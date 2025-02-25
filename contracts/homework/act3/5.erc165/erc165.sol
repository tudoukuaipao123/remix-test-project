// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/**
实现一个支持 ERC165 的合约，注册多个接口，并编写测试用例来验证 supportsInterface 函数的正确性。
编写一个合约，它通过调用 supportsInterface 动态判断与其交互的合约是否实现了特定的标准
***/

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract MyContract is ERC165 {
    // ERC721 接口 ID
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    // ERC1155 接口 ID
    bytes4 private constant _INTERFACE_ID_ERC1155 = 0xd9b67a26;

    constructor() {
        // 注册支持的接口
        _registerInterface(_INTERFACE_ID_ERC721);
        _registerInterface(_INTERFACE_ID_ERC1155);
    }

    // 查询是否支持某个接口
    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}