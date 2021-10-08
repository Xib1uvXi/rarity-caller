//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./IERC721.sol";

interface IRarity is IERC721 {
    // getter
    function next_summoner() external view returns(uint256);
    function xp_per_day() external view returns(uint256);
    function DAY() external view returns(uint256);
    function name() external view returns(string memory);
    function symbol() external view returns(string memory);
    function xp(uint256) external view returns (uint);
    function adventurers_log(uint256) external view returns (uint);
    function class(uint256) external view returns (uint);
    function level(uint256) external view returns (uint);
    // event
    event summoned(address indexed owner, uint clazz, uint summoner);
    event leveled(address indexed owner, uint level, uint summoner);
    // methods
    function adventure(uint256 _summoner) external;
    function spend_xp(uint256 _summoner, uint256 _xp) external;
    function level_up(uint256 _summoner) external;
    function summoner(uint256 _summoner) external view returns (uint256 _xp, uint256 _log, uint256 _class, uint256 _level);
    function summon(uint256 _class) external;
    function xp_required(uint256 current_level) external pure returns (uint256 _xp_to_next_level);
    function tokenURI(uint256 _summoner) external view returns (string memory);
    function classes(uint256 id) external pure returns (string memory _description);
}

interface IRarityAttributes {
    // getter
    function ability_scores(uint summoner) external view returns (uint32 strength, uint32 dexterity, uint32 constitution, uint32 intelligence, uint32 wisdom, uint32 charisma);
    function level_points_spent(uint summoner) external view returns(uint);
    function character_created(uint summoner) external view returns(bool);
    // events
    event Created(address indexed creator, uint summoner, uint32 strength, uint32 dexterity, uint32 constitution, uint32 intelligence, uint32 wisdom, uint32 charisma);
    event Leveled(address indexed leveler, uint summoner, uint32 strength, uint32 dexterity, uint32 constitution, uint32 intelligence, uint32 wisdom, uint32 charisma);
    // methods
    function point_buy(uint _summoner, uint32 _str, uint32 _dex, uint32 _const, uint32 _int, uint32 _wis, uint32 _cha) external;
    function calculate_point_buy(uint _str, uint _dex, uint _const, uint _int, uint _wis, uint _cha) external pure returns (uint);
    function calc(uint score) external pure returns (uint);
    function increase_strength(uint _summoner) external;
    function increase_dexterity(uint _summoner) external;
    function increase_constitution(uint _summoner) external;
    function increase_intelligence(uint _summoner) external;
    function increase_wisdom(uint _summoner) external;
    function increase_charisma(uint _summoner) external;
    function abilities_by_level(uint current_level) external pure returns (uint);
    function tokenURI(uint256 _summoner) external view returns (string memory);
}

interface IRarityDungeon {
    // getter
    function balanceOf(uint) external view returns (uint);
    function adventurers_log(uint) external view returns (uint);
    // events
    event Transfer(uint indexed from, uint indexed to, uint amount);
    event Approval(uint indexed from, uint indexed to, uint amount);
    // methods
    function scout(uint _summoner) external view returns (uint reward);
    function adventure(uint _summoner) external returns(uint reward);
    function approve(uint from, uint spender, uint amount) external returns (bool);
    function transfer(uint from, uint to, uint amount) external returns (bool);
    function transferFrom(uint executor, uint from, uint to, uint amount) external returns (bool);
}

interface IRarityGold {
    // getter
    function balanceOf(uint) external view returns(uint);
    function claimed(uint) external view returns(uint);
    // events
    event Transfer(uint indexed from, uint indexed to, uint amount);
    event Approval(uint indexed from, uint indexed to, uint amount);
    // methods
    function claimable(uint _summoner) external view returns (uint amount);
    function claim(uint _summoner) external;
    function approve(uint from, uint spender, uint amount) external returns (bool);
    function transfer(uint from, uint to, uint amount) external returns (bool);
    function transferFrom(uint executor, uint from, uint to, uint amount) external returns (bool);
}