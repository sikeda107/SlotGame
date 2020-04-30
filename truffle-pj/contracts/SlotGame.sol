pragma solidity >=0.6.6 <0.7.0;
pragma experimental ABIEncoderV2;


contract SlotGame {
    struct User {
        string name;
        uint256 createdTime;
        uint256 lastPlayTime;
        uint256 winsCount;
        uint256 loseCount;
    }
    mapping(address => User) addressToUser;
    uint256 usersCount;

    constructor() public {
        usersCount = 0;
    }

    event createdUser(
        string createdUserName,
        uint256 createdUserCreatedTime,
        uint256 createdUsersCount
    );

    function createUser(string memory _name) public {
        // 引数なしまたは、作成済みでない
        require(
            keccak256(bytes(_name)) != keccak256(bytes("")) &&
                keccak256(bytes(addressToUser[msg.sender].name)) ==
                keccak256(bytes(""))
        );
        addressToUser[msg.sender].name = _name;
        addressToUser[msg.sender].createdTime = now;
        addressToUser[msg.sender].winsCount = 0;
        addressToUser[msg.sender].loseCount = 0;
        usersCount += 1;
        emit createdUser(
            addressToUser[msg.sender].name,
            addressToUser[msg.sender].createdTime,
            usersCount
        );
    }

    function getMyUserInfo() public view returns (User memory) {
        // 作成済みであること
        require(
            keccak256(bytes(addressToUser[msg.sender].name)) !=
                keccak256(bytes(""))
        );
        return addressToUser[msg.sender];
    }

    function countUpWinsCount() public {
        // 作成済みであること
        require(
            keccak256(bytes(addressToUser[msg.sender].name)) !=
                keccak256(bytes(""))
        );
        addressToUser[msg.sender].lastPlayTime = now;
        addressToUser[msg.sender].winsCount += 1;
    }

    function countUpLoseCount() public {
        // 作成済みであること
        require(
            keccak256(bytes(addressToUser[msg.sender].name)) !=
                keccak256(bytes(""))
        );
        addressToUser[msg.sender].lastPlayTime = now;
        addressToUser[msg.sender].loseCount += 1;
    }
}
