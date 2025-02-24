// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/**
1.3 solidity函数调用
作业
编写一个合约，定义不同可见性和状态可变性的函数，并进行测试。
实现一个函数，接受两个参数并返回它们的和与积。
创建一个 payable 函数，允许用户向合约发送以太币，并记录发送金额。
**/

contract FunctionCall {
    uint256 private data;
    uint256 public  count;
    uint256 internal interCount;

    function countAll(uint n, uint m) public pure returns(uint sum, uint product) {
        sum = n + m;
        product = n * m;
    }

    function doPay( address _address) public payable {
        require(msg.value >= 0, "value should not be 0");
        address payable sendAddress = payable(_address);
        count += msg.value;
        sendAddress.transfer(msg.value);
    }

}