// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// 结构体类型-作业
contract StractTest {
    struct Product {
        uint id;
        string name;
        uint price;
        uint stock;
    }

    struct Order {
        uint orderId;
        uint time;
        uint[] productCarts;
    }

    mapping(uint => Product) public products;
    mapping(uint => Order) public orders;
    uint public productCount = 0;
    uint public orderCount = 0;
    function addProduct(string memory _name, uint _price, uint _stock) public {
        productCount++;
        products[productCount] = Product(productCount, _name, _price, _stock);
    }

    function updateProductStock(uint _productId, uint _newStock) public {
        Product storage product = products[_productId];
        product.stock = _newStock;
    }

    function getProduct(uint _productId) public view returns (string memory, uint, uint) {
        Product storage product = products[_productId];
        return (product.name, product.price, product.stock);
    }

    function addOrder(uint[] memory productCarts) public {
        orderCount++;
        orders[orderCount] = Order(orderCount, block.timestamp, productCarts);
    }
}

contract UserManagement {
    // 用户信息结构体
    struct UserInfo {
        bytes32 name; // 使用 bytes32 代替 string 以减少存储成本
        uint balance;
    }

    // 交易历史结构体
    struct Transaction {
        uint transactionId;
        uint time;
        uint amount;
        address from;
        address to;
    }

    // 用户信息映射
    mapping(address => UserInfo) public users;

    // 用户交易历史映射
    mapping(address => Transaction[]) public userTransactions;

    // 用户总数
    uint public userCount;

    // 事件
    event UserRegistered(address indexed user, bytes32 name);
    event BalanceUpdated(address indexed user, uint newBalance);
    event TransactionRecorded(
        address indexed from,
        address indexed to,
        uint amount,
        uint time
    );

    // 注册用户
    function registerUser(bytes32 _name) public {
        require(users[msg.sender].name == 0, "User already registered");

        users[msg.sender] = UserInfo({
            name: _name,
            balance: 0
        });

        userCount++;
        emit UserRegistered(msg.sender, _name);
    }

    // 更新用户余额
    function updateBalance(uint _newBalance) public {
        require(users[msg.sender].name != 0, "User not registered");

        users[msg.sender].balance = _newBalance;
        emit BalanceUpdated(msg.sender, _newBalance);
    }

    // 记录交易历史
    function recordTransaction(address _to, uint _amount) public {
        require(users[msg.sender].name != 0, "Sender not registered");
        require(users[_to].name != 0, "Recipient not registered");

        uint transactionId = userTransactions[msg.sender].length;
        userTransactions[msg.sender].push(Transaction({
            transactionId: transactionId,
            time: block.timestamp,
            amount: _amount,
            from: msg.sender,
            to: _to
        }));

        emit TransactionRecorded(msg.sender, _to, _amount, block.timestamp);
    }

    // 获取用户信息
    function getUserInfo(address _user) public view returns (bytes32, uint) {
        require(users[_user].name != 0, "User not registered");
        return (users[_user].name, users[_user].balance);
    }

    // 获取用户交易历史
    function getUserTransactions(address _user) public view returns (Transaction[] memory) {
        require(users[_user].name != 0, "User not registered");
        return userTransactions[_user];
    }
}