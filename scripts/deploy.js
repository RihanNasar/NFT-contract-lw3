const hre = require("hardhat")


async function sleep(ms){
  return new Promise((resolve) => setTimeout(resolve,ms))
}
async function main() {
   const whitelistContract = await hre.ethers.deployContract("Whitelist",[10]);
   await whitelistContract.waitForDeployment();

   console.log("the address of the contract: ", whitelistContract.target);
   await sleep(30*1000);
   await hre.run("verify:verify",{
    address: whitelistContract.target,
    constructorArguments: [10],
   })

}
main()
    .then(() => process.exit(0))
    .catch((err) => {
        console.log("error is ", err);
        process.exit(1);
    })