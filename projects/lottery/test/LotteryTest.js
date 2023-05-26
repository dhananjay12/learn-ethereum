const Lottery = artifacts.require("Lottery");
const Web3 = require('web3');
const {expectRevert} = require('@openzeppelin/test-helpers');

contract("lottery", accounts =>{
 
    var owner = accounts[0]
    let lottery;
    
    // helpers
    async function assertContractBalance(expectedBalance) {
        const actualBalance = await lottery.getBalance.call();
        assert.equal(actualBalance, expectedBalance);
    }

    async function assertPlayerCount(expectedPlayerCount) {
        const actualPlayerCount = await lottery.getNumberOfPlayers.call();
        assert.equal(actualPlayerCount, expectedPlayerCount);
    }

    beforeEach(async () => { 
        lottery = await Lottery.new()
    })

    describe('Default state of the contract at creation', () => { 
        it('has contract balance of 0', async () => { 
            await assertContractBalance(0);
        })

        it('and number of players are 0', async () => { 
            await assertPlayerCount(0);
        })
        it('and manager is account[0]', async () => { 
            const manager = await lottery.manager.call();
            assert.equal(manager, accounts[0]);
        })
    })

    describe('Entering lottery', () => { 
        it('account[1] enters the lottery', async () => { 
            await lottery.sendTransaction({from:accounts[1],value: Web3.utils.toWei('.1', 'ether')})
            await assertPlayerCount(1);
            await assertContractBalance(Web3.utils.toWei('.1', 'ether'));
        })
        it('account[1] enters the lottery with less ether', async () => { 
            await expectRevert(
                lottery.sendTransaction({from:accounts[1],value: Web3.utils.toWei('.09', 'ether')}), 
                "Invalid entry fee provided. It must be .1 eth",
            );
        })
        it('account[1] enters the lottery with more ether', async () => { 
            await expectRevert(
                lottery.sendTransaction({from:accounts[1],value: Web3.utils.toWei('.2', 'ether')}), 
                "Invalid entry fee provided. It must be .1 eth",
            );
        })
        it('account[1], account[2], account[3] enters the lottery', async () => { 
            await lottery.sendTransaction({from:accounts[1],value: Web3.utils.toWei('.1', 'ether')})
            await lottery.sendTransaction({from:accounts[2],value: Web3.utils.toWei('.1', 'ether')})
            await lottery.sendTransaction({from:accounts[3],value: Web3.utils.toWei('.1', 'ether')})
            await assertPlayerCount(3);
            await assertContractBalance(Web3.utils.toWei('.3', 'ether'));
        })
        it('account[1], account[2] (enters 2 times), account[3] enters the lottery', async () => { 
            await lottery.sendTransaction({from:accounts[1],value: Web3.utils.toWei('.1', 'ether')})
            await lottery.sendTransaction({from:accounts[2],value: Web3.utils.toWei('.1', 'ether')})
            await lottery.sendTransaction({from:accounts[2],value: Web3.utils.toWei('.1', 'ether')})
            await lottery.sendTransaction({from:accounts[3],value: Web3.utils.toWei('.1', 'ether')})
            await assertPlayerCount(4);
            await assertContractBalance(Web3.utils.toWei('.4', 'ether'));
        })
    })

    describe('Picking Winner', () => { 
        it('No other account can call pickWinner other than accounts[0]', async () => { 
            await expectRevert(
                lottery.pickWinner({from:accounts[1]}), 
                "Only owner can call pickWinner",
            );
            await expectRevert(
                lottery.pickWinner({from:accounts[2]}), 
                "Only owner can call pickWinner",
            );
        })
        it('Minimum 3 people must be in lottery to proceed', async () => { 
            await expectRevert(
                lottery.pickWinner({from:accounts[0]}), 
                "Minimum 3 people must be in lottery to proceed",
            );
        })
        it('Picking winner', async () => { 
            await lottery.sendTransaction({from:accounts[1],value: Web3.utils.toWei('.1', 'ether')})
            await lottery.sendTransaction({from:accounts[2],value: Web3.utils.toWei('.1', 'ether')})
            await lottery.sendTransaction({from:accounts[2],value: Web3.utils.toWei('.1', 'ether')})
            await lottery.sendTransaction({from:accounts[3],value: Web3.utils.toWei('.1', 'ether')})
            await assertPlayerCount(4);
            await lottery.pickWinner()
            await assertContractBalance(0);
            await assertPlayerCount(0);
        })
    })

});