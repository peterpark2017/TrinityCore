-- v 1.0 ---
DROP TABLE IF EXISTS `characters_fake`;
CREATE TABLE IF NOT EXISTS `characters_fake` (
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

DROP TABLE IF EXISTS `fake_zones`;
CREATE TABLE IF NOT EXISTS `fake_zones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `zone` INT NULL,
  `level` INT NULL,
  PRIMARY KEY (`id`));
  
/* 幻化功能的表 */
DROP TABLE IF EXISTS `custom_transmogrification`;
CREATE TABLE IF NOT EXISTS `custom_transmogrification` (
  `GUID` int(10) unsigned NOT NULL COMMENT 'Item guidLow',
  `FakeEntry` int(10) unsigned NOT NULL COMMENT 'Item entry',
  `Owner` int(10) unsigned NOT NULL COMMENT 'Player guidLow',
  PRIMARY KEY (`GUID`),
  KEY `Owner` (`Owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='6_2';

DROP TABLE IF EXISTS `custom_transmogrification_sets`;
CREATE TABLE IF NOT EXISTS `custom_transmogrification_sets` (
  `Owner` int(10) unsigned NOT NULL COMMENT 'Player guidlow',
  `PresetID` tinyint(3) unsigned NOT NULL COMMENT 'Preset identifier',
  `SetName` text COMMENT 'SetName',
  `SetData` text COMMENT 'Slot1 Entry1 Slot2 Entry2',
  PRIMARY KEY (`Owner`,`PresetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='6_1';
