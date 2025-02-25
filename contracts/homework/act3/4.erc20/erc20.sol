// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/**
ERC20 作业
实现一个自定义的 ERC20 代币，使用 SafeMath 保障安全
编写一个代币授权与转账的智能合约，模拟工资发放
使用 Remix 部署代币并测试其基本功能
***/

import "@openzeppelin/contracts/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyToken is ERC20 {
    using SafeMath for uint256;

    constructor(uint256 initAmount) ERC20("MyToken", "MTK"){
        _mint(msg.sender, initAmount); // 初始化代币数量
    }

    function transfer(address _address, uint256 amount) payable external returns(bool) {
        require(amount > 0);
        require(balancesOf(msg.sender) > amount);
        _transfer(msg.sender, _address, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(sender) >= amount, "Insufficient balance");
        require(allowance(sender, msg.sender) >= amount, "Allowance exceeded");

        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, allowance(sender, msg.sender).sub(amount));
        return true;
    }

}

contract Payroll {
    IERC20 public token;
    address public employer;

    event SalaryPaid(address indexed employee, uint256 amount);

    constructor(address tokenAddress) {
        token = IERC20(tokenAddress);
        employer = msg.sender;
    }

    function approveEmployer(uint256 amount) external {
        require(token.approve(employer, amount), "Approval failed");
    }

    function paySalary(address employee, uint256 amount) external {
        require(msg.sender == employer, "Only employer can pay salary");

        uint256 allowance = token.allowance(employee, address(this));
        require(allowance >= amount, "Insufficient allowance");

        bool success = token.transferFrom(employee, employer, amount);
        require(success, "Transfer failed");

        success = token.transfer(employee, amount);
        require(success, "Salary payment failed");

        emit SalaryPaid(employee, amount);
    }
}