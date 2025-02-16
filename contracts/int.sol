// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Convert {
    int8 y = -3;
    int x = int(y); 

    //如果转换成更小的类型，变量的值会丢失高位，从前面（左边截取）。 
    uint32 a = 0x12345678; 
    uint16 b = uint16(a); // b = 0x5678 
    // 如果从小的uint转到大的整数类型，则前面补零,(左边补零)
    uint16 c = 0x1234;
    uint32 d = uint32(c); // d = 0x00001234;

    // 如果是字节(二进制)数组bytes 则从末尾截取（右边截取），处理原始的二进制数据
    bytes2 e = 0x1234;
    bytes1 f = bytes1(e); // f = 0x12;

    // 如果字节(二进制)数组类型bytes从小变大，则在右边补零
    bytes1 g = 0x12;
    bytes2 h = bytes2(g); // h = 0x1200

    //把整数赋值给整型时，不能超出范围，发生截断，否则会报错。 
    uint8 i = 12; // 正确 
    uint32 j = 1234; // 正确 
    // uint16 k = 0x123456; // 错误,

}