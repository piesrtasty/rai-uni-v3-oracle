// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.7;
pragma experimental ABIEncoderV2;

import {Script} from "forge-std/Script.sol";
import {ChainlinkTWAP} from "geb-chainlink-median";
import {ConverterFeed} from "geb-uniswap-median";
import {UniswapV3Medianizer} from "geb-uniswap-median";

abstract contract DeployOracle is Script {
    function setUp() public virtual {}

    function run() public virtual {
        vm.broadcast();

        ChainlinkTWAP chainlinkTwap = new ChainlinkTWAP(
            0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
            259200, // 3 days
            518400, // 6 days
            10000000000,
            6 // every 12 hours
        );

        UniswapV3Medianizer univ3Twap = UniswapV3Medianizer(
            0x0dc9877f6024ccf16a470a74176c9260beb83ab6,
            0x03ab458634910AaD20eF5f1C8ee96F1D6ac54919,
            259200,
            0
        );

        ConverterFeed converterFeed = ConverterFeed(
            address(univ3Twap),
            address(chainlinkTwap),
            1000000000000000000
        );
    }
}
