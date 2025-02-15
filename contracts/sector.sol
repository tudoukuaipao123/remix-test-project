// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionSelectorExample {
    // 函数 计算输入值的平方
    function square(uint x) public pure returns (uint z) {
        return x*x;
    }

    // 函数 计算乘以2 这里返回的是真的数字
    function double(uint x) public pure returns (uint z) {
        return x*2;
    }

    // 这里返回bytes4字节的是selector截取的4个字节代号
    function getSelectorSquare(uint x) public pure returns (bytes4) {
        return this.square.selector;
    }

    // 这里返回bytes4字节的是selector截取的4个字节代号
    function getSelectorDouble(uint x) public pure returns (bytes4) {
        return bytes4(keccak256("double(uint256)"));
    }

    function execute(bytes4 selector, uint x) external returns (uint z) {
        // 这里的data是指二进制字节数据
        (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(selector, x));
        require(success, "Call failed");
        // 这里是把二进制字节数据进行解码成制定格式
        z = abi.decode(data,(uint));
    }
}