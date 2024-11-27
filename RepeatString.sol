// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract RepeatString {
    //Task 6:

    //Write a function that accepts an integer n and a string s as parameters,
    // and returns a string of s repeated exactly n times.

    function repeat(
        string memory s,
        uint n
    ) public pure returns (string[] memory) {
        string[] memory s1 = new string[](n);
        for (uint i = 0; i < n; i++) {
            s1[i] = s;
        }
        return s1;
    }
}
