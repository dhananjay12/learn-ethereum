//SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    
    // declaring the state variables
    address payable[] public players; //dynamic array of type address payable
    address public manager; 
    
    
    // declaring the constructor
    constructor(){
        // initializing the owner to the address that deploys the contract
        manager = msg.sender; 
    }
    
    // declaring the receive() function that is necessary to receive ETH
    receive () payable external{
        // each player sends exactly 0.1 ETH. Without any specific suffic default is wei. Use a covnerter to check
        require(msg.value == 0.1 ether, "Invalid entry fee provided. It must be .1 eth");
        // appending the player to the players array
        players.push(payable(msg.sender));
    }
    
    // returning the contract's balance in wei
    function getBalance() public view returns(uint){
        // only the manager is allowed to call it
        require(msg.sender == manager);
        return address(this).balance;
    }

    // returns number of players
    function getNumberOfPlayers() public view returns(uint count) {
        return players.length;
    }
    
    // helper function that returns a big random integer
    function random() internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }
    
    
    // selecting the winner
    function pickWinner() public{
        // only the manager can pick a winner if there are at least 3 players in the lottery
        require(msg.sender == manager, "Only owner can call pickWinner");
        require (players.length >= 3, "Minimum 3 people must be in lottery to proceed");
        
        uint r = random();
        address payable winner;
        
        // computing a random index of the array
        uint index = r % players.length;
    
        winner = players[index]; // this is the winner
        
        // transferring the entire contract's balance to the winner
        winner.transfer(getBalance());
        
        // resetting the lottery for the next round
        players = new address payable[](0);
    }

}
