//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';

// import 'hardhat/console.sol';

// You may not modify this contract
contract NotRareToken is ERC721 {
    mapping(address => bool) private alreadyMinted;

    uint256 private totalSupply;

    constructor() ERC721('NotRareToken', 'NRT') {}

    function mint() external {
        totalSupply++;
        _safeMint(msg.sender, totalSupply);
        alreadyMinted[msg.sender] = true;
    }
}

contract OptimizedAttacker {
    constructor(address victim) {
        unchecked {
            NotRareToken nRareToken = NotRareToken(victim);

            uint256 start = nRareToken.balanceOf(nRareToken.ownerOf(1)) + 1;
            uint256 end = start + 150;

            nRareToken.mint();
            for (uint256 ii = start + 1; ii < end; ++ii) {
                nRareToken.mint();
                nRareToken.transferFrom(address(this), msg.sender, ii);
            }

            nRareToken.transferFrom(address(this), msg.sender, start);
        }
    }
}
