// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract RemoveDup {
    //Task 7:

    //Define a function that removes duplicates from an array of non negative numbers and returns it as a result.
    //The order of the sequence has to stay the same.

    //[1,2,2,3,3,4,3,5]
    mapping(uint => bool) public seen; // Mapping to track seen numbers

    function removeDuplicates(
        uint[] memory input
    ) public returns (uint[] memory) {
        uint[] memory tempResult = new uint[](input.length); // Temporary array to store unique numbers
        uint count = 0; // Counter for unique numbers

        for (uint i = 0; i < input.length; i++) {
            if (!seen[input[i]]) {
                seen[input[i]] = true; // Mark the number as seen
                tempResult[count] = input[i]; // Add to the result array
                count++;
            }
        }
        // Loops through the temporary array (tempResult) to copy only the unique numbers into the final result array.
        // Create a new array with the correct size
        uint[] memory result = new uint[](count);
        for (uint j = 0; j < count; j++) {
            result[j] = tempResult[j];
        }

        return result;
    }
}
