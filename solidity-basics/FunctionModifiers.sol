// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Property {

    uint public price;
    address public owner;

    constructor () {
        price = 0;
        owner = msg.sender;
    }

    // Standard way of testing specific conditions before executing in more than one function.
    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }

    function changeOwner (address _owner) public onlyOwner {
        owner = _owner;
    }

    function withdraw (uint _price) public onlyOwner {
        price = _price;
    }
}