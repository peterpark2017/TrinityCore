/*==========创建表============================== */

/* 假玩家功能的表 */
USE characters;

DROP TABLE IF EXISTS `characters`.`characters_fake`;
CREATE TABLE IF NOT EXISTS `characters`.`characters_fake` (
  `name` varchar(12) NOT NULL,
  `race` mediumint(3) NOT NULL DEFAULT '0',
  `class` mediumint(3) NOT NULL DEFAULT '0',
  `level` mediumint(3) NOT NULL DEFAULT '0',
  `zone` mediumint(9) NOT NULL DEFAULT '0',
  `gender` mediumint(3) NOT NULL DEFAULT '0',
  `online` datetime NOT NULL,
  `lastup` datetime NOT NULL,
  UNIQUE KEY `name` (`name`),
  KEY `level` (`level`),
  KEY `online` (`online`),
  KEY `lastup` (`lastup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `characters`.`fake_zones`;
CREATE TABLE `characters`.`fake_zones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `zone` INT NULL,
  `level` INT NULL,
  PRIMARY KEY (`id`));
  
/* 幻化功能的表 */
CREATE TABLE IF NOT EXISTS `characters`.`custom_transmogrification` (
  `GUID` int(10) unsigned NOT NULL COMMENT 'Item guidLow',
  `FakeEntry` int(10) unsigned NOT NULL COMMENT 'Item entry',
  `Owner` int(10) unsigned NOT NULL COMMENT 'Player guidLow',
  PRIMARY KEY (`GUID`),
  KEY `Owner` (`Owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='6_2';

CREATE TABLE IF NOT EXISTS `characters`.`custom_transmogrification_sets` (
  `Owner` int(10) unsigned NOT NULL COMMENT 'Player guidlow',
  `PresetID` tinyint(3) unsigned NOT NULL COMMENT 'Preset identifier',
  `SetName` text COMMENT 'SetName',
  `SetData` text COMMENT 'Slot1 Entry1 Slot2 Entry2',
  PRIMARY KEY (`Owner`,`PresetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='6_1';

/* 商店功能 */
CREATE TABLE IF NOT EXISTS `world`.`vip_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) unsigned NOT NULL,
  `category` int(11) unsigned NOT NULL DEFAULT '0',
  `price` int(11) unsigned NOT NULL DEFAULT '0',
  `name` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  


/* 会员功能 */
CREATE TABLE IF NOT EXISTS `auth`.`account_premium` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'Account id',
  `vip_level` int(11) unsigned NOT NULL DEFAULT '0',
  `vip_expire` int(11) unsigned NOT NULL DEFAULT '0',
  `wow_point` int(11) unsigned NOT NULL DEFAULT '0',
  `RAF_num` int(11) NULL DEFAULT '0',
  `RAF_rewards` int(11) NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
  
/*技能学习为0 */
/* update world.npc_trainer set MoneyCost=0; */

/* 关闭战场
update `battleground_template` set MinLvl=99,MaxLvl=0 where ID not in (4,5,6);
update `access_requirement` set level_min=99;
*/

/*----------一些装备的修改------------------*/

/*学习初级骑术的卷轴*/
UPDATE `world`.`item_template` SET `spellid_2`='33389', `RequiredSkill`='0', `RequiredSkillRank`='0'  WHERE `entry`='3737';
UPDATE `world`.`item_template_locale` SET `name_loc4`='初级骑术卷轴', `name_loc5`='初級騎術捲軸',description_loc4='使用它可以学会初级骑术技能。',description_loc5='使用它可以學會初級騎術技能。' WHERE `entry`='3737';

/* 狼和马都只需要1级可以骑 */
UPDATE `world`.`item_template` SET `RequiredLevel`='1' WHERE `entry`='5656';
UPDATE `world`.`item_template` SET `RequiredLevel`='1' WHERE `entry`='5668';

/* 新装备血战宝典 */
replace  INTO `world`.`item_template` (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, 
`BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, 
`requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, 
`StatsCount`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`,
 `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, 
 `ScalingStatDistribution`, `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, 
 `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`,
 `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, 
 `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`,
 `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`,
 `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, 
 `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, 
 `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, 
 `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, 
 `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`) VALUES
(29739, 0, 0, -1, 'WOW Book', 1103, 7, 134217728, 0, 1, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36177, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 
0, 0, 0, -1, 0, -1, 1, 'Useful handy book provided by Nostairius WoW.', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 'wowbook', 0, 0, 0, 0, 0, 12340);

UPDATE `world`.`locales_item` SET `name_loc4`='魔兽宝典', `name_loc5`='魔獸寶典',description_loc4='本魔兽服给玩家提供的工具，可以提供会员，商城，角色等服务。',description_loc5='本魔獸服給玩家提供的工具，可以提供會員，商城，角色等服務。' WHERE `entry`='29739';

/* 出生赠送装备*/

INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 3737, 1), 
   (2, 11, 3737, 1),
   (3, 11, 3737, 1),
   (4, 11, 3737, 1),
   (5, 11, 3737, 1),
   (6, 11, 3737, 1),
   (7, 11, 3737, 1),
   (8, 11, 3737, 1),
   (9, 11, 3737, 1),
   (10, 11, 3737, 1),
   (11, 11, 3737, 1),
   (1, 10, 3737, 1), 
   (2, 10, 3737, 1),
   (3, 10, 3737, 1),
   (4, 10, 3737, 1),
   (5, 10, 3737, 1),
   (6, 10, 3737, 1),
   (7, 10, 3737, 1),
   (8, 10, 3737, 1),
   (9, 10, 3737, 1),
   (10, 10, 3737, 1),
   (11, 10, 3737, 1),
   (1, 9, 3737, 1), 
   (2, 9, 3737, 1),
   (3, 9, 3737, 1),
   (4, 9, 3737, 1),
   (5, 9, 3737, 1),
   (6, 9, 3737, 1),
   (7, 9, 3737, 1),
   (8, 9, 3737, 1),
   (9, 9, 3737, 1),
   (10, 9, 3737, 1),
   (11, 9, 3737, 1),
   (1, 8, 3737, 1), 
   (2, 8, 3737, 1),
   (3, 8, 3737, 1),
   (4, 8, 3737, 1),
   (5, 8, 3737, 1),
   (6, 8, 3737, 1),
   (7, 8, 3737, 1),
   (8, 8, 3737, 1),
   (9, 8, 3737, 1),
   (10, 8, 3737, 1),
   (11, 8, 3737, 1),
   (1, 7, 3737, 1), 
   (2, 7, 3737, 1),
   (3, 7, 3737, 1),
   (4, 7, 3737, 1),
   (5, 7, 3737, 1),
   (6, 7, 3737, 1),
   (7, 7, 3737, 1),
   (8, 7, 3737, 1),
   (9, 7, 3737, 1),
   (10, 7, 3737, 1),
   (11, 7, 3737, 1),
   (1, 6, 3737, 1), 
   (2, 6, 3737, 1),
   (3, 6, 3737, 1),
   (4, 6, 3737, 1),
   (5, 6, 3737, 1),
   (6, 6, 3737, 1),
   (7, 6, 3737, 1),
   (8, 6, 3737, 1),
   (9, 6, 3737, 1),
   (10, 6, 3737, 1),
   (11, 6, 3737, 1),
   (1, 5, 3737, 1), 
   (2, 5, 3737, 1),
   (3, 5, 3737, 1),
   (4, 5, 3737, 1),
   (5, 5, 3737, 1),
   (6, 5, 3737, 1),
   (7, 5, 3737, 1),
   (8, 5, 3737, 1),
   (9, 5, 3737, 1),
   (10, 5, 3737, 1),
   (11, 5, 3737, 1),
   (1, 4, 3737, 1), 
   (2, 4, 3737, 1),
   (3, 4, 3737, 1),
   (4, 4, 3737, 1),
   (5, 4, 3737, 1),
   (6, 4, 3737, 1),
   (7, 4, 3737, 1),
   (8, 4, 3737, 1),
   (9, 4, 3737, 1),
   (10, 4, 3737, 1),
   (11, 4, 3737, 1),
   (1, 3, 3737, 1), 
   (2, 3, 3737, 1),
   (3, 3, 3737, 1),
   (4, 3, 3737, 1),
   (5, 3, 3737, 1),
   (6, 3, 3737, 1),
   (7, 3, 3737, 1),
   (8, 3, 3737, 1),
   (9, 3, 3737, 1),
   (10, 3, 3737, 1),
   (11, 3, 3737, 1),
   (1, 2, 3737, 1), 
   (2, 2, 3737, 1),
   (3, 2, 3737, 1),
   (4, 2, 3737, 1),
   (5, 2, 3737, 1),
   (6, 2, 3737, 1),
   (7, 2, 3737, 1),
   (8, 2, 3737, 1),
   (9, 2, 3737, 1),
   (10, 2, 3737, 1),
   (11, 2, 3737, 1),
   (1, 1, 3737, 1), 
   (2, 1, 3737, 1),
   (3, 1, 3737, 1),
   (4, 1, 3737, 1),
   (5, 1, 3737, 1),
   (6, 1, 3737, 1),
   (7, 1, 3737, 1),
   (8, 1, 3737, 1),
   (9, 1, 3737, 1),
   (10, 1, 3737, 1),
   (11, 1, 3737, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 29739, 1), 
   (2, 11, 29739, 1),
   (3, 11, 29739, 1),
   (4, 11, 29739, 1),
   (5, 11, 29739, 1),
   (6, 11, 29739, 1),
   (7, 11, 29739, 1),
   (8, 11, 29739, 1),
   (9, 11, 29739, 1),
   (10, 11, 29739, 1),
   (11, 11, 29739, 1),
   (1, 10, 29739, 1), 
   (2, 10, 29739, 1),
   (3, 10, 29739, 1),
   (4, 10, 29739, 1),
   (5, 10, 29739, 1),
   (6, 10, 29739, 1),
   (7, 10, 29739, 1),
   (8, 10, 29739, 1),
   (9, 10, 29739, 1),
   (10, 10, 29739, 1),
   (11, 10, 29739, 1),
   (1, 9, 29739, 1), 
   (2, 9, 29739, 1),
   (3, 9, 29739, 1),
   (4, 9, 29739, 1),
   (5, 9, 29739, 1),
   (6, 9, 29739, 1),
   (7, 9, 29739, 1),
   (8, 9, 29739, 1),
   (9, 9, 29739, 1),
   (10, 9, 29739, 1),
   (11, 9, 29739, 1),
   (1, 8, 29739, 1), 
   (2, 8, 29739, 1),
   (3, 8, 29739, 1),
   (4, 8, 29739, 1),
   (5, 8, 29739, 1),
   (6, 8, 29739, 1),
   (7, 8, 29739, 1),
   (8, 8, 29739, 1),
   (9, 8, 29739, 1),
   (10, 8, 29739, 1),
   (11, 8, 29739, 1),
   (1, 7, 29739, 1), 
   (2, 7, 29739, 1),
   (3, 7, 29739, 1),
   (4, 7, 29739, 1),
   (5, 7, 29739, 1),
   (6, 7, 29739, 1),
   (7, 7, 29739, 1),
   (8, 7, 29739, 1),
   (9, 7, 29739, 1),
   (10, 7, 29739, 1),
   (11, 7, 29739, 1),
   (1, 6, 29739, 1), 
   (2, 6, 29739, 1),
   (3, 6, 29739, 1),
   (4, 6, 29739, 1),
   (5, 6, 29739, 1),
   (6, 6, 29739, 1),
   (7, 6, 29739, 1),
   (8, 6, 29739, 1),
   (9, 6, 29739, 1),
   (10, 6, 29739, 1),
   (11, 6, 29739, 1),
   (1, 5, 29739, 1), 
   (2, 5, 29739, 1),
   (3, 5, 29739, 1),
   (4, 5, 29739, 1),
   (5, 5, 29739, 1),
   (6, 5, 29739, 1),
   (7, 5, 29739, 1),
   (8, 5, 29739, 1),
   (9, 5, 29739, 1),
   (10, 5, 29739, 1),
   (11, 5, 29739, 1),
   (1, 4, 29739, 1), 
   (2, 4, 29739, 1),
   (3, 4, 29739, 1),
   (4, 4, 29739, 1),
   (5, 4, 29739, 1),
   (6, 4, 29739, 1),
   (7, 4, 29739, 1),
   (8, 4, 29739, 1),
   (9, 4, 29739, 1),
   (10, 4, 29739, 1),
   (11, 4, 29739, 1),
   (1, 3, 29739, 1), 
   (2, 3, 29739, 1),
   (3, 3, 29739, 1),
   (4, 3, 29739, 1),
   (5, 3, 29739, 1),
   (6, 3, 29739, 1),
   (7, 3, 29739, 1),
   (8, 3, 29739, 1),
   (9, 3, 29739, 1),
   (10, 3, 29739, 1),
   (11, 3, 29739, 1),
   (1, 2, 29739, 1), 
   (2, 2, 29739, 1),
   (3, 2, 29739, 1),
   (4, 2, 29739, 1),
   (5, 2, 29739, 1),
   (6, 2, 29739, 1),
   (7, 2, 29739, 1),
   (8, 2, 29739, 1),
   (9, 2, 29739, 1),
   (10, 2, 29739, 1),
   (11, 2, 29739, 1),
   (1, 1, 29739, 1), 
   (2, 1, 29739, 1),
   (3, 1, 29739, 1),
   (4, 1, 29739, 1),
   (5, 1, 29739, 1),
   (6, 1, 29739, 1),
   (7, 1, 29739, 1),
   (8, 1, 29739, 1),
   (9, 1, 29739, 1),
   (10, 1, 29739, 1),
   (11, 1, 29739, 1);
   

INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 1, 48685, 1), 
   (2, 1, 48685, 1),
   (3, 1, 48685, 1),
   (4, 1, 48685, 1),
   (5, 1, 48685, 1),
   (6, 1, 48685, 1),
   (7, 1, 48685, 1),
   (8, 1, 48685, 1),
   (9, 1, 48685, 1),
   (10, 1, 48685, 1),
   (11, 1, 48685, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 1, 42949, 1), 
   (2, 1, 42949, 1),
   (3, 1, 42949, 1),
   (4, 1, 42949, 1),
   (5, 1, 42949, 1),
   (6, 1, 42949, 1),
   (7, 1, 42949, 1),
   (8, 1, 42949, 1),
   (9, 1, 42949, 1),
   (10, 1, 42949, 1),
   (11, 1, 42949, 1);

INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 1, 42992, 1), 
   (2, 1, 42992, 1),
   (3, 1, 42992, 1),
   (4, 1, 42992, 1),
   (5, 1, 42992, 1),
   (6, 1, 42992, 1),
   (7, 1, 42992, 1),
   (8, 1, 42992, 1),
   (9, 1, 42992, 1),
   (10, 1, 42992, 1),
   (11, 1, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 1, 42991, 1), 
   (2, 1, 42991, 1),
   (3, 1, 42991, 1),
   (4, 1, 42991, 1),
   (5, 1, 42991, 1),
   (6, 1, 42991, 1),
   (7, 1, 42991, 1),
   (8, 1, 42991, 1),
   (9, 1, 42991, 1),
   (10, 1, 42991, 1),
   (11, 1, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 1, 50255, 1), 
   (2, 1, 50255, 1),
   (3, 1, 50255, 1),
   (4, 1, 50255, 1),
   (5, 1, 50255, 1),
   (6, 1, 50255, 1),
   (7, 1, 50255, 1),
   (8, 1, 50255, 1),
   (9, 1, 50255, 1),
   (10, 1, 50255, 1),
   (11, 1, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 1, 44098, 1), 
   (2, 1, 44097, 1),
   (3, 1, 44098, 1),
   (4, 1, 44098, 1),
   (5, 1, 44097, 1),
   (6, 1, 44097, 1),
   (7, 1, 44098, 1),
   (8, 1, 44097, 1),
   (9, 1, 44097, 1),
   (10, 1, 44097, 1),
   (11, 1, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 1, 42943, 1), 
   (2, 1, 42943, 1),
   (3, 1, 42943, 1),
   (4, 1, 42943, 1),
   (5, 1, 42943, 1),
   (6, 1, 42943, 1),
   (7, 1, 42943, 1),
   (8, 1, 42943, 1),
   (9, 1, 42943, 1),
   (10, 1, 42943, 1),
   (11, 1, 42943, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 2, 48685, 1), 
   (2, 2, 48685, 1),
   (3, 2, 48685, 1),
   (4, 2, 48685, 1),
   (5, 2, 48685, 1),
   (6, 2, 48685, 1),
   (7, 2, 48685, 1),
   (8, 2, 48685, 1),
   (9, 2, 48685, 1),
   (10, 2, 48685, 1),
   (11, 2, 48685, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 2, 42949, 1), 
   (2, 2, 42949, 1),
   (3, 2, 42949, 1),
   (4, 2, 42949, 1),
   (5, 2, 42949, 1),
   (6, 2, 42949, 1),
   (7, 2, 42949, 1),
   (8, 2, 42949, 1),
   (9, 2, 42949, 1),
   (10, 2, 42949, 1),
   (11, 2, 42949, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 2, 42992, 1), 
   (2, 2, 42992, 1),
   (3, 2, 42992, 1),
   (4, 2, 42992, 1),
   (5, 2, 42992, 1),
   (6, 2, 42992, 1),
   (7, 2, 42992, 1),
   (8, 2, 42992, 1),
   (9, 2, 42992, 1),
   (10, 2, 42992, 1),
   (11, 2, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 2, 42991, 1), 
   (2, 2, 42991, 1),
   (3, 2, 42991, 1),
   (4, 2, 42991, 1),
   (5, 2, 42991, 1),
   (6, 2, 42991, 1),
   (7, 2, 42991, 1),
   (8, 2, 42991, 1),
   (9, 2, 42991, 1),
   (10, 2, 42991, 1),
   (11, 2, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 2, 50255, 1), 
   (2, 2, 50255, 1),
   (3, 2, 50255, 1),
   (4, 2, 50255, 1),
   (5, 2, 50255, 1),
   (6, 2, 50255, 1),
   (7, 2, 50255, 1),
   (8, 2, 50255, 1),
   (9, 2, 50255, 1),
   (10, 2, 50255, 1),
   (11, 2, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 2, 44098, 1), 
   (2, 2, 44097, 1),
   (3, 2, 44098, 1),
   (4, 2, 44098, 1),
   (5, 2, 44097, 1),
   (6, 2, 44097, 1),
   (7, 2, 44098, 1),
   (8, 2, 44097, 1),
   (9, 2, 44097, 1),
   (10, 2, 44097, 1),
   (11, 2, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 2, 44092, 1), 
   (2, 2, 44092, 1),
   (3, 2, 44092, 1),
   (4, 2, 44092, 1),
   (5, 2, 44092, 1),
   (6, 2, 44092, 1),
   (7, 2, 44092, 1),
   (8, 2, 44092, 1),
   (9, 2, 44092, 1),
   (10, 2, 44092, 1),
   (11, 2, 44092, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 3, 48689, 1), 
   (2, 3, 48689, 1),
   (3, 3, 48689, 1),
   (4, 3, 48689, 1),
   (5, 3, 48689, 1),
   (6, 3, 48689, 1),
   (7, 3, 48689, 1),
   (8, 3, 48689, 1),
   (9, 3, 48689, 1),
   (10, 3, 48689, 1),
   (11, 3, 48689, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 3, 42952, 1), 
   (2, 3, 42952, 1),
   (3, 3, 42952, 1),
   (4, 3, 42952, 1),
   (5, 3, 42952, 1),
   (6, 3, 42952, 1),
   (7, 3, 42952, 1),
   (8, 3, 42952, 1),
   (9, 3, 42952, 1),
   (10, 3, 42952, 1),
   (11, 3, 42952, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 3, 42992, 1), 
   (2, 3, 42992, 1),
   (3, 3, 42992, 1),
   (4, 3, 42992, 1),
   (5, 3, 42992, 1),
   (6, 3, 42992, 1),
   (7, 3, 42992, 1),
   (8, 3, 42992, 1),
   (9, 3, 42992, 1),
   (10, 3, 42992, 1),
   (11, 3, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 3, 42991, 1), 
   (2, 3, 42991, 1),
   (3, 3, 42991, 1),
   (4, 3, 42991, 1),
   (5, 3, 42991, 1),
   (6, 3, 42991, 1),
   (7, 3, 42991, 1),
   (8, 3, 42991, 1),
   (9, 3, 42991, 1),
   (10, 3, 42991, 1),
   (11, 3, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 3, 50255, 1), 
   (2, 3, 50255, 1),
   (3, 3, 50255, 1),
   (4, 3, 50255, 1),
   (5, 3, 50255, 1),
   (6, 3, 50255, 1),
   (7, 3, 50255, 1),
   (8, 3, 50255, 1),
   (9, 3, 50255, 1),
   (10, 3, 50255, 1),
   (11, 3, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 3, 44098, 1), 
   (2, 3, 44097, 1),
   (3, 3, 44098, 1),
   (4, 3, 44098, 1),
   (5, 3, 44097, 1),
   (6, 3, 44097, 1),
   (7, 3, 44098, 1),
   (8, 3, 44097, 1),
   (9, 3, 44097, 1),
   (10, 3, 44097, 1),
   (11, 3, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 3, 42946, 1), 
   (2, 3, 42946, 1),
   (3, 3, 42946, 1),
   (4, 3, 42946, 1),
   (5, 3, 42946, 1),
   (6, 3, 42946, 1),
   (7, 3, 42946, 1),
   (8, 3, 42946, 1),
   (9, 3, 42946, 1),
   (10, 3, 42946, 1),
   (11, 3, 42946, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 48689, 1), 
   (2, 4, 48689, 1),
   (3, 4, 48689, 1),
   (4, 4, 48689, 1),
   (5, 4, 48689, 1),
   (6, 4, 48689, 1),
   (7, 4, 48689, 1),
   (8, 4, 48689, 1),
   (9, 4, 48689, 1),
   (10, 4, 48689, 1),
   (11, 4, 48689, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 42952, 1), 
   (2, 4, 42952, 1),
   (3, 4, 42952, 1),
   (4, 4, 42952, 1),
   (5, 4, 42952, 1),
   (6, 4, 42952, 1),
   (7, 4, 42952, 1),
   (8, 4, 42952, 1),
   (9, 4, 42952, 1),
   (10, 4, 42952, 1),
   (11, 4, 42952, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 42992, 1), 
   (2, 4, 42992, 1),
   (3, 4, 42992, 1),
   (4, 4, 42992, 1),
   (5, 4, 42992, 1),
   (6, 4, 42992, 1),
   (7, 4, 42992, 1),
   (8, 4, 42992, 1),
   (9, 4, 42992, 1),
   (10, 4, 42992, 1),
   (11, 4, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 42991, 1), 
   (2, 4, 42991, 1),
   (3, 4, 42991, 1),
   (4, 4, 42991, 1),
   (5, 4, 42991, 1),
   (6, 4, 42991, 1),
   (7, 4, 42991, 1),
   (8, 4, 42991, 1),
   (9, 4, 42991, 1),
   (10, 4, 42991, 1),
   (11, 4, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 50255, 1), 
   (2, 4, 50255, 1),
   (3, 4, 50255, 1),
   (4, 4, 50255, 1),
   (5, 4, 50255, 1),
   (6, 4, 50255, 1),
   (7, 4, 50255, 1),
   (8, 4, 50255, 1),
   (9, 4, 50255, 1),
   (10, 4, 50255, 1),
   (11, 4, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 44098, 1), 
   (2, 4, 44097, 1),
   (3, 4, 44098, 1),
   (4, 4, 44098, 1),
   (5, 4, 44097, 1),
   (6, 4, 44097, 1),
   (7, 4, 44098, 1),
   (8, 4, 44097, 1),
   (9, 4, 44097, 1),
   (10, 4, 44097, 1),
   (11, 4, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 42944, 1), 
   (2, 4, 42944, 1),
   (3, 4, 42944, 1),
   (4, 4, 42944, 1),
   (5, 4, 42944, 1),
   (6, 4, 42944, 1),
   (7, 4, 42944, 1),
   (8, 4, 42944, 1),
   (9, 4, 42944, 1),
   (10, 4, 42944, 1),
   (11, 4, 42944, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 44091, 1), 
   (2, 4, 44091, 1),
   (3, 4, 44091, 1),
   (4, 4, 44091, 1),
   (5, 4, 44091, 1),
   (6, 4, 44091, 1),
   (7, 4, 44091, 1),
   (8, 4, 44091, 1),
   (9, 4, 44091, 1),
   (10, 4, 44091, 1),
   (11, 4, 44091, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 5, 48691, 1), 
   (2, 5, 48691, 1),
   (3, 5, 48691, 1),
   (4, 5, 48691, 1),
   (5, 5, 48691, 1),
   (6, 5, 48691, 1),
   (7, 5, 48691, 1),
   (8, 5, 48691, 1),
   (9, 5, 48691, 1),
   (10, 5, 48691, 1),
   (11, 5, 48691, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 5, 42985, 1), 
   (2, 5, 42985, 1),
   (3, 5, 42985, 1),
   (4, 5, 42985, 1),
   (5, 5, 42985, 1),
   (6, 5, 42985, 1),
   (7, 5, 42985, 1),
   (8, 5, 42985, 1),
   (9, 5, 42985, 1),
   (10, 5, 42985, 1),
   (11, 5, 42985, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 5, 42992, 1), 
   (2, 5, 42992, 1),
   (3, 5, 42992, 1),
   (4, 5, 42992, 1),
   (5, 5, 42992, 1),
   (6, 5, 42992, 1),
   (7, 5, 42992, 1),
   (8, 5, 42992, 1),
   (9, 5, 42992, 1),
   (10, 5, 42992, 1),
   (11, 5, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 5, 42991, 1), 
   (2, 5, 42991, 1),
   (3, 5, 42991, 1),
   (4, 5, 42991, 1),
   (5, 5, 42991, 1),
   (6, 5, 42991, 1),
   (7, 5, 42991, 1),
   (8, 5, 42991, 1),
   (9, 5, 42991, 1),
   (10, 5, 42991, 1),
   (11, 5, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 5, 50255, 1), 
   (2, 5, 50255, 1),
   (3, 5, 50255, 1),
   (4, 5, 50255, 1),
   (5, 5, 50255, 1),
   (6, 5, 50255, 1),
   (7, 5, 50255, 1),
   (8, 5, 50255, 1),
   (9, 5, 50255, 1),
   (10, 5, 50255, 1),
   (11, 5, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 5, 44098, 1), 
   (2, 5, 44097, 1),
   (3, 5, 44098, 1),
   (4, 5, 44098, 1),
   (5, 5, 44097, 1),
   (6, 5, 44097, 1),
   (7, 5, 44098, 1),
   (8, 5, 44097, 1),
   (9, 5, 44097, 1),
   (10, 5, 44097, 1),
   (11, 5, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 5, 42947, 1), 
   (2, 5, 42947, 1),
   (3, 5, 42947, 1),
   (4, 5, 42947, 1),
   (5, 5, 42947, 1),
   (6, 5, 42947, 1),
   (7, 5, 42947, 1),
   (8, 5, 42947, 1),
   (9, 5, 42947, 1),
   (10, 5, 42947, 1),
   (11, 5, 42947, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 6, 48685, 1), 
   (2, 6, 48685, 1),
   (3, 6, 48685, 1),
   (4, 6, 48685, 1),
   (5, 6, 48685, 1),
   (6, 6, 48685, 1),
   (7, 6, 48685, 1),
   (8, 6, 48685, 1),
   (9, 6, 48685, 1),
   (10, 6, 48685, 1),
   (11, 6, 48685, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 6, 42949, 1), 
   (2, 6, 42949, 1),
   (3, 6, 42949, 1),
   (4, 6, 42949, 1),
   (5, 6, 42949, 1),
   (6, 6, 42949, 1),
   (7, 6, 42949, 1),
   (8, 6, 42949, 1),
   (9, 6, 42949, 1),
   (10, 6, 42949, 1),
   (11, 6, 42949, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 6, 42992, 1), 
   (2, 6, 42992, 1),
   (3, 6, 42992, 1),
   (4, 6, 42992, 1),
   (5, 6, 42992, 1),
   (6, 6, 42992, 1),
   (7, 6, 42992, 1),
   (8, 6, 42992, 1),
   (9, 6, 42992, 1),
   (10, 6, 42992, 1),
   (11, 6, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 6, 42991, 1), 
   (2, 6, 42991, 1),
   (3, 6, 42991, 1),
   (4, 6, 42991, 1),
   (5, 6, 42991, 1),
   (6, 6, 42991, 1),
   (7, 6, 42991, 1),
   (8, 6, 42991, 1),
   (9, 6, 42991, 1),
   (10, 6, 42991, 1),
   (11, 6, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 6, 50255, 1), 
   (2, 6, 50255, 1),
   (3, 6, 50255, 1),
   (4, 6, 50255, 1),
   (5, 6, 50255, 1),
   (6, 6, 50255, 1),
   (7, 6, 50255, 1),
   (8, 6, 50255, 1),
   (9, 6, 50255, 1),
   (10, 6, 50255, 1),
   (11, 6, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 6, 44098, 1), 
   (2, 6, 44097, 1),
   (3, 6, 44098, 1),
   (4, 6, 44098, 1),
   (5, 6, 44097, 1),
   (6, 6, 44097, 1),
   (7, 6, 44098, 1),
   (8, 6, 44097, 1),
   (9, 6, 44097, 1),
   (10, 6, 44097, 1),
   (11, 6, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 6, 44092, 1), 
   (2, 6, 44092, 1),
   (3, 6, 44092, 1),
   (4, 6, 44092, 1),
   (5, 6, 44092, 1),
   (6, 6, 44092, 1),
   (7, 6, 44092, 1),
   (8, 6, 44092, 1),
   (9, 6, 44092, 1),
   (10, 6, 44092, 1),
   (11, 6, 44092, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 7, 48687, 1), 
   (2, 7, 48687, 1),
   (3, 7, 48687, 1),
   (4, 7, 48687, 1),
   (5, 7, 48687, 1),
   (6, 7, 48687, 1),
   (7, 7, 48687, 1),
   (8, 7, 48687, 1),
   (9, 7, 48687, 1),
   (10, 7, 48687, 1),
   (11, 7, 48687, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 7, 42984, 1), 
   (2, 7, 42984, 1),
   (3, 7, 42984, 1),
   (4, 7, 42984, 1),
   (5, 7, 42984, 1),
   (6, 7, 42984, 1),
   (7, 7, 42984, 1),
   (8, 7, 42984, 1),
   (9, 7, 42984, 1),
   (10, 7, 42984, 1),
   (11, 7, 42984, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 7, 42992, 1), 
   (2, 7, 42992, 1),
   (3, 7, 42992, 1),
   (4, 7, 42992, 1),
   (5, 7, 42992, 1),
   (6, 7, 42992, 1),
   (7, 7, 42992, 1),
   (8, 7, 42992, 1),
   (9, 7, 42992, 1),
   (10, 7, 42992, 1),
   (11, 7, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 7, 42991, 1), 
   (2, 7, 42991, 1),
   (3, 7, 42991, 1),
   (4, 7, 42991, 1),
   (5, 7, 42991, 1),
   (6, 7, 42991, 1),
   (7, 7, 42991, 1),
   (8, 7, 42991, 1),
   (9, 7, 42991, 1),
   (10, 7, 42991, 1),
   (11, 7, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 7, 50255, 1), 
   (2, 7, 50255, 1),
   (3, 7, 50255, 1),
   (4, 7, 50255, 1),
   (5, 7, 50255, 1),
   (6, 7, 50255, 1),
   (7, 7, 50255, 1),
   (8, 7, 50255, 1),
   (9, 7, 50255, 1),
   (10, 7, 50255, 1),
   (11, 7, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 7, 44098, 1), 
   (2, 7, 44097, 1),
   (3, 7, 44098, 1),
   (4, 7, 44098, 1),
   (5, 7, 44097, 1),
   (6, 7, 44097, 1),
   (7, 7, 44098, 1),
   (8, 7, 44097, 1),
   (9, 7, 44097, 1),
   (10, 7, 44097, 1),
   (11, 7, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 7, 42947, 1), 
   (2, 7, 42947, 1),
   (3, 7, 42947, 1),
   (4, 7, 42947, 1),
   (5, 7, 42947, 1),
   (6, 7, 42947, 1),
   (7, 7, 42947, 1),
   (8, 7, 42947, 1),
   (9, 7, 42947, 1),
   (10, 7, 42947, 1),
   (11, 7, 42947, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 8, 48691, 1), 
   (2, 8, 48691, 1),
   (3, 8, 48691, 1),
   (4, 8, 48691, 1),
   (5, 8, 48691, 1),
   (6, 8, 48691, 1),
   (7, 8, 48691, 1),
   (8, 8, 48691, 1),
   (9, 8, 48691, 1),
   (10, 8, 48691, 1),
   (11, 8, 48691, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 8, 42985, 1), 
   (2, 8, 42985, 1),
   (3, 8, 42985, 1),
   (4, 8, 42985, 1),
   (5, 8, 42985, 1),
   (6, 8, 42985, 1),
   (7, 8, 42985, 1),
   (8, 8, 42985, 1),
   (9, 8, 42985, 1),
   (10, 8, 42985, 1),
   (11, 8, 42985, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 8, 42992, 1), 
   (2, 8, 42992, 1),
   (3, 8, 42992, 1),
   (4, 8, 42992, 1),
   (5, 8, 42992, 1),
   (6, 8, 42992, 1),
   (7, 8, 42992, 1),
   (8, 8, 42992, 1),
   (9, 8, 42992, 1),
   (10, 8, 42992, 1),
   (11, 8, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 8, 42991, 1), 
   (2, 8, 42991, 1),
   (3, 8, 42991, 1),
   (4, 8, 42991, 1),
   (5, 8, 42991, 1),
   (6, 8, 42991, 1),
   (7, 8, 42991, 1),
   (8, 8, 42991, 1),
   (9, 8, 42991, 1),
   (10, 8, 42991, 1),
   (11, 8, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 8, 50255, 1), 
   (2, 8, 50255, 1),
   (3, 8, 50255, 1),
   (4, 8, 50255, 1),
   (5, 8, 50255, 1),
   (6, 8, 50255, 1),
   (7, 8, 50255, 1),
   (8, 8, 50255, 1),
   (9, 8, 50255, 1),
   (10, 8, 50255, 1),
   (11, 8, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 8, 44098, 1), 
   (2, 8, 44097, 1),
   (3, 8, 44098, 1),
   (4, 8, 44098, 1),
   (5, 8, 44097, 1),
   (6, 8, 44097, 1),
   (7, 8, 44098, 1),
   (8, 8, 44097, 1),
   (9, 8, 44097, 1),
   (10, 8, 44097, 1),
   (11, 8, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 8, 42947, 1), 
   (2, 8, 42947, 1),
   (3, 8, 42947, 1),
   (4, 8, 42947, 1),
   (5, 8, 42947, 1),
   (6, 8, 42947, 1),
   (7, 8, 42947, 1),
   (8, 8, 42947, 1),
   (9, 8, 42947, 1),
   (10, 8, 42947, 1),
   (11, 8, 42947, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 9, 48691, 1), 
   (2, 9, 48691, 1),
   (3, 9, 48691, 1),
   (4, 9, 48691, 1),
   (5, 9, 48691, 1),
   (6, 9, 48691, 1),
   (7, 9, 48691, 1),
   (8, 9, 48691, 1),
   (9, 9, 48691, 1),
   (10, 9, 48691, 1),
   (11, 9, 48691, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 9, 42985, 1), 
   (2, 9, 42985, 1),
   (3, 9, 42985, 1),
   (4, 9, 42985, 1),
   (5, 9, 42985, 1),
   (6, 9, 42985, 1),
   (7, 9, 42985, 1),
   (8, 9, 42985, 1),
   (9, 9, 42985, 1),
   (10, 9, 42985, 1),
   (11, 9, 42985, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 9, 42992, 1), 
   (2, 9, 42992, 1),
   (3, 9, 42992, 1),
   (4, 9, 42992, 1),
   (5, 9, 42992, 1),
   (6, 9, 42992, 1),
   (7, 9, 42992, 1),
   (8, 9, 42992, 1),
   (9, 9, 42992, 1),
   (10, 9, 42992, 1),
   (11, 9, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 9, 42991, 1), 
   (2, 9, 42991, 1),
   (3, 9, 42991, 1),
   (4, 9, 42991, 1),
   (5, 9, 42991, 1),
   (6, 9, 42991, 1),
   (7, 9, 42991, 1),
   (8, 9, 42991, 1),
   (9, 9, 42991, 1),
   (10, 9, 42991, 1),
   (11, 9, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 9, 50255, 1), 
   (2, 9, 50255, 1),
   (3, 9, 50255, 1),
   (4, 9, 50255, 1),
   (5, 9, 50255, 1),
   (6, 9, 50255, 1),
   (7, 9, 50255, 1),
   (8, 9, 50255, 1),
   (9, 9, 50255, 1),
   (10, 9, 50255, 1),
   (11, 9, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 9, 44098, 1), 
   (2, 9, 44097, 1),
   (3, 9, 44098, 1),
   (4, 9, 44098, 1),
   (5, 9, 44097, 1),
   (6, 9, 44097, 1),
   (7, 9, 44098, 1),
   (8, 9, 44097, 1),
   (9, 9, 44097, 1),
   (10, 9, 44097, 1),
   (11, 9, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 9, 42947, 1), 
   (2, 9, 42947, 1),
   (3, 9, 42947, 1),
   (4, 9, 42947, 1),
   (5, 9, 42947, 1),
   (6, 9, 42947, 1),
   (7, 9, 42947, 1),
   (8, 9, 42947, 1),
   (9, 9, 42947, 1),
   (10, 9, 42947, 1),
   (11, 9, 42947, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 48687, 1), 
   (2, 11, 48687, 1),
   (3, 11, 48687, 1),
   (4, 11, 48687, 1),
   (5, 11, 48687, 1),
   (6, 11, 48687, 1),
   (7, 11, 48687, 1),
   (8, 11, 48687, 1),
   (9, 11, 48687, 1),
   (10, 11, 48687, 1),
   (11, 11, 48687, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 42984, 1), 
   (2, 11, 42984, 1),
   (3, 11, 42984, 1),
   (4, 11, 42984, 1),
   (5, 11, 42984, 1),
   (6, 11, 42984, 1),
   (7, 11, 42984, 1),
   (8, 11, 42984, 1),
   (9, 11, 42984, 1),
   (10, 11, 42984, 1),
   (11, 11, 42984, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 42992, 1), 
   (2, 11, 42992, 1),
   (3, 11, 42992, 1),
   (4, 11, 42992, 1),
   (5, 11, 42992, 1),
   (6, 11, 42992, 1),
   (7, 11, 42992, 1),
   (8, 11, 42992, 1),
   (9, 11, 42992, 1),
   (10, 11, 42992, 1),
   (11, 11, 42992, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 42991, 1), 
   (2, 11, 42991, 1),
   (3, 11, 42991, 1),
   (4, 11, 42991, 1),
   (5, 11, 42991, 1),
   (6, 11, 42991, 1),
   (7, 11, 42991, 1),
   (8, 11, 42991, 1),
   (9, 11, 42991, 1),
   (10, 11, 42991, 1),
   (11, 11, 42991, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 50255, 1), 
   (2, 11, 50255, 1),
   (3, 11, 50255, 1),
   (4, 11, 50255, 1),
   (5, 11, 50255, 1),
   (6, 11, 50255, 1),
   (7, 11, 50255, 1),
   (8, 11, 50255, 1),
   (9, 11, 50255, 1),
   (10, 11, 50255, 1),
   (11, 11, 50255, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 44098, 1), 
   (2, 11, 44097, 1),
   (3, 11, 44098, 1),
   (4, 11, 44098, 1),
   (5, 11, 44097, 1),
   (6, 11, 44097, 1),
   (7, 11, 44098, 1),
   (8, 11, 44097, 1),
   (9, 11, 44097, 1),
   (10, 11, 44097, 1),
   (11, 11, 44098, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 42947, 1), 
   (2, 11, 42947, 1),
   (3, 11, 42947, 1),
   (4, 11, 42947, 1),
   (5, 11, 42947, 1),
   (6, 11, 42947, 1),
   (7, 11, 42947, 1),
   (8, 11, 42947, 1),
   (9, 11, 42947, 1),
   (10, 11, 42947, 1),
   (11, 11, 42947, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 1, 933, 4), 
   (2, 1, 933, 4),
   (3, 1, 933, 4),
   (4, 1, 933, 4),
   (5, 1, 933, 4),
   (6, 1, 933, 4),
   (7, 1, 933, 4),
   (8, 1, 933, 4),
   (9, 1, 933, 4),
   (10, 1, 933, 4),
   (11, 1, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 2, 933, 4), 
   (2, 2, 933, 4),
   (3, 2, 933, 4),
   (4, 2, 933, 4),
   (5, 2, 933, 4),
   (6, 2, 933, 4),
   (7, 2, 933, 4),
   (8, 2, 933, 4),
   (9, 2, 933, 4),
   (10, 2, 933, 4),
   (11, 2, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 3, 933, 4), 
   (2, 3, 933, 4),
   (3, 3, 933, 4),
   (4, 3, 933, 4),
   (5, 3, 933, 4),
   (6, 3, 933, 4),
   (7, 3, 933, 4),
   (8, 3, 933, 4),
   (9, 3, 933, 4),
   (10, 3, 933, 4),
   (11, 3, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 933, 4), 
   (2, 4, 933, 4),
   (3, 4, 933, 4),
   (4, 4, 933, 4),
   (5, 4, 933, 4),
   (6, 4, 933, 4),
   (7, 4, 933, 4),
   (8, 4, 933, 4),
   (9, 4, 933, 4),
   (10, 4, 933, 4),
   (11, 4, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 5, 933, 4), 
   (2, 5, 933, 4),
   (3, 5, 933, 4),
   (4, 5, 933, 4),
   (5, 5, 933, 4),
   (6, 5, 933, 4),
   (7, 5, 933, 4),
   (8, 5, 933, 4),
   (9, 5, 933, 4),
   (10, 5, 933, 4),
   (11, 5, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 6, 933, 4), 
   (2, 6, 933, 4),
   (3, 6, 933, 4),
   (4, 6, 933, 4),
   (5, 6, 933, 4),
   (6, 6, 933, 4),
   (7, 6, 933, 4),
   (8, 6, 933, 4),
   (9, 6, 933, 4),
   (10, 6, 933, 4),
   (11, 6, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 7, 933, 4), 
   (2, 7, 933, 4),
   (3, 7, 933, 4),
   (4, 7, 933, 4),
   (5, 7, 933, 4),
   (6, 7, 933, 4),
   (7, 7, 933, 4),
   (8, 7, 933, 4),
   (9, 7, 933, 4),
   (10, 7, 933, 4),
   (11, 7, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 8, 933, 4), 
   (2, 8, 933, 4),
   (3, 8, 933, 4),
   (4, 8, 933, 4),
   (5, 8, 933, 4),
   (6, 8, 933, 4),
   (7, 8, 933, 4),
   (8, 8, 933, 4),
   (9, 8, 933, 4),
   (10, 8, 933, 4),
   (11, 8, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 9, 933, 4), 
   (2, 9, 933, 4),
   (3, 9, 933, 4),
   (4, 9, 933, 4),
   (5, 9, 933, 4),
   (6, 9, 933, 4),
   (7, 9, 933, 4),
   (8, 9, 933, 4),
   (9, 9, 933, 4),
   (10, 9, 933, 4),
   (11, 9, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 933, 4), 
   (2, 11, 933, 4),
   (3, 11, 933, 4),
   (4, 11, 933, 4),
   (5, 11, 933, 4),
   (6, 11, 933, 4),
   (7, 11, 933, 4),
   (8, 11, 933, 4),
   (9, 11, 933, 4),
   (10, 11, 933, 4),
   (11, 11, 933, 4);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 1, 5656, 1), 
   (2, 1, 5668, 1),
   (3, 1, 5656, 1),
   (4, 1, 5656, 1),
   (5, 1, 5668, 1),
   (6, 1, 5668, 1),
   (7, 1, 5656, 1),
   (8, 1, 5668, 1),
   (9, 1, 5668, 1),
   (10, 1, 5668, 1),
   (11, 1, 5656, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 2, 5656, 1), 
   (2, 2, 5668, 1),
   (3, 2, 5656, 1),
   (4, 2, 5656, 1),
   (5, 2, 5668, 1),
   (6, 2, 5668, 1),
   (7, 2, 5656, 1),
   (8, 2, 5668, 1),
   (9, 2, 5668, 1),
   (10, 2, 5668, 1),
   (11, 2, 5656, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 3, 5656, 1), 
   (2, 3, 5668, 1),
   (3, 3, 5656, 1),
   (4, 3, 5656, 1),
   (5, 3, 5668, 1),
   (6, 3, 5668, 1),
   (7, 3, 5656, 1),
   (8, 3, 5668, 1),
   (9, 3, 5668, 1),
   (10, 3, 5668, 1),
   (11, 3, 5656, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 4, 5656, 1), 
   (2, 4, 5668, 1),
   (3, 4, 5656, 1),
   (4, 4, 5656, 1),
   (5, 4, 5668, 1),
   (6, 4, 5668, 1),
   (7, 4, 5656, 1),
   (8, 4, 5668, 1),
   (9, 4, 5668, 1),
   (10, 4, 5668, 1),
   (11, 4, 5656, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 5, 5656, 1), 
   (2, 5, 5668, 1),
   (3, 5, 5656, 1),
   (4, 5, 5656, 1),
   (5, 5, 5668, 1),
   (6, 5, 5668, 1),
   (7, 5, 5656, 1),
   (8, 5, 5668, 1),
   (9, 5, 5668, 1),
   (10, 5, 5668, 1),
   (11, 5, 5656, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 6, 5656, 1), 
   (2, 6, 5668, 1),
   (3, 6, 5656, 1),
   (4, 6, 5656, 1),
   (5, 6, 5668, 1),
   (6, 6, 5668, 1),
   (7, 6, 5656, 1),
   (8, 6, 5668, 1),
   (9, 6, 5668, 1),
   (10, 6, 5668, 1),
   (11, 6, 5656, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 7, 5656, 1), 
   (2, 7, 5668, 1),
   (3, 7, 5656, 1),
   (4, 7, 5656, 1),
   (5, 7, 5668, 1),
   (6, 7, 5668, 1),
   (7, 7, 5656, 1),
   (8, 7, 5668, 1),
   (9, 7, 5668, 1),
   (10, 7, 5668, 1),
   (11, 7, 5656, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 8, 5656, 1), 
   (2, 8, 5668, 1),
   (3, 8, 5656, 1),
   (4, 8, 5656, 1),
   (5, 8, 5668, 1),
   (6, 8, 5668, 1),
   (7, 8, 5656, 1),
   (8, 8, 5668, 1),
   (9, 8, 5668, 1),
   (10, 8, 5668, 1),
   (11, 8, 5656, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 9, 5656, 1), 
   (2, 9, 5668, 1),
   (3, 9, 5656, 1),
   (4, 9, 5656, 1),
   (5, 9, 5668, 1),
   (6, 9, 5668, 1),
   (7, 9, 5656, 1),
   (8, 9, 5668, 1),
   (9, 9, 5668, 1),
   (10, 9, 5668, 1),
   (11, 9, 5656, 1);
   
INSERT INTO `world`.`playercreateinfo_item`
   (`race`, `class`, `itemid`, `amount`)
VALUES
   (1, 11, 5656, 1), 
   (2, 11, 5668, 1),
   (3, 11, 5656, 1),
   (4, 11, 5656, 1),
   (5, 11, 5668, 1),
   (6, 11, 5668, 1),
   (7, 11, 5656, 1),
   (8, 11, 5668, 1),
   (9, 11, 5668, 1),
   (10, 11, 5668, 1),
   (11, 11, 5656, 1);


/* 假玩家功能 */
REPLACE INTO `world`.`trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (12001, 'Message: "Do not disturb".', NULL, NULL, NULL, '该玩家正忙', '該玩家忙碌中', NULL, NULL, 'РЎРѕРѕР±С‰РµРЅРёРµ: "РќРµ Р±РµСЃРїРѕРєРѕРёС‚СЊ".');


				
insert into `characters`.`fake_zones` (`zone`,`level`) values
(439,30),(33,30),(331,30),(405,30),(45,30),(36,30),
(47,40),(440,40),(357,40),(15,40),
(28,50),(139,50),(361,50),(46,50),(51,50),(490,50),(618,50),(1377,50), 
(3483,60),(3520,60),(3523,60),(3519,60),(3521,60),(3522,60),(3526,60),
(3537,70),(65,70),(66,70),(394,70),(4523,70),(4522,70),(67,70),(68,70),(69,70);
 
INSERT INTO `characters_fake` (`name`, `race`, `class`, `level`, `zone`, `gender`, `online`, `lastup`) VALUES
('Luz Maxwell', 2, 8, 53, 22, 0, '2016-08-08 19:16:00', '2016-08-08 16:22:37'),
('Trump', 3, 4, 55, 20, 0, '2016-08-08 21:27:44', '2016-08-08 16:22:37'),
('Drew Henry', 10, 2, 55,18, 1, '2016-08-08 14:14:01', '2016-08-08 16:22:37'),
('Alonzo Armstrong', 10, 2, 65, 45, 0, '2016-08-08 21:15:47', '2016-08-08 16:22:37'),
('Stephanie Morales', 1, 1, 64, 32, 1, '2016-08-08 11:51:35', '2016-08-08 18:19:40'),
('Fanroag', 5, 1, 63, 23, 0, '2016-08-08 14:29:51', '2016-08-08 16:22:37'),
('Jovan', 10, 2, 63, 18, 0, '2016-08-08 04:24:43', '2016-08-08 23:49:06'),
('Cemiru', 1, 2, 73, 22, 1, '2016-08-08 12:45:17', '2016-08-08 15:56:40'),
('Thoir', 1, 1, 56, 6, 1, '2016-08-08 05:43:07', '2016-08-08 16:22:37'),
('Brair', 3, 2, 53, 15, 1, '2016-08-08 21:15:13', '2016-08-08 16:22:37'),
('Matanaar', 4, 3, 65, 3, 1, '2016-08-08 13:09:17', '2016-08-08 15:07:46'),
('Ocnaar', 5, 1, 73, 22, 0, '2016-08-08 06:12:15', '2016-08-08 16:22:37'),
('Talaid', 4, 11, 63, 1, 0, '2016-08-08 21:23:45', '2016-08-08 15:02:50'),
('Artfas', 1, 2, 76, 40, 0, '2016-08-08 04:50:43', '2016-08-08 16:22:37'),
('Nahan', 4, 1, 64, 43, 0, '2016-08-08 17:54:05', '2016-08-08 19:59:12'),
('Gromgurn Froststone', 6, 11, 41, 45, 0, '2016-08-08 11:46:37', '2016-08-08 20:18:07'),
('Hulfohmyr Hammercrag', 5, 9, 75, 45, 0, '2016-08-08 22:02:27', '2016-08-08 14:35:01'),
('Gimdram Steelmane', 3, 5, 62, 39, 0, '2016-08-08 10:15:35', '2016-08-08 17:53:00'),
('Grummand Firetoe', 2, 1, 52, 11, 0, '2016-08-08 03:03:05', '2016-08-08 14:10:08'),
('Thymyl Stormhand', 6, 11, 53, 38, 1, '2016-08-08 15:51:15', '2016-08-08 13:15:21'),
('Brummir Longbrand', 8, 4, 65, 5, 0, '2016-08-08 13:17:54', '2016-08-08 18:13:53'),
('Gryitharm Stormbreaker', 5, 6, 57, 12, 0, '2016-08-08 09:21:15', '2016-08-08 16:22:37'),
('Gimnir Mountainmantle', 4, 4, 65, 22, 0, '2016-08-08 08:06:03', '2016-08-08 14:25:07'),
('Hjalgus Barleybrow', 2, 5, 72, 39, 1, '2016-08-08 09:16:03', '2016-08-08 14:25:07'),
('Balnum Bronzehelm', 1, 2, 65, 43, 0, '2016-08-08 09:36:03', '2016-08-08 14:25:07'),
('Reyniathiel Cliffhand', 3, 9, 52, 12, 1, '2016-08-08 10:26:03', '2016-08-08 14:25:07'),
('Dimnia Coldtoe', 2, 4, 65, 5, 1, '2016-08-08 10:06:03', '2016-08-08 14:25:07'),
('Lassamlin Ironhammer', 5, 11, 65, 12, 1, '2016-08-08 10:06:03', '2016-08-08 14:25:07'),
('Brollamwhin Stoneroar', 6, 11, 55, 3, 1, '2016-08-08 10:56:03', '2016-08-08 14:25:07'),
('Runanlyl Bouldergrip', 4, 3, 71, 40, 1, '2016-08-08 11:46:03', '2016-08-08 14:25:07'),
('Ungorras Fusebraid', 10, 2, 65, 45, 0, '2016-08-08 11:06:03', '2016-08-08 14:25:07'),
('Rynahlinn Frosthammer', 3, 5, 73, 3, 0, '2016-08-08 11:16:03', '2016-08-08 14:25:07'),
('Ingros Blackhand', 4, 1, 55, 11, 1, '2016-08-08 13:06:03', '2016-08-08 14:25:07'),
('Nessamniss Moltenbranch', 2, 1, 75, 3, 0, '2016-08-08 13:26:03', '2016-08-08 14:25:07'),
('Lokeetonk', 3, 5, 65, 38, 1, '2016-08-08 13:06:03', '2016-08-08 14:25:07'),
('Berryspanner', 1, 1, 43,11,1, '2016-08-08 13:33:03', '2016-08-08 14:25:07'),
('Bobick', 4, 11, 63, 5, 1, '2016-08-08 13:11:03', '2016-08-08 14:25:07'),
('Portersteel', 1, 2, 52, 20, 0, '2016-08-08 13:06:03', '2016-08-08 14:25:07'),
('Nittleklink Fizzlefizz', 6, 11, 61, 45, 1, '2016-08-08 14:16:03', '2016-08-08 14:25:07'),
('Klovizz', 5, 1, 57, 22, 1, '2016-08-08 14:55:03', '2016-08-08 14:25:07'),
('Porterspan', 1, 2, 55, 38, 1, '2016-08-08 14:44:03', '2016-08-08 14:25:07'),
('Dinkkatank', 1, 3, 63, 1, 0, '2016-08-08 14:54:03', '2016-08-08 14:25:07'),
('Draxlekettle', 1, 4, 62, 40, 0, '2016-08-08 15:43:03', '2016-08-08 14:25:07'),
('Glimthin', 3, 5, 69, 5, 1, '2016-08-08 15:23:03', '2016-08-08 14:25:07'),
('Twistbang', 3, 5, 41, 38, 1, '2016-08-08 15:06:03', '2016-08-08 14:25:07'),
('Bintink', 10, 2, 75, 38, 0, '2016-08-08 16:06:03', '2016-08-08 14:25:07'),
('Grindpipe', 10, 9, 54, 57, 1, '2016-08-08 16:12:03', '2016-08-08 14:25:07'),
('Dibobik', 5, 3, 51, 39, 0, '2016-08-08 16:06:03', '2016-08-08 14:25:07'),
('Finefizz', 6, 11, 61, 39, 1, '2016-08-08 16:33:03', '2016-08-08 14:25:07'),
('Gnokarn', 6, 9, 43,11,0, '2016-08-08 16:11:03', '2016-08-08 14:25:07'),
('Overgear', 6, 3, 35, 20, 1, '2016-08-08 17:54:03', '2016-08-08 14:25:07'),
('Nittledabink Stormspindle', 5, 1, 55, 1, 1, '2016-08-08 17:06:03', '2016-08-08 14:25:07'),
('Gelvizz', 5, 4, 44, 57, 0, '2016-08-08 17:33:03', '2016-08-08 14:25:07'),
('Shinefizzle', 4, 1, 64,11,1, '2016-08-08 17:06:03', '2016-08-08 14:25:07'),
('Glinlawizz Portergauge', 4, 3, 63, 5, 1, '2016-08-08 18:06:03', '2016-08-08 14:25:07'),
('Teenwack Grindspanner', 4, 4, 46, 20, 0, '2016-08-08 18:06:03', '2016-08-08 14:25:07'),
('Tynbick Berryspring', 4, 5, 37, 12, 0, '2016-08-08 18:55:03', '2016-08-08 14:25:07'),
('Loklink Porterblast', 4, 11, 65, 1, 1, '2016-08-08 18:36:03', '2016-08-08 14:25:07'),
('Elwick Clickkettle', 2, 1, 51, 57, 1, '2016-08-08 18:26:03', '2016-08-08 14:25:07'),
('Klolibik', 2, 3, 65, 62, 1, '2016-08-08 19:06:03', '2016-08-08 14:25:07'),
('Finehouse', 2, 4, 65, 12, 0, '2016-08-08 19:06:03', '2016-08-08 14:25:07'),
('Tinkadink', 2, 5, 37, 57, 1, '2016-08-08 19:56:03', '2016-08-08 14:25:07'),
('Clickbus', 2, 11, 57, 45, 1, '2016-08-08 19:46:03', '2016-08-08 14:25:07'),
('Filtonk', 1, 2, 55, 12, 0, '2016-08-08 19:06:03', '2016-08-08 14:25:07'),
('Mekkawhistle', 1, 3, 54, 57, 1, '2016-08-08 20:16:03', '2016-08-08 14:25:07'),
('Donbeeble', 1, 4, 58, 45, 1, '2016-08-08 20:06:03', '2016-08-08 14:25:07'),
('Porterspring', 1, 5, 64, 5, 0, '2016-08-08 20:26:03', '2016-08-08 14:25:07'),
('Burago Castdwadle', 1, 9, 65, 12, 1, '2016-08-08 20:06:03', '2016-08-08 14:25:07'),
('Bonbeeash Mekkasprocket', 1, 11, 67, 20, 1, '2016-08-08 20:33:03', '2016-08-08 14:25:07'),
('Mittlevizz Shineblast', 4, 4, 65, 45, 0, '2016-08-08 21:06:03', '2016-08-08 14:25:07'),
('Lakink', 2, 5, 62, 30, 1, '2016-08-08 21:16:03', '2016-08-08 14:25:07'),
('Sadspan', 1, 2, 65, 43, 0, '2016-08-08 21:36:03', '2016-08-08 14:25:07'),
('Pithkomac', 3, 9, 52, 1, 1, '2016-08-08 21:26:03', '2016-08-08 14:25:07'),
('Stormspark', 2, 4, 55, 5, 1, '2016-08-08 21:06:03', '2016-08-08 14:25:07'),
('Draxlefizzle', 5, 11, 65, 43, 1, '2016-08-08 22:06:03', '2016-08-08 14:25:07'),
('Shortspinner', 6, 11, 75, 5, 1, '2016-08-08 22:56:03', '2016-08-08 14:25:07'),
('Fastbang', 4, 3, 61, 40, 1, '2016-08-08 22:46:03', '2016-08-08 14:25:07'),
('Thistlespinner', 10, 2, 65, 45, 0, '2016-08-08 22:06:03', '2016-08-08 14:25:07'),
('Spannerkettle', 3, 5, 43, 3, 0, '2016-08-08 22:16:03', '2016-08-08 14:25:07'),
('Pick a world', 4, 1, 55, 11, 1, '2016-08-08 23:06:03', '2016-08-08 14:25:07'),
('Jaeden Reed', 2, 1, 65, 5, 0, '2016-08-08 23:26:03', '2016-08-08 14:25:07'),
('Smithies', 3, 5, 65, 38, 1, '2016-08-08 23:06:03', '2016-08-08 14:25:07'),
('Buckley', 1, 1, 63,11,1, '2016-08-08 23:33:03', '2016-08-08 14:25:07'),
('Leo Thorne', 4, 11, 63, 5, 1, '2016-08-08 23:11:03', '2016-08-08 14:25:07'),
('René Berkeley', 1, 2, 62, 20, 0, '2016-08-08 1:06:03', '2016-08-08 14:25:07'),
('Jeoffroi Clare', 6, 11, 51, 45, 1, '2016-08-08 1:16:03', '2016-08-08 14:25:07'),
('Paxon Copeland', 5, 1, 57, 45, 1, '2016-08-08 1:55:03', '2016-08-08 14:25:07'),
('Mika Alden', 1, 2, 65, 5, 1, '2016-08-08 2:44:03', '2016-08-08 14:25:07'),
('Ashton', 1, 3, 63, 1, 0, '2016-08-08 2:54:03', '2016-08-08 14:25:07'),
('GoBusters', 1, 4, 72, 40, 0, '2016-08-08 3:43:03', '2016-08-08 14:25:07'),
('Wheatley', 3, 5, 69, 5, 1, '2016-08-08 3:23:03', '2016-08-08 14:25:07'),
('Stafford', 3, 5, 41, 1, 1, '2016-08-08 4:06:03', '2016-08-08 14:25:07'),
('Baxter', 10, 2, 45, 38, 0, '2016-08-08 4:06:03', '2016-08-08 14:25:07'),
('Bradford', 10, 9, 54, 57, 1, '2016-08-08 5:12:03', '2016-08-08 14:25:07'),
('Addington', 5, 3, 51, 39, 0, '2016-08-08 6:06:03', '2016-08-08 14:25:07'),
('Morton', 6, 11, 41, 39, 1, '2016-08-08 6:33:03', '2016-08-08 14:25:07'),
('Gaspard', 6, 9, 33, 6, 0, '2016-08-08 6:11:03', '2016-08-08 14:25:07'),
('Clapham', 6, 3, 35, 20, 1, '2016-08-08 7:54:03', '2016-08-08 14:25:07'),
('Kurt Sherman', 5, 1, 35, 20, 1, '2016-08-08 7:06:03', '2016-08-08 14:25:07'),
('Blade Langley', 5, 4, 44, 57, 0, '2016-08-08 7:33:03', '2016-08-08 14:25:07'),
('Leladaern', 4, 1, 64, 6, 1, '2016-08-08 8:06:03', '2016-08-08 14:25:07'),
('Featherbreath', 4, 3, 33, 5, 1, '2016-08-08 21:06:03', '2016-08-08 14:25:07'),
('Alyaedan', 4, 4, 46, 20, 0, '2016-08-08 21:06:03', '2016-08-08 14:25:07'),
('Bladeswift', 4, 5, 37, 12, 0, '2016-08-08 8:55:03', '2016-08-08 14:25:07'),
('Syelar Amberoak', 4, 11, 35, 1, 1, '2016-08-08 20:36:03', '2016-08-08 14:25:07'),
('Lyaeleath Summerwater', 2, 1, 31, 12, 1, '2016-08-08 22:26:03', '2016-08-08 14:25:07'),
('Saellor', 2, 3, 25, 62, 1, '2016-08-08 22:06:03', '2016-08-08 14:25:07'),
('Strongmoon', 2, 4, 35, 12, 0, '2016-08-08 23:06:03', '2016-08-08 14:25:07'),
('Uyfdren', 2, 5, 37, 57, 1, '2016-08-08 20:56:03', '2016-08-08 14:25:07'),
('Nightswift', 2, 11, 67, 45, 1, '2016-08-08 19:46:03', '2016-08-08 14:25:07'),
('Mytidrus', 1, 2, 35, 12, 0, '2016-08-08 19:06:03', '2016-08-08 14:25:07'),
('Rainshadow', 1, 3, 37, 45, 1, '2016-08-08 20:16:03', '2016-08-08 14:25:07'),
('Esrennas Winterseeker', 1, 4, 38, 45, 1, '2016-08-08 20:06:03', '2016-08-08 14:25:07'),
('Anandras', 1, 5, 64, 5, 0, '2016-08-08 20:26:03', '2016-08-08 14:25:07'),
('Wintergazer', 1, 9, 55, 12, 1, '2016-08-08 20:06:03', '2016-08-08 14:25:07'),
('Amfeanai', 1, 11, 57, 20, 1, '2016-08-08 20:33:03', '2016-08-08 14:25:07'),


('Stillmane', 2, 8, 53, 20, 0, '2016-08-08 19:16:00', '2016-08-08 16:22:37'),
('Dawnhelm', 3, 4, 45, 20, 0, '2016-08-08 21:27:44', '2016-08-08 16:22:37'),
('Ravenwatcher', 10, 2, 55,18, 1, '2016-08-08 14:14:01', '2016-08-08 16:22:37'),
('Featherrunner', 10, 2, 55, 45, 0, '2016-08-08 21:15:47', '2016-08-08 16:22:37'),
('Shieldshade', 1, 1, 44, 32, 1, '2016-08-08 11:51:35', '2016-08-08 18:19:40'),
('Silentbow', 5, 1, 43, 23, 0, '2016-08-08 14:29:51', '2016-08-08 16:22:37'),
('Steve Jobs', 10, 2, 43, 18, 0, '2016-08-08 04:24:43', '2016-08-08 23:49:06'),
('Bill Gates', 1, 2, 43, 18, 1, '2016-08-08 12:45:17', '2016-08-08 15:56:40'),
('Jack Ma', 1, 1, 56, 6, 1, '2016-08-08 05:43:07', '2016-08-08 16:22:37'),
('Hold your sorrow', 3, 2, 53, 15, 1, '2016-08-08 21:15:13', '2016-08-08 16:22:37'),
('Amberstriker', 4, 3, 65, 3, 1, '2016-08-08 13:09:17', '2016-08-08 15:07:46'),
('Duskblade', 5, 1, 53, 18, 0, '2016-08-08 06:12:15', '2016-08-08 16:22:37'),
('Chairman', 4, 11, 43, 1, 0, '2016-08-08 21:23:45', '2016-08-08 15:02:50'),
('Mosssong', 1, 2, 46, 40, 0, '2016-08-08 04:50:43', '2016-08-08 16:22:37'),
('Ylaenia', 4, 1, 64, 43, 0, '2016-08-08 17:54:05', '2016-08-08 19:59:12'),
('Keanas', 6, 11, 51, 45, 0, '2016-08-08 11:46:37', '2016-08-08 20:18:07'),
('Fydrieth', 5, 9, 45, 45, 0, '2016-08-08 22:02:27', '2016-08-08 14:35:01'),
('Ylyssae', 3, 5, 52, 39, 0, '2016-08-08 10:15:35', '2016-08-08 17:53:00'),
('Haenna', 2, 1, 62, 11, 0, '2016-08-08 03:03:05', '2016-08-08 14:10:08'),
('Thileyssa', 6, 11, 53, 38, 1, '2016-08-08 15:51:15', '2016-08-08 13:15:21'),
('Continue alone', 8, 4, 65, 5, 0, '2016-08-08 13:17:54', '2016-08-08 18:13:53'),
('Hero Legend', 5, 6, 57, 12, 0, '2016-08-08 09:21:15', '2016-08-08 16:22:37'),
('Punk Dream', 4, 4, 55, 45, 0, '2016-08-08 08:06:03', '2016-08-08 14:25:07'),
('Elijah', 2, 5, 62, 45, 1, '2016-08-08 09:16:03', '2016-08-08 14:25:07'),
('Theodore', 1, 2, 65, 43, 0, '2016-08-08 09:36:03', '2016-08-08 14:25:07'),
('Evil Again', 3, 9, 52, 43, 1, '2016-08-08 10:26:03', '2016-08-08 14:25:07'),
('m1n9', 2, 4, 55, 40, 1, '2016-08-08 10:06:03', '2016-08-08 14:25:07'),
('Jaylen Chatham', 5, 11, 45, 18, 1, '2016-08-08 10:06:03', '2016-08-08 14:25:07'),
('Friedl Langley', 6, 11, 45, 18, 1, '2016-08-08 10:56:03', '2016-08-08 14:25:07'),
('乄sweet丶', 4, 3, 61, 40, 1, '2016-08-08 11:46:03', '2016-08-08 14:25:07'),
('Freddie', 10, 2, 65, 45, 0, '2016-08-08 11:06:03', '2016-08-08 14:25:07'),
('Beasant', 3, 5, 43, 3, 0, '2016-08-08 11:16:03', '2016-08-08 14:25:07'),
('Esc Compton', 4, 1, 55, 1, 1, '2016-08-08 13:06:03', '2016-08-08 14:25:07'),
('丿丶灬Gastly', 2, 1, 55, 1, 0, '2016-08-08 13:26:03', '2016-08-08 14:25:07'),
('Rain Leighton', 3, 5, 35, 38, 1, '2016-08-08 13:06:03', '2016-08-08 14:25:07'),
('New Witas Clemons', 1, 1, 43,5,1, '2016-08-08 13:33:03', '2016-08-08 14:25:07'),
('Dorkas Norton', 4, 11, 43, 5, 1, '2016-08-08 13:11:03', '2016-08-08 14:25:07'),
('Quilaethan Starspell', 1, 2, 32, 20, 0, '2016-08-08 13:06:03', '2016-08-08 14:25:07'),
('Zelaron Redfury', 6, 11, 31, 45, 1, '2016-08-08 14:16:03', '2016-08-08 14:25:07'),
('milk口milk', 5, 1, 47, 5, 1, '2016-08-08 14:55:03', '2016-08-08 14:25:07'),
('Autumnlight', 1, 2, 55, 5, 1, '2016-08-08 14:44:03', '2016-08-08 14:25:07'),
('8087Brightstar', 1, 3, 63, 1, 0, '2016-08-08 14:54:03', '2016-08-08 14:25:07'),
('Alarean', 1, 4, 52, 40, 0, '2016-08-08 15:43:03', '2016-08-08 14:25:07'),
('Blackwing', 3, 5, 59, 5, 1, '2016-08-08 15:23:03', '2016-08-08 14:25:07'),
('Provenceo', 3, 5, 51, 38, 1, '2016-08-08 15:06:03', '2016-08-08 14:25:07'),
('Keeneanis', 10, 2, 55, 38, 0, '2016-08-08 16:06:03', '2016-08-08 14:25:07'),
('bu Emberdown', 10, 9, 54, 57, 1, '2016-08-08 16:12:03', '2016-08-08 14:25:07'),
('Despot', 5, 3, 51, 39, 0, '2016-08-08 16:06:03', '2016-08-08 14:25:07'),
('MVP Leader彡', 6, 11, 51, 57, 1, '2016-08-08 16:33:03', '2016-08-08 14:25:07'),
('丶Mx灬 Legend', 6, 9, 53,5,0, '2016-08-08 16:11:03', '2016-08-08 14:25:07'),
('Downblade', 6, 3, 55, 20, 1, '2016-08-08 17:54:03', '2016-08-08 14:25:07'),
('Xo灬Bloodsky', 5, 1, 55, 12, 1, '2016-08-08 17:06:03', '2016-08-08 14:25:07'),
('Noraeten Mirthbane', 5, 4, 44, 57, 0, '2016-08-08 17:33:03', '2016-08-08 14:25:07'),
('TopTeam', 4, 1, 64,5,1, '2016-08-08 17:06:03', '2016-08-08 14:25:07'),
('丿Moonflame丨', 4, 3, 33, 5, 1, '2016-08-08 18:06:03', '2016-08-08 14:25:07'),
('艹Jack丿丶', 4, 4, 56, 20, 0, '2016-08-08 18:06:03', '2016-08-08 14:25:07'),
('Autumnbringer', 4, 5, 37, 12, 0, '2016-08-08 18:55:03', '2016-08-08 14:25:07'),
('Mr Autumnfury', 4, 11, 55, 1, 1, '2016-08-08 18:36:03', '2016-08-08 14:25:07'),
('EndStar', 2, 1, 61, 5, 1, '2016-08-08 18:26:03', '2016-08-08 14:25:07'),
('巛Telanea Nightshadow灬', 2, 3, 65, 62, 1, '2016-08-08 19:06:03', '2016-08-08 14:25:07'),
('丶巛Wonder', 2, 4, 65, 12, 0, '2016-08-08 19:06:03', '2016-08-08 14:25:07'),
('Roc丿Syyna 灬', 2, 5, 37, 57, 1, '2016-08-08 19:56:03', '2016-08-08 14:25:07'),
('丿Drift灬', 2, 11, 57, 45, 1, '2016-08-08 19:46:03', '2016-08-08 14:25:07'),
('丶Bloodvale', 1, 2, 55, 12, 0, '2016-08-08 19:06:03', '2016-08-08 14:25:07'),
('巛Highwhisper', 1, 3, 77, 3, 1, '2016-08-08 20:16:03', '2016-08-08 14:25:07'),
('丿AnGel灬', 1, 4,68, 45, 1, '2016-08-08 20:06:03', '2016-08-08 14:25:07'),
('Tynheaanae', 1, 5, 64, 5, 0, '2016-08-08 20:26:03', '2016-08-08 14:25:07'),
('Johaiah', 1, 9, 65, 12, 1, '2016-08-08 20:06:03', '2016-08-08 14:25:07'),
('Emberwalker', 1, 11, 57, 20, 1, '2016-08-08 20:33:03', '2016-08-08 14:25:07'),
('Re丨灬Brightshard', 4, 4, 55, 20, 0, '2016-08-08 21:06:03', '2016-08-08 14:25:07'),
('Daedine', 2, 5, 42, 45, 1, '2016-08-08 21:16:03', '2016-08-08 14:25:07'),
('Coldbrook', 1, 2, 35, 43, 0, '2016-08-08 21:36:03', '2016-08-08 14:25:07'),
('丿Noann Daybrook彡', 3, 9, 52, 3, 1, '2016-08-08 21:26:03', '2016-08-08 14:25:07'),
('Amoanae Highsky', 2, 4, 45, 43, 1, '2016-08-08 21:06:03', '2016-08-08 14:25:07'),
('Sunny灬', 5, 11, 45, 1, 1, '2016-08-08 22:06:03', '2016-08-08 14:25:07'),
('Jazald', 6, 11, 55, 5, 1, '2016-08-08 22:56:03', '2016-08-08 14:25:07'),
('End Goldwell', 4, 3, 61, 40, 1, '2016-08-08 22:46:03', '2016-08-08 14:25:07'),
('Kazziaz', 10, 2, 65, 45, 0, '2016-08-08 22:06:03', '2016-08-08 14:25:07'),
('Top丨Moneynozzle', 3, 5, 43, 3, 0, '2016-08-08 22:16:03', '2016-08-08 14:25:07'),
('丿丶Gigapot', 4, 1, 55, 3, 1, '2016-08-08 23:06:03', '2016-08-08 14:25:07'),
('氵E丶Kleeteex', 2, 1, 35, 38, 0, '2016-08-08 23:26:03', '2016-08-08 14:25:07'),
('Farsnipe', 3, 5, 65, 38, 1, '2016-08-08 23:06:03', '2016-08-08 14:25:07'),
('灬Hagglevolt', 1, 1, 53,3,1, '2016-08-08 23:33:03', '2016-08-08 14:25:07'),
('艹丶LOVE', 4, 11, 34, 5, 1, '2016-08-08 23:11:03', '2016-08-08 14:25:07'),
('Moneyshatter', 1, 2, 32, 20, 0, '2016-08-08 1:06:03', '2016-08-08 14:25:07'),
('NinesEal', 6, 11, 31, 45, 1, '2016-08-08 1:16:03', '2016-08-08 14:25:07'),
('Fixto Loosefingers', 5, 1, 47, 20, 1, '2016-08-08 1:55:03', '2016-08-08 14:25:07'),
('Jazeel', 1, 2, 45, 20, 1, '2016-08-08 2:44:03', '2016-08-08 14:25:07'),
('Boltnozzle', 1, 3, 63, 1, 0, '2016-08-08 2:54:03', '2016-08-08 14:25:07'),
('Scrollwrench', 10, 2, 35, 25, 0, '2016-08-08 09:11:53', '2016-08-08 16:22:37');

/*------------------ 幻化大师 ------------------*/
SET @TEXT_ID := 65000;
REPLACE INTO `world`.`npc_text` (`ID`, `text0_0`) VALUES
(@TEXT_ID, 'Transmogrification allows you to change how your items look like without changing the stats of the items.\r\nItems used in transmogrification are no longer refundable, tradeable and are bound to you.\r\nUpdating a menu updates the view and prices.\r\n\r\nNot everything can be transmogrified with eachother.\r\nRestrictions include but are not limited to:\r\nOnly armor and weapons can be transmogrified\r\nGuns, bows and crossbows can be transmogrified with eachother\r\nFishing poles can not be transmogrified\r\nYou must be able to equip both items used in the process.\r\n\r\nTransmogrifications stay on your items as long as you own them.\r\nIf you try to put the item in guild bank or mail it to someone else, the transmogrification is stripped.\r\n\r\nYou can also remove transmogrifications for free at the transmogrifier.'),
(@TEXT_ID+1, 'You can save your own transmogrification sets.\r\n\r\nTo save, first you must transmogrify your equipped items.\r\nThen when you go to the set management menu and go to save set menu,\r\nall items you have transmogrified are displayed so you see what you are saving.\r\nIf you think the set is fine, you can click to save the set and name it as you wish.\r\n\r\nTo use a set you can click the saved set in the set management menu and then select use set.\r\nIf the set has a transmogrification for an item that is already transmogrified, the old transmogrification is lost.\r\nNote that same transmogrification restrictions apply when trying to use a set as in normal transmogrification.\r\n\r\nTo delete a set you can go to the set\'s menu and select delete set.');
 
REPLACE INTO `world`.`locales_npc_text` (`ID`, `text0_0_loc4`) VALUES
(@TEXT_ID, '幻化允许你改变装备的外观，但是装备的属性还是保留原来的属性。.\r\n被幻化的装备和玩家绑定，无法被退还或交易。\r\n\r\n装备并不能随意幻化。\r\n幻化的限制包括：\r\n只有盔甲和武器才能被幻化。\r\n其中，枪，弓箭只能互相之间幻化\r\n钓鱼竿不能被幻化。\r\n用来被幻化的装备，以及幻化材料，都需要能够被玩家角色所使用。\r\n\r\幻化过的装备，只有当你把它们放到公会银行或送给别人，才会恢复正常。\r\n\r\n幻化商人处也可以免费为你把幻化过的装备复原。'),
(@TEXT_ID+1, '你可以保存你自己的幻化套装.\r\n\r\n首先，你需要幻化你的装备.\r\n然后，到幻化商人菜单，选择“保存套装”菜单,\r\n在菜单里，所有被你幻化过的装备都会列出来，这样你可以知道要保存的内容.\r\n点击保存套装，并对其命名.\r\n\r\n要使用套装，只需要在套装管理菜单里，点击已经保存的套装，然后选择使用套装即可.\r\n如果套装里的某个幻化部位，已经被幻化过，那么旧的幻化效果就会被移除.\r\n\r\n要删除幻化套装，你可以在对应菜单里选择删除即可.');


SET
@Entry = 190010,
@Name = "Warpweaver";

REPLACE INTO `world`.`creature_template` (`entry`, `modelid1`, `modelid2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `scale`, `rank`, `dmgschool`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(@Entry, 19646, 0, @Name, "Transmogrifier", NULL, 0, 80, 80, 2, 35, 1, 1, 0, 0, 2000, 0, 1, 0, 7, 138936390, 0, 0, 0, '', 0, 3, 1, 0, 0, 1, 0, 0, 'Creature_Transmogrify');




-- 幻化----
SET @STRING_ENTRY := 11100;
REPLACE INTO `world`.`trinity_string` (`entry`, `content_default`,`content_loc4`,`content_loc5`) VALUES
(@STRING_ENTRY+0, 'Item transmogrified','装备已被幻化','装备已被幻化'),
(@STRING_ENTRY+1, 'Equipment slot is empty','装备槽是空的','装备槽是空的'),
(@STRING_ENTRY+2, 'Invalid source item selected','选择的要被幻化的装备无效','选择的要被幻化的装备无效'),
(@STRING_ENTRY+3, 'Source item does not exist','要被幻化的装备不存在','要被幻化的装备不存在'),
(@STRING_ENTRY+4, 'Destination item does not exist','幻化材料装备不存在','幻化材料装备不存在'),
(@STRING_ENTRY+5, 'Selected items are invalid','选择的装备无效','选择的装备无效'),
(@STRING_ENTRY+6, 'Not enough money','兜里没钱啊','兜里没钱啊'),
(@STRING_ENTRY+7, 'You don\'t have enough tokens','没有足够的令牌','没有足够的令牌'),
(@STRING_ENTRY+8, 'Transmogrifications removed','幻化已经被复原','幻化已经被复原'),
(@STRING_ENTRY+9, 'There are no transmogrifications','没有幻化过的装备','没有幻化过的装备'),
(@STRING_ENTRY+10, 'Invalid name inserted','插入名字无效','插入名字无效');


REPLACE INTO `world`.`trinity_string` (`entry`, `content_default`,`content_loc4`,`content_loc5`) VALUES
(15100, '|TInterface/ICONS/INV_Misc_Book_11:30:30:-18:0|tHow transmogrification works','|TInterface/ICONS/INV_Misc_Book_11:30:30:-18:0|t幻化介绍','|TInterface/ICONS/INV_Misc_Book_11:30:30:-18:0|t幻化介绍'),
(15101, 'Head','头盔','头盔'),
(15102, 'Shoulders','护肩','护肩'),
(15103, 'Shirt','衣服','衣服'),
(15104, 'Chest','胸甲','胸甲'),
(15105, 'Waist','护腰','护腰'),
(15106, 'Legs','护腿','护腿'),
(15107, 'Feet','鞋子','鞋子'),
(15108, 'Wrists','护腕','护腕'),
(15109, 'Hands','手套','手套'),
(15110, 'Back','返回..','返回..'),
(15111, 'Main hand','主武器','主武器'),
(15112, 'Off hand','副武器','副武器'),
(15113, 'Ranged','远程','远程'),
(15114, 'Tabard','斗篷','斗篷'),
(15115, '|TInterface/RAIDFRAME/UI-RAIDFRAME-MAINASSIST:30:30:-18:0|tManage sets','|TInterface/RAIDFRAME/UI-RAIDFRAME-MAINASSIST:30:30:-18:0|t幻化套装管理','|TInterface/RAIDFRAME/UI-RAIDFRAME-MAINASSIST:30:30:-18:0|t幻化套装管理'),
(15116, '|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-18:0|tRemove all transmogrifications','|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-18:0|t移除所有幻化','|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-18:0|t移除所有幻化'),
(15117, '|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:30:30:-18:0|tUpdate menu','|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:30:30:-18:0|t更新菜单','|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:30:30:-18:0|t更新菜单'),
(15118, 'Remove transmogrifications from all equipped items?','请确认是否要去除所有装备的幻化效果？','请确认是否要去除所有装备的幻化效果？'),
(15119, '|TInterface/ICONS/INV_Misc_Book_11:30:30:-18:0|tHow sets work','|TInterface/ICONS/INV_Misc_Book_11:30:30:-18:0|t套装介绍','|TInterface/ICONS/INV_Misc_Book_11:30:30:-18:0|t套装介绍'),
(15120, '|TInterface/GuildBankFrame/UI-GuildBankFrame-NewTab:30:30:-18:0|tSave set','|TInterface/GuildBankFrame/UI-GuildBankFrame-NewTab:30:30:-18:0|tS保存套装','|TInterface/GuildBankFrame/UI-GuildBankFrame-NewTab:30:30:-18:0|tS保存套装'),
(15121, '|TInterface/ICONS/INV_Misc_Statue_02:30:30:-18:0|tUse set','|TInterface/ICONS/INV_Misc_Statue_02:30:30:-18:0|t使用套装','|TInterface/ICONS/INV_Misc_Statue_02:30:30:-18:0|t使用套装'),
(15122, '|TInterface/PaperDollInfoFrame/UI-GearManager-LeaveItem-Opaque:30:30:-18:0|tDelete set','|TInterface/PaperDollInfoFrame/UI-GearManager-LeaveItem-Opaque:30:30:-18:0|t删除套装','|TInterface/PaperDollInfoFrame/UI-GearManager-LeaveItem-Opaque:30:30:-18:0|t删除套装'),
(15123, 'Using this set for transmogrify will bind transmogrified items to you and make them non-refundable and non-tradeable.\nDo you wish to continue?\n\n','使用这套幻化套装将使你相关装备与你绑定，并且这些装备无法被交易或退还。\n是否继续？\n\n','使用这套幻化套装将使你相关装备与你绑定，并且这些装备无法被交易或退还。\n是否继续？\n\n'),
(15124, 'Are you sure you want to delete ','请确认是否删除','请确认是否删除'),
(15125, 'Insert set name ','请输入套装名称','请输入套装名称'),
(15126, '|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-18:0|tRemove transmogrification','|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-18:0|t移除幻化','|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-18:0|t移除幻化'),
(15127, 'Remove transmogrification from the slot?','是否从装备槽中移除幻化效果？','是否从装备槽中移除幻化效果？');




INSERT INTO `auth`.`rbac_permissions` (`id`, `name`) VALUES
(999, 'Command: vip');

INSERT INTO `auth`.`rbac_linked_permissions` (`id`, `linkedId`) VALUES
(195, 999);

INSERT INTO `world`.`command` (`name`, `permission`, `help`) VALUES
('vip bank', 999, 'Syntax: .vip bank'),
('vip mail', 999, 'Syntax: .vip mail');

REPLACE INTO `world`.`npc_text` (`ID`, `text0_0`) VALUES (64000, 'Do you want to spend 20 DPs on 30 days VIP?');
REPLACE INTO `world`.`locales_npc_text` (Id,text0_0_loc4,text0_1_loc4) VALUES ('64000','是否花费20赞助点购买30天VIP会员？','');

REPLACE  into `world`.trinity_string (entry,content_default,content_loc4) 
values (15070,"[PvP] 你越级杀死了玩家（%s）, 获得了额外%d荣耀点奖励!","你越级杀死了玩家（%s）, 获得了额外%d荣耀点奖励!");

REPLACE  into `world`.trinity_string (entry,content_default,content_loc4) 
values (15071,"[PvP] 你被等级比你低的玩家（%s）杀死了, 额外损失了%d荣耀点!","你被等级比你低的玩家（%s）杀死了, 额外损失了%d荣耀点!");

REPLACE  into `world`.trinity_string (entry,content_default,content_loc4) 
values (15072,"[PvP] 你被其他玩家（%s）杀死了, 额外损失了%d铜币!","你被其他玩家（%s）杀死了, 额外损失了%d铜币!");

REPLACE  into `world`.trinity_string (entry,content_default,content_loc4) 
values (15073,"[PvP] 你杀死了玩家（%s）, 获得了%d铜币奖励!","你杀死了玩家（%s）, 获得了%d铜币奖励!");

REPLACE  into `world`.trinity_string (entry,content_default,content_loc4) 
values (15074,"[PvP] 你可耻的杀死了比你等级低很多的玩家（%s）, 扣除%d荣耀点作为惩罚!","你可耻的杀死了比你等级低很多的玩家（%s）, 扣除%d荣耀点作为惩罚！");

REPLACE  into `world`.trinity_string (entry,content_default,content_loc4) 
values (15075,"You have been awarded a token for slaying another player!","你杀死了其他玩家，得到了一个勋章奖励！");

REPLACE  into `world`.trinity_string (entry,content_default,content_loc4) 
values (15076,"You don't have any space in your bags.","你背包没有空间了。");

REPLACE  into `world`.trinity_string (entry,content_default,content_loc4) 
values (15077,"You were killed by others and lost the item [%s]x%d","你被杀死后，丢失了[%s]x%d");

REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15078,"Reward","推广奖励");

REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15079,"Summon","召唤");

REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15080,"Summon Heros","召唤英雄");

REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15081,"WoW Shop","魔兽商店");

REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15082,"Characters","角色服务");

REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15083,"Membership","会员服务");

REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15084,"Summon trainer successfully","您临时召唤了一个训练师，有效时间5分钟");

REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15085,"WARRIOR","战士");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15086,"PALADIN","圣骑士");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15087,"HUNTER","猎人");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15088,"ROGUE","盗贼");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15089,"PRIEST","牧师");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15090,"DEATH KNIGHT","死骑");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15091,"SHAMAN","萨满");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15092,"MAGE","法师");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15093,"WARLOCK","术士");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15095,"DRUID","德鲁伊");
REPLACE  into world.trinity_string (entry,content_default,content_loc4) 
values (15096,"BLADE MASTER","剑圣");



-- 会员服务 --
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (12009,"Sorry, only VIP users are allowed.","对不起，只有VIP用户可以访问");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15128,"Membership Type:           %s","会员类型:     %s");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15129,"Donation Points(DPs):   %d","赞助点数:     %d");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15130,"VIP Expire Date:\n%s","VIP到期时间:\n%s");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15131,"Buy 30-day VIP:           20 DPs","购买30天VIP会员:           20赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15132,"Spend 20 DPs on 30-day VIP. Confirm?","花费20赞助点购买30天VIP会员。确定购买？");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15133,"Buy Gold","购买金币");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15134,"You don't have enough Donation Points(DPs) to buy!","您的赞助点不足，无法购买！");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15135,"Buy 5000  Gold:     5 DPs", "购买5000 金币:    5赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15136,"Buy 10000 Gold:     10 DPs","购买10000金币:    10赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15137,"Buy 22000 Gold:     20 DPs","购买22000金币:    20赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15138,"Buy 35000 Gold:     30 DPs","购买35000金币:    30赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15139,"Buy 60000 Gold:     50 DPs","购买60000金币:    50赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15140,"You have bought successfully!","购买成功");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15141,"Failed to buy!","购买失败");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15142,"Bank (VIP)","移动银行（VIP）");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15143,"Mailbox (VIP)","移动邮箱（VIP）");

-- 角色服务 --
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15144,"Change Faction:   20 DPs","改变阵营:    20赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15145,"Change Race:      20 DPs","改变种族:    20赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15146,"Change Class:     25 DPs","改变职业:    25赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15147,"Boost Level","快速升级");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15148,"Change faction will cost 20 Donation Points(DPs). Confirm?","改变阵营将花费20赞助点。确认？");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15149,"Change race will cost 20 Donation Points(DPs). Confirm?","改变种族将花费20赞助点。确认？");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15150,"Boost Level Confirm","快速升级确认");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15151,"Rename will cost 15 Donation Points(DPs). Confirm?","角色改名将花费15赞助点。确认？");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15152,"Character customization will cost 15 Donation Points(DPs). Confirm?","改变外貌将花费15赞助点。确认？");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15153,"Rename:             15 DPs","角色改名:    15赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15154,"Customize:          15 DPs","改变外貌:    15赞助点");

-- 推广奖励 --
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15155,"Recruit Friends Reward","邀请推广奖励");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15156,"My RAF Id:           %d","我的邀请码       %d");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15157,"Total Recruited:       %d","我邀请的数量:       %d");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15158,"Total Reward:         %d DP","总推广奖励:     %d赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15159,"Played Time Reward","在线时间奖励");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15160,"Total Played Time:    %s","在线游戏时间:     %s");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15161,"Total Reward:        %.1f DP","获得奖励:     %.1f赞助点");

-- 商店功能 --
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15162,"Buy Armors","购买装备");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15163,"Buy Mounts","购买坐骑");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15164,"%s:       %d DP","%s:       %d赞助点");
REPLACE  into `world`.`trinity_string` (entry,content_default,content_loc4) values (15165,"You will spend %d DP on %s. Please confirm?","您将花费%d赞助点购买%s");

-- 商店的物品 --
REPLACE INTO `creature_template` (`entry`, `modelid1`, `modelid2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `scale`, `rank`, `dmgschool`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(@Entry, 19646, 0, @Name, "Transmogrifier", NULL, 0, 80, 80, 2, 35, 1, 1, 0, 0, 2000, 0, 1, 0, 7, 138936390, 0, 0, 0, '', 0, 3, 1, 0, 0, 1, 0, 0, 'Creature_Transmogrify');

