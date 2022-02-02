// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Gotchas{
    string[] public cities = ['Amsterdam', 'Berlin'];
    function f_memory() public {
        string[] memory s1 = cities;
        //string s2; // error , data location must be specified
        s1[0] = 'Delhi'; // no effect on cities
    }

    function f_storage() public {
        string[] storage s1 = cities;
        s1[0] = 'Delhi'; // This will change cities too
    }
}