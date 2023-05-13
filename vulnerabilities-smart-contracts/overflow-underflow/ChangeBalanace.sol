// SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract ChangeBalance {
    uint8 public balance;

    function decreaseBalance() public {
        balance--;
    }

    function increaseBalance() public {
        balance++;
    }
    
}