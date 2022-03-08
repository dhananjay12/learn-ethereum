// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AwesomeContract{
    address public owner;
    constructor (address eoa){
        owner = eoa;
    }
}

contract AwesomeContractCreator {
    address public creatorOwner;
    AwesomeContract[] public deployedContracts;

    constructor(){
        creatorOwner = msg.sender;
    }

    function deployedAwesomeContract() public{
        AwesomeContract contract_address = new AwesomeContract(msg.sender);
        deployedContracts.push(contract_address);
    }
}