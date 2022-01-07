// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Message {
    string myMessage;

//https://docs.soliditylang.org/en/latest/types.html#reference-types so you have to put memory, calldata or storage  after String
    function setMessage(string memory x) public {
        myMessage = x;
    }

    function getMessage() public view returns (string memory) {
        return myMessage;
    }
}