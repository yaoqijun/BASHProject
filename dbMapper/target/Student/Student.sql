CREATE TABLE `Student` (
	`id` int(11) DEFAULT NULL COMMENT '学生Id',
	`name` varchar(20) DEFAULT NULL COMMENT '学生姓名',
	`age` int(11) DEFAULT NULL COMMENT '学生年龄',
	`name_age` int(11) DEFAULT NULL COMMENT 'test',
	`age_name` int(11) DEFAULT NULL COMMENT 'test',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
