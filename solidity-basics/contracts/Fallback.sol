// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

interface IFallback{
       function count() external;
}

contract Fallback {
    
    function foo() internal view {
        console.log("Hello World");
    }

    fallback() external payable {
        foo();
        console.log("fallback");

        revert("You shouldn't be here");
    }
}