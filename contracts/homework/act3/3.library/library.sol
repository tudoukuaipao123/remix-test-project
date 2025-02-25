// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "./MathLab.sol";
/**

1.编写一个库 MathLib，实现加法、减法和乘法函数，并在合约中使用该库。
2.修改 MathLib 的乘法函数为外部函数，然后编写一个合约 CalcTest 使用链接库，并通过库地址调用乘法函数。
3.编写一个库，提供对数组的扩展功能（如 contains 函数检查数组是否包含某个元素），并在合约中使用 using for 语法扩展数组类型。
**/

library  MathLib {
    function add(uint a, uint b) public pure returns (uint sum) {
        sum = a + b;
    }

    function subtract(uint a, uint b) public pure returns (uint result) {
        result = a - b;
    }
}

contract LibraryTest {
    function add(uint a, uint b) public  pure returns (uint c) {
        c = MathLib.add(a,  b);
    }
}


contract LibraryTest2 {
    MathLib2 public mathlab;

    constructor(address _address) {
        mathlab = MathLib2(_address);
    }


    function add(uint a, uint b) public pure returns(uint c) {
        c = mathlab.add(a, b);
    }
}