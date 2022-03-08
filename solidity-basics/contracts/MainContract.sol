// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//Used in InheritenceContract
contract MainContract {

    uint internal value;

    constructor (uint amount) {
        value = amount;
    }

    function deposit (uint amount) public {
        value += amount;
    }

    function withdraw (uint amount) public {
        value -= amount;
    }
}