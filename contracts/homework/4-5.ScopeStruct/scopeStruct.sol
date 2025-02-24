// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/**
1.4-1.5变量的作用域和控制结构 作业
编写一个包含公共、内部和私有状态变量的合约，测试其在合约内部、外部以及派生合约中的访问权限。
实现一个函数，使用for循环计算1到n的所有奇数和，并使用try/catch结构处理外部合约调用中的异常。
**/

contract ExternalContract {
    function someFunction(uint a) public returns(bool result) {
        uint b = a * a;
        result = b > 100;
    }
}

contract ScopeStruct {
    uint256 public outData;
    uint128 private privateData;

    function loopFunc(uint a) public returns(uint sum) {
        sum = 0;
        for (uint x = 0; x <= a; x++) {
            if (x%2 == 1) {
                sum += x;
            }
        }
    }

    function countNum(uint b, address externalContractAddress) public  returns (bool result){
        try ExternalContract(externalContractAddress).someFunction(20) returns (bool result) {
           result = true; 
        } catch {
            result = false;
        }
    }


}