/*
 Navicat Premium Data Transfer

 Source Server         : CMS
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 123.56.224.1:3306
 Source Schema         : cms_demo_guodong

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 21/08/2020 11:20:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gd_admin
-- ----------------------------
DROP TABLE IF EXISTS `{pre}admin`;
CREATE TABLE `{pre}admin`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `realname` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` int(11) NOT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `last_login_ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `issystem` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_admin
-- ----------------------------
INSERT INTO `{pre}admin` VALUES (1, 'admin', '超级管理员', 1, 'e10adc3949ba59abbe56e057f20f883e', 1, 1, '127.0.0.1', 1, 1, '2017-05-08 18:50:30', '2020-08-02 08:23:09', 0, 1);

-- ----------------------------
-- Table structure for gd_area
-- ----------------------------
DROP TABLE IF EXISTS `{pre}area`;
CREATE TABLE `{pre}area`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `surname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pid` int(11) NOT NULL,
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `default` tinyint(1) NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `pctheme` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mobiletheme` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `htmlfolder` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_area
-- ----------------------------
INSERT INTO `{pre}area` VALUES (1, 'cn', 0, '中文', '', 1, 1, 1, '2017-11-30 13:55:37', '2020-08-20 01:24:24', 0, 'default', 'mobile', 'html');
INSERT INTO `{pre}area` VALUES (2, 'en', 0, '英文', '', 0, 1, 1, '2017-11-30 13:55:37', '2020-08-01 13:37:49', 1, 'default', 'mobile', 'html');
INSERT INTO `{pre}area` VALUES (3, 'rus', 0, '俄文', '', 0, 1, 0, '2020-08-01 13:50:55', '0000-00-00 00:00:00', 1, 'default', 'mobile', 'html');

-- ----------------------------
-- Table structure for gd_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `{pre}auth_group`;
CREATE TABLE `{pre}auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限分组',
  `description` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组描述',
  `create_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gd_auth_group
-- ----------------------------
INSERT INTO `{pre}auth_group` VALUES (1, '系统管理', '系统管理', 1, '2020-06-29 00:00:00');
INSERT INTO `{pre}auth_group` VALUES (2, '全局配置', '全局配置', 1, '2020-06-29 00:00:00');
INSERT INTO `{pre}auth_group` VALUES (3, '基础内容', '基础内容', 1, '2020-06-29 00:00:00');
INSERT INTO `{pre}auth_group` VALUES (4, '文章内容', '文章内容', 1, '2020-06-29 00:00:00');
INSERT INTO `{pre}auth_group` VALUES (5, '扩展内容', '扩展内容', 1, '2020-06-29 00:00:00');

-- ----------------------------
-- Table structure for gd_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `{pre}auth_rule`;
CREATE TABLE `{pre}auth_rule`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规则名',
  `pid` int(11) NOT NULL COMMENT '父ID',
  `sorting` int(11) NOT NULL,
  `controller` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '控制器名',
  `action` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'action',
  `param` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数',
  `create_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_user` int(11) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `icon` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 199 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_auth_rule
-- ----------------------------
INSERT INTO `{pre}auth_rule` VALUES (1, '系统管理', 0, 88, '', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-02 09:10:40', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (2, '区域管理', 1, 200, 'Area', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (3, '菜单系统', 1, 255, 'Menu', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (4, '系统角色', 1, 255, 'Role', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-02 09:07:36', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (5, '系统用户', 1, 255, 'SysUser', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (6, '系统日志', 1, 255, 'Syslog', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (8, '数据库管理', 1, 255, 'Db', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (10, '基础内容', 0, 255, '', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (11, '站点信息', 10, 255, 'Site', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-02 09:16:03', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (12, '公司信息', 10, 200, 'Company', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-02 09:16:18', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (29, '内容栏目', 10, 255, 'Sorts', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-02 09:16:10', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (30, '内容管理', 0, 255, '', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-20 13:32:13', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (31, '专题内容', 30, 255, 'Single', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-20 13:41:51', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (36, '定制标签', 56, 255, 'Label', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-02 09:17:40', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (50, '留言信息', 57, 255, 'Message', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (51, '轮播图片', 57, 255, 'Slide', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (52, '友情链接', 57, 255, 'Link', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (55, '模型管理', 56, 200, 'Model', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (56, '全局配置', 0, 255, '', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (57, '扩展功能', 0, 255, '', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-20 15:01:37', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (58, '模型字段', 56, 255, 'ModelField', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (60, '自定义表单', 57, 255, 'Form', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (61, '文章内链', 57, 255, 'Tags', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (74, '权限管理', 1, 255, 'Auth', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (75, '在线更新', 1, 255, 'Update', '', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (76, '列表内容', 30, 255, 'Content', '', '', 1, '2014-07-14 06:21:35', 1, '2020-08-20 14:55:19', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (82, '欢迎页面', 0, 666, 'Home', 'Welcome', '', 1, '2014-07-14 06:21:35', 1, '2020-08-20 01:43:54', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (83, '添加/编辑', 2, 255, 'Area', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (85, '添加/编辑', 3, 255, 'Menu', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (86, '添加/编辑', 4, 255, 'Role', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (87, '添加/编辑', 5, 255, 'SysUser', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (88, '删除', 6, 255, 'Syslog', 'clear', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (89, '删除', 2, 255, 'Area', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (90, '删除', 3, 255, 'Menu', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (91, '删除', 4, 255, 'Role', 'index', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (92, '删除', 5, 255, 'SysUser', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (93, '添加/编辑', 74, 255, 'Auth', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (94, '删除', 74, 255, 'Auth', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (95, '编辑', 11, 255, 'Site', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (96, '编辑', 12, 200, 'Company', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (97, '添加/编辑', 29, 255, 'Sorts', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (98, '删除', 29, 255, 'Sorts', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (99, '状态开关', 29, 255, 'Sorts', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (100, '状态开关', 4, 255, 'Role', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (101, '状态开关', 3, 255, 'Menu', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (102, '状态开关', 5, 255, 'SysUser', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (104, '删除', 76, 255, 'Content', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (105, '状态开关', 76, 255, 'Content', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (107, '添加/编辑', 76, 255, 'Content', 'saveContent', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (118, '添加/编辑', 61, 255, 'Tags', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (119, '删除', 61, 255, 'Tags', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (120, '状态开关', 61, 255, 'Tags', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (121, '添加/编辑', 52, 255, 'Link', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (122, '删除', 52, 255, 'Link', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (123, '状态开关', 52, 255, 'Link', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (124, '添加/编辑', 51, 255, 'Slide', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (125, '删除', 51, 255, 'Slide', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (136, '添加/编辑', 55, 200, 'Model', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (137, '删除', 55, 200, 'Model', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (138, '状态开关', 55, 200, 'Model', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (140, '添加/编辑', 36, 200, 'Label', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (141, '删除', 36, 200, 'Label', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (142, '状态开关', 36, 200, 'Label', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (144, '添加/编辑', 58, 200, 'ModelField', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (145, '删除', 58, 200, 'ModelField', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (153, '添加/编辑', 60, 255, 'Form', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (154, '删除', 60, 255, 'Form', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (155, '状态开关', 60, 255, 'Form', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (158, '首页', 82, 255, 'Home', 'index', '', 1, '2014-07-14 06:21:35', 1, '2020-08-20 20:44:42', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (159, '添加/编辑', 31, 255, 'Single', 'edit', '', 1, '2020-08-20 13:34:47', 1, '2020-08-20 14:39:16', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (160, '状态开关', 31, 255, 'Single', 'switch', '', 1, '2020-08-20 14:46:35', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (161, '移动', 76, 255, 'Content', 'move', '', 1, '2020-08-20 14:47:47', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (162, '复制', 76, 255, 'Content', 'copy', '', 1, '2020-08-20 14:48:14', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (163, '批量删除', 76, 255, 'Content', 'batchdel', '', 1, '2020-08-20 14:49:06', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (164, 'table中编辑', 76, 255, 'Content', 'changeValue', '', 1, '2020-08-20 14:51:23', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (165, '编辑', 186, 255, 'Config', 'edit', '', 1, '2020-08-20 15:00:37', 1, '2020-08-20 17:40:17', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (166, '审核', 50, 255, 'Message', 'check', '', 1, '2020-08-20 15:03:12', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (167, '回复', 50, 255, 'Message', 'reply', '', 1, '2020-08-20 15:03:45', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (168, '状态开关', 50, 255, 'Message', 'switch', '', 1, '2020-08-20 15:04:45', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (169, '删除', 50, 255, 'Message', 'del', '', 1, '2020-08-20 15:05:12', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (170, '广告管理', 57, 255, 'Myad', '', '', 1, '2020-08-20 15:10:56', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (171, '添加/编辑', 170, 255, 'Myad', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (172, '删除', 170, 255, 'Myad', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (173, '状态开关', 170, 255, 'Myad', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (174, '状态开关', 2, 255, 'Area', 'switch', '', 1, '2020-08-20 15:14:37', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (175, '在table中修改', 2, 255, 'Area', 'changeValue', '', 1, '2020-08-20 15:15:30', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (176, '在table中修改', 3, 255, 'Menu', 'changeValue', '', 1, '2020-08-20 15:15:30', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (177, '在table中修改', 74, 255, 'Auth', 'changeValue', '', 1, '2020-08-20 15:15:30', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (178, '在table中修改', 4, 255, 'Role', 'changeValue', '', 1, '2020-08-20 15:15:30', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (179, '在table中修改', 5, 255, 'SysUser', 'changeValue', '', 1, '2020-08-20 15:15:30', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (180, '删除', 8, 255, 'Db', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (181, '打包下载', 8, 255, 'Db', 'packDownload', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (182, '本地导入', 8, 255, 'Db', 'upload', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (183, '还原', 8, 255, 'Db', 'recovery', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (184, '检查更新', 75, 255, 'Upgrade', 'checkAuth', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 1, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (185, '执行更新', 75, 255, 'Upgrade', 'checkAuth', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (186, '配置参数', 56, 255, 'Config', '', '', 1, '2020-08-20 17:40:02', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (187, '轮播图分组', 57, 255, 'slidegroup', '', '', 1, '2020-08-21 09:27:25', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (188, '添加/编辑', 187, 255, 'slidegroup', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (189, '删除', 187, 255, 'slidegroup', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (190, '状态开关', 187, 255, 'slidegroup', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (191, '友链分组', 57, 255, 'linkgroup', '', '', 1, '2020-08-21 09:30:25', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (192, '添加/编辑', 191, 255, 'linkgroup', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (193, '删除', 191, 255, 'linkgroup', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (194, '状态开关', 191, 255, 'linkgroup', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (195, '表单字段管理', 57, 255, 'formfield', '', '', 1, '2020-08-21 09:33:17', 0, '0000-00-00 00:00:00', 1, 0, 'fa-folder-open');
INSERT INTO `{pre}auth_rule` VALUES (196, '添加/编辑', 195, 255, 'formfield', 'edit', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (197, '删除', 195, 255, 'formfield', 'del', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');
INSERT INTO `{pre}auth_rule` VALUES (198, '状态开关', 195, 255, 'formfield', 'switch', '', 1, '2014-07-14 06:21:35', 1, '2014-07-14 06:21:35', 1, 0, 'fa-folder-open-o');

-- ----------------------------
-- Table structure for gd_company
-- ----------------------------
DROP TABLE IF EXISTS `{pre}company`;
CREATE TABLE `{pre}company`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `area_id` int(11) NULL DEFAULT NULL,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `postcode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fax` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qq` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `license` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `other` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_company
-- ----------------------------
INSERT INTO `{pre}company` VALUES (1, 1, '北京国栋科技有限公司', '北京市朝阳区远洋国际中心', '100000', '张先生', '18888888888', '010-88888888', '010-88888888', 'admin@guodong.tech', '88888888', '88888888', '其它信息');
INSERT INTO `{pre}company` VALUES (2, 2, '12', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');

-- ----------------------------
-- Table structure for gd_config
-- ----------------------------
DROP TABLE IF EXISTS `{pre}config`;
CREATE TABLE `{pre}config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `deleted` int(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_config
-- ----------------------------
INSERT INTO `{pre}config` VALUES (1, 'web_status', '1', '', 0);
INSERT INTO `{pre}config` VALUES (2, 'close_tip', '', '', 0);
INSERT INTO `{pre}config` VALUES (3, 'cached', '0', '', 0);
INSERT INTO `{pre}config` VALUES (4, 'cache_time', '888', '', 0);
INSERT INTO `{pre}config` VALUES (5, 'gzip', '0', '', 0);
INSERT INTO `{pre}config` VALUES (6, 'pagenum', '5', '', 0);
INSERT INTO `{pre}config` VALUES (7, 'tag_times', '3', '', 0);
INSERT INTO `{pre}config` VALUES (8, 'forbid_words', '', '', 0);
INSERT INTO `{pre}config` VALUES (9, 'water_status', '0', '', 0);
INSERT INTO `{pre}config` VALUES (10, 'water_text', 'JellyCMS', '', 0);
INSERT INTO `{pre}config` VALUES (11, 'water_font', '/static/font/msyh.ttf', '', 0);
INSERT INTO `{pre}config` VALUES (12, 'water_text_size', '18', '', 0);
INSERT INTO `{pre}config` VALUES (13, 'water_color', '#393d49', '', 0);
INSERT INTO `{pre}config` VALUES (14, 'water_pic', '/static/upload/20200813/1597298356_0549091865f3a0edd6ed.jpg', '', 0);
INSERT INTO `{pre}config` VALUES (15, 'water_position', 'center', '', 0);
INSERT INTO `{pre}config` VALUES (16, 'admin_check_code', '1', '', 0);
INSERT INTO `{pre}config` VALUES (17, 'message_status', '1', '', 0);
INSERT INTO `{pre}config` VALUES (18, 'message_ver_code', '1', '', 0);
INSERT INTO `{pre}config` VALUES (19, 'message_verify', '1', '', 0);
INSERT INTO `{pre}config` VALUES (20, 'form_status', '1', '', 0);
INSERT INTO `{pre}config` VALUES (21, 'form_ver_code', '1', '', 0);
INSERT INTO `{pre}config` VALUES (22, 'lock_count', '5', '', 0);
INSERT INTO `{pre}config` VALUES (23, 'lock_time', '888', '', 0);
INSERT INTO `{pre}config` VALUES (24, 'blackip', '', '', 0);
INSERT INTO `{pre}config` VALUES (25, 'whiteip', '', '', 0);
INSERT INTO `{pre}config` VALUES (26, 'url_suffix', '.html', '', 0);
INSERT INTO `{pre}config` VALUES (27, 'url_rule', 'short', '', 0);
INSERT INTO `{pre}config` VALUES (28, 'systemname', 'JellyCMS', '', 0);
INSERT INTO `{pre}config` VALUES (29, 'animate', 'fadeIn', '', 0);
INSERT INTO `{pre}config` VALUES (30, 'copyright', '<p>copyright © 2015-2020  <a href=\"http://www.guodong.tech/\" target=\"_blank\">北京国栋科技有限公司</a></p>\n<p><span><a href=\"https://demo.jellycms.cn/\" target=\"_blank\">在线演示</a></span><span><a href=\"https://www.jellycms.cn\" target=\"_blank\">前往官网</a></span> </p>', '', 0);
INSERT INTO `{pre}config` VALUES (31, 'syslogo', '/static/upload/20200819/1597839707_e5aa26a723a39ac6b619.png', '', 0);
INSERT INTO `{pre}config` VALUES (32, 'syscompany', '北京国栋科技有限公司', '', 0);
INSERT INTO `{pre}config` VALUES (33, 'sysdescription', '', '', 0);
INSERT INTO `{pre}config` VALUES (34, 'position', 'center', '', 0);
INSERT INTO `{pre}config` VALUES (35, 'water_opacity', '0.2', '', 0);
INSERT INTO `{pre}config` VALUES (36, 'water_proportion', '0.2', '', 0);
INSERT INTO `{pre}config` VALUES (37, 'stactics_status', '0', '', 0);
INSERT INTO `{pre}config` VALUES (38, 'max_stactics', '10', '', 0);
INSERT INTO `{pre}config` VALUES (39, 'admin_domain', '', '', 0);

-- ----------------------------
-- Table structure for gd_content
-- ----------------------------
DROP TABLE IF EXISTS `{pre}content`;
CREATE TABLE `{pre}content`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `area_id` int(11) NOT NULL,
  `sorts_id` int(11) NOT NULL,
  `subsort_id` int(11) NOT NULL,
  `color` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subtitle` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `filename` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `author` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `source` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `link` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp(0) NOT NULL,
  `pic` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pics` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tags` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `keywords` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sorting` bigint(20) NOT NULL,
  `top` tinyint(1) NOT NULL,
  `recommend` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `headline` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `visit` int(10) NOT NULL,
  `like` int(10) NOT NULL,
  `oppose` int(10) NOT NULL,
  `create_user` int(10) NOT NULL,
  `update_user` int(10) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `otherfile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pictitles` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '图片对应标题 逗号分隔',
  `status` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ay_content_sorting`(`sorting`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_content
-- ----------------------------
INSERT INTO `{pre}content` VALUES (1, 'JellyCMS3.8.1正式发布', 1, 3, 2, '', '', '', '', '', '', '0000-00-00 00:00:00', '/static/upload/20200819/1597821934_3be768770bb62d65c19e.jpg', '', '<p>JellyCMS3.8.1正式发布</p>', '', '', '', 256, 1, '1', '1', 4, 0, 0, 1, 1, '2020-08-18 20:04:01', '2020-08-19 15:25:36', '', '', 1, 0);
INSERT INTO `{pre}content` VALUES (2, '新手如何搭建自己的网站?', 1, 2, 2, '', '', '', '', '', '', '0000-00-00 00:00:00', '', '', '<p style=\"margin-top: 26px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">第一步：确定网站类型</span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">首先确定网站类型，不同的网站类型选择的开源程序一般不同，如企业网站推荐使用米拓，功能全面，seo功能完善。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">第二步：购买域名、服务器或主机</span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">买东西大家一定会购买，就算不会，你在哪个平台买可以直接咨询相应平台的客服就可以，这里就不多说了，只是有两点需要注意一下：</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">1、如果网站不准备备案，一定要买香港或者海外的主机，国内主机不备案网站无法上线；</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">2、一般中小型企业选择主机就够用了，而且价格相对便宜一点，当然如果您是土豪也可以直接购买服务器。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">第三步：选择合适的开源程序</span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">常见的开源程序有<a href=\"https://www.jellycms.cn/\" target=\"_blank\">JellyCMS</a>、帝国，织梦，米拓，wordpress，phpcms，discuz等等，大家按需要选择合适的就行。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">如果想仿站<a href=\"https://www.jellycms.cn/\" target=\"_blank\" style=\"font-family: arial; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">JellyCMS</a>就比较适合；</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">如果想做资讯类站点，织梦就比较方便，搭建快，后台支持采集功能，缺点就是不安全，我见过很多企业因为资讯选择织梦程序导致服务器被入侵；</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">如果想做响应式网站，选择<a href=\"https://www.jellycms.cn/\" target=\"_blank\" style=\"font-family: arial; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">JellyCMS</a>比较合适，功能完善，其他开源程序很少支持响应式的；</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">如果想做博客，可以用wordpress，比较适合做博客网站；</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">大家可以根据自己的需求选择就好，这里就不再一一举例了。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">第四步：上传程序源码到空间</span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">大家找到需要的开源程序后去相应的网站下载安装文件，然后利用ftp上传到空间根目录。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">第五步：安装网站</span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">安装网站每个开源程序基本都差不多，一般是会要填数据库名与密码，设置管理员账号密码，大多数直接下一步，下一步，按提示填写信息就可以了。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">第六步：后台设置</span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">后台设置一般包括，网站名称，关键词，图片修改，栏目搭建等。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">第七步：内容填充</span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">内容填充包括网站简介，产品介绍，联系方式，资讯等，这里需要注意的是，建议一定要用文字或文字+图片来填充，很多网站为了方便，公司简介就是一张图片来介绍，文字全在图片上，甚至有些连产品介绍也是直接全部用图片，这样非常不利于搜索引擎的爬取与收录。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">第八步：搭建完成</span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\"><span class=\"bjh-br\"></span></span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">网站搭建完成后还没有结束，重要的是如何去运营网站，我们也会不定期的分享网站运营方面的知识，大家可以持续关注。</span></p><p><br/></p>', '', '新手如何搭建自己的网站', '新手如何搭建自己的网站', 0, 0, '', '', 2, 0, 0, 1, 1, '2020-08-21 09:24:13', '2020-08-21 09:34:02', '', '', 1, 0);
INSERT INTO `{pre}content` VALUES (3, '新手如何选域名和购买域名?', 1, 2, 2, '', '', '', '', '', '', '0000-00-00 00:00:00', '', '', '<h1 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 28px; color: rgb(79, 79, 79); line-height: 36px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">前言</h1><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 18px; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">本文介绍的是如何购买一个网络域名，是建立个人网站的基础准备之一。</p><h1 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 28px; color: rgb(79, 79, 79); line-height: 36px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">知识储备</h1><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>域名是什么？</p></li><li><p>域名系统是什么？</p></li><li><p>HTTP 是什么？</p></li><li><p>HTTPS 是什么？</p></li></ul><h2 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 24px; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">域名是什么？</h2><blockquote style=\"box-sizing: border-box; outline: 0px; margin: 0px 0px 24px; padding: 16px; color: rgba(0, 0, 0, 0.5); border-left: 8px solid rgb(221, 223, 228); background: rgb(238, 240, 244); overflow: auto; overflow-wrap: break-word; font-family: -apple-system, &quot;SF UI Text&quot;, Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;, sans-serif; font-size: 14px; font-variant-ligatures: common-ligatures; white-space: normal; word-break: break-word !important;\"><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 0px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(153, 153, 153); line-height: 22px; overflow-wrap: break-word;\">网域名称（英语：Domain Name，简称：Domain），简称域名、网域，是由一串用点分隔的字符组成的互联网上某一台计算机或计算机组的名称，用于在数据传输时标识计算机的电子方位。域名可以说是一个 IP 地址的代称，目的是为了便于记忆后者。例如，wikipedia.org&nbsp;是一个域名，和 IP 地址 208.80.152.2 相对应。人们可以直接访问&nbsp;wikipedia.org&nbsp;来代替 IP 地址，然后域名系统（DNS）就会将它转化成便于机器识别的 IP 地址。这样，人们只需要记忆&nbsp;wikipedia.org&nbsp;这一串带有特殊含义的字符，而不需要记忆没有含义的数字。</p></blockquote><h2 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 24px; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">域名系统是什么？</h2><blockquote style=\"box-sizing: border-box; outline: 0px; margin: 0px 0px 24px; padding: 16px; color: rgba(0, 0, 0, 0.5); border-left: 8px solid rgb(221, 223, 228); background: rgb(238, 240, 244); overflow: auto; overflow-wrap: break-word; font-family: -apple-system, &quot;SF UI Text&quot;, Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;, sans-serif; font-size: 14px; font-variant-ligatures: common-ligatures; white-space: normal; word-break: break-word !important;\"><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 0px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(153, 153, 153); line-height: 22px; overflow-wrap: break-word;\">域名系统（英文：Domain Name System，缩写：DNS）是互联网的一项服务。它作为将域名和IP地址相互映射的一个分布式数据库，能够使人更方便地访问互联网。DNS 使用 TCP 和 UDP 端口 53。当前，对于每一级域名长度的限制是63个字符，域名总长度则不能超过 253 个字符。</p></blockquote><h2 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 24px; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">HTTP 是什么？</h2><blockquote style=\"box-sizing: border-box; outline: 0px; margin: 0px 0px 24px; padding: 16px; color: rgba(0, 0, 0, 0.5); border-left: 8px solid rgb(221, 223, 228); background: rgb(238, 240, 244); overflow: auto; overflow-wrap: break-word; font-family: -apple-system, &quot;SF UI Text&quot;, Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;, sans-serif; font-size: 14px; font-variant-ligatures: common-ligatures; white-space: normal; word-break: break-word !important;\"><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 0px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(153, 153, 153); line-height: 22px; overflow-wrap: break-word;\">超文本传输协议（英语：HyperText Transfer Protocol，缩写：HTTP）是一种用于分布式、协作式和超媒体信息系统的应用层协议。HTTP是万维网的数据通信的基础。</p></blockquote><h2 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 24px; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">HTTPS 是什么？</h2><blockquote style=\"box-sizing: border-box; outline: 0px; margin: 0px 0px 24px; padding: 16px; color: rgba(0, 0, 0, 0.5); border-left: 8px solid rgb(221, 223, 228); background: rgb(238, 240, 244); overflow: auto; overflow-wrap: break-word; font-family: -apple-system, &quot;SF UI Text&quot;, Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;, sans-serif; font-size: 14px; font-variant-ligatures: common-ligatures; white-space: normal; word-break: break-word !important;\"><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 0px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(153, 153, 153); line-height: 22px; overflow-wrap: break-word;\">超文本传输安全协议（英语：Hypertext Transfer Protocol Secure，缩写：HTTPS，常称为HTTP over TLS，HTTP over SSL 或 HTTP Secure）是一种通过计算机网络进行安全通信的传输协议。HTTPS 经由 HTTP 进行通信，但利用 SSL/TLS 来加密数据包。HTTPS 开发的主要目的，是提供对网站服务器的身份认证，保护交换数据的隐私与完整性。这个协议由网景公司（Netscape）在1994 年首次提出，随后扩展到互联网上。</p></blockquote><h1 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 28px; color: rgb(79, 79, 79); line-height: 36px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">实现方法</h1><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 18px; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">学习了知识储备中的技术点，我们可以看出，为了搭建一个完整的网站，除了提供服务的服务器之外，购买一个域名是必不可少的，另外，配置 https 也是必不可少的一步，因此我们额外购买 SSL 证书。<br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/>如何购买一个域名，分为以下几个步骤：</p><ol style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>选择域名服务提供商</p></li><li><p>购买域名</p></li><li><p>购买 SSL 证书</p></li></ol><h2 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 24px; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">选择域名服务提供商</h2><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 18px; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">域名服务提供商有很多，无论是什么原因导致你最终选择哪一家，我都是以最便捷易懂的目的来推荐。以下是我推荐的几个域名服务提供商：</p><ol style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>阿里云（万网）&nbsp;https://wanwang.aliyun.com/domain/</p></li><li><p>腾讯云&nbsp;https://dnspod.cloud.tencent.com/</p></li><li><p>Godaddy&nbsp;https://sg.godaddy.com/zh/domains</p></li></ol><h2 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 24px; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">购买域名</h2><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 18px; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">JellyCMS.cn 是在阿里云（万网）上购买的，因此本文以阿里云（万网）为例，介绍如何购买一个域名。</p><ol style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>在浏览器打开阿里云（万网）链接&nbsp;https://wanwang.aliyun.com/domain/，进入万网主页。<br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/><br/></p></li><li><p>在输入框输入自己想要给网站起的名字（最好是纯英文数字，当然中文现在也支持了，但为了走向世界，还是老老实实用英文数字作为你的网站域名吧），点击查域名按钮。<br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/><br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/>我输入的是 iloveyou，搜索结果出来了，因为这个 iloveyou 必定火爆，所以搜索结果显示大致分为两种，未注册和已注册，你可以看到已注册的显示价格都非常高，那是因为已经被别人购买，道理如同商标抢注，所以你也可以用这个方法来赚钱，未注册的相对便宜，你可以直接点击加入清单，稍后购买，也可以鼠标悬停在更多价格按钮上参考1年、3年、5年、10年期的价格，一次购买的期限越长，相对平均价格越低，如果只购买1年期，到期如果需要保留并才续费，那价格肯定会比直接买多年期要高，所以购买前一定要想好计划好。<br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/><br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/>为了说明一般情况，我又换了一个名字 <span style=\"color: rgb(77, 77, 77); font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 18px; font-variant-ligatures: common-ligatures; background-color: rgb(255, 255, 255);\">JellyCMS</span>搜索。<br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/><br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/>这次可以看到，由于是个性化起名，显示的价格一下就降低了很多，而且选择余地也很多，可以根据自己的实际情况进行购买。我选择了 top 后缀的域名，点击加入清单按钮，接着点击立即结算按钮，进入结算页面。<br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/><br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/>付款后，你就拥有了一个正式的域名了，这时你就可以点击&nbsp;https://dc.console.aliyun.com&nbsp;进入域名控制台进行各种配置操作了。<br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/><br/></p></li></ol><h2 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 24px; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">购买 SSL 证书</h2><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 18px; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">在阿里云（万网）购买了域名服务以后，就可以接着购买 SSL 证书了，点击域名控制台相应域名列表后的管理链接，进行具体的配置管理，包括购买 SSL 证书。<br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/><br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/>可以看到【免费开启SSL证书】这个链接，点击后发现有收费的和免费的两个选择，我认为免费的对于个人网站够用，要求不高的情况下可以选择它。<br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/><br style=\"box-sizing: border-box; outline: 0px; margin: 0px; padding: 0px; overflow-wrap: break-word;\"/>填写要申请的域名后，就可以一路免费（或者收费）直到拥有 SSL 证书了。</p><h1 style=\"box-sizing: border-box; outline: 0px; margin: 8px 0px 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 28px; color: rgb(79, 79, 79); line-height: 36px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">总结</h1><p style=\"box-sizing: border-box; outline: 0px; margin-top: 0px; margin-bottom: 16px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-size: 18px; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures; white-space: normal; background-color: rgb(255, 255, 255);\">本文简单介绍了购买域名以及 SSL 证书的步骤，只是完成了搭建个人网站的一小部分工作，接下来还会继续写关于搭建个人网站的其他必要工作，包括域名的绑定，SSL 证书的设置方法。</p><p><br/></p>', '', '新手如何选域名,新手如何购买域名', '本文介绍的是如何购买一个网络域名，是建立个人网站的基础准备之一', 0, 0, '', '', 0, 0, 0, 1, 1, '2020-08-21 09:30:20', '2020-08-21 09:33:23', '', '', 1, 0);
INSERT INTO `{pre}content` VALUES (4, 'JellyCMS', 1, 5, 5, '', '', '', '', '', '', '0000-00-00 00:00:00', '/static/upload/20200821/1597979080_56aa87415a0ccad45be8.jpg', '', '<p><span style=\"color: rgb(88, 96, 105); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; font-size: 14px; background-color: rgb(255, 255, 255);\">JellyCMS是全新内核且永久开源免费的PHP企业网站开发建设管理系统，是一套高效、简洁的可免费商用的PHP CMS源码，能够满足各类企业网站开发建设的需要。只要懂HTML就可快速开发企业网站。官方提供了大量网站模板免费下载和使用，将致力于为广大开发者和企业提供最佳的网站开发建设解决方案。</span></p>', '', 'JellyCMS', 'JellyCMS是全新内核且永久开源免费的PHP企业网站开发建设管理系统，是一套高效、简洁的可免费商用的PHP CMS源码，能够满足各类企业网站开发建设的需要。只要懂HTML就可快速开发企业网站。官方提供了大量网站模板免费下载和使用，将致力于为广大开发者和企业提供最佳的网站开发建设解决方案。', 0, 0, '', '', 0, 0, 0, 1, 1, '2020-08-21 11:04:09', '2020-08-21 11:05:06', '', '', 1, 0);
INSERT INTO `{pre}content` VALUES (5, 'JellyCRM', 1, 5, 5, '', '', '', '', '', '', '0000-00-00 00:00:00', '/static/upload/20200821/1597979175_7b0ff2fcfcd38651743c.jpg', '', '<p>JellyCRM</p>', '', '', 'JellyCRM', 0, 0, '', '', 0, 0, 0, 1, 0, '2020-08-21 11:06:21', '0000-00-00 00:00:00', '', '', 1, 0);
INSERT INTO `{pre}content` VALUES (6, 'JellySHOP', 1, 5, 5, '', '', '', '', '', '', '0000-00-00 00:00:00', '/static/upload/20200821/1597979496_5cd9c6081669271c2af5.jpg', '', '<p>JellySHOP</p>', '', 'JellySHOP', 'JellySHOP', 0, 0, '', '', 0, 0, 0, 1, 1, '2020-08-21 11:08:33', '2020-08-21 11:11:37', '', '', 1, 0);
INSERT INTO `{pre}content` VALUES (7, 'JellyTOOL', 1, 5, 5, '', '', '', '', '', '', '0000-00-00 00:00:00', '/static/upload/20200821/1597979518_47198bb10af0cad74efc.jpg', '', '<p>JellyTOOL</p>', '', '', '', 0, 0, '', '', 0, 0, 0, 1, 1, '2020-08-21 11:10:40', '2020-08-21 11:11:59', '', '', 1, 0);

-- ----------------------------
-- Table structure for gd_content_ext
-- ----------------------------
DROP TABLE IF EXISTS `{pre}content_ext`;
CREATE TABLE `{pre}content_ext`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content_id` bigint(20) NOT NULL COMMENT '关联content表',
  `modelfield_id` int(11) NOT NULL COMMENT '模型扩展字段ID',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '模型扩展字段值 多个值以逗号隔开',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ay_content_ext_contentid`(`content_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_content_ext
-- ----------------------------
INSERT INTO `{pre}content_ext` VALUES (1, 4, 1, '');
INSERT INTO `{pre}content_ext` VALUES (2, 4, 2, '');
INSERT INTO `{pre}content_ext` VALUES (3, 4, 3, '');
INSERT INTO `{pre}content_ext` VALUES (4, 5, 1, '');
INSERT INTO `{pre}content_ext` VALUES (5, 5, 2, '');
INSERT INTO `{pre}content_ext` VALUES (6, 5, 3, '');
INSERT INTO `{pre}content_ext` VALUES (7, 6, 1, '');
INSERT INTO `{pre}content_ext` VALUES (8, 6, 2, '');
INSERT INTO `{pre}content_ext` VALUES (9, 6, 3, '');
INSERT INTO `{pre}content_ext` VALUES (10, 7, 1, '');
INSERT INTO `{pre}content_ext` VALUES (11, 7, 2, '');
INSERT INTO `{pre}content_ext` VALUES (12, 7, 3, '');

-- ----------------------------
-- Table structure for gd_form
-- ----------------------------
DROP TABLE IF EXISTS `{pre}form`;
CREATE TABLE `{pre}form`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `table_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_user` int(11) NULL DEFAULT NULL,
  `update_user` int(11) NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `issystem` tinyint(1) NULL DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_form
-- ----------------------------
INSERT INTO `{pre}form` VALUES (1, '在线留言', 'message', 1, 1, '2020-07-01 00:00:00', '2020-07-26 22:14:16', 1, 0, 1, '1');
INSERT INTO `{pre}form` VALUES (2, '内容评论表单', 'comment', 1, 1, '2020-07-26 21:04:05', '2020-07-27 05:45:47', 1, 0, 1, '');

-- ----------------------------
-- Table structure for gd_form_comment
-- ----------------------------
DROP TABLE IF EXISTS `{pre}form_comment`;
CREATE TABLE `{pre}form_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_id` int(11) NULL DEFAULT NULL COMMENT '内容ID',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `pid` int(11) NULL DEFAULT 0 COMMENT '父ID',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_user` int(11) NULL DEFAULT NULL,
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `nickname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '0：前台不显示；1：前台展示；3：审核中  与form表type关联',
  `deleted` tinyint(1) NULL DEFAULT 0,
  `area_id` int(11) NULL DEFAULT NULL COMMENT '区域ID',
  `checked` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gd_form_comment
-- ----------------------------
INSERT INTO `{pre}form_comment` VALUES (1, 1, '小程序生成：微信小程序，百度小程序，支付宝小程序等平台小程序 小程序生成：微信小程序，百度小程序，支付宝小程序等平台小程序', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '果冻', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (2, 2, '小程序生成：微信小程序，百度小程序，支付宝小程序等平台小程序 小程序生成：微信小程序，百度小程序，支付宝小程序等平台小程序', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '果冻', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (3, 21, '小程序生成：微信小程序，百度小程序，支付宝小程序等平台小程序 小程序生成：微信小程序，百度小程序，支付宝小程序等平台小程序', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '果冻', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (4, 21, '系统简洁，高效，易用,一般的开发人员能轻易上手并立刻投身网站建设', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (5, 21, '开源免费', 0, '0000-00-00 00:00:00', 0, '', '/static/images/logo.png', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (6, 21, 'aaaa', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (7, 21, 'asfd', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (8, 21, 'aaa', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (9, 21, 'aa', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (10, 21, 'aaa', 0, '0000-00-00 00:00:00', 0, '', '/static/images/logo.png', 0, '网友', 1, 1, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (11, 21, 'ccc', 6, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (12, 21, 'aaa', 6, '0000-00-00 00:00:00', 0, '', '/static/images/logo.png', 0, '网友aaa', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (13, 21, 'dddddd', 6, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (14, 21, 'cccc', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (15, 21, 'eee', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (16, 20, 'test', 0, '0000-00-00 00:00:00', 0, '', '/static/images/icon.jpg', 0, '网友', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (17, 0, 'sdfs', 1, '0000-00-00 00:00:00', 0, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (18, 0, '123', 8, '0000-00-00 00:00:00', 0, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (19, 0, 'asdfasdfa', 1, '0000-00-00 00:00:00', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (20, 0, 'aw ef', 1, '0000-00-00 00:00:00', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (21, 0, 'adfas', 1, '0000-00-00 00:00:00', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (22, 0, 'asdf', 21, '0000-00-00 00:00:00', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (23, 0, 'asd', 9, '0000-00-00 00:00:00', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (24, 0, 'asdf', 21, '2020-07-29 22:02:33', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (25, 0, 'easdf', 11, '2020-07-29 22:15:00', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (26, 0, 'qwe', 25, '2020-07-29 22:15:14', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (27, 0, 'asdf', 26, '2020-07-29 22:18:32', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (28, 0, 'asdf', 27, '2020-07-29 22:22:17', 1, '', '', 0, '', 1, 0, 1, 0);
INSERT INTO `{pre}form_comment` VALUES (29, 0, '啊十分大方', 28, '2020-07-29 22:22:31', 1, '', '', 0, '', 1, 0, 1, 0);

-- ----------------------------
-- Table structure for gd_form_field
-- ----------------------------
DROP TABLE IF EXISTS `{pre}form_field`;
CREATE TABLE `{pre}form_field`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NULL DEFAULT NULL,
  `name` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `length` bigint(20) NULL DEFAULT NULL,
  `required` tinyint(1) NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sorting` bigint(20) NULL DEFAULT NULL,
  `create_user` int(11) NULL DEFAULT NULL,
  `update_user` int(11) NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  `deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mysql字段类型',
  `issystem` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '1:系统内置',
  `display` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 1 COMMENT '是否显示在后台列表',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ay_form_field_sorting`(`sorting`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_form_field
-- ----------------------------
INSERT INTO `{pre}form_field` VALUES (1, 1, 'username', 10, 1, '联系人', 255, 0, 1, '2018-07-14 18:24:02', '2020-08-20 08:13:34', 0, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (2, 1, 'mobile', 12, 1, '手机', 255, 0, 1, '2018-07-14 18:24:02', '2020-07-27 11:41:29', 0, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (3, 2, 'content', 500, 1, '内容', 255, 0, 1, '2018-07-14 18:24:02', '2020-07-05 06:08:14', 0, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (4, 2, 'tel', 20, 1, '电话号码', 255, 0, 0, '2018-11-30 15:18:00', '2018-11-30 15:18:00', 0, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (6, 1, 'content', 100, 1, '内容', 255, 1, 1, '2020-07-01 06:30:00', '2020-07-01 06:37:23', 0, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (7, 3, 'content_id', 12, 1, ' ', 255, 1, 1, '2020-07-01 06:32:25', '2020-07-01 06:38:49', 1, 'int', 0, 1);
INSERT INTO `{pre}form_field` VALUES (8, 3, 'content', 100, 1, ' ', 255, 1, 0, '2020-07-01 06:32:34', '0000-00-00 00:00:00', 1, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (9, 2, 'pid', 12, 1, '父消息ID', 255, 1, 1, '2020-07-01 06:32:51', '2020-07-28 10:31:11', 0, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (10, 8, 'a', 20, 1, 'a', 255, 1, 1, '2020-07-27 09:07:00', '2020-07-27 09:08:48', 1, 'int', 0, 1);
INSERT INTO `{pre}form_field` VALUES (11, 4, 'name', 20, 1, '姓名', 255, 1, 0, '2020-07-27 12:12:22', '0000-00-00 00:00:00', 0, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (12, 4, 'sex', 1, 1, '性别', 255, 1, 0, '2020-07-27 12:15:33', '0000-00-00 00:00:00', 0, 'int', 0, 1);
INSERT INTO `{pre}form_field` VALUES (13, 4, 'taste', 50, 0, '兴趣', 255, 1, 0, '2020-07-27 12:17:11', '0000-00-00 00:00:00', 0, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (14, 1, 'pid', 11, 0, '父消息id', 255, 1, 1, '2020-07-28 08:55:06', '2020-07-29 15:46:13', 0, 'int', 0, 1);
INSERT INTO `{pre}form_field` VALUES (15, 1, 'ip', 20, 0, '用户IP', 255, 1, 1, '2020-07-28 09:15:49', '2020-07-28 09:17:35', 0, 'varchar', 0, 1);
INSERT INTO `{pre}form_field` VALUES (16, 1, 'checked', 1, 0, '是否审核', 255, 1, 1, '2020-07-30 12:37:32', '2020-07-30 12:41:06', 0, 'int', 0, 1);
INSERT INTO `{pre}form_field` VALUES (17, 2, 'checked', 1, 0, '是否审核', 255, 1, 1, '2020-07-30 12:39:38', '2020-07-30 12:41:13', 0, 'int', 0, 1);

-- ----------------------------
-- Table structure for gd_form_message
-- ----------------------------
DROP TABLE IF EXISTS `{pre}form_message`;
CREATE TABLE `{pre}form_message`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `area_id` int(11) NULL DEFAULT NULL,
  `username` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `create_user` int(11) NULL DEFAULT NULL,
  `update_user` int(11) NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  `deleted` tinyint(1) NULL DEFAULT 0,
  `pid` int(11) NULL DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `checked` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_form_message
-- ----------------------------
INSERT INTO `{pre}form_message` VALUES (1, 1, '国栋', '18888866666', '用户留言', '', 0, 0, 0, '2020-07-24 19:54:43', '2020-07-24 19:54:43', 0, 0, '/static/images/logo.png', 2);
INSERT INTO `{pre}form_message` VALUES (2, 1, '国栋', '18888866666', '管理员回复', '', 1, 0, 0, '2020-07-24 19:54:43', '2020-07-24 19:54:43', 0, 1, '/static/images/icon.jpg', 0);
INSERT INTO `{pre}form_message` VALUES (3, 1, 'qqq', 'qqq', '测试', '', 1, 0, 0, '2020-07-24 19:54:43', '2020-07-24 19:54:43', 0, 0, '/static/images/logo.png', 2);
INSERT INTO `{pre}form_message` VALUES (4, 1, 'aa', 'aaa', 'aaaaaa', '', 1, 0, 0, '2020-07-24 19:54:43', '2020-07-24 19:54:43', 0, 0, '/static/images/logo.png', 0);
INSERT INTO `{pre}form_message` VALUES (5, 1, '', '', '4444', '', 1, 1, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 4, '', 2);
INSERT INTO `{pre}form_message` VALUES (6, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 18:17:26', '0000-00-00 00:00:00', 0, 5, '', 2);
INSERT INTO `{pre}form_message` VALUES (7, 1, '', '', '55', '', 1, 1, 0, '2020-07-29 18:19:12', '0000-00-00 00:00:00', 0, 6, '', 0);
INSERT INTO `{pre}form_message` VALUES (8, 1, '', '', '55', '', 1, 1, 0, '2020-07-29 18:20:38', '0000-00-00 00:00:00', 1, 6, '', 0);
INSERT INTO `{pre}form_message` VALUES (9, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 18:20:58', '0000-00-00 00:00:00', 1, 8, '', 0);
INSERT INTO `{pre}form_message` VALUES (10, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 18:21:33', '0000-00-00 00:00:00', 1, 9, '', 0);
INSERT INTO `{pre}form_message` VALUES (11, 1, '', '', '4', '', 1, 1, 0, '2020-07-29 18:23:20', '0000-00-00 00:00:00', 0, 10, '', 2);
INSERT INTO `{pre}form_message` VALUES (12, 1, '', '', '444', '', 1, 1, 0, '2020-07-29 18:25:54', '0000-00-00 00:00:00', 1, 6, '', 0);
INSERT INTO `{pre}form_message` VALUES (13, 1, '', '', '444', '', 1, 1, 0, '2020-07-29 18:27:15', '0000-00-00 00:00:00', 1, 6, '', 0);
INSERT INTO `{pre}form_message` VALUES (14, 1, '', '', '545', '', 1, 1, 0, '2020-07-29 18:28:13', '0000-00-00 00:00:00', 0, 7, '', 0);
INSERT INTO `{pre}form_message` VALUES (15, 1, '', '', '急急急', '', 1, 1, 0, '2020-07-29 18:29:42', '0000-00-00 00:00:00', 1, 6, '', 0);
INSERT INTO `{pre}form_message` VALUES (16, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 18:34:04', '0000-00-00 00:00:00', 1, 6, '', 0);
INSERT INTO `{pre}form_message` VALUES (17, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 18:45:39', '0000-00-00 00:00:00', 0, 7, '', 0);
INSERT INTO `{pre}form_message` VALUES (18, 1, '', '', '4', '', 1, 1, 0, '2020-07-29 18:46:02', '0000-00-00 00:00:00', 0, 7, '', 0);
INSERT INTO `{pre}form_message` VALUES (19, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 18:46:33', '0000-00-00 00:00:00', 0, 7, '', 0);
INSERT INTO `{pre}form_message` VALUES (20, 1, '', '', '4', '', 1, 1, 0, '2020-07-29 18:47:00', '0000-00-00 00:00:00', 0, 7, '', 0);
INSERT INTO `{pre}form_message` VALUES (21, 1, '', '', '55', '', 1, 1, 0, '2020-07-29 18:47:26', '0000-00-00 00:00:00', 0, 7, '', 0);
INSERT INTO `{pre}form_message` VALUES (22, 1, '', '', '444', '', 1, 1, 0, '2020-07-29 18:47:52', '0000-00-00 00:00:00', 0, 7, '', 0);
INSERT INTO `{pre}form_message` VALUES (23, 1, '', '', '444', '', 1, 1, 0, '2020-07-29 18:54:19', '0000-00-00 00:00:00', 0, 22, '', 0);
INSERT INTO `{pre}form_message` VALUES (24, 1, '', '', '444', '', 1, 1, 0, '2020-07-29 18:54:59', '0000-00-00 00:00:00', 0, 23, '', 0);
INSERT INTO `{pre}form_message` VALUES (25, 1, '', '', 'eee', '', 1, 1, 0, '2020-07-29 18:55:12', '0000-00-00 00:00:00', 0, 24, '', 0);
INSERT INTO `{pre}form_message` VALUES (26, 1, '', '', 'www', '', 1, 1, 0, '2020-07-29 18:55:23', '0000-00-00 00:00:00', 0, 14, '', 0);
INSERT INTO `{pre}form_message` VALUES (27, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 18:56:31', '0000-00-00 00:00:00', 0, 26, '', 0);
INSERT INTO `{pre}form_message` VALUES (28, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 18:58:12', '0000-00-00 00:00:00', 0, 27, '', 0);
INSERT INTO `{pre}form_message` VALUES (29, 1, '', '', '222', '', 1, 1, 0, '2020-07-29 18:58:16', '0000-00-00 00:00:00', 0, 28, '', 0);
INSERT INTO `{pre}form_message` VALUES (30, 1, '', '', '444', '', 1, 1, 0, '2020-07-29 18:58:20', '0000-00-00 00:00:00', 0, 29, '', 0);
INSERT INTO `{pre}form_message` VALUES (31, 1, '', '', '5', '', 1, 1, 0, '2020-07-29 18:58:28', '0000-00-00 00:00:00', 0, 30, '', 0);
INSERT INTO `{pre}form_message` VALUES (32, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 19:06:03', '0000-00-00 00:00:00', 0, 17, '', 0);
INSERT INTO `{pre}form_message` VALUES (33, 1, '', '', '44', '', 1, 1, 0, '2020-07-29 19:07:18', '0000-00-00 00:00:00', 0, 17, '', 0);
INSERT INTO `{pre}form_message` VALUES (34, 1, '', '', '4', '', 1, 1, 0, '2020-07-29 19:14:44', '0000-00-00 00:00:00', 0, 33, '', 0);
INSERT INTO `{pre}form_message` VALUES (35, 1, '', '', 'sadghf', '', 1, 1, 0, '2020-07-29 21:56:54', '0000-00-00 00:00:00', 0, 2, '', 0);
INSERT INTO `{pre}form_message` VALUES (36, 1, '', '', '123', '', 1, 1, 0, '2020-07-29 22:01:04', '0000-00-00 00:00:00', 0, 35, '', 0);
INSERT INTO `{pre}form_message` VALUES (37, 1, '', '', 'a\'s\'d\'f', '', 1, 1, 0, '2020-07-29 22:25:06', '0000-00-00 00:00:00', 0, 36, '', 0);
INSERT INTO `{pre}form_message` VALUES (38, 1, '', '', '啊啊啊啊', '', 1, 1, 0, '2020-07-30 09:13:26', '0000-00-00 00:00:00', 0, 37, '', 0);
INSERT INTO `{pre}form_message` VALUES (39, 1, '', '', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '', 1, 1, 0, '2020-07-30 12:03:33', '0000-00-00 00:00:00', 0, 38, '', 0);
INSERT INTO `{pre}form_message` VALUES (40, 1, '', '', '啊实打实打算大苏打啊实打实的啊实打实打算大苏打啊实打实的啊实打实打算大苏打啊实打实的', '', 0, 1, 0, '2020-07-30 12:20:37', '0000-00-00 00:00:00', 0, 39, '', 2);

-- ----------------------------
-- Table structure for gd_label
-- ----------------------------
DROP TABLE IF EXISTS `{pre}label`;
CREATE TABLE `{pre}label`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_user` int(11) NULL DEFAULT NULL,
  `update_user` int(11) NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_label
-- ----------------------------
INSERT INTO `{pre}label` VALUES (1, 'xingbiea_1', '男女', 'radio', '测试标签', 0, 1, '0000-00-00 00:00:00', '2020-08-06 09:50:24', 1, 0, '男');
INSERT INTO `{pre}label` VALUES (2, 'pic', '这是一个标签', 'pic', '测试标签', 0, 1, '0000-00-00 00:00:00', '2020-07-28 13:14:02', 1, 0, '/static/upload/20200728/1595913241_f34df13909eb3ec9ba47.png');
INSERT INTO `{pre}label` VALUES (3, 'beijing', '写作,阅读,游戏,1', 'checkbox', '测试标签', 0, 1, '0000-00-00 00:00:00', '2020-08-19 17:34:51', 1, 0, '阅读,游戏');
INSERT INTO `{pre}label` VALUES (4, 'shandong', '这是一个标签', 'file', '测试标签', 1, 1, '2020-07-05 04:46:05', '2020-07-28 13:09:41', 1, 0, '/static/upload/20200728/1595912978_0a9ac88e1672cbcf9f95.zip');
INSERT INTO `{pre}label` VALUES (5, 'xihu', '', 'editor', '啊啊啊西湖的水', 1, 1, '2020-07-20 13:25:52', '2020-07-28 08:39:41', 1, 0, '<p><em><strong>asdfasdfasfdasf</strong></em></p>');
INSERT INTO `{pre}label` VALUES (6, 'xingqu', '写作,阅读,游戏,音乐', 'select', '兴趣', 1, 1, '2020-07-28 11:26:01', '2020-08-19 17:07:16', 1, 0, '写作');
INSERT INTO `{pre}label` VALUES (7, 'checkbox', 'a,a,a,a,a', 'checkbox', '多选测试', 1, 1, '2020-07-28 12:50:29', '2020-08-19 17:34:19', 1, 0, 'a');

-- ----------------------------
-- Table structure for gd_link
-- ----------------------------
DROP TABLE IF EXISTS `{pre}link`;
CREATE TABLE `{pre}link`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `area_id` int(11) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `link` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `logo` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sorting` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ay_link_sorting`(`sorting`) USING BTREE,
  INDEX `ay_link_gid`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_link
-- ----------------------------
INSERT INTO `{pre}link` VALUES (1, 1, 2, 'JellyCMS', 'https://www.jellycms.cn', '/static/upload/20200726/1595777905_05bebc6dda9305bb9429.png', 88, 1, 0, 1, '0000-00-00 00:00:00', '2020-08-18 20:01:35', 0);
INSERT INTO `{pre}link` VALUES (2, 1, 2, '国栋科技', 'http://www.guodong.tech', '/static/upload/20200729/1595974911_dd3c43721af4c223ca4f.png', 255, 1, 1, 1, '2020-07-01 01:19:01', '2020-07-29 06:21:52', 0);
INSERT INTO `{pre}link` VALUES (3, 1, 2, '北京国栋科技有限公司', 'http://www.guodong.tech', '', 255, 1, 1, 1, '2020-07-01 03:40:22', '2020-07-26 22:16:53', 0);
INSERT INTO `{pre}link` VALUES (4, 1, 2, '果冻CMS', 'https://www.jellycms.cn', '', 0, 1, 1, 1, '2020-07-01 13:36:16', '2020-08-18 20:02:06', 0);
INSERT INTO `{pre}link` VALUES (5, 0, 1, 'asdfasdf', 'http://a.aaa', '', 255, 1, 1, 0, '2020-07-26 21:35:05', '0000-00-00 00:00:00', 0);

-- ----------------------------
-- Table structure for gd_link_group
-- ----------------------------
DROP TABLE IF EXISTS `{pre}link_group`;
CREATE TABLE `{pre}link_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `area_id` int(11) NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `sorting` int(3) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gd_link_group
-- ----------------------------
INSERT INTO `{pre}link_group` VALUES (1, '默认英文分组', 2, 1, 1, '0000-00-00 00:00:00', '2020-07-27 04:03:38', 255, 1, 0);
INSERT INTO `{pre}link_group` VALUES (2, '默认中文分组', 1, 1, 1, '2020-07-05 06:55:11', '2020-07-26 21:48:03', 255, 1, 0);
INSERT INTO `{pre}link_group` VALUES (3, '英文分组', 2, 1, 1, '2020-07-26 21:40:35', '2020-07-26 21:48:36', 255, 1, 0);

-- ----------------------------
-- Table structure for gd_logs
-- ----------------------------
DROP TABLE IF EXISTS `{pre}logs`;
CREATE TABLE `{pre}logs`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日志名',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日志描述',
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ip地址',
  `os` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作系统',
  `browser` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '浏览器',
  `create_user` int(10) NOT NULL COMMENT '创建用户',
  `create_time` timestamp(0) NOT NULL COMMENT '创建时间',
  `mobile` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '移动端',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 303 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_logs
-- ----------------------------
INSERT INTO `{pre}logs` VALUES (1, 'syslog-clear', '清空日志', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 07:44:36', '', 1);
INSERT INTO `{pre}logs` VALUES (2, 'syslog-clear', '清空日志', '127.0.0.1', 'Android', 'Chrome', 1, '2020-08-04 07:44:57', 'Android', 1);
INSERT INTO `{pre}logs` VALUES (3, 'syslog-clear', '清空日志', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 08:17:32', '', 1);
INSERT INTO `{pre}logs` VALUES (4, 'name', '$description', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 08:23:16', '', 1);
INSERT INTO `{pre}logs` VALUES (5, 'name', '$description', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 08:23:18', '', 1);
INSERT INTO `{pre}logs` VALUES (6, 'menu', '欢迎页面菜单添加/编辑', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 08:25:45', '', 1);
INSERT INTO `{pre}logs` VALUES (7, 'menu', '菜单添加/编辑:欢迎页面', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 08:26:50', '', 1);
INSERT INTO `{pre}logs` VALUES (8, 'menu', '菜单添加/编辑:欢迎页面', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 08:29:23', '', 1);
INSERT INTO `{pre}logs` VALUES (9, 'menu', '菜单添加/编辑:系统管理', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 08:29:35', '', 1);
INSERT INTO `{pre}logs` VALUES (10, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 09:11:06', '', 1);
INSERT INTO `{pre}logs` VALUES (11, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 09:11:09', '', 1);
INSERT INTO `{pre}logs` VALUES (12, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 09:12:17', '', 1);
INSERT INTO `{pre}logs` VALUES (13, 'menu', 'ID82菜单编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:06:24', '', 1);
INSERT INTO `{pre}logs` VALUES (14, 'menu', 'ID82菜单编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:06:25', '', 1);
INSERT INTO `{pre}logs` VALUES (15, 'syslog-clear', '清空日志', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:07:05', '', 1);
INSERT INTO `{pre}logs` VALUES (16, 'menu', 'ID82菜单编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:07:13', '', 1);
INSERT INTO `{pre}logs` VALUES (17, 'menu', 'ID82菜单编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:07:14', '', 1);
INSERT INTO `{pre}logs` VALUES (18, 'menu', 'ID82菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:07:42', '', 1);
INSERT INTO `{pre}logs` VALUES (19, 'menu', 'ID82菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:07:43', '', 1);
INSERT INTO `{pre}logs` VALUES (20, 'menu', 'ID:82,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:08:00', '', 1);
INSERT INTO `{pre}logs` VALUES (21, 'menu', 'ID:82,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:08:00', '', 1);
INSERT INTO `{pre}logs` VALUES (22, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:25:11', '', 1);
INSERT INTO `{pre}logs` VALUES (23, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:25:14', '', 1);
INSERT INTO `{pre}logs` VALUES (24, 'syslog-clear', '清空日志', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-04 12:25:32', '', 1);
INSERT INTO `{pre}logs` VALUES (25, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-05 12:06:47', '', 1);
INSERT INTO `{pre}logs` VALUES (26, 'menu', 'ID:82,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-06 07:39:53', '', 1);
INSERT INTO `{pre}logs` VALUES (27, 'menu', 'ID:82,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-06 07:39:54', '', 1);
INSERT INTO `{pre}logs` VALUES (28, 'menu', 'ID:82,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-06 07:39:55', '', 1);
INSERT INTO `{pre}logs` VALUES (29, 'menu', 'ID:57,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-06 07:39:56', '', 1);
INSERT INTO `{pre}logs` VALUES (30, 'menu', 'ID:57,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-06 07:39:56', '', 1);
INSERT INTO `{pre}logs` VALUES (31, 'menu', 'ID:30,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-06 07:39:57', '', 1);
INSERT INTO `{pre}logs` VALUES (32, 'menu', 'ID:30,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-06 07:39:58', '', 1);
INSERT INTO `{pre}logs` VALUES (33, 'menu', 'ID:10,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-06 07:39:58', '', 1);
INSERT INTO `{pre}logs` VALUES (34, 'menu', 'ID:10,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-06 07:39:59', '', 1);
INSERT INTO `{pre}logs` VALUES (35, 'syslog-clear', '清空日志', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-07 15:43:20', '', 1);
INSERT INTO `{pre}logs` VALUES (36, 'menu', 'ID:78,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-07 17:34:47', '', 1);
INSERT INTO `{pre}logs` VALUES (37, 'syslog-clear', '清空日志', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-07 18:48:57', '', 1);
INSERT INTO `{pre}logs` VALUES (38, 'menu', 'ID:75,菜单编辑状态', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-09 16:13:09', '', 1);
INSERT INTO `{pre}logs` VALUES (39, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-09 16:13:24', '', 1);
INSERT INTO `{pre}logs` VALUES (40, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-09 16:13:40', '', 1);
INSERT INTO `{pre}logs` VALUES (41, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-09 16:13:59', '', 1);
INSERT INTO `{pre}logs` VALUES (42, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-09 16:14:12', '', 1);
INSERT INTO `{pre}logs` VALUES (43, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-09 16:14:19', '', 1);
INSERT INTO `{pre}logs` VALUES (44, 'menu', '菜单添加/编辑:在线更新', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-09 16:14:28', '', 1);
INSERT INTO `{pre}logs` VALUES (45, 'menu', '菜单添加/编辑:升级管理', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-09 16:14:42', '', 1);
INSERT INTO `{pre}logs` VALUES (46, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 11:29:45', '', 1);
INSERT INTO `{pre}logs` VALUES (47, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 11:32:35', '', 1);
INSERT INTO `{pre}logs` VALUES (48, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 11:37:13', '', 1);
INSERT INTO `{pre}logs` VALUES (49, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 11:38:33', '', 1);
INSERT INTO `{pre}logs` VALUES (50, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 11:38:58', '', 1);
INSERT INTO `{pre}logs` VALUES (51, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 11:39:12', '', 1);
INSERT INTO `{pre}logs` VALUES (52, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 11:44:13', '', 1);
INSERT INTO `{pre}logs` VALUES (53, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 11:45:16', '', 1);
INSERT INTO `{pre}logs` VALUES (54, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 11:45:49', '', 1);
INSERT INTO `{pre}logs` VALUES (55, 'menu', '菜单添加/编辑:广告位管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 14:59:30', '', 1);
INSERT INTO `{pre}logs` VALUES (56, 'menu', '菜单添加/编辑:系统管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-17 15:41:04', '', 1);
INSERT INTO `{pre}logs` VALUES (57, 'menu', '菜单添加/编辑:案例列表', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:41:05', '', 1);
INSERT INTO `{pre}logs` VALUES (58, 'menu', '菜单添加/编辑:案例列表', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:41:49', '', 1);
INSERT INTO `{pre}logs` VALUES (59, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:42:13', '', 1);
INSERT INTO `{pre}logs` VALUES (60, 'menu', '菜单添加/编辑:招聘列表', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:42:22', '', 1);
INSERT INTO `{pre}logs` VALUES (61, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:42:48', '', 1);
INSERT INTO `{pre}logs` VALUES (62, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:42:50', '', 1);
INSERT INTO `{pre}logs` VALUES (63, 'menu', '菜单删除:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:43:05', '', 1);
INSERT INTO `{pre}logs` VALUES (64, 'menu', '菜单添加/编辑:专题内容', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:43:16', '', 1);
INSERT INTO `{pre}logs` VALUES (65, 'menu', '菜单添加/编辑:专题内容', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:43:17', '', 1);
INSERT INTO `{pre}logs` VALUES (66, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:44:03', '', 1);
INSERT INTO `{pre}logs` VALUES (67, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:44:09', '', 1);
INSERT INTO `{pre}logs` VALUES (68, 'menu', '菜单添加/编辑:产品列表', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:45:16', '', 1);
INSERT INTO `{pre}logs` VALUES (69, 'menu', '菜单删除:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 19:45:37', '', 1);
INSERT INTO `{pre}logs` VALUES (70, 'menu', '菜单添加/编辑:扩展内容', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 20:30:59', '', 1);
INSERT INTO `{pre}logs` VALUES (71, 'menu', '菜单添加/编辑:基础内容', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 20:31:55', '', 1);
INSERT INTO `{pre}logs` VALUES (72, 'menu', '菜单添加/编辑:扩展内容', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 20:35:26', '', 1);
INSERT INTO `{pre}logs` VALUES (73, 'menu', '菜单添加/编辑:基础内容', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 20:41:48', '', 1);
INSERT INTO `{pre}logs` VALUES (74, 'menu', '菜单添加/编辑:全局配置', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 20:43:55', '', 1);
INSERT INTO `{pre}logs` VALUES (75, 'menu', '菜单添加/编辑:权限分组', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:12:35', '', 1);
INSERT INTO `{pre}logs` VALUES (76, 'menu', '菜单添加/编辑:系统用户', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:12:51', '', 1);
INSERT INTO `{pre}logs` VALUES (77, 'menu', '菜单添加/编辑:扩展内容', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:13:57', '', 1);
INSERT INTO `{pre}logs` VALUES (78, 'menu', '菜单添加/编辑:系统日志', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:15:55', '', 1);
INSERT INTO `{pre}logs` VALUES (79, 'menu', '菜单添加/编辑:权限管理', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:17:37', '', 1);
INSERT INTO `{pre}logs` VALUES (80, 'menu', '菜单添加/编辑:区域管理', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:18:17', '', 1);
INSERT INTO `{pre}logs` VALUES (81, 'menu', '菜单添加/编辑:系统角色', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:18:55', '', 1);
INSERT INTO `{pre}logs` VALUES (82, 'menu', '菜单添加/编辑:在线更新', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:19:37', '', 1);
INSERT INTO `{pre}logs` VALUES (83, 'menu', '菜单添加/编辑:在线更新', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:19:55', '', 1);
INSERT INTO `{pre}logs` VALUES (84, 'menu', '菜单添加/编辑:定制标签', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:21:26', '', 1);
INSERT INTO `{pre}logs` VALUES (85, 'menu', '菜单添加/编辑:模型字段', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:22:31', '', 1);
INSERT INTO `{pre}logs` VALUES (86, 'menu', '菜单添加/编辑:模型管理', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:23:05', '', 1);
INSERT INTO `{pre}logs` VALUES (87, 'menu', '菜单添加/编辑:系统管理', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:23:50', '', 1);
INSERT INTO `{pre}logs` VALUES (88, 'menu', '菜单添加/编辑:文章内链', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:24:55', '', 1);
INSERT INTO `{pre}logs` VALUES (89, 'menu', '菜单添加/编辑:文章内链', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:25:32', '', 1);
INSERT INTO `{pre}logs` VALUES (90, 'menu', '菜单添加/编辑:自定义表单', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:26:57', '', 1);
INSERT INTO `{pre}logs` VALUES (91, 'menu', '菜单添加/编辑:留言信息', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:28:31', '', 1);
INSERT INTO `{pre}logs` VALUES (92, 'menu', '菜单添加/编辑:留言信息', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:32:09', '', 1);
INSERT INTO `{pre}logs` VALUES (93, 'menu', '菜单添加/编辑:公司信息', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-18 22:39:26', '', 1);
INSERT INTO `{pre}logs` VALUES (94, 'menu', '菜单添加/编辑:模板管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-19 09:45:54', '', 1);
INSERT INTO `{pre}logs` VALUES (95, 'menu', '菜单添加/编辑:模板管理', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-19 09:46:45', '', 1);
INSERT INTO `{pre}logs` VALUES (96, 'menu', '菜单添加/编辑:扩展功能', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 16:58:57', '', 1);
INSERT INTO `{pre}logs` VALUES (97, 'menu', '菜单添加/编辑:内容管理', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 16:59:29', '', 1);
INSERT INTO `{pre}logs` VALUES (98, 'menu', '菜单添加/编辑:基础配置', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 16:59:51', '', 1);
INSERT INTO `{pre}logs` VALUES (99, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 17:00:23', '', 1);
INSERT INTO `{pre}logs` VALUES (100, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 17:00:26', '', 1);
INSERT INTO `{pre}logs` VALUES (101, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 20:09:21', '', 1);
INSERT INTO `{pre}logs` VALUES (102, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 20:09:24', '', 1);
INSERT INTO `{pre}logs` VALUES (103, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 20:09:29', '', 1);
INSERT INTO `{pre}logs` VALUES (104, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 20:09:33', '', 1);
INSERT INTO `{pre}logs` VALUES (105, 'menu', '菜单添加/编辑:', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-19 20:09:36', '', 1);
INSERT INTO `{pre}logs` VALUES (106, 'area', '[区域]添加/编辑:中文', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:13:35', '', 1);
INSERT INTO `{pre}logs` VALUES (107, 'area', '[区域]添加/编辑:中文[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:22:03', '', 1);
INSERT INTO `{pre}logs` VALUES (108, 'area', '[区域]添加/编辑:中文[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:24:24', '', 1);
INSERT INTO `{pre}logs` VALUES (109, 'area', '[区域]添加/编辑:1111[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:26:17', '', 1);
INSERT INTO `{pre}logs` VALUES (110, 'area', '[区域]添加/编辑:1[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:27:28', '', 1);
INSERT INTO `{pre}logs` VALUES (111, 'area', '[区域]添加/编辑:1[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:27:56', '', 1);
INSERT INTO `{pre}logs` VALUES (112, 'area', '[区域]编辑字段surname为cn1[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:35:01', '', 1);
INSERT INTO `{pre}logs` VALUES (113, 'area', '[区域]编辑字段surname为cn[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:35:16', '', 1);
INSERT INTO `{pre}logs` VALUES (114, 'area', '[区域]修改默认状态[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:40:31', '', 1);
INSERT INTO `{pre}logs` VALUES (115, 'area', '[区域]修改默认状态[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:40:33', '', 1);
INSERT INTO `{pre}logs` VALUES (116, 'area', '[区域]修改默认状态[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:41:06', '', 1);
INSERT INTO `{pre}logs` VALUES (117, 'auth', '[权限]添加/编辑:欢迎页面[ID:82]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:43:54', '', 1);
INSERT INTO `{pre}logs` VALUES (118, 'company', '[公司信息]编辑[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 01:48:05', '', 1);
INSERT INTO `{pre}logs` VALUES (119, 'menu', 'ID:7,菜单编辑状态', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 08:27:17', '', 1);
INSERT INTO `{pre}logs` VALUES (120, 'menu', 'ID:7,菜单编辑状态', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 08:27:21', '', 1);
INSERT INTO `{pre}logs` VALUES (121, 'menu', 'ID:7,菜单编辑状态', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 08:46:02', '', 1);
INSERT INTO `{pre}logs` VALUES (122, 'menu', 'ID:7,菜单编辑状态', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 08:46:04', '', 1);
INSERT INTO `{pre}logs` VALUES (123, 'menu', 'ID:7,菜单编辑状态', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 08:46:05', '', 1);
INSERT INTO `{pre}logs` VALUES (124, 'menu', 'ID:7,菜单编辑状态', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 08:46:31', '', 1);
INSERT INTO `{pre}logs` VALUES (125, 'menu', 'ID:1,菜单编辑状态', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 08:47:28', '', 1);
INSERT INTO `{pre}logs` VALUES (126, 'label', '[定制标签]修改状态:[ID:7]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 08:50:28', '', 1);
INSERT INTO `{pre}logs` VALUES (127, 'label', '[定制标签]修改状态:[ID:7]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 08:50:31', '', 1);
INSERT INTO `{pre}logs` VALUES (128, 'auth', '[权限]编辑字段sorting为666[ID:82]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-20 10:25:16', '', 1);
INSERT INTO `{pre}logs` VALUES (129, 'syslog-clear', '清空日志', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-20 10:31:29', '', 0);
INSERT INTO `{pre}logs` VALUES (130, 'auth', '[权限]添加/编辑:内容管理[ID:30]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 13:32:13', '', 0);
INSERT INTO `{pre}logs` VALUES (131, 'auth', '[权限]添加/编辑:专题内容[ID:31]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 13:32:44', '', 0);
INSERT INTO `{pre}logs` VALUES (132, 'auth', '[权限]添加/编辑:编辑[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 13:34:47', '', 0);
INSERT INTO `{pre}logs` VALUES (133, 'auth', '[权限]添加/编辑:编辑/新增[ID:159]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 13:35:16', '', 0);
INSERT INTO `{pre}logs` VALUES (134, 'auth', '[权限]删除[ID:32]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 13:40:21', '', 0);
INSERT INTO `{pre}logs` VALUES (135, 'auth', '[权限]添加/编辑:新闻列表[ID:76]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 13:41:20', '', 0);
INSERT INTO `{pre}logs` VALUES (136, 'auth', '[权限]添加/编辑:专题内容[ID:31]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 13:41:51', '', 0);
INSERT INTO `{pre}logs` VALUES (137, 'auth', '[权限]编辑字段controller为1[ID:10]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 13:56:38', '', 0);
INSERT INTO `{pre}logs` VALUES (138, 'auth', '[权限]编辑字段controller为[ID:10]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 13:56:47', '', 0);
INSERT INTO `{pre}logs` VALUES (139, 'company', '[配置参数]编辑', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-20 14:25:37', '', 0);
INSERT INTO `{pre}logs` VALUES (140, 'company', '[配置参数]编辑', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-20 14:25:44', '', 0);
INSERT INTO `{pre}logs` VALUES (141, 'auth', '[权限]添加/编辑:添加/编辑[ID:159]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:39:16', '', 0);
INSERT INTO `{pre}logs` VALUES (142, 'auth', '[权限]添加/编辑:编辑页面[ID:106]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:41:54', '', 0);
INSERT INTO `{pre}logs` VALUES (143, 'auth', '[权限]删除[ID:103]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:44:47', '', 0);
INSERT INTO `{pre}logs` VALUES (144, 'auth', '[权限]删除[ID:106]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:44:51', '', 0);
INSERT INTO `{pre}logs` VALUES (145, 'auth', '[权限]删除[ID:127]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:44:59', '', 0);
INSERT INTO `{pre}logs` VALUES (146, 'auth', '[权限]添加/编辑:状态开关[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:46:35', '', 0);
INSERT INTO `{pre}logs` VALUES (147, 'auth', '[权限]添加/编辑:移动[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:47:47', '', 0);
INSERT INTO `{pre}logs` VALUES (148, 'auth', '[权限]添加/编辑:复制[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:48:14', '', 0);
INSERT INTO `{pre}logs` VALUES (149, 'auth', '[权限]添加/编辑:批量删除[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:49:06', '', 0);
INSERT INTO `{pre}logs` VALUES (150, 'auth', '[权限]添加/编辑:table中编辑[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:51:23', '', 0);
INSERT INTO `{pre}logs` VALUES (151, 'auth', '[权限]添加/编辑:列表内容[ID:76]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:55:19', '', 0);
INSERT INTO `{pre}logs` VALUES (152, 'auth', '[权限]删除[ID:129]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:04', '', 0);
INSERT INTO `{pre}logs` VALUES (153, 'auth', '[权限]删除[ID:117]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:07', '', 0);
INSERT INTO `{pre}logs` VALUES (154, 'auth', '[权限]删除[ID:116]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:10', '', 0);
INSERT INTO `{pre}logs` VALUES (155, 'auth', '[权限]删除[ID:113]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:12', '', 0);
INSERT INTO `{pre}logs` VALUES (156, 'auth', '[权限]删除[ID:114]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:15', '', 0);
INSERT INTO `{pre}logs` VALUES (157, 'auth', '[权限]删除[ID:115]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:18', '', 0);
INSERT INTO `{pre}logs` VALUES (158, 'auth', '[权限]删除[ID:79]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:26', '', 0);
INSERT INTO `{pre}logs` VALUES (159, 'auth', '[权限]删除[ID:108]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:31', '', 0);
INSERT INTO `{pre}logs` VALUES (160, 'auth', '[权限]删除[ID:109]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:33', '', 0);
INSERT INTO `{pre}logs` VALUES (161, 'auth', '[权限]删除[ID:110]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:35', '', 0);
INSERT INTO `{pre}logs` VALUES (162, 'auth', '[权限]删除[ID:111]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:37', '', 0);
INSERT INTO `{pre}logs` VALUES (163, 'auth', '[权限]删除[ID:112]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:39', '', 0);
INSERT INTO `{pre}logs` VALUES (164, 'auth', '[权限]删除[ID:128]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:41', '', 0);
INSERT INTO `{pre}logs` VALUES (165, 'auth', '[权限]删除[ID:77]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 14:56:44', '', 0);
INSERT INTO `{pre}logs` VALUES (166, 'auth', '[权限]添加/编辑:编辑[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:00:37', '', 0);
INSERT INTO `{pre}logs` VALUES (167, 'auth', '[权限]添加/编辑:扩展功能[ID:57]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:01:37', '', 0);
INSERT INTO `{pre}logs` VALUES (168, 'auth', '[权限]添加/编辑:审核[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:03:12', '', 0);
INSERT INTO `{pre}logs` VALUES (169, 'auth', '[权限]添加/编辑:回复[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:03:45', '', 0);
INSERT INTO `{pre}logs` VALUES (170, 'auth', '[权限]添加/编辑:状态开关[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:04:45', '', 0);
INSERT INTO `{pre}logs` VALUES (171, 'auth', '[权限]添加/编辑:删除[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:05:12', '', 0);
INSERT INTO `{pre}logs` VALUES (172, 'auth', '[权限]删除[ID:126]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:06:45', '', 0);
INSERT INTO `{pre}logs` VALUES (173, 'auth', '[权限]添加/编辑:广告管理[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:10:56', '', 0);
INSERT INTO `{pre}logs` VALUES (174, 'auth', '[权限]添加/编辑:修改状态[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:14:37', '', 0);
INSERT INTO `{pre}logs` VALUES (175, 'auth', '[权限]添加/编辑:在table中修改[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:15:30', '', 0);
INSERT INTO `{pre}logs` VALUES (176, 'content', '[内容管理]编辑字段值为256[ID:1]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-20 15:16:53', '', 0);
INSERT INTO `{pre}logs` VALUES (177, 'auth', '[权限]删除[ID:7]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:36:04', '', 0);
INSERT INTO `{pre}logs` VALUES (178, 'auth', '[权限]删除[ID:9]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:36:18', '', 0);
INSERT INTO `{pre}logs` VALUES (179, 'auth', '[权限]删除[ID:73]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:36:22', '', 0);
INSERT INTO `{pre}logs` VALUES (180, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:48:46', '', 0);
INSERT INTO `{pre}logs` VALUES (181, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:48:51', '', 0);
INSERT INTO `{pre}logs` VALUES (182, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:50:00', '', 0);
INSERT INTO `{pre}logs` VALUES (183, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:51:12', '', 0);
INSERT INTO `{pre}logs` VALUES (184, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:51:14', '', 0);
INSERT INTO `{pre}logs` VALUES (185, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:56:29', '', 0);
INSERT INTO `{pre}logs` VALUES (186, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:56:30', '', 0);
INSERT INTO `{pre}logs` VALUES (187, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:57:42', '', 0);
INSERT INTO `{pre}logs` VALUES (188, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:57:45', '', 0);
INSERT INTO `{pre}logs` VALUES (189, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:58:21', '', 0);
INSERT INTO `{pre}logs` VALUES (190, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:58:23', '', 0);
INSERT INTO `{pre}logs` VALUES (191, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 15:58:25', '', 0);
INSERT INTO `{pre}logs` VALUES (192, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 16:49:57', '', 0);
INSERT INTO `{pre}logs` VALUES (193, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 16:55:07', '', 0);
INSERT INTO `{pre}logs` VALUES (194, 'auth', '[权限]添加/编辑:配置参数[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 17:40:02', '', 0);
INSERT INTO `{pre}logs` VALUES (195, 'auth', '[权限]添加/编辑:编辑[ID:165]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 17:40:18', '', 0);
INSERT INTO `{pre}logs` VALUES (196, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:25:24', '', 0);
INSERT INTO `{pre}logs` VALUES (197, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:26:55', '', 0);
INSERT INTO `{pre}logs` VALUES (198, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:31:57', '', 0);
INSERT INTO `{pre}logs` VALUES (199, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:32:22', '', 0);
INSERT INTO `{pre}logs` VALUES (200, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:32:37', '', 0);
INSERT INTO `{pre}logs` VALUES (201, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:33:14', '', 0);
INSERT INTO `{pre}logs` VALUES (202, 'site', '[站点信息]编辑', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:33:20', '', 0);
INSERT INTO `{pre}logs` VALUES (203, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:33:35', '', 0);
INSERT INTO `{pre}logs` VALUES (204, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:34:24', '', 0);
INSERT INTO `{pre}logs` VALUES (205, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:34:39', '', 0);
INSERT INTO `{pre}logs` VALUES (206, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:42:24', '', 0);
INSERT INTO `{pre}logs` VALUES (207, 'auth', '[权限]添加/编辑:首页[ID:158]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:44:42', '', 0);
INSERT INTO `{pre}logs` VALUES (208, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:45:21', '', 0);
INSERT INTO `{pre}logs` VALUES (209, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:48:44', '', 0);
INSERT INTO `{pre}logs` VALUES (210, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:54:04', '', 0);
INSERT INTO `{pre}logs` VALUES (211, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-20 20:54:22', '', 0);
INSERT INTO `{pre}logs` VALUES (212, 'auth', '[权限]编辑字段值为[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 08:59:16', '', 0);
INSERT INTO `{pre}logs` VALUES (213, 'auth', '[权限]编辑字段值为[ID:29]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 08:59:45', '', 0);
INSERT INTO `{pre}logs` VALUES (214, 'auth', '[权限]编辑字段值为[ID:12]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 08:59:48', '', 0);
INSERT INTO `{pre}logs` VALUES (215, 'auth', '[权限]编辑字段值为[ID:31]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 08:59:52', '', 0);
INSERT INTO `{pre}logs` VALUES (216, 'auth', '[权限]编辑字段值为[ID:76]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 08:59:55', '', 0);
INSERT INTO `{pre}logs` VALUES (217, 'auth', '[权限]编辑字段值为[ID:36]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:00', '', 0);
INSERT INTO `{pre}logs` VALUES (218, 'auth', '[权限]编辑字段值为[ID:58]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:02', '', 0);
INSERT INTO `{pre}logs` VALUES (219, 'auth', '[权限]编辑字段值为[ID:186]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:04', '', 0);
INSERT INTO `{pre}logs` VALUES (220, 'auth', '[权限]编辑字段值为[ID:55]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:07', '', 0);
INSERT INTO `{pre}logs` VALUES (221, 'auth', '[权限]编辑字段值为[ID:50]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:12', '', 0);
INSERT INTO `{pre}logs` VALUES (222, 'auth', '[权限]编辑字段值为[ID:51]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:14', '', 0);
INSERT INTO `{pre}logs` VALUES (223, 'auth', '[权限]编辑字段值为[ID:52]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:17', '', 0);
INSERT INTO `{pre}logs` VALUES (224, 'auth', '[权限]编辑字段值为[ID:60]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:19', '', 0);
INSERT INTO `{pre}logs` VALUES (225, 'auth', '[权限]编辑字段值为[ID:61]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:22', '', 0);
INSERT INTO `{pre}logs` VALUES (226, 'auth', '[权限]编辑字段值为[ID:170]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:25', '', 0);
INSERT INTO `{pre}logs` VALUES (227, 'auth', '[权限]编辑字段值为[ID:3]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:29', '', 0);
INSERT INTO `{pre}logs` VALUES (228, 'auth', '[权限]编辑字段值为[ID:4]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:32', '', 0);
INSERT INTO `{pre}logs` VALUES (229, 'auth', '[权限]编辑字段值为[ID:5]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:35', '', 0);
INSERT INTO `{pre}logs` VALUES (230, 'auth', '[权限]编辑字段值为[ID:6]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:37', '', 0);
INSERT INTO `{pre}logs` VALUES (231, 'auth', '[权限]编辑字段值为[ID:8]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:40', '', 0);
INSERT INTO `{pre}logs` VALUES (232, 'auth', '[权限]编辑字段值为[ID:74]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:42', '', 0);
INSERT INTO `{pre}logs` VALUES (233, 'auth', '[权限]编辑字段值为[ID:75]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:45', '', 0);
INSERT INTO `{pre}logs` VALUES (234, 'auth', '[权限]编辑字段值为[ID:2]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:00:49', '', 0);
INSERT INTO `{pre}logs` VALUES (235, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:02:10', '', 0);
INSERT INTO `{pre}logs` VALUES (236, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:03:35', '', 0);
INSERT INTO `{pre}logs` VALUES (237, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:04:16', '', 0);
INSERT INTO `{pre}logs` VALUES (238, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:04:17', '', 0);
INSERT INTO `{pre}logs` VALUES (239, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:05:00', '', 0);
INSERT INTO `{pre}logs` VALUES (240, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:05:16', '', 0);
INSERT INTO `{pre}logs` VALUES (241, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:05:18', '', 0);
INSERT INTO `{pre}logs` VALUES (242, 'sorts', '[内容栏目]修改状态[ID:11]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:05:19', '', 0);
INSERT INTO `{pre}logs` VALUES (243, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:05:55', '', 0);
INSERT INTO `{pre}logs` VALUES (244, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:06:38', '', 0);
INSERT INTO `{pre}logs` VALUES (245, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:07:03', '', 0);
INSERT INTO `{pre}logs` VALUES (246, 'single', '[专题内容]修改状态[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:07:25', '', 0);
INSERT INTO `{pre}logs` VALUES (247, 'single', '[专题内容]修改状态[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:07:26', '', 0);
INSERT INTO `{pre}logs` VALUES (248, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:07:38', '', 0);
INSERT INTO `{pre}logs` VALUES (249, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:08:04', '', 0);
INSERT INTO `{pre}logs` VALUES (250, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:08:33', '', 0);
INSERT INTO `{pre}logs` VALUES (251, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:10:48', '', 0);
INSERT INTO `{pre}logs` VALUES (252, 'model', '[模型字段]编辑/添加:[ID:2]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:11:18', '', 0);
INSERT INTO `{pre}logs` VALUES (253, 'model', '[模型字段]编辑/添加:[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:14:10', '', 0);
INSERT INTO `{pre}logs` VALUES (254, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:14:31', '', 0);
INSERT INTO `{pre}logs` VALUES (255, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:17:28', '', 0);
INSERT INTO `{pre}logs` VALUES (256, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:18:48', '', 0);
INSERT INTO `{pre}logs` VALUES (257, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:20:01', '', 0);
INSERT INTO `{pre}logs` VALUES (258, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:21:24', '', 0);
INSERT INTO `{pre}logs` VALUES (259, 'slide', '[幻灯片分组]修改状态[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:22:24', '', 0);
INSERT INTO `{pre}logs` VALUES (260, 'slide', '[幻灯片分组]修改状态[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:22:25', '', 0);
INSERT INTO `{pre}logs` VALUES (261, 'slide', '[幻灯片分组]编辑/新增[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:22:43', '', 0);
INSERT INTO `{pre}logs` VALUES (262, 'content', '[内容管理]编辑 [ID:2]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 09:24:13', '', 0);
INSERT INTO `{pre}logs` VALUES (263, 'auth', '[权限]添加/编辑:轮播图分组[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:27:25', '', 0);
INSERT INTO `{pre}logs` VALUES (264, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:29:23', '', 0);
INSERT INTO `{pre}logs` VALUES (265, 'auth', '[权限]添加/编辑:友链分组[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:30:25', '', 0);
INSERT INTO `{pre}logs` VALUES (266, 'content', '[内容管理]编辑 [ID:3]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 09:30:20', '', 0);
INSERT INTO `{pre}logs` VALUES (267, 'content', '[内容管理]编辑字段值为新手如何选域名和购买域名?[ID:3]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 09:30:43', '', 0);
INSERT INTO `{pre}logs` VALUES (268, 'content', '[内容管理]编辑字段值为新手如何搭建自己的网站?[ID:2]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 09:30:47', '', 0);
INSERT INTO `{pre}logs` VALUES (269, 'formfield', '[自定义表单字段]修改必填[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:32:10', '', 0);
INSERT INTO `{pre}logs` VALUES (270, 'formfield', '[自定义表单字段]修改必填[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:32:11', '', 0);
INSERT INTO `{pre}logs` VALUES (271, 'content', '[内容管理]编辑 [ID:3]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 09:33:03', '', 0);
INSERT INTO `{pre}logs` VALUES (272, 'auth', '[权限]添加/编辑:表单字段管理[ID:]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:33:17', '', 0);
INSERT INTO `{pre}logs` VALUES (273, 'content', '[内容管理]编辑 [ID:3]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 09:33:23', '', 0);
INSERT INTO `{pre}logs` VALUES (274, 'content', '[内容管理]编辑 [ID:2]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 09:34:02', '', 0);
INSERT INTO `{pre}logs` VALUES (275, 'company', '[配置参数]编辑', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 09:36:03', '', 0);
INSERT INTO `{pre}logs` VALUES (276, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:37:02', '', 0);
INSERT INTO `{pre}logs` VALUES (277, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:38:52', '', 0);
INSERT INTO `{pre}logs` VALUES (278, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:39:41', '', 0);
INSERT INTO `{pre}logs` VALUES (279, 'menu', '[菜单]编辑字段值为:[ID:56]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 09:39:37', '', 0);
INSERT INTO `{pre}logs` VALUES (280, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:40:44', '', 0);
INSERT INTO `{pre}logs` VALUES (281, 'sysuser', '[系统用户]编辑/新增[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:41:01', '', 0);
INSERT INTO `{pre}logs` VALUES (282, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:56:07', '', 0);
INSERT INTO `{pre}logs` VALUES (283, 'auth', '[权限]编辑字段值为checkAuth[ID:185]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:56:35', '', 0);
INSERT INTO `{pre}logs` VALUES (284, 'auth', '[权限]删除[ID:184]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:56:46', '', 0);
INSERT INTO `{pre}logs` VALUES (285, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:58:10', '', 0);
INSERT INTO `{pre}logs` VALUES (286, 'upgrade', '[系统升级]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 09:58:40', '', 0);
INSERT INTO `{pre}logs` VALUES (287, 'role', '[角色管理]编辑/新增：超级管理员[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 10:08:20', '', 0);
INSERT INTO `{pre}logs` VALUES (288, 'sysuser', '[系统用户]修改状态[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 10:08:42', '', 0);
INSERT INTO `{pre}logs` VALUES (289, 'sysuser', '[系统用户]修改状态[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 10:08:42', '', 0);
INSERT INTO `{pre}logs` VALUES (290, 'sysuser', '[系统用户]修改状态[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 10:08:46', '', 0);
INSERT INTO `{pre}logs` VALUES (291, 'sysuser', '[系统用户]编辑/新增[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 10:08:49', '', 0);
INSERT INTO `{pre}logs` VALUES (292, 'menu', '[菜单]修改状态:[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 10:08:59', '', 0);
INSERT INTO `{pre}logs` VALUES (293, 'menu', '[菜单]修改状态:[ID:1]', '127.0.0.1', 'Windows 10', 'Chrome', 1, '2020-08-21 10:09:00', '', 0);
INSERT INTO `{pre}logs` VALUES (294, 'content', '[内容管理]编辑 [ID:4]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 11:04:09', '', 0);
INSERT INTO `{pre}logs` VALUES (295, 'content', '[内容管理]编辑 [ID:4]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 11:04:42', '', 0);
INSERT INTO `{pre}logs` VALUES (296, 'content', '[内容管理]编辑 [ID:4]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 11:05:06', '', 0);
INSERT INTO `{pre}logs` VALUES (297, 'content', '[内容管理]编辑 [ID:5]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 11:06:21', '', 0);
INSERT INTO `{pre}logs` VALUES (298, 'content', '[内容管理]编辑 [ID:6]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 11:08:33', '', 0);
INSERT INTO `{pre}logs` VALUES (299, 'content', '[内容管理]编辑 [ID:7]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 11:10:40', '', 0);
INSERT INTO `{pre}logs` VALUES (300, 'content', '[内容管理]编辑 [ID:6]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 11:11:21', '', 0);
INSERT INTO `{pre}logs` VALUES (301, 'content', '[内容管理]编辑 [ID:6]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 11:11:37', '', 0);
INSERT INTO `{pre}logs` VALUES (302, 'content', '[内容管理]编辑 [ID:7]', '127.0.0.1', 'Windows 7', 'Chrome', 1, '2020-08-21 11:11:59', '', 0);

-- ----------------------------
-- Table structure for gd_menu
-- ----------------------------
DROP TABLE IF EXISTS `{pre}menu`;
CREATE TABLE `{pre}menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `area_id` int(11) NOT NULL,
  `controller` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '控制器',
  `action` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'action',
  `params` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数',
  `url` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `roles_id` json NOT NULL COMMENT '角色IDS，绑定角色',
  `sorting` int(3) NOT NULL,
  `status` int(1) NOT NULL,
  `shortcut` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `is_fast` tinyint(1) NULL DEFAULT 0 COMMENT '是否首页快捷显示',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ay_menu_sorting`(`sorting`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_menu
-- ----------------------------
INSERT INTO `{pre}menu` VALUES (1, 0, '系统管理', 1, '', '', '', '', '[1, 2]', 108, 1, '0', 'fa-cogs', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:23:50', 0, 0);
INSERT INTO `{pre}menu` VALUES (2, 1, '区域管理', 1, 'Area', 'index', '', '/Area/index', '[1, 2]', 9, 1, '1', 'fa-language', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:18:17', 0, 0);
INSERT INTO `{pre}menu` VALUES (3, 1, '菜单系统', 1, 'Menu', 'index', '', '/Menu/index', '[1, 2, 11]', 8, 1, '0', 'fa-bars', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 1);
INSERT INTO `{pre}menu` VALUES (4, 1, '系统角色', 1, 'Role', 'index', '', '/Role/index', '[1, 2]', 7, 1, '1', 'fa-address-book-o', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:18:55', 0, 0);
INSERT INTO `{pre}menu` VALUES (5, 1, '系统用户', 1, 'SysUser', 'index', '', '/SysUser/index', '[1, 2]', 6, 1, '1', 'fa-user-o', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:12:51', 0, 0);
INSERT INTO `{pre}menu` VALUES (6, 1, '系统日志', 1, 'Log', 'index', '', '/Syslog/index', '[1, 2]', 5, 1, '1', 'fa-calendar-check-o', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:15:55', 0, 0);
INSERT INTO `{pre}menu` VALUES (7, 1, '类型管理', 1, 'Type', 'index', '', '/Type/index', '[1, 2, 11]', 906, 0, '0', 'fa-tags', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (8, 1, '数据库管理', 1, 'Db', 'index', '', '/Db/index', '[1, 2, 11]', 4, 1, '1', 'fa-database', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (9, 1, '服务器信息', 1, 'Server', 'Index', '', '/Server/Index', '[1, 2, 11]', 3, 0, '1', 'fa-info-circle', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (10, 0, '基础配置', 1, '', '', '', '', '[1, 2]', 300, 1, '0', 'fa-cube', 0, 1, '2015-06-18 03:58:19', '2020-08-19 16:59:51', 0, 0);
INSERT INTO `{pre}menu` VALUES (11, 10, '站点信息', 1, 'Site', 'index', '', '/Site/index', '[1, 2, 11]', 301, 1, '1', 'fa-cog', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (12, 10, '公司信息', 1, 'Company', 'index', '', '/Company/index', '[1, 2]', 302, 1, '1', 'fa-home', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:39:26', 0, 1);
INSERT INTO `{pre}menu` VALUES (29, 10, '内容栏目', 1, 'Sorts', 'index', '', '/Sorts/index', '[1, 2, 11]', 303, 1, '1', 'fa-bars', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 1);
INSERT INTO `{pre}menu` VALUES (30, 0, '内容管理', 1, '', '', '', '', '[1, 2]', 666, 1, '0', 'fa-file-text-o', 0, 1, '2015-06-18 03:58:19', '2020-08-19 16:59:29', 0, 0);
INSERT INTO `{pre}menu` VALUES (31, 30, '专题内容', 1, 'Single', 'index', '1', '/Single/index/1', '[1, 2]', 188, 1, '0', 'fa-file-o', 0, 1, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (36, 56, '定制标签', 1, 'Label', 'index', '', '/Label/index', '[1, 2]', 203, 1, '1', 'fa-tags', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:21:26', 0, 1);
INSERT INTO `{pre}menu` VALUES (50, 57, '留言信息', 1, 'Message', 'index', '', '/Message/index', '[1, 2]', 501, 1, '1', 'fa-plug', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:32:09', 0, 1);
INSERT INTO `{pre}menu` VALUES (51, 57, '轮播图片', 1, 'Slide', 'index', '', '/Slide/index', '[1, 2, 11]', 502, 1, '1', 'fa-picture-o', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 1);
INSERT INTO `{pre}menu` VALUES (52, 57, '友情链接', 1, 'Link', 'index', '', '/Link/index', '[1, 2, 11]', 503, 1, '1', 'fa-link', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 1);
INSERT INTO `{pre}menu` VALUES (53, 56, '配置参数', 1, 'Config', 'index', '', '/Config/index', '[1, 2, 11]', 201, 1, '1', 'fa-sliders', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 1);
INSERT INTO `{pre}menu` VALUES (55, 56, '模型管理', 1, 'Model', 'index', '', '/Model/index', '[1, 2]', 204, 1, '1', 'fa-building', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:23:05', 0, 0);
INSERT INTO `{pre}menu` VALUES (56, 0, '全局配置', 1, '', '', '', '', '[1, 2]', 255, 1, '0', 'fa-windows', 0, 1, '2015-06-18 03:58:19', '2020-08-18 20:43:55', 0, 0);
INSERT INTO `{pre}menu` VALUES (57, 0, '扩展功能', 1, '', '', '', '', '[1, 2]', 555, 1, '0', 'fa-delicious', 0, 1, '2015-06-18 03:58:19', '2020-08-19 16:58:57', 0, 0);
INSERT INTO `{pre}menu` VALUES (58, 56, '模型字段', 1, 'ModelField', 'Iindex', '', '/ModelField/index', '[1, 2]', 205, 1, '1', 'fa-university', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:22:31', 0, 1);
INSERT INTO `{pre}menu` VALUES (60, 57, '自定义表单', 1, 'Form', 'index', '', '/Form/index', '[1, 2]', 504, 1, '1', 'fa-gg', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:26:57', 0, 1);
INSERT INTO `{pre}menu` VALUES (61, 57, '文章内链', 1, 'Tags', 'index', '', '/Tags/index', '[1, 2]', 505, 1, '0', 'fa-retweet', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:25:32', 0, 1);
INSERT INTO `{pre}menu` VALUES (73, 1, '权限分组', 1, 'Auth', 'Group', '', '/Auth/Group', '[1, 2]', 255, 0, '', 'fa-user-o', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:12:35', 0, 0);
INSERT INTO `{pre}menu` VALUES (74, 1, '权限管理', 1, 'Auth', 'Index', '', '/Auth/Index', '[1, 2]', 8, 1, '', 'fa-film', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:17:37', 0, 0);
INSERT INTO `{pre}menu` VALUES (75, 1, '在线更新', 1, 'Update', 'Index', '', '/Update/Index', '[1, 2]', 1, 0, '', 'fa-cloud-download', 0, 1, '2015-06-18 03:58:19', '2020-08-18 22:19:37', 0, 0);
INSERT INTO `{pre}menu` VALUES (76, 30, '产品列表', 1, 'Content', 'Index', '3', '/Content/Index/3', '[1, 2]', 88, 1, '', 'fa-file-text-o', 0, 1, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (77, 30, '新闻列表', 1, 'Content', 'Index', '2', '/Content/Index/2', '[1, 2, 11]', 98, 1, '', 'fa-file-text-o', 0, 0, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (78, 30, '案例列表', 1, 'Content', 'Index', '4', '/Content/Index/3', '[1, 2]', 78, 1, '', 'fa-file-text-o', 0, 1, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (79, 30, '招聘列表', 1, 'Content', 'Index', '5', '/Content/Index/4', '[1, 2]', 68, 1, '', 'fa-file-text-o', 0, 1, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (82, 0, '欢迎页面', 1, 'Home', 'Welcome', '', '/Home/Welcome', '[1, 2, 11]', 888, 1, '', 'fa-home', 1, 1, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (83, 1, '在线更新', 1, 'Upgrade', 'index', '', '/Upgrade/index', '[1, 2]', 0, 1, '', 'fa-cloud-download', 1, 1, '2015-06-18 03:58:19', '2020-08-18 22:19:55', 0, 0);
INSERT INTO `{pre}menu` VALUES (84, 1, '升级管理', 0, 'UpgradeManage', 'index', '', '/UpgradeManage/index', '[1, 2, 11]', 0, 1, '', 'fa-cloud-upload', 1, 1, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (85, 57, '广告位管理', 0, 'Myad', 'index', '', '/Myad/index', '[1, 2, 11]', 500, 1, '', 'fa fa-handshake-o', 1, 1, '2015-06-18 03:58:19', '2015-06-18 03:58:19', 0, 0);
INSERT INTO `{pre}menu` VALUES (86, 57, '模板管理', 0, 'Template', 'index', '', '/Template/index', '[1, 2]', 499, 1, '', 'fa-file-code-o', 1, 1, '2020-08-19 09:45:54', '2020-08-19 09:46:45', 0, 0);

-- ----------------------------
-- Table structure for gd_model
-- ----------------------------
DROP TABLE IF EXISTS `{pre}model`;
CREATE TABLE `{pre}model`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` tinyint(1) NOT NULL,
  `urlname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `listtpl` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `contenttpl` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `create_user` int(10) NOT NULL,
  `update_user` int(10) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `issystem` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_model
-- ----------------------------
INSERT INTO `{pre}model` VALUES (1, '专题', 1, 'pages', 'about.html', 'about.html', 1, 1, 1, '2020-07-01 13:39:40', '2020-07-01 13:39:40', 0, 1);
INSERT INTO `{pre}model` VALUES (2, '新闻', 2, 'news', 'newslist.html', 'news.html', 1, 1, 1, '2020-07-01 13:39:40', '2020-07-01 13:39:40', 0, 1);
INSERT INTO `{pre}model` VALUES (3, '产品', 2, 'products', 'productlist.html', 'product.html', 1, 1, 1, '2020-07-01 13:39:40', '2020-07-01 13:39:40', 0, 1);
INSERT INTO `{pre}model` VALUES (4, '案例', 2, 'cases', 'caselist.html', 'case.html', 1, 1, 1, '2020-07-01 13:39:40', '2020-07-01 13:39:40', 0, 1);
INSERT INTO `{pre}model` VALUES (5, '招聘', 2, 'jobs', 'joblist.html', 'job.html', 1, 1, 1, '2020-07-01 13:39:40', '2020-07-01 13:39:40', 0, 1);

-- ----------------------------
-- Table structure for gd_modelfield
-- ----------------------------
DROP TABLE IF EXISTS `{pre}modelfield`;
CREATE TABLE `{pre}modelfield`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sorting` bigint(20) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_modelfield
-- ----------------------------
INSERT INTO `{pre}modelfield` VALUES (1, 3, 'price', 'input', '', '产品价格', 255, 0, 1, 1, '2015-06-18 19:15:03', '2015-07-30 15:41:26', 1);
INSERT INTO `{pre}modelfield` VALUES (2, 3, 'type', 'checkbox', '基础版,专业版,旗舰版', '类型', 255, 0, 1, 1, '2015-06-18 19:15:03', '2020-08-21 09:11:18', 1);
INSERT INTO `{pre}modelfield` VALUES (3, 3, 'color', 'radio', '红色,橙红色,橙色,橙黄色', '颜色', 255, 0, 1, 1, '2015-06-18 19:15:03', '2020-08-19 17:44:32', 1);

-- ----------------------------
-- Table structure for gd_myad
-- ----------------------------
DROP TABLE IF EXISTS `{pre}myad`;
CREATE TABLE `{pre}myad`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `label` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `timeset` tinyint(1) NOT NULL,
  `start_time` datetime(0) NULL DEFAULT NULL,
  `end_time` datetime(0) NULL DEFAULT NULL,
  `normbody` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expbody` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `path` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `link` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `width` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `height` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `text_size` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `text_color` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `text_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `create_user` int(11) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `update_user` int(11) NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 1,
  `deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gd_myad
-- ----------------------------
INSERT INTO `{pre}myad` VALUES (82, 'test1', 'test1', 'text', 0, '2020-08-18 14:56:58', '2020-08-18 14:56:58', '<a href=\'http://www.jellycms.cn/\'  style=\'font-size:50px;color:#7adc18\'>文本内容</a>', '文本', NULL, 'http://www.jellycms.cn/', NULL, NULL, NULL, '50px', '#7adc18', '文本内容', '2020-08-18 15:01:09', 1, '2020-08-18 15:18:14', 1, 0, 0);
INSERT INTO `{pre}myad` VALUES (83, 'test2', 'test2', 'single_img', 1, '2020-08-18 15:19:18', '2020-08-27 15:19:00', '<a href=\'http://www.jellycms.cn/\' target=\'_blank\'><img src=\'/static/upload/20200818/1597735173_8b628cb4414692e44f19.jpg\' width=\'200px\' height=\'200px title=http://www.jellycms.cn/\' border=\'0\' /></a>', '过期显示内容', '/static/upload/20200818/1597735173_8b628cb4414692e44f19.jpg', 'http://www.jellycms.cn/', 'http://www.jellycms.cn/', '200px', '200px', NULL, NULL, NULL, '2020-08-18 15:19:53', 1, '2020-08-18 15:29:35', 1, 1, 0);
INSERT INTO `{pre}myad` VALUES (84, 'test3', 'test3', 'more_img', 1, '2020-08-18 16:01:50', '2020-08-29 15:28:23', '<link rel=\"stylesheet\" href=\"/template/default/css/swiper.min.css\"><div class=\"swiper-container\" style=\"width: 407px;height: 60px;\"><div class=\"swiper-wrapper\"><div class=\"swiper-slide\"><a href=\"http://www.jellycms.cn/\" target=\"_blank\"><img src=\"/static/upload/20200818/1597735358_196e50f4b22bccc30e8b.jpg\" title=\"http://www.jellycms.cn/\" width=\"407px\" height=\"60px\" /></a></div><div class=\"swiper-slide\"><a href=\"http://www.jellycms.cn/\" target=\"_blank\"><img src=\"/static/upload/20200818/1597735358_e1d128c5ecf66559d84d.jpg\" title=\"http://www.jellycms.cn/\" width=\"407px\" height=\"60px\" /></a></div><div class=\"swiper-slide\"><a href=\"http://www.jellycms.cn/\" target=\"_blank\"><img src=\"/static/upload/20200818/1597735359_8a1045190ef18bf9d5c9.jpg\" title=\"http://www.jellycms.cn/\" width=\"407px\" height=\"60px\" /></a></div><div class=\"swiper-slide\"><a href=\"http://www.jellycms.cn/\" target=\"_blank\"><img src=\"/static/upload/20200818/1597735359_5fc7817dd6e54e251a1b.jpg\" title=\"http://www.jellycms.cn/\" width=\"407px\" height=\"60px\" /></a></div></div></div><script src=\"/template/default/js/swiper.min.js\"></script><script type=\"text/javascript\">var mySwiper = new Swiper(\".swiper-container\", {loop : true,})</script>', '过期显示内容', '/static/upload/20200818/1597735358_196e50f4b22bccc30e8b.jpg,/static/upload/20200818/1597735358_e1d128c5ecf66559d84d.jpg,/static/upload/20200818/1597735359_8a1045190ef18bf9d5c9.jpg,/static/upload/20200818/1597735359_5fc7817dd6e54e251a1b.jpg', 'http://www.jellycms.cn/,http://www.jellycms.cn/,http://www.jellycms.cn/,http://www.jellycms.cn/', 'http://www.jellycms.cn/,http://www.jellycms.cn/,http://www.jellycms.cn/,http://www.jellycms.cn/', '407px', '60px', NULL, NULL, NULL, '2020-08-18 15:23:06', 1, '2020-08-18 16:55:23', 1, 1, 0);

-- ----------------------------
-- Table structure for gd_role
-- ----------------------------
DROP TABLE IF EXISTS `{pre}role`;
CREATE TABLE `{pre}role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `areas_id` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管辖区域JSON',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色描述',
  `rules_id` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限JSON',
  `create_user` int(11) NOT NULL COMMENT '创建者ID',
  `update_user` int(11) NOT NULL COMMENT '更新者ID',
  `create_time` timestamp(0) NOT NULL COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL COMMENT '角色状态',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_role
-- ----------------------------
INSERT INTO `{pre}role` VALUES (1, '[1]', '超级管理员', '超级管理员具有所有权限', '[]', 1, 1, '2020-08-02 08:14:07', '2020-08-21 10:08:20', 1, 0);
INSERT INTO `{pre}role` VALUES (2, '[1,2]', '内容管理', '内容管理员具有基本内容管理权限', '[82,158,10,11,95,29,97,98,99,12,96,30,31,159,160,76,104,105,107,161,162,163,164,56,36,140,141,142,58,144,145,55,136,137,138,57,50,166,167,168,169,51,124,125,52,121,122,123,60,153,154,155,61,118,119,120,170,171,172,173,165,1,3,85,90,101,176,4,86,91,100,178,5,87,92,102,179,6,88,8,180,181,182,183,74,93,94,177,75,184,185,2,83,89,174,175]', 1, 1, '2020-07-13 20:20:12', '2020-08-02 13:12:53', 1, 0);

-- ----------------------------
-- Table structure for gd_site
-- ----------------------------
DROP TABLE IF EXISTS `{pre}site`;
CREATE TABLE `{pre}site`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `area_id` int(11) NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `subtitle` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `domain` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `logo` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keywords` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icp` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pctheme` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobiletheme` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `statistics` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `copyright` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qrcode` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `service_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `subscribe_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_site
-- ----------------------------
INSERT INTO `{pre}site` VALUES (1, 1, 'JellyCMS', '开源免费PHP企业网站内容管理系统', 'https://www.jellycms.cn', '/static/upload/20200819/1597808531_3cb922bdf8ab8f567bd8.png', 'phpcms,免费cms,php开源cms,php企业cms,php建站cms', 'JellyCMS是北京国栋科技有限公司开发的企业信息化解决方案系统之一，永久开源免费的PHP企业网站开发建设管理系统，是一套高效、简洁、安全、易用的遵循MIT协议的免费PHP CMS源码网站开发建设解决方案。', '京ICP备19013673号', 'default', 'mobile', '统计代码', 'CopyRight 2015-2020 All Right Reserved', '/static/upload/20200819/1597822100_12968a3ea78c50d7f90d.png', '/static/upload/20200819/1597822100_12968a3ea78c50d7f90d.png', '/static/upload/20200819/1597822100_12968a3ea78c50d7f90d.png');
INSERT INTO `{pre}site` VALUES (2, 2, '1', '1', '', '', '1', '', '', '', '', '', '', '', '', '');

-- ----------------------------
-- Table structure for gd_slide
-- ----------------------------
DROP TABLE IF EXISTS `{pre}slide`;
CREATE TABLE `{pre}slide`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `area_id` int(11) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `pic` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `link` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sorting` bigint(20) NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `bgcolor` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bgpic` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ay_slide_gid`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_slide
-- ----------------------------
INSERT INTO `{pre}slide` VALUES (1, '开源  免费', 1, 1, '/static/upload/20200712/1594497780_4225ef3a155a8b0175b6.png', 'http://www.guodong.tech/', '基于MIT开源协议，被授权人有权利使用、复制、修改、合并、出版、发行、散布、再授权及贩售软件及软件的副本。', 2558, 0, 1, '0000-00-00 00:00:00', '2020-07-14 17:30:10', 0, 'rgba(30, 159, 255, 1)', '/static/upload/20200714/1594716239_644849b3b63e15f971a3.jpg', 1);
INSERT INTO `{pre}slide` VALUES (2, '简单 易用', 1, 1, '/static/upload/20200712/1594497899_e3285ad5e789a7b101bc.png', 'http://www.guodong.tech/', '使用十分简单,容易上手,快捷方便，官方网站还配有详细的使用文档', 255, 0, 1, '0000-00-00 00:00:00', '2020-07-27 05:06:38', 0, 'rgba(95, 184, 120, 1)', '/static/upload/20200714/1594717207_e03f686b75bc9a9066a1.png', 1);
INSERT INTO `{pre}slide` VALUES (3, '免费升级', 1, 1, '/static/upload/20200712/1594497796_c565284bbba5be7cfc20.png', 'http://www.guodong.tech/', '开源免费的PHP内容管理系统 不需要高深专业技术轻松搭建网站 使用简单　灵活方便　稳定快捷 风格切换　想换就换　适应不同需求', 255, 1, 1, '2020-07-01 08:36:22', '2020-07-19 17:04:34', 0, 'rgba(144, 240, 144,  0.5)', '/static/upload/20200712/1594495763_b0c24478f9997e28af0d.jpg', 1);
INSERT INTO `{pre}slide` VALUES (4, '英文幻灯片1', 1, 2, '/static/upload/20200711/1594476025_fa547ef7eb285996522e.png', 'http://www.jellycms.cn', '英文幻灯片1', 255, 0, 1, '0000-00-00 00:00:00', '2020-07-27 05:07:53', 0, 'rgba(255, 140, 0, 1)', '/static/upload/20200711/1594476022_f131b70d32713bba8db3.png', 1);
INSERT INTO `{pre}slide` VALUES (5, '英文幻灯片2', 1, 2, '/static/upload/20200711/1594476002_c2bf4ace4a57b62e4780.png', 'http://www.jellycms.cn', '英文幻灯片2', 255, 1, 1, '2020-07-11 22:00:03', '2020-07-27 05:07:35', 0, 'rgba(31, 147, 255,  0.73)', '/static/upload/20200711/1594476000_9b3c0b8449efd28e017f.png', 1);

-- ----------------------------
-- Table structure for gd_slide_group
-- ----------------------------
DROP TABLE IF EXISTS `{pre}slide_group`;
CREATE TABLE `{pre}slide_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `area_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `create_user` int(11) NOT NULL,
  `update_user` int(11) NOT NULL,
  `create_time` timestamp(0) NOT NULL,
  `update_time` timestamp(0) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `sorting` int(3) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gd_slide_group
-- ----------------------------
INSERT INTO `{pre}slide_group` VALUES (1, '中文幻灯片分组', 1, 1, 1, 1, '2020-07-05 00:00:00', '2020-08-21 09:22:43', 0, 255);
INSERT INTO `{pre}slide_group` VALUES (2, '英文幻灯片分组', 2, 1, 1, 1, '2020-07-05 08:21:26', '2020-07-27 04:38:36', 0, 255);

-- ----------------------------
-- Table structure for gd_sorts
-- ----------------------------
DROP TABLE IF EXISTS `{pre}sorts`;
CREATE TABLE `{pre}sorts`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `area_id` int(3) NULL DEFAULT NULL,
  `model_id` int(5) NULL DEFAULT NULL,
  `pid` int(10) NULL DEFAULT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `listtpl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contenttpl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `outlink` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `subname` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `pics` json NULL,
  `ico` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `pic` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keywords` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `urlname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sorting` bigint(20) NULL DEFAULT NULL,
  `create_user` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_user` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `update_time` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `deleted` tinyint(1) NOT NULL,
  `enname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `slogan` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '专题页面内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ay_content_sort_sorting`(`sorting`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_sorts
-- ----------------------------
INSERT INTO `{pre}sorts` VALUES (1, 1, 1, 0, '关于我们', 'about.html', '', 1, '', '网站建设「一站式」服务商', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/index-aboutus.jpg', '关于我们', '关于我们', '描述', 'aboutus', 255, '1', '1', '2018-04-11 17:26:11', '2020-07-29 04:24:24', 0, 'CONTACT US', '24小时竭诚为您服务', '<p>&nbsp; &nbsp; &nbsp; 2020年注定是不平凡的一年。决战决胜之年又遭遇新冠肺炎疫情影响，以习近平同志为核心的党中央保持战略定力，团结带领全党全国各族人民迎难而上，有效应对一系列风险挑战。 细数今年上半年，习近平夙夜在公，勤勉工作，不断刷新“忙碌指数”：数十次出席重要会议部署各项工作，8次国内考察，调研足迹遍及7省区市，3次出席国际重要会议并发表讲话，20余次致信、回信海内外人士，60次就疫情防控等话题与40余位外国政要和国际组织负责人通电话……<br/></p><p>人民网·中国共产党新闻网推出系列图解报道，带您全方面回顾习近平的2020上半年。2020年注定是不平凡的一年。决战决胜之年又遭遇新冠肺炎疫情影响，以习近平同志为核心的党中央保持战略定力，团结带领全党全国各族人民迎难而上，有效应对一系列风险挑战。 细数今年上半年，习近平夙夜在公，勤勉工作，不断刷新“忙碌指数”：数十次出席重要会议部署各项工作，8次国内考察，调研足迹遍及7省区市，3次出席国际重要会议并发表讲话，20余次致信、回信海内外人士，60次就疫情防控等话题与40余位外国政要和国际组织负责人通电话……人民网·中国共产党新闻网推出系列图解报道，带您全方面回顾习近平的2020上半年。2020年注定是不平凡的一年。决战决胜之年又遭遇新冠肺炎疫情影响，以习近平同志为核心的党中央保持战略定力，团结带领全党全国各族人民迎难而上，有效应对一系列风险挑战。 细数今年上半年，习近平夙夜在公，勤勉工作，不断刷新“忙碌指数”：数十次出席重要会议部署各项工作，8次国内考察，调研足迹遍及7省区市，3次出席国际重要会议并发表讲话，20余次致信、回信海内外人士，60次就疫情防控等话题与40余位外国政要和国际组织负责人通电话……人民网·中国共产党新闻网推出系列图解报道，带您全方面回顾习近平的2020上半年。2020年注定是不平凡的一年。决战决胜之年又遭遇新冠肺炎疫情影响，以习近平同志为核心的党中央保持战略定力，团结带领全党全国各族人民迎难而上，有效应对一系列风险挑战。 细数今年上半年，习近平夙夜在公，勤勉工作，不断刷新“忙碌指数”：数十次出席重要会议部署各项工作，8次国内考察，调研足迹遍及7省区市，3次出席国际重要会议并发表讲话，20余次致信、回信海内外人士，60次就疫情防控等话题与40余位外国政要和国际组织负责人通电话……人民网·中国共产党新闻网推出系列图解报道，带您全方面回顾习近平的2020上半年。2020年注定是不平凡的一年。决战决胜之年又遭遇新冠肺炎疫情影响，以习近平同志为核心的党中央保持战略定力，团结带领全党全国各族人民迎难而上，有效应对一系列风险挑战。 细数今年上半年，习近平夙夜在公，勤勉工作，不断刷新“忙碌指数”：数十次出席重要会议部署各项工作，8次国内考察，调研足迹遍及7省区市，3次出席国际重要会议并发表讲话，20余次致信、回信海内外人士，60次就疫情防控等话题与40余位外国政要和国际组织负责人通电话……人民网·中国共产党新闻网推出系列图解报道，带您全方面回顾习近平的2020上半年。2020年注定是不平凡的一年。决战决胜之年又遭遇新冠肺炎疫情影响，以习近平同志为核心的党中央保持战略定力，团结带领全党全国各族人民迎难而上，有效应对一系列风险挑战。 细数今年上半年，习近平夙夜在公，勤勉工作，不断刷新“忙碌指数”：数十次出席重要会议部署各项工作，8次国内考察，调研足迹遍及7省区市，3次出席国际重要会议并发表讲话，20余次致信、回信海内外人士，60次就疫情防控等话题与40余位外国政要和国际组织负责人通电话……人民网·中国共产党新闻网推出系列图解报道，带您全方面回顾习近平的2020上半年。<br/></p>');
INSERT INTO `{pre}sorts` VALUES (2, 1, 2, 0, '新闻动态', 'newslist.html', 'news.html', 1, '', '了解最新公司动态及行业资讯', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '了解最新公司动态及行业资讯', 'article', 255, '1', '1', '2018-04-11 17:26:46', '2018-04-11 17:26:46', 0, 'CONTACT US', '24小时竭诚为您服务', '');
INSERT INTO `{pre}sorts` VALUES (3, 1, 2, 2, '公司动态', 'newslist.html', 'news.html', 1, '', '了解最新公司动态及行业资讯', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '了解最新公司动态及行业资讯', 'company', 255, '1', '1', '2018-04-11 17:27:05', '2018-04-11 17:27:05', 0, 'CONTACT US', '24小时竭诚为您服务', '');
INSERT INTO `{pre}sorts` VALUES (4, 1, 2, 2, '行业动态', 'newslist.html', 'news.html', 1, '', '了解最新公司动态及行业资讯', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '了解最新公司动态及行业资讯', 'industry', 255, '1', '1', '2018-04-11 17:27:30', '2018-04-11 17:27:30', 0, 'CONTACT US', '24小时竭诚为您服务', '');
INSERT INTO `{pre}sorts` VALUES (5, 1, 3, 0, '产品中心', 'productlist.html', 'product.html', 1, '', '服务创造价值、存在造就未来', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '服务创造价值、存在造就未来', 'product', 255, '1', '1', '2018-04-11 17:27:54', '2018-04-11 17:27:54', 0, 'CONTACT US', '24小时竭诚为您服务', '');
INSERT INTO `{pre}sorts` VALUES (6, 1, 3, 5, '果冻CMS', 'productlist.html', 'product.html', 1, '', '服务创造价值、存在造就未来', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '服务创造价值、存在造就未来', 'website', 255, '1', '1', '2018-04-11 17:28:19', '2018-04-11 17:28:19', 0, 'CONTACT US', '24小时竭诚为您服务', '');
INSERT INTO `{pre}sorts` VALUES (7, 1, 3, 5, '果冻CRM', 'productlist.html', 'product.html', 1, '', '服务创造价值、存在造就未来', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '服务创造价值、存在造就未来', 'domain', 255, '1', '1', '2018-04-11 17:28:38', '2018-04-11 17:28:38', 0, 'CONTACT US', '24小时竭诚为您服务', '');
INSERT INTO `{pre}sorts` VALUES (8, 1, 4, 0, '服务案例', 'caselist.html', 'case.html', 1, '', '服务创造价值、存在造就未来', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '服务创造价值、存在造就未来', 'case', 255, '1', '1', '2018-04-11 17:29:16', '2018-04-11 17:29:16', 0, 'CONTACT US', '24小时竭诚为您服务', '');
INSERT INTO `{pre}sorts` VALUES (9, 1, 5, 0, '加入我们', 'joblist.html', 'job.html', 1, '', '诚聘优秀人士加入我们的团队', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '诚聘优秀人士加入我们的团队', 'job', 255, '1', '1', '2018-04-11 17:30:02', '2018-04-11 17:30:02', 0, 'CONTACT US', '24小时竭诚为您服务', '');
INSERT INTO `{pre}sorts` VALUES (10, 1, 1, 0, '在线留言', 'message.html', 'message.html', 1, '', '有什么问题欢迎您随时反馈', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '有什么问题欢迎您随时反馈', 'gbook', 255, '1', '1', '2018-04-11 17:30:36', '2018-04-12 10:55:31', 0, 'CONTACT US', '24小时竭诚为您服务', '');
INSERT INTO `{pre}sorts` VALUES (11, 1, 1, 0, '联系我们', 'contact.html', 'contact.html', 1, '', '能为您服务是我们的荣幸', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '能为您服务是我们的荣幸', 'contact', 255, '1', '1', '2018-04-11 17:31:29', '2018-04-11 17:31:29', 0, 'CONTACT US', '24小时竭诚为您服务', '<p style=\"margin-top: 1em; margin-bottom: 1em; padding: 0px; word-wrap: break-word; font-family: Arial, Verdana, &quot;Microsoft Yahei&quot;, 微软雅黑, 宋体, Helvetica, sans-serif; font-size: 14px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\"><iframe class=\"ueditor_baidumap\" src=\"/static/ueditor/dialogs/map/show.html#center=116.433896,39.918542&zoom=10&width=700&height=400&markers=116.404,39.915&markerStyles=l,A\" frameborder=\"0\" width=\"100%\" height=\"400\" align=\"\"></iframe></p><p><br/></p>');
INSERT INTO `{pre}sorts` VALUES (12, 1, 2, 3, '公司动态子类', 'newslist.html', 'news.html', 1, '', '了解最新公司动态及行业资讯', '[1, 2, 3, 4, 5, 6, 7, 8]', '/static/images/mit.png', '/static/images/proxy-pic.png', '', '', '了解最新公司动态及行业资讯', 'company', 255, '1', '1', '2018-04-11 17:27:05', '2018-04-11 17:27:05', 0, 'CONTACT US', '24小时竭诚为您服务', '');

-- ----------------------------
-- Table structure for gd_statistics
-- ----------------------------
DROP TABLE IF EXISTS `{pre}statistics`;
CREATE TABLE `{pre}statistics`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_time` datetime(0) NOT NULL,
  `ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `os` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `spider` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '搜索引擎',
  `content_id` int(11) NOT NULL COMMENT '0:首页',
  `sort_id` int(11) NOT NULL COMMENT '0:首页',
  `from` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `end_time` datetime(0) NOT NULL,
  `province` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '省',
  `query_string` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE COMMENT '便于插入数据'
) ENGINE = InnoDB AUTO_INCREMENT = 2525 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gd_statistics
-- ----------------------------
INSERT INTO `{pre}statistics` VALUES (1, '2020-08-14 21:49:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-14 21:49:07', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2, '2020-08-14 21:49:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-14 21:49:08', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (3, '2020-08-14 21:49:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-14 21:49:14', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (4, '2020-08-14 22:16:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-14 22:35:35', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (5, '2020-08-14 22:18:46', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-14 22:29:17', '福建', '');
INSERT INTO `{pre}statistics` VALUES (6, '2020-08-14 22:29:17', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-14 22:30:16', '云南', '');
INSERT INTO `{pre}statistics` VALUES (7, '2020-08-14 22:30:17', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-14 22:30:18', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (8, '2020-08-14 22:30:18', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:30:19', '上海', '');
INSERT INTO `{pre}statistics` VALUES (9, '2020-08-14 22:30:19', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 8, '', '2020-08-14 22:30:20', '新疆', '');
INSERT INTO `{pre}statistics` VALUES (10, '2020-08-14 22:30:20', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:30:21', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (11, '2020-08-14 22:30:21', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:30:22', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (12, '2020-08-14 22:30:22', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:30:22', '广东', '');
INSERT INTO `{pre}statistics` VALUES (13, '2020-08-14 22:30:23', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:30:35', '广东', '');
INSERT INTO `{pre}statistics` VALUES (14, '2020-08-14 22:30:35', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:30:36', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (15, '2020-08-14 22:30:36', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:30:37', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (16, '2020-08-14 22:30:37', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:30:37', '河南', '');
INSERT INTO `{pre}statistics` VALUES (17, '2020-08-14 22:30:38', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:30:38', '青海', '');
INSERT INTO `{pre}statistics` VALUES (18, '2020-08-14 22:30:38', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:30:39', '宁夏', '');
INSERT INTO `{pre}statistics` VALUES (19, '2020-08-14 22:30:39', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 8, '', '2020-08-14 22:30:40', '上海', '');
INSERT INTO `{pre}statistics` VALUES (20, '2020-08-14 22:30:40', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:30:41', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (21, '2020-08-14 22:30:41', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:30:43', '山东', '');
INSERT INTO `{pre}statistics` VALUES (22, '2020-08-14 22:30:44', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:30:45', '山西', '');
INSERT INTO `{pre}statistics` VALUES (23, '2020-08-14 22:30:45', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:30:46', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (24, '2020-08-14 22:30:47', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:30:47', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (25, '2020-08-14 22:30:47', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:30:49', '福建', '');
INSERT INTO `{pre}statistics` VALUES (26, '2020-08-14 22:30:49', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-14 22:30:50', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (27, '2020-08-14 22:30:50', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-14 22:30:51', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (28, '2020-08-14 22:30:51', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:30:52', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (29, '2020-08-14 22:30:52', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:30:53', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (30, '2020-08-14 22:30:53', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:30:53', '海南', '');
INSERT INTO `{pre}statistics` VALUES (31, '2020-08-14 22:30:54', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:30:54', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (32, '2020-08-14 22:30:54', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:30:55', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (33, '2020-08-14 22:30:55', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:30:56', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (34, '2020-08-14 22:30:56', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-14 22:30:56', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (35, '2020-08-14 22:30:56', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-14 22:30:57', '云南', '');
INSERT INTO `{pre}statistics` VALUES (36, '2020-08-14 22:30:57', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:30:58', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (37, '2020-08-14 22:30:58', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:31:02', '云南', '');
INSERT INTO `{pre}statistics` VALUES (38, '2020-08-14 22:31:03', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:31:04', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (39, '2020-08-14 22:31:04', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-14 22:31:05', '香港', '');
INSERT INTO `{pre}statistics` VALUES (40, '2020-08-14 22:31:05', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-14 22:31:06', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (41, '2020-08-14 22:31:06', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-14 22:31:07', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (42, '2020-08-14 22:31:07', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-14 22:31:08', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (43, '2020-08-14 22:31:08', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:31:09', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (44, '2020-08-14 22:31:09', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:31:10', '江西', '');
INSERT INTO `{pre}statistics` VALUES (45, '2020-08-14 22:31:10', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:31:11', '四川', '');
INSERT INTO `{pre}statistics` VALUES (46, '2020-08-14 22:31:11', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:31:25', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (47, '2020-08-14 22:31:25', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:31:26', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (48, '2020-08-14 22:31:26', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:31:26', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (49, '2020-08-14 22:31:26', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:31:43', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (50, '2020-08-14 22:31:44', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:31:44', '山东', '');
INSERT INTO `{pre}statistics` VALUES (51, '2020-08-14 22:31:45', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 8, '', '2020-08-14 22:31:54', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (52, '2020-08-14 22:31:54', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:31:55', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (53, '2020-08-14 22:31:55', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:31:56', '云南', '');
INSERT INTO `{pre}statistics` VALUES (54, '2020-08-14 22:31:56', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:31:57', '四川', '');
INSERT INTO `{pre}statistics` VALUES (55, '2020-08-14 22:31:57', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:31:59', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (56, '2020-08-14 22:31:59', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:32:19', '四川', '');
INSERT INTO `{pre}statistics` VALUES (57, '2020-08-14 22:32:19', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:32:22', '广西', '');
INSERT INTO `{pre}statistics` VALUES (58, '2020-08-14 22:32:22', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:32:23', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (59, '2020-08-14 22:32:24', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:32:24', '云南', '');
INSERT INTO `{pre}statistics` VALUES (60, '2020-08-14 22:32:24', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:32:25', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (61, '2020-08-14 22:32:25', '223.72.69.26', 'Windows 7', 'Chrome', '360', 0, 8, '', '2020-08-14 22:32:26', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (62, '2020-08-14 22:32:26', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 5, '', '2020-08-14 22:32:33', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (63, '2020-08-14 22:32:34', '223.72.69.26', 'Windows 7', 'Opera', '360', 257, 5, '', '2020-08-14 22:32:35', '海南', '');
INSERT INTO `{pre}statistics` VALUES (64, '2020-08-14 22:32:35', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 1, '', '2020-08-14 22:32:36', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (65, '2020-08-14 22:32:36', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 0, '', '2020-08-14 22:32:40', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (66, '2020-08-14 22:32:40', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 1, '', '2020-08-14 22:32:40', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (67, '2020-08-14 22:32:41', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 0, '', '2020-08-14 22:32:49', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (68, '2020-08-14 22:32:49', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 1, '', '2020-08-14 22:33:00', '四川', '');
INSERT INTO `{pre}statistics` VALUES (69, '2020-08-14 22:33:00', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 2, '', '2020-08-14 22:33:06', '江西', '');
INSERT INTO `{pre}statistics` VALUES (70, '2020-08-14 22:33:06', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 1, '', '2020-08-14 22:33:08', '云南', '');
INSERT INTO `{pre}statistics` VALUES (71, '2020-08-14 22:33:08', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 2, '', '2020-08-14 22:33:09', '福建', '');
INSERT INTO `{pre}statistics` VALUES (72, '2020-08-14 22:33:09', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 5, '', '2020-08-14 22:33:11', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (73, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Opera', '360', 257, 5, '', '2020-08-14 22:33:13', '福建', '');
INSERT INTO `{pre}statistics` VALUES (74, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 2, '', '2020-08-14 22:33:13', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (75, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 1, '', '2020-08-14 22:33:14', '香港', '');
INSERT INTO `{pre}statistics` VALUES (76, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 0, '', '2020-08-14 22:33:25', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (77, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Opera', '360', 0, 1, '', '2020-08-14 22:33:27', '福建', '');
INSERT INTO `{pre}statistics` VALUES (78, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Opera', '', 0, 2, '', '2020-08-14 22:33:28', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (79, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Opera', '', 0, 1, '', '2020-08-14 22:33:30', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (80, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-14 22:33:31', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (81, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-14 22:33:32', '广东', '');
INSERT INTO `{pre}statistics` VALUES (82, '2020-08-15 12:22:44', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-14 22:33:50', '河北', '');
INSERT INTO `{pre}statistics` VALUES (83, '2020-08-15 22:22:44', '223.72.69.26', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-14 22:33:46', '北京', '');
INSERT INTO `{pre}statistics` VALUES (84, '2020-08-15 22:22:44', '223.72.69.26', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-14 22:33:52', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (85, '2020-08-15 22:22:44', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-14 22:33:54', '海南', '');
INSERT INTO `{pre}statistics` VALUES (86, '2020-08-15 22:22:44', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-14 22:34:09', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (87, '2020-08-14 22:34:09', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-14 22:34:10', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (88, '2020-08-14 22:34:10', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-14 22:34:11', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (89, '2020-08-14 22:34:11', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:34:11', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (90, '2020-08-14 22:34:11', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:34:12', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (91, '2020-08-14 22:34:12', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 8, '', '2020-08-14 22:34:13', '广东', '');
INSERT INTO `{pre}statistics` VALUES (92, '2020-08-15 22:22:44', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-14 22:34:14', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (93, '2020-08-15 22:22:44', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-14 22:34:15', '新疆', '');
INSERT INTO `{pre}statistics` VALUES (94, '2020-08-15 22:22:44', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:34:16', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (95, '2020-08-15 22:22:44', '223.72.69.26', 'Windows 7', 'Firefox', '', 0, 11, '', '2020-08-14 22:35:27', '香港', '');
INSERT INTO `{pre}statistics` VALUES (96, '2020-08-15 22:22:44', '127.0.0.1', 'Windows 10', 'Firefox', '', 0, 0, '', '2020-08-15 00:11:05', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (97, '2020-08-15 22:22:44', '127.0.0.1', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:36:14', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (98, '2020-08-15 22:22:44', '127.0.0.1', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:41:11', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (99, '2020-08-15 22:22:44', '119.40.128.7', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:41:12', '广东', '');
INSERT INTO `{pre}statistics` VALUES (100, '2020-08-15 22:22:44', '124.172.106.108', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:41:15', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (101, '2020-08-15 22:22:44', '203.95.96.248', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:41:32', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (102, '2020-08-15 22:22:44', '202.170.216.171', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:42:02', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (103, '2020-08-15 22:22:44', '202.95.252.45', 'Windows 7', 'Firefox', '', 0, 0, '', '0000-00-00 00:00:00', '青海', '');
INSERT INTO `{pre}statistics` VALUES (104, '2020-08-15 22:22:44', '123.199.128.59', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:42:05', '海南', '');
INSERT INTO `{pre}statistics` VALUES (105, '2020-08-15 22:22:44', '116.224.97.22', 'Windows 7', 'Firefox', '', 188, 2, '', '2020-08-14 22:42:43', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (106, '2020-08-15 22:42:44', '202.127.112.13', 'Windows 7', 'Firefox', '', 0, 5, '', '2020-08-14 22:43:44', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (107, '2020-08-15 22:42:44', '202.173.224.239', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-14 22:43:46', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (108, '2020-08-15 22:42:44', '117.124.151.250', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:43:47', '香港', '');
INSERT INTO `{pre}statistics` VALUES (109, '2020-08-15 22:42:44', '202.120.22.203', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:43:49', '山西', '');
INSERT INTO `{pre}statistics` VALUES (110, '2020-08-15 22:42:44', '210.56.192.8', 'Windows 7', 'Firefox', '', 0, 0, '', '2020-08-14 22:43:50', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (111, '2020-08-15 22:42:44', '203.142.219.213', 'Windows 7', 'Firefox', '', 0, 1, '', '2020-08-14 22:43:52', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (112, '2020-08-15 22:42:44', '119.27.160.91', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-14 22:44:00', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (113, '2020-08-15 22:42:44', '119.248.49.230', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-14 22:44:01', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (114, '2020-08-15 22:42:44', '119.148.160.119', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-14 23:07:50', '山东', '');
INSERT INTO `{pre}statistics` VALUES (115, '2020-08-15 22:42:44', '119.2.68.96', 'Windows 7', 'Firefox', '', 0, 0, '', '0000-00-00 00:00:00', '四川', '');
INSERT INTO `{pre}statistics` VALUES (116, '2020-08-15 22:42:44', '59.192.168.206', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-14 23:07:52', '宁夏', '');
INSERT INTO `{pre}statistics` VALUES (117, '2020-08-15 22:42:44', '119.20.114.129', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-14 23:08:02', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (118, '2020-08-15 22:42:44', '116.66.179.101', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-14 23:08:17', '福建', '');
INSERT INTO `{pre}statistics` VALUES (119, '2020-08-15 22:42:44', '123.108.208.75', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-14 23:08:19', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (120, '2020-08-15 22:42:44', '203.208.229.164', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '上海', '');
INSERT INTO `{pre}statistics` VALUES (121, '2020-08-15 22:42:44', '60.245.128.173', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-15 00:11:06', '云南', '');
INSERT INTO `{pre}statistics` VALUES (122, '2020-08-15 22:42:44', '122.60.128.97', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-15 00:11:07', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (123, '2020-08-15 22:42:44', '60.232.120.192', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-15 09:21:03', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (124, '2020-08-15 00:48:13', '124.40.128.63', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '天津', '');
INSERT INTO `{pre}statistics` VALUES (125, '2020-08-15 01:28:11', '124.242.121.129', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '山西', '');
INSERT INTO `{pre}statistics` VALUES (126, '2020-08-15 02:25:37', '192.188.170.205', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (127, '2020-08-15 02:59:09', '58.116.152.91', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '河南', '');
INSERT INTO `{pre}statistics` VALUES (128, '2020-08-15 04:05:26', '121.79.128.144', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (129, '2020-08-15 05:12:06', '119.3.142.112', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (130, '2020-08-15 06:18:46', '117.8.250.75', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (131, '2020-08-15 06:51:58', '210.87.128.228', 'Windows 10', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (132, '2020-08-15 06:52:05', '203.100.32.155', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-15 06:52:09', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (133, '2020-08-15 06:53:04', '222.176.100.183', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-15 06:53:10', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (134, '2020-08-15 06:53:10', '119.18.208.71', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-15 06:53:19', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (135, '2020-08-15 06:53:19', '220.232.64.63', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-15 06:53:21', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (136, '2020-08-15 06:53:23', '117.128.187.54', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-15 06:53:32', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (137, '2020-08-15 06:53:49', '119.58.216.167', 'Windows 10', 'Opera', '', 0, 0, '', '2020-08-15 06:54:05', '广东', '');
INSERT INTO `{pre}statistics` VALUES (138, '2020-08-15 06:54:02', '58.240.9.41', 'Windows 10', 'Opera', '', 0, 10, '', '0000-00-00 00:00:00', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (139, '2020-08-15 06:54:03', '121.52.224.12', 'Windows 10', 'Opera', '', 0, 10, '', '0000-00-00 00:00:00', '山西', '');
INSERT INTO `{pre}statistics` VALUES (140, '2020-08-15 06:54:24', '60.63.100.10', 'Windows 10', 'Opera', '', 188, 2, '', '0000-00-00 00:00:00', '青海', '');
INSERT INTO `{pre}statistics` VALUES (141, '2020-08-15 06:54:28', '119.40.64.171', 'Windows 10', 'Opera', '', 188, 2, '', '2020-08-15 06:54:36', '云南', '');
INSERT INTO `{pre}statistics` VALUES (142, '2020-08-15 06:58:28', '124.67.75.113', 'Windows 10', 'Opera', '', 0, 2, '', '2020-08-15 06:58:32', '广西', '');
INSERT INTO `{pre}statistics` VALUES (143, '2020-08-15 06:58:34', '221.12.128.59', 'Windows 10', 'Opera', '', 0, 2, '', '2020-08-15 06:58:43', '北京', '');
INSERT INTO `{pre}statistics` VALUES (144, '2020-08-15 07:02:28', '119.96.174.159', 'Windows 10', 'Opera', '', 0, 11, '', '2020-08-15 07:02:32', '天津', '');
INSERT INTO `{pre}statistics` VALUES (145, '2020-08-15 07:02:33', '117.121.15.170', 'Windows 10', 'Opera', '', 0, 11, '', '2020-08-15 07:02:42', '广西', '');
INSERT INTO `{pre}statistics` VALUES (146, '2020-08-15 07:57:26', '124.40.128.177', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-15 07:57:32', '云南', '');
INSERT INTO `{pre}statistics` VALUES (147, '2020-08-15 07:57:32', '202.127.224.97', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-15 07:57:41', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (148, '2020-08-15 07:58:47', '118.89.211.8', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '海南', '');
INSERT INTO `{pre}statistics` VALUES (149, '2020-08-15 08:12:51', '118.89.119.181', 'Windows 10', 'Opera', '', 0, 8, '', '2020-08-15 08:12:56', '上海', '');
INSERT INTO `{pre}statistics` VALUES (150, '2020-08-15 08:12:57', '202.122.112.112', 'Windows 10', 'Opera', '', 0, 8, '', '2020-08-15 08:13:06', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (151, '2020-08-15 08:45:18', '119.176.4.6', 'Windows 7', 'Opera', '', 0, 0, '', '0000-00-00 00:00:00', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (152, '2020-08-15 08:50:22', '124.42.205.165', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 08:50:30', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (153, '2020-08-15 08:51:07', '203.191.16.23', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 08:51:08', '天津', '');
INSERT INTO `{pre}statistics` VALUES (154, '2020-08-15 08:51:09', '119.144.163.146', 'Windows 7', 'Opera', '', 0, 2, '', '2020-08-15 08:51:09', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (155, '2020-08-15 08:51:09', '202.141.160.13', 'Windows 7', 'Opera', '', 0, 5, '', '2020-08-15 08:51:10', '四川', '');
INSERT INTO `{pre}statistics` VALUES (156, '2020-08-15 08:51:11', '202.14.236.73', 'Windows 7', 'Opera', '', 0, 8, '', '2020-08-15 08:51:11', '河北', '');
INSERT INTO `{pre}statistics` VALUES (157, '2020-08-15 08:51:11', '116.192.140.52', 'Windows 7', 'Opera', '', 0, 9, '', '2020-08-15 08:51:12', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (158, '2020-08-15 08:51:12', '202.189.80.51', 'Windows 7', 'Opera', '', 0, 1, '', '2020-08-15 08:51:13', '山东', '');
INSERT INTO `{pre}statistics` VALUES (159, '2020-08-15 09:03:18', '220.192.37.247', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 09:03:20', '云南', '');
INSERT INTO `{pre}statistics` VALUES (160, '2020-08-15 09:03:20', '60.255.29.133', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 09:03:23', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (161, '2020-08-15 09:04:53', '202.149.160.77', 'Windows 7', 'Opera', '', 0, 0, '', '0000-00-00 00:00:00', '天津', '');
INSERT INTO `{pre}statistics` VALUES (162, '2020-08-15 09:04:54', '117.103.128.216', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 09:05:01', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (163, '2020-08-15 09:05:01', '219.242.77.151', 'Windows 7', 'Opera', '', 0, 1, '', '2020-08-15 09:05:02', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (164, '2020-08-15 09:05:02', '203.156.192.42', 'Windows 7', 'Opera', '', 0, 2, '', '2020-08-15 09:05:03', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (165, '2020-08-15 09:05:03', '117.80.33.205', 'Windows 7', 'Opera', '', 0, 5, '', '2020-08-15 09:05:04', '河南', '');
INSERT INTO `{pre}statistics` VALUES (166, '2020-08-15 09:05:04', '202.70.163.192', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-15 09:05:05', '广东', '');
INSERT INTO `{pre}statistics` VALUES (167, '2020-08-15 09:05:05', '202.127.212.53', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-15 09:05:05', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (168, '2020-08-15 09:05:05', '117.21.231.39', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-15 09:05:06', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (169, '2020-08-15 09:05:06', '203.132.32.49', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-15 09:05:07', '福建', '');
INSERT INTO `{pre}statistics` VALUES (170, '2020-08-15 09:05:07', '203.90.128.18', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 09:18:08', '北京', '');
INSERT INTO `{pre}statistics` VALUES (171, '2020-08-15 09:05:27', '221.200.86.44', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '江西', '');
INSERT INTO `{pre}statistics` VALUES (172, '2020-08-15 09:06:18', '203.223.59.53', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 09:18:06', '河北', '');
INSERT INTO `{pre}statistics` VALUES (173, '2020-08-15 09:18:18', '202.130.224.59', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '河南', '');
INSERT INTO `{pre}statistics` VALUES (174, '2020-08-15 09:21:04', '221.130.102.165', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-15 10:35:22', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (175, '2020-08-15 09:22:13', '118.88.64.205', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-15 09:22:18', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (176, '2020-08-15 09:22:18', '58.24.242.10', 'Windows 10', 'Firefox', '', 0, 1, '', '2020-08-15 09:22:20', '海南', '');
INSERT INTO `{pre}statistics` VALUES (177, '2020-08-15 09:22:21', '59.32.55.228', 'Windows 10', 'Firefox', '', 0, 2, '', '2020-08-15 09:22:22', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (178, '2020-08-15 09:22:24', '125.171.22.126', 'Windows 10', 'Firefox', '', 0, 5, '', '2020-08-15 09:22:36', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (179, '2020-08-15 09:22:36', '61.29.128.119', 'Windows 10', 'Firefox', '', 0, 5, '', '2020-08-15 09:22:37', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (180, '2020-08-15 09:22:38', '202.127.160.177', 'Windows 10', 'Firefox', '', 0, 5, '', '2020-08-15 09:22:41', '山西', '');
INSERT INTO `{pre}statistics` VALUES (181, '2020-08-15 09:22:41', '203.90.124.228', 'Windows 10', 'Firefox', '360', 0, 5, '', '2020-08-15 09:22:43', '青海', '');
INSERT INTO `{pre}statistics` VALUES (182, '2020-08-15 09:22:43', '120.72.128.195', 'Windows 10', 'Firefox', '', 0, 2, '', '2020-08-15 09:22:44', '北京', '');
INSERT INTO `{pre}statistics` VALUES (183, '2020-08-15 09:22:44', '124.156.134.25', 'Windows 10', 'Firefox', '', 0, 1, '', '2020-08-15 09:22:45', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (184, '2020-08-15 09:22:46', '121.60.197.45', 'Windows 10', 'Firefox', '', 0, 0, '', '2020-08-15 09:23:21', '广东', '');
INSERT INTO `{pre}statistics` VALUES (185, '2020-08-15 09:23:21', '59.80.147.131', 'Windows 10', 'Firefox', '', 0, 0, '', '2020-08-15 09:23:23', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (186, '2020-08-15 09:23:23', '203.92.160.169', 'Windows 10', 'Firefox', '', 0, 0, '', '2020-08-15 09:23:24', '上海', '');
INSERT INTO `{pre}statistics` VALUES (187, '2020-08-15 09:23:25', '202.92.252.237', 'Windows 10', 'Firefox', '', 0, 0, '', '2020-08-15 09:23:43', '北京', '');
INSERT INTO `{pre}statistics` VALUES (188, '2020-08-15 09:23:44', '116.70.229.61', 'Windows 10', 'Firefox', '', 0, 2, '', '2020-08-15 09:23:45', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (189, '2020-08-15 09:23:46', '210.76.104.88', 'Windows 10', 'Firefox', '', 0, 1, '', '2020-08-15 09:23:47', '河北', '');
INSERT INTO `{pre}statistics` VALUES (190, '2020-08-15 09:23:47', '210.21.118.201', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-15 09:23:48', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (191, '2020-08-15 09:23:48', '60.208.80.234', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-15 09:24:02', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (192, '2020-08-15 10:12:06', '116.214.128.169', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '香港', '');
INSERT INTO `{pre}statistics` VALUES (193, '2020-08-15 10:23:20', '219.128.185.248', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-15 10:23:35', '河北', '');
INSERT INTO `{pre}statistics` VALUES (194, '2020-08-15 10:23:59', '125.96.54.183', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 10:24:38', '天津', '');
INSERT INTO `{pre}statistics` VALUES (195, '2020-08-15 10:24:39', '203.135.160.111', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 10:24:41', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (196, '2020-08-15 10:24:42', '123.49.128.147', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 10:24:44', '海南', '');
INSERT INTO `{pre}statistics` VALUES (197, '2020-08-15 10:24:45', '61.29.128.31', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 10:25:02', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (198, '2020-08-15 10:25:03', '123.49.128.17', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-15 10:25:07', '山西', '');
INSERT INTO `{pre}statistics` VALUES (199, '2020-08-15 10:25:07', '123.101.150.194', 'Windows 7', 'Firefox', '', 0, 2, '', '2020-08-15 10:25:19', '青海', '');
INSERT INTO `{pre}statistics` VALUES (200, '2020-08-15 10:25:20', '122.119.154.3', 'Windows 7', 'Firefox', '360', 0, 2, '', '2020-08-15 10:25:44', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (201, '2020-08-15 10:25:44', '119.48.113.1', 'Windows 7', 'Firefox', '360', 0, 0, '', '2020-08-15 11:15:02', '云南', '');
INSERT INTO `{pre}statistics` VALUES (202, '2020-08-15 10:35:22', '161.207.106.64', 'Windows 10', 'Firefox', '360', 0, 9, '', '2020-08-15 10:36:50', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (203, '2020-08-15 10:36:50', '116.208.216.225', 'Windows 10', 'Firefox', '360', 0, 5, '', '2020-08-15 10:36:51', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (204, '2020-08-15 10:36:51', '119.32.25.66', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-15 11:05:30', '上海', '');
INSERT INTO `{pre}statistics` VALUES (205, '2020-08-15 11:05:30', '117.75.146.130', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-15 14:23:53', '福建', '');
INSERT INTO `{pre}statistics` VALUES (206, '2020-08-15 11:15:26', '203.81.16.142', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 11:26:29', '江西', '');
INSERT INTO `{pre}statistics` VALUES (207, '2020-08-15 11:18:47', '120.32.212.22', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (208, '2020-08-15 12:25:26', '125.61.128.135', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '青海', '');
INSERT INTO `{pre}statistics` VALUES (209, '2020-08-15 12:58:47', '116.4.80.1', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (210, '2020-08-15 14:05:26', '221.224.172.126', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (211, '2020-08-15 14:12:41', '124.160.3.193', 'Windows 7', 'Chrome', 'sougouspider', 0, 0, '', '2020-08-15 14:12:51', '江西', '');
INSERT INTO `{pre}statistics` VALUES (212, '2020-08-15 14:16:09', '61.8.160.1', 'Windows 7', 'Chrome', 'sougouspider', 0, 0, '', '2020-08-15 14:16:11', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (213, '2020-08-15 14:16:13', '123.108.208.31', 'Windows 7', 'IE 8.0', 'sougouspider', 0, 0, '', '0000-00-00 00:00:00', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (214, '2020-08-15 14:16:31', '121.51.68.206', 'Windows 7', 'IE 8.0', 'sougouspider', 0, 2, '', '0000-00-00 00:00:00', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (215, '2020-08-15 14:16:33', '203.92.231.184', 'Windows 7', 'IE 8.0', '', 0, 5, '', '0000-00-00 00:00:00', '四川', '');
INSERT INTO `{pre}statistics` VALUES (216, '2020-08-15 14:16:34', '58.99.128.164', 'Windows 7', 'IE 8.0', '', 0, 8, '', '0000-00-00 00:00:00', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (217, '2020-08-15 14:16:35', '119.27.192.186', 'Windows 7', 'IE 8.0', '', 0, 9, '', '0000-00-00 00:00:00', '广西', '');
INSERT INTO `{pre}statistics` VALUES (218, '2020-08-15 14:16:45', '162.105.49.235', 'Windows 7', 'IE 8.0', '', 0, 8, '', '0000-00-00 00:00:00', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (219, '2020-08-15 14:16:47', '169.211.1.90', 'Windows 7', '', '', 0, 10, '', '0000-00-00 00:00:00', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (220, '2020-08-15 14:16:48', '203.212.80.56', 'Windows 7', 'IE 8.0', '', 0, 11, '', '0000-00-00 00:00:00', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (221, '2020-08-15 14:16:49', '58.100.137.146', 'Windows 7', 'IE 8.0', '', 0, 1, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (222, '2020-08-15 14:16:50', '220.248.90.169', 'Windows 7', 'IE 8.0', '', 0, 2, '', '0000-00-00 00:00:00', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (223, '2020-08-15 14:16:51', '121.224.24.140', 'Windows 7', 'IE 8.0', '', 0, 0, '', '0000-00-00 00:00:00', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (224, '2020-08-15 14:16:52', '202.127.192.177', 'Windows 7', 'IE 8.0', '', 0, 1, '', '0000-00-00 00:00:00', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (225, '2020-08-15 14:16:53', '116.212.160.254', 'Windows 7', 'Internet Explorer', '', 0, 5, '', '0000-00-00 00:00:00', '天津', '');
INSERT INTO `{pre}statistics` VALUES (226, '2020-08-15 14:16:53', '122.8.89.0', 'Windows 7', 'Internet Explorer', '360', 0, 8, '', '0000-00-00 00:00:00', '天津', '');
INSERT INTO `{pre}statistics` VALUES (227, '2020-08-15 14:16:54', '203.187.160.206', 'Windows 7', 'Internet Explorer', '360', 0, 9, '', '0000-00-00 00:00:00', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (228, '2020-08-15 14:16:55', '203.88.192.116', 'Windows 7', 'Internet Explorer', '360', 0, 10, '', '0000-00-00 00:00:00', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (229, '2020-08-15 14:16:56', '61.8.160.147', 'Windows 7', 'Internet Explorer', '360', 0, 11, '', '0000-00-00 00:00:00', '河南', '');
INSERT INTO `{pre}statistics` VALUES (230, '2020-08-15 14:16:57', '202.131.208.181', 'Windows 7', 'Internet Explorer', '360', 0, 8, '', '0000-00-00 00:00:00', '山西', '');
INSERT INTO `{pre}statistics` VALUES (231, '2020-08-15 14:16:58', '121.16.38.187', 'Windows 7', 'Internet Explorer', '', 0, 5, '', '0000-00-00 00:00:00', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (232, '2020-08-15 14:17:00', '119.32.121.255', 'Windows 7', 'Internet Explorer', '', 257, 5, '', '0000-00-00 00:00:00', '天津', '');
INSERT INTO `{pre}statistics` VALUES (233, '2020-08-15 14:23:54', '218.104.236.45', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-15 18:08:45', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (234, '2020-08-15 14:36:25', '61.4.80.112', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-15 14:36:27', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (235, '2020-08-15 14:36:27', '202.131.16.59', 'Windows 7', 'Opera', '', 0, 2, '', '2020-08-15 14:37:14', '云南', '');
INSERT INTO `{pre}statistics` VALUES (236, '2020-08-15 14:51:26', '211.160.102.241', 'Windows 10', 'Opera', '', 0, 0, '', '2020-08-15 14:51:32', '四川', '');
INSERT INTO `{pre}statistics` VALUES (237, '2020-08-15 14:51:32', '203.192.39.144', 'Windows 10', 'Opera', '', 0, 0, '', '2020-08-15 14:51:40', '云南', '');
INSERT INTO `{pre}statistics` VALUES (238, '2020-08-15 14:52:16', '202.91.128.1', 'Windows 10', 'Opera', '', 0, 11, '', '2020-08-15 14:52:21', '云南', '');
INSERT INTO `{pre}statistics` VALUES (239, '2020-08-15 14:52:17', '221.199.128.197', 'Windows 10', 'Opera', '', 0, 5, '', '2020-08-15 14:52:27', '海南', '');
INSERT INTO `{pre}statistics` VALUES (240, '2020-08-15 14:52:23', '124.68.83.42', 'Windows 10', 'Opera', '', 0, 11, '', '2020-08-15 14:52:31', '海南', '');
INSERT INTO `{pre}statistics` VALUES (241, '2020-08-15 14:52:28', '123.178.157.5', 'Windows 10', 'Opera', '', 0, 5, '', '2020-08-15 14:52:31', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (242, '2020-08-15 14:53:02', '116.128.237.196', 'Windows 10', 'Opera', '', 0, 0, '', '2020-08-15 14:53:11', '四川', '');
INSERT INTO `{pre}statistics` VALUES (243, '2020-08-15 14:53:11', '58.16.209.176', 'Windows 10', 'Opera', '', 0, 0, '', '2020-08-15 14:53:16', '云南', '');
INSERT INTO `{pre}statistics` VALUES (244, '2020-08-15 14:56:25', '203.110.160.99', 'Windows 10', 'Opera', '', 0, 9, '', '2020-08-15 14:56:29', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (245, '2020-08-15 14:56:30', '125.62.175.166', 'Windows 10', 'Opera', '', 0, 9, '', '2020-08-15 14:56:39', '福建', '');
INSERT INTO `{pre}statistics` VALUES (246, '2020-08-15 14:58:31', '203.174.96.226', 'Windows 10', 'Opera', '', 0, 0, '', '2020-08-15 14:58:41', '香港', '');
INSERT INTO `{pre}statistics` VALUES (247, '2020-08-15 14:58:43', '119.18.192.107', 'Windows 10', 'Opera', '', 0, 0, '', '2020-08-15 14:58:46', '云南', '');
INSERT INTO `{pre}statistics` VALUES (248, '2020-08-15 14:59:45', '202.92.155.212', 'Windows 10', 'Opera', '', 0, 2, '', '2020-08-15 14:59:49', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (249, '2020-08-15 14:59:51', '202.122.128.79', 'Windows 10', 'Opera', '', 0, 2, '', '2020-08-15 15:00:00', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (250, '2020-08-15 14:59:55', '121.46.243.56', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-15 15:00:01', '云南', '');
INSERT INTO `{pre}statistics` VALUES (251, '2020-08-15 15:00:01', '118.180.151.191', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-15 15:00:10', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (252, '2020-08-15 15:02:15', '123.108.208.112', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-15 15:02:20', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (253, '2020-08-15 15:02:21', '116.199.143.214', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-15 15:02:30', '新疆', '');
INSERT INTO `{pre}statistics` VALUES (254, '2020-08-15 15:12:07', '210.15.186.107', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '福建', '');
INSERT INTO `{pre}statistics` VALUES (255, '2020-08-15 15:24:38', '61.232.154.185', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-15 15:24:42', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (256, '2020-08-15 15:24:43', '122.8.58.185', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-15 15:24:52', '新疆', '');
INSERT INTO `{pre}statistics` VALUES (257, '2020-08-15 15:25:35', '202.181.112.229', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-15 15:25:39', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (258, '2020-08-15 15:25:45', '121.89.75.158', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-15 15:25:48', '山西', '');
INSERT INTO `{pre}statistics` VALUES (259, '2020-08-15 16:18:46', '219.224.218.244', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (260, '2020-08-15 17:01:04', '203.119.24.228', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:01:05', '广西', '');
INSERT INTO `{pre}statistics` VALUES (261, '2020-08-15 17:01:06', '202.173.8.36', 'Windows 7', 'Opera', '', 0, 1, '', '2020-08-15 17:01:06', '河北', '');
INSERT INTO `{pre}statistics` VALUES (262, '2020-08-15 17:01:07', '121.46.125.128', 'Windows 7', 'Opera', '', 0, 2, '', '2020-08-15 17:01:08', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (263, '2020-08-15 17:01:08', '210.32.2.0', 'Windows 7', 'Opera', '', 0, 5, '', '2020-08-15 17:01:14', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (264, '2020-08-15 17:01:15', '119.204.199.75', 'Windows 7', 'Opera', '', 0, 5, '', '2020-08-15 17:01:18', '山东', '');
INSERT INTO `{pre}statistics` VALUES (265, '2020-08-15 17:01:19', '202.93.252.137', 'Windows 7', 'Opera', '', 257, 5, '', '2020-08-15 17:01:21', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (266, '2020-08-15 17:01:22', '203.223.77.136', 'Windows 7', 'Opera', '', 0, 2, '', '2020-08-15 17:01:23', '云南', '');
INSERT INTO `{pre}statistics` VALUES (267, '2020-08-15 17:01:25', '219.244.180.240', 'Windows 7', 'Opera', '', 187, 2, '', '2020-08-15 17:01:25', '江西', '');
INSERT INTO `{pre}statistics` VALUES (268, '2020-08-15 17:01:26', '169.211.1.167', 'Windows 7', 'Opera', '', 0, 1, '', '2020-08-15 17:01:27', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (269, '2020-08-15 17:01:28', '210.87.128.213', 'Windows 7', 'Opera', '', 0, 5, '', '2020-08-15 17:01:28', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (270, '2020-08-15 17:01:29', '202.170.128.92', 'Windows 7', 'Opera', '', 0, 8, '', '2020-08-15 17:01:30', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (271, '2020-08-15 17:01:30', '218.249.125.20', 'Windows 7', 'Opera', '', 0, 9, '', '2020-08-15 17:01:43', '河北', '');
INSERT INTO `{pre}statistics` VALUES (272, '2020-08-15 17:01:44', '121.60.75.79', 'Windows 7', 'Opera', '', 38, 9, '', '2020-08-15 17:01:45', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (273, '2020-08-15 17:01:46', '119.48.239.105', 'Windows 7', 'Opera', '', 0, 1, '', '2020-08-15 17:03:19', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (274, '2020-08-15 17:02:02', '123.100.131.112', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 17:02:03', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (275, '2020-08-15 17:02:03', '61.4.176.207', 'Windows 7', 'Opera', '', 0, 1, '', '2020-08-15 17:02:05', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (276, '2020-08-15 17:02:05', '210.32.61.147', 'Windows 7', 'Opera', '', 0, 2, '', '2020-08-15 17:02:05', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (277, '2020-08-15 17:02:06', '203.100.192.180', 'Windows 7', 'Opera', '', 0, 5, '', '2020-08-15 17:02:06', '河北', '');
INSERT INTO `{pre}statistics` VALUES (278, '2020-08-15 17:02:06', '123.242.88.52', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 17:02:07', '江西', '');
INSERT INTO `{pre}statistics` VALUES (279, '2020-08-15 17:02:07', '210.192.96.141', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 17:02:08', '北京', '');
INSERT INTO `{pre}statistics` VALUES (280, '2020-08-15 17:02:08', '119.27.160.219', 'Windows 7', 'Opera', '', 0, 1, '', '2020-08-15 17:02:09', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (281, '2020-08-15 17:02:09', '119.176.211.60', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 17:02:10', '广东', '');
INSERT INTO `{pre}statistics` VALUES (282, '2020-08-15 17:02:10', '124.64.166.17', 'Windows 7', 'Opera', '', 0, 0, '', '2020-08-15 17:02:10', '青海', '');
INSERT INTO `{pre}statistics` VALUES (283, '2020-08-15 17:02:11', '210.21.138.203', 'Windows 7', 'Opera', '', 0, 1, '', '2020-08-15 17:02:13', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (284, '2020-08-15 17:02:14', '202.43.144.240', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:02:14', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (285, '2020-08-15 17:02:15', '202.95.252.170', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:02:15', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (286, '2020-08-15 17:02:15', '123.180.247.181', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 17:03:25', '福建', '');
INSERT INTO `{pre}statistics` VALUES (287, '2020-08-15 17:03:19', '119.80.186.226', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:03:20', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (288, '2020-08-15 17:03:20', '116.255.128.59', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:03:27', '新疆', '');
INSERT INTO `{pre}statistics` VALUES (289, '2020-08-15 17:03:23', '221.198.126.34', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-15 17:03:24', '广西', '');
INSERT INTO `{pre}statistics` VALUES (290, '2020-08-15 17:03:28', '202.38.184.11', 'Windows 7', 'Chrome', '', 184, 2, '', '2020-08-15 17:03:29', '福建', '');
INSERT INTO `{pre}statistics` VALUES (291, '2020-08-15 17:03:30', '118.102.16.56', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:03:31', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (292, '2020-08-15 17:03:32', '121.100.128.129', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:07:24', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (293, '2020-08-15 17:07:25', '116.69.199.85', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 17:07:25', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (294, '2020-08-15 17:07:26', '202.69.4.82', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-15 17:07:26', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (295, '2020-08-15 17:07:27', '118.192.131.221', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:07:27', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (296, '2020-08-15 17:07:28', '116.248.145.121', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:07:29', '宁夏', '');
INSERT INTO `{pre}statistics` VALUES (297, '2020-08-15 17:07:29', '202.127.112.91', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:07:30', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (298, '2020-08-15 17:07:30', '121.100.128.183', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:07:32', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (299, '2020-08-15 17:07:33', '118.67.112.178', 'Windows 7', 'Chrome', '', 184, 2, '', '2020-08-15 17:07:35', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (300, '2020-08-15 17:07:36', '119.20.71.171', 'Windows 7', 'Chrome', '', 184, 2, '', '2020-08-15 17:07:37', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (301, '2020-08-15 17:10:33', '116.207.67.55', 'Windows 7', 'Chrome', '', 184, 2, '', '2020-08-15 17:10:34', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (302, '2020-08-15 17:10:35', '203.209.224.254', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 17:10:36', '广西', '');
INSERT INTO `{pre}statistics` VALUES (303, '2020-08-15 17:10:36', '119.62.90.237', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-15 17:10:37', '福建', '');
INSERT INTO `{pre}statistics` VALUES (304, '2020-08-15 17:10:37', '123.99.128.186', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:10:38', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (305, '2020-08-15 17:10:39', '116.52.135.110', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:10:41', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (306, '2020-08-15 17:10:42', '203.119.24.232', 'Windows 7', 'Chrome', '', 184, 2, '', '2020-08-15 17:10:48', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (307, '2020-08-15 17:10:48', '202.127.112.187', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:10:50', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (308, '2020-08-15 17:10:50', '202.10.64.3', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:10:51', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (309, '2020-08-15 17:10:52', '203.100.96.168', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:10:53', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (310, '2020-08-15 17:10:54', '124.248.211.124', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-15 17:10:55', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (311, '2020-08-15 17:10:55', '125.104.144.131', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-15 17:10:56', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (312, '2020-08-15 17:10:56', '120.90.185.50', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-15 17:11:22', '上海', '');
INSERT INTO `{pre}statistics` VALUES (313, '2020-08-15 17:11:23', '119.148.160.160', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:11:24', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (314, '2020-08-15 17:11:24', '123.138.238.19', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:11:25', '青海', '');
INSERT INTO `{pre}statistics` VALUES (315, '2020-08-15 17:11:26', '116.1.77.147', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:11:26', '河北', '');
INSERT INTO `{pre}statistics` VALUES (316, '2020-08-15 17:11:27', '119.4.138.186', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 17:11:27', '新疆', '');
INSERT INTO `{pre}statistics` VALUES (317, '2020-08-15 17:11:27', '58.68.128.241', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-15 17:11:30', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (318, '2020-08-15 17:11:31', '124.108.40.77', 'Windows 7', 'Chrome', '', 27, 8, '', '2020-08-15 17:11:32', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (319, '2020-08-15 17:11:32', '121.51.107.23', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:11:33', '上海', '');
INSERT INTO `{pre}statistics` VALUES (320, '2020-08-15 17:11:34', '116.248.78.159', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:11:44', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (321, '2020-08-15 17:11:39', '203.191.144.125', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-15 17:11:41', '四川', '');
INSERT INTO `{pre}statistics` VALUES (322, '2020-08-15 17:11:44', '125.254.128.43', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-15 17:11:48', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (323, '2020-08-15 17:11:49', '125.112.160.254', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:12:12', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (324, '2020-08-15 17:12:12', '116.95.198.28', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:12:13', '江西', '');
INSERT INTO `{pre}statistics` VALUES (325, '2020-08-15 17:12:13', '121.59.47.152', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 17:12:14', '山东', '');
INSERT INTO `{pre}statistics` VALUES (326, '2020-08-15 17:12:14', '124.31.53.21', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-15 17:12:15', '香港', '');
INSERT INTO `{pre}statistics` VALUES (327, '2020-08-15 17:12:15', '221.12.52.49', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-15 17:12:16', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (328, '2020-08-15 17:12:16', '118.89.231.80', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:12:17', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (329, '2020-08-15 17:12:17', '202.38.219.107', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:12:28', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (330, '2020-08-15 17:12:28', '59.107.72.11', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:12:36', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (331, '2020-08-15 17:12:37', '124.6.64.169', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:12:38', '宁夏', '');
INSERT INTO `{pre}statistics` VALUES (332, '2020-08-15 17:12:38', '203.83.56.16', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 17:12:39', '河北', '');
INSERT INTO `{pre}statistics` VALUES (333, '2020-08-15 17:12:39', '118.88.32.204', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-15 17:12:40', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (334, '2020-08-15 17:12:41', '124.72.96.241', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-15 17:12:41', '北京', '');
INSERT INTO `{pre}statistics` VALUES (335, '2020-08-15 17:12:42', '202.127.224.7', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-15 17:12:43', '青海', '');
INSERT INTO `{pre}statistics` VALUES (336, '2020-08-15 17:12:43', '221.200.129.148', 'Windows 7', 'Chrome', '', 0, 2, '', '0000-00-00 00:00:00', '河北', '');
INSERT INTO `{pre}statistics` VALUES (337, '2020-08-15 17:12:44', '122.4.200.47', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:12:45', '山东', '');
INSERT INTO `{pre}statistics` VALUES (338, '2020-08-15 17:12:45', '202.170.128.207', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:12:46', '广东', '');
INSERT INTO `{pre}statistics` VALUES (339, '2020-08-15 17:12:47', '202.90.224.52', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:12:47', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (340, '2020-08-15 17:12:48', '121.60.223.10', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:12:48', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (341, '2020-08-15 17:12:49', '59.80.166.53', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 17:12:49', '江西', '');
INSERT INTO `{pre}statistics` VALUES (342, '2020-08-15 17:12:50', '116.52.143.57', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-15 17:12:50', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (343, '2020-08-15 17:12:51', '220.192.70.156', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-15 17:12:51', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (344, '2020-08-15 17:12:52', '119.128.56.61', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-15 17:16:27', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (345, '2020-08-15 17:16:27', '124.40.128.41', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:16:29', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (346, '2020-08-15 17:16:30', '202.136.48.211', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:16:30', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (347, '2020-08-15 17:16:31', '119.48.151.28', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:16:32', '广东', '');
INSERT INTO `{pre}statistics` VALUES (348, '2020-08-15 17:16:32', '203.207.64.202', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:16:33', '广西', '');
INSERT INTO `{pre}statistics` VALUES (349, '2020-08-15 17:16:33', '169.211.1.59', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 17:16:34', '青海', '');
INSERT INTO `{pre}statistics` VALUES (350, '2020-08-15 17:16:34', '119.57.239.223', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-15 17:16:35', '北京', '');
INSERT INTO `{pre}statistics` VALUES (351, '2020-08-15 17:16:36', '58.100.107.158', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-15 17:16:36', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (352, '2020-08-15 17:16:37', '202.192.109.135', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-15 17:16:37', '新疆', '');
INSERT INTO `{pre}statistics` VALUES (353, '2020-08-15 17:16:38', '203.207.64.211', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-15 17:16:39', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (354, '2020-08-15 17:16:39', '119.44.149.144', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:16:40', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (355, '2020-08-15 17:16:40', '202.92.252.117', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:17:55', '河南', '');
INSERT INTO `{pre}statistics` VALUES (356, '2020-08-15 17:17:55', '202.173.8.221', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:17:56', '河北', '');
INSERT INTO `{pre}statistics` VALUES (357, '2020-08-15 17:17:56', '123.151.128.60', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 17:18:13', '海南', '');
INSERT INTO `{pre}statistics` VALUES (358, '2020-08-15 17:18:13', '120.128.122.158', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:18:15', '青海', '');
INSERT INTO `{pre}statistics` VALUES (359, '2020-08-15 17:18:15', '119.27.64.193', 'Windows 7', 'Chrome', '', 0, 9, '', '0000-00-00 00:00:00', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (360, '2020-08-15 17:18:16', '203.142.219.93', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-15 17:18:17', '江西', '');
INSERT INTO `{pre}statistics` VALUES (361, '2020-08-15 17:18:17', '122.49.55.47', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-15 17:18:18', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (362, '2020-08-15 17:18:19', '116.192.41.96', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-15 17:18:24', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (363, '2020-08-15 17:18:25', '222.240.63.168', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 17:18:26', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (364, '2020-08-15 17:18:28', '117.22.145.211', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-15 17:18:52', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (365, '2020-08-15 17:19:01', '121.89.219.103', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 17:19:02', '福建', '');
INSERT INTO `{pre}statistics` VALUES (366, '2020-08-15 17:19:03', '123.8.23.208', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:19:26', '云南', '');
INSERT INTO `{pre}statistics` VALUES (367, '2020-08-15 17:19:26', '123.253.145.96', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 17:41:33', '河北', '');
INSERT INTO `{pre}statistics` VALUES (368, '2020-08-15 17:25:26', '60.253.128.57', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '河南', '');
INSERT INTO `{pre}statistics` VALUES (369, '2020-08-15 18:01:46', '119.235.128.35', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (370, '2020-08-15 18:08:46', '202.179.240.66', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-15 18:11:16', '河北', '');
INSERT INTO `{pre}statistics` VALUES (371, '2020-08-15 18:11:17', '203.187.160.30', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 09:26:04', '广西', '');
INSERT INTO `{pre}statistics` VALUES (372, '2020-08-15 18:12:51', '124.31.187.50', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 18:12:54', '上海', '');
INSERT INTO `{pre}statistics` VALUES (373, '2020-08-15 18:12:55', '118.66.137.76', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 18:12:57', '河南', '');
INSERT INTO `{pre}statistics` VALUES (374, '2020-08-15 18:12:57', '121.40.72.161', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 18:12:58', '香港', '');
INSERT INTO `{pre}statistics` VALUES (375, '2020-08-15 18:12:58', '58.68.128.127', 'Windows 7', 'Chrome', 'yahu', 0, 5, '', '2020-08-15 18:12:58', '海南', '');
INSERT INTO `{pre}statistics` VALUES (376, '2020-08-15 18:12:58', '202.112.152.186', 'Windows 7', 'Chrome', 'souhu', 0, 8, '', '2020-08-15 18:13:00', '河北', '');
INSERT INTO `{pre}statistics` VALUES (377, '2020-08-15 19:05:27', '125.31.192.104', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (378, '2020-08-15 20:12:07', '202.38.149.43', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '四川', '');
INSERT INTO `{pre}statistics` VALUES (379, '2020-08-15 21:18:47', '117.103.16.69', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '山东', '');
INSERT INTO `{pre}statistics` VALUES (380, '2020-08-15 21:52:07', '202.38.138.188', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (381, '2020-08-15 22:19:59', '119.57.17.254', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '江西', '');
INSERT INTO `{pre}statistics` VALUES (382, '2020-08-15 22:19:59', '203.99.16.102', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (383, '2020-08-15 22:21:33', '122.204.193.128', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 22:21:34', '山西', '');
INSERT INTO `{pre}statistics` VALUES (384, '2020-08-15 22:21:34', '202.14.238.25', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 22:21:35', '海南', '');
INSERT INTO `{pre}statistics` VALUES (385, '2020-08-15 22:21:36', '211.160.210.27', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 22:21:36', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (386, '2020-08-15 22:21:37', '124.108.40.67', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 22:21:38', '山东', '');
INSERT INTO `{pre}statistics` VALUES (387, '2020-08-15 22:21:39', '123.99.128.241', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-15 22:22:03', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (388, '2020-08-15 22:22:04', '119.232.131.98', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 22:22:09', '河南', '');
INSERT INTO `{pre}statistics` VALUES (389, '2020-08-15 22:22:10', '118.67.112.106', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-15 22:22:11', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (390, '2020-08-15 22:22:12', '122.144.128.245', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 22:22:13', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (391, '2020-08-15 22:22:14', '117.22.43.238', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 22:22:15', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (392, '2020-08-15 22:22:15', '119.16.117.233', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-15 22:22:16', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (393, '2020-08-15 22:22:16', '116.208.97.190', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-15 22:22:17', '北京', '');
INSERT INTO `{pre}statistics` VALUES (394, '2020-08-15 22:22:18', '210.16.128.200', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-15 22:22:19', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (395, '2020-08-15 22:22:20', '117.48.63.90', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-15 22:22:24', '青海', '');
INSERT INTO `{pre}statistics` VALUES (396, '2020-08-15 22:22:24', '123.99.128.218', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-15 22:22:25', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (397, '2020-08-15 22:58:47', '203.86.64.60', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '山东', '');
INSERT INTO `{pre}statistics` VALUES (398, '2020-08-16 00:05:34', '202.127.216.21', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (399, '2020-08-16 01:12:07', '111.206.198.29', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (400, '2020-08-16 02:52:06', '111.206.222.5', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (401, '2020-08-16 03:58:47', '111.206.198.68', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '上海', '');
INSERT INTO `{pre}statistics` VALUES (402, '2020-08-16 05:05:26', '111.206.221.38', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (403, '2020-08-16 06:12:07', '111.206.198.27', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (404, '2020-08-16 07:18:47', '111.206.198.125', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (405, '2020-08-16 08:58:48', '111.206.221.29', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '福建', '');
INSERT INTO `{pre}statistics` VALUES (406, '2020-08-16 10:59:53', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (407, '2020-08-16 10:59:59', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (408, '2020-08-16 11:12:07', '111.206.198.108', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (409, '2020-08-16 11:36:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:37:03', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (410, '2020-08-16 11:37:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:37:06', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (411, '2020-08-16 11:37:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:37:55', '广东', '');
INSERT INTO `{pre}statistics` VALUES (412, '2020-08-16 11:37:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:39:04', '青海', '');
INSERT INTO `{pre}statistics` VALUES (413, '2020-08-16 11:39:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:40:21', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (414, '2020-08-16 11:40:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:41:18', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (415, '2020-08-16 11:41:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:42:41', '广西', '');
INSERT INTO `{pre}statistics` VALUES (416, '2020-08-16 11:42:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:44:33', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (417, '2020-08-16 11:44:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:44:45', '上海', '');
INSERT INTO `{pre}statistics` VALUES (418, '2020-08-16 11:44:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:45:23', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (419, '2020-08-16 11:45:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-16 11:45:02', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (420, '2020-08-16 11:45:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-16 11:45:05', '天津', '');
INSERT INTO `{pre}statistics` VALUES (421, '2020-08-16 11:45:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 11:48:40', '海南', '');
INSERT INTO `{pre}statistics` VALUES (422, '2020-08-16 11:48:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 12:00:12', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (423, '2020-08-16 12:00:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 12:11:57', '宁夏', '');
INSERT INTO `{pre}statistics` VALUES (424, '2020-08-16 12:11:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 12:12:23', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (425, '2020-08-16 12:12:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-16 12:13:18', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (426, '2020-08-16 12:18:47', '111.206.221.85', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (427, '2020-08-16 12:22:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 12:24:02', '青海', '');
INSERT INTO `{pre}statistics` VALUES (428, '2020-08-16 12:24:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 12:25:55', '海南', '');
INSERT INTO `{pre}statistics` VALUES (429, '2020-08-16 12:26:04', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 12:26:06', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (430, '2020-08-16 12:26:07', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 12:26:07', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (431, '2020-08-16 12:26:07', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-16 12:26:08', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (432, '2020-08-16 12:26:08', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 12:26:13', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (433, '2020-08-16 12:26:13', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 12:26:15', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (434, '2020-08-16 12:26:15', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-16 12:26:17', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (435, '2020-08-16 12:26:17', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-16 12:26:19', '内蒙古', '');
INSERT INTO `{pre}statistics` VALUES (436, '2020-08-16 12:26:19', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-16 12:26:21', '天津', '');
INSERT INTO `{pre}statistics` VALUES (437, '2020-08-16 12:26:21', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-16 12:26:26', '上海', '');
INSERT INTO `{pre}statistics` VALUES (438, '2020-08-16 12:26:26', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-16 12:26:30', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (439, '2020-08-16 12:26:30', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 12:26:30', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (440, '2020-08-16 12:26:30', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 12:26:32', '福建', '');
INSERT INTO `{pre}statistics` VALUES (441, '2020-08-16 12:26:33', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 12:26:33', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (442, '2020-08-16 12:26:34', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 12:26:35', '山西', '');
INSERT INTO `{pre}statistics` VALUES (443, '2020-08-16 12:26:36', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 12:26:44', '天津', '');
INSERT INTO `{pre}statistics` VALUES (444, '2020-08-16 12:26:44', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 12:26:51', '澳门', '');
INSERT INTO `{pre}statistics` VALUES (445, '2020-08-16 12:26:51', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 12:26:52', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (446, '2020-08-16 12:26:52', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-16 12:26:56', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (447, '2020-08-16 12:28:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 19:47:43', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (448, '2020-08-16 12:52:07', '111.206.221.34', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (449, '2020-08-16 13:58:47', '111.206.198.196', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '宁夏', '');
INSERT INTO `{pre}statistics` VALUES (450, '2020-08-16 14:50:03', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 19:47:45', '上海', '');
INSERT INTO `{pre}statistics` VALUES (451, '2020-08-16 15:05:40', '111.206.221.13', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '天津', '');
INSERT INTO `{pre}statistics` VALUES (452, '2020-08-16 16:12:07', '111.206.198.40', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '江西', '');
INSERT INTO `{pre}statistics` VALUES (453, '2020-08-16 17:52:07', '111.206.198.15', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '宁夏', '');
INSERT INTO `{pre}statistics` VALUES (454, '2020-08-16 18:58:47', '111.206.221.115', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (455, '2020-08-16 19:47:45', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 19:47:46', '广东', '');
INSERT INTO `{pre}statistics` VALUES (456, '2020-08-16 19:47:46', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-16 19:47:47', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (457, '2020-08-16 19:47:47', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-16 19:47:48', '河南', '');
INSERT INTO `{pre}statistics` VALUES (458, '2020-08-16 19:47:48', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 20:19:37', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (459, '2020-08-16 19:47:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 19:47:45', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (460, '2020-08-16 19:47:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 20:19:28', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (461, '2020-08-16 20:05:27', '111.206.221.79', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '四川', '');
INSERT INTO `{pre}statistics` VALUES (462, '2020-08-16 20:19:37', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 20:19:38', '贵州', '');
INSERT INTO `{pre}statistics` VALUES (463, '2020-08-16 20:19:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '福建', '');
INSERT INTO `{pre}statistics` VALUES (464, '2020-08-16 20:19:38', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-16 20:19:39', '江西', '');
INSERT INTO `{pre}statistics` VALUES (465, '2020-08-16 20:19:39', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-16 20:19:41', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (466, '2020-08-16 20:19:41', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-16 20:19:42', '山西', '');
INSERT INTO `{pre}statistics` VALUES (467, '2020-08-16 20:19:42', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 20:19:43', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (468, '2020-08-16 20:19:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 20:19:50', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (469, '2020-08-16 20:19:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 20:19:54', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (470, '2020-08-16 20:19:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-16 20:20:01', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (471, '2020-08-16 21:20:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (472, '2020-08-16 21:53:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-16 21:54:15', '海南', '');
INSERT INTO `{pre}statistics` VALUES (473, '2020-08-16 21:54:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 21:57:02', '吉林', '');
INSERT INTO `{pre}statistics` VALUES (474, '2020-08-16 21:55:06', '111.206.221.37', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '江西', '');
INSERT INTO `{pre}statistics` VALUES (475, '2020-08-16 21:57:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 21:57:03', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (476, '2020-08-16 21:57:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-16 21:57:04', '上海', '');
INSERT INTO `{pre}statistics` VALUES (477, '2020-08-16 21:57:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-16 21:58:05', '四川', '');
INSERT INTO `{pre}statistics` VALUES (478, '2020-08-16 21:58:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-16 21:58:07', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (479, '2020-08-16 21:58:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-16 21:58:27', '上海', '');
INSERT INTO `{pre}statistics` VALUES (480, '2020-08-16 21:58:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-16 21:58:38', '新疆', '');
INSERT INTO `{pre}statistics` VALUES (481, '2020-08-16 23:01:44', '111.206.221.51', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '江苏', '');
INSERT INTO `{pre}statistics` VALUES (482, '2020-08-17 01:15:01', '111.206.198.46', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (483, '2020-08-17 02:21:41', '111.206.221.115', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (484, '2020-08-17 02:55:02', '111.206.221.115', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '西藏', '');
INSERT INTO `{pre}statistics` VALUES (485, '2020-08-17 04:01:42', '111.206.221.93', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '上海', '');
INSERT INTO `{pre}statistics` VALUES (486, '2020-08-17 05:08:22', '111.206.221.88', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '四川', '');
INSERT INTO `{pre}statistics` VALUES (487, '2020-08-17 06:15:02', '111.206.198.72', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '青海', '');
INSERT INTO `{pre}statistics` VALUES (488, '2020-08-17 07:21:41', '111.206.221.99', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (489, '2020-08-17 07:55:02', '111.206.221.15', 'iOS', '', 'Baiduspider', 0, 9, '', '0000-00-00 00:00:00', '广东', '');
INSERT INTO `{pre}statistics` VALUES (490, '2020-08-17 08:28:22', '111.206.221.95', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '青海', '');
INSERT INTO `{pre}statistics` VALUES (491, '2020-08-17 08:31:42', '111.206.221.25', 'iOS', '', 'Baiduspider', 0, 3, '', '0000-00-00 00:00:00', '山西', '');
INSERT INTO `{pre}statistics` VALUES (492, '2020-08-17 08:31:43', '111.206.198.98', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (493, '2020-08-17 08:35:02', '111.206.221.92', 'iOS', '', 'Baiduspider', 0, 6, '', '0000-00-00 00:00:00', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (494, '2020-08-17 08:35:02', '111.206.221.80', 'iOS', '', 'Baiduspider', 0, 5, '', '0000-00-00 00:00:00', '香港', '');
INSERT INTO `{pre}statistics` VALUES (495, '2020-08-17 08:38:22', '111.206.221.100', 'iOS', '', 'Baiduspider', 0, 7, '', '0000-00-00 00:00:00', '海南', '');
INSERT INTO `{pre}statistics` VALUES (496, '2020-08-17 08:38:23', '111.206.221.34', 'iOS', '', 'Baiduspider', 0, 8, '', '0000-00-00 00:00:00', '台湾', '');
INSERT INTO `{pre}statistics` VALUES (497, '2020-08-17 08:41:42', '111.206.198.5', 'iOS', '', 'Baiduspider', 0, 11, '', '0000-00-00 00:00:00', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (498, '2020-08-17 08:42:02', '111.206.221.10', 'iOS', '', 'Baiduspider', 0, 10, '', '0000-00-00 00:00:00', '新疆', '');
INSERT INTO `{pre}statistics` VALUES (499, '2020-08-17 08:45:01', '220.181.108.76', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '广西', '');
INSERT INTO `{pre}statistics` VALUES (500, '2020-08-17 08:45:03', '111.206.221.110', 'iOS', '', 'Baiduspider', 187, 2, '', '0000-00-00 00:00:00', '浙江', '');
INSERT INTO `{pre}statistics` VALUES (501, '2020-08-17 08:48:22', '111.206.198.108', 'iOS', '', 'Baiduspider', 0, 4, '', '0000-00-00 00:00:00', '香港', '');
INSERT INTO `{pre}statistics` VALUES (502, '2020-08-17 08:51:44', '111.206.221.97', 'iOS', '', 'Baiduspider', 186, 2, '', '0000-00-00 00:00:00', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (503, '2020-08-17 08:55:02', '111.206.221.43', 'iOS', '', 'Baiduspider', 35, 9, '', '0000-00-00 00:00:00', '广东', '');
INSERT INTO `{pre}statistics` VALUES (504, '2020-08-17 08:55:03', '111.206.221.19', 'iOS', '', 'Baiduspider', 185, 2, '', '0000-00-00 00:00:00', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (505, '2020-08-17 08:58:22', '111.206.222.204', 'iOS', '', 'Baiduspider', 38, 9, '', '0000-00-00 00:00:00', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (506, '2020-08-17 09:01:42', '111.206.198.126', 'iOS', '', 'Baiduspider', 34, 9, '', '0000-00-00 00:00:00', '南海诸岛', '');
INSERT INTO `{pre}statistics` VALUES (507, '2020-08-17 09:01:42', '111.206.221.110', 'iOS', '', 'Baiduspider', 37, 9, '', '0000-00-00 00:00:00', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (508, '2020-08-17 09:05:02', '111.206.198.72', 'iOS', '', 'Baiduspider', 25, 9, '', '0000-00-00 00:00:00', '湖南', '');
INSERT INTO `{pre}statistics` VALUES (509, '2020-08-17 09:05:02', '111.206.198.26', 'iOS', '', 'Baiduspider', 36, 9, '', '0000-00-00 00:00:00', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (510, '2020-08-17 09:08:22', '111.206.221.94', 'iOS', '', 'Baiduspider', 39, 9, '', '0000-00-00 00:00:00', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (511, '2020-08-17 09:08:22', '111.206.221.110', 'iOS', '', 'Baiduspider', 33, 9, '', '0000-00-00 00:00:00', '湖北', '');
INSERT INTO `{pre}statistics` VALUES (512, '2020-08-17 09:11:42', '111.206.221.70', 'iOS', '', 'Baiduspider', 0, 9, '', '0000-00-00 00:00:00', '陕西', '');
INSERT INTO `{pre}statistics` VALUES (513, '2020-08-17 09:26:05', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 10:09:10', '甘肃', '');
INSERT INTO `{pre}statistics` VALUES (514, '2020-08-17 09:27:48', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 09:28:02', '黑龙江', '');
INSERT INTO `{pre}statistics` VALUES (515, '2020-08-17 09:28:05', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 09:28:09', '安徽', '');
INSERT INTO `{pre}statistics` VALUES (516, '2020-08-17 09:28:15', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 09:28:20', '天津', '');
INSERT INTO `{pre}statistics` VALUES (517, '2020-08-17 09:28:20', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 09:28:24', '天津', '');
INSERT INTO `{pre}statistics` VALUES (518, '2020-08-17 09:28:24', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 09:28:25', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (519, '2020-08-17 09:28:26', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 12:14:57', '河北', '');
INSERT INTO `{pre}statistics` VALUES (520, '2020-08-17 10:09:11', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 10:09:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (521, '2020-08-17 10:09:29', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 10:09:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (522, '2020-08-17 10:09:30', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 10:10:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (523, '2020-08-17 10:10:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 10:10:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (524, '2020-08-17 10:10:25', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 10:10:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (525, '2020-08-17 10:10:27', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 10:10:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (526, '2020-08-17 10:10:28', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 10:10:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (527, '2020-08-17 10:10:30', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 10:42:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (528, '2020-08-17 10:40:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 10:40:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (529, '2020-08-17 10:40:35', '223.72.69.26', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (530, '2020-08-17 10:40:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 10:40:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (531, '2020-08-17 10:40:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 10:40:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (532, '2020-08-17 10:40:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 10:47:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (533, '2020-08-17 10:42:10', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 10:42:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (534, '2020-08-17 10:42:11', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 10:42:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (535, '2020-08-17 10:42:14', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 10:42:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (536, '2020-08-17 10:42:16', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 10:42:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (537, '2020-08-17 10:42:21', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 11:03:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (538, '2020-08-17 10:45:15', '111.206.222.143', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (539, '2020-08-17 10:47:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 10:47:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (540, '2020-08-17 10:47:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 10:47:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (541, '2020-08-17 10:51:15', '111.206.221.74', 'iOS', '', 'Baiduspider', 0, 9, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (542, '2020-08-17 10:53:11', '220.181.108.117', 'Unknown Platform', '', 'Baiduspider', 0, 9, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (543, '2020-08-17 10:55:07', '111.206.198.46', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (544, '2020-08-17 10:55:07', '111.206.221.44', 'iOS', '', 'Baiduspider', 0, 9, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (545, '2020-08-17 10:55:19', '220.181.108.155', 'Unknown Platform', '', 'Baiduspider', 0, 1, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (546, '2020-08-17 11:01:08', '111.206.221.19', 'iOS', '', 'Baiduspider', 170, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (547, '2020-08-17 11:03:03', '111.206.221.83', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (548, '2020-08-17 11:03:17', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 11:03:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (549, '2020-08-17 11:03:59', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 11:04:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (550, '2020-08-17 11:04:21', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-17 11:04:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (551, '2020-08-17 11:04:46', '127.0.0.1', 'Windows 10', 'Chrome', '', 181, 2, '', '2020-08-17 11:04:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (552, '2020-08-17 11:04:49', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 11:04:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (553, '2020-08-17 11:04:50', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 11:10:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (554, '2020-08-17 11:06:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 11:08:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (555, '2020-08-17 11:06:55', '220.181.108.81', 'Unknown Platform', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (556, '2020-08-17 11:08:52', '111.206.222.93', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (557, '2020-08-17 11:08:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 11:12:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (558, '2020-08-17 11:10:43', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 11:10:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (559, '2020-08-17 11:10:45', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 11:10:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (560, '2020-08-17 11:12:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 11:12:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (561, '2020-08-17 11:12:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 11:12:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (562, '2020-08-17 11:12:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 11:13:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (563, '2020-08-17 11:12:45', '111.206.221.39', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (564, '2020-08-17 11:13:08', '111.206.221.68', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (565, '2020-08-17 11:13:13', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 11:15:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (566, '2020-08-17 11:15:16', '111.206.221.24', 'iOS', '', 'Baiduspider', 181, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (567, '2020-08-17 11:16:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 11:16:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (568, '2020-08-17 11:16:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 11:16:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (569, '2020-08-17 11:16:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 11:16:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (570, '2020-08-17 11:16:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 11:16:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (571, '2020-08-17 11:16:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 11:25:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (572, '2020-08-17 11:18:56', '111.206.198.27', 'iOS', '', 'Baiduspider', 179, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (573, '2020-08-17 11:20:52', '111.206.221.80', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (574, '2020-08-17 11:25:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 11:38:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (575, '2020-08-17 11:28:36', '111.206.221.22', 'iOS', '', 'Baiduspider', 0, 3, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (576, '2020-08-17 11:32:29', '111.206.198.46', 'iOS', '', 'Baiduspider', 150, 12, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (577, '2020-08-17 11:34:25', '111.206.198.72', 'iOS', '', 'Baiduspider', 151, 12, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (578, '2020-08-17 11:38:17', '111.206.221.39', 'iOS', '', 'Baiduspider', 0, 3, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (579, '2020-08-17 11:38:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 11:38:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (580, '2020-08-17 11:38:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 11:44:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (581, '2020-08-17 11:42:10', '111.206.198.9', 'iOS', '', 'Baiduspider', 149, 12, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (582, '2020-08-17 11:44:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 11:47:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (583, '2020-08-17 11:46:02', '111.206.198.27', 'iOS', '', 'Baiduspider', 0, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (584, '2020-08-17 11:47:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 11:47:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (585, '2020-08-17 11:47:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 11:47:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (586, '2020-08-17 11:47:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 11:47:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (587, '2020-08-17 11:47:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 11:47:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (588, '2020-08-17 11:47:39', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 11:47:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (589, '2020-08-17 11:47:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 11:47:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (590, '2020-08-17 11:47:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 11:47:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (591, '2020-08-17 11:47:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 11:47:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (592, '2020-08-17 11:47:58', '111.206.198.108', 'iOS', '', 'Baiduspider', 0, 6, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (593, '2020-08-17 11:47:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 11:47:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (594, '2020-08-17 11:47:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 11:48:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (595, '2020-08-17 11:48:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 11:52:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (596, '2020-08-17 11:49:53', '111.206.221.38', 'iOS', '', 'Baiduspider', 0, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (597, '2020-08-17 11:50:05', '111.206.221.2', 'iOS', '', 'Baiduspider', 0, 6, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (598, '2020-08-17 11:52:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 11:52:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (599, '2020-08-17 11:52:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 11:52:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (600, '2020-08-17 11:53:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 11:53:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (601, '2020-08-17 11:53:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 11:53:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (602, '2020-08-17 11:53:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:06:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (603, '2020-08-17 11:53:58', '111.206.221.50', 'iOS', '', 'Baiduspider', 0, 6, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (604, '2020-08-17 11:55:54', '111.206.221.73', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (605, '2020-08-17 11:58:01', '220.181.108.176', 'Unknown Platform', '', 'Baiduspider', 0, 6, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (606, '2020-08-17 12:01:54', '111.206.198.26', 'iOS', '', 'Baiduspider', 257, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (607, '2020-08-17 12:03:51', '111.206.198.141', 'iOS', '', 'Baiduspider', 28, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (608, '2020-08-17 12:03:53', '111.206.221.78', 'iOS', '', 'Baiduspider', 30, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (609, '2020-08-17 12:04:03', '111.206.221.36', 'iOS', '', 'Baiduspider', 31, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (610, '2020-08-17 12:04:14', '111.206.221.72', 'iOS', '', 'Baiduspider', 32, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (611, '2020-08-17 12:04:21', '111.206.221.34', 'iOS', '', 'Baiduspider', 30, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (612, '2020-08-17 12:04:56', '111.206.221.82', 'iOS', '', 'Baiduspider', 254, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (613, '2020-08-17 12:06:21', '111.206.198.6', 'iOS', '', 'Baiduspider', 258, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (614, '2020-08-17 12:06:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:06:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (615, '2020-08-17 12:06:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 258, 5, '', '2020-08-17 12:11:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (616, '2020-08-17 12:10:14', '111.206.221.71', 'iOS', '', 'Baiduspider', 256, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (617, '2020-08-17 12:11:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 258, 5, '', '2020-08-17 12:11:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (618, '2020-08-17 12:11:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:19:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (619, '2020-08-17 12:14:05', '111.206.221.110', 'iOS', '', 'Baiduspider', 0, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (620, '2020-08-17 12:16:03', '111.206.222.16', 'iOS', '', 'Baiduspider', 251, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (621, '2020-08-17 12:16:04', '111.206.221.103', 'iOS', '', 'Baiduspider', 250, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (622, '2020-08-17 12:16:14', '111.206.221.93', 'iOS', '', 'Baiduspider', 255, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (623, '2020-08-17 12:18:09', '111.206.221.38', 'iOS', '', 'Baiduspider', 0, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (624, '2020-08-17 12:20:05', '111.206.198.72', 'iOS', '', 'Baiduspider', 0, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (625, '2020-08-17 12:22:01', '220.181.108.79', 'Unknown Platform', '', 'Baiduspider', 0, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (626, '2020-08-17 12:23:00', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 12:23:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (627, '2020-08-17 12:23:05', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:23:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (628, '2020-08-17 12:23:06', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:23:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (629, '2020-08-17 12:23:09', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 12:23:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (630, '2020-08-17 12:23:10', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 12:23:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (631, '2020-08-17 12:23:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:23:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (632, '2020-08-17 12:23:21', '111.206.221.26', 'iOS', '', 'Baiduspider', 0, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (633, '2020-08-17 12:23:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:23:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (634, '2020-08-17 12:23:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:23:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (635, '2020-08-17 12:23:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:23:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (636, '2020-08-17 12:23:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:23:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (637, '2020-08-17 12:23:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:23:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (638, '2020-08-17 12:23:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:23:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (639, '2020-08-17 12:23:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:23:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (640, '2020-08-17 12:23:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:23:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (641, '2020-08-17 12:23:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:23:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (642, '2020-08-17 12:23:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:23:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (643, '2020-08-17 12:23:27', '127.0.0.1', 'Android', 'Chrome', '', 0, 1, '', '2020-08-17 12:23:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (644, '2020-08-17 12:23:42', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:23:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (645, '2020-08-17 12:23:43', '127.0.0.1', 'Windows 10', 'Chrome', '', 257, 5, '', '2020-08-17 12:24:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (646, '2020-08-17 12:23:45', '111.206.221.104', 'iOS', '', 'Baiduspider', 0, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (647, '2020-08-17 12:24:06', '127.0.0.1', 'Windows 7', 'Internet Explorer', '', 0, 0, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (648, '2020-08-17 12:24:19', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:24:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (649, '2020-08-17 12:24:19', '116.179.32.36', 'Unknown Platform', '', 'Baiduspider', 0, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (650, '2020-08-17 12:24:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:25:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (651, '2020-08-17 12:24:34', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 12:24:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (652, '2020-08-17 12:24:36', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 12:24:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (653, '2020-08-17 12:24:37', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 12:24:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (654, '2020-08-17 12:24:41', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:24:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (655, '2020-08-17 12:24:43', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 12:24:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (656, '2020-08-17 12:24:46', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:24:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (657, '2020-08-17 12:24:49', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:28:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (658, '2020-08-17 12:24:58', '111.206.221.84', 'iOS', '', 'Baiduspider', 109, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (659, '2020-08-17 12:24:59', '111.206.198.26', 'iOS', '', 'Baiduspider', 0, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (660, '2020-08-17 12:24:59', '111.206.221.71', 'iOS', '', 'Baiduspider', 0, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (661, '2020-08-17 12:25:00', '111.206.221.14', 'iOS', '', 'Baiduspider', 111, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (662, '2020-08-17 12:25:01', '111.206.198.166', 'iOS', '', 'Baiduspider', 110, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (663, '2020-08-17 12:25:03', '111.206.221.91', 'iOS', '', 'Baiduspider', 108, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (664, '2020-08-17 12:25:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:25:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (665, '2020-08-17 12:25:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:25:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (666, '2020-08-17 12:25:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:25:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (667, '2020-08-17 12:25:18', '127.0.0.1', 'Android', 'Chrome', '', 0, 2, '', '2020-08-17 12:25:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (668, '2020-08-17 12:25:29', '111.206.221.98', 'iOS', '', 'Baiduspider', 0, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (669, '2020-08-17 12:25:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:25:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (670, '2020-08-17 12:25:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:25:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (671, '2020-08-17 12:25:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:25:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (672, '2020-08-17 12:25:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:25:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (673, '2020-08-17 12:25:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:25:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (674, '2020-08-17 12:25:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:25:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (675, '2020-08-17 12:25:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:26:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (676, '2020-08-17 12:26:04', '111.206.221.31', 'iOS', '', 'Baiduspider', 0, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (677, '2020-08-17 12:26:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:26:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (678, '2020-08-17 12:26:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:26:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (679, '2020-08-17 12:26:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:26:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (680, '2020-08-17 12:26:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:26:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (681, '2020-08-17 12:26:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:26:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (682, '2020-08-17 12:26:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:26:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (683, '2020-08-17 12:26:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 12:26:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (684, '2020-08-17 12:26:39', '111.206.221.90', 'iOS', '', 'Baiduspider', 227, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (685, '2020-08-17 12:26:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 12:26:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (686, '2020-08-17 12:26:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:26:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (687, '2020-08-17 12:26:58', '127.0.0.1', 'Android', 'Chrome', '', 0, 0, '', '2020-08-17 12:27:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (688, '2020-08-17 12:27:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:27:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (689, '2020-08-17 12:27:32', '127.0.0.1', 'Android', 'Chrome', '', 0, 0, '', '2020-08-17 12:27:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (690, '2020-08-17 12:27:40', '127.0.0.1', 'Android', 'Chrome', '', 0, 0, '', '2020-08-17 12:27:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (691, '2020-08-17 12:28:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:28:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (692, '2020-08-17 12:28:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:28:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (693, '2020-08-17 12:28:08', '127.0.0.1', 'Android', 'Chrome', '', 0, 0, '', '2020-08-17 12:28:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (694, '2020-08-17 12:28:22', '111.206.221.82', 'iOS', '', 'Baiduspider', 0, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (695, '2020-08-17 12:28:34', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 12:28:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (696, '2020-08-17 12:28:37', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:28:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (697, '2020-08-17 12:28:39', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:28:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (698, '2020-08-17 12:28:41', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 12:28:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (699, '2020-08-17 12:28:42', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 12:28:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (700, '2020-08-17 12:28:44', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 12:28:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (701, '2020-08-17 12:28:45', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:51:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (702, '2020-08-17 12:28:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:28:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (703, '2020-08-17 12:28:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:28:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (704, '2020-08-17 12:28:57', '111.206.198.21', 'iOS', '', 'Baiduspider', 223, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (705, '2020-08-17 12:28:48', '127.0.0.1', 'Android', 'Chrome', '', 0, 0, '', '2020-08-17 12:29:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (706, '2020-08-17 12:29:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:29:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (707, '2020-08-17 12:29:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:29:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (708, '2020-08-17 12:29:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:29:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (709, '2020-08-17 12:29:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:29:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (710, '2020-08-17 12:29:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:29:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (711, '2020-08-17 12:29:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:29:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (712, '2020-08-17 12:29:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:29:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (713, '2020-08-17 12:29:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:29:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (714, '2020-08-17 12:29:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:29:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (715, '2020-08-17 12:29:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:29:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (716, '2020-08-17 12:29:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:29:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (717, '2020-08-17 12:29:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 12:29:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (718, '2020-08-17 12:29:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 12:29:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (719, '2020-08-17 12:29:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:31:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (720, '2020-08-17 12:31:49', '220.181.108.159', 'Unknown Platform', '', 'Baiduspider', 0, 8, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (721, '2020-08-17 12:31:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:31:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (722, '2020-08-17 12:31:48', '127.0.0.1', 'Android', 'Chrome', '', 0, 0, '', '2020-08-17 12:32:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (723, '2020-08-17 12:32:24', '111.206.221.108', 'iOS', '', 'Baiduspider', 0, 8, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (724, '2020-08-17 12:32:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:32:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (725, '2020-08-17 12:32:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:32:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (726, '2020-08-17 12:32:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:32:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (727, '2020-08-17 12:32:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:32:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (728, '2020-08-17 12:33:00', '127.0.0.1', 'Android', 'Chrome', '', 0, 1, '', '2020-08-17 12:33:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (729, '2020-08-17 12:33:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:33:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (730, '2020-08-17 12:33:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:33:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (731, '2020-08-17 12:33:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:33:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (732, '2020-08-17 12:33:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:33:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (733, '2020-08-17 12:33:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:33:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (734, '2020-08-17 12:33:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (735, '2020-08-17 12:34:08', '111.206.221.15', 'iOS', '', 'Baiduspider', 0, 8, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (736, '2020-08-17 12:34:43', '111.206.222.143', 'iOS', '', 'Baiduspider', 0, 8, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (737, '2020-08-17 12:35:18', '111.206.198.108', 'iOS', '', 'Baiduspider', 26, 8, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (738, '2020-08-17 12:36:27', '111.206.198.5', 'iOS', '', 'Baiduspider', 0, 8, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (739, '2020-08-17 12:37:35', '116.179.32.112', 'Unknown Platform', '', 'Baiduspider', 0, 11, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (740, '2020-08-17 12:38:11', '111.206.221.115', 'iOS', '', 'Baiduspider', 0, 11, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (741, '2020-08-17 12:39:19', '116.179.32.155', 'Unknown Platform', '', 'Baiduspider', 0, 10, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (742, '2020-08-17 12:39:54', '111.206.221.103', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (743, '2020-08-17 12:40:29', '111.206.221.2', 'iOS', '', 'Baiduspider', 0, 10, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (744, '2020-08-17 12:41:04', '111.206.198.18', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (745, '2020-08-17 12:41:38', '116.179.32.161', 'Unknown Platform', '', 'Baiduspider', 187, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (746, '2020-08-17 12:42:14', '111.206.198.126', 'iOS', '', 'Baiduspider', 144, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (747, '2020-08-17 12:42:48', '111.206.221.96', 'iOS', '', 'Baiduspider', 0, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (748, '2020-08-17 12:43:21', '220.181.108.90', 'Unknown Platform', '', 'Baiduspider', 0, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (749, '2020-08-17 12:43:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:43:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (750, '2020-08-17 12:43:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:43:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (751, '2020-08-17 12:43:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:43:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (752, '2020-08-17 12:43:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:43:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (753, '2020-08-17 12:43:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:43:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (754, '2020-08-17 12:44:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:44:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (755, '2020-08-17 12:44:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:44:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (756, '2020-08-17 12:44:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 12:44:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (757, '2020-08-17 12:44:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 12:44:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (758, '2020-08-17 12:44:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:44:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (759, '2020-08-17 12:44:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:44:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (760, '2020-08-17 12:44:39', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:44:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (761, '2020-08-17 12:44:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:44:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (762, '2020-08-17 12:44:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 12:44:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (763, '2020-08-17 12:44:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:50:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (764, '2020-08-17 12:45:07', '111.206.221.68', 'iOS', '', 'Baiduspider', 146, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (765, '2020-08-17 12:46:16', '111.206.221.106', 'iOS', '', 'Baiduspider', 22, 9, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (766, '2020-08-17 12:46:16', '111.206.221.103', 'iOS', '', 'Baiduspider', 143, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (767, '2020-08-17 12:47:08', '111.206.221.87', 'iOS', '', 'Baiduspider', 0, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (768, '2020-08-17 12:47:24', '111.206.222.221', 'iOS', '', 'Baiduspider', 0, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (769, '2020-08-17 12:48:35', '111.206.221.26', 'iOS', '', 'Baiduspider', 145, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (770, '2020-08-17 12:49:08', '220.181.108.77', 'Unknown Platform', '', 'Baiduspider', 186, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (771, '2020-08-17 12:49:42', '116.179.32.20', 'Unknown Platform', '', 'Baiduspider', 184, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (772, '2020-08-17 12:50:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:50:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (773, '2020-08-17 12:50:52', '220.181.108.89', 'Unknown Platform', '', 'Baiduspider', 185, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (774, '2020-08-17 12:50:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:52:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (775, '2020-08-17 12:51:26', '116.179.32.240', 'Unknown Platform', '', 'Baiduspider', 38, 9, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (776, '2020-08-17 12:52:00', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 12:52:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (777, '2020-08-17 12:52:02', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 12:52:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (778, '2020-08-17 12:52:02', '111.206.221.35', 'iOS', '', 'Baiduspider', 24, 9, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (779, '2020-08-17 12:52:03', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 12:52:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (780, '2020-08-17 12:52:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:52:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (781, '2020-08-17 12:52:24', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:52:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (782, '2020-08-17 12:52:29', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:52:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (783, '2020-08-17 12:52:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:52:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (784, '2020-08-17 12:52:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:52:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (785, '2020-08-17 12:52:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:52:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (786, '2020-08-17 12:52:35', '116.179.32.98', 'Unknown Platform', '', 'Baiduspider', 39, 9, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (787, '2020-08-17 12:52:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:52:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (788, '2020-08-17 12:52:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:52:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (789, '2020-08-17 12:52:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:52:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (790, '2020-08-17 12:52:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:52:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (791, '2020-08-17 12:52:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:53:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (792, '2020-08-17 12:52:48', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:52:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (793, '2020-08-17 12:52:51', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:52:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (794, '2020-08-17 12:52:52', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 12:52:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (795, '2020-08-17 12:52:53', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 12:52:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (796, '2020-08-17 12:52:54', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-17 12:52:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (797, '2020-08-17 12:52:55', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 12:52:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (798, '2020-08-17 12:52:57', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 12:52:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (799, '2020-08-17 12:52:58', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 12:53:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (800, '2020-08-17 12:53:15', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:53:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (801, '2020-08-17 12:53:16', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:53:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (802, '2020-08-17 12:53:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:53:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (803, '2020-08-17 12:53:27', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:53:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (804, '2020-08-17 12:53:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:53:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (805, '2020-08-17 12:53:45', '116.179.32.42', 'Unknown Platform', '', 'Baiduspider', 170, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (806, '2020-08-17 12:53:46', '111.206.221.86', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (807, '2020-08-17 12:53:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:53:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (808, '2020-08-17 12:53:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:53:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (809, '2020-08-17 12:53:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:53:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (810, '2020-08-17 12:53:50', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:53:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (811, '2020-08-17 12:53:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:53:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (812, '2020-08-17 12:53:51', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 12:53:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (813, '2020-08-17 12:53:52', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 12:53:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (814, '2020-08-17 12:53:53', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-17 12:54:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (815, '2020-08-17 12:53:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:53:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (816, '2020-08-17 12:53:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 23, 8, '', '2020-08-17 12:54:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (817, '2020-08-17 12:54:16', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 12:54:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (818, '2020-08-17 12:54:17', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-17 12:54:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (819, '2020-08-17 12:54:18', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 12:54:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (820, '2020-08-17 12:54:20', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-17 12:54:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (821, '2020-08-17 12:54:21', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 12:54:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (822, '2020-08-17 12:54:21', '111.206.221.27', 'iOS', '', 'Baiduspider', 169, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (823, '2020-08-17 12:54:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 12:54:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (824, '2020-08-17 12:54:24', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 12:54:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (825, '2020-08-17 12:54:26', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-17 12:54:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (826, '2020-08-17 12:54:27', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 12:54:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (827, '2020-08-17 12:54:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:54:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (828, '2020-08-17 12:54:34', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-17 12:54:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (829, '2020-08-17 12:54:38', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 12:54:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (830, '2020-08-17 12:54:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:54:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (831, '2020-08-17 12:54:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:54:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (832, '2020-08-17 12:54:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:54:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (833, '2020-08-17 12:54:50', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-17 12:54:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (834, '2020-08-17 12:54:51', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 13:09:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (835, '2020-08-17 12:54:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:57:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (836, '2020-08-17 12:54:56', '111.206.221.23', 'iOS', '', 'Baiduspider', 119, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (837, '2020-08-17 12:56:04', '111.206.222.28', 'iOS', '', 'Baiduspider', 173, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (838, '2020-08-17 12:57:14', '111.206.221.100', 'iOS', '', 'Baiduspider', 78, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (839, '2020-08-17 12:57:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:57:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (840, '2020-08-17 12:57:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:57:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (841, '2020-08-17 12:57:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:57:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (842, '2020-08-17 12:57:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 12:57:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (843, '2020-08-17 12:57:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:57:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (844, '2020-08-17 12:58:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:58:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (845, '2020-08-17 12:58:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:58:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (846, '2020-08-17 12:58:23', '111.206.222.212', 'iOS', '', 'Baiduspider', 94, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (847, '2020-08-17 12:58:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:58:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (848, '2020-08-17 12:58:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:59:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (849, '2020-08-17 12:58:58', '111.206.221.30', 'iOS', '', 'Baiduspider', 93, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (850, '2020-08-17 12:59:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:59:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (851, '2020-08-17 12:59:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:59:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (852, '2020-08-17 12:59:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:59:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (853, '2020-08-17 12:59:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:59:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (854, '2020-08-17 12:59:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 12:59:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (855, '2020-08-17 12:59:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 12:59:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (856, '2020-08-17 12:59:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 12:59:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (857, '2020-08-17 12:59:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 12:59:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (858, '2020-08-17 12:59:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 12:59:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (859, '2020-08-17 12:59:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 12:59:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (860, '2020-08-17 13:00:06', '111.206.221.85', 'iOS', '', 'Baiduspider', 18, 3, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (861, '2020-08-17 12:59:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:17:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (862, '2020-08-17 13:01:16', '111.206.221.11', 'iOS', '', 'Baiduspider', 175, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (863, '2020-08-17 13:01:51', '111.206.221.114', 'iOS', '', 'Baiduspider', 125, 3, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (864, '2020-08-17 13:02:26', '111.206.221.107', 'iOS', '', 'Baiduspider', 178, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (865, '2020-08-17 13:02:45', '36.99.136.132', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-17 13:02:59', '', '');
INSERT INTO `{pre}statistics` VALUES (866, '2020-08-17 13:03:03', '111.206.221.20', 'iOS', '', 'Baiduspider', 176, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (867, '2020-08-17 13:03:50', '111.7.100.19', 'Windows 10', 'Chrome', '', 188, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (868, '2020-08-17 13:03:57', '111.7.100.18', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-17 13:04:04', '', '');
INSERT INTO `{pre}statistics` VALUES (869, '2020-08-17 13:04:09', '111.206.198.72', 'iOS', '', 'Baiduspider', 121, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (870, '2020-08-17 13:04:48', '36.99.136.132', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 13:04:52', '', '');
INSERT INTO `{pre}statistics` VALUES (871, '2020-08-17 13:04:54', '36.99.136.132', 'Windows 10', 'Chrome', '', 0, 9, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (872, '2020-08-17 13:04:54', '111.7.100.17', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 13:04:56', '', '');
INSERT INTO `{pre}statistics` VALUES (873, '2020-08-17 13:04:59', '111.7.100.17', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 13:05:06', '', '');
INSERT INTO `{pre}statistics` VALUES (874, '2020-08-17 13:04:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (875, '2020-08-17 13:06:27', '111.206.222.162', 'iOS', '', 'Baiduspider', 48, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (876, '2020-08-17 13:07:01', '111.206.221.50', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (877, '2020-08-17 13:09:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (878, '2020-08-17 13:09:22', '111.206.198.123', 'iOS', '', 'Baiduspider', 56, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (879, '2020-08-17 13:09:29', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-17 13:10:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (880, '2020-08-17 13:09:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (881, '2020-08-17 13:09:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (882, '2020-08-17 13:09:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (883, '2020-08-17 13:09:39', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (884, '2020-08-17 13:09:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (885, '2020-08-17 13:09:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (886, '2020-08-17 13:09:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (887, '2020-08-17 13:09:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (888, '2020-08-17 13:09:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:09:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (889, '2020-08-17 13:09:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:10:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (890, '2020-08-17 13:10:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:10:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (891, '2020-08-17 13:10:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:10:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (892, '2020-08-17 13:10:47', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-17 13:10:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (893, '2020-08-17 13:10:48', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 13:10:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (894, '2020-08-17 13:10:49', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-17 13:10:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (895, '2020-08-17 13:10:50', '127.0.0.1', 'Windows 10', 'Chrome', '', 27, 8, '', '2020-08-17 23:48:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (896, '2020-08-17 13:10:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:10:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (897, '2020-08-17 13:10:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:10:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (898, '2020-08-17 13:10:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 13:10:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (899, '2020-08-17 13:10:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:11:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (900, '2020-08-17 13:11:04', '111.206.222.22', 'iOS', '', 'Baiduspider', 54, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (901, '2020-08-17 13:11:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:11:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (902, '2020-08-17 13:11:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:11:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (903, '2020-08-17 13:11:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:11:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (904, '2020-08-17 13:11:39', '111.206.221.66', 'iOS', '', 'Baiduspider', 57, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (905, '2020-08-17 13:12:14', '111.206.221.43', 'iOS', '', 'Baiduspider', 43, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (906, '2020-08-17 13:12:50', '111.206.198.38', 'iOS', '', 'Baiduspider', 45, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (907, '2020-08-17 13:12:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:12:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (908, '2020-08-17 13:12:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:12:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (909, '2020-08-17 13:12:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:13:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (910, '2020-08-17 13:13:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:13:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (911, '2020-08-17 13:13:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:13:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (912, '2020-08-17 13:13:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:13:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (913, '2020-08-17 13:13:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:13:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (914, '2020-08-17 13:13:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:13:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (915, '2020-08-17 13:13:23', '111.206.221.2', 'iOS', '', 'Baiduspider', 44, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (916, '2020-08-17 13:13:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:15:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (917, '2020-08-17 13:13:57', '111.206.221.43', 'iOS', '', 'Baiduspider', 40, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (918, '2020-08-17 13:14:33', '111.206.221.23', 'iOS', '', 'Baiduspider', 21, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (919, '2020-08-17 13:15:07', '111.206.221.109', 'iOS', '', 'Baiduspider', 41, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (920, '2020-08-17 13:15:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 13:15:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (921, '2020-08-17 13:15:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:15:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (922, '2020-08-17 13:15:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:15:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (923, '2020-08-17 13:15:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:15:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (924, '2020-08-17 13:15:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:15:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (925, '2020-08-17 13:15:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 13:15:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (926, '2020-08-17 13:15:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:15:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (927, '2020-08-17 13:15:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:16:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (928, '2020-08-17 13:15:41', '111.206.221.37', 'iOS', '', 'Baiduspider', 51, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (929, '2020-08-17 13:16:16', '111.206.221.33', 'iOS', '', 'Baiduspider', 53, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (930, '2020-08-17 13:16:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:16:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (931, '2020-08-17 13:16:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:16:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (932, '2020-08-17 13:16:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:16:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (933, '2020-08-17 13:16:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:16:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (934, '2020-08-17 13:16:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:16:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (935, '2020-08-17 13:16:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:17:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (936, '2020-08-17 13:17:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:17:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (937, '2020-08-17 13:17:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:17:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (938, '2020-08-17 13:17:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:17:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (939, '2020-08-17 13:17:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:17:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (940, '2020-08-17 13:17:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:17:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (941, '2020-08-17 13:17:59', '111.206.198.233', 'iOS', '', 'Baiduspider', 49, 4, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (942, '2020-08-17 13:17:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:17:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (943, '2020-08-17 13:17:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:17:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (944, '2020-08-17 13:17:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:17:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (945, '2020-08-17 13:17:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:17:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (946, '2020-08-17 13:17:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:18:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (947, '2020-08-17 13:18:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:18:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (948, '2020-08-17 13:18:35', '111.206.198.6', 'iOS', '', 'Baiduspider', 155, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (949, '2020-08-17 13:18:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:18:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (950, '2020-08-17 13:18:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:18:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (951, '2020-08-17 13:18:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:18:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (952, '2020-08-17 13:18:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:18:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (953, '2020-08-17 13:18:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:18:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (954, '2020-08-17 13:18:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:18:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (955, '2020-08-17 13:18:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:18:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (956, '2020-08-17 13:18:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:18:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (957, '2020-08-17 13:18:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:18:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (958, '2020-08-17 13:18:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:18:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (959, '2020-08-17 13:18:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:18:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (960, '2020-08-17 13:18:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 13:18:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (961, '2020-08-17 13:18:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 13:18:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (962, '2020-08-17 13:18:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 13:18:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (963, '2020-08-17 13:18:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:18:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (964, '2020-08-17 13:18:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:18:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (965, '2020-08-17 13:18:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 13:18:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (966, '2020-08-17 13:18:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 13:18:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (967, '2020-08-17 13:18:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 13:18:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (968, '2020-08-17 13:18:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:19:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (969, '2020-08-17 13:19:09', '111.206.221.79', 'iOS', '', 'Baiduspider', 156, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (970, '2020-08-17 13:19:49', '111.206.221.87', 'iOS', '', 'Baiduspider', 154, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (971, '2020-08-17 13:19:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:19:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (972, '2020-08-17 13:19:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:20:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (973, '2020-08-17 13:20:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:20:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (974, '2020-08-17 13:20:18', '111.206.221.102', 'iOS', '', 'Baiduspider', 182, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (975, '2020-08-17 13:20:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:20:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (976, '2020-08-17 13:20:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (977, '2020-08-17 13:20:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:21:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (978, '2020-08-17 13:20:52', '116.179.32.206', 'Unknown Platform', '', 'Baiduspider', 181, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (979, '2020-08-17 13:21:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:21:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (980, '2020-08-17 13:21:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:21:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (981, '2020-08-17 13:21:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:21:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (982, '2020-08-17 13:21:28', '111.206.222.212', 'iOS', '', 'Baiduspider', 75, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (983, '2020-08-17 13:21:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:22:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (984, '2020-08-17 13:22:02', '111.206.221.25', 'iOS', '', 'Baiduspider', 77, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (985, '2020-08-17 13:22:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:22:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (986, '2020-08-17 13:22:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:22:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (987, '2020-08-17 13:22:39', '127.0.0.1', 'Windows 7', 'Internet Explorer', '', 0, 0, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (988, '2020-08-17 13:22:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:23:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (989, '2020-08-17 13:23:11', '111.206.221.106', 'iOS', '', 'Baiduspider', 76, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (990, '2020-08-17 13:23:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:23:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (991, '2020-08-17 13:23:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:24:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (992, '2020-08-17 13:24:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:24:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (993, '2020-08-17 13:24:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:24:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (994, '2020-08-17 13:24:55', '111.206.221.25', 'iOS', '', 'Baiduspider', 159, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (995, '2020-08-17 13:24:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:24:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (996, '2020-08-17 13:24:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:27:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (997, '2020-08-17 13:25:29', '111.206.221.86', 'iOS', '', 'Baiduspider', 162, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (998, '2020-08-17 13:26:05', '111.206.221.79', 'iOS', '', 'Baiduspider', 160, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (999, '2020-08-17 13:27:12', '220.181.108.173', 'Unknown Platform', '', 'Baiduspider', 179, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1000, '2020-08-17 13:27:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:27:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1001, '2020-08-17 13:27:48', '111.206.222.21', 'iOS', '', 'Baiduspider', 153, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1002, '2020-08-17 13:27:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:28:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1003, '2020-08-17 13:28:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:28:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1004, '2020-08-17 13:28:22', '111.206.198.126', 'iOS', '', 'Baiduspider', 0, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1005, '2020-08-17 13:28:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:28:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1006, '2020-08-17 13:28:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:28:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1007, '2020-08-17 13:28:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:28:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1008, '2020-08-17 13:28:57', '111.206.221.48', 'iOS', '', 'Baiduspider', 59, 2, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1009, '2020-08-17 13:28:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:28:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1010, '2020-08-17 13:28:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:29:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1011, '2020-08-17 13:29:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:29:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1012, '2020-08-17 13:29:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:29:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1013, '2020-08-17 13:29:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:30:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1014, '2020-08-17 13:30:06', '111.206.222.179', 'iOS', '', 'Baiduspider', 0, 3, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1015, '2020-08-17 13:30:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:30:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1016, '2020-08-17 13:30:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1017, '2020-08-17 13:30:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:30:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1018, '2020-08-17 13:30:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:31:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1019, '2020-08-17 13:30:40', '220.181.108.169', 'Unknown Platform', '', 'Baiduspider', 0, 3, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1020, '2020-08-17 13:31:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:31:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1021, '2020-08-17 13:31:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:32:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1022, '2020-08-17 13:32:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:32:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1023, '2020-08-17 13:32:24', '116.179.32.41', 'Unknown Platform', '', 'Baiduspider', 150, 12, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1024, '2020-08-17 13:32:28', '111.7.100.21', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 13:32:42', '', '');
INSERT INTO `{pre}statistics` VALUES (1025, '2020-08-17 13:32:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:35:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1026, '2020-08-17 13:32:58', '220.181.108.161', 'Unknown Platform', '', 'Baiduspider', 151, 12, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1027, '2020-08-17 13:33:33', '116.179.32.37', 'Unknown Platform', '', 'Baiduspider', 149, 12, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1028, '2020-08-17 13:34:43', '111.206.198.231', 'iOS', '', 'Baiduspider', 211, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1029, '2020-08-17 13:34:51', '111.7.100.25', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-17 13:34:54', '', '');
INSERT INTO `{pre}statistics` VALUES (1030, '2020-08-17 13:34:59', '111.7.100.27', 'Windows 10', 'Chrome', '', 0, 10, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1031, '2020-08-17 13:35:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:36:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1032, '2020-08-17 13:35:18', '111.206.221.19', 'iOS', '', 'Baiduspider', 209, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1033, '2020-08-17 13:35:58', '111.206.222.20', 'iOS', '', 'Baiduspider', 212, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1034, '2020-08-17 13:36:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1035, '2020-08-17 13:37:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:37:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1036, '2020-08-17 13:37:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1037, '2020-08-17 13:37:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1038, '2020-08-17 13:37:36', '111.206.221.109', 'iOS', '', 'Baiduspider', 0, 5, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1039, '2020-08-17 13:37:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1040, '2020-08-17 13:37:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1041, '2020-08-17 13:37:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1042, '2020-08-17 13:37:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1043, '2020-08-17 13:37:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1044, '2020-08-17 13:37:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1045, '2020-08-17 13:37:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1046, '2020-08-17 13:37:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1047, '2020-08-17 13:37:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1048, '2020-08-17 13:37:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:37:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1049, '2020-08-17 13:37:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1050, '2020-08-17 13:37:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:37:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1051, '2020-08-17 13:37:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:37:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1052, '2020-08-17 13:37:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:37:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1053, '2020-08-17 13:37:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:38:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1054, '2020-08-17 13:38:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 13:38:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1055, '2020-08-17 13:38:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:38:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1056, '2020-08-17 13:38:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 258, 5, '', '2020-08-17 13:38:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1057, '2020-08-17 13:38:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:38:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1058, '2020-08-17 13:38:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:38:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1059, '2020-08-17 13:38:46', '111.206.221.73', 'iOS', '', 'Baiduspider', 136, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1060, '2020-08-17 13:38:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:38:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1061, '2020-08-17 13:38:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:39:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1062, '2020-08-17 13:39:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:39:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1063, '2020-08-17 13:39:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:39:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1064, '2020-08-17 13:39:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:39:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1065, '2020-08-17 13:39:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:39:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1066, '2020-08-17 13:39:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:39:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1067, '2020-08-17 13:39:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:40:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1068, '2020-08-17 13:39:54', '111.206.221.51', 'iOS', '', 'Baiduspider', 134, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1069, '2020-08-17 13:40:29', '111.206.221.88', 'iOS', '', 'Baiduspider', 129, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1070, '2020-08-17 13:41:04', '111.206.221.107', 'iOS', '', 'Baiduspider', 116, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1071, '2020-08-17 13:40:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:41:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1072, '2020-08-17 13:41:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:41:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1073, '2020-08-17 13:41:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:41:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1074, '2020-08-17 13:41:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:41:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1075, '2020-08-17 13:41:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:41:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1076, '2020-08-17 13:41:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 13:41:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1077, '2020-08-17 13:41:38', '111.206.221.114', 'iOS', '', 'Baiduspider', 117, 7, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1078, '2020-08-17 13:41:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-17 13:44:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1079, '2020-08-17 13:44:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-17 13:44:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1080, '2020-08-17 13:44:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:44:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1081, '2020-08-17 13:44:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:44:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1082, '2020-08-17 13:44:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:44:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1083, '2020-08-17 13:44:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:44:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1084, '2020-08-17 13:44:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:45:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1085, '2020-08-17 13:45:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:45:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1086, '2020-08-17 13:45:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 13:45:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1087, '2020-08-17 13:45:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:45:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1088, '2020-08-17 13:45:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:45:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1089, '2020-08-17 13:45:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:46:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1090, '2020-08-17 13:46:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:46:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1091, '2020-08-17 13:46:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:46:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1092, '2020-08-17 13:46:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:46:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1093, '2020-08-17 13:46:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:46:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1094, '2020-08-17 13:46:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:46:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1095, '2020-08-17 13:46:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:46:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1096, '2020-08-17 13:46:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 13:46:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1097, '2020-08-17 13:46:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:46:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1098, '2020-08-17 13:46:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:46:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1099, '2020-08-17 13:46:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:46:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1100, '2020-08-17 13:46:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:46:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1101, '2020-08-17 13:46:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:46:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1102, '2020-08-17 13:46:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:46:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1103, '2020-08-17 13:46:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:46:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1104, '2020-08-17 13:46:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:47:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1105, '2020-08-17 13:47:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:47:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1106, '2020-08-17 13:47:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 13:47:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1107, '2020-08-17 13:47:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:47:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1108, '2020-08-17 13:47:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 13:47:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1109, '2020-08-17 17:28:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:29:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1110, '2020-08-17 17:29:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:29:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1111, '2020-08-17 17:29:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:29:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1112, '2020-08-17 17:29:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:29:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1113, '2020-08-17 17:29:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:29:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1114, '2020-08-17 17:29:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:29:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1115, '2020-08-17 17:29:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:29:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1116, '2020-08-17 17:29:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:29:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1117, '2020-08-17 17:29:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:29:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1118, '2020-08-17 17:29:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:32:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1119, '2020-08-17 17:32:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:32:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1120, '2020-08-17 17:32:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:32:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1121, '2020-08-17 17:32:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:34:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1122, '2020-08-17 17:34:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:34:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1123, '2020-08-17 17:34:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:34:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1124, '2020-08-17 17:34:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:34:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1125, '2020-08-17 17:34:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:34:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1126, '2020-08-17 17:34:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:34:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1127, '2020-08-17 17:34:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:34:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1128, '2020-08-17 17:34:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:34:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1129, '2020-08-17 17:34:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:34:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1130, '2020-08-17 17:34:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:34:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1131, '2020-08-17 17:34:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:34:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1132, '2020-08-17 17:34:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:34:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1133, '2020-08-17 17:34:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:34:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1134, '2020-08-17 17:34:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 251, 5, '', '2020-08-17 17:34:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1135, '2020-08-17 17:34:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1136, '2020-08-17 17:34:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:34:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1137, '2020-08-17 17:34:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:35:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1138, '2020-08-17 17:35:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:35:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1139, '2020-08-17 17:35:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:35:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1140, '2020-08-17 17:35:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:35:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1141, '2020-08-17 17:35:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:35:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1142, '2020-08-17 17:35:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:35:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1143, '2020-08-17 17:35:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:35:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1144, '2020-08-17 17:35:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:35:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1145, '2020-08-17 17:35:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:35:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1146, '2020-08-17 17:35:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:35:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1147, '2020-08-17 17:35:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:35:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1148, '2020-08-17 17:35:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:35:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1149, '2020-08-17 17:35:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:35:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1150, '2020-08-17 17:35:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:35:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1151, '2020-08-17 17:35:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:35:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1152, '2020-08-17 17:35:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:35:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1153, '2020-08-17 17:35:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:35:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1154, '2020-08-17 17:35:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:35:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1155, '2020-08-17 17:35:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:35:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1156, '2020-08-17 17:35:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 17:35:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1157, '2020-08-17 17:35:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 17:35:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1158, '2020-08-17 17:35:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:35:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1159, '2020-08-17 17:35:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:35:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1160, '2020-08-17 17:35:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:35:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1161, '2020-08-17 17:35:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:35:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1162, '2020-08-17 17:35:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:35:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1163, '2020-08-17 17:35:39', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:35:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1164, '2020-08-17 17:35:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:35:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1165, '2020-08-17 17:35:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 17:35:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1166, '2020-08-17 17:35:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 17:35:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1167, '2020-08-17 17:35:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 17:35:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1168, '2020-08-17 17:35:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 17:35:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1169, '2020-08-17 17:35:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 17:35:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1170, '2020-08-17 17:35:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:36:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1171, '2020-08-17 17:36:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:36:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1172, '2020-08-17 17:36:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:36:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1173, '2020-08-17 17:36:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:36:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1174, '2020-08-17 17:36:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:36:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1175, '2020-08-17 17:36:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:36:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1176, '2020-08-17 17:36:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:36:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1177, '2020-08-17 17:36:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:36:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1178, '2020-08-17 17:36:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:36:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1179, '2020-08-17 17:36:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:36:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1180, '2020-08-17 17:36:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:36:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1181, '2020-08-17 17:36:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:36:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1182, '2020-08-17 17:37:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:37:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1183, '2020-08-17 17:37:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:37:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1184, '2020-08-17 17:37:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:37:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1185, '2020-08-17 17:37:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:37:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1186, '2020-08-17 17:37:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:37:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1187, '2020-08-17 17:37:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:38:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1188, '2020-08-17 17:38:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:38:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1189, '2020-08-17 17:38:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:38:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1190, '2020-08-17 17:38:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:38:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1191, '2020-08-17 17:38:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:38:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1192, '2020-08-17 17:38:59', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:39:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1193, '2020-08-17 17:39:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:39:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1194, '2020-08-17 17:39:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:39:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1195, '2020-08-17 17:39:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:39:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1196, '2020-08-17 17:39:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:39:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1197, '2020-08-17 17:39:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:39:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1198, '2020-08-17 17:39:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 17:39:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1199, '2020-08-17 17:39:59', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:40:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1200, '2020-08-17 17:40:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:40:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1201, '2020-08-17 17:40:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:40:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1202, '2020-08-17 17:40:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:40:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1203, '2020-08-17 17:40:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:40:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1204, '2020-08-17 17:40:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:40:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1205, '2020-08-17 17:40:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:40:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1206, '2020-08-17 17:40:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:40:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1207, '2020-08-17 17:40:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:40:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1208, '2020-08-17 17:40:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:40:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1209, '2020-08-17 17:40:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 17:40:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1210, '2020-08-17 17:40:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 17:40:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1211, '2020-08-17 17:40:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:40:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1212, '2020-08-17 17:40:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:40:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1213, '2020-08-17 17:40:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:40:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1214, '2020-08-17 17:40:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 17:41:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1215, '2020-08-17 17:41:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:41:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1216, '2020-08-17 17:41:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:41:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1217, '2020-08-17 17:41:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:41:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1218, '2020-08-17 17:41:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:41:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1219, '2020-08-17 17:41:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:41:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1220, '2020-08-17 17:41:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:41:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1221, '2020-08-17 17:41:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 17:41:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1222, '2020-08-17 17:41:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:41:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1223, '2020-08-17 17:41:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:41:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1224, '2020-08-17 17:41:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:41:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1225, '2020-08-17 17:41:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:41:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1226, '2020-08-17 17:41:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:41:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1227, '2020-08-17 17:41:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:41:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1228, '2020-08-17 17:41:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 17:41:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1229, '2020-08-17 17:41:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 17:41:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1230, '2020-08-17 17:41:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:41:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1231, '2020-08-17 17:41:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:42:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1232, '2020-08-17 17:42:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:42:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1233, '2020-08-17 17:42:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:42:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1234, '2020-08-17 17:42:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:42:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1235, '2020-08-17 17:42:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:42:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1236, '2020-08-17 17:42:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:42:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1237, '2020-08-17 17:42:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:42:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1238, '2020-08-17 17:42:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:42:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1239, '2020-08-17 17:42:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 17:42:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1240, '2020-08-17 17:42:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 17:42:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1241, '2020-08-17 17:42:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:42:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1242, '2020-08-17 17:42:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:42:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1243, '2020-08-17 17:42:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:42:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1244, '2020-08-17 17:42:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:42:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1245, '2020-08-17 17:42:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:42:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1246, '2020-08-17 17:42:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 17:42:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1247, '2020-08-17 17:42:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 17:42:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1248, '2020-08-17 17:42:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:43:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1249, '2020-08-17 17:43:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:43:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1250, '2020-08-17 17:43:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:44:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1251, '2020-08-17 17:44:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:47:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1252, '2020-08-17 17:47:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:47:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1253, '2020-08-17 17:47:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 17:48:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1254, '2020-08-17 17:48:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 17:48:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1255, '2020-08-17 17:48:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:48:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1256, '2020-08-17 17:48:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:48:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1257, '2020-08-17 17:48:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:48:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1258, '2020-08-17 17:48:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:48:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1259, '2020-08-17 17:48:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:48:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1260, '2020-08-17 17:48:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:48:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1261, '2020-08-17 17:48:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:48:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1262, '2020-08-17 17:48:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:48:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1263, '2020-08-17 17:48:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:48:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1264, '2020-08-17 17:48:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:48:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1265, '2020-08-17 17:48:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:48:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1266, '2020-08-17 17:48:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 17:48:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1267, '2020-08-17 17:48:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:49:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1268, '2020-08-17 17:49:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:49:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1269, '2020-08-17 17:49:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:49:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1270, '2020-08-17 17:49:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:49:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1271, '2020-08-17 17:49:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:49:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1272, '2020-08-17 17:49:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:49:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1273, '2020-08-17 17:49:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 17:49:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1274, '2020-08-17 17:49:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:49:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1275, '2020-08-17 17:49:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:49:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1276, '2020-08-17 17:49:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:51:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1277, '2020-08-17 17:51:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:51:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1278, '2020-08-17 17:51:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:51:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1279, '2020-08-17 17:51:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:51:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1280, '2020-08-17 17:51:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 17:51:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1281, '2020-08-17 17:51:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:51:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1282, '2020-08-17 17:51:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:51:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1283, '2020-08-17 17:51:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:51:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1284, '2020-08-17 17:51:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:51:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1285, '2020-08-17 17:51:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:51:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1286, '2020-08-17 17:51:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:51:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1287, '2020-08-17 17:51:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:52:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1288, '2020-08-17 17:54:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:54:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1289, '2020-08-17 17:54:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:54:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1290, '2020-08-17 17:54:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:54:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1291, '2020-08-17 17:54:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:54:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1292, '2020-08-17 17:54:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:54:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1293, '2020-08-17 17:54:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:54:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1294, '2020-08-17 17:54:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:55:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1295, '2020-08-17 17:55:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:55:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1296, '2020-08-17 17:55:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:56:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1297, '2020-08-17 17:56:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:56:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1298, '2020-08-17 17:56:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:56:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1299, '2020-08-17 17:56:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:56:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1300, '2020-08-17 17:56:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:56:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1301, '2020-08-17 17:56:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 17:56:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1302, '2020-08-17 17:56:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:56:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1303, '2020-08-17 17:56:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 17:56:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1304, '2020-08-17 17:56:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:56:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1305, '2020-08-17 17:56:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:57:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1306, '2020-08-17 17:57:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:57:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1307, '2020-08-17 17:57:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:57:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1308, '2020-08-17 17:57:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 17:57:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1309, '2020-08-17 17:57:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:57:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1310, '2020-08-17 17:57:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 17:57:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1311, '2020-08-17 17:58:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 17:59:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1312, '2020-08-17 17:59:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:03:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1313, '2020-08-17 18:03:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:03:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1314, '2020-08-17 18:03:59', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:04:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1315, '2020-08-17 18:04:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:04:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1316, '2020-08-17 18:04:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:16:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1317, '2020-08-17 18:16:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:26:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1318, '2020-08-17 18:26:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:26:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1319, '2020-08-17 18:26:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:28:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1320, '2020-08-17 18:28:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:30:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1321, '2020-08-17 18:30:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:31:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1322, '2020-08-17 18:31:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:31:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1323, '2020-08-17 18:31:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 18:31:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1324, '2020-08-17 18:31:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:31:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1325, '2020-08-17 18:31:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 18:31:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1326, '2020-08-17 18:31:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 18:31:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1327, '2020-08-17 18:31:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 18:31:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1328, '2020-08-17 18:31:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:32:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1329, '2020-08-17 18:32:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:32:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1330, '2020-08-17 18:32:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 18:32:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1331, '2020-08-17 18:32:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:32:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1332, '2020-08-17 18:32:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:35:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1333, '2020-08-17 18:35:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 18:35:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1334, '2020-08-17 18:35:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 18:36:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1335, '2020-08-17 18:36:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 18:36:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1336, '2020-08-17 18:36:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:36:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1337, '2020-08-17 18:36:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 18:36:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1338, '2020-08-17 18:36:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 18:37:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1339, '2020-08-17 18:37:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 18:37:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1340, '2020-08-17 18:37:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:37:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1341, '2020-08-17 18:37:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 18:37:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1342, '2020-08-17 18:37:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-17 18:37:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1343, '2020-08-17 18:38:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-17 18:41:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1344, '2020-08-17 18:41:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-17 18:41:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1345, '2020-08-17 18:41:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 18:41:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1346, '2020-08-17 18:41:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 18:41:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1347, '2020-08-17 18:41:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-17 18:41:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1348, '2020-08-17 18:41:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:41:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1349, '2020-08-17 18:41:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 18:41:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1350, '2020-08-17 18:41:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 18:41:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1351, '2020-08-17 18:41:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:48:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1352, '2020-08-17 18:48:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:54:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1353, '2020-08-17 18:54:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:54:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1354, '2020-08-17 18:54:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 18:54:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1355, '2020-08-17 18:54:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 18:55:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1356, '2020-08-17 18:55:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 18:55:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1357, '2020-08-17 18:55:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 18:55:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1358, '2020-08-17 18:55:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:55:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1359, '2020-08-17 18:55:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 18:55:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1360, '2020-08-17 18:55:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:55:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1361, '2020-08-17 18:55:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 18:55:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1362, '2020-08-17 18:55:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 18:55:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1363, '2020-08-17 18:55:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 18:55:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1364, '2020-08-17 18:55:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:55:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1365, '2020-08-17 18:58:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:58:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1366, '2020-08-17 18:58:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 18:58:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1367, '2020-08-17 18:58:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 18:58:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1368, '2020-08-17 18:58:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 18:58:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1369, '2020-08-17 18:58:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 18:59:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1370, '2020-08-17 18:59:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 18:59:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1371, '2020-08-17 18:59:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 18:59:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1372, '2020-08-17 18:59:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 18:59:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1373, '2020-08-17 18:59:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 18:59:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1374, '2020-08-17 18:59:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 18:59:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1375, '2020-08-17 18:59:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 18:59:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1376, '2020-08-17 18:59:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 18:59:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1377, '2020-08-17 18:59:59', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1378, '2020-08-17 19:00:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 19:00:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1379, '2020-08-17 19:00:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 19:00:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1380, '2020-08-17 19:00:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 27, 8, '', '2020-08-17 19:00:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1381, '2020-08-17 19:00:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 27, 8, '', '2020-08-17 19:00:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1382, '2020-08-17 19:00:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:00:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1383, '2020-08-17 19:00:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 19:04:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1384, '2020-08-17 19:04:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 19:04:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1385, '2020-08-17 19:04:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:04:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1386, '2020-08-17 19:05:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 19:05:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1387, '2020-08-17 19:05:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:06:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1388, '2020-08-17 19:06:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:06:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1389, '2020-08-17 19:06:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 19:06:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1390, '2020-08-17 19:06:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:06:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1391, '2020-08-17 19:06:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 19:06:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1392, '2020-08-17 19:06:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 19:06:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1393, '2020-08-17 19:06:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 19:06:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1394, '2020-08-17 19:06:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 19:06:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1395, '2020-08-17 19:06:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:06:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1396, '2020-08-17 19:07:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 19:07:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1397, '2020-08-17 19:07:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 185, 2, '', '2020-08-17 19:07:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1398, '2020-08-17 19:07:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:07:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1399, '2020-08-17 19:07:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 184, 2, '', '2020-08-17 19:07:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1400, '2020-08-17 19:07:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:07:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1401, '2020-08-17 19:07:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:07:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1402, '2020-08-17 19:07:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:07:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1403, '2020-08-17 19:07:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:07:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1404, '2020-08-17 19:07:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:07:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1405, '2020-08-17 19:07:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 169, 2, '', '2020-08-17 19:07:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1406, '2020-08-17 19:07:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 169, 2, '', '2020-08-17 19:07:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1407, '2020-08-17 19:07:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:07:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1408, '2020-08-17 19:07:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 19:07:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1409, '2020-08-17 19:07:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 19:07:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1410, '2020-08-17 19:07:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 19:12:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1411, '2020-08-17 19:12:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 19:12:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1412, '2020-08-17 19:12:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:12:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1413, '2020-08-17 19:12:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 184, 2, '', '2020-08-17 19:12:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1414, '2020-08-17 19:12:39', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 19:12:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1415, '2020-08-17 19:12:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:12:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1416, '2020-08-17 19:12:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:12:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1417, '2020-08-17 19:12:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 183, 2, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1418, '2020-08-17 19:18:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:18:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1419, '2020-08-17 19:18:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 19:21:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1420, '2020-08-17 19:21:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 19:25:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1421, '2020-08-17 19:25:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 19:25:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1422, '2020-08-17 19:25:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1423, '2020-08-17 19:28:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 19:28:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1424, '2020-08-17 19:28:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 19:28:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1425, '2020-08-17 19:28:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 19:28:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1426, '2020-08-17 19:29:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 19:29:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1427, '2020-08-17 19:29:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 19:29:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1428, '2020-08-17 21:17:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:17:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1429, '2020-08-17 21:17:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:17:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1430, '2020-08-17 21:17:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:17:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1431, '2020-08-17 21:17:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:17:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1432, '2020-08-17 21:17:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 21:17:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1433, '2020-08-17 21:17:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 21:17:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1434, '2020-08-17 21:17:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:17:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1435, '2020-08-17 21:17:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:18:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1436, '2020-08-17 21:21:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:21:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1437, '2020-08-17 21:21:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:21:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1438, '2020-08-17 21:21:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:21:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1439, '2020-08-17 21:21:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:21:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1440, '2020-08-17 21:21:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 21:21:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1441, '2020-08-17 21:21:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 21:21:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1442, '2020-08-17 21:21:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 21:21:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1443, '2020-08-17 21:21:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 21:21:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1444, '2020-08-17 21:21:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:21:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1445, '2020-08-17 21:21:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:21:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1446, '2020-08-17 21:21:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:21:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1447, '2020-08-17 21:21:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:21:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1448, '2020-08-17 21:21:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:21:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1449, '2020-08-17 21:21:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:21:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1450, '2020-08-17 21:21:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:21:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1451, '2020-08-17 21:21:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:21:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1452, '2020-08-17 21:21:59', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:22:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1453, '2020-08-17 21:22:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:22:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1454, '2020-08-17 21:22:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:22:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1455, '2020-08-17 21:22:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:22:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1456, '2020-08-17 21:22:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 21:22:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1457, '2020-08-17 21:22:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 21:22:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1458, '2020-08-17 21:22:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 21:22:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1459, '2020-08-17 21:22:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 21:22:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1460, '2020-08-17 21:22:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:22:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1461, '2020-08-17 21:22:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:22:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1462, '2020-08-17 21:22:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:22:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1463, '2020-08-17 21:22:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:22:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1464, '2020-08-17 21:22:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:22:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1465, '2020-08-17 21:23:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 21:23:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1466, '2020-08-17 21:23:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 21:23:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1467, '2020-08-17 21:23:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 21:23:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1468, '2020-08-17 21:23:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 186, 2, '', '2020-08-17 21:23:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1469, '2020-08-17 21:23:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:23:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1470, '2020-08-17 21:23:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:23:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1471, '2020-08-17 21:23:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:23:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1472, '2020-08-17 21:23:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:23:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1473, '2020-08-17 21:23:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:23:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1474, '2020-08-17 21:23:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:23:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1475, '2020-08-17 21:23:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:23:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1476, '2020-08-17 21:23:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1477, '2020-08-17 21:23:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 21:23:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1478, '2020-08-17 21:23:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 21:23:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1479, '2020-08-17 21:23:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 21:24:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1480, '2020-08-17 21:24:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:24:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1481, '2020-08-17 21:24:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:24:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1482, '2020-08-17 21:24:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:24:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1483, '2020-08-17 21:24:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:24:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1484, '2020-08-17 21:24:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 21:24:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1485, '2020-08-17 21:24:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 21:24:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1486, '2020-08-17 21:24:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:24:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1487, '2020-08-17 21:24:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:24:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1488, '2020-08-17 21:24:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-17 21:24:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1489, '2020-08-17 21:24:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:24:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1490, '2020-08-17 21:24:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:24:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1491, '2020-08-17 21:24:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:24:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1492, '2020-08-17 21:24:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:24:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1493, '2020-08-17 21:24:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 21:24:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1494, '2020-08-17 21:24:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-17 21:24:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1495, '2020-08-17 21:24:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-17 21:24:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1496, '2020-08-17 21:24:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-17 21:24:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1497, '2020-08-17 21:24:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:24:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1498, '2020-08-17 21:24:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:24:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1499, '2020-08-17 21:24:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:24:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1500, '2020-08-17 21:24:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:24:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1501, '2020-08-17 21:24:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:24:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1502, '2020-08-17 21:24:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 258, 5, '', '2020-08-17 21:24:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1503, '2020-08-17 21:24:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 258, 5, '', '2020-08-17 21:24:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1504, '2020-08-17 21:24:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 258, 5, '', '2020-08-17 21:24:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1505, '2020-08-17 21:24:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 258, 5, '', '2020-08-17 21:24:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1506, '2020-08-17 21:24:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 258, 5, '', '2020-08-17 21:26:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1507, '2020-08-17 21:26:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 258, 5, '', '2020-08-17 21:26:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1508, '2020-08-17 21:26:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:26:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1509, '2020-08-17 21:26:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:26:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1510, '2020-08-17 21:26:59', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:27:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1511, '2020-08-17 21:27:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:27:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1512, '2020-08-17 21:27:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:27:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1513, '2020-08-17 21:27:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:27:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1514, '2020-08-17 21:27:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:27:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1515, '2020-08-17 21:27:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:27:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1516, '2020-08-17 21:27:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:27:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1517, '2020-08-17 21:27:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:27:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1518, '2020-08-17 21:27:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:27:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1519, '2020-08-17 21:27:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:27:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1520, '2020-08-17 21:27:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:27:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1521, '2020-08-17 21:27:59', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:28:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1522, '2020-08-17 21:28:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:28:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1523, '2020-08-17 21:28:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:28:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1524, '2020-08-17 21:28:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 21:28:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1525, '2020-08-17 21:28:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 21:28:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1526, '2020-08-17 21:28:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:28:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1527, '2020-08-17 21:28:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 21:28:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1528, '2020-08-17 21:28:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 21:28:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1529, '2020-08-17 21:28:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 21:28:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1530, '2020-08-17 21:28:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 21:28:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1531, '2020-08-17 21:28:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-17 21:31:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1532, '2020-08-17 23:15:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:18:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1533, '2020-08-17 23:22:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1534, '2020-08-17 23:32:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1535, '2020-08-17 23:32:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1536, '2020-08-17 23:32:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1537, '2020-08-17 23:32:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1538, '2020-08-17 23:32:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1539, '2020-08-17 23:33:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1540, '2020-08-17 23:34:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1541, '2020-08-17 23:34:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1542, '2020-08-17 23:34:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1543, '2020-08-17 23:34:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1544, '2020-08-17 23:34:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1545, '2020-08-17 23:34:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1546, '2020-08-17 23:34:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1547, '2020-08-17 23:34:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1548, '2020-08-17 23:34:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1549, '2020-08-17 23:34:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1550, '2020-08-17 23:34:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:34:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1551, '2020-08-17 23:38:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:38:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1552, '2020-08-17 23:38:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1553, '2020-08-17 23:38:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1554, '2020-08-17 23:48:14', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-17 23:48:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1555, '2020-08-17 23:48:17', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 01:17:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1556, '2020-08-17 23:48:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-17 23:48:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1557, '2020-08-17 23:48:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-17 23:48:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1558, '2020-08-17 23:48:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-17 23:48:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1559, '2020-08-17 23:48:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-17 23:48:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1560, '2020-08-17 23:48:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-17 23:49:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1561, '2020-08-17 23:50:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:11:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1562, '2020-08-17 23:50:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1563, '2020-08-17 23:50:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1564, '2020-08-17 23:50:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1565, '2020-08-17 23:51:36', '116.179.32.138', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '2020-08-18 00:03:06', '', '');
INSERT INTO `{pre}statistics` VALUES (1566, '2020-08-17 23:51:36', '111.206.198.39', 'iOS', '', 'Baiduspider', 0, 0, '', '2020-08-18 00:03:06', '', '');
INSERT INTO `{pre}statistics` VALUES (1567, '2020-08-17 23:52:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1568, '2020-08-17 23:52:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1569, '2020-08-17 23:59:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1570, '2020-08-18 00:00:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1571, '2020-08-18 00:02:16', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1572, '2020-08-18 00:02:17', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1573, '2020-08-18 00:02:50', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:06', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1574, '2020-08-18 00:03:20', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:03:22', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1575, '2020-08-18 00:03:22', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 00:08:15', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1576, '2020-08-18 00:08:15', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 00:08:16', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1577, '2020-08-18 00:08:16', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 00:08:17', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1578, '2020-08-18 00:08:17', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 00:08:17', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1579, '2020-08-18 00:08:17', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-18 00:08:18', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1580, '2020-08-18 00:11:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:11:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1581, '2020-08-18 00:11:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 00:11:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1582, '2020-08-18 00:39:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 00:40:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1583, '2020-08-18 00:40:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 00:40:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1584, '2020-08-18 00:40:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 00:40:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1585, '2020-08-18 00:40:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 00:40:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1586, '2020-08-18 00:58:16', '116.179.32.32', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1587, '2020-08-18 00:58:16', '111.206.198.52', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1588, '2020-08-18 00:58:16', '111.206.198.52', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1589, '2020-08-18 01:17:27', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 01:17:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1590, '2020-08-18 01:17:54', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:17:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1591, '2020-08-18 01:17:57', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 01:17:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1592, '2020-08-18 01:17:59', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-18 01:18:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1593, '2020-08-18 01:18:02', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:18:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1594, '2020-08-18 01:18:07', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-18 01:18:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1595, '2020-08-18 01:18:08', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-18 01:18:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1596, '2020-08-18 01:18:08', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:18:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1597, '2020-08-18 01:18:09', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-18 01:18:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1598, '2020-08-18 01:18:11', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-18 01:18:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1599, '2020-08-18 01:18:28', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-18 01:18:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1600, '2020-08-18 01:18:31', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-18 01:18:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1601, '2020-08-18 01:18:36', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-18 01:18:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1602, '2020-08-18 01:18:51', '127.0.0.1', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-18 01:21:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1603, '2020-08-18 01:21:49', '127.0.0.1', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-18 01:23:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1604, '2020-08-18 01:23:25', '127.0.0.1', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-18 01:24:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1605, '2020-08-18 01:24:10', '127.0.0.1', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-18 01:24:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1606, '2020-08-18 01:24:21', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-18 01:24:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1607, '2020-08-18 01:24:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-18 01:24:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1608, '2020-08-18 01:24:26', '127.0.0.1', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-18 01:24:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1609, '2020-08-18 01:24:28', '127.0.0.1', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-18 01:24:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1610, '2020-08-18 01:24:56', '127.0.0.1', 'Windows 10', 'Chrome', '', 188, 2, '', '2020-08-18 01:24:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1611, '2020-08-18 01:24:58', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:31:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1612, '2020-08-18 01:31:34', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:32:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1613, '2020-08-18 01:32:59', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:35:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1614, '2020-08-18 01:35:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:36:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1615, '2020-08-18 01:36:05', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:36:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1616, '2020-08-18 01:36:11', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:36:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1617, '2020-08-18 01:36:29', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:36:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1618, '2020-08-18 01:36:37', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:41:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1619, '2020-08-18 01:41:33', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:41:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1620, '2020-08-18 01:42:00', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:42:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1621, '2020-08-18 01:42:30', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:43:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1622, '2020-08-18 01:43:45', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:44:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1623, '2020-08-18 01:44:00', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:45:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1624, '2020-08-18 01:45:27', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:45:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1625, '2020-08-18 01:45:41', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:45:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1626, '2020-08-18 01:45:42', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:46:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1627, '2020-08-18 01:46:14', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:47:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1628, '2020-08-18 01:47:45', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:48:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1629, '2020-08-18 01:48:06', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:49:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1630, '2020-08-18 01:49:02', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:50:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1631, '2020-08-18 01:50:01', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:50:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1632, '2020-08-18 01:50:44', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:50:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1633, '2020-08-18 01:50:46', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:52:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1634, '2020-08-18 01:52:38', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:52:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1635, '2020-08-18 01:52:42', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:53:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1636, '2020-08-18 01:53:25', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:53:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1637, '2020-08-18 01:53:34', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:58:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1638, '2020-08-18 01:58:01', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:58:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1639, '2020-08-18 01:58:15', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 01:59:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1640, '2020-08-18 01:59:39', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:00:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1641, '2020-08-18 02:00:49', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:00:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1642, '2020-08-18 02:00:50', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:01:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1643, '2020-08-18 02:01:48', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:02:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1644, '2020-08-18 02:02:54', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:05:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1645, '2020-08-18 02:04:56', '220.181.108.118', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1646, '2020-08-18 02:04:56', '111.206.198.97', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1647, '2020-08-18 02:04:56', '111.206.198.97', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1648, '2020-08-18 02:05:37', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:06:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1649, '2020-08-18 02:06:35', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:07:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1650, '2020-08-18 02:07:30', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:07:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1651, '2020-08-18 02:07:36', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:07:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1652, '2020-08-18 02:07:38', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-18 02:07:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1653, '2020-08-18 02:07:39', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 02:27:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1654, '2020-08-18 02:27:11', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 02:27:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1655, '2020-08-18 02:27:20', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:27:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1656, '2020-08-18 02:27:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:27:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1657, '2020-08-18 02:30:50', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:31:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1658, '2020-08-18 02:31:06', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:31:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1659, '2020-08-18 02:41:15', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:42:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1660, '2020-08-18 02:45:01', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:46:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1661, '2020-08-18 02:52:19', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 02:52:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1662, '2020-08-18 02:52:56', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 02:53:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1663, '2020-08-18 02:53:07', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 02:53:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1664, '2020-08-18 02:53:50', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 02:53:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1665, '2020-08-18 02:53:51', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-18 02:53:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1666, '2020-08-18 03:05:37', '171.13.14.8', 'Windows 10', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '河南', '');
INSERT INTO `{pre}statistics` VALUES (1667, '2020-08-18 03:11:36', '116.179.32.150', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1668, '2020-08-18 03:11:36', '111.206.198.34', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1669, '2020-08-18 03:11:36', '111.206.198.34', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1670, '2020-08-18 03:44:56', '116.179.32.115', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1671, '2020-08-18 03:44:56', '111.206.198.12', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1672, '2020-08-18 03:44:56', '111.206.198.12', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1673, '2020-08-18 04:51:36', '220.181.108.167', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1674, '2020-08-18 04:51:36', '111.206.221.68', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1675, '2020-08-18 04:51:36', '111.206.221.68', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1676, '2020-08-18 05:58:16', '116.179.32.134', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1677, '2020-08-18 05:58:16', '111.206.221.67', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1678, '2020-08-18 05:58:16', '111.206.221.67', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1679, '2020-08-18 07:04:56', '116.179.32.67', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1680, '2020-08-18 07:04:56', '111.206.198.36', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1681, '2020-08-18 07:04:56', '111.206.198.36', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1682, '2020-08-18 08:11:36', '220.181.108.181', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1683, '2020-08-18 08:11:36', '111.206.221.30', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1684, '2020-08-18 08:11:36', '111.206.221.30', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1685, '2020-08-18 08:44:56', '116.179.32.25', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1686, '2020-08-18 08:44:56', '111.206.221.96', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1687, '2020-08-18 08:44:56', '111.206.221.96', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1688, '2020-08-18 08:48:57', '34.221.235.25', 'Windows 8.1', 'Firefox', '', 0, 0, '', '0000-00-00 00:00:00', '美国', '');
INSERT INTO `{pre}statistics` VALUES (1689, '2020-08-18 09:02:28', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:02:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1690, '2020-08-18 09:20:29', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 09:20:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1691, '2020-08-18 09:20:33', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 09:21:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1692, '2020-08-18 09:21:01', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 09:21:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1693, '2020-08-18 09:21:16', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 09:22:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1694, '2020-08-18 09:22:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:22:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1695, '2020-08-18 09:22:24', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:27:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1696, '2020-08-18 09:27:45', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:28:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1697, '2020-08-18 09:28:08', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:28:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1698, '2020-08-18 09:28:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:29:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1699, '2020-08-18 09:29:31', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:30:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1700, '2020-08-18 09:30:34', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:33:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1701, '2020-08-18 09:33:49', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:38:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1702, '2020-08-18 09:38:01', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:38:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1703, '2020-08-18 09:38:43', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 09:39:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1704, '2020-08-18 09:39:27', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:01:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1705, '2020-08-18 09:51:36', '116.179.32.84', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1706, '2020-08-18 09:51:37', '111.206.221.69', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1707, '2020-08-18 09:51:37', '111.206.221.69', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1708, '2020-08-18 10:40:26', '111.7.100.16', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 10:40:41', '河南', '');
INSERT INTO `{pre}statistics` VALUES (1709, '2020-08-18 10:58:16', '220.181.108.87', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1710, '2020-08-18 10:58:16', '111.206.198.53', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1711, '2020-08-18 10:58:16', '111.206.198.53', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1712, '2020-08-18 12:04:56', '220.181.108.109', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1713, '2020-08-18 12:04:56', '111.206.221.91', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1714, '2020-08-18 12:04:56', '111.206.221.91', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1715, '2020-08-18 12:08:26', '36.99.136.132', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-18 12:08:30', '河南', '');
INSERT INTO `{pre}statistics` VALUES (1716, '2020-08-18 12:08:32', '36.99.136.131', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-18 12:08:41', '河南', '');
INSERT INTO `{pre}statistics` VALUES (1717, '2020-08-18 12:09:20', '111.7.100.18', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 12:09:34', '河南', '');
INSERT INTO `{pre}statistics` VALUES (1718, '2020-08-18 12:58:24', '111.7.100.18', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-18 12:58:27', '河南', '');
INSERT INTO `{pre}statistics` VALUES (1719, '2020-08-18 12:58:28', '111.7.100.18', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-18 12:58:37', '河南', '');
INSERT INTO `{pre}statistics` VALUES (1720, '2020-08-18 13:11:36', '220.181.108.120', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1721, '2020-08-18 13:11:36', '111.206.221.15', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1722, '2020-08-18 13:11:36', '111.206.221.15', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1723, '2020-08-18 13:33:21', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1724, '2020-08-18 13:33:27', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1725, '2020-08-18 13:40:26', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 13:40:28', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1726, '2020-08-18 13:40:28', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 13:40:29', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1727, '2020-08-18 13:40:29', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 13:40:29', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1728, '2020-08-18 13:40:30', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 13:40:30', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1729, '2020-08-18 13:40:30', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 13:40:31', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1730, '2020-08-18 13:40:31', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-18 13:40:32', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1731, '2020-08-18 13:40:33', '223.72.47.122', 'Windows 7', 'Chrome', '', 26, 8, '', '2020-08-18 13:40:36', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1732, '2020-08-18 13:40:36', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 13:40:37', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1733, '2020-08-18 13:40:38', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 13:40:41', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1734, '2020-08-18 13:44:56', '220.181.108.82', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1735, '2020-08-18 13:44:56', '111.206.198.120', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1736, '2020-08-18 13:44:56', '111.206.198.120', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1737, '2020-08-18 14:31:19', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 14:31:20', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1738, '2020-08-18 14:31:21', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 14:31:21', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1739, '2020-08-18 14:31:22', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 14:31:22', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1740, '2020-08-18 14:31:22', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 14:31:22', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1741, '2020-08-18 14:31:23', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-18 14:31:23', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1742, '2020-08-18 14:31:23', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-18 14:31:24', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1743, '2020-08-18 14:51:36', '116.179.32.28', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1744, '2020-08-18 14:51:36', '111.206.221.83', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1745, '2020-08-18 14:51:36', '111.206.221.83', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1746, '2020-08-18 15:00:50', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 19:01:21', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1747, '2020-08-18 15:01:40', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:07:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1748, '2020-08-18 15:07:05', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:08:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1749, '2020-08-18 15:08:01', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:08:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1750, '2020-08-18 15:08:12', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:08:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1751, '2020-08-18 15:08:25', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:08:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1752, '2020-08-18 15:08:42', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:10:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1753, '2020-08-18 15:10:41', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:11:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1754, '2020-08-18 15:11:06', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:11:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1755, '2020-08-18 15:11:53', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:13:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1756, '2020-08-18 15:13:35', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:14:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1757, '2020-08-18 15:14:00', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:14:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1758, '2020-08-18 15:14:54', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:15:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1759, '2020-08-18 15:15:46', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:17:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1760, '2020-08-18 15:17:26', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:17:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1761, '2020-08-18 15:17:59', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:18:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1762, '2020-08-18 15:18:19', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:20:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1763, '2020-08-18 15:20:12', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:22:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1764, '2020-08-18 15:20:12', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 15:20:13', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1765, '2020-08-18 15:22:10', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:23:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1766, '2020-08-18 15:22:10', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 15:22:11', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1767, '2020-08-18 15:23:25', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:28:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1768, '2020-08-18 15:28:36', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:29:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1769, '2020-08-18 15:29:43', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:30:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1770, '2020-08-18 15:30:37', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 15:31:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1771, '2020-08-18 15:31:04', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:36:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1772, '2020-08-18 15:58:16', '220.181.108.179', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1773, '2020-08-18 15:58:17', '111.206.198.39', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1774, '2020-08-18 15:58:17', '111.206.198.39', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1775, '2020-08-18 16:06:20', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 16:06:22', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1776, '2020-08-18 16:06:48', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 16:06:49', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1777, '2020-08-18 16:07:17', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:18:01', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1778, '2020-08-18 16:09:07', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 16:09:08', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1779, '2020-08-18 16:13:52', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 16:13:54', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1780, '2020-08-18 16:18:01', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:18:03', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1781, '2020-08-18 16:18:03', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:18:04', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1782, '2020-08-18 16:18:04', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 16:18:04', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1783, '2020-08-18 16:18:04', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 16:18:05', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1784, '2020-08-18 16:18:05', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-18 16:18:07', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1785, '2020-08-18 16:18:07', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-18 16:18:08', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1786, '2020-08-18 16:18:08', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:18:10', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1787, '2020-08-18 16:18:10', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:18:13', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1788, '2020-08-18 16:18:13', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:18:28', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1789, '2020-08-18 16:18:28', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:18:30', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1790, '2020-08-18 16:18:30', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:18:32', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1791, '2020-08-18 16:18:32', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:18:39', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1792, '2020-08-18 16:18:39', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:18:41', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1793, '2020-08-18 16:18:41', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:18:43', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1794, '2020-08-18 16:18:43', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:18:46', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1795, '2020-08-18 16:18:46', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 16:18:47', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1796, '2020-08-18 16:18:47', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 16:18:47', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1797, '2020-08-18 16:18:48', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-18 16:18:48', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1798, '2020-08-18 16:18:48', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-18 16:18:49', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1799, '2020-08-18 16:18:49', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-18 16:18:49', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1800, '2020-08-18 16:18:49', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-18 16:18:50', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1801, '2020-08-18 16:18:50', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:18:51', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1802, '2020-08-18 16:18:51', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:18:55', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1803, '2020-08-18 16:33:52', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:33:54', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1804, '2020-08-18 16:33:54', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:33:55', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1805, '2020-08-18 16:33:55', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:33:59', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1806, '2020-08-18 16:33:58', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1807, '2020-08-18 16:33:59', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:34:03', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1808, '2020-08-18 16:34:03', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:35:56', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1809, '2020-08-18 16:35:56', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:35:57', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1810, '2020-08-18 16:35:57', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 16:35:58', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1811, '2020-08-18 16:35:58', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:35:59', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1812, '2020-08-18 16:37:30', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:37:36', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1813, '2020-08-18 16:37:36', '65.154.226.109', 'Windows 10', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '美国', '');
INSERT INTO `{pre}statistics` VALUES (1814, '2020-08-18 16:37:37', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1815, '2020-08-18 16:37:39', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1816, '2020-08-18 16:37:42', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:38:16', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1817, '2020-08-18 16:38:16', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:38:20', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1818, '2020-08-18 16:38:20', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:38:22', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1819, '2020-08-18 16:38:22', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:38:26', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1820, '2020-08-18 16:38:25', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1821, '2020-08-18 16:38:26', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:38:27', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1822, '2020-08-18 16:38:27', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:38:29', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1823, '2020-08-18 16:38:29', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:38:58', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1824, '2020-08-18 16:38:49', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:38:51', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1825, '2020-08-18 16:38:51', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:38:55', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1826, '2020-08-18 16:38:55', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:38:56', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1827, '2020-08-18 16:38:57', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:39:16', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1828, '2020-08-18 16:38:59', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:39:03', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1829, '2020-08-18 16:39:03', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:39:05', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1830, '2020-08-18 16:39:05', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1831, '2020-08-18 16:39:07', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:39:07', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1832, '2020-08-18 16:39:07', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 16:39:08', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1833, '2020-08-18 16:39:08', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 16:39:09', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1834, '2020-08-18 16:39:09', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-18 16:39:09', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1835, '2020-08-18 16:39:10', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-18 16:39:10', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1836, '2020-08-18 16:39:10', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 10, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1837, '2020-08-18 16:39:11', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-18 16:39:12', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1838, '2020-08-18 16:39:12', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:40:50', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1839, '2020-08-18 16:39:17', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:39:20', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1840, '2020-08-18 16:39:21', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:40:49', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1841, '2020-08-18 16:39:22', '65.154.226.109', 'Windows 10', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '美国', '');
INSERT INTO `{pre}statistics` VALUES (1842, '2020-08-18 16:39:39', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:39:41', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1843, '2020-08-18 16:39:41', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:39:45', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1844, '2020-08-18 16:39:45', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:40:35', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1845, '2020-08-18 16:40:35', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:40:36', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1846, '2020-08-18 16:40:36', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:40:46', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1847, '2020-08-18 16:40:44', '65.154.226.100', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '美国', '');
INSERT INTO `{pre}statistics` VALUES (1848, '2020-08-18 16:40:46', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:40:48', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1849, '2020-08-18 16:40:48', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:40:51', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1850, '2020-08-18 16:40:51', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1851, '2020-08-18 16:40:59', '65.154.226.100', 'Linux', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '美国', '');
INSERT INTO `{pre}statistics` VALUES (1852, '2020-08-18 16:41:39', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:41:43', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1853, '2020-08-18 16:41:43', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1854, '2020-08-18 16:41:43', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:41:46', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1855, '2020-08-18 16:41:46', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:41:47', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1856, '2020-08-18 16:41:47', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:41:48', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1857, '2020-08-18 16:41:49', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:42:54', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1858, '2020-08-18 16:42:47', '65.154.226.109', 'Windows 10', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '美国', '');
INSERT INTO `{pre}statistics` VALUES (1859, '2020-08-18 16:42:54', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:43:02', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1860, '2020-08-18 16:43:02', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:43:05', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1861, '2020-08-18 16:43:05', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:43:06', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1862, '2020-08-18 16:43:06', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 16:43:07', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1863, '2020-08-18 16:43:07', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1864, '2020-08-18 16:43:59', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:44:06', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1865, '2020-08-18 16:44:07', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:44:51', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1866, '2020-08-18 16:44:09', '65.154.226.109', 'Windows 10', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '美国', '');
INSERT INTO `{pre}statistics` VALUES (1867, '2020-08-18 16:44:51', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:44:55', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1868, '2020-08-18 16:44:56', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:45:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1869, '2020-08-18 16:45:00', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 16:45:16', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1870, '2020-08-18 16:45:16', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 16:45:24', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1871, '2020-08-18 16:45:30', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 16:45:31', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1872, '2020-08-18 16:45:31', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 16:45:31', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1873, '2020-08-18 16:45:32', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 16:45:32', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1874, '2020-08-18 16:45:32', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 16:45:33', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1875, '2020-08-18 16:45:34', '223.72.47.122', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-18 16:45:38', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1876, '2020-08-18 16:45:38', '223.72.47.122', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-18 16:45:40', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1877, '2020-08-18 16:45:40', '223.72.47.122', 'Windows 7', 'Chrome', '', 188, 2, '', '2020-08-18 16:45:41', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1878, '2020-08-18 16:45:42', '223.72.47.122', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-18 16:45:43', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1879, '2020-08-18 16:45:44', '223.72.47.122', 'Windows 7', 'Chrome', '', 257, 5, '', '2020-08-18 16:45:48', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1880, '2020-08-18 17:04:56', '220.181.108.141', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1881, '2020-08-18 17:04:56', '111.206.198.38', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1882, '2020-08-18 17:04:56', '111.206.198.38', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1883, '2020-08-18 17:23:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 187, 2, '', '2020-08-18 17:23:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1884, '2020-08-18 17:36:16', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:36:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1885, '2020-08-18 17:36:28', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:36:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1886, '2020-08-18 17:36:30', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:36:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1887, '2020-08-18 17:36:52', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:37:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1888, '2020-08-18 17:37:07', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:37:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1889, '2020-08-18 17:37:47', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:37:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1890, '2020-08-18 17:37:49', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:37:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1891, '2020-08-18 17:37:55', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:37:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1892, '2020-08-18 17:37:56', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-18 17:37:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1893, '2020-08-18 17:37:57', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:38:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1894, '2020-08-18 17:38:20', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1895, '2020-08-18 17:38:21', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:38:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1896, '2020-08-18 17:38:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:39:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1897, '2020-08-18 17:38:33', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:38:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1898, '2020-08-18 17:39:01', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:39:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1899, '2020-08-18 17:39:14', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:39:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1900, '2020-08-18 17:39:32', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 17:39:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1901, '2020-08-18 17:39:33', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:40:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1902, '2020-08-18 17:40:18', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:40:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1903, '2020-08-18 17:40:31', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 17:40:34', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1904, '2020-08-18 17:40:34', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:40:35', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1905, '2020-08-18 17:40:35', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:40:40', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1906, '2020-08-18 17:40:40', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 17:40:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1907, '2020-08-18 17:40:42', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-18 17:40:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1908, '2020-08-18 17:40:43', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:41:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1909, '2020-08-18 17:41:14', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:41:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1910, '2020-08-18 17:41:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:41:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1911, '2020-08-18 17:41:25', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:41:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1912, '2020-08-18 17:41:44', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:41:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1913, '2020-08-18 17:41:46', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:42:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1914, '2020-08-18 17:42:12', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:42:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1915, '2020-08-18 17:42:40', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:42:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1916, '2020-08-18 17:42:53', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-18 17:42:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1917, '2020-08-18 17:42:56', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:42:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1918, '2020-08-18 17:42:57', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:42:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1919, '2020-08-18 17:42:59', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:42:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1920, '2020-08-18 17:42:59', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1921, '2020-08-18 17:43:00', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1922, '2020-08-18 17:43:01', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1923, '2020-08-18 17:43:02', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1924, '2020-08-18 17:43:02', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1925, '2020-08-18 17:43:03', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1926, '2020-08-18 17:43:04', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1927, '2020-08-18 17:43:04', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1928, '2020-08-18 17:43:09', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1929, '2020-08-18 17:43:14', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1930, '2020-08-18 17:43:17', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1931, '2020-08-18 17:43:20', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1932, '2020-08-18 17:43:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1933, '2020-08-18 17:43:24', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1934, '2020-08-18 17:43:27', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1935, '2020-08-18 17:43:30', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1936, '2020-08-18 17:43:34', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1937, '2020-08-18 17:43:40', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1938, '2020-08-18 17:43:43', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:43:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1939, '2020-08-18 17:43:55', '127.0.0.1', 'Windows 10', 'Chrome', '', 1, 3, '', '2020-08-18 17:43:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1940, '2020-08-18 17:44:02', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:44:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1941, '2020-08-18 17:44:28', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:44:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1942, '2020-08-18 17:44:31', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 17:44:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1943, '2020-08-18 17:44:38', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-18 19:53:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1944, '2020-08-18 18:11:36', '220.181.108.163', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1945, '2020-08-18 18:11:37', '111.206.221.87', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1946, '2020-08-18 18:11:37', '111.206.221.87', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1947, '2020-08-18 18:44:56', '116.179.32.78', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1948, '2020-08-18 18:44:56', '111.206.221.16', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1949, '2020-08-18 18:44:56', '111.206.221.16', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1950, '2020-08-18 18:57:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1951, '2020-08-18 19:03:11', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:03:21', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1952, '2020-08-18 19:03:22', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1953, '2020-08-18 19:03:26', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:03:32', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1954, '2020-08-18 19:03:34', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:03:36', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1955, '2020-08-18 19:03:37', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:03:40', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1956, '2020-08-18 19:03:40', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:03:44', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1957, '2020-08-18 19:03:44', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 19:03:44', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1958, '2020-08-18 19:03:45', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 19:03:45', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1959, '2020-08-18 19:03:45', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 19:03:46', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1960, '2020-08-18 19:03:46', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-18 19:03:47', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1961, '2020-08-18 19:03:47', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-18 19:03:47', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1962, '2020-08-18 19:03:48', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-18 19:03:48', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1963, '2020-08-18 19:03:48', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-18 19:03:50', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1964, '2020-08-18 19:03:50', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 19:03:54', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1965, '2020-08-18 19:03:54', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:03:56', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1966, '2020-08-18 19:03:56', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:03:59', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1967, '2020-08-18 19:03:59', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-18 19:04:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1968, '2020-08-18 19:04:00', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 19:04:01', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1969, '2020-08-18 19:04:01', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 19:04:02', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1970, '2020-08-18 19:04:02', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 19:04:05', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1971, '2020-08-18 19:04:05', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 19:04:07', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1972, '2020-08-18 19:04:07', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 19:04:09', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1973, '2020-08-18 19:04:09', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-18 19:04:10', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1974, '2020-08-18 19:04:10', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 19:04:11', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1975, '2020-08-18 19:04:11', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 19:04:12', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1976, '2020-08-18 19:04:12', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 19:04:14', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1977, '2020-08-18 19:04:14', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-18 19:04:36', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1978, '2020-08-18 19:24:47', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 19:24:49', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1979, '2020-08-18 19:24:49', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 19:24:49', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1980, '2020-08-18 19:25:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:25:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1981, '2020-08-18 19:25:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 19:25:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1982, '2020-08-18 19:25:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 19:25:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1983, '2020-08-18 19:25:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:25:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1984, '2020-08-18 19:25:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:34:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1985, '2020-08-18 19:26:31', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 19:26:34', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1986, '2020-08-18 19:29:24', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 19:29:25', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1987, '2020-08-18 19:34:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 19:34:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1988, '2020-08-18 19:34:17', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:36:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1989, '2020-08-18 19:36:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 19:36:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1990, '2020-08-18 19:36:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 19:36:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1991, '2020-08-18 19:36:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 19:37:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1992, '2020-08-18 19:37:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:37:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1993, '2020-08-18 19:37:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 19:37:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1994, '2020-08-18 19:37:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 19:37:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1995, '2020-08-18 19:51:36', '220.181.108.117', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1996, '2020-08-18 19:51:36', '111.206.221.13', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (1997, '2020-08-18 19:51:36', '111.206.221.13', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (1998, '2020-08-18 19:53:26', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 09:21:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (1999, '2020-08-18 19:57:19', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 19:57:20', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2000, '2020-08-18 20:01:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 20:02:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2001, '2020-08-18 20:02:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 20:02:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2002, '2020-08-18 20:02:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 20:02:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2003, '2020-08-18 20:02:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 20:02:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2004, '2020-08-18 20:02:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 20:02:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2005, '2020-08-18 20:02:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 20:02:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2006, '2020-08-18 20:02:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 20:02:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2007, '2020-08-18 20:02:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 20:02:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2008, '2020-08-18 20:02:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 20:02:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2009, '2020-08-18 20:02:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 20:04:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2010, '2020-08-18 20:04:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 20:04:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2011, '2020-08-18 20:04:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 20:04:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2012, '2020-08-18 20:04:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 20:05:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2013, '2020-08-18 20:05:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 20:05:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2014, '2020-08-18 20:05:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 3, '', '2020-08-18 20:05:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2015, '2020-08-18 20:05:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 3, '', '2020-08-18 20:05:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2016, '2020-08-18 20:05:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 4, '', '2020-08-18 20:05:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2017, '2020-08-18 20:05:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 3, '', '2020-08-18 20:05:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2018, '2020-08-18 20:05:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 4, '', '2020-08-18 20:05:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2019, '2020-08-18 20:05:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 20:05:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2020, '2020-08-18 20:05:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 20:05:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2021, '2020-08-18 20:05:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 20:05:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2022, '2020-08-18 20:06:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 20:06:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2023, '2020-08-18 20:06:03', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 20:06:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2024, '2020-08-18 20:06:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 20:06:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2025, '2020-08-18 20:06:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 20:06:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2026, '2020-08-18 20:58:16', '220.181.108.179', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (2027, '2020-08-18 20:58:17', '111.206.198.26', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (2028, '2020-08-18 21:03:25', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 21:03:26', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2029, '2020-08-18 21:17:36', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 21:17:37', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2030, '2020-08-18 21:17:41', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 21:17:42', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2031, '2020-08-18 21:26:52', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 21:26:54', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2032, '2020-08-18 21:31:36', '220.181.108.154', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', 'company/1.html');
INSERT INTO `{pre}statistics` VALUES (2033, '2020-08-18 21:31:36', '111.206.221.98', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (2034, '2020-08-18 21:39:56', '120.244.129.104', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-18 21:39:57', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2035, '2020-08-18 22:33:42', '111.7.100.19', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-18 22:33:45', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2036, '2020-08-18 22:33:47', '111.7.100.19', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-18 22:33:55', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2037, '2020-08-18 22:36:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 22:36:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2038, '2020-08-18 22:36:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 22:36:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2039, '2020-08-18 22:36:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-18 22:36:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2040, '2020-08-18 22:38:16', '116.179.32.208', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (2041, '2020-08-18 22:38:22', '111.206.198.19', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (2042, '2020-08-18 22:45:27', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 22:45:43', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2043, '2020-08-18 22:45:44', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 22:45:45', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2044, '2020-08-18 22:45:46', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-18 22:45:48', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2045, '2020-08-18 22:45:48', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-18 22:45:51', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2046, '2020-08-18 22:45:51', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-18 22:45:52', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2047, '2020-08-18 22:45:52', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 22:45:56', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2048, '2020-08-18 22:45:56', '27.8.169.138', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-18 22:46:09', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2049, '2020-08-18 22:46:09', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-18 22:46:33', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2050, '2020-08-18 22:46:33', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 6, '', '2020-08-18 22:46:38', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2051, '2020-08-18 22:46:38', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 7, '', '2020-08-18 22:46:40', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2052, '2020-08-18 22:46:40', '27.8.169.138', 'Windows 7', 'Chrome', '', 0, 7, '', '2020-08-18 22:47:40', '重庆', '');
INSERT INTO `{pre}statistics` VALUES (2053, '2020-08-18 23:07:52', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 7, '', '2020-08-18 23:07:56', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2054, '2020-08-18 23:07:56', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 7, '', '2020-08-18 23:07:58', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2055, '2020-08-18 23:07:58', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 23:08:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2056, '2020-08-18 23:08:00', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-18 23:08:06', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2057, '2020-08-18 23:08:06', '223.72.47.122', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-18 23:08:08', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2058, '2020-08-19 00:08:07', '111.7.100.16', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-19 00:08:10', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2059, '2020-08-19 00:08:10', '111.7.100.16', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-19 00:08:20', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2060, '2020-08-19 00:08:16', '220.181.108.77', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (2061, '2020-08-19 00:08:16', '111.206.221.77', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (2062, '2020-08-19 00:08:18', '111.206.198.34', 'iOS', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', '');
INSERT INTO `{pre}statistics` VALUES (2063, '2020-08-19 00:46:05', '111.7.100.22', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-19 00:46:07', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2064, '2020-08-19 00:46:08', '111.7.100.23', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-19 00:46:17', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2065, '2020-08-19 01:30:22', '36.99.136.135', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-19 01:30:27', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2066, '2020-08-19 01:30:27', '36.99.136.132', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-19 01:30:36', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2067, '2020-08-19 09:21:49', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-19 09:22:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2068, '2020-08-19 09:22:41', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-19 10:05:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2069, '2020-08-19 10:05:53', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-19 10:05:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2070, '2020-08-19 10:05:53', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-19 10:05:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2071, '2020-08-19 10:05:56', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 3, '', '2020-08-19 10:05:59', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2072, '2020-08-19 10:06:00', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 4, '', '2020-08-19 10:06:02', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2073, '2020-08-19 10:06:02', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-19 10:06:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2074, '2020-08-19 10:06:04', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 3, '', '2020-08-19 10:06:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2075, '2020-08-19 10:06:06', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 4, '', '2020-08-19 10:06:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2076, '2020-08-19 10:06:15', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 4, '', '2020-08-19 10:06:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2077, '2020-08-19 10:06:18', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 3, '', '2020-08-19 10:06:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2078, '2020-08-19 10:06:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 4, '', '2020-08-19 10:06:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2079, '2020-08-19 10:06:25', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 3, '', '2020-08-19 10:06:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2080, '2020-08-19 10:06:26', '127.0.0.1', 'Windows 10', 'Chrome', '', 1, 3, '', '2020-08-19 10:06:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2081, '2020-08-19 10:06:30', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 4, '', '2020-08-19 10:06:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2082, '2020-08-19 10:06:32', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 3, '', '2020-08-19 10:06:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2083, '2020-08-19 10:06:35', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-19 10:07:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2084, '2020-08-19 10:07:14', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-19 10:07:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2085, '2020-08-19 10:07:20', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-19 10:07:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2086, '2020-08-19 10:07:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 1, 3, '', '2020-08-19 10:07:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2087, '2020-08-19 10:07:57', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 10:09:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2088, '2020-08-19 10:09:21', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 1, '', '2020-08-19 10:09:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2089, '2020-08-19 10:09:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-19 10:09:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2090, '2020-08-19 10:09:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-19 10:09:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2091, '2020-08-19 10:09:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-19 10:09:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2092, '2020-08-19 10:09:24', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-19 10:09:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2093, '2020-08-19 10:09:25', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-19 10:09:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2094, '2020-08-19 10:09:55', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 10:19:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2095, '2020-08-19 10:19:41', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-19 10:28:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2096, '2020-08-19 10:19:47', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2097, '2020-08-19 10:20:35', '127.0.0.1', 'Windows 10', 'Chrome', '', 1, 3, '', '2020-08-19 10:20:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2098, '2020-08-19 10:21:42', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 10:21:47', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2099, '2020-08-19 10:21:47', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2100, '2020-08-19 10:21:48', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 10:22:01', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2101, '2020-08-19 10:22:01', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 10:22:05', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2102, '2020-08-19 10:22:05', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 10:22:30', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2103, '2020-08-19 10:29:21', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 10:29:29', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2104, '2020-08-19 10:55:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 10:55:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2105, '2020-08-19 10:55:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 10:56:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2106, '2020-08-19 10:56:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 10:57:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2107, '2020-08-19 10:57:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 10:58:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2108, '2020-08-19 10:58:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 10:58:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2109, '2020-08-19 10:58:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 10:58:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2110, '2020-08-19 10:58:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 11:01:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2111, '2020-08-19 11:01:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 11:01:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2112, '2020-08-19 11:01:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 11:01:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2113, '2020-08-19 11:01:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 11:01:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2114, '2020-08-19 11:01:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 11:02:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2115, '2020-08-19 11:02:54', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 11:02:58', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2116, '2020-08-19 11:02:59', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 11, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2117, '2020-08-19 11:03:01', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 11, '', '2020-08-19 11:05:39', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2118, '2020-08-19 11:03:03', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 11:03:04', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2119, '2020-08-19 11:05:39', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 11:05:42', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2120, '2020-08-19 11:05:42', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-19 11:05:44', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2121, '2020-08-19 11:05:44', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-19 14:48:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2122, '2020-08-19 11:10:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 11:10:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2123, '2020-08-19 11:42:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 11:42:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2124, '2020-08-19 11:42:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 11:42:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2125, '2020-08-19 11:42:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 11:42:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2126, '2020-08-19 11:42:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 11:56:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2127, '2020-08-19 12:07:26', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 12:07:29', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2128, '2020-08-19 12:07:29', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 12:08:12', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2129, '2020-08-19 12:08:12', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 12:08:13', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2130, '2020-08-19 12:08:13', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 12:08:13', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2131, '2020-08-19 12:08:13', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 12:08:14', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2132, '2020-08-19 12:08:14', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 12:08:15', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2133, '2020-08-19 12:08:15', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 12:08:16', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2134, '2020-08-19 12:08:16', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 12:08:17', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2135, '2020-08-19 12:08:17', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 12:08:24', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2136, '2020-08-19 12:08:24', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 12:09:16', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2137, '2020-08-19 12:09:16', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 12:09:19', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2138, '2020-08-19 12:09:19', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 12:09:26', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2139, '2020-08-19 12:09:26', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 12:09:27', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2140, '2020-08-19 14:02:02', '111.7.100.17', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 14:02:10', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2141, '2020-08-19 14:02:11', '111.7.100.17', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 14:02:17', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2142, '2020-08-19 14:02:18', '111.7.100.26', 'Windows 10', 'Chrome', '', 0, 1, '', '0000-00-00 00:00:00', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2143, '2020-08-19 14:02:20', '111.7.100.25', 'Windows 10', 'Chrome', '', 0, 1, '', '0000-00-00 00:00:00', '河南', '');
INSERT INTO `{pre}statistics` VALUES (2144, '2020-08-19 14:48:00', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-19 14:48:02', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2145, '2020-08-19 14:48:02', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-19 14:48:17', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2146, '2020-08-19 14:48:26', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2147, '2020-08-19 14:51:40', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 14:51:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2148, '2020-08-19 14:51:42', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-19 14:52:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2149, '2020-08-19 14:52:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-19 14:52:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2150, '2020-08-19 14:52:25', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 14:54:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2151, '2020-08-19 14:54:19', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 14:55:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2152, '2020-08-19 14:55:46', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 14:55:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2153, '2020-08-19 14:55:47', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 14:55:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2154, '2020-08-19 14:55:48', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-19 14:55:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2155, '2020-08-19 14:55:49', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-19 14:57:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2156, '2020-08-19 14:57:36', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-19 14:58:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2157, '2020-08-19 14:59:30', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-19 14:59:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2158, '2020-08-19 14:59:45', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2159, '2020-08-19 15:04:55', '220.181.108.145', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', 'company_2/');
INSERT INTO `{pre}statistics` VALUES (2160, '2020-08-19 15:18:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 15:18:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2161, '2020-08-19 15:20:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2162, '2020-08-19 15:27:30', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 15:27:33', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2163, '2020-08-19 15:27:33', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2164, '2020-08-19 15:27:33', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 15:32:56', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2165, '2020-08-19 15:28:17', '223.72.47.122', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 15:28:18', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2166, '2020-08-19 15:35:26', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 15:35:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2167, '2020-08-19 15:35:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 15:35:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2168, '2020-08-19 15:35:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 15:36:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2169, '2020-08-19 15:36:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 15:36:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2170, '2020-08-19 15:36:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 15:36:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2171, '2020-08-19 15:36:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:38:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2172, '2020-08-19 15:38:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:39:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2173, '2020-08-19 15:39:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:39:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2174, '2020-08-19 15:39:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:39:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2175, '2020-08-19 15:39:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:40:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2176, '2020-08-19 15:40:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:40:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2177, '2020-08-19 15:40:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:41:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2178, '2020-08-19 15:41:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:41:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2179, '2020-08-19 15:41:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2180, '2020-08-19 15:41:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:41:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2181, '2020-08-19 15:41:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:41:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2182, '2020-08-19 15:41:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:43:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2183, '2020-08-19 15:43:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:43:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2184, '2020-08-19 15:43:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:43:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2185, '2020-08-19 15:43:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 15:43:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2186, '2020-08-19 15:43:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:43:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2187, '2020-08-19 15:43:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-19 15:43:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2188, '2020-08-19 15:43:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:43:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2189, '2020-08-19 15:43:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:43:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2190, '2020-08-19 15:43:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-19 15:43:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2191, '2020-08-19 15:43:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 15:43:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2192, '2020-08-19 15:43:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 16:47:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2193, '2020-08-19 16:41:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 16:41:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2194, '2020-08-19 16:47:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 16:47:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2195, '2020-08-19 16:47:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 16:47:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2196, '2020-08-19 16:47:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 16:47:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2197, '2020-08-19 16:47:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 16:47:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2198, '2020-08-19 16:47:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 16:47:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2199, '2020-08-19 16:47:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 16:47:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2200, '2020-08-19 16:47:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-19 16:47:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2201, '2020-08-19 16:47:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-19 16:47:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2202, '2020-08-19 16:47:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-19 16:47:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2203, '2020-08-19 16:47:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-19 16:47:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2204, '2020-08-19 16:47:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 16:48:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2205, '2020-08-19 16:47:59', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 16:48:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2206, '2020-08-19 16:48:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 16:48:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2207, '2020-08-19 16:48:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 16:48:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2208, '2020-08-19 17:56:55', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 17:57:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2209, '2020-08-19 17:57:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 17:57:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2210, '2020-08-19 17:57:32', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 17:58:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2211, '2020-08-19 18:15:39', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 18:15:40', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2212, '2020-08-19 19:20:08', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 19:20:54', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2213, '2020-08-19 19:23:44', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 19:23:45', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2214, '2020-08-19 19:24:25', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-19 19:24:27', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2215, '2020-08-19 20:27:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-19 20:27:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2216, '2020-08-19 20:27:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-19 20:27:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2217, '2020-08-19 20:27:24', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-19 20:27:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2218, '2020-08-19 21:11:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 21:11:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2219, '2020-08-19 21:11:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 21:11:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2220, '2020-08-19 21:11:44', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 21:11:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2221, '2020-08-19 21:11:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 21:13:44', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2222, '2020-08-19 21:13:32', '223.101.46.34', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 21:15:00', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (2223, '2020-08-19 21:15:01', '223.101.46.34', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 21:15:06', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (2224, '2020-08-19 21:15:06', '223.101.46.34', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 21:15:08', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (2225, '2020-08-19 21:15:08', '223.101.46.34', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 21:15:14', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (2226, '2020-08-19 21:15:14', '223.101.46.34', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 21:21:53', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (2227, '2020-08-19 21:21:53', '223.101.46.34', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 21:21:56', '辽宁', '');
INSERT INTO `{pre}statistics` VALUES (2228, '2020-08-19 22:20:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-19 22:20:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2229, '2020-08-19 22:20:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 22:20:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2230, '2020-08-19 22:20:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 22:20:19', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2231, '2020-08-19 22:20:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-19 22:20:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2232, '2020-08-19 22:20:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-19 22:20:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2233, '2020-08-19 22:20:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 22:20:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2234, '2020-08-19 22:20:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 22:20:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2235, '2020-08-19 22:20:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 22:20:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2236, '2020-08-19 22:20:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 22:20:47', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2237, '2020-08-19 22:20:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 22:20:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2238, '2020-08-19 22:20:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-19 22:20:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2239, '2020-08-19 22:20:53', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-19 22:20:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2240, '2020-08-19 22:20:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-19 22:20:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2241, '2020-08-19 22:20:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-19 22:21:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2242, '2020-08-19 22:21:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 22:21:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2243, '2020-08-19 22:21:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 22:21:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2244, '2020-08-19 22:21:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 22:21:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2245, '2020-08-19 22:21:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 22:21:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2246, '2020-08-19 22:21:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 22:21:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2247, '2020-08-19 22:21:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 22:21:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2248, '2020-08-19 22:21:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 22:21:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2249, '2020-08-19 22:21:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-19 22:21:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2250, '2020-08-19 22:21:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-19 22:21:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2251, '2020-08-19 22:21:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 22:21:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2252, '2020-08-19 22:21:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 22:21:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2253, '2020-08-19 22:21:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 22:22:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2254, '2020-08-19 22:22:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-19 22:22:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2255, '2020-08-19 22:22:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 22:22:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2256, '2020-08-19 22:22:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 22:22:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2257, '2020-08-19 22:22:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 22:22:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2258, '2020-08-19 22:22:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-19 22:22:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2259, '2020-08-19 22:22:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-19 22:22:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2260, '2020-08-19 22:22:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 22:22:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2261, '2020-08-19 22:22:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-19 22:22:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2262, '2020-08-19 22:22:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 22:22:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2263, '2020-08-19 22:22:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-19 22:22:48', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2264, '2020-08-19 22:22:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-19 22:22:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2265, '2020-08-19 22:35:40', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-20 11:21:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2266, '2020-08-20 00:14:14', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 00:26:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2267, '2020-08-20 00:26:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 00:26:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2268, '2020-08-20 00:26:36', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2269, '2020-08-20 02:15:29', '116.179.32.39', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', 'company_4/');
INSERT INTO `{pre}statistics` VALUES (2270, '2020-08-20 08:09:32', '116.179.32.73', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', 'company/152.html');
INSERT INTO `{pre}statistics` VALUES (2271, '2020-08-20 08:28:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 08:28:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2272, '2020-08-20 08:28:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 08:28:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2273, '2020-08-20 09:17:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:17:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2274, '2020-08-20 09:33:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-20 09:33:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2275, '2020-08-20 09:35:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-20 09:35:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2276, '2020-08-20 09:35:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 09:35:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2277, '2020-08-20 09:36:48', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:36:50', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2278, '2020-08-20 09:36:50', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:36:53', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2279, '2020-08-20 09:36:53', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2280, '2020-08-20 09:36:54', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:36:56', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2281, '2020-08-20 09:36:56', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 09:36:57', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2282, '2020-08-20 09:36:57', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:36:59', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2283, '2020-08-20 09:36:59', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:37:03', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2284, '2020-08-20 09:37:03', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-20 09:37:04', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2285, '2020-08-20 09:37:04', '223.72.57.9', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-20 09:37:08', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2286, '2020-08-20 09:37:08', '223.72.57.9', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-20 09:37:10', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2287, '2020-08-20 09:37:10', '223.72.57.9', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-20 09:37:13', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2288, '2020-08-20 09:37:13', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 09:39:58', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2289, '2020-08-20 09:39:58', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 09:40:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2290, '2020-08-20 09:40:00', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 09:40:04', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2291, '2020-08-20 09:40:04', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-20 09:40:07', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2292, '2020-08-20 09:40:07', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-20 09:40:09', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2293, '2020-08-20 09:40:10', '223.72.57.9', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-20 09:40:13', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2294, '2020-08-20 09:40:13', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:40:16', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2295, '2020-08-20 09:40:16', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:40:19', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2296, '2020-08-20 09:40:19', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 09:40:20', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2297, '2020-08-20 09:40:20', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-20 09:40:21', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2298, '2020-08-20 09:40:21', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 09:40:22', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2299, '2020-08-20 09:40:22', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-20 09:40:22', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2300, '2020-08-20 09:40:23', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-20 09:40:23', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2301, '2020-08-20 09:40:24', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 09:40:24', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2302, '2020-08-20 09:40:24', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:40:25', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2303, '2020-08-20 09:40:26', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 09:40:26', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2304, '2020-08-20 09:40:26', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 09:40:27', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2305, '2020-08-20 09:40:27', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 09:41:05', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2306, '2020-08-20 09:41:05', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 09:41:06', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2307, '2020-08-20 10:40:59', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 10:41:46', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2308, '2020-08-20 11:09:32', '116.179.32.20', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', 'company/148.html');
INSERT INTO `{pre}statistics` VALUES (2309, '2020-08-20 12:03:47', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 12:03:51', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2310, '2020-08-20 12:26:34', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 12:26:35', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2311, '2020-08-20 12:26:37', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 12:26:46', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2312, '2020-08-20 13:00:33', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 13:00:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2313, '2020-08-20 13:00:40', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 13:00:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2314, '2020-08-20 13:14:32', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 13:14:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2315, '2020-08-20 13:14:50', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 13:14:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2316, '2020-08-20 13:15:17', '120.244.128.160', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 13:15:30', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2317, '2020-08-20 13:15:38', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 13:15:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2318, '2020-08-20 13:21:24', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 13:21:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2319, '2020-08-20 14:27:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 14:27:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2320, '2020-08-20 14:27:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 14:27:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2321, '2020-08-20 14:27:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 14:29:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2322, '2020-08-20 14:29:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 14:30:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2323, '2020-08-20 14:30:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 14:30:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2324, '2020-08-20 14:30:07', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 14:30:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2325, '2020-08-20 14:30:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 14:30:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2326, '2020-08-20 14:30:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:05:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2327, '2020-08-20 14:55:31', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2328, '2020-08-20 14:58:31', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 14:58:33', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2329, '2020-08-20 15:05:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:10:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2330, '2020-08-20 15:09:04', '220.181.108.154', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', 'article/188.html');
INSERT INTO `{pre}statistics` VALUES (2331, '2020-08-20 15:10:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:31:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2332, '2020-08-20 15:31:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 15:31:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2333, '2020-08-20 15:31:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-20 15:31:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2334, '2020-08-20 15:31:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:31:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2335, '2020-08-20 15:31:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-20 15:31:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2336, '2020-08-20 15:31:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-20 15:31:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2337, '2020-08-20 15:31:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:31:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2338, '2020-08-20 15:31:58', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 15:32:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2339, '2020-08-20 15:32:00', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-20 15:32:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2340, '2020-08-20 15:32:02', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:36:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2341, '2020-08-20 15:36:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 15:36:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2342, '2020-08-20 15:36:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-20 15:36:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2343, '2020-08-20 15:36:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:37:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2344, '2020-08-20 15:37:00', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:37:03', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2345, '2020-08-20 15:37:03', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 15:37:06', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2346, '2020-08-20 15:37:06', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 15:37:11', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2347, '2020-08-20 15:37:11', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-20 15:37:12', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2348, '2020-08-20 15:37:12', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:37:14', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2349, '2020-08-20 15:37:14', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:37:16', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2350, '2020-08-20 15:37:17', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-20 15:37:20', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2351, '2020-08-20 15:37:20', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:37:22', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2352, '2020-08-20 15:37:22', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:37:23', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2353, '2020-08-20 15:37:23', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:43:06', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2354, '2020-08-20 15:37:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:43:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2355, '2020-08-20 15:43:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:43:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2356, '2020-08-20 15:43:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:43:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2357, '2020-08-20 15:43:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:43:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2358, '2020-08-20 15:43:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:43:53', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2359, '2020-08-20 15:43:54', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-20 15:43:55', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2360, '2020-08-20 15:43:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 15:43:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2361, '2020-08-20 15:43:56', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-20 15:43:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2362, '2020-08-20 15:43:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-20 15:55:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2363, '2020-08-20 18:36:27', '116.179.32.141', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', 'article/171.html');
INSERT INTO `{pre}statistics` VALUES (2364, '2020-08-20 21:26:02', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 21:26:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2365, '2020-08-20 21:26:04', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 2, '', '2020-08-20 21:26:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2366, '2020-08-20 21:26:22', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 5, '', '2020-08-20 21:26:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2367, '2020-08-20 21:26:23', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-20 21:26:24', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2368, '2020-08-20 21:26:24', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-20 21:26:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2369, '2020-08-20 21:26:26', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-20 21:26:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2370, '2020-08-20 21:26:42', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-20 21:28:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2371, '2020-08-20 21:28:31', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-20 21:28:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2372, '2020-08-20 21:28:33', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 8, '', '2020-08-20 21:28:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2373, '2020-08-20 21:28:35', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 9, '', '2020-08-20 21:28:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2374, '2020-08-20 21:28:36', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-21 10:12:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2375, '2020-08-20 23:32:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-20 23:32:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2376, '2020-08-20 23:32:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-20 23:32:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2377, '2020-08-21 01:30:04', '220.181.108.177', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', 'domain/131.html');
INSERT INTO `{pre}statistics` VALUES (2378, '2020-08-21 05:54:00', '220.181.108.109', 'Unknown Platform', '', 'Baiduspider', 0, 0, '', '0000-00-00 00:00:00', '', 'domain/133.html');
INSERT INTO `{pre}statistics` VALUES (2379, '2020-08-21 08:57:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 08:57:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2380, '2020-08-21 08:57:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 08:59:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2381, '2020-08-21 08:59:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-21 08:59:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2382, '2020-08-21 08:59:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-21 08:59:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2383, '2020-08-21 08:59:51', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 08:59:57', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2384, '2020-08-21 08:59:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-21 09:02:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2385, '2020-08-21 09:02:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 09:02:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2386, '2020-08-21 09:02:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 09:02:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2387, '2020-08-21 09:02:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:04:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2388, '2020-08-21 09:04:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:14:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2389, '2020-08-21 09:23:10', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:25:01', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2390, '2020-08-21 09:24:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:24:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2391, '2020-08-21 09:24:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:24:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2392, '2020-08-21 09:32:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:34:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2393, '2020-08-21 09:34:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:34:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2394, '2020-08-21 09:34:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 2, 2, '', '2020-08-21 09:35:03', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2395, '2020-08-21 09:35:04', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:35:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2396, '2020-08-21 09:35:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 09:35:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2397, '2020-08-21 09:35:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 09:35:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2398, '2020-08-21 09:35:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 09:35:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2399, '2020-08-21 09:35:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 09:35:37', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2400, '2020-08-21 09:35:37', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-21 09:35:38', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2401, '2020-08-21 09:35:38', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-21 09:35:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2402, '2020-08-21 09:35:39', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-21 09:35:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2403, '2020-08-21 09:35:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-21 09:35:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2404, '2020-08-21 09:35:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:36:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2405, '2020-08-21 09:36:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:36:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2406, '2020-08-21 09:36:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 2, 2, '', '2020-08-21 09:36:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2407, '2020-08-21 09:36:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 09:36:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2408, '2020-08-21 09:36:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:37:20', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2409, '2020-08-21 09:37:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:38:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2410, '2020-08-21 09:38:22', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:38:26', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2411, '2020-08-21 09:38:27', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 09:38:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2412, '2020-08-21 09:38:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 09:38:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2413, '2020-08-21 09:38:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 09:38:29', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2414, '2020-08-21 09:38:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-21 09:38:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2415, '2020-08-21 09:38:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-21 09:38:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2416, '2020-08-21 09:38:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-21 09:38:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2417, '2020-08-21 09:38:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 11, '', '2020-08-21 09:38:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2418, '2020-08-21 09:38:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:38:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2419, '2020-08-21 09:38:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:40:43', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2420, '2020-08-21 09:40:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 09:40:45', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2421, '2020-08-21 09:40:46', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 09:41:04', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2422, '2020-08-21 09:41:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:41:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2423, '2020-08-21 09:41:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 09:41:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2424, '2020-08-21 09:41:12', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 09:41:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2425, '2020-08-21 09:41:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 09:41:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2426, '2020-08-21 09:41:14', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-21 09:41:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2427, '2020-08-21 09:41:15', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-21 09:41:15', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2428, '2020-08-21 09:45:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:45:07', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2429, '2020-08-21 09:45:08', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:45:09', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2430, '2020-08-21 09:45:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 09:45:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2431, '2020-08-21 09:45:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 09:45:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2432, '2020-08-21 09:45:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 09:45:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2433, '2020-08-21 09:45:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:45:14', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2434, '2020-08-21 09:50:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 09:50:49', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2435, '2020-08-21 09:50:50', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 09:50:51', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2436, '2020-08-21 09:50:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-21 09:51:10', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2437, '2020-08-21 09:51:10', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-21 09:51:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2438, '2020-08-21 09:51:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '2020-08-21 10:07:52', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2439, '2020-08-21 09:52:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2440, '2020-08-21 09:52:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2441, '2020-08-21 09:52:47', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2442, '2020-08-21 09:52:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2443, '2020-08-21 09:55:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2444, '2020-08-21 09:56:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2445, '2020-08-21 09:56:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2446, '2020-08-21 10:05:45', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2447, '2020-08-21 10:06:57', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2448, '2020-08-21 10:07:20', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2449, '2020-08-21 10:07:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2450, '2020-08-21 10:07:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2451, '2020-08-21 10:07:49', '127.0.0.1', 'Windows 7', 'Chrome', '', 1, 3, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2452, '2020-08-21 10:07:52', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 10:07:54', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2453, '2020-08-21 10:07:55', '127.0.0.1', 'Windows 7', 'Chrome', '', 2, 2, '', '2020-08-21 10:08:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2454, '2020-08-21 10:08:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 2, 2, '', '2020-08-21 10:08:28', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2455, '2020-08-21 10:08:29', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 10:08:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2456, '2020-08-21 10:08:30', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 10:08:31', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2457, '2020-08-21 10:08:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 10:08:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2458, '2020-08-21 10:08:32', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 10:08:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2459, '2020-08-21 10:08:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 10:08:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2460, '2020-08-21 10:08:35', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 10:11:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2461, '2020-08-21 10:12:19', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 10:12:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2462, '2020-08-21 10:12:35', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-21 10:14:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2463, '2020-08-21 10:12:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 10:12:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2464, '2020-08-21 10:12:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 10:12:36', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2465, '2020-08-21 10:14:38', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '2020-08-21 10:14:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2466, '2020-08-21 10:14:53', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 0, '', '2020-08-21 10:14:56', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2467, '2020-08-21 10:15:15', '127.0.0.1', 'Windows 10', 'Chrome', '', 0, 10, '', '0000-00-00 00:00:00', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2468, '2020-08-21 10:20:49', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '0000-00-00 00:00:00', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2469, '2020-08-21 10:40:49', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 10:40:53', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2470, '2020-08-21 10:41:12', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 10:41:14', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2471, '2020-08-21 10:41:14', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 10:41:15', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2472, '2020-08-21 10:41:15', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 10:41:16', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2473, '2020-08-21 10:41:16', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 10:41:17', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2474, '2020-08-21 10:41:17', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 10:41:17', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2475, '2020-08-21 10:41:17', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 8, '', '2020-08-21 10:41:18', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2476, '2020-08-21 10:41:18', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 9, '', '2020-08-21 10:41:19', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2477, '2020-08-21 10:41:19', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 10, '', '2020-08-21 10:41:20', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2478, '2020-08-21 10:41:20', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 10:41:21', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2479, '2020-08-21 10:41:21', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 10:41:27', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2480, '2020-08-21 10:41:27', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 10:41:28', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2481, '2020-08-21 10:41:28', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 10:41:30', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2482, '2020-08-21 11:01:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:01:11', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2483, '2020-08-21 11:01:11', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 11:01:12', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2484, '2020-08-21 11:01:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 11:01:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2485, '2020-08-21 11:01:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 11:01:32', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2486, '2020-08-21 11:01:33', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 11:01:34', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2487, '2020-08-21 11:01:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 11:01:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2488, '2020-08-21 11:01:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:01:50', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2489, '2020-08-21 11:03:45', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:03:46', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2490, '2020-08-21 11:04:48', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:05:08', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2491, '2020-08-21 11:05:09', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:05:21', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2492, '2020-08-21 11:05:21', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 11:06:23', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2493, '2020-08-21 11:06:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 11:06:58', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2494, '2020-08-21 11:06:59', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 11:07:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2495, '2020-08-21 11:07:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 11:07:13', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2496, '2020-08-21 11:07:13', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 11:07:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2497, '2020-08-21 11:07:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:07:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2498, '2020-08-21 11:07:43', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:08:35', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2499, '2020-08-21 11:08:36', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:10:41', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2500, '2020-08-21 11:10:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:11:22', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2501, '2020-08-21 11:11:23', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:11:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2502, '2020-08-21 11:11:40', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:12:01', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2503, '2020-08-21 11:12:01', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:12:06', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2504, '2020-08-21 11:12:06', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 11:12:16', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2505, '2020-08-21 11:12:16', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 11:12:18', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2506, '2020-08-21 11:12:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:12:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2507, '2020-08-21 11:12:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:12:30', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2508, '2020-08-21 11:12:31', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:12:33', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2509, '2020-08-21 11:12:34', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:12:40', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2510, '2020-08-21 11:12:41', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 11:12:42', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2511, '2020-08-21 11:12:42', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:13:05', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2512, '2020-08-21 11:13:05', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 11:13:17', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2513, '2020-08-21 11:13:18', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:13:25', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2514, '2020-08-21 11:13:25', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 11:13:27', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2515, '2020-08-21 11:13:28', '127.0.0.1', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:14:39', '本机地址', '');
INSERT INTO `{pre}statistics` VALUES (2516, '2020-08-21 11:14:50', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:15:36', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2517, '2020-08-21 11:15:36', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:15:39', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2518, '2020-08-21 11:15:39', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 1, '', '2020-08-21 11:15:40', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2519, '2020-08-21 11:15:40', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 2, '', '2020-08-21 11:15:41', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2520, '2020-08-21 11:15:41', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 5, '', '2020-08-21 11:15:42', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2521, '2020-08-21 11:15:42', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:15:46', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2522, '2020-08-21 11:15:46', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:17:57', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2523, '2020-08-21 11:19:20', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:19:21', '北京', '');
INSERT INTO `{pre}statistics` VALUES (2524, '2020-08-21 11:19:23', '223.72.57.9', 'Windows 7', 'Chrome', '', 0, 0, '', '2020-08-21 11:19:23', '北京', '');

-- ----------------------------
-- Table structure for gd_tags
-- ----------------------------
DROP TABLE IF EXISTS `{pre}tags`;
CREATE TABLE `{pre}tags`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `area_id` int(10) NOT NULL COMMENT '绑定区域ID',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域名',
  `link` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '链接',
  `create_user` int(11) NOT NULL COMMENT '创建者ID',
  `update_user` int(11) NOT NULL COMMENT '更新者ID',
  `create_time` timestamp(0) NOT NULL COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL COMMENT '状态:0:不可用；1：可用',
  `deleted` tinyint(1) NOT NULL COMMENT '删除 0：未删除；1：已删除； 删除操作不进行物理删除',
  `sorting` int(10) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gd_tags
-- ----------------------------
INSERT INTO `{pre}tags` VALUES (1, 1, '国栋科技', 'https://www.guodong.tech/', 1, 1, '2020-07-26 20:21:41', '2020-08-16 21:54:39', 1, 0, 255);
INSERT INTO `{pre}tags` VALUES (2, 1, '北京国栋', 'https://www.guodong.tech/', 1, 1, '2020-07-26 20:22:14', '2020-08-16 21:55:03', 1, 0, 255);
INSERT INTO `{pre}tags` VALUES (3, 1, 'JellyCMS', 'https://www.jellycms.cn/', 1, 0, '2020-07-26 20:23:15', '0000-00-00 00:00:00', 1, 0, 255);
INSERT INTO `{pre}tags` VALUES (4, 1, '果冻CMS', 'https://www.jellycms.cn/', 1, 0, '2020-07-26 20:23:28', '0000-00-00 00:00:00', 1, 0, 255);
INSERT INTO `{pre}tags` VALUES (5, 1, 'JellyCRM', 'https://www.jellycrm.cn/', 1, 0, '2020-07-26 20:23:51', '0000-00-00 00:00:00', 1, 0, 255);
INSERT INTO `{pre}tags` VALUES (6, 1, '果冻CRM', 'https://www.jellycrm.cn/', 1, 0, '2020-07-26 20:24:06', '0000-00-00 00:00:00', 1, 0, 255);

-- ----------------------------
-- Table structure for gd_upgrade_manage
-- ----------------------------
DROP TABLE IF EXISTS `{pre}upgrade_manage`;
CREATE TABLE `{pre}upgrade_manage`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `zipfile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '更新包',
  `md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细说明文件',
  `fit_versions` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '适用版本号多个以半角逗号隔开',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '更新描述',
  `create_time` datetime(0) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '是否开启更新',
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gd_upgrade_manage
-- ----------------------------
INSERT INTO `{pre}upgrade_manage` VALUES (1, '3.8.0', 'static\\upgrade\\20200811\\1597110155_84d07662d2c960a66d40.zip', '34bf9e4427d6e839895610aa5d77ca90', '新建文件夹/幕布.jpg,覆盖,说明 \n新建文件夹/新建文件夹/1.jpg,覆盖,说明 \n新建文件夹/新建文件夹/2.jpg,覆盖,说明 \n备案.rar,覆盖,说明 \n手持身份证.jpg,覆盖,说明 \n手持营业执照.jpg,覆盖,说明 \n营业执照.jpg,覆盖,说明', '3.7.9', '<p>222</p>', '2020-08-05 18:51:53', '0000-00-00 00:00:00', '1', 0);
INSERT INTO `{pre}upgrade_manage` VALUES (2, '3.8.1', 'static\\upgrade\\20200811\\1597110127_ceb4b5561aca2f187db9.zip', '34bf9e4427d6e839895610aa5d77ca90', '新建文件夹/幕布.jpg,覆盖,说明 \n新建文件夹/新建文件夹/1.jpg,覆盖,说明 \n新建文件夹/新建文件夹/2.jpg,覆盖,说明 \n备案.rar,覆盖,说明 \n手持身份证.jpg,覆盖,说明 \n手持营业执照.jpg,覆盖,说明 \n营业执照.jpg,覆盖,说明', '3.8.0', '<p>6666</p>', '2020-08-06 17:57:29', '0000-00-00 00:00:00', '1', 0);
INSERT INTO `{pre}upgrade_manage` VALUES (3, '3.8.2', 'static\\upgrade\\20200810\\1597065494_cc1c1fe9d0a29ec742e4.zip', '34bf9e4427d6e839895610aa5d77ca90', '新建文件夹/幕布.jpg,覆盖,说明 \n新建文件夹/新建文件夹/1.jpg,覆盖,说明 \n新建文件夹/新建文件夹/2.jpg,覆盖,说明 \n备案.rar,覆盖,说明 \n手持身份证.jpg,覆盖,说明 \n手持营业执照.jpg,覆盖,说明 \n营业执照.jpg,覆盖,说明', '3.8.1', '<p>8888</p>', '2020-08-07 16:50:17', '0000-00-00 00:00:00', '1', 0);
INSERT INTO `{pre}upgrade_manage` VALUES (4, '3.8.3', 'static\\upgrade\\20200812\\1597186342_846ed3e7102da61db176.zip', '830894eb9465a352eb828a376dac33b2', 'app/admin/test.php,覆盖,无 \napp/test.php,覆盖,无', '3.8.0,3.8.2', '<p><span style=\"color:#00b050\"><strong>常规更新，本次升级XXXX</strong></span></p>', '2020-08-10 10:29:09', '2020-08-07 16:52:07', '1', 0);

SET FOREIGN_KEY_CHECKS = 1;
