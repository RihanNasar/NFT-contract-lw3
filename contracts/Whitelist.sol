// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Whitelist {
    uint8 public maxWhiteListAddresses;

    mapping (address => bool) public whitelistaddresses;
    uint8 public noOfWhiteListAddresses;

    constructor (uint8 _maxWhiteListAddresses)  {
        maxWhiteListAddresses = _maxWhiteListAddresses ;
    }

    function addAddressToWhiteList() public  {
        require(!whitelistaddresses[msg.sender],"already whitelisted");
        require(noOfWhiteListAddresses < maxWhiteListAddresses,"can not add anymore limit reached");
        whitelistaddresses[msg.sender] = true;
        noOfWhiteListAddresses += 1;
    }
}   