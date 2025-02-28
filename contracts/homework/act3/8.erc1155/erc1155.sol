// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721Enumerable.sol";

contract CollectibleWithEnumeration is ERC721Enumerable {

    uint public constant gold = 3;
    uint public constant sliver = 6;
    uint public constant sword = 1;

    constructor() public ERC1155("https://mygame.io/api/token/{id}.json") {
        _mint(msg.sender, gold, 1000, "");
        _mint(msg.sender, sliver, 5000, "");
        _mint(msg.sender, sword, 3, "");
    }

    
    // 批量转移函数
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public override {
        require(ids.length == amounts.length, "ERC1155: ids and amounts length mismatch");
        for (uint256 i = 0; i < ids.length; i++) {
            safeTransferFrom(from, to, ids[i], amounts[i], data);
        }
    }

}