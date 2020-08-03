DROP TABLE IF EXISTS `gd_admin`;
CREATE TABLE `gd_admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` longtext NOT NULL,
  `realname` longtext NOT NULL,
  `role_id` int(11) NOT NULL,
  `password` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  `last_login_ip` varchar(16) NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp NOT NULL,
  `update_time` timestamp NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `issystem` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `gd_admin` VALUES
('1','admin','超级管理员','1','e10adc3949ba59abbe56e057f20f883e','1','1','127.0.0.1','1','1','2017-05-08 18:50:30','2020-08-02 08:23:09','0','1'),
('2','zhaojiabin','赵家彬','2','e10adc3949ba59abbe56e057f20f883e','1','1','127.0.0.1','1','1','2020-06-29 12:39:12','2020-07-13 20:24:06','0','0'),
('3','beijing','北京','1','1','1','1','127.0.0.1','1','1','2020-07-03 22:16:12','2020-07-12 12:33:07','0','0'),
('4','shandong','山东','1','c81e728d9d4c2f636f067f89cc14862c','0','0','127.0.0.1','1','1','2020-07-12 14:54:00','2020-07-12 14:54:32','0','0');

