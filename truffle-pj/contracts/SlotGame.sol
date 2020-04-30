pragma solidity >=0.6.6 <0.7.0;
pragma experimental ABIEncoderV2;


/// @title Recorder the Results of Playing Slot Game
/// @author s.ikeda107
/// @notice You can record the results of playing the game.
/// @dev This contract use ABIEncoderV2. This contract has been programmed with sol version 0.6.6 in mind.
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

    event Received(address, uint256);

    /// @notice Receive Ether Function
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    event createdUser(
        string createdUserName,
        uint256 createdUserCreatedTime,
        uint256 createdUsersCount
    );

    /// @notice Create a User for each address when not already created.
    /// @dev This function throw event after creating user.
    /// @param _name user name
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

    /// @notice Get your user information
    /// @return the current user of User type.
    function getMyUserInfo() public view returns (User memory) {
        // 作成済みであること
        require(
            keccak256(bytes(addressToUser[msg.sender].name)) !=
                keccak256(bytes(""))
        );
        return addressToUser[msg.sender];
    }

    /// @notice Add the number of wins and save the time.
    function countUpWinsCount() public {
        // 作成済みであること
        require(
            keccak256(bytes(addressToUser[msg.sender].name)) !=
                keccak256(bytes(""))
        );
        addressToUser[msg.sender].lastPlayTime = now;
        addressToUser[msg.sender].winsCount += 1;
    }

    /// @notice Add the number of loses and save the time.
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
