// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// array 类型作业
contract StringBytesExample {

    // 字符串数组
    string[] public stringArray;

    // 字节数组数组
    bytes[] public bytesArray;

    // 接收字符串并将其添加到字符串数组中
    function addString(string calldata newString) external {
        stringArray.push(newString);
    }

    // 接收字节数组并将其添加到字节数组数组中
    function addBytes(bytes calldata newBytes) external {
        bytesArray.push(newBytes);
    }

    // 获取指定索引处的字符串
    function getString(uint index) external view returns (string memory) {
        require(index < stringArray.length, "Index out of bounds");
        return stringArray[index];
    }

    // 获取指定索引处的字节数组
    function getBytes(uint index) external view returns (bytes memory) {
        require(index < bytesArray.length, "Index out of bounds");
        return bytesArray[index];
    }

    // 返回字符串的长度
    function getStringLength(string calldata str) external pure returns (uint) {
        return bytes(str).length;
    }

    // 连接两个字符串
    function concatenateStrings(string calldata str1, string calldata str2) external pure returns (string memory) {
        return string(abi.encodePacked(str1, str2));
    }

    // 将字节数组转换为字符串
    function bytesToString(bytes calldata data) external pure returns (string memory) {
        return string(data);
    }

    // 将字符串转换为字节数组
    function stringToBytes(string calldata str) external pure returns (bytes memory) {
        return bytes(str);
    }

    // 从字节数组获取指定位置的字节
    function getByteAt(bytes calldata data, uint index) external pure returns (bytes1) {
        require(index < data.length, "Index out of bounds");
        return data[index];
    }

    // 字符串数组的合并
    function concatenateStringArray() external view returns (string memory) {
        string memory result = "";
        for (uint i = 0; i < stringArray.length; i++) {
            result = string(abi.encodePacked(result, stringArray[i]));
        }
        return result;
    }

    // 获取字节数组的总长度
    function getTotalBytesLength() external view returns (uint totalLength) {
        totalLength = 0;
        for (uint i = 0; i < bytesArray.length; i++) {
            totalLength += bytesArray[i].length;
        }
    }
}
