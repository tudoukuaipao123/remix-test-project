// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VirtualCollectibles is ERC721Enumerable, ERC721URIStorage, Ownable {
    // 记录下一个 NFT 代币的 ID
    uint256 private _currentTokenId;

    // 构造函数，设置合约名称和符号
    constructor() ERC721("VirtualCollectibles", "VRC") {}

    // 创建新 NFT 的函数
    function mint(address to, string memory tokenURI) external onlyOwner returns (uint256) {
        uint256 tokenId = _currentTokenId + 1;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _currentTokenId = tokenId; // 更新当前的 token ID
        return tokenId;
    }

    // 重写 _beforeTokenTransfer 来处理代币枚举
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // 重写 tokenURI 函数，返回 NFT 的元数据 URI
    function tokenURI(uint256 tokenId) public view override(ERC721URIStorage, ERC721) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    // 重写 _burn 来处理 NFT 销毁后的枚举
    function _burn(uint256 tokenId) internal override(ERC721URIStorage, ERC721) {
        super._burn(tokenId);
    }

    // 查询所有 NFT 的代币 ID
    function getAllTokens() external view returns (uint256[] memory) {
        uint256 totalSupply = totalSupply();
        uint256[] memory tokens = new uint256[](totalSupply);
        for (uint256 i = 0; i < totalSupply; i++) {
            tokens[i] = tokenByIndex(i);
        }
        return tokens;
    }
}
