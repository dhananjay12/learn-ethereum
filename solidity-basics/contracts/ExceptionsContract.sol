// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ExceptionsContract {

    // Public variable lastCaller, with a value of none
    string  public lastCaller = "none";

    // Function revertBehavior that takes in a name as an argument,
    //and sets the lastCaller variable to this argument received
    function  revertBehavior(string memory name) public returns (bool) {
        lastCaller = name;

        // Check if length of the string is zero
        // If the argument received has zero length, it throws an exception...
        // Once an exception is thrown, the variable lastCaller rolls back to its initial value
        if (bytes(name).length == 0) {
            revert("The length of the string is zero");
        }
        // This is the same thing...just using require to check the length of the input string.
        // The code will only be exceuted if the length is greater than 0
        // The above lines of code may be replaced with this
        require(bytes(name).length > 0, "The length of the string is zero");

        return true;
    }

}

// So, what is going on is that in the function revertBehavior
// lastCaller is being changed to the input argument
// and then an exception is thrown, and the lastCaller reverts back
// to its orginial value, thus nullifying the effect