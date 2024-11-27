// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

contract BodyMass {
    // Task 4:

    // Write function bmi that calculates body mass index (bmi = weight / height2).

    // if bmi <= 18.5 return "Underweight"
    // if bmi <= 25.0 return "Normal"
    // if bmi <= 30.0 return "Overweight"
    // if bmi > 30 return "Obese

    //  uint public bmiValue ;
    function bmi(uint weight, uint height) public pure returns (string memory) {
        //  uint256 DECIMALS = 1e18;
        // Calculate BMI = weight / (height * height)
        // height is expected to be in meters and weight in kilograms.
        // uint scaleWeight= weight * DECIMALS;
        uint heightSquared = height * height; // Height in cm squared
        // uint scaleHeight = heightSquared * DECIMALS;
        // uint bmiValue = scaleWeight / heightSquared;
        uint bmiValue = weight / heightSquared;
        // Scale BMI down to human-readable value by dividing by 1e4 (to account for height in cm)
        //  bmiValue = bmiValue * 10000 / DECIMALS;
        // Check the BMI range and return the appropriate result
        if (bmiValue <= 18) {
            return "Underweight"; // BMI <= 18.5
        } else if (bmiValue <= 25) {
            return "Normal"; // BMI <= 25.0
        } else if (bmiValue <= 30) {
            return "Overweight"; // BMI <= 30.0
        } else {
            return "Obese"; // BMI > 30
        }
    }
}
