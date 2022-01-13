// SPDX-License-Identifier: GPL-3.0
// OpenZeppelin Contracts v4.4.1 (token/ERC20/ERC20.sol)

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
//or
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol"; 

pragma solidity >=0.7.0 <0.9.0;

contract SampleToken is ERC20 {

    constructor() ERC20("Scaffold ETH Token", "SET") {
        // Mint 1000 tokens to msg.sender
        // Similar to how
        // 1 dollar = 100 cents
        // 1 token = 1 * (10 ** decimals)
        //1000 tokens with 18 decimals
        _mint(msg.sender, 1000 * 10 ** 18);
    }
}