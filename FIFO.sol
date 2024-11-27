// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract FIFO {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "u r not owner");
        _;
    }

    struct Queue {
        address user;
        uint amount;
    }
    Queue[] queue;

    function push() external payable {
        require(msg.value > 0.1 ether, "insufficent amount");
        require(msg.sender != address(0), "invalid address calling");
        queue.push(Queue(msg.sender, msg.value));
    }

    function pop() external onlyOwner {
        require(queue.length > 0, "length should b greater than zero");

        Queue memory firstEle = queue[0];

        payable(firstEle.user).transfer(firstEle.amount);
        // Remove the item from the front of the queue
        // loop shifts each item to the left by one position to remove the first item
        //shifting the items in the queue
        for (uint i = 0; i < queue.length - 1; i++) {
            queue[i] = queue[i + 1];
        }
        queue.pop(); // Pop the last element
    }

    function size() public view returns (uint) {
        return queue.length;
    }

    function get(uint256 _index) external view returns (address, uint) {
        require(_index < queue.length, "invalid index");
        Queue memory item = queue[_index];
        return (item.user, item.amount);
    }
}
