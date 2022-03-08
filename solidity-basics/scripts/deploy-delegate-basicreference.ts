import "@nomiclabs/hardhat-ethers";
import { ethers } from "hardhat";

async function deploy(name, ...args) {
  const ContractFactory = await ethers.getContractFactory(name);
  const contract = await ContractFactory.deploy(...args);

  await contract.deployed();

  console.log(contract.address);

  return contract;
}

async function run() {
    //Fully qualified name so hardhat knows which to pick
  const a = await deploy("contracts/delegate/BasicReference.sol:A");
  const b = await deploy("contracts/delegate/BasicReference.sol:B", a.address);

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
}

run();
