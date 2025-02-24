// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// function 类型作业
contract FunctionTestContract {
    function square(uint x) public pure returns(uint z) {
        return x*x;
    }

    function double(uint x) public pure returns(uint z) {
        return x*2;
    }

    function getSquareSelector() public pure returns(bytes4) {
        return this.square.selector;
    }

    function getDoubleSelector() public pure returns(bytes4) {
        return bytes4(keccak256("double(uint256)"));
    }

    function executeFunction(bytes4 selector, uint x) external returns(uint z) {
        (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(selector, x));
        require(success, "fail");
        return abi.decode(data, (uint));
    }
}