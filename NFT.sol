pragma solidity ^0.8.0;

contract NFTCollection {

  // Los atributos de la colección

  string public name;
  string public symbol;
  uint256 public totalSupply;

  // Estructura de los NFT

  struct NFT {
    uint256 id;
    uint8 rarity;
    string imageURI;
  }

  // Array

  NFT[] public NFTs;

  // Constructor

  constructor(string memory _name, string memory _symbol) {
    name = _name;
    symbol = _symbol;
    totalSupply = 9999;

    // Inicializa los NFT

    for (uint256 i = 0; i < totalSupply; i++) {
      NFTs.push(NFT(i, generateRarity(), "https://example.com/image/" + i));
    }
  }

  // Genera una rareza aleatoria

  function generateRarity() private returns (uint8) {
    return uint8(keccak256(abi.encodePacked(block.timestamp, block.number)));
  }

  // Devuelve el NFT con el ID especificado

  function getNFT(uint256 _id) public view returns (NFT memory) {
    return NFTs[_id];
  }

  // Crea un nuevo NFT

  function mintNFT() public payable {
    // Comprueba que el usuario haya pagado la cantidad correcta

    require(msg.value == 0.01 ether);

    // Genera un nuevo NFT

    NFT memory newNFT = NFT(totalSupply, generateRarity(), "https://example.com/image/" + totalSupply);

    // Añade el nuevo NFT a la colección

    NFTs.push(newNFT);

    // Actualiza el total de NFTs

    totalSupply++;

    // Devuelve el nuevo NFT al usuario

    emit MintedNFT(newNFT.id);
    return newNFT;
  }

  // Eventos

  event MintedNFT(uint256 _id);
}
