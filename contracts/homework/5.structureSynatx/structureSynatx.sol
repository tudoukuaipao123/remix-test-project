// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/**
编写一个合约，定义不同的可见性修饰符并测试其访问权限。
实现一个事件触发的功能，外部应用可以通过 Web3.js 监听事件。
编写一个带有 receive 和 fallback 函数的合约，测试其接收以太币和处理错误调用的行为。
**/
contract StructureSynatx {
    event Received(address sender, uint amount);
    event ErrorHandled(address sender, uint256 value, bytes data, string message);

    // 1. 定义不同可见性修饰符的变量和函数
    uint256 public publicVar = 1; // 公共变量
    uint256 private privateVar = 2; // 私有变量
    uint256 internal internalVar = 3; // 内部变量

    // 公共函数
    function publicFunc() public pure returns (string memory) {
        return "Public function called";
    }

    // 私有函数
    function privateFunc() private pure returns (string memory) {
        return "Private function called";
    }

    // 内部函数
    function internalFunc() internal pure returns (string memory) {
        return "Internal function called";
    }

    // 外部函数
    function externalFunc() external pure returns (string memory) {
        return "External function called";
    }

    function receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function fallback() external payable {
        if (msg.data.length > 0) {
            emit ErrorHandled(
                msg.sender,
                msg.value,
                msg.data,
                "Invalid function call or data provided"
            );
            // 可以选择回滚交易
            revert("Invalid function call or data provided");
        } else {
            emit ErrorHandled(
                msg.sender,
                msg.value,
                msg.data,
                "Fallback called with no data"
            );
        }
    }

}