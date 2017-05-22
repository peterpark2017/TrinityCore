-- v 1.0 ---
/* 会员充值支持 */
DROP TABLE IF EXISTS `account_premium`;
CREATE TABLE IF NOT EXISTS `account_premium` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'Account id',
  `vip_level` int(11) unsigned NOT NULL DEFAULT '0',
  `vip_expire` int(11) unsigned NOT NULL DEFAULT '0',
  `wow_point` int(11) unsigned NOT NULL DEFAULT '0',
  `RAF_num` int(11) NULL DEFAULT '0',
  `RAF_rewards` int(11) NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  