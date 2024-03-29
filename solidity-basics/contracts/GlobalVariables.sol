// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract GlobalVariables {
    string public lastCaller = "not-set";

    address public owner;
    uint256 public sentValue;

    constructor() {
        // msg.sender is the address that interacts with the contract (deploys it in this case)
        owner = msg.sender;
    }

    // Demonstrates the use of the ether subdenominations
    function etherUnitsTest() public pure returns (bool) {
        // True
        bool value = (1 ether == 1000000000 gwei);
        return value;
    }

    // Demonstrates the use of the time units
    function timeUnits() public view returns (uint256) {
        uint256 timeNow = block.timestamp; //storing current time using now
        //returns block time in seconds since 1970
        if (timeNow == 1000 days) {
            // converting 1000 literal to days, using the suffix days
            return timeNow;
        }

        return 0;
    }

    // Demonstrates the use of block object
    function getBlockInformation()
        public
        view
        returns (
            uint256 number,
            bytes32 hash,
            address coinbase,
            uint256 difficulty
        )
    {
        number = block.number; // Previous block
        hash = blockhash(number - 1); // -1 because excluding current...same as block.blockhash()
        // Current block
        coinbase = block.coinbase;
        difficulty = block.difficulty;
    }

    // Demonstrates the use of the msg object
    function getMsgInformation()
        public
        view
        returns (
            bytes memory data,
            bytes4 sig,
            address sender
        )
    {
        data = msg.data;
        sig = msg.sig;
        sender = msg.sender;
    }

    function changeOwner() public {
        // msg.sender is the address that interacts with the contract (calls the function in this case)
        owner = msg.sender;
    }

    function sendEther() public payable {
        // must be payable to receive ETH with the transaction
        // msg.value is the value of wei sent in this transaction (when calling the function)
        sentValue = msg.value;
    }

    // returning the balance of the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
