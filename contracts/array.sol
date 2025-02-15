// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// 静态数组 - 长度固定

// 动态数组 - 长度根据需要调整

contract ArrayOperations {
    uint[] public dynamicArray;
    function addElement(uint _element) public {
        dynamicArray.push(_element);  // 向数组添加元素
    }
    function removeLastElement() public {
        dynamicArray.pop();  // 删除数组最后一个元素
    }
    function getLength() public view returns (uint) {
        return dynamicArray.length;  // 获取数组长度
    }
}