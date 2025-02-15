// 数据类型
// 值类型
/**
布尔类型
整型
定长浮点型
定长字节数组
有理数和整型常量
字符串常量
十六进制常量
枚举
函数类型
地址类型
地址常量

注意：类型里没有浮点型！solidity里不支持浮点型！会溢出
*/
// 引用类型


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ValueType {
    // bool就是布尔不是boolean public是可以访问
    bool public isActive = true;
    function toggleActive() public {
        isActive = !isActive;
    }

    // 整型
    int8 signedInt = 32; // -2^8-1 ~ 2^8-1 
    uint8 uInt = 32; // 0 ~ 2^8-1（255） 正数
    /**
    // 整型支持
    比较运算符： <=,<,==,!=,>=
    位操作符: &(和)  ｜(或)  ^(异或) ～(位取反)
    算数操作符：+ - * / %(取余数)
    位移操作符: <<(左位移)  >>(右位移)  操作符右边的数不能是负数
    **/

    int8 a = -1;
    int16 b = 2;
    uint32 c = 10;
    uint8 d = 16;

    function add(uint x, uint y) public pure returns (uint z) {
        z = x + y;
    }

    function divide(uint x, uint y) public pure returns (uint z) {
        z = x/y; // 除法这里没有小数，只有整数，如果有小数就只取整数部分
    }

    /**
    // 对于整数 x，x >> y 表示将 x 的二进制位向右移动 y 位。右移时，最右边的位会丢失，最左边的位会根据 x 是正数还是负数进行填充（对于负数，左侧填充 1，对于正数，左侧填充 0）。
    // 假设 x 为 1，y 为 2：
    // x = 1 的二进制表示是 0000 0001（假设是 8 位表示）。
    // 右移 2 位后，1 的二进制表示会变成 0000 0000。
    */
    function shift(int x, uint8 y) public  pure  returns (int z) {
        z = x >> y;
    }

    function add2() public pure returns(uint8) {
        uint8 a = 128;
        uint8 b = a*2;
        return b; // 因为uint8最大是255 256就溢出了
    }

    // uint8 = 0xff

    // 定长浮点型  solidity没有浮点数，这是模拟浮点数
    int256 fixedPoint = 1e18; // 模拟定长浮点型 1e18 实际上就是 10^18

    // 定长字节数据
    bytes1 sigleByle = 0x12;
    // bytes256 bt256 = 0x0000000000000;

    // 有理数和整型常量
    uint256 integer = 1234;
    uint256 rationalLiteral = 1.5*1e18; // 表示1.5以太

    // 字符串常量
    string greeting = "hello"; // 不可变的文本数据

    // 枚举
    enum Status {Pending, Shipped}

    Status public currentStatus;

    // 函数类型，也是一种值类型
    function setStatus(Status _status) public {
        currentStatus = _status;
    }

    // 地址类型,存储以太坊地址，特殊字符串类型，20字符
    address owner = msg.sender;

    address public myAddress = 0x1234567890123456789012345678901234567890;
    address myAddress2 = msg.sender;// 当前合约调用者的地址

    // address和address payable转换； payable的地址是可以接收住币的
    address payable payableAddress = payable(owner);

    // address的属性和方法
    /**
    balance: 使用balance属性获取地址的以太坊余额  获取金额
    transfer: 使用transfer()方法将以太币转移到另一个地址， 可以理解为支付？推荐使用
    send: 使用send方法转移比特币，返回布尔值表示转移是否成功, 另一种支付？没有自动回退机制，不推荐使用
    call: 低级别调用，也返回布尔值来判断转移是否成功，另一种支付？ 讨论其安全性问题以及与 send() 和 transfer() 的区别。
    **/
    uint256 balance = myAddress.balance; // 获取地址余额

    // (bool success, ) = balance.call{value: 1 ether}("");  // 使用 call 转移 1 ETH
    // require(success, "Transfer failed.");

    // address 和 address payable 的区别
    // address payable 是可以接收以太币的地址类型。address 类型不能直接发送以太币，必须显式转换为 address payable。
    // 交易的信息
    //msg.data; //交易携带信息
    //msg.value; // 转账传多少值

    //address 类型的实际应用  白名单机制、支付合约等 

    /**
        // 白名单机制
        mapping(address => bool) public whitelist; // 创建一个白名单列表

        function addToWhitelist(address _address) public {
            whitelist[_address] = true;
        }

        function isWhitelisted(address _address) public view returns (bool) {
            return whitelist[_address];
        }

        // 授权支付合约
        function pay(address payable recipient) public payable { // 如果在白名单内则授权合约权限，可以支付
            require(whitelist[recipient], "Recipient is not whitelisted.");
            recipient.transfer(msg.value);
        }
    **/

    // 安全性考虑 避免重入攻击
    /**
        function withdraw(uint256 amount) public {
            require(balances[msg.sender] >= amount, "Insufficient balance.");

            // 更新余额
            balances[msg.sender] -= amount;

            // 转账
            (bool success, ) = msg.sender.call{value: amount}("");
            require(success, "Transfer failed.");
        }

        // 存款函数
        function deposit() public payable {
            balances[msg.sender] += msg.value;
        }

        防范重入攻击的关键点：
        检查-效果-交互模式：我们应该在进行外部调用（例如转账）之前，先更新合约的状态，确保合约的状态在外部调用前是最新的。这样即使发生回调，合约状态也不会受到影响。

        使用 ReentrancyGuard：OpenZeppelin 提供的 ReentrancyGuard 可以用来防止重入攻击。通过引入一个 nonReentrant 修饰符，确保在执行合约函数时不会被重新进入。

        使用 transfer 或 send：虽然 transfer 和 send 限制了调用者能够消耗的 gas（最大 2300 gas），减少了外部合约执行的可能性，但它们也有一些限制，不能处理复杂的回调逻辑，因此在一些简单场景中也能作为防范手段。
    **/

    

    // 地址常量
    address constant fixedAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

}