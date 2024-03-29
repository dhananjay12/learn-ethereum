// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EventsContract {
    // Represents the time when the bidding will end
    uint biddingEnds = block.timestamp + 5 days;

    struct HighBidder {
        address bidder;
        string bidderName;
        uint bid;
    }

    // Variable of type HighBidder
    HighBidder public highBidder;

    // Events emitted by contract
    // Whenever a high bid is received
    event NewHighBid(address indexed who, string name, uint howmuch);

    // High bid preceded by this event
    event BidFailed(address indexed who, string name, uint howmuch);

    // Ensures that bid can be received i.e, auction not ended
    modifier timed {
        if(block.timestamp < biddingEnds){
            _;
        } else {
            /**throw an exception */
            revert("Throw an exception");
        }
    }

    constructor() {
        // Starts the bidding at 1 ether
        highBidder.bid = 1 ether;
    }

    
    // Payable since ether should be coming along
    // Timed, we need to end this bidding in 5 days
    function bid(string memory bidderName) public payable timed {
        if(msg.value > highBidder.bid) {
            highBidder.bidder = msg.sender;
            highBidder.bidderName = bidderName;
            highBidder.bid = msg.value;
            // Received a high bid - emit event
            emit NewHighBid(msg.sender, bidderName, msg.value);
        } else {
            // Received bid less than high bid emit event
            emit BidFailed(msg.sender, bidderName, msg.value);
            // throwing exception would return the ethers
            revert("Throw an exception");
        }
    }
}