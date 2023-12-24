// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.7;
pragma experimental ABIEncoderV2;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import {Params} from "@script/Params.s.sol";
import {GoerliParams} from "@script/GoerliParams.s.sol";
import {MainnetParams} from "@script/MainnetParams.s.sol";
import {ChainlinkTWAP} from "@contracts/ChainlinkTWAP.sol";
import {ConverterFeed} from "geb-uniswap-median/UniV3ChainlinkTWAPConverterFeed.sol";
import {UniswapV3Medianizer} from "geb-uniswap-median/UniswapV3Medianizer.sol";

abstract contract IncreasingRewardRelayerLike {
    function reimburseCaller(address) external virtual;

    function refundRequestor() external view virtual returns (address);
}

abstract contract DeployOracle is Script, Params {
    uint256 internal _deployerPk;
    // --- Helpers ---
    uint256 public chainId;
    address public deployer;

    function run() public virtual {
        _getEnvironmentParams();

        deployer = vm.addr(_deployerPk);
        vm.startBroadcast(deployer);

        ChainlinkTWAP chainlinkTwap = new ChainlinkTWAP(
            chainlinkAggregator,
            chainlinkWindowSize,
            maxWindowSize,
            multiplier,
            granularity
        );

        UniswapV3Medianizer univ3Twap = new UniswapV3Medianizer(
            uniswapPool,
            targetToken,
            uniWindowSize,
            minimumLiquidity
        );

        new ConverterFeed(
            address(univ3Twap),
            address(chainlinkTwap),
            scalingFactor
        );
    }
}

contract DeployOracleGoerli is GoerliParams, DeployOracle {
    function setUp() public virtual {
        _deployerPk = uint256(vm.envBytes32("GOERLI_DEPLOYER_PK"));
        chainId = 5;
    }
}

contract DeployOracleMainnet is MainnetParams, DeployOracle {
    function setUp() public virtual {
        _deployerPk = uint256(vm.envBytes32("MAINNET_DEPLOYER_PK"));
        chainId = 1;
    }
}
