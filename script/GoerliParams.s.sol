// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.7;

import {Params} from "@script/Params.s.sol";

abstract contract GoerliParams is Params {
    // --- Testnet Params ---
    function _getEnvironmentParams() internal override {
        chainlinkAggregator = 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e; // ETH / USD
        uniswapPool = 0x0d239A060e6970b50479B990814E8f9dfD22306E; // GSUc / WETH
        targetToken = 0x252D98faB648203AA33310721bBbDdfA8F1b6587; // GSUc
    }
}
