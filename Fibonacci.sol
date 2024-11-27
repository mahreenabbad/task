// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract Fibonacci {
    //Task 5:

    //Print Fibonacci series in solidity and understand its logic.

    function fib(uint n) public pure returns (uint[] memory) {
        uint[] memory result = new uint[](n);
        if (n > 0) {
            result[0] = 0;
        }
        if (n > 1) {
            result[1] = 1;
        }

        for (uint i = 2; i < n; i++) {
            result[i] = result[i - 1] + result[i - 2];
        }

        return result;
    }
}
