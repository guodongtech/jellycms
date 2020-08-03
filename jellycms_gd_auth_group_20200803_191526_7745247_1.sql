DROP TABLE IF EXISTS `gd_auth_group`;
CREATE TABLE `gd_auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '权限分组',
  `description` varchar(30) NOT NULL COMMENT '分组描述',
  `create_user` int(11) NOT NULL,
  `create_time` timestamp NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `gd_auth_group` VALUES
('1','系统管理','系统管理','1','2020-06-29 00:00:00'),
('2','全局配置','全局配置','1','2020-06-29 00:00:00'),
('3','基础内容','基础内容','1','2020-06-29 00:00:00'),
('4','文章内容','文章内容','1','2020-06-29 00:00:00'),
('5','扩展内容','扩展内容','1','2020-06-29 00:00:00');

