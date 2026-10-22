SET NAMES utf8mb4;
-- 建立新的 Schema
CREATE DATABASE IF NOT EXISTS mybatis
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- 切換到新的 Schema
USE mybatis;

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `user_name` VARCHAR(64) NOT NULL DEFAULT 'NULL' COMMENT '用戶名',
  `nick_name` VARCHAR(64) NOT NULL DEFAULT 'NULL' COMMENT '暱稱',
  `password` VARCHAR(64) NOT NULL DEFAULT 'NULL' COMMENT '密碼',
  `status` CHAR(1) DEFAULT '0' COMMENT '帳號狀態（0正常 1停用）',
  `email` VARCHAR(64) DEFAULT NULL COMMENT '信箱',
  `phonenumber` VARCHAR(32) DEFAULT NULL COMMENT '手機號碼',
  `sex` CHAR(1) DEFAULT NULL COMMENT '用戶性别（0男，1女，2未知）',
  `avatar` LONGTEXT DEFAULT NULL COMMENT '頭像',
  `user_type` CHAR(1) NOT NULL DEFAULT '1' COMMENT '用戶類型（0管理員，1普通用戶）',
  `create_by` BIGINT(20) DEFAULT NULL COMMENT '創建人的用戶id',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創建時間',
  `update_by` BIGINT(20) DEFAULT NULL COMMENT '更新人',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  `del_flag` INT(11) DEFAULT '0' COMMENT '刪除標誌（0代表未刪除，1代表已删除）',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='用戶表';

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(64) NOT NULL DEFAULT 'NULL' COMMENT '菜單名',
  `path` varchar(200) DEFAULT NULL COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '組件路徑',
  `visible` char(1) DEFAULT '0' COMMENT '菜單狀態（0顯示 1隱藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜單狀態（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '權限標示',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜單圖標',
  `create_by` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT '0' COMMENT '是否刪除（0未删除 1已删除）',
  `remark` varchar(500) DEFAULT NULL COMMENT '備註',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='菜單表';


DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `role_key` varchar(100) DEFAULT NULL COMMENT '角色權限字符串',
  `status` char(1) DEFAULT '0' COMMENT '角色狀態（0正常 1停用）',
  `del_flag` int(1) DEFAULT '0' COMMENT 'del_flag',
  `create_by` bigint(200) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` bigint(200) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL COMMENT '備註',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `role_id` bigint(200) NOT NULL ,
  `menu_id` bigint(200) NOT NULL DEFAULT '0' COMMENT '菜單id',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `user_id` bigint(200) NOT NULL ,
  `role_id` bigint(200) NOT NULL DEFAULT '0' COMMENT '角色id',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*SQL建立必要資料腳本----------------------------------------------------------------*/
-- sys_role
INSERT INTO mybatis.sys_role
(id, name, role_key, status, del_flag, create_by, create_time, update_by, update_time, remark)
VALUES(1, '管理員', 'admin', '0', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO mybatis.sys_role
(id, name, role_key, status, del_flag, create_by, create_time, update_by, update_time, remark)
VALUES(2, '基本用戶', 'vip1', '0', 0, NULL, NULL, NULL, NULL, NULL);
-- sys_role_menu
INSERT INTO mybatis.sys_role_menu
(role_id, menu_id)
VALUES(1, 1);
INSERT INTO mybatis.sys_role_menu
(role_id, menu_id)
VALUES(1, 2);
INSERT INTO mybatis.sys_role_menu
(role_id, menu_id)
VALUES(2, 2);
-- sys_menu
INSERT INTO mybatis.sys_menu
(id, menu_name, `path`, component, visible, status, perms, icon, create_by, create_time, update_by, update_time, del_flag, remark)
VALUES(1, '管理基本使用者狀態', 'admin', 'sys/dept/admin', '0', '0', 'sys:dept:admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO mybatis.sys_menu
(id, menu_name, `path`, component, visible, status, perms, icon, create_by, create_time, update_by, update_time, del_flag, remark)
VALUES(2, '頁面基本使用功能', 'vip1', 'sys/dept/vip1', '0', '0', 'sys:dept:vip1', NULL, NULL, NULL, NULL, NULL, NULL, NULL);