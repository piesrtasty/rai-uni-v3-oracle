// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.7;
pragma experimental ABIEncoderV2;

import {Script} from "forge-std/Script.sol";
import {UniV3ChainlinkTWAPConverterFeed} from "geb-uniswap-median";

abstract contract DeployOracle is Script {
    function setUp() public virtual {}

    function run() public virtual {
        vm.broadcast();
    }
}
