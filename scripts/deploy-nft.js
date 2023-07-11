const hre = require("hardhat")

const contractAddress = "0xeb14Ccf4FcF09e14B247494C991BfeA80314113A";

async function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve,ms));
}

async function main() {
    const nftContract = hre.ethers.deployContract("CryptoDevs",[contractAddress]);
    await nftContract.waitForDeployment();

    console.log("address is ", nftContract.target)
    await sleep(30*1000);
    await hre.run("verify:verify",{
        address : nftContract.target,
        constructorArguments: [contractAddress]
    })

}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });