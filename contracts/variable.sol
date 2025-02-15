// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// solidity 是一种静态的类型语言，这意味着申明期间就需要制定变量的类型，每一个变量申明的时候，都有一个基于类型的默认值，没有 undefined 和 null
// 状态变量: 变量值-永久  存储到区块链里,合约的存储空间
// 局部变量: 仅在函数执行中有效, 函数退出后变量无效
// 全局变量: 存在全局命名空间的变量，可以获取区块链的相关信息,比如区块链高度

contract Variable {
    uint storageDATA; // 状态变量
    constructor() public {
        storageDATA = 10;
    }

    /**
    public 对外开放
    view 可读
    returns 返回结构
    */
    // 局部变量 a,b,c
    function getResult() public view returns (uint) {
        uint a = 1; // 局部变量
        address b;
        uint c = 2;
        return a + c; // 返回变量
    }

    // 全局变量

    block.coinbase;
    block.difficulty;// 难度指示
    block.gaslimit;
    block.number; // 当前的区块高度
    block.timestamp; // 区块的时间戳
    msg.data;
    msg.sender; // 当前调用者地址
    msg.sig; // 当前调用者签名
    msg.value; // 传入当前的钱
    now; // 当前的块的时间戳
    tx.gas;


    // 变量的书写规范
    /**
    1.不应该用关键词作为变量名，比如now,break,for,if,bool,block
    2.变量名不应该以数字开头0-9，123test无效
    3.区分大消息，大写和小写是两个不同的变量
    */

}