// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// 映射类型作业
contract PointsSystem {
    address[] public users;
    mapping(address => uint) public points;

    function addUser(address _user) public {
        require(points[_user] == 0, "User already exists");
        users.push(_user);
        points[_user] = 100; // 初始积分
    }

    function transferPoints(address _to, uint _amount) public {
        require(points[msg.sender] > _amount, "Insufficient points.");
        points[msg.sender] -= _amount;
        points[_to] += _amount;
    }

    function getAllUser() public returns(address[] memory) {
        return users;
    }

    // 获取排行榜（按积分降序排序）
    function getLeaderboard() public view returns (address[] memory, uint256[] memory) {
        address[] memory sortedUsers = users;
        uint256[] memory sortedPoints = new uint256[](sortedUsers.length);

        // 复制积分数据
        for (uint256 i = 0; i < sortedUsers.length; i++) {
            sortedPoints[i] = points[sortedUsers[i]];
        }

        // 对用户按积分降序排序
        for (uint256 i = 0; i < sortedUsers.length - 1; i++) {
            for (uint256 j = i + 1; j < sortedUsers.length; j++) {
                if (sortedPoints[i] < sortedPoints[j]) {
                    // 交换用户地址
                    (sortedUsers[i], sortedUsers[j]) = (sortedUsers[j], sortedUsers[i]);
                    // 交换积分
                    (sortedPoints[i], sortedPoints[j]) = (sortedPoints[j], sortedPoints[i]);
                }
            }
        }

        return (sortedUsers, sortedPoints);
    }

}