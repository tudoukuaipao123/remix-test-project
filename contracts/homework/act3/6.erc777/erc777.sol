// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC777/IERC777Recipient.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC777/IERC777.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/introspection/IERC1820Registry.sol";

contract Merit is IERC777Recipient {
    IERC1820Registry private _erc1820 = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
    bytes32 constant private TOKENS_RECIPIENT_INTERFACE_HASH = 0xb281fc8c12954d22544db45de3159a39272895b169a852b314f9cc762e44c53b;

    event TokensReceived(address operator, address from, address to, uint256 amount, bytes userData, bytes operatorData);

    constructor() {
        _erc1820.setInterfaceImplementer(address(this), TOKENS_RECIPIENT_INTERFACE_HASH, address(this));
    }

    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external override {
        emit TokensReceived(operator, from, to, amount, userData, operatorData);
    }

}


contract Operator {
    ERC777 private _token;

    constructor(ERC777 token) {
        _token = token;
    }

    function operatorSend(
        address sender,
        address recipient,
        uint256 amount,
        bytes memory data,
        bytes memory operatorData
    ) public {
        require(_token.isOperator(msg.sender, sender));
        _token.operatorSend(sender, recipient, amount, data, operatorData);
    }

}