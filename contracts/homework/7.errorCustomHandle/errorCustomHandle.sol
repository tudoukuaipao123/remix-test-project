// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/***
6.错误处理与自定义错误 作业
编写一个合约，使用 assert、require 和 revert 来处理输入参数和内部逻辑错误。
在合约中实现 try/catch 结构，捕获外部合约调用中的异常，并返回处理结果。
使用 Solidity 0.8.0 的自定义错误机制重构错误处理逻辑，减少 Gas 消耗。
***/
contract ErrorCustomHandle {
    
    error Unauthorized(address caller);

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function addCustom(uint a, uint b) public pure returns(uint c) {
        require(a > 0 && b > 0);
        c = a * b;
        assert(c >= a && c >= b);
        if (c == 0) {
            revert("error handle");
        }
    }

    function validUser() public {
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender);
        }
    }


}