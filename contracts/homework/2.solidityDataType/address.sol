// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// address类型作业

contract AddressWallet {
    mapping(address => uint256) public balances;
    mapping(address => bool) public whitelist;

    function addToWhitelist(address _address) public {
        whitelist[_address] = true;
    }

    function isWhitelisted(address _address) public returns(bool) {
        return whitelist[_address];
    }

    function removeFromWhitelist(address _address) public {
        whitelist[_address] = false;
    }


    // deposit 存款
    function deposit() public payable {
        balances[msg.sender] += msg.value; // 这里只是加数值操作，真正的付款操作是支付方操作的
    }

    // withdraw 提款
    function withdraw(uint256 amount) public {
        // 先检查付款额是否超出余额
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        balances[msg.sender] -= amount;
        address payable payAddress = payable(msg.sender);
        payAddress.transfer(amount);
    }

    // 检查账户余额
    function checkBalances() public view returns (uint256) {
        return balances[msg.sender];
    }

}