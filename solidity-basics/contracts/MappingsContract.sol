// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MappingsContract {
    // Creates in Storage
    mapping(string => string) relations;

    // Add a relation
    function addRelation(string memory name, string memory relation) public {
        // Store the relation
        relations[name] = relation;
    }

    // Returns a Relation
    function getRelation(string memory name) public view returns (string memory){
        return relations[name];
    }

    // Remove the key value pair from the mapping
    function removeRelation(string memory name) public {
        delete(relations[name]);
    }
}