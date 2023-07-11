// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.18;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "./Whitelist.sol";

 contract CryptoDevs is ERC721Enumerable, Ownable {  
        uint256 constant public _price = 0.01 ether;
        uint256 constant public maxTokens = 20;
        Whitelist whitelist;
        uint256 public reservedTokens;
        uint256 public claimedReservedTokens = 0;

        constructor(address whitelistContract) ERC721("Crypto Devs","CD") {
            whitelist = Whitelist(whitelistContract);
            reservedTokens = whitelist.maxWhiteListAddresses();
        }

        function mint() public payable {
            require(totalSupply() + reservedTokens - claimedReservedTokens < maxTokens,"EXCEEDED MAX SUPPLY");

            if(whitelist.whitelistaddresses(msg.sender) && msg.value < _price) {
                require(balanceOf(msg.sender) ==0 ,"already minted");
                claimedReservedTokens +=1;
            }else {
                require(msg.value > _price, "not enough ether");
            }
            uint256  tokenId = totalSupply();
            _safeMint(msg.sender, tokenId);

        }
         function withdraw() public onlyOwner  {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) =  _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

}