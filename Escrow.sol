// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public buyer;
    address public seller;
    address public escrowAgent;
    uint256 public amount;
    bool public buyerConfirmed;
    bool public sellerConfirmed;

    constructor(address _seller) {
        escrowAgent = msg.sender; // Contract deployer as escrow agent
        buyer = msg.sender; // Initially, the contract deployer is the buyer
        seller = _seller;
    }

    // Buyer deposits funds to start escrow
    function deposit() external payable {
        require(msg.sender == buyer, "Only the buyer can deposit");
        require(msg.value > 0, "Deposit must be greater than zero");
        amount = msg.value;
    }

    // Buyer confirms receipt of goods/services
    function confirmReceipt() external {
        require(msg.sender == buyer, "Only the buyer can confirm");
        buyerConfirmed = true;
    }

    // Seller confirms delivery of goods/services
    function confirmDelivery() external {
        require(msg.sender == seller, "Only the seller can confirm");
        sellerConfirmed = true;
    }

    // Release funds to seller if both confirm
    function releaseFunds() external {
        require(
            msg.sender == escrowAgent,
            "Only escrow agent can release funds"
        );
        require(buyerConfirmed && sellerConfirmed, "Both parties must confirm");
        payable(seller).transfer(amount);
    }

    // Refund funds to buyer if conditions are not met
    function refund() external {
        require(msg.sender == escrowAgent, "Only escrow agent can refund");
        require(!buyerConfirmed || !sellerConfirmed, "No reason for refund");
        payable(buyer).transfer(amount);
    }
}
