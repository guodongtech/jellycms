DROP TABLE IF EXISTS `gd_area`;
CREATE TABLE `gd_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `surname` varchar(10) NOT NULL DEFAULT '',
  `pid` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `domain` varchar(50) NOT NULL,
  `default` tinyint(1) NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp NOT NULL,
  `update_time` timestamp NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `pctheme` varchar(20) NOT NULL,
  `mobiletheme` varchar(20) NOT NULL,
  `htmlfolder` varchar(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `gd_area` VALUES
('1','cn','0','中文','www.guodong.tech','1','1','1','2017-11-30 13:55:37','2020-08-02 08:54:40','0','default','mobile','html'),
('2','en','0','英文','en.guodong.tech','0','1','1','2017-11-30 13:55:37','2020-08-01 13:37:49','0','default','mobile','html'),
('3','eee','0','qwe','','0','1','0','2020-08-01 13:50:55','0000-00-00 00:00:00','0','default','mobile','html');

