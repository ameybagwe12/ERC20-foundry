// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//  OPEN ZEPPELIN TOKENS DEPLOYED
contract MyToken is ERC20 {
    constructor(uint256 initSupply) ERC20("MyToken", "MT") {
        _mint(msg.sender, initSupply);
    }
}
