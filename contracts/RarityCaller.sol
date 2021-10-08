// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./IRarity.sol";

contract RarityCaller is Ownable {
    // Rarity Contracts
    IRarity rarity = IRarity(0xce761D788DF608BD21bdd59d6f4B54b2e27F25Bb);// 冒险 && 升级
    // IRarityAttributes rarity_attributes = IRarityAttributes(0xB5F5AF1087A8DA62A23b08C00C6ec9af21F397a1); //召唤师属性购买	
    // IRarityDungeon rarity_dungeon = IRarityDungeon(0x2A0F1cB17680161cF255348dDFDeE94ea8Ca196A);//副本
    // IRarityGold rarity_gold = IRarityGold(0x2069B76Afe6b734Fb65D1d099E7ec64ee9CC76B2);//金币领取合约

    // fees
    mapping(address => uint) public fees;
    uint public feeMultiplier = 30;

    function rarityAdventureAll(uint[] calldata summoners) external payable {
         uint startGasLeft = gasleft();
         
         for (uint i; i < summoners.length; i++) {
            rarity.adventure(summoners[i]);
        }

        uint cost = (startGasLeft - gasleft()) * tx.gasprice * feeMultiplier / 100;

        require(msg.value > cost, "INSUFFICIENT_FEE");
        
        fees[address(this)] += cost;

        payable(msg.sender).transfer(msg.value - cost);
    }

    function rarityLevelupAll(uint[] calldata summoners) external payable {
        uint startGasLeft = gasleft();
        
        for (uint i; i < summoners.length; i++) {
            rarity.level_up(summoners[i]);
        }

        uint cost = (startGasLeft - gasleft()) * tx.gasprice * feeMultiplier / 100;

        require(msg.value > cost, "INSUFFICIENT_FEE");
        
        fees[address(this)] += cost;

        payable(msg.sender).transfer(msg.value - cost);
    }

    function withdrawFees(
        address to
    ) external onlyOwner {
        require(fees[address(this)] >= 0, "ZERO_FEE");
        uint amount = fees[address(this)];
        fees[address(this)] = 0;
        payable(to).transfer(amount);
    }

    function setFeeMultiplier(
        uint multiplier
    ) external onlyOwner {
        require(multiplier <= 100, "MULTIPLIER_OVERFLOW");
        feeMultiplier = multiplier;
    }
}


