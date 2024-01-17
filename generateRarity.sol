function generateRarity() private returns (Rarity) {
  return Rarity(keccak256(abi.encodePacked(block.timestamp, block.number)) % 8);
}
