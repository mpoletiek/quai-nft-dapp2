// Quai NFT Example //
/////////////////////
// Anyone can mint.
// Max supply and mint price are public, modifiable by the owner.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract TestERC721 is ERC721URIStorage, Ownable {
    uint256 public tokenIds = 0;
    uint256 public mintPrice = (5 ether);
    uint256 public supply = 10000;
    
    constructor(address initialOwner) Ownable(initialOwner) ERC721("TestERC721", "TNFT") { }

    // Mint NFT 
    function mint(address _recipient, string memory _tokenURI)
        public 
        payable
        returns (uint256)
    {
        require(msg.value == mintPrice, "5 QUAI to Mint");
        uint256 tokenId = tokenIds;
        require(tokenId < supply, "No more NFTs");
        _mint(_recipient, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        tokenIds += 1;
        return tokenId;
    }

    // Burn NFT
    function burn(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Only the owner of the NFT can burn it.");
        _burn(tokenId);
    }

   
    // Update token supply
    function updateSupply(uint256 _supply)
        public
        onlyOwner()
        returns (uint256)
    {
        require(_supply > tokenIds, "New supply must be greater than current minted supply.");
        supply = _supply;
        return supply;
    }

    // Update Mint Price
    function updateMintPrice(uint256 _price)
        public
        onlyOwner()
        returns (uint256)
    {
        mintPrice = _price;
        return mintPrice;
    }
    
    // Withdraw QUAI to Owner
    function withdraw()
        public 
        payable
        onlyOwner()
        returns (bool)
    {
        require(msg.sender == owner(), "Unauthorized");
        (bool success, ) = owner().call{value:address(this).balance}("");
        require(success, "Withdraw failed.");
        return true;
    }

}