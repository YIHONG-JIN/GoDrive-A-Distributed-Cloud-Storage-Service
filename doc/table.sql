-- 创建文件表
CREATE TABLE `tbl_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_sha1` char(40) NOT NULL DEFAULT '',
  `file_name` varchar(256) NOT NULL DEFAULT '',
  `file_size` bigint(20) DEFAULT '0',
  `file_addr` varchar(1024) NOT NULL DEFAULT '',
  `create_at` datetime default NOW(),
  `update_at` datetime default NOW() on update current_timestamp(),
  `status` int(11) NOT NULL DEFAULT '0',
  `ext1` int(11) DEFAULT '0',
  `ext2` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_file_hash` (`file_sha1`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建用户表
CREATE TABLE `tbl_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL DEFAULT '',
  `user_pwd` varchar(256) NOT NULL DEFAULT '',
  `email` varchar(64) DEFAULT '',
  `phone` varchar(128) DEFAULT '',
  `email_validated` tinyint(1) DEFAULT 0,
  `phone_validated` tinyint(1) DEFAULT 0,
  `signup_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_active` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `profile` text,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`user_name`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建用户token表
CREATE TABLE `tbl_user_token` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL DEFAULT,
  `user_token` char(40) NOT NULL DEFAULT,
    PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建用户文件表
CREATE TABLE `tbl_user_file` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL,
  `file_sha1` varchar(64) NOT NULL DEFAULT '',
  `file_size` bigint(20) DEFAULT '0',
  `file_name` varchar(256) NOT NULL DEFAULT,
  `upload_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT CURRENT_TIMESTAMP 
          ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_user_file` (`user_name`, `file_sha1`),
  KEY `idx_status` (`status`),
  KEY `idx_user_id` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
