// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MathLib2 {
    // 外部函数，执行乘法运算
    function multiply(uint256 a, uint256 b) external pure returns (uint256) {
        return a * b;
    }
}