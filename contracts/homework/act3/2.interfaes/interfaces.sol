// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/*
2.2接口（Interfaces）
1.接口的基本实现：
编写一个接口 IVault，定义存款和取款的函数，然后编写一个合约 Bank 实现该接口，管理用户的存款和取款。
2.合约间通信：
编写一个代币合约 MyToken，然后编写一个奖励合约 Reward，通过 MyToken 合约给用户发放代币奖励。
3.使用标准接口：
实现一个符合 ERC20 标准的代币合约，并通过 ERC20 接口与钱包合约进行交互。

**/

interface IVault {
    function deposit() payable  external;
    function withdraw(uint256 amount) external;
}

contract Bank is IVault {
    mapping(address => uint256) private balances;

    function deposit() payable external override  {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external override  {
        require(amount>0);
        require(balances[msg.sender]>0);
        balances[msg.sender] -= amount;
        (bool success,) = msg.sender.call{value: amount}("");
        require(success);
    }
}