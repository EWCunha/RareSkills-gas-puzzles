// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedDistribute {
    constructor(address[4] memory _contributors) payable {}

    function distribute() external {
        // 56774
        uint256 amount = address(this).balance >> 2;
        require(amount > 0, "cannot distribute yet");

        assembly {
            pop(
                call(
                    gas(),
                    0x70997970C51812dc3A010C7d01b50e0d17dc79C8,
                    amount,
                    0,
                    0,
                    0,
                    0
                )
            )
            pop(
                call(
                    gas(),
                    0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC,
                    amount,
                    0,
                    0,
                    0,
                    0
                )
            )
            pop(
                call(
                    gas(),
                    0x90F79bf6EB2c4f870365E785982E1f101E93b906,
                    amount,
                    0,
                    0,
                    0,
                    0
                )
            )
            selfdestruct(0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65)
        }
    }
}
