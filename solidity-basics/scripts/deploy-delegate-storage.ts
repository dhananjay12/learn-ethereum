import "@nomiclabs/hardhat-ethers";
import { ethers } from "hardhat";

async function deploy(name, ...args) {
  const ContractFactory = await ethers.getContractFactory(name);
  const contract = await ContractFactory.deploy(...args);

  await contract.deployed();

  console.log(contract.address);

  return contract;
}

async function printStorage(contract, name, count) {
  for (let i = 0; i < count; ++i) {
    console.log(
      name,
      i,
      await ethers.provider.getStorageAt(contract.address, i)
    );
  }
}

async function run() {
    //Fully qualified name so hardhat knows which to pick
  const a = await deploy("contracts/delegate/storage/DelegateCall.sol:A");
  const b = await deploy("contracts/delegate/storage/DelegateCall.sol:B", a.address);

  //////////////////////////////////////////////////////////////

  console.log("A", await a.getA());
  console.log("B", await b.getB());
  console.log("----------------");

  await a.setA(42);
  console.log("A", await a.getA());
  console.log("B", await b.getB());
  console.log("----------------");

  await b.setB(60);
  console.log("A", await a.getA());
  console.log("B", await b.getB());
  console.log("----------------");

  await printStorage(b, "B", 3);
  await b.setB(45);
  console.log("---------------");
  await printStorage(b, "B", 3);
}

run();
