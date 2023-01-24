// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract HomeChain is ERC721URIStorage, ERC721Enumerable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("HomeChain", "HOME") {}

    function create(address owner, string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newTokenId = _tokenIds.current();
        _mint(owner, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        _tokenIds.increment();
        return newTokenId;
    }

    function updateAttributes(uint256 tokenId, string memory tokenURI)
        public
        returns (uint256)
    {
        require(_ownerOf(tokenId) == msg.sender, "Only the owner can update!");
        _setTokenURI(tokenId, tokenURI);

        return tokenId;
    }

    function getTokenIds(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256[] memory _tokensOfOwner = new uint256[](
            ERC721.balanceOf(_owner)
        );
        uint256 i;

        for (i = 0; i < ERC721.balanceOf(_owner); i++) {
            _tokensOfOwner[i] = ERC721Enumerable.tokenOfOwnerByIndex(_owner, i);
        }
        return (_tokensOfOwner);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
