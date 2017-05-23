-- v 1.0 ---
/* 商店功能 */
DROP TABLE IF EXISTS `vip_shop`;
CREATE TABLE IF NOT EXISTS `vip_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) unsigned NOT NULL,
  `category` int(11) unsigned NOT NULL DEFAULT '0',
  `price` int(11) unsigned NOT NULL DEFAULT '0',
  `name` text NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
