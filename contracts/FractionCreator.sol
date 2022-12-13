//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.9;

import "./ERC1155URIStorage.sol";

contract FractionCreator is ERC1155URIStorage {

    address public owner;

    constructor(uint256 tokenId, string memory tokenURI, uint fractionCount, address ownerAddress) ERC1155("") {
        owner = msg.sender;
        _mint(ownerAddress, tokenId, fractionCount, " ");
        setURI(tokenId, tokenURI);
    }

    function mintFraction(uint256 tokenId, string memory tokenURI, uint fractionCount, address ownerAddress) external onlyOwner{
        _mint(ownerAddress, tokenId, fractionCount, " ");
        setURI(tokenId, tokenURI);
    }

    function burn(address account, uint256 id, uint256 value) public virtual {
        require(
            account == _msgSender() || isApprovedForAll(account, _msgSender()),
            "ERC1155: caller is not token owner nor approved"
        );

        _burn(account, id, value);
    }

    function setURI(uint256 tokenId, string memory tokenURI) internal {
        super._setURI(tokenId, tokenURI);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized!!!");
        _;
    }

    //Remove in final build
    function destroy() public {
        selfdestruct(payable(msg.sender));
    }
}