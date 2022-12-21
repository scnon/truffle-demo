// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract KeyGame {
    struct Key {
        uint256 id;
        uint256 price;
        uint256 time;
        address owner;
    }

    Key[] keys;
    IERC20 public usdt;
    address payable owner;
    uint32 public index = 0;
    uint256 public cashPool = 10;
    uint256 _initPrice = 0.01 ether;
    uint256 _coolTime = 10 days;
    uint256 public endTime = 0;
    Key current = Key(0, 0, 0, address(0));
    mapping(address => uint256) public awards;

    event NewKey(uint256 id, uint256 price, uint256 start, uint256 end);
    event KeySold(uint256 id, uint256 price, address owner);
    event Check(uint256 id, uint256 price, address owner);

    constructor() {
        owner = payable(msg.sender);
        usdt = IERC20(0x9a2B7E8B4E16B9588a613768BA95c0F3d5bfBc96);
        generateKey(_initPrice);
    }

    modifier timeout {
        require(block.timestamp > endTime, "The key is selling");
        _;
    }

    modifier timing {
        require(block.timestamp <= endTime, "The key is out expired");
        _;
    }

    function SetToken(address _token) public {
        require(msg.sender == owner, "You are not the owner");
        usdt = IERC20(_token);
    }

    function NewTurn() public {

    }

    function generateKey(uint256 _price) private {
        uint256 _id = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)));
        current = Key(_id, _price , block.timestamp, address(0));
        keys.push(current);

        endTime = block.timestamp + _coolTime;
        emit NewKey(_id, _price, block.timestamp, endTime);
    }

    function process() public {
        if(block.timestamp > endTime) {
            _checkOver();
        }
    }

    function getCurrent() public view returns (Key memory) {
        return current;
    }

    function getHistory() public view returns (Key[] memory) {
        return keys;
    }

    function getAwards() public view returns (uint256) {
        return awards[msg.sender];
    }

    function buyKey() public payable timing {
        process();
        // require(msg.value == current.price, "You must pay the price");
        require(current.owner == address(0), "The key is already sold");
        
        // payable(current.owner).transfer(current.price);
        usdt.transfer(owner, current.price);

        // cashPool += _price / 2;
        // uint256 last = _price / 2 / (keys.length - 1);
        // for(uint256 i = 0; i < keys.length - 1; i++) {
        //     if(keys[i].owner != address(0)) {
        //         awards[keys[i].owner] += last;
        //     }
        // }

        current.owner = msg.sender;
        endTime = block.timestamp + _coolTime;
        emit KeySold(current.id, current.price, current.owner);

        generateKey(current.price * 2);
    }

    function _checkOver() private timeout {

    }
}