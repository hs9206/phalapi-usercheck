/*
 Navicat Premium Data Transfer

 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : haima_master

 Date: 03/09/2019 15:12:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for phalapi_user
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'UID',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) DEFAULT '' COMMENT '昵称',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(32) DEFAULT NULL COMMENT '随机加密因子',
  `reg_time` int(11) DEFAULT '0' COMMENT '注册时间',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `uuid` varchar(32) DEFAULT NULL COMMENT 'uuid',
  `ext_info` json DEFAULT NULL COMMENT '用户扩展信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unique_key` (`username`),
  UNIQUE KEY `uuid_unique_key` (`uuid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_login_qq
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_login_qq` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `qq_openid` varchar(28) DEFAULT '' COMMENT 'QQ的OPENID',
  `qq_token` varchar(150) DEFAULT '' COMMENT 'QQ的TOKEN',
  `qq_expires_in` int(10) DEFAULT '0' COMMENT 'QQ的失效时间',
  `user_id` bigint(10) DEFAULT '0' COMMENT '绑定的用户ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_login_weixin
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_login_weixin` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `wx_openid` varchar(28) DEFAULT '' COMMENT '微信OPENID',
  `wx_token` varchar(150) DEFAULT '' COMMENT '微信TOKEN',
  `wx_expires_in` int(10) DEFAULT '0' COMMENT '微信失效时间',
  `user_id` bigint(10) DEFAULT '0' COMMENT '绑定的用户ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_0
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_0` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_1
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_2
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_3
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_3` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_4
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_4` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_5
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_5` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_6
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_6` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_7
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_7` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_8
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_8` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for phalapi_user_session_9
-- ----------------------------
CREATE TABLE IF NOT EXISTS `phalapi_user_session_9` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户id',
  `token` varchar(64) DEFAULT '' COMMENT '登录token',
  `client` varchar(32) DEFAULT '' COMMENT '客户端来源',
  `times` int(6) DEFAULT '0' COMMENT '登录次数',
  `login_time` int(11) DEFAULT '0' COMMENT '登录时间',
  `expires_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `ext_data` text COMMENT 'json data here',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
