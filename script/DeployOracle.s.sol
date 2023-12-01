// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.7;
pragma experimental ABIEncoderV2;

import {Script} from "forge-std/Script.sol";
import {ChainlinkTWAP} from "../src/ChainlinkTWAP.sol";
import {ConverterFeed} from "geb-uniswap-median/UniV3ChainlinkTWAPConverterFeed.sol";
import {UniswapV3Medianizer} from "geb-uniswap-median/UniswapV3Medianizer.sol";

abstract contract DeployOracle is Script {
    function setUp() public virtual {}

    function run() public virtual {
        deployer = vm.addr(_deployerPk);
        vm.broadcast();

        ChainlinkTWAP chainlinkTwap = new ChainlinkTWAP(
            0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
            259200, // 3 days
            518400, // 6 days
            10000000000,
            6 // every 12 hours
        );

        UniswapV3Medianizer univ3Twap = new UniswapV3Medianizer(
            0x0dc9877f6024ccf16a470a74176c9260beb83ab6,
            0x03ab458634910AaD20eF5f1C8ee96F1D6ac54919,
            259200,
            0
        );

        ConverterFeed converterFeed = new ConverterFeed(
            address(univ3Twap),
            address(chainlinkTwap),
            1000000000000000000
        );
    }
}

contract DeployOracleGoerli is DeployOracle {
    function setUp() public override {
        _deployerPk = uint256(vm.envBytes32("GOERLI_DEPLOYER_PK"));
        chainId = 5;
    }
}

contract DeployOracleMainnet is MainnetParams, DeployGovernance {
    function setUp() public virtual {
        _deployerPk = uint256(vm.envBytes32("MAINNET_DEPLOYER_PK"));
        chainId = 1;
    }
}
