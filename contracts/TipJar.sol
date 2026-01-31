// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TipJar {
    address public owner;
    uint256 public totalTipped;

    event TipReceived(address indexed from, uint256 amount);
    event Withdraw(address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function tip() external payable {
        require(msg.value > 0, "No ETH sent");
        totalTipped += msg.value;
        emit TipReceived(msg.sender, msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        uint256 balance = address(this).balance;
        require(balance > 0, "Empty");

        payable(owner).transfer(balance);
        emit Withdraw(owner, balance);
    }

    receive() external payable {
        tip();
    }
}