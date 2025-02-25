// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Car {
    uint16 public speed;

    // virtual标记为可重写
    function drive() virtual public {
        
    }
}

contract ElectricCar is Car {

    uint8 public batteryLevel;

    function drive() public override {
        batteryLevel++;
    }

}


contract Person {
    string internal name;
    uint8 internal age;
}

contract Employee {
    uint8 internal rank;

    function upgrades() virtual internal {
        rank++;
    }
}

contract Manager is Person, Employee {

    function upgrades() internal override {
        if (rank < 3) {
            revert("not manager");
        }
        rank++;
    }

}


// 抽象合约 Shape，包含一个纯虚函数 area
abstract contract Shape {
    // 纯虚函数 area，所有继承该合约的子合约必须实现它
    function area() public virtual view returns (uint256);
}

// Square 合约，继承 Shape 合约
contract Square is Shape {
    uint256 public sideLength;

    constructor(uint256 _sideLength) {
        sideLength = _sideLength;
    }

    // 实现 area 函数，计算正方形的面积
    function area() public view override returns (uint256) {
        return sideLength * sideLength;
    }
}

// Circle 合约，继承 Shape 合约
contract Circle is Shape {
uint256 public radius;

    constructor(uint256 _radius) {
        radius = _radius;
    }

    // 实现 area 函数，计算圆形的面积
    function area() public view override returns (uint256) {
        return radius * radius * 314159 / 100000;  // 使用近似值 3.14159 进行计算
    }
}