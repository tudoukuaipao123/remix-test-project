pragma solidity 0.8.20;
contract C {
    uint public data = 30;         // 公共状态变量
    uint internal iData = 10;      // 内部状态变量
    function x() public returns (uint) {
        data = 3;                  // 内部访问公共变量
        return data;
    }
}

contract Caller {
    C c = new C();
    function f() public view returns (uint) {
        return c.data();          // 外部访问公共变量
    }
}

contract D is C {
    uint storedData;
    function y() public returns (uint) {
        iData = 3;               // 派生合约内部访问内部变量
        return iData;
    }
    function getResult() public view returns(uint) {
        uint a = 1;               // 局部变量
        uint b = 2;
        uint result = a + b;
        return storedData;        // 访问状态变量
    }
}
