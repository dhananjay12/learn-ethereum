// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hero {
    enum Class {
        Mage,
        Healer,
        Barbarian
    }
    
    mapping(address => uint256[]) addressToHeroes;

    function getHeroes() public view returns (uint256[] memory) {
        return addressToHeroes[msg.sender];
    }

    function createHero(Class class) public payable {
        require(msg.value >= 0.05 ether, "Please send more money :)");

        uint256[] memory stats = new uint256[](5);

        stats[0] = 2;
        stats[1] = 7;
        stats[2] = 12;
        stats[3] = 17;
        stats[4] = 22;

        uint256 len = 5;
        uint256 hero = uint256(class); // enum

        do {
            uint256 pos = generateRandom() % len;
            uint256 value = (generateRandom() % (13 + len)) + 1;

            hero |= value << stats[pos]; // doing OR operation - put staff in (AND contains smth?) / << multiply by 2 (shift bits)

            len--;

            stats[pos] = stats[len];
        } while (len > 0);

        addressToHeroes[msg.sender].push(hero);
    }

    function generateRandom() public view virtual returns (uint256) {
        return
            uint256(
                keccak256(abi.encodePacked(block.difficulty, block.timestamp))
            );
    } // no use in prod :)

    function getStrength(uint32 hero) public pure returns (uint32) {
        return uint32((hero >> 2) & 0x1F); /* first two bits are class information */
    }

    function getHealth(uint32 hero) public pure returns (uint32) {
        return uint32((hero >> 7) & 0x1F);
    }

    function getDexterity(uint32 hero) public pure returns (uint32) {
        return uint32((hero >> 12) & 0x1F);
    }

    function getIntellect(uint32 hero) public pure returns (uint32) {
        return uint32((hero >> 17) & 0x1F);
    }

    function getMagic(uint32 hero) public pure returns (uint32) {
        return uint32((hero >> 22) & 0x1F);
    }
}

////////////////////////////////////////////////////////////////

// Design
// We want to be able to generate random Hereos.
// The user gets to put in their class of hereo on generation
// classes: Mage, Healer, Barbarian
// Class will not influence stats created, therefore getting an epic hero will be hard.
// I want to be paid... 0.05 eth per hero!
// I should be able to get my heroes I have generated.
// Heroes should be stored on the chain.
// stats are strength, health, intellect, magic, dexterity
// stats are randomly generated
// A scale of 1 - 18
// The stats are randomly picked and their amplitude is randomly determined according to the following:
// Stat 1 can max at 18
// Stat 2 can max at 17
// Stat 3 can max at 16
// ...
// You could imagine these being an NFT
// They are non divisable
    
