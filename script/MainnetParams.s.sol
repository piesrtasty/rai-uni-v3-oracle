// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.7;

import {Params} from "@script/Params.s.sol";

abstract contract MainnetParams is Params {
    // --- Testnet Params ---
    function _getEnvironmentParams() internal override {
        chainlinkAggregator = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419; // ETH / USD
        uniswapPool = 0x0dc9877F6024CCf16a470a74176C9260beb83AB6; // RAI / WETH
        targetToken = 0x03ab458634910AaD20eF5f1C8ee96F1D6ac54919; // RAI
    }
}
