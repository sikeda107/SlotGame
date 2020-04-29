pragma solidity >=0.6.6 <0.7.0;
pragma experimental ABIEncoderV2;

contract SlotGame {
    struct User {
        string name;
        uint256 createdTime;
        uint256 winsCount;
        uint256 loseCount;
    }
    mapping(address => User) addressToUser;

    constructor() public {}

    event createdUser(string createdUserName, uint256 createdUserCreatedTime);

    function createUser(string memory _name) public {
        // 引数なしまたは、作成済みでない
        require(
            keccak256(bytes(_name)) !=
                keccak256(bytes("")) &&
                keccak256(bytes(addressToUser[msg.sender].name)) ==
                keccak256(bytes(""))
        );
        addressToUser[msg.sender].name = _name;
        addressToUser[msg.sender].createdTime = now;
        addressToUser[msg.sender].winsCount = 0;
        addressToUser[msg.sender].loseCount = 0;
        emit createdUser(
            addressToUser[msg.sender].name,
            addressToUser[msg.sender].createdTime
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
}
