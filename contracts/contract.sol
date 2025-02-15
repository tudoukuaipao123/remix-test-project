// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Hello {
    function sayHi() public {
        // 合约中的成员函数
    }

    // 课支付回退函数  
    // external访问权限 用于指定函数是外部函数，意味着它只能被外部合约或者外部账户调用,不能被内部调用, external 函数用于优化 Gas 使用
    // payable 是否接受以太币, 如果没有payable 那么它不能接收以太币
    receive() external payable {
        // 接收以太币的代码放这里
    }

    function getAddress() public view returns (address) {
        return address(this); // 返回当前合约地址
    }

    function destoryContract(address payable recipient) public {
        selfdestruct(recipient);
    }

    // function getContractInfo() public pure returns (string memory, bytes memory, bytes memory) {
    //     return (type(Hello).name, type(Hello).creationCode, type(Hello).runtimeCode);
    // }

    function isContract(address addr) public view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }
    


}
