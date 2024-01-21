// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployMyToken} from "../script/DeployMyToken.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public myToken;
    DeployMyToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant START_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployMyToken();
        myToken = deployer.run();

        vm.prank(msg.sender);
        myToken.transfer(bob, START_BALANCE);
    }

    function testBobBalance() public {
        assertEq(START_BALANCE, myToken.balanceOf(bob));
    }

    function testAllowances() public {
        // transferFrom
        uint256 initAllowance = 1000;
        uint256 tfAmount = 500;

        vm.prank(bob);
        myToken.approve(alice, initAllowance);

        vm.prank(alice);
        myToken.transferFrom(bob, alice, tfAmount);

        assertEq(myToken.balanceOf(alice), tfAmount);
        assertEq(myToken.balanceOf(bob), START_BALANCE - tfAmount);
    }
}
