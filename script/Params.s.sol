// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.7;

abstract contract Params {
    // ChainlinkTWAP
    address chainlinkAggregator;
    uint256 chainlinkWindowSize = 259200; // 3 days
    uint256 maxWindowSize = 518400; // 6 days
    uint256 multiplier = 10000000000;
    uint8 granularity = 6; // every 12 hours

    // UniswapV3Medianizer
    address uniswapPool;
    address targetToken;
    uint32 uniWindowSize = 259200;
    uint256 minimumLiquidity = 0;

    // UniV3ChainlinkTWAPConverterFeed
    uint256 scalingFactor = 1000000000000000000;

    function _getEnvironmentParams() internal virtual;
}
