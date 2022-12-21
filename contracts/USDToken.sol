// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract USDToken is ERC20 {
  uint public initialSupply = 10000 * 10 ** decimals();

  constructor() ERC20("USDToken", "USDT") {
      _mint(msg.sender, initialSupply);
  }
}