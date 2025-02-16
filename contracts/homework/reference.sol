// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ReferenceType {
    uint[] public data; // 存储在storage中的动态数组

    function updateData(uint[] memory newData) public {
        data = newData;
    }

    function getData() public returns(uint[] memory) {
        return data; // 返回storage中的数据作为memory中的数组
    }

    function modifyStorageData(uint index, uint value) public {
        require(index < data.length, "Index out of bounds");
        data[index] = value; // 修改storage 开销较大
    }
    
    function modifyMemoryData(uint[] memory memoryData, uint index, uint value) public returns(uint[] memory) {
        require(index < memoryData.length, "Index out of bounds");
        if (memoryData.length > 0) {
            memoryData[index] = value;
        }
        return memoryData;
    }

}