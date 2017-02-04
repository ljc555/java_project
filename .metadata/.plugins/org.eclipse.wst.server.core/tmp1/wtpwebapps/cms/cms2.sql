/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50612
Source Host           : localhost:3306
Source Database       : cms2

Target Server Type    : MYSQL
Target Server Version : 50612
File Encoding         : 65001

Date: 2015-07-29 10:06:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `jc_acquisition`
-- ----------------------------
DROP TABLE IF EXISTS `jc_acquisition`;
CREATE TABLE `jc_acquisition` (
  `acquisition_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `acq_name` varchar(50) NOT NULL COMMENT '采集名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '停止时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '当前状态(0:静止;1:采集;2:暂停)',
  `curr_num` int(11) NOT NULL DEFAULT '0' COMMENT '当前号码',
  `curr_item` int(11) NOT NULL DEFAULT '0' COMMENT '当前条数',
  `total_item` int(11) NOT NULL DEFAULT '0' COMMENT '每页总条数',
  `pause_time` int(11) NOT NULL DEFAULT '0' COMMENT '暂停时间(毫秒)',
  `page_encoding` varchar(20) NOT NULL DEFAULT 'GBK' COMMENT '页面编码',
  `plan_list` longtext COMMENT '采集列表',
  `dynamic_addr` varchar(255) DEFAULT NULL COMMENT '动态地址',
  `dynamic_start` int(11) DEFAULT NULL COMMENT '页码开始',
  `dynamic_end` int(11) DEFAULT NULL COMMENT '页码结束',
  `linkset_start` varchar(255) DEFAULT NULL COMMENT '内容链接区开始',
  `linkset_end` varchar(255) DEFAULT NULL COMMENT '内容链接区结束',
  `link_start` varchar(255) DEFAULT NULL COMMENT '内容链接开始',
  `link_end` varchar(255) DEFAULT NULL COMMENT '内容链接结束',
  `title_start` varchar(255) DEFAULT NULL COMMENT '标题开始',
  `title_end` varchar(255) DEFAULT NULL COMMENT '标题结束',
  `keywords_start` varchar(255) DEFAULT NULL COMMENT '关键字开始',
  `keywords_end` varchar(255) DEFAULT NULL COMMENT '关键字结束',
  `description_start` varchar(255) DEFAULT NULL COMMENT '描述开始',
  `description_end` varchar(255) DEFAULT NULL COMMENT '描述结束',
  `content_start` varchar(255) DEFAULT NULL COMMENT '内容开始',
  `content_end` varchar(255) DEFAULT NULL COMMENT '内容结束',
  `pagination_start` varchar(255) DEFAULT NULL COMMENT '内容分页开始',
  `pagination_end` varchar(255) DEFAULT NULL COMMENT '内容分页结束',
  `queue` int(11) NOT NULL DEFAULT '0' COMMENT '队列',
  `repeat_check_type` varchar(20) NOT NULL DEFAULT 'NONE' COMMENT '重复类型',
  PRIMARY KEY (`acquisition_id`),
  KEY `fk_jc_acquisition_channel` (`channel_id`),
  KEY `fk_jc_acquisition_contenttype` (`type_id`),
  KEY `fk_jc_acquisition_site` (`site_id`),
  KEY `fk_jc_acquisition_user` (`user_id`),
  CONSTRAINT `fk_jc_acquisition_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_acquisition_contenttype` FOREIGN KEY (`type_id`) REFERENCES `jc_content_type` (`type_id`),
  CONSTRAINT `fk_jc_acquisition_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_acquisition_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS采集表';

-- ----------------------------
-- Records of jc_acquisition
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_acquisition_history`
-- ----------------------------
DROP TABLE IF EXISTS `jc_acquisition_history`;
CREATE TABLE `jc_acquisition_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_url` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目地址',
  `content_url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容地址',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `description` varchar(20) NOT NULL DEFAULT '' COMMENT '描述',
  `acquisition_id` int(11) DEFAULT NULL COMMENT '采集源',
  `content_id` int(11) DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`history_id`),
  KEY `fk_acquisition_history_acquisition` (`acquisition_id`),
  CONSTRAINT `fk_jc_history_acquisition` FOREIGN KEY (`acquisition_id`) REFERENCES `jc_acquisition` (`acquisition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集历史记录表';

-- ----------------------------
-- Records of jc_acquisition_history
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_acquisition_temp`
-- ----------------------------
DROP TABLE IF EXISTS `jc_acquisition_temp`;
CREATE TABLE `jc_acquisition_temp` (
  `temp_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `channel_url` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目地址',
  `content_url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容地址',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `percent` int(3) NOT NULL DEFAULT '0' COMMENT '百分比',
  `description` varchar(20) NOT NULL DEFAULT '' COMMENT '描述',
  `seq` int(3) NOT NULL DEFAULT '0' COMMENT '顺序',
  PRIMARY KEY (`temp_id`),
  KEY `fk_jc_temp_site` (`site_id`),
  CONSTRAINT `fk_jc_temp_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集进度临时表';

-- ----------------------------
-- Records of jc_acquisition_temp
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_advertising`
-- ----------------------------
DROP TABLE IF EXISTS `jc_advertising`;
CREATE TABLE `jc_advertising` (
  `advertising_id` int(11) NOT NULL AUTO_INCREMENT,
  `adspace_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `ad_name` varchar(100) NOT NULL COMMENT '广告名称',
  `category` varchar(50) NOT NULL COMMENT '广告类型',
  `ad_code` longtext COMMENT '广告代码',
  `ad_weight` int(11) NOT NULL DEFAULT '1' COMMENT '广告权重',
  `display_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '展现次数',
  `click_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '点击次数',
  `start_time` date DEFAULT NULL COMMENT '开始时间',
  `end_time` date DEFAULT NULL COMMENT '结束时间',
  `is_enabled` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  PRIMARY KEY (`advertising_id`),
  KEY `fk_jc_advertising_site` (`site_id`),
  KEY `fk_jc_space_advertising` (`adspace_id`),
  CONSTRAINT `fk_jc_advertising_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_space_advertising` FOREIGN KEY (`adspace_id`) REFERENCES `jc_advertising_space` (`adspace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='CMS广告表';

-- ----------------------------
-- Records of jc_advertising
-- ----------------------------
INSERT INTO `jc_advertising` VALUES ('1', '1', '1', 'banner', 'image', null, '1', '127', '0', null, null, '1');
INSERT INTO `jc_advertising` VALUES ('2', '2', '1', '通栏广告1', 'image', null, '1', '123', '2', null, null, '1');
INSERT INTO `jc_advertising` VALUES ('3', '3', '1', '视频广告上', 'image', null, '1', '0', '0', null, null, '1');
INSERT INTO `jc_advertising` VALUES ('4', '4', '1', '视频广告下', 'image', null, '1', '0', '0', null, null, '1');
INSERT INTO `jc_advertising` VALUES ('5', '5', '1', '留言板本周热点广告', 'image', null, '1', '0', '0', null, null, '1');

-- ----------------------------
-- Table structure for `jc_advertising_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_advertising_attr`;
CREATE TABLE `jc_advertising_attr` (
  `advertising_id` int(11) NOT NULL,
  `attr_name` varchar(50) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_params_advertising` (`advertising_id`),
  CONSTRAINT `fk_jc_params_advertising` FOREIGN KEY (`advertising_id`) REFERENCES `jc_advertising` (`advertising_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS广告属性表';

-- ----------------------------
-- Records of jc_advertising_attr
-- ----------------------------
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_title', '查看willcms官方网站');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_url', '/r/cms/www/red/img/banner.gif');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_link', 'http://www.willcms.com');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_width', '735');
INSERT INTO `jc_advertising_attr` VALUES ('1', 'image_height', '70');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_title', 'willcms官方网站');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_url', '/r/cms/www/red/img/banner1.jpg');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_link', 'http://www.willcms.com');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_width', '960');
INSERT INTO `jc_advertising_attr` VALUES ('2', 'image_height', '60');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_height', '89');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_link', 'http://');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_url', '/u/cms/www/201112/17144805im1p.jpg');
INSERT INTO `jc_advertising_attr` VALUES ('3', 'image_width', '980');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_height', '90');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_link', 'http://');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_url', '/u/cms/www/201112/17145028j3bj.jpg');
INSERT INTO `jc_advertising_attr` VALUES ('4', 'image_width', '980');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_height', '109');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_link', 'http://3x.willcms.com');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_target', '_blank');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_url', '/u/cms/www/201112/18155751wi1k.gif');
INSERT INTO `jc_advertising_attr` VALUES ('5', 'image_width', '215');

-- ----------------------------
-- Table structure for `jc_advertising_space`
-- ----------------------------
DROP TABLE IF EXISTS `jc_advertising_space`;
CREATE TABLE `jc_advertising_space` (
  `adspace_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `ad_name` varchar(100) NOT NULL COMMENT '名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `is_enabled` char(1) NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`adspace_id`),
  KEY `fk_jc_adspace_site` (`site_id`),
  CONSTRAINT `fk_jc_adspace_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='CMS广告版位表';

-- ----------------------------
-- Records of jc_advertising_space
-- ----------------------------
INSERT INTO `jc_advertising_space` VALUES ('1', '1', '页头banner', '全站页头banner', '1');
INSERT INTO `jc_advertising_space` VALUES ('2', '1', '通栏广告', '页面中间通栏广告', '1');
INSERT INTO `jc_advertising_space` VALUES ('3', '1', '视频广告上', '', '1');
INSERT INTO `jc_advertising_space` VALUES ('4', '1', '视频广告下', '', '1');
INSERT INTO `jc_advertising_space` VALUES ('5', '1', '留言板本周热点广告', '', '1');

-- ----------------------------
-- Table structure for `jc_channel`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel`;
CREATE TABLE `jc_channel` (
  `channel_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL COMMENT '模型ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `parent_id` int(11) DEFAULT NULL COMMENT '父栏目ID',
  `channel_path` varchar(30) DEFAULT NULL COMMENT '访问路径',
  `lft` int(11) NOT NULL DEFAULT '1' COMMENT '树左边',
  `rgt` int(11) NOT NULL DEFAULT '2' COMMENT '树右边',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `has_content` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有内容',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  PRIMARY KEY (`channel_id`),
  KEY `fk_jc_channel_model` (`model_id`),
  KEY `fk_jc_channel_parent` (`parent_id`),
  KEY `fk_jc_channel_site` (`site_id`),
  CONSTRAINT `fk_jc_channel_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`),
  CONSTRAINT `fk_jc_channel_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_channel_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='CMS栏目表';

-- ----------------------------
-- Records of jc_channel
-- ----------------------------
INSERT INTO `jc_channel` VALUES ('2', '1', '1', null, 'ent', '1', '26', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('3', '1', '1', null, 'finance', '27', '48', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('4', '1', '1', null, 'house', '49', '66', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('5', '1', '1', null, 'sports', '67', '78', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('6', '1', '1', null, 'tech', '79', '94', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('7', '1', '1', null, 'car', '95', '106', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('9', '4', '1', null, 'download', '107', '114', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('10', '2', '1', null, 'about', '115', '116', '10', '0', '1');
INSERT INTO `jc_channel` VALUES ('23', '1', '1', '4', 'fczc', '50', '51', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('24', '1', '1', '4', 'lsck', '52', '53', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('25', '1', '1', '106', 'home', '146', '147', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('37', '4', '1', '9', 'system', '108', '109', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('38', '4', '1', '9', 'network', '110', '111', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('39', '4', '1', '9', 'media', '112', '113', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('40', '3', '1', '2', 'jg', '2', '3', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('42', '1', '1', '2', 'hynews', '4', '5', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('43', '3', '1', '106', 'notice', '144', '145', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('44', '1', '1', '2', 'officerst', '14', '15', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('45', '1', '1', '2', 'huiyi', '16', '17', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('46', '1', '1', '2', 'zhuanti', '12', '13', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('47', '1', '1', '2', 'jianshe', '10', '11', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('48', '1', '1', '2', 'xiehui', '8', '9', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('49', '1', '1', '2', 'fuwu', '6', '7', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('53', '1', '1', '3', 'zhaobgg', '28', '29', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('54', '3', '1', '3', 'baomingqq', '34', '35', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('55', '1', '1', '3', 'chouqianqk', '32', '33', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('56', '1', '1', '3', 'zigegs', '30', '31', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('57', '1', '1', '3', 'ruweigg', '36', '37', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('58', '1', '1', '3', 'richeng', '38', '39', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('59', '1', '1', '3', 'dayi', '40', '41', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('60', '1', '1', '3', 'zhongbgs', '42', '43', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('61', '1', '1', '3', 'zhongbgg', '44', '45', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('62', '1', '1', '7', 'zengcwj', '96', '97', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('63', '1', '1', '7', 'zhongxgh', '98', '99', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('64', '1', '1', '7', 'shidjs', '100', '101', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('65', '1', '1', '7', 'gongcjz', '102', '103', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('66', '1', '1', '7', 'fengjing', '104', '105', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('67', '1', '1', '6', 'wenjgz', '80', '81', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('68', '1', '1', '6', 'banszl', '82', '83', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('70', '3', '1', '106', 'qiyezizhi', '148', '149', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('71', '1', '1', '6', 'chaiq', '84', '85', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('72', '1', '1', '6', 'jiuchenggz', '86', '87', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('73', '1', '1', '6', 'luopanzs', '88', '89', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('74', '1', '1', '4', 'jiage', '54', '55', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('75', '1', '1', '4', 'gdranqi', '56', '57', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('76', '1', '1', '4', 'tuiguang', '58', '59', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('77', '1', '1', '4', 'anquan', '60', '61', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('78', '1', '1', '4', 'jingda', '64', '65', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('79', '1', '1', '4', 'fuwu', '62', '63', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('81', '1', '1', '5', 'xingzfg', '68', '69', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('82', '3', '1', '5', 'guiz', '74', '75', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('83', '3', '1', '5', 'difangfg', '70', '71', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('84', '3', '1', '5', 'difanggz', '72', '73', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('85', '3', '1', '5', 'guifanwj', '76', '77', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('86', '1', '1', '2', 'zhengwugk', '18', '19', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('87', '1', '1', '2', 'xingzzn', '20', '21', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('88', '1', '1', null, 'zyzc', '117', '120', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('89', '3', '1', '2', 'zwxx', '22', '23', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('91', '3', '1', null, 'bsdt', '121', '142', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('92', '3', '1', '91', 'sqgk', '122', '123', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('93', '3', '1', '91', 'kcyb', '124', '125', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('94', '3', '1', '91', 'dzzb', '126', '127', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('95', '3', '1', '91', 'bdy', '128', '129', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('96', '3', '1', '91', 'zzdj', '130', '131', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('97', '3', '1', '91', 'dzrk', '132', '133', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('98', '3', '1', '91', 'kcyb', '134', '135', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('99', '3', '1', '91', 'dy', '136', '137', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('100', '3', '1', '91', 'qyzs', '138', '139', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('101', '3', '1', '6', 'qyzs', '90', '91', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('102', '3', '1', '2', 'sqgk', '24', '25', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('103', '3', '1', '91', 'hybz', '140', '141', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('104', '3', '1', '88', 'zhxx', '118', '119', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('105', '3', '1', '3', 'wstb', '46', '47', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('106', '3', '1', null, 'jzgc', '143', '160', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('107', '3', '1', '106', 'sgxk', '150', '151', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('108', '3', '1', '106', 'ysba', '152', '153', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('109', '3', '1', '106', 'zlaq', '154', '155', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('110', '3', '1', '106', 'zjxx', '156', '157', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('111', '3', '1', '6', 'dcxk', '92', '93', '10', '1', '1');
INSERT INTO `jc_channel` VALUES ('112', '3', '1', '106', 'wsdy', '158', '159', '10', '1', '1');

-- ----------------------------
-- Table structure for `jc_channel_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_attr`;
CREATE TABLE `jc_channel_attr` (
  `channel_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_channel` (`channel_id`),
  CONSTRAINT `fk_jc_attr_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目扩展属性表';

-- ----------------------------
-- Records of jc_channel_attr
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_channel_department`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_department`;
CREATE TABLE `jc_channel_department` (
  `channel_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`department_id`),
  KEY `fk_jc_channel_department` (`department_id`),
  CONSTRAINT `fk_jc_channel_department` FOREIGN KEY (`department_id`) REFERENCES `jc_department` (`depart_id`),
  CONSTRAINT `fk_jc_department_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目部门关联表';

-- ----------------------------
-- Records of jc_channel_department
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_channel_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_ext`;
CREATE TABLE `jc_channel_ext` (
  `channel_id` int(11) NOT NULL,
  `channel_name` varchar(100) NOT NULL COMMENT '名称',
  `final_step` tinyint(4) DEFAULT '2' COMMENT '终审级别',
  `after_check` tinyint(4) DEFAULT NULL COMMENT '审核后(1:不能修改删除;2:修改后退回;3:修改后不变)',
  `is_static_channel` char(1) NOT NULL DEFAULT '0' COMMENT '是否栏目静态化',
  `is_static_content` char(1) NOT NULL DEFAULT '0' COMMENT '是否内容静态化',
  `is_access_by_dir` char(1) NOT NULL DEFAULT '1' COMMENT '是否使用目录访问',
  `is_list_child` char(1) NOT NULL DEFAULT '0' COMMENT '是否使用子栏目列表',
  `page_size` int(11) NOT NULL DEFAULT '20' COMMENT '每页多少条记录',
  `channel_rule` varchar(150) DEFAULT NULL COMMENT '栏目页生成规则',
  `content_rule` varchar(150) DEFAULT NULL COMMENT '内容页生成规则',
  `link` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `tpl_channel` varchar(100) DEFAULT NULL COMMENT '栏目页模板',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '内容页模板',
  `title_img` varchar(100) DEFAULT NULL COMMENT '缩略图',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图',
  `has_title_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内容是否有缩略图',
  `has_content_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内容是否有内容图',
  `title_img_width` int(11) NOT NULL DEFAULT '139' COMMENT '内容标题图宽度',
  `title_img_height` int(11) NOT NULL DEFAULT '139' COMMENT '内容标题图高度',
  `content_img_width` int(11) NOT NULL DEFAULT '310' COMMENT '内容内容图宽度',
  `content_img_height` int(11) NOT NULL DEFAULT '310' COMMENT '内容内容图高度',
  `comment_control` int(11) NOT NULL DEFAULT '0' COMMENT '评论(0:匿名;1:会员;2:关闭)',
  `allow_updown` tinyint(1) NOT NULL DEFAULT '1' COMMENT '顶踩(true:开放;false:关闭)',
  `is_blank` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否新窗口打开',
  `title` varchar(255) DEFAULT NULL COMMENT 'TITLE',
  `keywords` varchar(255) DEFAULT NULL COMMENT 'KEYWORDS',
  `description` varchar(255) DEFAULT NULL COMMENT 'DESCRIPTION',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_ext_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目内容表';

-- ----------------------------
-- Records of jc_channel_ext
-- ----------------------------
INSERT INTO `jc_channel_ext` VALUES ('2', '政务资讯 ', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/新闻栏目_父级.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '政务资讯 ', '政务资讯 ', '政务资讯 ');
INSERT INTO `jc_channel_ext` VALUES ('3', '招标投标 ', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/新闻栏目_父级.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '招标投标 ', '招标投标 ', '招标投标 ');
INSERT INTO `jc_channel_ext` VALUES ('4', '燃气管理', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/新闻栏目_父级.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '燃气管理', '燃气管理', '燃气管理');
INSERT INTO `jc_channel_ext` VALUES ('5', '政策法规', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/新闻栏目_父级.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '政策法规', '政策法规', '政策法规');
INSERT INTO `jc_channel_ext` VALUES ('6', '住房与地产开发', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/新闻栏目_父级.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '住房与地产开发', '住房与地产开发', '住房与地产开发');
INSERT INTO `jc_channel_ext` VALUES ('7', '城乡建设 ', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/新闻栏目_父级.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '城乡建设 ', '城乡建设 ', '城乡建设 ');
INSERT INTO `jc_channel_ext` VALUES ('9', '下载专区 ', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '下载专区 ', '下载专区 ', '下载专区 ');
INSERT INTO `jc_channel_ext` VALUES ('10', '关于我们', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '关于我们', '关于我们', '关于我们');
INSERT INTO `jc_channel_ext` VALUES ('23', '文件通知 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', '文件通知 ', '房产政策', '文件通知 34');
INSERT INTO `jc_channel_ext` VALUES ('24', '办事指南 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', '办事指南 ', '办事指南 ', '办事指南 2');
INSERT INTO `jc_channel_ext` VALUES ('25', '资质等级标准 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', '资质等级标准 ', '资质等级标准 ', '资质等级标准 ');
INSERT INTO `jc_channel_ext` VALUES ('37', '系统软件', null, null, '0', '0', '1', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/下载栏目_二级.html', null, null, null, '0', '1', '139', '139', '139', '98', '0', '1', '0', '系统软件', '系统软件', '系统软件');
INSERT INTO `jc_channel_ext` VALUES ('38', '网络工具', null, null, '0', '0', '1', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/下载栏目_二级.html', null, null, null, '0', '1', '139', '139', '139', '98', '0', '1', '0', '网络工具', '网络工具', '网络工具');
INSERT INTO `jc_channel_ext` VALUES ('39', '媒体工具', null, null, '0', '0', '1', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/下载栏目_二级.html', null, null, null, '0', '1', '139', '139', '139', '98', '0', '1', '0', '媒体工具', '媒体工具', '媒体工具');
INSERT INTO `jc_channel_ext` VALUES ('40', '机构设置 ', null, null, '0', '0', '1', '0', '20', null, null, null, null, '/WEB-INF/t/cms/www/red/content/作品内容.html', null, null, '0', '1', '139', '139', '310', '310', '2', '0', '0', '机构设置 ', '机构设置 ', '机构设置 ');
INSERT INTO `jc_channel_ext` VALUES ('42', '行业新闻 ', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/t/cms/www/red/channel/新闻栏目_父级.html', '/WEB-INF/t/cms/www/red/content/新闻内容.html', null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '行业新闻 ', '行业新闻 ', '行业新闻 \r\n \r\n文件通知 \r\n \r\n领导讲话 \r\n \r\n会议动态 \r\n \r\n资料下载 \r\n \r\n相关专题 \r\n \r\n建设之光 \r\n \r\n各区县建设局 \r\n \r\n直属事业单位 \r\n \r\n协会学会 \r\n \r\n便民服务 \r\n \r\n联系信息 \r\n \r\n  \r\n');
INSERT INTO `jc_channel_ext` VALUES ('43', '文件通知 ', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', '文件通知 ', '文件通知 ', '文件通知 ');
INSERT INTO `jc_channel_ext` VALUES ('44', '领导讲话 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, '/u/cms/www/201106/211626373ypn.jpg', null, '1', '0', '60', '60', '310', '310', '2', '0', '0', '领导讲话 ', '领导讲话 ', '  \r\n领导讲话 ');
INSERT INTO `jc_channel_ext` VALUES ('45', '会议动态 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', '会议动态 ', '会议动态 ', '会议动态 ');
INSERT INTO `jc_channel_ext` VALUES ('46', '相关专题 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', '相关专题 ', '相关专题 ', '相关专题 \r\n \r\n建设之光 \r\n \r\n各区县建设局 \r\n \r\n直属事业单位 \r\n \r\n协会学会 \r\n \r\n便民服务 \r\n \r\n联系信息 \r\n \r\n  \r\n');
INSERT INTO `jc_channel_ext` VALUES ('47', '建设之光 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', '建设之光 ', '建设之光 ', '建设之光 ');
INSERT INTO `jc_channel_ext` VALUES ('48', '协会学会 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', '协会学会 ', '协会学会 ', '协会学会 \r\n \r\n便民服务 \r\n \r\n联系信息 \r\n \r\n  \r\n');
INSERT INTO `jc_channel_ext` VALUES ('49', '便民服务 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', '便民服务 ', '便民服务 ', '便民服务 \r\n \r\n联系信息 \r\n \r\n  \r\n');
INSERT INTO `jc_channel_ext` VALUES ('53', '招标公告 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('54', '报名情况 ', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('55', '抽签情况 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('56', '资格预审公示 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('57', '入围公告 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('58', '日程安排 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('59', '网上答疑 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('60', '中标公示 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('61', '中标公告 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('62', '政策文件 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('63', '中心镇规划 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('64', '试点村建设 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('65', '工程进展 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('66', '风景名胜 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('67', '文件通知 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('68', '办事指南 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('70', '企业资质 ', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('71', '拆迁公告 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('72', '旧城改造 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('73', '楼盘展示 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('74', '燃气价格 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('75', '管道燃气 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('76', '品牌推广', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('77', ' 燃气安全 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('78', '安全用气有奖竞答 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('79', '燃气服务栏目 ', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('81', '行政法规', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('82', '部门规章', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('83', '地方性法规', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('84', '地方政府规章', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('85', '规范性文件', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('86', '政务公开', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('87', '行政职能', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('88', '职业注册', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('89', '政务信息', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('91', '办事大厅', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('92', '服务项目', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('93', '办事指南', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('94', '收费标准', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('95', '办事结果', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('96', '资质等级标准', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('97', '电子招标系统招标人人口', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('98', '勘察设计企业统计月报', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('99', '交易备案表在线打印 ', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('100', '企业展示', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('101', '企业展示', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('102', '申请公开', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('103', '行业标准', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('104', '综合信息', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('105', '投标申请名表网上填报', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('106', '建筑工程', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('107', '施工许可', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('108', '工程竣工验收备案', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('109', '质量安全', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('110', '造价信息', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('111', '地产许可', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '2', '0', '0', null, null, null);
INSERT INTO `jc_channel_ext` VALUES ('112', '施工项目网上答疑', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null);

-- ----------------------------
-- Table structure for `jc_channel_txt`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_txt`;
CREATE TABLE `jc_channel_txt` (
  `channel_id` int(11) NOT NULL,
  `txt` longtext COMMENT '栏目内容',
  `txt1` longtext COMMENT '扩展内容1',
  `txt2` longtext COMMENT '扩展内容2',
  `txt3` longtext COMMENT '扩展内容3',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_txt_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目文本表';

-- ----------------------------
-- Records of jc_channel_txt
-- ----------------------------
INSERT INTO `jc_channel_txt` VALUES ('10', '<p><font size=\"2\">&nbsp;强大、灵活的标签。</font></p>', null, null, null);

-- ----------------------------
-- Table structure for `jc_channel_user`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_user`;
CREATE TABLE `jc_channel_user` (
  `channel_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`user_id`),
  KEY `fk_jc_channel_user` (`user_id`),
  CONSTRAINT `fk_jc_channel_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目用户关联表';

-- ----------------------------
-- Records of jc_channel_user
-- ----------------------------
INSERT INTO `jc_channel_user` VALUES ('2', '4');
INSERT INTO `jc_channel_user` VALUES ('40', '4');
INSERT INTO `jc_channel_user` VALUES ('42', '4');
INSERT INTO `jc_channel_user` VALUES ('43', '4');
INSERT INTO `jc_channel_user` VALUES ('44', '4');
INSERT INTO `jc_channel_user` VALUES ('45', '4');
INSERT INTO `jc_channel_user` VALUES ('46', '4');
INSERT INTO `jc_channel_user` VALUES ('47', '4');
INSERT INTO `jc_channel_user` VALUES ('88', '4');
INSERT INTO `jc_channel_user` VALUES ('89', '4');
INSERT INTO `jc_channel_user` VALUES ('91', '4');
INSERT INTO `jc_channel_user` VALUES ('92', '4');
INSERT INTO `jc_channel_user` VALUES ('93', '4');
INSERT INTO `jc_channel_user` VALUES ('94', '4');
INSERT INTO `jc_channel_user` VALUES ('95', '4');
INSERT INTO `jc_channel_user` VALUES ('96', '4');
INSERT INTO `jc_channel_user` VALUES ('97', '4');
INSERT INTO `jc_channel_user` VALUES ('98', '4');
INSERT INTO `jc_channel_user` VALUES ('99', '4');
INSERT INTO `jc_channel_user` VALUES ('100', '4');
INSERT INTO `jc_channel_user` VALUES ('102', '4');
INSERT INTO `jc_channel_user` VALUES ('103', '4');
INSERT INTO `jc_channel_user` VALUES ('104', '4');
INSERT INTO `jc_channel_user` VALUES ('106', '4');
INSERT INTO `jc_channel_user` VALUES ('107', '4');
INSERT INTO `jc_channel_user` VALUES ('108', '4');
INSERT INTO `jc_channel_user` VALUES ('109', '4');
INSERT INTO `jc_channel_user` VALUES ('110', '4');
INSERT INTO `jc_channel_user` VALUES ('112', '4');

-- ----------------------------
-- Table structure for `jc_chnl_group_contri`
-- ----------------------------
DROP TABLE IF EXISTS `jc_chnl_group_contri`;
CREATE TABLE `jc_chnl_group_contri` (
  `channel_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`group_id`),
  KEY `fk_jc_channel_group_c` (`group_id`),
  CONSTRAINT `fk_jc_channel_group_c` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_channel_c` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目投稿会员组关联表';

-- ----------------------------
-- Records of jc_chnl_group_contri
-- ----------------------------
INSERT INTO `jc_chnl_group_contri` VALUES ('3', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('4', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('5', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('6', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('7', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('59', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('101', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('105', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('106', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('107', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('108', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('109', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('110', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('111', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('112', '1');
INSERT INTO `jc_chnl_group_contri` VALUES ('2', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('77', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('78', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('79', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('82', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('83', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('84', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('85', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('88', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('89', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('91', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('92', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('93', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('94', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('95', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('96', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('97', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('98', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('99', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('100', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('102', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('103', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('104', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('106', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('107', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('108', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('109', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('110', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('112', '2');
INSERT INTO `jc_chnl_group_contri` VALUES ('88', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('91', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('92', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('93', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('94', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('95', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('96', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('97', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('98', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('99', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('100', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('103', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('104', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('106', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('107', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('108', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('109', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('110', '3');
INSERT INTO `jc_chnl_group_contri` VALUES ('112', '3');

-- ----------------------------
-- Table structure for `jc_chnl_group_view`
-- ----------------------------
DROP TABLE IF EXISTS `jc_chnl_group_view`;
CREATE TABLE `jc_chnl_group_view` (
  `channel_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`group_id`),
  KEY `fk_jc_channel_group_v` (`group_id`),
  CONSTRAINT `fk_jc_channel_group_v` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_channel_v` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目浏览会员组关联表';

-- ----------------------------
-- Records of jc_chnl_group_view
-- ----------------------------
INSERT INTO `jc_chnl_group_view` VALUES ('2', '2');
INSERT INTO `jc_chnl_group_view` VALUES ('40', '2');

-- ----------------------------
-- Table structure for `jc_comment`
-- ----------------------------
DROP TABLE IF EXISTS `jc_comment`;
CREATE TABLE `jc_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_user_id` int(11) DEFAULT NULL COMMENT '评论用户ID',
  `reply_user_id` int(11) DEFAULT NULL COMMENT '回复用户ID',
  `content_id` int(11) NOT NULL COMMENT '内容ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `create_time` datetime NOT NULL COMMENT '评论时间',
  `reply_time` datetime DEFAULT NULL COMMENT '回复时间',
  `ups` smallint(6) NOT NULL DEFAULT '0' COMMENT '支持数',
  `downs` smallint(6) NOT NULL DEFAULT '0' COMMENT '反对数',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
  PRIMARY KEY (`comment_id`),
  KEY `fk_jc_comment_content` (`content_id`),
  KEY `fk_jc_comment_reply` (`reply_user_id`),
  KEY `fk_jc_comment_site` (`site_id`),
  KEY `fk_jc_comment_user` (`comment_user_id`),
  CONSTRAINT `fk_jc_comment_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_comment_reply` FOREIGN KEY (`reply_user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_comment_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_comment_user` FOREIGN KEY (`comment_user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS评论表';

-- ----------------------------
-- Records of jc_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_comment_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_comment_ext`;
CREATE TABLE `jc_comment_ext` (
  `comment_id` int(11) NOT NULL,
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `text` longtext COMMENT '评论内容',
  `reply` longtext COMMENT '回复内容',
  KEY `fk_jc_ext_comment` (`comment_id`),
  CONSTRAINT `fk_jc_ext_comment` FOREIGN KEY (`comment_id`) REFERENCES `jc_comment` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS评论扩展表';

-- ----------------------------
-- Records of jc_comment_ext
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_config`
-- ----------------------------
DROP TABLE IF EXISTS `jc_config`;
CREATE TABLE `jc_config` (
  `config_id` int(11) NOT NULL,
  `context_path` varchar(20) DEFAULT '/cms' COMMENT '部署路径',
  `servlet_point` varchar(20) DEFAULT NULL COMMENT 'Servlet挂载点',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `db_file_uri` varchar(50) NOT NULL DEFAULT '/dbfile.svl?n=' COMMENT '数据库附件访问地址',
  `is_upload_to_db` tinyint(1) NOT NULL DEFAULT '0' COMMENT '上传附件至数据库',
  `def_img` varchar(255) NOT NULL DEFAULT '/cms/r/cms/www/default/no_picture.gif' COMMENT '图片不存在时默认图片',
  `login_url` varchar(255) NOT NULL DEFAULT '/login.jspx' COMMENT '登录地址',
  `process_url` varchar(255) DEFAULT NULL COMMENT '登录后处理地址',
  `mark_on` tinyint(1) NOT NULL DEFAULT '1' COMMENT '开启图片水印',
  `mark_width` int(11) NOT NULL DEFAULT '120' COMMENT '图片最小宽度',
  `mark_height` int(11) NOT NULL DEFAULT '120' COMMENT '图片最小高度',
  `mark_image` varchar(100) DEFAULT '/r/cms/www/watermark.png' COMMENT '图片水印',
  `mark_content` varchar(100) NOT NULL DEFAULT 'www.willcms.com' COMMENT '文字水印内容',
  `mark_size` int(11) NOT NULL DEFAULT '20' COMMENT '文字水印大小',
  `mark_color` varchar(10) NOT NULL DEFAULT '#FF0000' COMMENT '文字水印颜色',
  `mark_alpha` int(11) NOT NULL DEFAULT '50' COMMENT '水印透明度（0-100）',
  `mark_position` int(11) NOT NULL DEFAULT '1' COMMENT '水印位置(0-5)',
  `mark_offset_x` int(11) NOT NULL DEFAULT '0' COMMENT 'x坐标偏移量',
  `mark_offset_y` int(11) NOT NULL DEFAULT '0' COMMENT 'y坐标偏移量',
  `count_clear_time` date NOT NULL COMMENT '计数器清除时间',
  `count_copy_time` datetime NOT NULL COMMENT '计数器拷贝时间',
  `download_code` varchar(32) NOT NULL DEFAULT 'willcms' COMMENT '下载防盗链md5混淆码',
  `download_time` int(11) NOT NULL DEFAULT '12' COMMENT '下载有效时间（小时）',
  `email_host` varchar(50) DEFAULT NULL COMMENT '邮件发送服务器',
  `email_encoding` varchar(20) DEFAULT NULL COMMENT '邮件发送编码',
  `email_username` varchar(100) DEFAULT NULL COMMENT '邮箱用户名',
  `email_password` varchar(100) DEFAULT NULL COMMENT '邮箱密码',
  `email_personal` varchar(100) DEFAULT NULL COMMENT '邮箱发件人',
  `email_validate` tinyint(1) DEFAULT '0' COMMENT '开启邮箱验证',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS配置表';

-- ----------------------------
-- Records of jc_config
-- ----------------------------
INSERT INTO `jc_config` VALUES ('1', '/cms', null, '80', '/dbfile.svl?n=', '0', '/r/cms/www/no_picture.gif', '/login.jspx', null, '0', '120', '120', '/r/cms/www/watermark.png', 'www.willcms.com', '20', '#FF0000', '50', '1', '0', '0', '2015-07-28', '2015-07-28 16:01:10', 'willcms', '12', null, null, null, null, null, '0');

-- ----------------------------
-- Table structure for `jc_config_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_config_attr`;
CREATE TABLE `jc_config_attr` (
  `config_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_config` (`config_id`),
  CONSTRAINT `fk_jc_attr_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS配置属性表';

-- ----------------------------
-- Records of jc_config_attr
-- ----------------------------
INSERT INTO `jc_config_attr` VALUES ('1', 'password_min_len', '6');
INSERT INTO `jc_config_attr` VALUES ('1', 'username_reserved', '');
INSERT INTO `jc_config_attr` VALUES ('1', 'register_on', 'true');
INSERT INTO `jc_config_attr` VALUES ('1', 'member_on', 'true');
INSERT INTO `jc_config_attr` VALUES ('1', 'username_min_len', '6');

-- ----------------------------
-- Table structure for `jc_content`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content`;
CREATE TABLE `jc_content` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL COMMENT '栏目ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `type_id` int(11) NOT NULL COMMENT '属性ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `sort_date` datetime NOT NULL COMMENT '排序日期',
  `top_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '固顶级别',
  `has_title_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有标题图',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `status` tinyint(4) NOT NULL DEFAULT '2' COMMENT '状态(0:草稿;1:审核中;2:审核通过;3:回收站)',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  `comments_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日评论数',
  `downloads_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日下载数',
  `ups_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日顶数',
  PRIMARY KEY (`content_id`),
  KEY `fk_jc_content_site` (`site_id`),
  KEY `fk_jc_content_type` (`type_id`),
  KEY `fk_jc_content_user` (`user_id`),
  KEY `fk_jc_contentchannel` (`channel_id`),
  CONSTRAINT `fk_jc_contentchannel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_content_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_content_type` FOREIGN KEY (`type_id`) REFERENCES `jc_content_type` (`type_id`),
  CONSTRAINT `fk_jc_content_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=utf8 COMMENT='CMS内容表';

-- ----------------------------
-- Records of jc_content
-- ----------------------------
INSERT INTO `jc_content` VALUES ('123', '23', '1', '1', '1', '2011-01-04 13:54:45', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('125', '23', '1', '1', '1', '2011-01-04 13:55:35', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('126', '23', '1', '1', '1', '2011-01-04 13:56:21', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('129', '23', '1', '1', '1', '2011-01-04 13:57:09', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('133', '23', '1', '1', '1', '2011-01-04 13:57:50', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('137', '24', '1', '1', '1', '2011-01-04 14:00:40', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('139', '24', '1', '1', '1', '2011-01-04 14:01:24', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('141', '24', '1', '1', '1', '2011-01-04 14:02:08', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('145', '24', '1', '1', '1', '2011-01-04 14:02:48', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('147', '24', '1', '1', '1', '2011-01-04 14:04:12', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('150', '25', '1', '1', '1', '2011-01-04 14:10:14', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('153', '44', '1', '1', '1', '2011-01-04 14:11:48', '0', '0', '0', '3', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('155', '25', '1', '1', '1', '2011-01-04 14:14:31', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('156', '25', '1', '1', '1', '2011-01-04 14:14:35', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('157', '25', '1', '1', '1', '2011-01-04 14:15:22', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('158', '25', '1', '1', '1', '2011-01-04 14:16:24', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('159', '25', '1', '1', '1', '2011-01-04 14:16:43', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('160', '25', '1', '1', '1', '2011-01-04 14:17:54', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('161', '46', '1', '1', '1', '2011-01-04 14:18:34', '0', '0', '0', '3', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('172', '39', '1', '1', '1', '2011-01-04 14:34:23', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('173', '39', '1', '1', '1', '2011-01-04 14:44:02', '0', '0', '0', '2', '0', '0', '1', '0');
INSERT INTO `jc_content` VALUES ('174', '37', '1', '1', '1', '2011-01-04 14:44:59', '0', '0', '0', '2', '0', '0', '1', '0');
INSERT INTO `jc_content` VALUES ('175', '37', '1', '1', '1', '2011-01-04 14:46:00', '0', '0', '0', '2', '0', '0', '2', '0');
INSERT INTO `jc_content` VALUES ('195', '66', '1', '1', '1', '2011-06-18 15:36:14', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('196', '40', '3', '1', '1', '2011-06-18 15:49:41', '0', '0', '0', '3', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('197', '42', '3', '1', '1', '2011-06-18 15:51:47', '0', '0', '0', '3', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('198', '87', '1', '1', '1', '2011-06-18 18:25:51', '0', '0', '0', '3', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('199', '40', '1', '1', '1', '2011-06-20 10:06:23', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('200', '86', '1', '1', '1', '2011-06-20 10:08:08', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('201', '86', '1', '1', '1', '2011-06-20 10:08:57', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('202', '86', '1', '1', '1', '2011-06-20 10:09:50', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('203', '42', '1', '1', '1', '2011-06-20 10:10:32', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('204', '42', '1', '1', '1', '2011-06-20 10:11:05', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('205', '42', '1', '1', '1', '2011-06-20 10:11:33', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('206', '43', '1', '1', '1', '2011-06-20 10:12:16', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('207', '44', '1', '1', '1', '2011-06-20 10:12:56', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('208', '45', '1', '1', '1', '2011-06-20 10:14:56', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('209', '45', '1', '1', '1', '2011-06-20 10:15:35', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('210', '46', '1', '1', '1', '2011-06-20 10:16:19', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('211', '46', '1', '1', '1', '2011-06-20 10:16:45', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('212', '47', '1', '1', '1', '2011-06-20 10:17:30', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('213', '47', '1', '1', '1', '2011-06-20 10:18:12', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('214', '47', '1', '1', '1', '2011-06-20 10:18:35', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('215', '49', '1', '1', '1', '2011-06-20 10:19:57', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('216', '49', '1', '1', '1', '2011-06-20 10:21:47', '0', '0', '0', '2', '1', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('217', '87', '1', '1', '1', '2011-06-20 10:22:16', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('218', '87', '1', '1', '1', '2011-06-20 10:26:03', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('219', '53', '1', '1', '1', '2011-06-20 10:27:34', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('220', '53', '1', '1', '1', '2011-06-20 10:28:12', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('221', '54', '1', '1', '1', '2011-06-20 10:29:30', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('222', '54', '1', '1', '1', '2011-06-20 10:30:06', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('223', '55', '1', '1', '1', '2011-06-20 10:31:02', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('224', '55', '1', '1', '1', '2011-06-20 10:32:10', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('225', '56', '1', '1', '1', '2011-06-20 10:32:40', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('226', '56', '1', '1', '1', '2011-06-20 10:33:09', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('227', '57', '1', '1', '1', '2011-06-20 10:33:49', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('228', '57', '1', '1', '1', '2011-06-20 10:34:11', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('229', '58', '1', '1', '1', '2011-06-20 10:34:38', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('230', '58', '1', '1', '1', '2011-06-20 10:34:59', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('231', '59', '1', '1', '1', '2011-06-20 10:35:31', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('232', '59', '1', '1', '1', '2011-06-20 10:36:04', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('233', '60', '1', '1', '1', '2011-06-20 10:36:32', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('234', '60', '1', '1', '1', '2011-06-20 10:36:55', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('235', '61', '1', '1', '1', '2011-06-20 10:37:20', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('236', '61', '1', '1', '1', '2011-06-20 10:37:36', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('237', '74', '1', '1', '1', '2011-06-20 10:38:44', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('238', '74', '1', '1', '1', '2011-06-20 10:39:11', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('239', '75', '1', '1', '1', '2011-06-20 10:39:41', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('240', '76', '1', '1', '1', '2011-06-20 10:40:26', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('241', '76', '1', '1', '1', '2011-06-20 10:40:47', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('242', '77', '1', '1', '1', '2011-06-20 10:41:23', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('243', '77', '1', '1', '1', '2011-06-20 10:41:39', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('244', '78', '1', '1', '1', '2011-06-20 10:42:23', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('245', '79', '1', '1', '1', '2011-06-20 10:43:11', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('246', '79', '1', '1', '1', '2011-06-20 10:43:25', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('247', '81', '1', '1', '1', '2011-06-20 10:44:11', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('248', '81', '1', '1', '1', '2011-06-20 10:44:28', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('249', '82', '1', '1', '1', '2011-06-20 10:44:54', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('250', '82', '1', '1', '1', '2011-06-20 10:45:17', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('251', '83', '1', '1', '1', '2011-06-20 10:45:49', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('252', '83', '1', '1', '1', '2011-06-20 10:46:10', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('253', '84', '1', '1', '1', '2011-06-20 10:46:38', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('254', '84', '1', '1', '1', '2011-06-20 10:47:01', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('255', '85', '1', '1', '1', '2011-06-20 10:47:38', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('256', '85', '1', '1', '1', '2011-06-20 10:47:54', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('257', '85', '1', '1', '1', '2011-06-20 10:48:11', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('258', '67', '1', '1', '1', '2011-06-20 10:48:46', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('259', '67', '1', '1', '1', '2011-06-20 10:48:56', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('260', '68', '1', '1', '1', '2011-06-20 10:49:23', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('261', '68', '1', '1', '1', '2011-06-20 10:49:38', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('264', '70', '1', '1', '1', '2011-06-20 10:51:25', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('265', '70', '1', '1', '1', '2011-06-20 10:51:39', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('266', '71', '1', '1', '1', '2011-06-20 10:52:03', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('267', '71', '1', '1', '1', '2011-06-20 10:52:17', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('268', '72', '1', '1', '1', '2011-06-20 10:52:38', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('269', '72', '1', '1', '1', '2011-06-20 10:52:57', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('270', '73', '1', '1', '1', '2011-06-20 10:53:31', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('271', '73', '1', '1', '1', '2011-06-20 10:53:45', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('272', '62', '1', '1', '1', '2011-06-20 10:54:41', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('273', '62', '1', '1', '1', '2011-06-20 10:54:49', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('274', '63', '1', '1', '1', '2011-06-20 10:55:03', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('275', '63', '1', '1', '1', '2011-06-20 10:55:20', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('276', '64', '1', '1', '1', '2011-06-20 10:55:33', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('277', '64', '1', '1', '1', '2011-06-20 10:55:41', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('278', '65', '1', '1', '1', '2011-06-20 10:55:59', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('279', '65', '1', '1', '1', '2011-06-20 10:56:08', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('280', '65', '1', '1', '1', '2011-06-20 10:56:18', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('281', '65', '1', '1', '1', '2011-06-20 10:56:19', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('282', '65', '1', '1', '1', '2011-06-20 10:56:19', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('283', '66', '1', '1', '1', '2011-06-20 10:56:33', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('284', '66', '1', '1', '1', '2011-06-20 10:56:33', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('285', '37', '1', '1', '1', '2011-06-20 18:55:43', '0', '0', '1', '2', '0', '0', '2', '0');
INSERT INTO `jc_content` VALUES ('286', '40', '4', '1', '1', '2011-06-20 19:20:44', '0', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('287', '88', '1', '1', '1', '2011-06-29 09:27:38', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('288', '88', '1', '1', '1', '2011-06-29 09:28:30', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('289', '101', '1', '1', '1', '2011-06-29 17:45:30', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('290', '101', '1', '1', '1', '2011-06-29 17:45:41', '0', '0', '0', '2', '0', '0', '0', '0');
INSERT INTO `jc_content` VALUES ('291', '81', '1', '1', '1', '2015-07-22 19:08:10', '0', '0', '0', '2', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `jc_contenttag`
-- ----------------------------
DROP TABLE IF EXISTS `jc_contenttag`;
CREATE TABLE `jc_contenttag` (
  `content_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  KEY `fk_jc_content_tag` (`tag_id`),
  KEY `fk_jc_tag_content` (`content_id`),
  CONSTRAINT `fk_jc_content_tag` FOREIGN KEY (`tag_id`) REFERENCES `jc_content_tag` (`tag_id`),
  CONSTRAINT `fk_jc_tag_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容标签关联表';

-- ----------------------------
-- Records of jc_contenttag
-- ----------------------------
INSERT INTO `jc_contenttag` VALUES ('123', '50', '0');
INSERT INTO `jc_contenttag` VALUES ('123', '51', '1');
INSERT INTO `jc_contenttag` VALUES ('123', '31', '2');
INSERT INTO `jc_contenttag` VALUES ('125', '5', '0');
INSERT INTO `jc_contenttag` VALUES ('125', '52', '1');
INSERT INTO `jc_contenttag` VALUES ('125', '31', '2');
INSERT INTO `jc_contenttag` VALUES ('126', '53', '0');
INSERT INTO `jc_contenttag` VALUES ('126', '30', '1');
INSERT INTO `jc_contenttag` VALUES ('126', '54', '2');
INSERT INTO `jc_contenttag` VALUES ('126', '55', '3');
INSERT INTO `jc_contenttag` VALUES ('129', '56', '0');
INSERT INTO `jc_contenttag` VALUES ('129', '52', '1');
INSERT INTO `jc_contenttag` VALUES ('129', '31', '2');
INSERT INTO `jc_contenttag` VALUES ('129', '57', '3');
INSERT INTO `jc_contenttag` VALUES ('133', '58', '0');
INSERT INTO `jc_contenttag` VALUES ('133', '1', '1');
INSERT INTO `jc_contenttag` VALUES ('133', '59', '2');
INSERT INTO `jc_contenttag` VALUES ('137', '60', '0');
INSERT INTO `jc_contenttag` VALUES ('139', '61', '0');
INSERT INTO `jc_contenttag` VALUES ('141', '62', '0');
INSERT INTO `jc_contenttag` VALUES ('141', '63', '1');
INSERT INTO `jc_contenttag` VALUES ('145', '64', '0');
INSERT INTO `jc_contenttag` VALUES ('147', '65', '0');
INSERT INTO `jc_contenttag` VALUES ('147', '66', '1');
INSERT INTO `jc_contenttag` VALUES ('156', '67', '0');
INSERT INTO `jc_contenttag` VALUES ('156', '68', '1');
INSERT INTO `jc_contenttag` VALUES ('157', '69', '0');
INSERT INTO `jc_contenttag` VALUES ('158', '70', '0');
INSERT INTO `jc_contenttag` VALUES ('158', '71', '1');
INSERT INTO `jc_contenttag` VALUES ('158', '72', '2');
INSERT INTO `jc_contenttag` VALUES ('161', '73', '0');
INSERT INTO `jc_contenttag` VALUES ('161', '74', '1');
INSERT INTO `jc_contenttag` VALUES ('197', '75', '0');
INSERT INTO `jc_contenttag` VALUES ('199', '76', '0');
INSERT INTO `jc_contenttag` VALUES ('287', '77', '0');
INSERT INTO `jc_contenttag` VALUES ('289', '78', '0');

-- ----------------------------
-- Table structure for `jc_content_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_attachment`;
CREATE TABLE `jc_content_attachment` (
  `content_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL COMMENT '排列顺序',
  `attachment_path` varchar(255) NOT NULL COMMENT '附件路径',
  `attachment_name` varchar(100) NOT NULL COMMENT '附件名称',
  `filename` varchar(100) DEFAULT NULL COMMENT '文件名',
  `download_count` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  KEY `fk_jc_attachment_content` (`content_id`),
  CONSTRAINT `fk_jc_attachment_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容附件表';

-- ----------------------------
-- Records of jc_content_attachment
-- ----------------------------
INSERT INTO `jc_content_attachment` VALUES ('172', '0', '/u/cms/www/201101/04143406ni8r.rar', 'willcms.rar', 'willcms.rar', '0');
INSERT INTO `jc_content_attachment` VALUES ('173', '0', '/u/cms/www/201101/04143406ni8r.rar', '04143406ni8r.rar', null, '0');
INSERT INTO `jc_content_attachment` VALUES ('175', '0', '/u/cms/www/201101/04143406ni8r.rar', '04143406ni8r.rar', null, '0');
INSERT INTO `jc_content_attachment` VALUES ('174', '0', '/u/cms/www/201101/04143406ni8r.rar', '04143406ni8r.rar', null, '0');
INSERT INTO `jc_content_attachment` VALUES ('285', '0', '/u/cms/www/201106/201853362t8g.ppt', '湖南微尔技术部规划目标.ppt', '湖南微尔技术部规划目标.ppt', '0');
INSERT INTO `jc_content_attachment` VALUES ('199', '0', '/u/cms/www/201106/201857178dqh.doc', '222222', null, '0');

-- ----------------------------
-- Table structure for `jc_content_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_attr`;
CREATE TABLE `jc_content_attr` (
  `content_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_content` (`content_id`),
  CONSTRAINT `fk_jc_attr_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容扩展属性表';

-- ----------------------------
-- Records of jc_content_attr
-- ----------------------------
INSERT INTO `jc_content_attr` VALUES ('172', 'warrant', '免费版');
INSERT INTO `jc_content_attr` VALUES ('172', 'demoUrl', 'http://');
INSERT INTO `jc_content_attr` VALUES ('172', 'relatedLink', 'http://');
INSERT INTO `jc_content_attr` VALUES ('172', 'softType', '国产软件');
INSERT INTO `jc_content_attr` VALUES ('173', 'warrant', '免费版');
INSERT INTO `jc_content_attr` VALUES ('173', 'demoUrl', 'http://');
INSERT INTO `jc_content_attr` VALUES ('173', 'relatedLink', 'http://');
INSERT INTO `jc_content_attr` VALUES ('173', 'softType', '国产软件');
INSERT INTO `jc_content_attr` VALUES ('174', 'warrant', '免费版');
INSERT INTO `jc_content_attr` VALUES ('174', 'demoUrl', 'http://');
INSERT INTO `jc_content_attr` VALUES ('174', 'relatedLink', 'http://');
INSERT INTO `jc_content_attr` VALUES ('174', 'softType', '国产软件');
INSERT INTO `jc_content_attr` VALUES ('175', 'warrant', '免费版');
INSERT INTO `jc_content_attr` VALUES ('175', 'demoUrl', '#');
INSERT INTO `jc_content_attr` VALUES ('175', 'relatedLink', '#');
INSERT INTO `jc_content_attr` VALUES ('175', 'softType', '国产软件');
INSERT INTO `jc_content_attr` VALUES ('285', 'warrant', '免费版');
INSERT INTO `jc_content_attr` VALUES ('285', 'demoUrl', 'http://');
INSERT INTO `jc_content_attr` VALUES ('285', 'relatedLink', 'http://');
INSERT INTO `jc_content_attr` VALUES ('285', 'softType', '国产软件');

-- ----------------------------
-- Table structure for `jc_content_channel`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_channel`;
CREATE TABLE `jc_content_channel` (
  `channel_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`content_id`),
  KEY `fk_jc_channel_content` (`content_id`),
  CONSTRAINT `fk_jc_channel_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_content_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容栏目关联表';

-- ----------------------------
-- Records of jc_content_channel
-- ----------------------------
INSERT INTO `jc_content_channel` VALUES ('23', '123');
INSERT INTO `jc_content_channel` VALUES ('23', '125');
INSERT INTO `jc_content_channel` VALUES ('23', '126');
INSERT INTO `jc_content_channel` VALUES ('23', '129');
INSERT INTO `jc_content_channel` VALUES ('23', '133');
INSERT INTO `jc_content_channel` VALUES ('24', '137');
INSERT INTO `jc_content_channel` VALUES ('24', '139');
INSERT INTO `jc_content_channel` VALUES ('24', '141');
INSERT INTO `jc_content_channel` VALUES ('24', '145');
INSERT INTO `jc_content_channel` VALUES ('24', '147');
INSERT INTO `jc_content_channel` VALUES ('25', '150');
INSERT INTO `jc_content_channel` VALUES ('44', '153');
INSERT INTO `jc_content_channel` VALUES ('25', '155');
INSERT INTO `jc_content_channel` VALUES ('25', '156');
INSERT INTO `jc_content_channel` VALUES ('25', '157');
INSERT INTO `jc_content_channel` VALUES ('25', '158');
INSERT INTO `jc_content_channel` VALUES ('25', '159');
INSERT INTO `jc_content_channel` VALUES ('25', '160');
INSERT INTO `jc_content_channel` VALUES ('46', '161');
INSERT INTO `jc_content_channel` VALUES ('39', '172');
INSERT INTO `jc_content_channel` VALUES ('39', '173');
INSERT INTO `jc_content_channel` VALUES ('37', '174');
INSERT INTO `jc_content_channel` VALUES ('37', '175');
INSERT INTO `jc_content_channel` VALUES ('66', '195');
INSERT INTO `jc_content_channel` VALUES ('40', '196');
INSERT INTO `jc_content_channel` VALUES ('42', '197');
INSERT INTO `jc_content_channel` VALUES ('87', '198');
INSERT INTO `jc_content_channel` VALUES ('40', '199');
INSERT INTO `jc_content_channel` VALUES ('86', '200');
INSERT INTO `jc_content_channel` VALUES ('86', '201');
INSERT INTO `jc_content_channel` VALUES ('86', '202');
INSERT INTO `jc_content_channel` VALUES ('42', '203');
INSERT INTO `jc_content_channel` VALUES ('42', '204');
INSERT INTO `jc_content_channel` VALUES ('42', '205');
INSERT INTO `jc_content_channel` VALUES ('43', '206');
INSERT INTO `jc_content_channel` VALUES ('44', '207');
INSERT INTO `jc_content_channel` VALUES ('45', '208');
INSERT INTO `jc_content_channel` VALUES ('45', '209');
INSERT INTO `jc_content_channel` VALUES ('46', '210');
INSERT INTO `jc_content_channel` VALUES ('46', '211');
INSERT INTO `jc_content_channel` VALUES ('47', '212');
INSERT INTO `jc_content_channel` VALUES ('47', '213');
INSERT INTO `jc_content_channel` VALUES ('47', '214');
INSERT INTO `jc_content_channel` VALUES ('49', '215');
INSERT INTO `jc_content_channel` VALUES ('49', '216');
INSERT INTO `jc_content_channel` VALUES ('87', '217');
INSERT INTO `jc_content_channel` VALUES ('87', '218');
INSERT INTO `jc_content_channel` VALUES ('53', '219');
INSERT INTO `jc_content_channel` VALUES ('53', '220');
INSERT INTO `jc_content_channel` VALUES ('54', '221');
INSERT INTO `jc_content_channel` VALUES ('54', '222');
INSERT INTO `jc_content_channel` VALUES ('55', '223');
INSERT INTO `jc_content_channel` VALUES ('55', '224');
INSERT INTO `jc_content_channel` VALUES ('56', '225');
INSERT INTO `jc_content_channel` VALUES ('56', '226');
INSERT INTO `jc_content_channel` VALUES ('57', '227');
INSERT INTO `jc_content_channel` VALUES ('57', '228');
INSERT INTO `jc_content_channel` VALUES ('58', '229');
INSERT INTO `jc_content_channel` VALUES ('58', '230');
INSERT INTO `jc_content_channel` VALUES ('59', '231');
INSERT INTO `jc_content_channel` VALUES ('59', '232');
INSERT INTO `jc_content_channel` VALUES ('60', '233');
INSERT INTO `jc_content_channel` VALUES ('60', '234');
INSERT INTO `jc_content_channel` VALUES ('61', '235');
INSERT INTO `jc_content_channel` VALUES ('61', '236');
INSERT INTO `jc_content_channel` VALUES ('74', '237');
INSERT INTO `jc_content_channel` VALUES ('74', '238');
INSERT INTO `jc_content_channel` VALUES ('75', '239');
INSERT INTO `jc_content_channel` VALUES ('76', '240');
INSERT INTO `jc_content_channel` VALUES ('76', '241');
INSERT INTO `jc_content_channel` VALUES ('77', '242');
INSERT INTO `jc_content_channel` VALUES ('77', '243');
INSERT INTO `jc_content_channel` VALUES ('78', '244');
INSERT INTO `jc_content_channel` VALUES ('79', '245');
INSERT INTO `jc_content_channel` VALUES ('79', '246');
INSERT INTO `jc_content_channel` VALUES ('81', '247');
INSERT INTO `jc_content_channel` VALUES ('81', '248');
INSERT INTO `jc_content_channel` VALUES ('82', '249');
INSERT INTO `jc_content_channel` VALUES ('82', '250');
INSERT INTO `jc_content_channel` VALUES ('83', '251');
INSERT INTO `jc_content_channel` VALUES ('83', '252');
INSERT INTO `jc_content_channel` VALUES ('84', '253');
INSERT INTO `jc_content_channel` VALUES ('84', '254');
INSERT INTO `jc_content_channel` VALUES ('85', '255');
INSERT INTO `jc_content_channel` VALUES ('85', '256');
INSERT INTO `jc_content_channel` VALUES ('85', '257');
INSERT INTO `jc_content_channel` VALUES ('67', '258');
INSERT INTO `jc_content_channel` VALUES ('67', '259');
INSERT INTO `jc_content_channel` VALUES ('68', '260');
INSERT INTO `jc_content_channel` VALUES ('68', '261');
INSERT INTO `jc_content_channel` VALUES ('70', '264');
INSERT INTO `jc_content_channel` VALUES ('70', '265');
INSERT INTO `jc_content_channel` VALUES ('71', '266');
INSERT INTO `jc_content_channel` VALUES ('71', '267');
INSERT INTO `jc_content_channel` VALUES ('72', '268');
INSERT INTO `jc_content_channel` VALUES ('72', '269');
INSERT INTO `jc_content_channel` VALUES ('73', '270');
INSERT INTO `jc_content_channel` VALUES ('73', '271');
INSERT INTO `jc_content_channel` VALUES ('62', '272');
INSERT INTO `jc_content_channel` VALUES ('62', '273');
INSERT INTO `jc_content_channel` VALUES ('63', '274');
INSERT INTO `jc_content_channel` VALUES ('63', '275');
INSERT INTO `jc_content_channel` VALUES ('64', '276');
INSERT INTO `jc_content_channel` VALUES ('64', '277');
INSERT INTO `jc_content_channel` VALUES ('65', '278');
INSERT INTO `jc_content_channel` VALUES ('65', '279');
INSERT INTO `jc_content_channel` VALUES ('65', '280');
INSERT INTO `jc_content_channel` VALUES ('65', '281');
INSERT INTO `jc_content_channel` VALUES ('65', '282');
INSERT INTO `jc_content_channel` VALUES ('66', '283');
INSERT INTO `jc_content_channel` VALUES ('66', '284');
INSERT INTO `jc_content_channel` VALUES ('37', '285');
INSERT INTO `jc_content_channel` VALUES ('40', '286');
INSERT INTO `jc_content_channel` VALUES ('88', '287');
INSERT INTO `jc_content_channel` VALUES ('88', '288');
INSERT INTO `jc_content_channel` VALUES ('101', '289');
INSERT INTO `jc_content_channel` VALUES ('101', '290');
INSERT INTO `jc_content_channel` VALUES ('81', '291');

-- ----------------------------
-- Table structure for `jc_content_check`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_check`;
CREATE TABLE `jc_content_check` (
  `content_id` int(11) NOT NULL,
  `check_step` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核步数',
  `check_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  `is_rejected` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否退回',
  `reviewer` int(11) DEFAULT NULL COMMENT '终审者',
  `check_date` datetime DEFAULT NULL COMMENT '终审时间',
  PRIMARY KEY (`content_id`),
  KEY `fk_jc_content_check_user` (`reviewer`),
  CONSTRAINT `fk_jc_check_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_content_check_user` FOREIGN KEY (`reviewer`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容审核信息表';

-- ----------------------------
-- Records of jc_content_check
-- ----------------------------
INSERT INTO `jc_content_check` VALUES ('123', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('125', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('126', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('129', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('133', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('137', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('139', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('141', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('145', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('147', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('150', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('153', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('155', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('156', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('157', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('158', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('159', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('160', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('161', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('172', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('173', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('174', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('175', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('195', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('196', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('197', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('198', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('199', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('200', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('201', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('202', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('203', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('204', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('205', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('206', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('207', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('208', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('209', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('210', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('211', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('212', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('213', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('214', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('215', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('216', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('217', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('218', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('219', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('220', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('221', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('222', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('223', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('224', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('225', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('226', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('227', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('228', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('229', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('230', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('231', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('232', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('233', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('234', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('235', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('236', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('237', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('238', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('239', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('240', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('241', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('242', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('243', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('244', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('245', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('246', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('247', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('248', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('249', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('250', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('251', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('252', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('253', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('254', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('255', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('256', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('257', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('258', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('259', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('260', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('261', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('264', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('265', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('266', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('267', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('268', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('269', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('270', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('271', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('272', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('273', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('274', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('275', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('276', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('277', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('278', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('279', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('280', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('281', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('282', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('283', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('284', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('285', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('286', '1', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('287', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('288', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('289', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('290', '2', null, '0', null, null);
INSERT INTO `jc_content_check` VALUES ('291', '2', null, '0', null, null);

-- ----------------------------
-- Table structure for `jc_content_count`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_count`;
CREATE TABLE `jc_content_count` (
  `content_id` int(11) NOT NULL,
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '总访问数',
  `views_month` int(11) NOT NULL DEFAULT '0' COMMENT '月访问数',
  `views_week` int(11) NOT NULL DEFAULT '0' COMMENT '周访问数',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  `comments` int(11) NOT NULL DEFAULT '0' COMMENT '总评论数',
  `comments_month` int(11) NOT NULL DEFAULT '0' COMMENT '月评论数',
  `comments_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周评论数',
  `comments_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日评论数',
  `downloads` int(11) NOT NULL DEFAULT '0' COMMENT '总下载数',
  `downloads_month` int(11) NOT NULL DEFAULT '0' COMMENT '月下载数',
  `downloads_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周下载数',
  `downloads_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日下载数',
  `ups` int(11) NOT NULL DEFAULT '0' COMMENT '总顶数',
  `ups_month` int(11) NOT NULL DEFAULT '0' COMMENT '月顶数',
  `ups_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周顶数',
  `ups_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日顶数',
  `downs` int(11) NOT NULL DEFAULT '0' COMMENT '总踩数',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_count_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容计数表';

-- ----------------------------
-- Records of jc_content_count
-- ----------------------------
INSERT INTO `jc_content_count` VALUES ('123', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('125', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('126', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('129', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('133', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('137', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('139', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('141', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('145', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('147', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('150', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('153', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('155', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('156', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('157', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('159', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('160', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('161', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('172', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('173', '3', '0', '0', '0', '0', '0', '0', '0', '1', '1', '1', '1', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('174', '6', '0', '0', '0', '0', '0', '0', '0', '1', '1', '1', '1', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('175', '7', '0', '0', '0', '0', '0', '0', '0', '2', '2', '1', '2', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('195', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('196', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('197', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('198', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('200', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('201', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('202', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('203', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('204', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('205', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('206', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('207', '8', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('208', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('209', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('210', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('211', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('212', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('213', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('214', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('215', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('216', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('217', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('218', '12', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('219', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('220', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('221', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('222', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('223', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('224', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('225', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('226', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('227', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('228', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('229', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('230', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('231', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('232', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('233', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('234', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('235', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('236', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('237', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('239', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('240', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('241', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('242', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('243', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('244', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('245', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('246', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('247', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('248', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('249', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('250', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('251', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('252', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('253', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('254', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('255', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('256', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('257', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('258', '11', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('259', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('260', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('261', '8', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('264', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('265', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('266', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('267', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('268', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('269', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('270', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('271', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('272', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('273', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('274', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('275', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('276', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('277', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('278', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('279', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('280', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('281', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('282', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('283', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('284', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('285', '8', '0', '0', '0', '0', '0', '0', '0', '2', '2', '1', '2', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('286', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('287', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('288', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('289', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('290', '2', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `jc_content_count` VALUES ('291', '3', '3', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `jc_content_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_ext`;
CREATE TABLE `jc_content_ext` (
  `content_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL COMMENT '标题',
  `short_title` varchar(150) DEFAULT NULL COMMENT '简短标题',
  `author` varchar(100) DEFAULT NULL COMMENT '作者',
  `origin` varchar(100) DEFAULT NULL COMMENT '来源',
  `origin_url` varchar(255) DEFAULT NULL COMMENT '来源链接',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `release_date` datetime NOT NULL COMMENT '发布日期',
  `media_path` varchar(255) DEFAULT NULL COMMENT '媒体路径',
  `media_type` varchar(20) DEFAULT NULL COMMENT '媒体类型',
  `title_color` varchar(10) DEFAULT NULL COMMENT '标题颜色',
  `is_bold` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否加粗',
  `title_img` varchar(100) DEFAULT NULL COMMENT '标题图片',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图片',
  `type_img` varchar(100) DEFAULT NULL COMMENT '类型图片',
  `link` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '指定模板',
  `need_regenerate` tinyint(1) NOT NULL DEFAULT '1' COMMENT '需要重新生成静态页',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_ext_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容扩展表';

-- ----------------------------
-- Records of jc_content_ext
-- ----------------------------
INSERT INTO `jc_content_ext` VALUES ('123', '沈阳房价调控政策大猜谜', '沈阳房价调控政策大猜谜', null, null, null, '今年房价会降吗?热议中的房产税能否推出?还会有几次加息?会不会有新一轮调控政策出台?在尚不明朗的房价走势下，你会不会买房?', '2011-01-04 13:54:45', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('125', '多地楼市调控细则“和风细雨” 严厉政策遭化解？ ', '多地楼市调控细则“和风细雨” 严厉政策遭化解？ ', null, null, null, '\r\n一些地方楼市调控政策近期陆续出台。与北京调控政策的严厉程度相比，其他地方楼市新政则显得“和风细雨”，力度“温和”。 ', '2011-01-04 13:55:35', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('126', '房产税改革中央地方现分歧　评估机构成关键', '房产税改革中央地方现分歧　评估机构成关键', null, null, null, '　现有地方试点方案，均是修改现行房产税，将已有房产税的征税范围扩展到居民自住房屋，这与部委意见不一；而地方与中央立法精神不一，未来会出现很大麻烦', '2011-01-04 13:56:21', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('129', '房产调控政策陆续出台 南通楼市成交大幅萎缩', '房产调控政策陆续出台 南通楼市成交大幅萎缩', null, null, null, '　随着住房公积金贷款新政以及央行加息等多重影响，市区住房成交量开始大幅萎缩。记者了解到：2010年12月的第四周也就是12月20日至12月26日，市区共成交住宅163套，较前一周减少335套，环比下降了67.27%。', '2011-01-04 13:57:09', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('133', '房地产2011年投资策略：区域分化 “稳”见未来', '房地产2011年投资策略：区域分化 “稳”见未来', null, null, null, '未来政策展望:我们认为明年房地产调控将更多使用货币手段，通过调整利率、信贷窗口指导、准备金等工具统筹应对房价上涨和通货膨胀。同时增加保障房供应，继续打击囤房、囤地，加大土地供应力度，缓解供给矛盾将是明年的另一条主线。另外，房产税试点政策明年出台的可能性也较大，如果实际政策力度符合预期，则可能引发阶段性行情；但房产税征收范围扩大或税率较高，则对于房地产市场以及股票市场均是较大打击。 ', '2011-01-04 13:57:50', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('137', '人盛巴厘天地N+1百变户型5500元/㎡起', '人盛巴厘天地N+1百变户型5500元/㎡起', null, null, null, '位于从化市太平神岗广从北路263号的人盛巴厘天地（资料、团购、论坛、二手）目前在售100-132平方米的三房单位，户型设计采用“N+1”百变户型，赠送空间高达15%，毛坯售价5500元/平方米起，最低首付只需12万元。', '2011-01-04 14:00:40', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('139', '花都雅居乐花园\"花间集\"二期6800元/㎡起', '花都雅居乐花园\"花间集\"二期6800元/㎡起', null, null, null, '位于花都区新华三东大道与茶碑路交汇处的花都雅居乐花园（资料、团购、论坛、二手）目前主要推售“花间集”二期单位，主要户型为100-131㎡的三至四房，毛坯均价6800元/平方米，带装修8000-9000元元/平方米，其中 100㎡的单位带装修交楼，127-131㎡的单位毛坯发售。 花间集所有户型均带7米观景阳台、空中花园、大面积入户花园。', '2011-01-04 14:01:24', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('141', '投资型公寓卡布奇诺1月底开盘', '投资型公寓卡布奇诺1月底开盘', null, null, null, '位于白云广州大道北同和华远厂路段的卡布奇诺（资料、团购、论坛、二手）将于1月底开盘，首期主推22-42㎡单身公寓和55㎡一房单位，预计均价13000-16000万元/平方米，带装修和家私家电，之前进行诚意登记的买家开盘可享受98折优惠，2011年8月可交楼。项目周边有吉之岛、乐购、广百、金逸国际电影城。', '2011-01-04 14:02:08', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('145', '君华香柏广场C栋19000元/㎡带装修', '君华香柏广场C栋19000元/㎡带装修', null, null, null, '位于白云区广州大道北与京溪路交汇处的君华香柏广场（资料、团购、论坛、二手）目前在售全新的C栋91-135平方米三房、四房“珍爱大宅”，均价19000元/平方米，带3500元/平方米装修。', '2011-01-04 14:02:48', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('147', '东方夏湾拿\"巴亚莫\"联排别墅10000元/㎡起', '东方夏湾拿\"巴亚莫\"联排别墅10000元/㎡起', null, null, null, '位于从化神岗镇广从公路莲塘桥的东方夏湾拿（资料、团购、论坛、二手）推出最新一期联排别墅“巴亚莫”组团，带首层老人房、中空客厅、独立天井设计，面积271-277平方米，五房三厅六卫设计，售价10000元/平米起。', '2011-01-04 14:04:12', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('150', '转让二手房 土地增值税猛涨十倍', null, null, null, null, '顺德区低调出台了一份《关于调整土地增值税预征率和核定征收率的公告（2010年第2号）》（以下简称《公告》），给楼市投出了一份“重磅炸弹”，本报在第一时间独家获知了该政策的内容。新政策规定，从2011年元旦起，顺德的纳税人转让普通二手住宅的，其土地增值税的核定征收率从原来的0.5%提高到5%，涨了整整十倍，二手房的置业门槛将再次被抬高', '2011-01-04 14:10:14', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('153', '二手房成交总体回落 五大城市再陷观望', null, null, null, null, '11月10日，中原集团发布二手住宅市场月报称，10月份，国内5大城市二手住宅市场再度陷入观望，成交量在持续4个月回升之后开始回落。总体来看，价格虽未出现下跌，但涨幅明显收窄', '2011-01-04 14:11:48', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('155', '索菲亚董事长柯建生:下一步终端网络要下沉', null, null, null, null, '柯建生：原来我们主要集中在一二线城市，一二线城市的布点通过几年的努力已经基本完成了，所以下一步准备在二三线城市布点，就是网络要下沉，要把网点铺的覆盖面更加广，因为毕竟是一个服务型的制造业。服务型制造业服务要到家，所以网点要适当的拓开。', '2011-01-04 14:14:31', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('156', '低碳环保旧物巧改收纳箱', '低碳环保旧物巧改收纳箱', null, null, null, null, '2011-01-04 14:14:35', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('157', '懒人必备的盘子餐桌', '懒人必备的盘子餐桌', null, null, null, 'Elad Kashi所设计的盘子餐桌，多了份自由、洒脱，吃饭时无需额外的盘子来承装食物，餐桌上凸凹有致的形状即可用来承装美味，吃完时将桌子擦拭干净即可，对于懒人来说很是实用。', '2011-01-04 14:15:22', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('158', '实木地板调价订单下滑 不调利润压缩', '实木地板调价订单下滑 不调利润压缩', null, null, null, '正值元旦佳节，但实木地板厂老板李伟俊却颇为烦恼，不断上涨的生产成本，让他左右为难。昨日，记者从部分实木地板生产企业处了解到，由于生产成本不断上涨，厂家纷纷上调地板出厂价，这直接导致订单下滑。', '2011-01-04 14:16:24', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('159', '12款简约时尚的客厅电视柜设计', null, null, null, null, '无论你每天面对电视的时间长短，一台电视机总还是家里的必备。平板电视的普及使得电视柜的样子也发生了很大变化，电视机与家具的融合度更高，因此在选择的时候需要考虑的细节也更多。', '2011-01-04 14:16:43', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('160', '“漂浮”在树梢的住家', null, null, null, null, '整座房屋可以说是完全颠倒过来建造，以天花板为水平，由上往下延伸一直到山坡面。建筑材料运用了水泥、钢筋以及木材，屋顶露台可以远眺大海以及山景，被树木以及自然生态包围，而且又符合环保。', '2011-01-04 14:17:54', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('161', '外部多重压力将影响未来整体衣柜发展', '外部多重压力将影响未来整体衣柜发展', null, null, null, '据悉，2010年下半年以来，衣柜企业整体销售形势不容乐观。不少企业下滑幅度高达60%，在一些主流卖场里，即使排名前十名的企业也未必能盈利。在这种情况下，企业纷纷打出了涨价牌，实属无奈之举。', '2011-01-04 14:18:34', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('172', '酷乐影音2010 1.0.3.6', '酷乐影音', null, null, null, '无需付费购买，到官方指定下载地址下载安装后即可以使用具有灵活点播的功能，随点随看，时间自由掌握操作简单，界面简洁明了掌握最先进的P2SP传输技术，传输速度更快，更节省带宽占用CPU、内存、带宽等系统资源占用少，不影响其它操作。 ', '2011-01-04 14:34:23', null, null, null, '0', null, 'http://img.duote.com/softImg/soft/25902_s.jpg', null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('173', '千千静听(TTPlayer) V5.7 BETA1', '千千静听', null, null, null, '千千静听是一款完全免费的音乐播放软件，拥有自主研发的全新音频引擎，集播放、音效、转换、歌词等众多功能于一身。其小巧精致、操作简捷、功能强大的特点，深得用户喜爱，被网友评为中国十大优秀软件之一，并且成为目前国内最受欢迎的音乐播放软件。', '2011-01-04 14:44:02', null, null, null, '0', null, 'http://ttplayer.qianqian.com/upload/100902/100902162707s.jpg', null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('174', '谷歌浏览器(Google Chrome) V6.0.447.0 Beta', '谷歌浏览器', null, null, null, 'Google Chrome(谷歌浏览器)是由Google开发的一款可让您更快速、轻松且安全地使用网络的浏览器，它的设计超级简洁，使用起来更加方便。', '2011-01-04 14:44:59', null, null, null, '0', null, 'http://img.duote.com/softImg/soft/5897_s.jpg', null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('175', '超级硬盘数据恢复软件 V2.3.1.1 ', '硬盘数据恢复软件', null, null, null, '超级硬盘数据恢复软件是一款简单易用且功能强大的数据恢复软件，可以恢复被删除、被格式化、分区丢失、重新分区或者分区提示格式化的数据。采用了最新的数据扫描引擎，以只读的方式从磁盘底层读出原始的扇区数据，经过高级的数据分析算法，扫描后把丢失的目录和文件在内存中重新建立出原先的分区和原先的目录结构，数据恢复的效果非常好。', '2011-01-04 14:46:00', null, null, null, '0', null, 'http://img.duote.com/softImg/soft/6732_s.jpg', null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('195', '标签公用属性', '标签公用属性', null, null, null, null, '2011-06-18 15:36:14', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('196', 'asdfsadf', null, null, null, null, 'asdfsadf', '2011-06-18 15:49:41', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('197', 'ffff', null, null, null, null, null, '2011-06-18 15:51:47', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('198', '后台教程之采集管理', null, null, null, null, null, '2011-06-18 18:25:51', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('199', '汕头市住房和城乡建设局主要职责asdasdasdasddsadsaasdasd aasdsffa', '简短标题', 'asdf', null, null, '摘要', '2011-06-20 10:06:23', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('200', '汕头市建设局办事“二次终结”制度', '汕头市建设', null, null, null, null, '2011-06-20 10:08:08', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('201', '汕头市建设局首问责任制', null, null, null, null, null, '2011-06-20 10:08:57', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('202', '汕头市建设局政务公开工作监督措施', null, null, null, null, null, '2011-06-20 10:09:50', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('203', '门窗幕墙行业要走系统集成之路', null, null, null, null, null, '2011-06-20 10:10:32', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('204', '保障房建设资金短缺难题待解', null, null, null, null, null, '2011-06-20 10:11:05', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('205', '佛山将首套房的最低首付提高到四成', null, null, null, null, null, '2011-06-20 10:11:33', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('206', '关于转发省住建厅产业转型升级突破点工作方案的通知', null, null, null, null, null, '2011-06-20 10:12:16', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('207', '省住房城乡建设厅规划处处长邱衍庆作汶川特大地震抗震救灾和恢复重建先进事迹报告', null, null, null, null, '5月6日上午，由中宣部、国家发改委、解放军总政治部和四川省委共同组织的汶川特大地震抗震救灾和恢复重建先进事迹报告会在省委礼堂隆重举行。报告团由省住房城乡建设厅规划处处长邱衍庆、四川重灾区映秀镇党委书记廖军、陕西省宁强县广坪镇党委书记李阳、成都军区联勤部川藏兵站部副部长敖斌、中国东方电气集团东汽党委书记何显富和甘肃省康县阳坝镇党委书记范登奎等9人组成。会前，省委副书记、省长黄华华，省委常委、宣传部长林雄，省政府党组成员、省扶贫开发领导小组副组长李容根，省军区副政委黄善春等领导同志亲切会见了报告团全体成员。', '2011-06-20 10:12:56', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('208', '关于表彰2010年度汕头市住房和城乡建设 ', null, null, null, null, null, '2011-06-20 10:14:56', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('209', '乘势而上 加快发展 开创全市建设工作新局面 ', null, null, null, null, null, '2011-06-20 10:15:35', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('210', '汕头市绿道网总体规划结构', null, null, null, null, null, '2011-06-20 10:16:19', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('211', '汪洋同志关于建设宜居城乡的论述', null, null, null, null, null, '2011-06-20 10:16:45', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('212', '建设之光', null, null, null, null, null, '2011-06-20 10:17:30', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('213', '机构设置与职责', null, null, null, null, null, '2011-06-20 10:18:12', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('214', '家有关建设行政管理的方针、政策和法律、法规、规章。', null, null, null, null, null, '2011-06-20 10:18:35', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('215', '近闻名的“建', null, null, null, null, null, '2011-06-20 10:19:57', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('216', '建筑之乡', null, null, null, null, null, '2011-06-20 10:21:47', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('217', '向型为主', null, null, null, null, null, '2011-06-20 10:22:16', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('218', '设置与职责', null, null, null, null, null, '2011-06-20 10:26:03', '/u/cms/www/201507/221900285ay4.flv', 'FLASH', null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('219', '公告', null, null, null, null, null, '2011-06-20 10:27:34', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('220', '公告2', null, null, null, null, null, '2011-06-20 10:28:12', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('221', '广厦新城红荔园二期工程监理', null, null, null, null, null, '2011-06-20 10:29:30', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('222', '岐山北工业区10kv开关站', null, null, null, null, null, '2011-06-20 10:30:06', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('223', '10kv开关站 ', null, null, null, null, null, '2011-06-20 10:31:02', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('224', '开关站 ', null, null, null, null, null, '2011-06-20 10:32:10', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('225', '广厦新城红荔园二期工程监理', null, null, null, null, null, '2011-06-20 10:32:40', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('226', '汕头市特殊教育学校第一期建设项目工程', null, null, null, null, null, '2011-06-20 10:33:09', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('227', '广厦新城红荔园二期工程监理', null, null, null, null, null, '2011-06-20 10:33:49', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('228', '工程监理', null, null, null, null, null, '2011-06-20 10:34:11', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('229', '广厦新城红荔园二期工程监理', null, null, null, null, null, '2011-06-20 10:34:38', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('230', '红荔园二期工程监理 ', null, null, null, null, null, '2011-06-20 10:34:59', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('231', '汕头经济特区林百欣中学建设教学综合楼（林百欣先生纪念馆）项目', null, null, null, null, null, '2011-06-20 10:35:31', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('232', '标文件的', null, null, null, null, null, '2011-06-20 10:36:04', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('233', '粤东高级技工学校学生宿舍及室外体育场建设项目', null, null, null, null, null, '2011-06-20 10:36:32', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('234', '东南雅建筑工程', null, null, null, null, null, '2011-06-20 10:36:55', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('235', '校学生宿舍及室外体育场', null, null, null, null, null, '2011-06-20 10:37:20', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('236', '电气安装、给', null, null, null, null, null, '2011-06-20 10:37:36', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('237', '建设局，中心城区各燃气企业： ', null, null, null, null, null, '2011-06-20 10:38:44', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('238', '局、物价局《关', null, null, null, null, null, '2011-06-20 10:39:11', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('239', '制定本方', null, null, null, null, null, '2011-06-20 10:39:41', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('240', '牌推广', null, null, null, null, null, '2011-06-20 10:40:26', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('241', '头市龙翔石油气有限公司', null, null, null, null, null, '2011-06-20 10:40:47', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('242', '季节是市民使用燃气器具不当', null, null, null, null, null, '2011-06-20 10:41:23', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('243', '定要保持', null, null, null, null, null, '2011-06-20 10:41:39', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('244', '燃气是液态石油气经过气化', null, null, null, null, null, '2011-06-20 10:42:23', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('245', '汕头新奥燃气有限公司服务指南', null, null, null, null, null, '2011-06-20 10:43:11', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('246', '业厅地址：', null, null, null, null, null, '2011-06-20 10:43:25', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('247', '中华人民共和国物权法', null, null, null, null, null, '2011-06-20 10:44:11', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('248', ' 一般规定 ', null, null, null, null, null, '2011-06-20 10:44:28', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('249', ' 一般规定 ', null, null, null, null, null, '2011-06-20 10:44:54', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('250', ' 一般规定 ', null, null, null, null, null, '2011-06-20 10:45:17', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('251', '担保物权', null, null, null, null, null, '2011-06-20 10:45:49', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('252', '物权', null, null, null, null, null, '2011-06-20 10:46:10', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('253', '般规定 ', null, null, null, null, null, '2011-06-20 10:46:38', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('254', '规定 ', null, null, null, null, null, '2011-06-20 10:47:01', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('255', '关于印发汕头建设网信息发布管理规定的通知', null, null, null, null, null, '2011-06-20 10:47:38', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('256', '　汕头市建设局', null, null, null, null, null, '2011-06-20 10:47:54', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('257', '网发布', null, null, null, null, null, '2011-06-20 10:48:11', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('258', '于对汕头市顺泰房产开发有限公司等29家企业不予换发房地产开发资质证书的决定', null, null, null, null, null, '2011-06-20 10:48:46', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('259', '产开发公司 ', null, null, null, null, null, '2011-06-20 10:48:56', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('260', '房地产开发企业三级及三级以下资质核准办事指南', null, null, null, null, null, '2011-06-20 10:49:23', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('261', '进一步加', null, null, null, null, null, '2011-06-20 10:49:38', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('264', '统计的范围', null, null, null, null, null, '2011-06-20 10:51:25', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('265', '设行业', null, null, null, null, null, '2011-06-20 10:51:39', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('266', '建设行业职工', null, null, null, null, null, '2011-06-20 10:52:03', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('267', '建设行业职工', null, null, null, null, null, '2011-06-20 10:52:17', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('268', '区（县）建设局、市直建筑业各有关单位： ', null, null, null, null, null, '2011-06-20 10:52:38', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('269', '及渠道 ', null, null, null, null, null, '2011-06-20 10:52:57', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('270', '硒鼓', null, null, null, null, null, '2011-06-20 10:53:31', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('271', '寺院', null, null, null, null, null, '2011-06-20 10:53:45', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('272', '寺工', null, null, null, null, null, '2011-06-20 10:54:41', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('273', '式的', null, null, null, null, null, '2011-06-20 10:54:49', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('274', '墳地方', null, null, null, null, null, '2011-06-20 10:55:03', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('275', '多我', null, null, null, null, null, '2011-06-20 10:55:20', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('276', '堵截', null, null, null, null, null, '2011-06-20 10:55:33', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('277', '堵截', null, null, null, null, null, '2011-06-20 10:55:41', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('278', '禾苗', null, null, null, null, null, '2011-06-20 10:55:59', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('279', '载体', null, null, null, null, null, '2011-06-20 10:56:08', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('280', '昌了', null, null, null, null, null, '2011-06-20 10:56:18', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('281', '昌了', null, null, null, null, null, '2011-06-20 10:56:19', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('282', '昌了', null, null, null, null, null, '2011-06-20 10:56:19', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('283', '和我', null, null, null, null, null, '2011-06-20 10:56:33', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('284', '和我', null, null, null, null, null, '2011-06-20 10:56:33', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('285', '1111111111111111111111111111111111111', '222', '111', null, null, '22222222222222222222222', '2011-06-20 18:55:43', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('286', 'ssssssssssssssssssssssssssssssssss', null, null, null, null, null, '2011-06-20 19:20:44', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('287', 'gfdgdsg', null, null, null, null, 'fdsdf', '2011-06-29 09:27:38', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('288', 'dfdf', null, null, null, null, 'fffffffffff', '2011-06-29 09:28:30', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('289', 'sdafasdf', 'sdfasdf', null, null, null, 'sadfsadf', '2011-06-29 17:45:30', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('290', 'ffffffff', null, null, null, null, 'ffffffffff', '2011-06-29 17:45:41', null, null, null, '0', null, null, null, null, null, '1');
INSERT INTO `jc_content_ext` VALUES ('291', 'aaaaaaaaaaaaaaaaaa', 'aaaaaa', null, null, null, null, '2015-07-22 19:08:10', '/cms/u/cms/www/201507/27233233ayzb.mp4', 'FLASH', null, '0', null, null, null, null, null, '1');

-- ----------------------------
-- Table structure for `jc_content_group_view`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_group_view`;
CREATE TABLE `jc_content_group_view` (
  `content_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`group_id`),
  KEY `fk_jc_content_group_v` (`group_id`),
  CONSTRAINT `fk_jc_content_group_v` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_content_v` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容浏览会员组关联表';

-- ----------------------------
-- Records of jc_content_group_view
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_content_picture`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_picture`;
CREATE TABLE `jc_content_picture` (
  `content_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL COMMENT '排列顺序',
  `img_path` varchar(100) NOT NULL COMMENT '图片地址',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`content_id`,`priority`),
  CONSTRAINT `fk_jc_picture_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容图片表';

-- ----------------------------
-- Records of jc_content_picture
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_content_share_check`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_share_check`;
CREATE TABLE `jc_content_share_check` (
  `share_check_id` int(11) NOT NULL AUTO_INCREMENT,
  `content_id` int(11) NOT NULL COMMENT '共享内容',
  `channel_id` int(11) NOT NULL COMMENT '共享栏目',
  `check_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态 0待审核 1审核通过 2推送',
  `check_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  `share_valid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '共享有效性',
  PRIMARY KEY (`share_check_id`),
  KEY `fk_channel_jc_content_share` (`channel_id`),
  KEY `fk_check_jc_content_share` (`content_id`),
  CONSTRAINT `fk_channel_jc_content_share` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_check_jc_content_share` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS共享内容审核信息表';

-- ----------------------------
-- Records of jc_content_share_check
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_content_tag`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_tag`;
CREATE TABLE `jc_content_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(50) NOT NULL COMMENT 'tag名称',
  `ref_counter` int(11) NOT NULL DEFAULT '1' COMMENT '被引用的次数',
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `ak_tag_name` (`tag_name`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COMMENT='CMS内容TAG表';

-- ----------------------------
-- Records of jc_content_tag
-- ----------------------------
INSERT INTO `jc_content_tag` VALUES ('1', '2011', '2');
INSERT INTO `jc_content_tag` VALUES ('2', '中国', '1');
INSERT INTO `jc_content_tag` VALUES ('3', '货币', '0');
INSERT INTO `jc_content_tag` VALUES ('4', '信贷', '0');
INSERT INTO `jc_content_tag` VALUES ('5', '楼市', '1');
INSERT INTO `jc_content_tag` VALUES ('6', '限购令', '0');
INSERT INTO `jc_content_tag` VALUES ('7', '人民币', '0');
INSERT INTO `jc_content_tag` VALUES ('8', '升值', '0');
INSERT INTO `jc_content_tag` VALUES ('9', '机构', '0');
INSERT INTO `jc_content_tag` VALUES ('10', 'CPI', '0');
INSERT INTO `jc_content_tag` VALUES ('11', '回落', '0');
INSERT INTO `jc_content_tag` VALUES ('12', '资金', '0');
INSERT INTO `jc_content_tag` VALUES ('13', '净流出', '0');
INSERT INTO `jc_content_tag` VALUES ('14', '桑德', '0');
INSERT INTO `jc_content_tag` VALUES ('15', '投“靶”', '0');
INSERT INTO `jc_content_tag` VALUES ('16', '基金', '0');
INSERT INTO `jc_content_tag` VALUES ('17', '资管', '0');
INSERT INTO `jc_content_tag` VALUES ('18', '回报', '0');
INSERT INTO `jc_content_tag` VALUES ('19', 'A股', '0');
INSERT INTO `jc_content_tag` VALUES ('20', '债基', '0');
INSERT INTO `jc_content_tag` VALUES ('21', '绩效', '0');
INSERT INTO `jc_content_tag` VALUES ('22', '上市', '0');
INSERT INTO `jc_content_tag` VALUES ('23', '年前', '0');
INSERT INTO `jc_content_tag` VALUES ('24', '加仓', '0');
INSERT INTO `jc_content_tag` VALUES ('25', '寻找', '0');
INSERT INTO `jc_content_tag` VALUES ('26', '生财之道', '0');
INSERT INTO `jc_content_tag` VALUES ('27', '理财', '0');
INSERT INTO `jc_content_tag` VALUES ('28', '赚钱', '0');
INSERT INTO `jc_content_tag` VALUES ('29', '个税', '0');
INSERT INTO `jc_content_tag` VALUES ('30', '改革', '1');
INSERT INTO `jc_content_tag` VALUES ('31', '政策', '3');
INSERT INTO `jc_content_tag` VALUES ('32', '2010', '0');
INSERT INTO `jc_content_tag` VALUES ('33', '美元', '0');
INSERT INTO `jc_content_tag` VALUES ('34', '欧元', '0');
INSERT INTO `jc_content_tag` VALUES ('35', '财险', '0');
INSERT INTO `jc_content_tag` VALUES ('36', '保费', '0');
INSERT INTO `jc_content_tag` VALUES ('37', '周鸿祎', '0');
INSERT INTO `jc_content_tag` VALUES ('38', '英雄', '0');
INSERT INTO `jc_content_tag` VALUES ('39', '商人', '0');
INSERT INTO `jc_content_tag` VALUES ('40', '汤玉祥', '0');
INSERT INTO `jc_content_tag` VALUES ('41', '轿车', '0');
INSERT INTO `jc_content_tag` VALUES ('42', 'Facebook', '0');
INSERT INTO `jc_content_tag` VALUES ('43', '投资', '0');
INSERT INTO `jc_content_tag` VALUES ('44', '新年', '0');
INSERT INTO `jc_content_tag` VALUES ('45', '李开复', '0');
INSERT INTO `jc_content_tag` VALUES ('46', '李瑜', '0');
INSERT INTO `jc_content_tag` VALUES ('47', '王建硕', '0');
INSERT INTO `jc_content_tag` VALUES ('48', '网站', '0');
INSERT INTO `jc_content_tag` VALUES ('49', '规模化', '0');
INSERT INTO `jc_content_tag` VALUES ('50', '沈阳', '1');
INSERT INTO `jc_content_tag` VALUES ('51', '房价', '1');
INSERT INTO `jc_content_tag` VALUES ('52', '调控', '2');
INSERT INTO `jc_content_tag` VALUES ('53', '房产税', '1');
INSERT INTO `jc_content_tag` VALUES ('54', '分歧', '1');
INSERT INTO `jc_content_tag` VALUES ('55', '评估', '1');
INSERT INTO `jc_content_tag` VALUES ('56', '房产', '1');
INSERT INTO `jc_content_tag` VALUES ('57', '成交', '1');
INSERT INTO `jc_content_tag` VALUES ('58', '房地产', '1');
INSERT INTO `jc_content_tag` VALUES ('59', '策略', '1');
INSERT INTO `jc_content_tag` VALUES ('60', '户型', '1');
INSERT INTO `jc_content_tag` VALUES ('61', '花都雅居乐花园', '1');
INSERT INTO `jc_content_tag` VALUES ('62', '卡布奇诺', '1');
INSERT INTO `jc_content_tag` VALUES ('63', '公寓', '1');
INSERT INTO `jc_content_tag` VALUES ('64', '君华香柏广场', '1');
INSERT INTO `jc_content_tag` VALUES ('65', '巴亚莫', '1');
INSERT INTO `jc_content_tag` VALUES ('66', '别墅', '1');
INSERT INTO `jc_content_tag` VALUES ('67', '低碳', '1');
INSERT INTO `jc_content_tag` VALUES ('68', '收纳箱', '1');
INSERT INTO `jc_content_tag` VALUES ('69', '餐桌', '1');
INSERT INTO `jc_content_tag` VALUES ('70', '地板', '1');
INSERT INTO `jc_content_tag` VALUES ('71', '订单', '1');
INSERT INTO `jc_content_tag` VALUES ('72', '利润', '1');
INSERT INTO `jc_content_tag` VALUES ('73', '衣柜', '1');
INSERT INTO `jc_content_tag` VALUES ('74', '重压力', '1');
INSERT INTO `jc_content_tag` VALUES ('75', 'ff', '1');
INSERT INTO `jc_content_tag` VALUES ('76', 'Tag标签', '1');
INSERT INTO `jc_content_tag` VALUES ('77', 'sdfsa', '1');
INSERT INTO `jc_content_tag` VALUES ('78', 'sdf', '1');

-- ----------------------------
-- Table structure for `jc_content_topic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_topic`;
CREATE TABLE `jc_content_topic` (
  `content_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`topic_id`),
  KEY `fk_jc_content_topic` (`topic_id`),
  CONSTRAINT `fk_jc_content_topic` FOREIGN KEY (`topic_id`) REFERENCES `jc_topic` (`topic_id`),
  CONSTRAINT `fk_jc_topic_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS专题内容关联表';

-- ----------------------------
-- Records of jc_content_topic
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_content_txt`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_txt`;
CREATE TABLE `jc_content_txt` (
  `content_id` int(11) NOT NULL,
  `txt` longtext COMMENT '文章内容',
  `txt1` longtext COMMENT '扩展内容1',
  `txt2` longtext COMMENT '扩展内容2',
  `txt3` longtext COMMENT '扩展内容3',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_txt_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容文本表';

-- ----------------------------
-- Records of jc_content_txt
-- ----------------------------
INSERT INTO `jc_content_txt` VALUES ('123', '<p>今年房价会降吗?热议中的房产税能否推出?还会有几次加息?会不会有新一轮调控政策出台?在尚不明朗的房价走势下，你会不会买房?</p>\r\n<p>　　在采访中，无论是开发商、中介经纪人，还是普通市民，普遍认为新一年楼市调控政策仍将持续，但对于调控效果各有不同看法，认为房价将随调控下降的看法并不占多。</p>\r\n<p>　　一家开发公司的负责人认为，今年楼市调控将呈常态化，但政策的影响只能具体情况具体分析，把沈阳和北上广等一线城市等同看待，对政策的影响度不加区分，显然是不客观的。以沈阳楼市刚需占绝对主体的情况来看，沈阳今年房价仍会保持稳中有升。</p>\r\n<p>　　而有意今年买房的崔先生表示，他也看不懂政策的作用和效果，&ldquo;越调越涨的怪圈弄得大家很郁闷，只能走一步看一步了&rdquo;。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('125', '<p>一些地方楼市调控政策近期陆续出台。与北京调控政策的严厉程度相比，其他地方楼市新政则显得&ldquo;和风细雨&rdquo;，力度&ldquo;温和&rdquo;。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;4月末，北京市率先推出细则，除强调坚决遏制住房价格过快上涨、加强住房保障工作、增加住房用地有效供应、实行更加严格的差别化住房信 贷政策、抑制投机性购房之外，明确提出商业银行根据风险状况暂停发放第三套及以上住房和不能提供1年以上北京市纳税证明或社会保险缴纳证明的非本市居民购 房贷款。</p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" align=\"left\">\r\n    <tbody>\r\n        <tr>\r\n            <td valign=\"top\">&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<p>北京细则中最为严厉的要数&ldquo;限购令&rdquo;，即同一购房家庭只能新购买一套商品住房。这使得北京细则成为各地楼市调控细则中力度最大的。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;青岛和深圳等地出台的细则虽然没有明确限制家庭购房套数，但对三套房贷款问题都作出了规定，基本按照国家政策上限执行。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;深圳版楼市调控细则要求对购买不同套数住房家庭（包括借款人、配偶及未成年子女）实行差别化信贷政策，限制各种名目的炒房和投机性购 房；商业银行根据风险状况，暂停发放购买第三套房以上住房贷款；对不能提供1年以上深圳市纳税证明或社会保险缴纳证明的非本地居民暂停发放购买住房贷款。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;青岛版细则也要求实行更为严格的差别化住房信贷政策，商业银行可停发第三套房贷款，对不能提供1年以上当地纳税证明或社会保险缴纳证明的非本地居民暂停发放购买住房贷款。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;相比之下，随后出台的广州、重庆等地细则更加&ldquo;缓和&rdquo;，不仅没有明确限制家庭购房套数，对于三套房贷款也没有明确规定。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;广州版细则从8个方面提出24条措施，重点放在增加有效供给、加强住房保障等供应端的调控上。重庆版细则也未对二套房认定和三套房贷款作出明确规定，仅提出对贷款购买第三套及以上住房的，贷款首付比例和贷款利率大幅度提高，政策执行力度较为宽松。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;总体来看，各地出台的细则都遵照了新&ldquo;国十条&rdquo;定下的基调，提出增加供给、加强保障房建设、实行差别化住房信贷政策、抑制投机性购房等，但政策力度不一。目前，尚未公布的上海和杭州楼市调控细则成为市场关注的热点。（记者 于萍）</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp; <b> 楼市严厉调控难以穿越地方&ldquo;温柔怀抱&rdquo;？</b></p>\r\n<p>　&nbsp;一个多月前开始的狂风骤雨般的房地产调控似乎正逐渐向和风细雨转变。继北京出台&ldquo;严厉&rdquo;的房产新政细则之后，上周五广州、重庆同日出台细则，加上此前的深圳，三地的细则都被冠上了&ldquo;温和&rdquo;的定语。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp; <b>北京 供需方均观望</b></p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;作为房地产调控政策最为严厉的城市，北京近一个月来商品房销售持续&ldquo;冰封&rdquo;，供需双方均陷入深度观望。&ldquo;由于市场原因，原定于5月下旬开盘的公寓项目将延期，价格待定。&rdquo;位于北京东三环边的&ldquo;首城国际&rdquo;项目销售人员告诉中国证券报记者。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;目前，受蓄客量不足等因素影响，北京不少新盘项目推迟开盘日期。开发商的观望直接导致楼市新增供应量锐减。&ldquo;北京对各项调控政策的执行很严格，加之成交量大幅萎缩，预计房价将维持下行趋势。&rdquo;21世纪不动产一位分析师表示。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;<b>6月入市项目锐减</b></p>\r\n<p>&nbsp;&nbsp;亚豪机构监测数据显示，6月份，北京将有32个项目入市销售。其中，首次开盘的纯新盘项目9个，包括中建&middot;府前观邸、丽都壹号、蓝光&middot;云鼎、紫御国际、保利茉莉公馆等，其余23个项目是老项目后期开盘。这与四五月份北京新盘入市量的均值相比下滑近40%。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;业内人士指出，4月份以来出台的一系列调控政策不仅导致楼市成交量大幅下跌，也改变了房价上涨的预期，不但购房者出现了明显的观望，开 发商也放缓推盘步伐。在6月即将开盘的32个项目中，能明确开盘价格的项目仅11个。不过，有七成以上的项目，开发商表示新盘定价不会高于周边市场价。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;亚豪机构副总经理高姗分析，北京调控政策出台后，取得预售许可或者办理现房销售备案的房地产开发项目，要在3日内一次性公开全部销售房 源，并严格按照申报价格明码标价对外销售。6月份拟开盘的项目多数为老盘后期，而不少项目前期定价过高，导致项目后期的开盘价缺乏回旋余地。另外，当前市 场变化较快，给开发商销售策略增加很大的难度。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;<b>房价结构性回落</b></p>\r\n<p>&nbsp;&nbsp;北京市房地产交易管理网的数据显示，5月1日-18日，北京共有13个项目开盘，新增房源3129套，新增面积31.25万平方米，比4月同期分别减少47.6%和29.8%。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;5月1日-18日，扣除保障性住房，北京商品住宅期房和现房累计成交2673套，成交面积30.47万平方米，分别比4月同期减少55.9%、65.6%；成交均价为17244元/平方米，比4月同期明显下跌。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;高姗指出，5月份，北京商品住宅成交均价结构性回落趋势更为明显。具体来看，五环外房源的成交均价下降更为显著。通州、望京等地商品房的成交均价较前期高点已下降近15%。四环内新盘也已停涨。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;5月以来，五环内开盘项目占总量的30.8%，4月同期则为20.8%。业内人士指出，5月份北京城区新盘供应占比明显增加，而整体均价未出现上调。这表明开发商的房价预期开始松动。（记者 林喆）</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp; 房产税悬疑</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;&ldquo;快点出来吧，别再折磨我了！&rdquo;80后的邵灵豪一直在等待上海楼市新政出台。他想买房，想知道房产税会不会出现在上海新政中，但每天各种消息搞得他很疲惫。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;市场曾传言5月底上海出台细则，现在又传推迟到6月。而在5月24日，上海房产税悬疑剧迎来一个小高潮。24日中午，上海易居房地产研 究院综合研究部部长杨红旭在微博上写道：&ldquo;上海楼市细则近两日将出，据称比较严厉，可能对市场产生较大负面影响。不过我个人认为，在其它城市细则越出越温 和的情况下，上海细则严厉程度不一定会超过北京。&rdquo;杨红旭的爆料随即引来众多网友和业内人士的关注。大约两小时之后，一则更为重磅的信息出现在了杨红旭的 微博上&mdash;&mdash;&ldquo;最新消息，将要出台的细则包括房产税，天呀，地产股又要跌了，大家快逃命。&rdquo;这一&ldquo;猛料&rdquo;立即引来诸多回应，其中不少人表示&ldquo;难以置信&rdquo;。仅 仅数分钟后，这条微博被推荐至新浪房产微博首页。最吸引眼球的是15时11分的微博：&ldquo;据悉，上海楼市细则明天发布。&rdquo;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;如果24日的剧情是杨红旭个人微博的发布，那么25日的剧情就是毫无出处的传言：&ldquo;今天下午上海将宣布开收房产税。新购房以0.6%征收。不出意外，3点左右将发布。&rdquo;受此影响，A股房地产板块午后加速下跌，盘中最大跌幅达3.47%。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;房产税传言像病毒发作一样，通过QQ、MSN、论坛、手机、微博等多种媒介传播。中国证券报记者25日下午在绿地集团采访，采访对象突然打断采访说：&ldquo;等一下，已经3点了，我看一下细则出来没有。&rdquo;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;其实，25日下午2时许，上海相关主管部门已经辟谣：仍未明确上海版楼市细则的发布时间表。杨红旭对中国证券报记者说，现在看来，细则出台的消息确实不属实，他也是听媒体朋友说的。他说，房地产业没有百分百准确的消息，至于准确程度的高低，大家等细则出来就知。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;不光是想买房的邵灵豪们在纠结中等待，媒体记者们的神经也处于高度紧张状态。房地产记者见到采访对象就问&ldquo;上海细则什么时候出&rdquo;、&ldquo;有 房产税吗&rdquo;。一名上海本地记者自嘲自己像祥林嫂一样，快得强迫症了。中国证券报记者25日一直等到深夜12点，但上海并没有公布任何有关楼市新政的消息。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;开发商也在四处打听消息。中国证券报记者25日遇到上海金叠房地产开发有限公司副总经理乐雨明，他向中国证券报记者打听地产政策走向以及行业前景。他们在等上海细则出台，以决定开盘策略。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;上海弘基企业集团副总裁高栋在微博上爆料称：前个星期，一开发商突然叫停旗下所有正在打桩的项目，静待新政细则出台，等半天等来了&ldquo;房产税三年免谈&rdquo;，非常高兴，通知全面恢复打桩，继续深挖洞。后来得知这消息不属实，晚上开会准备再次叫停。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;不仅地产商，山东一地级市官员告诉中国证券报记者，他们也在等待上海细则，或许会传递某种信号。一些人士分析，重庆之前称将开征&ldquo;特别房产税&rdquo;，但细则实际上比较温和，这已引起业内关注。作为高房价的代表城市，上海在调控尺度上将如何把握有着标杆意义。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;上海区县一级官员也在等待细则。上海松江区分管土地、住房的副区长陈猛表示，不知道细则什么时候出，曾经说是5月底，但政策内容没有征求过区县的意见。(记者 周文天)</p>\r\n<p>&nbsp;</p>\r\n<p>　　<b>上海 成交低位徘徊</b></p>\r\n<p>&nbsp;&nbsp;持续4周大幅下滑的上海商品住宅成交量上周止跌回升，但仍在历史低位徘徊。南京、杭州楼市成交则继续低迷。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;<b>上海 成交低迷</b></p>\r\n<p>&nbsp;&nbsp;佑威房地产研究中心及楼市专评网联合提供的数据显示，在5月17日-5月23日这一周，上海市商品住宅成交面积为7.6万平方米，相比 前周6.0万平方米的低谷，回升27%，但依然只相当于年均水平的1/4；商品住宅成交均价为19204元/平方米，比前周下跌了16%，这是新政出台以 来，上海周均价首次低于2万元。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;佑威房地产研究中心副主任陆骑麟分析，上周均价低于2万元的楼盘成交量为5.6万平方米，包揽成交面积榜前十名，占总成交量近3/4；每平方米5万元以上的高端楼盘，成交量出现腰斩，最终导致成交均价走低。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;在最近6周时间里，开发商共推出159万平方米的商品住宅房源，同期成交量只有84.7万平方米，这意味着过去一个半月里有74.3万 平方米的房源滞销。对此，中国房产信息集团分析师薛建雄认为，前几周因为高端项目赶在行情还没降温前上市成交，推高了价格，但随着高端项目成交比重下滑和 新上市房源价格回调，楼市成交均价大幅下滑。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;<b>宁杭 价滞量缩</b></p>\r\n<p>&nbsp;&nbsp;谨慎、再谨慎，成为南京和杭州楼市的关键词。买房人下手谨慎，开发商卖房也谨慎。据365地产家居网统计，截至5月23日，南京仅有21个楼盘将在6月份推出新房源。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;浙江杭州主城区在5月前23天共成交835套房源。而在去年5月份，杭州主城区成交量历史性地突破万套大关，达10058套，日均342.5套。相比去年5月同期，主城区成交量下跌近九成。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;杭州开发商纷纷延迟开盘以&ldquo;静观其变&rdquo;，5月杭州主城区住宅可售房源大部分时间徘徊在5000套之下。截至目前，5月杭州仅有6个楼盘开盘。而在4月中旬房地产新政出台前一周，杭州有12个楼盘集中开盘。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;尽管南京、杭州楼市成交低迷，但价格仍然高企。新政之后，市场对价格的预期普遍降低，而开发商仍将价格定在新政之前的水平。买卖双方的预期出现差异，造成楼市深陷僵局。（记者 周文天）</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;<b>深圳 看空仍是主流</b></p>\r\n<p>&nbsp;&nbsp;在观望气氛中，深圳一些价格明显下调的楼盘取得了不错的销售业绩。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;<b>低价楼盘受青睐</b></p>\r\n<p>&nbsp;&nbsp;根据深圳房地产信息网监测，5月17日-23日这一周新房成交量继续萎缩，仅成交225套住宅，环比下跌34.4%；成交面积 17464平方米，环比下跌四成。不过，成交均价高位运行，为21504元/平方米。二手房成交量同样继续回落，当周深圳市二手房共成交3230套，环比 下跌一成；成交面积31.25万平方米，环比微跌2.8%。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;但5月份以来，不时有新盘传出销售佳绩，尤其是那些开盘价大幅低于市场预期的小户型楼盘。5月16日，华侨城旗下公寓侨城馨苑开盘，起 价逾1.8万元/平方米，均价2.5-2.6万元/平方米，由于低于均价可能超过3万元的市场预期，当天成交积极，一天售出170多套。位于前海的丽湾商 务公寓，因为开盘价格大大低于同区域楼盘，在淡市中表现出色，5月17日-23日这一周以4026.98平方米、90套的周成交量取得了深圳楼盘成交冠 军，远远高于第二名的11套周销量。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;&ldquo;刚性需求正在支撑市场。&rdquo;世华地产总监肖小平表示，这部分刚需包括了首次置业和改善型需求，这类需求比较坚挺。中国证券报记者注意到，侨城馨苑单价在3万以上的房屋几乎无人问津，表明首次置业者仍占据主流。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;&ldquo;最近一次性付款的客户比例大幅增加。&rdquo;新近开盘的大户型楼盘第五大道代理商表示，付全款客户的比例之高甚至让他们感到吃惊。而丽湾商务公寓的销售人员称，该楼盘小户型总价低，相对较低的门槛为付全款客户接受，一次性付款的客户接近四成。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;中原地产市场总监王世界表示，一方面通胀预期强化，国内的投资渠道太少，另一方面楼市长期利好依然存在，而深圳细则又偏&ldquo;软&rdquo;，从而为投资型购房者对楼市未来增强了信心。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;<b>新盘优惠进行中</b></p>\r\n<p>&nbsp;&nbsp;在现在的市场大环境下，深圳不少新盘定价非常谨慎，并且推出了不少优惠措施。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;莱蒙&middot;水榭春天2期5月22日开盘，推出中心园景大户型房屋，开盘当天成交的客户，可享受9.7&times;9.8折的优惠折扣。折算其他优惠措 施后，总体打折幅度在9.4折至9折之间，折后售价约为1.8万-2.3万元/平方米。这比之前开盘的同区域新盘曼海宁有所下调。开盘当天所有成交业主可 获赠拥有20年使用权的车位一个。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;推出优惠措施的盐田区金山碧海楼盘在售均价17000元/平方米，170平方米山海楼王总价280万元/套起，目前购买部分特定单位可 以赠送20万至38万元装修款。龙岗区的君悦龙庭三期在售户型为160平方米以上5至6房大户单位，在售价格为11000-15000元/平方米，附赠送 面积共可达200平方米以上。目前购房可再享96折优惠。（记者 万晶）</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>　　<b>重庆 继续缩量盘整</b></p>\r\n<p>&nbsp;&nbsp;目前，重庆楼市观望氛围依然浓郁，但&ldquo;特别房产消费税&rdquo;等严厉调控政策最终未在重庆房地产调控政策中出现，且重庆的细则依然鼓励普通商品房需求。分析人士认为，这可能会增强开发商的定价信心，市场成交量也有望上升。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;房地产交易管理系统数据显示，5月17日至23日，重庆主城九区楼市成交总套数为2459套，总成交金额为12.03亿元，成交总面积22.85万平方米，这三项数据均创下近八周以来的新低。但成交均价在前一周4523元/平方米的基础上，回升至5265元/平方米。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;总体而言，重庆新盘的销售状况仍不理想，开盘第一周的销售率普遍很低。据不完全统计，5月17日至23日，重庆市主城区共有6个项目推 出新盘，共计1637套房源，总面积约11.32万平方米，但开盘当天的认购率勉强达到10%。而&ldquo;春语江山&rdquo;项目开盘当天推出271套，当天认购率为 5.17%。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;业内人士介绍，目前重庆市区的房价为4000-5000元/平方米，且从去年以来，房价上涨缓慢。国家统计局数据显示，今年4月，重庆 市房价环比涨幅为0.5%，远低于全国平均水平，更低于同期京沪等一线城市。今年以来，重庆商品房日均成交量维持在450套至600套之间，略低于去年底 的成交水平。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;重庆土地市场维持着较高的热度。不久前，重庆举行了楼市新政后第一次大规模的供地拍卖会，7块土地全被开发商收入囊中。其中，北京的金融街和重庆本土房企晋愉集团，分别斥资38.8亿元、10亿元，竞得423亩和301亩土地。（记者 林喆）</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp; <b>房产税悬疑</b></p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;&ldquo;快点出来吧，别再折磨我了！&rdquo;80后的邵灵豪一直在等待上海楼市新政出台。他想买房，想知道房产税会不会出现在上海新政中，但每天各种消息搞得他很疲惫。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;市场曾传言5月底上海出台细则，现在又传推迟到6月。而在5月24日，上海房产税悬疑剧迎来一个小高潮。24日中午，上海易居房地产研 究院综合研究部部长杨红旭在微博上写道：&ldquo;上海楼市细则近两日将出，据称比较严厉，可能对市场产生较大负面影响。不过我个人认为，在其它城市细则越出越温 和的情况下，上海细则严厉程度不一定会超过北京。&rdquo;杨红旭的爆料随即引来众多网友和业内人士的关注。大约两小时之后，一则更为重磅的信息出现在了杨红旭的 微博上&mdash;&mdash;&ldquo;最新消息，将要出台的细则包括房产税，天呀，地产股又要跌了，大家快逃命。&rdquo;这一&ldquo;猛料&rdquo;立即引来诸多回应，其中不少人表示&ldquo;难以置信&rdquo;。仅 仅数分钟后，这条微博被推荐至新浪房产微博首页。最吸引眼球的是15时11分的微博：&ldquo;据悉，上海楼市细则明天发布。&rdquo;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;如果24日的剧情是杨红旭个人微博的发布，那么25日的剧情就是毫无出处的传言：&ldquo;今天下午上海将宣布开收房产税。新购房以0.6%征收。不出意外，3点左右将发布。&rdquo;受此影响，A股房地产板块午后加速下跌，盘中最大跌幅达3.47%。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;房产税传言像病毒发作一样，通过QQ、MSN、论坛、手机、微博等多种媒介传播。中国证券报记者25日下午在绿地集团采访，采访对象突然打断采访说：&ldquo;等一下，已经3点了，我看一下细则出来没有。&rdquo;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;其实，25日下午2时许，上海相关主管部门已经辟谣：仍未明确上海版楼市细则的发布时间表。杨红旭对中国证券报记者说，现在看来，细则出台的消息确实不属实，他也是听媒体朋友说的。他说，房地产业没有百分百准确的消息，至于准确程度的高低，大家等细则出来就知。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;不光是想买房的邵灵豪们在纠结中等待，媒体记者们的神经也处于高度紧张状态。房地产记者见到采访对象就问&ldquo;上海细则什么时候出&rdquo;、&ldquo;有 房产税吗&rdquo;。一名上海本地记者自嘲自己像祥林嫂一样，快得强迫症了。中国证券报记者25日一直等到深夜12点，但上海并没有公布任何有关楼市新政的消息。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;开发商也在四处打听消息。中国证券报记者25日遇到上海金叠房地产开发有限公司副总经理乐雨明，他向中国证券报记者打听地产政策走向以及行业前景。他们在等上海细则出台，以决定开盘策略。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;上海弘基企业集团副总裁高栋在微博上爆料称：前个星期，一开发商突然叫停旗下所有正在打桩的项目，静待新政细则出台，等半天等来了&ldquo;房产税三年免谈&rdquo;，非常高兴，通知全面恢复打桩，继续深挖洞。后来得知这消息不属实，晚上开会准备再次叫停。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;不仅地产商，山东一地级市官员告诉中国证券报记者，他们也在等待上海细则，或许会传递某种信号。一些人士分析，重庆之前称将开征&ldquo;特别房产税&rdquo;，但细则实际上比较温和，这已引起业内关注。作为高房价的代表城市，上海在调控尺度上将如何把握有着标杆意义。</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;&nbsp;上海区县一级官员也在等待细则。上海松江区分管土地、住房的副区长陈猛表示，不知道细则什么时候出，曾经说是5月底，但政策内容没有征求过区县的意见。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('126', '<p><strong>修旧还是立新？ 房地税中央地方同床异梦</strong></p>\r\n<p>　　现有地方试点方案，均是修改现行房产税，将已有房产税的征税范围扩展到居民自住房屋，这与部委意见不一；而地方与中央立法精神不一，未来会出现很大麻烦</p>\r\n<p>　　对居民自住房屋征收房产税，这一贯穿2010年全年的政策悬念仍未现形。</p>\r\n<p>　　房产税目标主要是调控房价还是筹集收入？&ldquo;借道&rdquo;现有税种还是开征新税？土地、住房、财税等部门权责如何协调？当重庆和上海将房产税试点的申请提交国务院，现实的矛盾和冲突便浮出水面。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('129', '<p>　随着住房公积金贷款新政以及央行加息等多重影响，市区住房成交量开始大幅萎缩。记者了解到：2010年12月的第四周也就是12月20日至12月26日，市区共成交住宅163套，较前一周减少335套，环比下降了67.27%。<br />\r\n<br />\r\n近日，国家多部<a target=\"_blank\" href=\"http://search.bmlink.com/?action=seach&amp;from=default&amp;seachtype=newsearch&amp;keywords=%c3%c5&amp;Submit=%D6%D0%BD%A8%CB%D1%CB%F7\">门</a>表示，还将出台更严厉的调控政策，来抑制房价的过快增长。<br />\r\n<br />\r\n消息传来，不少市民暂停了买房计划。不少楼盘销售人员说：进入12月以来，来看房选房的客户开始逐渐变少，买房的市民也变得更加谨慎起来。据统 计：2010年12月的第四周，市区共成交住宅163套，非住宅成交66套，较前一周减少65套，环比下降了49.62%。其中，位于崇川区金鼎湾花园成 交备案20套；四季绿苑成交备案15套；东景国际尚层成交备案14套。位于港闸区的尚海城成交备案25套，高迪晶城销售备案14套。另外，市开发区也成交 了27套，相对前一周，成交量均有所下滑。<br />\r\n<br />\r\n业内人士分析市区出现成交量下降的趋势，主要源于住房&ldquo;南通版细则&rdquo;出台和市场的疲软。随着今年各项楼市调控政策继续出台，市区房地产市翅进入调整期，调整将围绕着抑制投资、鼓励自住这条主线展开。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('133', '<p>　未来政策展望:我们认为明年房地产调控将更多使用货币手段，通过调整利率、<a href=\"http://bank.jrj.com.cn/list/grxd.shtml\" class=\"ot1\">信贷</a>窗口指导、准备金等工具统筹应对房价上涨和通货膨胀。同时增加保障房供应，继续打击囤房、囤地，加大土地供应力度，缓解供给矛盾将是明年的另一条主线。另外，<a href=\"http://house.jrj.com.cn/\" class=\"ot1\">房产</a>税试点政策明年出台的可能性也较大，如果实际政策力度符合预期，则可能引发阶段性<a href=\"http://summary.jrj.com.cn/\" class=\"ot1\">行情</a>；但房产税征收范围扩大或税率较高，则对于房地产市场以及<a href=\"http://stock.jrj.com.cn/\" class=\"ot1\">股票</a>市场均是较大打击。</p>\r\n<p>　　外部环境良好:我们认为，明年全年经济仍然能够保持快速增长，而<a href=\"http://forex.jrj.com.cn/list/rmbdt.shtml\" class=\"ot1\">人民币</a>升 值、通货膨胀等因素对房地产均构成一定的助推作用，因此外部环境依然有利于房地产市场。l房地产市场:我们预计，房地产投资增速明年仍然可以达到 25~30%；新开工面积增速在20%~25%之间；环境较差的情况下房屋销售同比增速5%~8%；环境较好的情况下可达12%；房屋销售价格与2010 年基本持平。</p>\r\n<p>　　区域市场分化:从区域市场来看，2010年东部地区受政策影响较大，投资、新开工、销售等下滑较快，价格波动较大；但中西部地区受影响较小。我们认为由于中西部地区城镇化的加速，在明年房地产市场的大环境下，中西部地区的房地产市场较东部相对更有潜力。</p>\r\n<p>　　警惕财务风险:目前开发企业的财务状况依然可以维持。资产负债率、速动比率等硬性指标短期内比较健康。但由于2010年开发企业经营性现金流出较大，如果融资环境继续恶化或者销售回款不顺畅，则开发企业的财务状况容易迅速恶化。</p>\r\n<p>　　投资建议:2011年投资以&ldquo;稳健&rdquo;为主。我们推荐三类开发企业。一是实力雄厚、财务稳健的龙头型企业。第二是布局中、西部城市的开发企业。第三是布局大城市周边小城市的开发企业。<a href=\"http://share.jrj.com.cn/\" class=\"ot1\">个股</a>推荐:<span><a href=\"http://stock.jrj.com.cn/cominfo/default_000002.htm\" class=\"stbu\">万科A（000002）</a></span>（000002）、<span><a href=\"http://stock.jrj.com.cn/cominfo/default_600048.htm\" class=\"stbu\">保利地产（600048）</a></span>（600383）、<span><a href=\"http://stock.jrj.com.cn/cominfo/default_002146.htm\" class=\"stbu\">荣盛发展（002146）</a></span>（002146）l风险提示:开发企业资金回笼不畅，导致财务风险加大。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('137', '<p>位于从化市太平神岗广从北路263号的人盛巴厘天地（资料、团购、论坛、二手）目前在售100-132平方米的三房单位，户型设计采用&ldquo;N+1&rdquo;百变户型，赠送空间高达15%，毛坯售价5500元/平方米起，最低首付只需12万元。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('139', '<p>位于花都区新华三东大道与茶碑路交汇处的花都雅居乐花园（资料、团购、论坛、二手）目前主要推售&ldquo;花间集&rdquo;二期单位，主要户型为100-131㎡的三至四房，毛坯均价6800元/平方米，带装修8000-9000元元/平方米，其中 100㎡的单位带装修交楼，127-131㎡的单位毛坯发售。 花间集所有户型均带7米观景阳台、空中花园、大面积入户花园。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('141', '<p>位于白云广州大道北同和华远厂路段的卡布奇诺（资料、团购、论坛、二手）将于1月底开盘，首期主推22-42㎡单身公寓和55㎡一房单位，预计均价13000-16000万元/平方米，带装修和家私家电，之前进行诚意登记的买家开盘可享受98折优惠，2011年8月可交楼。项目周边有吉之岛、乐购、广百、金逸国际电影城。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('145', '<p>位于白云区广州大道北与京溪路交汇处的<a target=\"_blank&quot;\" title=\"君华香柏广场\" href=\"http://xf.house.163.com/gz/00CX.html\">君华香柏广场</a>（<a target=\"_blank&quot;\" title=\"君华香柏广场 楼盘详情\" href=\"http://xf.house.163.com/gz/00CX.html\">资料</a>、<a target=\"_blank&quot;\" title=\"君华香柏广场 团购\" href=\"http://xf.house.163.com/gz/groupbuy/00CX.html\">团购</a>、<a target=\"_blank\" title=\"君华香柏广场 业主论坛\" href=\"http://bbs.gz.house.163.com/list/youyicheng.html\">论坛</a>、<a target=\"_blank\" title=\"君华香柏广场 二手房源\" href=\"http://esf.house.163.com/gz/secondSearch%21esf.action?saletype=s&amp;keywords=%E5%90%9B%E5%8D%8E%E9%A6%99%E6%9F%8F%E5%B9%BF%E5%9C%BA\">二手</a>）目前在售全新的C栋91-135平方米三房、四房&ldquo;珍爱大宅&rdquo;，均价19000元/平方米，带3500元/平方米装修。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('147', '<p>位于从化神岗镇广从公路莲塘桥的<a target=\"_blank&quot;\" title=\"东方夏湾拿\" href=\"http://xf.house.163.com/gz/00Da.html\">东方夏湾拿</a>（<a target=\"_blank&quot;\" title=\"东方夏湾拿 楼盘详情\" href=\"http://xf.house.163.com/gz/00Da.html\">资料</a>、<a target=\"_blank&quot;\" title=\"东方夏湾拿 团购\" href=\"http://xf.house.163.com/gz/groupbuy/00Da.html\">团购</a>、<a target=\"_blank\" title=\"东方夏湾拿 业主论坛\" href=\"http://bbs.gz.house.163.com/list/xianawan.html\">论坛</a>、<a target=\"_blank\" title=\"东方夏湾拿 二手房源\" href=\"http://esf.house.163.com/gz/secondSearch%21esf.action?saletype=s&amp;keywords=%E4%B8%9C%E6%96%B9%E5%A4%8F%E6%B9%BE%E6%8B%BF\">二手</a>）推出最新一期联排别墅&ldquo;巴亚莫&rdquo;组团，带首层老人房、中空客厅、独立天井设计，面积271-277平方米，五房三厅六卫设计，售价10000元/平米起。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('150', '<div align=\"center\"><center><img height=\"320\" alt=\"转让二手房 土地增值税猛涨十倍\" width=\"446\" src=\"http://img1.cache.netease.com/catchpic/8/87/8741D8FB4E83027189EB962E84CFA4A6.jpg\" /></center></div>\r\n<p style=\"text-align: center\">　　<font face=\"楷体_GB2312\">征收对象为转让二手房的单位 暂不影响个人购房者</font></p>\r\n<p>本报讯 （记者肖颖摄影报道）近日，顺德区低调出台了一份《关于调整土地增值税预征率和核定征收率的公告（2010年第2号）》（以下简称《公告》），给楼市投出了一份&ldquo;重磅炸弹&rdquo;，本报在第一时间独家获知了该政策的内容。新政策规定，从2011年元旦起，顺德的纳税人转让普通二手住宅的，其土地增值税的核定征收率从原来的0.5%提高到5%，涨了整整十倍，二手房的置业门槛将再次被抬高。</p>\r\n<p><strong>新政暂不影响个人购房者</strong></p>\r\n<p>今年8月，顺德区调整了土地增值税预征率和核定预征率，对于旧房转让（包括二手房转让）实行核定征收土地增值税，非普通住宅、商铺等商业房产土地增值税的核定征收率为1%；其他房地产的土地增值税核定征收率为0.5%。</p>\r\n<p>时隔4个月后，原土地增值税税预征率和核定预征率被废除，新政策规定：转让普通住宅、库房、写字楼等办公房产、厂房等工业房产的，土地增值税的核定征收率为5%；转让其他房地产的，核定征收率为5.5%。</p>\r\n<p>顺德区财税局表示，现阶段该政策对大多数普通购房者的影响并不大。按照2008年财政部和国税局的相关文件规定，对个人销售住房暂免征收土地增值税。所以，《办法》中规定的征税对象，是转让二手房地产的单位。判断二手房交易中是否要收土地增值税的最简单的办法，就是查看房产证上，到底是个人的名字还是单位的名字。</p>\r\n<p>但是，一旦国家出台相关文件中止土地增值税优惠政策，普通个人购房者也将按《公告》中的规定征收税费。</p>\r\n<p><strong>市民多不知何为土地增值税</strong></p>\r\n<p>近日，记者来到顺德大良东乐路和碧溪路等多家二手房中介走访时，发现大多数购房者并不知道土地增值税为何物。</p>\r\n<p>大良东乐路一家中介公司的工作人员江翠玉表示，今年以来，不少购房优惠被取消，就连首次置业者也不例外。不管是业主来中介放盘，还是购房者来中介看房，她总是事先将土地增值税的政策解释给他们听。&ldquo;万一土地增值税优惠取消，也好让他们有个思想准备。&rdquo;</p>\r\n<p>一名中介工作人员告诉记者，二手房土地增值税优惠到底何时取消至今还不明朗，导致卖家的观望情绪加重。不少业主到中介放盘，其实并不是真心实意想卖楼，而是为了&ldquo;沽价&rdquo;，考验市场的承受能力。如果需求者众多，卖家就会逐渐提高价格。万一卖家发现市场形势不对头，也可以马上将房子甩手。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('153', '<p>11月10日，中原集团发布二手住宅市场月报称，10月份，国内5大城市二手住宅市场再度陷入观望，成交量在持续4个月回升之后开始回落。总体来看，价格虽未出现下跌，但涨幅明显收窄。</p>\r\n<p>报告称，受国家调控政策升级加码、特别是限购政策的影响，5大城市二手住宅成交量未能持续前4个月回升态势，10月起大幅回落。各地城市成交价格依旧缓慢上涨，但是涨幅趋缓。</p>\r\n<p>据中原地产10月二手住宅市场成交量调查数据显示，5大城市成交量为389万平方米，环比下跌28%，各城市环比跌幅在1~5成。其中，深圳和上海两城市由于&ldquo;限购令&rdquo;出台时间最早，而且深圳限购政策特别严厉，故成交量跌幅最大，分别为56%和28%；而广州和天津由于投资需求较少，加之两城市&ldquo;限购令&rdquo;出台较晚，且天津&ldquo;限购令&rdquo;仅限于局部区域，故成交量跌幅较小，分别为10%和7%；北京早在今年4月底就出台&ldquo;限购令&rdquo;，市场依然大受影响，成交量环比回落27%。</p>\r\n<p>中原地产指出，尽管总体成交量有所回落，但仍高于今年5月最低点，相当于7、8两月平均水平。不过，伴随着二手市场成交量大幅回落，业主对后市信心出现逆转，各地下调房源报价的比重开始增加。</p>\r\n<p>而据中原领先指数系统数据显示，10月份五大城市二手住宅成交价格依旧上涨，除广州外，其他四城市环比涨幅均不超过2.0%，其中深圳和北京的涨幅甚至低于1.0%。中原地产认为，虽然&ldquo;二次调控&rdquo;力度较前一次有所升级，但同4月底出台的新&ldquo;国十条&rdquo;相比影响力度明显减弱。根据中原统计，五大城市10月二手住宅成交量是5月低谷时的1.5~3倍；而且10月成交量环比跌幅均小于5月的环比跌幅。</p>\r\n<p>&nbsp;</p>\r\n<div class=\"gg200x300\">另外，据中原监测数据显示，10月除北京二手住宅租金略有回落外，其他四城市租金均保持平稳小幅上涨，环比涨幅在0.3%~0.8%。租金回报率则继续走低，五大城市租金回报率均低于3.2%，远低于当前的商业贷款基准利率，甚至低于5年期以下的公积金贷款基准利率（3.5%）。</div>\r\n<p>中原集团研究中心经理瞿安新认为，&ldquo;二次调控&rdquo;政策影响力度之所以减弱，一是由于目前市场上以刚性需求为主，受限购政策的影响较小；二是部分城市限购令颁布较晚，效应可能滞后；三是前次调控对市场的影响低于预期，市场对政策产生了一定的&ldquo;抗药性&rdquo;。</p>\r\n<p>瞿安新还表示，在政策持续高压的背景下，预计未来两个月，二手住宅成交量仍将低位徘徊，部分城市恐继续回落。而随着成交量的持续低迷，成交价格或将出现下跌。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('155', '<p class=\"f_center\" style=\"text-align: center\"><img alt=\"索菲亚董事长柯建生:下一步终端网络要下沉\" src=\"http://img4.cache.netease.com/home/2010/12/31/20101231152921e0e60.jpg\" /></p>\r\n<p class=\"f_center\">网易家居专访索菲亚董事长柯建生</p>\r\n<p>网易家居：非常感谢索菲亚的柯总接受网易家居的采访，我想问一下今年索菲亚的销售刚才柯总也提到了大约是6亿对吧？</p>\r\n<p>柯建生：对。</p>\r\n<p>网易家居：那么下一年有一个什么样的销售目标吗？</p>\r\n<p>柯建生：我们下一年的销售目标现在市场部在制定中，应该很快出来，但是现在还没有。</p>\r\n<p>网易家居：2010整个市场的环境是处于一个困难的时期，那么怎么样去评价索菲亚今年的表现？</p>\r\n<p>柯建生：今年的表现还是不错的，因为定制行业（定制衣柜）还是属于一个新兴行业，是从装修和成品家具细分出来的一个行业，所以在这几年都是高速增长的。所以虽然房地产会有些波动，但是这几年我们发展还是比较平稳的。</p>\r\n<p>网易家居：索菲亚在市场上处于领先的地位，但是现在有很多的品牌有进军衣柜这块，例如康耐登也做衣柜了，怎么样面对现在那么多品牌的进入？索菲亚还是比较专注在衣柜这块。</p>\r\n<p>柯建生：今天在会上我也讲了，主要有两个方面，一个方面是加快品牌的建设，包括渠道的扩张，10年来我们已经有了很好的基础，这是我们要继续发扬的一部分。另一方面，随着我们渠道的扩张和品牌的提升，我们的量肯定也会随之提升，所以要练好内功，把信息化建设、制造技术进一步提高来应对市场的需求。</p>\r\n<p>网易家居：在渠道这块能否具体说一下有一个什么样的计划。例如索菲亚在内陆一点的地区或者在二三线城市的发展有没有一个比较大的扩展计划？</p>\r\n<p>柯建生：原来我们主要集中在一二线城市，一二线城市的布点通过几年的努力已经基本完成了，所以下一步准备在二三线城市布点，就是网络要下沉，要把网点铺的覆盖面更加广，因为毕竟是一个服务型的制造业。服务型制造业服务要到家，所以网点要适当的拓开。</p>\r\n<p>网易家居：但是我们知道索菲亚整个产品线都是比较高端一点的，在三四线城市要铺开的话，那么市场的策略会否有所不同？用一个什么样的宣传方式会比较合适的呢？</p>\r\n<p>柯建生：定位在高端不一定太准确，其实我们的中端产品也有，相应也有一定的消费群在三四线城市，其实不是从今天开始，也有一些是在三四线开了网点的，从其发展来看还是不错的。我们的产品价钱也有一些是稍微低一点，有稍微高一点的，我们的产品覆盖还不是太窄，挺广的，应该是中高定位的。</p>\r\n<p>网易家居：索菲亚的代言人是舒淇，最近《非诚勿扰2》也快上演了，那么索菲亚有没有结合舒淇跟最近的电影市场热点做一些宣传？</p>\r\n<p>柯建生：我们最近做了一些活动，一个是现在我们在《非诚勿扰2》的片头有广告，这是一个。第二个，我们也组织一些新老客户包场去观赏《非诚勿扰2》。</p>\r\n<p>网易家居：除了电影的广告宣传方式以外，柯总怎么样看网络渠道的宣传方式？</p>\r\n<p>柯建生：网络渠道是一个新的渠道，我们也在关注，也在做一些尝试，例如正在做一些模拟的网店。其实在网络方面，我们跟分销商的B2B做的比较成熟了，在B2C方面也在做一些探讨，在这方面我们积极做了探讨，但是还是有一个过程的，有些事情要根据整个消费的状况去布局，不能够一下子就转，所以我们在传统渠道上现在还是重点。</p>\r\n<p>网易家居：那么如果是网络占据一个分销渠道的话，对传统的经销商会否有一定的利益上的冲突？</p>\r\n<p>柯建生：所以我们现在在平衡这个事情，网络渠道也在探讨，但是并没有大规模的去做一些网络方面的太多推动。在网络方面，我们有一些推广活动，有一些介绍，也有一些网购，都会有，但是这部分现在还不是我们的主流。</p>\r\n<p>网易家居：现在有很多企业品牌都会对卖场的急速扩张有一定的抗拒，觉得分销商的日子越来越不好过了，因为经销商实在是分布得太多了，您怎么看待这个问题？</p>\r\n<p>柯建生：不同的城市情况其实也不一样，有的城市确实有点过密了，好几家堆在一起，确实增加了一些成本。</p>\r\n<p>网易家居：索菲亚这边的经销商会否也会要面临这样的问题？索菲亚在渠道扩张这块控制得怎么样？</p>\r\n<p>柯建生：还好，我们基本上和各大卖场的关系都不错，各大卖场基本上都有进，随着这些卖场的开，其实一个城市的商业格局也在变化。就是说你有一些原来是好的，随着这些卖场的开，可能也会有变动，例如生意就分摊了，给摊薄了。如果是有一些变动，分销商也进行一些相应的调整，而且进卖场有时候也是有选择的，不是百分之百的进，如果有一些是跟卖场的布局有点不合理的话，我们也会做一些选择，所以目前来讲还没有什么太大的问题。</p>\r\n<p>网易家居：非常感谢柯总今天网易家居的采访，希望以后能够多跟柯总交流联系，谢谢！</p>\r\n<p>柯建生：谢谢！</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('156', '<p><strong>雨伞立架</strong></p>\r\n<p class=\"f_center\"><img width=\"425\" src=\"http://img1.cache.netease.com/catchpic/F/F0/F0635F8DE094BD062BD4C57E7054C48F.jpg\" alt=\"低碳环保旧物巧改收纳箱\" /></p>\r\n<p>拆改方法：雨伞也有固定的收纳器皿了，它不是现成品，而是由盆栽立架和陶瓷托盘两样东西组成。分别用金属专用涂料和瓷器专用涂料统一它们的颜色，直 接立在门口，你就再也不用担心滴水趟得到处都是。推荐：一般家里的雨伞都会撑开晾干，很占用空间，这个伞架非常巧妙地利用了花盆和盆栽立架，建议放在玄关 处，也有简洁的装饰作用。</p>\r\n<p><strong>布袋挂帘</strong></p>\r\n<p class=\"f_center\"><img width=\"421\" src=\"http://img1.cache.netease.com/catchpic/4/40/4049EBD5218E720760EF07A4FB2C6597.jpg\" alt=\"低碳环保旧物巧改收纳箱\" /></p>\r\n<p>拆改方法：现成的较长的布帘剪成合适的长度，挂在书架前挡灰尘。别忘记在帘子正面缝些彩色布口袋，充满乐趣。推荐：小小的布帘，看似普通，却解决了家里的许多难题。敞开的鬼子都可以迅速被封闭起来，似乎着你微笑。</p>\r\n<p><strong>木制隔断</strong></p>\r\n<p class=\"f_center\"><img width=\"520\" src=\"http://img1.cache.netease.com/catchpic/2/22/22F4424F6199B861BD4029B633DA2391.jpg\" alt=\"低碳环保旧物巧改收纳箱\" /></p>\r\n<p>拆改方法：壁橱或储藏室等带有搁架的地方都用到这些架子托架。你可以选择旧家具上的附件，并固定到架子上。推荐：这种废料做的小隔断做了二次处理，物品摆放会更有序。</p>\r\n<p><strong>首饰挂钩</strong></p>\r\n<p class=\"f_center\"><img width=\"368\" src=\"http://img1.cache.netease.com/catchpic/9/94/9421127BD9021E105AEA7B4345378A95.jpg\" alt=\"低碳环保旧物巧改收纳箱\" /></p>\r\n<div class=\"gg200x300\">&nbsp;</div>\r\n<p>拆改方法：将窗帘的系带挂钩固定到梳妆台侧面或衣帽间的墙上，首饰、领带的收纳难题迎刃而解。推荐：手制挂钩可固定在梳妆台或床头柜上，换衣服时可搭配喜欢的首饰。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('157', '<p class=\"f_center\"><img width=\"550\" height=\"453\" border=\"1\" src=\"http://img1.cache.netease.com/catchpic/A/AA/AA9ABBF6B5A01B99A80696F6D4C88E9B.jpg\" alt=\"　　Elad Kashi 所设计的盘子餐桌，多了份自由、洒脱，吃饭时无需额外的盘子来承装食物，餐桌上凸凹有致的形状即可用来承装美味，吃完时将桌子擦拭干净即可，对于懒人来说很是实用。\" /></p>\r\n<p>Elad Kashi所设计的盘子餐桌，多了份自由、洒脱，吃饭时无需额外的盘子来承装食物，餐桌上凸凹有致的形状即可用来承装美味，吃完时将桌子擦拭干净即可，对于懒人来说很是实用。</p>\r\n<p class=\"f_center\"><img width=\"550\" height=\"382\" border=\"1\" src=\"http://img1.cache.netease.com/catchpic/4/4A/4A605FE528D781EFF2B701877C617923.jpg\" alt=\"　　Elad Kashi 所设计的盘子餐桌，多了份自由、洒脱，吃饭时无需额外的盘子来承装食物，餐桌上凸凹有致的形状即可用来承装美味，吃完时将桌子擦拭干净即可，对于懒人来说很是实用。\" /></p>\r\n<p class=\"f_center\"><img width=\"550\" height=\"381\" border=\"1\" src=\"http://img1.cache.netease.com/catchpic/7/70/704D32B0959E03014F4397150D1F123A.jpg\" alt=\"　　Elad Kashi 所设计的盘子餐桌，多了份自由、洒脱，吃饭时无需额外的盘子来承装食物，餐桌上凸凹有致的形状即可用来承装美味，吃完时将桌子擦拭干净即可，对于懒人来说很是实用。\" /></p>\r\n<p class=\"f_center\"><img width=\"550\" height=\"384\" border=\"1\" src=\"http://img1.cache.netease.com/catchpic/6/63/6369005E95B3548ACFB3C9053726C07C.jpg\" alt=\"　　Elad Kashi 所设计的盘子餐桌，多了份自由、洒脱，吃饭时无需额外的盘子来承装食物，餐桌上凸凹有致的形状即可用来承装美味，吃完时将桌子擦拭干净即可，对于懒人来说很是实用。\" /></p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('158', '<p class=\"summary\">正值元旦佳节，但实木地板厂老板李伟俊却颇为烦恼，不断上涨的生产成本，让他左右为难。昨日，记者从部分实木地板生产企业处了解到，由于生产成本不断上涨，厂家纷纷上调地板出厂价，这直接导致订单下滑。</p>\r\n<p>&ldquo;调价，订单可能持续下滑;不调，利润受影响。&rdquo;正值元旦佳节，但实木地板厂老板李伟俊却颇为烦恼，不断上涨的生产成本，让他左右 为难。昨日，记者从部分实木地板生产企业处了解到，由于生产成本不断上涨，厂家纷纷上调地板出厂价，这直接导致订单下滑。我市有实木地板厂老板甚至一个月 净亏2万元。</p>\r\n<p><strong>实木地板纷纷上调出厂价</strong></p>\r\n<p>目前在我市销售的大部分实木地板，产地主要集中在浙江、江苏一带。&ldquo;我的厂就在浙江南浔，当地上规模的企业大概有300~400家。&rdquo;从事实木地板生产多年的李伟俊说，南浔已成为中国重要的地板之乡，东南亚、非洲、北美各地的木材，纷纷进入南浔，然后被逐层加工变成地板。</p>\r\n<p>李伟俊介绍，平均一平米实木地板上调幅度在2%左右，零售价每平方米至少上调了5元左右。&ldquo;以前100多元一平方米的实木地板，现在几乎找不到了。&rdquo;李伟俊表示。</p>\r\n<p>&ldquo;由于生产成本不断上涨，这次调价企业也处于无奈，因此幅度不大。&rdquo;在南浔有生产厂的重庆老板姚厚权表示，木材主要来自东南亚、非洲，但最近几年，这些地区的政府相继限制木材出口。木材出口量不断下降，导致价格不断提高。</p>\r\n<p>&ldquo;像龙凤檀去年每平方米涨了15元，现在价格在330元/平方米左右。&rdquo;姚厚权称，一吨实木原料，仅运费目前已涨至290元左右。加上去年以来人工费和厂家销售门面租金上涨，因此，企业不得不上调产品价格。</p>\r\n<p><strong>订单下滑企业月亏2万元</strong></p>\r\n<div class=\"gg200x300\">&nbsp;</div>\r\n<p>&ldquo;现在实木地板生意越来越难做了。&rdquo;姚厚权透露，去年以来，仅人工费就涨至3000元/人，成本高企直接压缩了企业的利润。&ldquo;以前利润至少可达30%~40%，而去年以来，利润顶多只有20%左右。&rdquo;姚厚权说。</p>\r\n<p>&ldquo;利润被挤压，企业只能上调产品出厂价，但价格一调，却导致订单量不断减少。&rdquo;浙江南浔某厂家负责人刘文涛一直叹气。他说，去年上半年，他就两次上调了价格，自去年10月份以来，其订单量逐月递减。</p>\r\n<p>&ldquo;价格高了，许多客户就转向复合地板之类的产品。&rdquo;刘文涛介绍，他专门作过统计，从去年10月份至今，实木地板订单量就缩减了近六成。&ldquo;订单一少，几乎每个月企业都要亏2万元左右。&rdquo;刘文涛无奈地说。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('159', '<p><strong>组合式</strong></p>\r\n<p>组合式电视柜让电视的摆放方式更加多样，满足了在家中随时随地看电视的需求。注意家具和电视之间的匹配及安装方式。</p>\r\n<p class=\"f_center\" style=\"text-align: center\"><img height=\"279\" alt=\"无论你每天面对电视的时间长短，一台电视机总还是家里的必备。平板电视的普及使得电视柜的样子也发生了很大变化，电视机与家具的融合度更高，因此在选择的时候需要考虑的细节也更多。这里推荐12款电视柜，诠释电视柜在实用的功能之外，兼具收纳多功能。\" width=\"500\" border=\"1\" src=\"http://img1.cache.netease.com/catchpic/C/C3/C3227939D9D06BAE62A3EAA1D91EC0D5.jpg\" /></p>\r\n<p><strong>客厅柜多合一方便好整理</strong></p>\r\n<p>将电视直接安装在客厅组合柜附带的板子上，整体效果非常好。电视、装饰物、书、摆件全部能融合在一起，还可根据实际摆放物品的需求自由安排各种搁板、柜门和抽屉的位置。</p>\r\n<p class=\"f_center\" style=\"text-align: center\"><img height=\"324\" alt=\"无论你每天面对电视的时间长短，一台电视机总还是家里的必备。平板电视的普及使得电视柜的样子也发生了很大变化，电视机与家具的融合度更高，因此在选择的时候需要考虑的细节也更多。这里推荐12款电视柜，诠释电视柜在实用的功能之外，兼具收纳多功能。\" width=\"388\" border=\"1\" src=\"http://img1.cache.netease.com/catchpic/C/CC/CCA8435B2EDADE4FE99C9E6A187C86C9.jpg\" /></p>\r\n<p><strong>可旋转台面看电视更舒适</strong></p>\r\n<p>摆放客厅组合柜的墙面恰好有窗子，白天看电视，光照会影响画面效果，这种可旋转台面能轻松解决这一问题。大家一起看电视的时候，能让每个人都拥有舒适的观看角度。</p>\r\n<p class=\"f_center\" style=\"text-align: center\"><img height=\"462\" alt=\"无论你每天面对电视的时间长短，一台电视机总还是家里的必备。平板电视的普及使得电视柜的样子也发生了很大变化，电视机与家具的融合度更高，因此在选择的时候需要考虑的细节也更多。这里推荐12款电视柜，诠释电视柜在实用的功能之外，兼具收纳多功能。\" width=\"360\" border=\"1\" src=\"http://img1.cache.netease.com/catchpic/0/02/026B1B614C28F4EC31B5CF76EEB842BC.jpg\" /></p>\r\n<p><strong>电视放进卧室收纳柜</strong></p>\r\n<p>虽然睡前看电视不是一个好的习惯，但在卧室摆放电视的家庭还是非常多。在卧室中，20寸的电视就很合适，打开柜门后，上部空间收纳各种碟片，下面可以用来放枕头和被子，非常实用。</p>\r\n<p class=\"f_center\" style=\"text-align: center\"><img height=\"437\" alt=\"无论你每天面对电视的时间长短，一台电视机总还是家里的必备。平板电视的普及使得电视柜的样子也发生了很大变化，电视机与家具的融合度更高，因此在选择的时候需要考虑的细节也更多。这里推荐12款电视柜，诠释电视柜在实用的功能之外，兼具收纳多功能。\" width=\"387\" border=\"1\" src=\"http://img1.cache.netease.com/catchpic/1/1D/1DFDF2D4589A7AA4488DA5DF0950130C.jpg\" /></p>\r\n<p>&nbsp;</p>\r\n<div class=\"gg200x300\"><strong>展示搁架电视巧安装</strong></div>\r\n<p>分隔客厅和餐厅空间的隔断，预留了安装平板电视的位置，解决了就餐时观看电视的需求。电视的尺寸不宜太大，37寸之内比较合适。可以选择安装层板，放置dvd和一些视听配件。</p>\r\n<p>(本文来源：居无忧网 )</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('160', '<div id=\"endText\">\r\n<p>这栋位于巴西&nbsp;Ubatuba的海边建筑是由&nbsp;SPBR&nbsp;Arquitetos&nbsp;所设计，整个房子看起來彷彿是漂浮在树梢一般。Ubatuba&nbsp;是圣保罗重要的海岸城市之一，这栋建筑平面佔地&nbsp;55&nbsp;米&nbsp;X&nbsp;16&nbsp;米，沿著几乎50%&nbsp;坡度的山坡建造，房屋距离地面足足有28米。整个建筑完全符合当地的环保法规，完全沒有破坏到自然的植物生态。</p>\r\n<p>整座房屋可以说是完全颠倒过来建造，以天花板为水平，由上往下延伸一直到山坡面。建筑材料运用了水泥、钢筋以及木材，屋顶露台可以远眺大海以及山景，被树木以及自然生态包围，而且又符合环保，看來我又有一个梦想房屋！</p>\r\n<p class=\"f_center\" style=\"text-align: center\"><img title=\"点击查看大图\" height=\"800\" alt=\"&ldquo;漂浮&rdquo;在树梢的住家\" src=\"http://img1.cache.netease.com/catchpic/1/1D/1D77CD911C0377D4AA8BFBA16CDE2C46.jpg\" width=\"533\" border=\"0\" jquery1293983709703=\"2\" /></p>\r\n<p class=\"f_center\" style=\"text-align: center\"><img title=\"点击查看大图\" height=\"375\" alt=\"&ldquo;漂浮&rdquo;在树梢的住家\" src=\"http://img1.cache.netease.com/catchpic/6/61/61BFA55DE9F371D41087F00AA34C7325.jpg\" width=\"560\" border=\"0\" jquery1293983709703=\"3\" /></p>\r\n<p class=\"f_center\" style=\"text-align: center\"><img title=\"点击查看大图\" height=\"800\" alt=\"&ldquo;漂浮&rdquo;在树梢的住家\" src=\"http://img1.cache.netease.com/catchpic/4/40/40F16897D92B27B78B16CFEE051E7D7E.jpg\" width=\"533\" border=\"0\" jquery1293983709703=\"4\" /></p>\r\n<p class=\"f_center\" style=\"text-align: center\"><img title=\"点击查看大图\" height=\"375\" alt=\"&ldquo;漂浮&rdquo;在树梢的住家\" src=\"http://img1.cache.netease.com/catchpic/8/85/85403E98784D436B66C610C19BD61F52.jpg\" width=\"560\" border=\"0\" jquery1293983709703=\"5\" /></p>\r\n<p class=\"f_center\" style=\"text-align: center\"><img title=\"点击查看大图\" height=\"376\" alt=\"&ldquo;漂浮&rdquo;在树梢的住家\" src=\"http://img1.cache.netease.com/catchpic/5/52/52D2C96DA227E27C7F01B25BC4537A41.jpg\" width=\"560\" border=\"0\" jquery1293983709703=\"6\" /></p>\r\n<p>&nbsp;</p>\r\n<div class=\"gg200x300\">&nbsp;</div>\r\n(本文来源：居无忧网 ) <img class=\"icon\" height=\"11\" alt=\"张雪茵\" src=\"http://img1.cache.netease.com/house/css09/end_i.gif\" width=\"12\" border=\"0\" /></div>\r\n<!-- 分页 -->', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('161', '<p class=\"summary\">据悉，2010年下半年以来，衣柜企业整体销售形势不容乐观。不少企业下滑幅度高达60%，在一些主流卖场里，即使排名前十名的企业也未必能盈利。在这种情况下，企业纷纷打出了涨价牌，实属无奈之举。</p>\r\n<p>&ldquo;房产新政&rdquo;到2010年下半年终于在衣柜行业体现出来，市场需求不旺，和去年同期相比，衣柜企业在北京的销售额下降了40%。与 此同时，各项成本在不断增加，逐年提高的人工成本也不容忽视。近几年来，随着居民收入和物价全面提高，工人对薪资的要求也越来越高，凡是手艺娴熟点儿的技 工，工资一般都在4000元左右，有时一些特别工种的工人工资更高。&ldquo;不能委屈了工人，但也不能让意风全部消化人工成本，迫于无奈我们的产品只有涨的份 儿。&rdquo;</p>\r\n<p>衣柜代理商陈小姐最近为涨价问题发愁。涨吧，消费者觉得价高;不涨，厂家变成真正亏本销售。&ldquo;经过我们内部调研和商讨后决定，为了保证基本利润和可持续发展，我所代理的衣柜产品很快要上调20%，实木类产品较过去提高10%的售价。&rdquo;陈小姐说这话时脸色有些沉重。</p>\r\n<p>现象：衣柜产品普遍上涨10%以上2010年下半年以来，&ldquo;房产新政&rdquo;的影响终于在家居行业显现出来，企业销售额普遍下滑，最多的下滑 40%-60%。在一片&ldquo;买卖不好做&rdquo;的叫苦声中，一个奇怪的现象随之而至：产品价格不但没有下降，反而不断往上涨。其中最有代表性的是衣柜行业，上涨幅 度都在10%以上，似乎不涨价就不时髦。不过，这种&ldquo;涨价&rdquo;风潮对于消费者来说并没有明显的感觉，因为上涨的是成本，人们看到的是虚高的市场价，而这个标 在价签上的价格，全凭厂商一张嘴说了算。</p>\r\n<p class=\"f_center\"><img alt=\"外部多重压力将影响未来整体衣柜发展\" hspace=\"0\" align=\"baseline\" border=\"0\" src=\"http://img1.cache.netease.com/catchpic/9/99/99FE033BE1B1A96E3F975A054FDDF564.JPG\" /></p>\r\n<p>关于涨价，同样的艰难决定近期还发生在其它衣柜品牌身上，上涨幅度约10%。成本增加销售下滑按照市场基本规律，涨价往往是缘于产品供不应求。供需 平衡被打破，物以稀为贵，涨价自在情理之中。然而，这一轮衣柜涨价潮却是一种&ldquo;怪象&rdquo;：衣柜厂商都在喊&ldquo;生意不好做&rdquo;，不但不降价反而涨价！</p>\r\n<p>由于原材料上涨过大，物流成本增加，销售价格太低不足以抵销成本的增量，只能靠提升出厂价来弥补。对于原材料上涨，业界普遍证实所言非虚。陈小姐这 样形容木材交易的火爆：&ldquo;现在有一批人每天都驻守在中国与俄罗斯边境附近，但凡有一辆运送木材的货车进来，会立刻将其拦下，不论价格高地不由分说地买下全 部木材，原料紧缺程度可想而知。&rdquo;陈小姐说，原材料少了，价格自然一路飙升，比如水曲柳木，现在已由过去的每立方米几百元飙升至1500多元，用水曲柳木 做的衣柜，价格自然是水涨船高。</p>\r\n<p>正在上涨的原材料不单单只有木材，还有制造衣柜必须用到的油漆、五金配件等。另外，工厂采购及运输成本加大也是衣柜涨价的直接原因。&ldquo;大家都知道汽油涨价了，那么随之而来的肯定就是运费提高，从而导致成本提高，涨价也就是理所当然。&rdquo;</p>\r\n<p>据悉，2010年下半年以来，衣柜企业整体销售形势不容乐观。不少企业下滑幅度高达60%，在一些主流卖场里，即使排名前十名的企业也未必能盈利。在这种情况下，企业纷纷打出了涨价牌，实属无奈之举。</p>\r\n<p>消费者对&ldquo;涨价&rdquo;不敏感尽管衣柜产品上浮价格在情理之中，但也有业内人士提出质疑：衣柜不属于快消品或日用品之列，很多时候人们都是几年才逛一次家居卖场，价格上涨与否消费者其实并不敏感。</p>\r\n<p>实际上，衣柜的标价很有学问。在居然之家、红星美凯龙等档次较高的卖场里，聚集着一批品牌衣柜企业，它们的价格相对来说比较坚挺，打个9折、8.5 折已经很不容易了，只有在重大促销活动的时候，才会打7折。但在一些不太知名的卖场里，3折、2折甚至1折的招牌随处可见，很多消费者养成了习惯，不打折 就不买，这直接导致了衣柜标价的虚高。一般来说，衣柜零售价比出厂价要高出一倍，才有打折的本钱。如果衣柜实际售价与出厂价相比，没有30%以上的毛利， 根本就没法维持高昂的场租、营业员的提成及物流、服务等成本支出。</p>\r\n<p>正因为人们在市场上看到的衣柜标价是虚的，成交价到底是多少才算合算，全凭顾客自己的感觉。而衣柜标多少价，最后又打多少折，也是全凭厂家一张嘴，消费者根本不可能了解到内情。这就导致了所谓涨价与降价不过是厂家与经销商之间的结算价格，消费者很难感觉得到。</p>\r\n<div class=\"gg200x300\">&nbsp;</div>\r\n<p>衣柜行业鱼龙混杂，一些非品牌的衣柜企业借助&ldquo;涨价风&rdquo;随手抬高价格的情况有可能发生，但肯定不会出现在品牌衣柜企业身上，尤其是北京衣柜品牌。&ldquo;一旦成为了品牌，企业的关注点都是如何让消费者获得更多实惠，而不是如何从消费者那里牟取暴利。&rdquo;</p>\r\n<p>面对成本增大而形成的涨价风，首选品牌衣柜的产品;对衣柜企业的建议则是，深入挖掘商品价值，避开北京、上海、天津等开店成本较高的一二线城市，将 市场拓展目标放在二三线城市。&ldquo;同样面积的店面，在一线城市刨除租金等成本后毛利可能只有10%，但在二三线城市肯定要高得多。&rdquo;</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('172', '<p>【基本介绍】<br />\r\n无需付费购买，到官方指定下载地址下载安装后即可以使用 <br />\r\n具有灵活点播的功能，随点随看，时间自由掌握<br />\r\n操作简单，界面简洁明了<br />\r\n掌握最先进的P2SP传输技术，传输速度更快，更节省带宽 <br />\r\n占用CPU、内存、带宽等系统资源占用少，不影响其它操作。 <br />\r\n支持多种视频文件格式 <br />\r\n播放流畅，首次连接速度快 <br />\r\n采用最新解码技术，使网络观看拖动无延时，达到播放本地文件的效果<br />\r\n最高清画面，支持网络高清点播，最高码率达到1300。 <br />\r\n采用脉冲式连接和自动重连策略，保证用户稳定、流畅的观看。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('173', '<p>【基本介绍】<br />\r\n千千静听是一款完全免费的音乐播放软件，拥有自主研发的全新音频引擎，集播放、音效、转换、歌词等众多功能于一身。其小巧精致、操作简捷、功能强大的特点，深得用户喜爱，被网友评为中国十大优秀软件之一，并且成为目前国内最受欢迎的音乐播放软件。<br />\r\n<br />\r\n【软件特色】<br />\r\n拥有自主研发的全新音频引擎，支持DirectSound、Kernel Streaming和ASIO等高级音频流输出方式、64比特混音、AddIn插件扩展技术，具有资源占用低、运行效率高，扩展能力强等特点。<br />\r\n<br />\r\n千千静听支持几乎所有常见的音频格式，包括MP/mp3PRO、AAC/AAC+、M4A/MP4、WMA、APE、MPC、OGG、WAVE、CD、 FLAC、RM、TTA、AIFF、AU等音频格式以及多种MOD和MIDI音乐，以及AVI、VCD、DVD等多种视频文件中的音频流，还支持CUE音轨索引文件。<br />\r\n<br />\r\n通过简单便捷的操作，可以在多种音频格式之间进行轻松转换，包括上述所有格式（以及CD或DVD中的音频流）到WAVE、MP3、APE、WMA等格式的转换；通过基于COM接口的AddIn插件或第三方提供的命令行编码器还能支持更多格式的播放</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('174', '<p>【基本介绍】<br />\r\n&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;Google Chrome(谷歌浏览器)是由Google开发的一款可让您更快速、轻松且安全地使用网络的浏览器，它的设计超级简洁，使用起来更加方便。<br />\r\n<br />\r\n【软件特点】<br />\r\n1、更好的插件稳定性和性能，特别是视频方面。<br />\r\n2、速度更快。相比于第一个测试版，JavaScript V8引擎的SunSpider测试成绩已经加快了40％，V8测试成绩也提高了50％，今后还会继续改进。<br />\r\n3、书签管理器和隐私控制。通过书签导入、导出，可以在Chrome和其它浏览器之间轻松切换，另外管理大量书签也更简单了。<br />\r\n&nbsp;</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('175', '<p>超级硬盘数据恢复软件是一款简单易用且功能强大的数据恢复软件，可以恢复被删除、被格式化、分区丢失、重新分区或者分区提示格式化的数据。采用了最新的数据扫描引擎，以只读的方式从磁盘底层读出原始的扇区数据，经过高级的数据分析算法，扫描后把丢失的目录和文件在内存中重新建立出原先的分区和原先的目录结构，数据恢复的效果非常好。<br />\r\n&nbsp;</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('195', '<p style=\"background: white; line-height: 16.5pt\"><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\">7</span><span style=\"font-size: 10.5pt; mso-ascii-font-family: Verdana; mso-hansi-font-family: Verdana\"><font face=\"宋体\">、文章列表（</font></span><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\">com.willcms.cms.action.directive.ContentAbstractDirective</span><font face=\"宋体\"><span style=\"font-size: 10.5pt; mso-ascii-font-family: Verdana; mso-hansi-font-family: Verdana\">）：</span><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\"><o:p></o:p></span></font></p>\r\n<p style=\"background: white; line-height: 16.5pt\"><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\">[@cms_content_list tpl=\'2\' styleList=\'1-1\' lineHeight=\'2\' bottomLine=\'1\' headMark=\'3\' dateFormat=\'MM-dd\' datePosition=\'2\' titLen=\'10\' append=\'&hellip;\' count=\'5\' channelId=\'1\' channelOption=\'1\'/]<o:p></o:p></span></p>\r\n<p style=\"background: white; line-height: 16.5pt\"><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\">[@cms_content_list count=\'5\' channelId=\'1\' channelOption=\'1\']<br />\r\n[#list tag_list as a]<br />\r\n${a.type.name}&lt;a href=&quot;${a.url}&quot;&gt;${a.title}&lt;/a&gt;<br />\r\n[/#list]<br />\r\n[/@cms_content_list]<o:p></o:p></span></p>\r\n<p style=\"background: white; line-height: 16.5pt\"><span style=\"font-size: 10.5pt; mso-ascii-font-family: Verdana; mso-hansi-font-family: Verdana\"><font face=\"宋体\">【</font></span><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\">tpl</span><span style=\"font-size: 10.5pt; mso-ascii-font-family: Verdana; mso-hansi-font-family: Verdana\"><font face=\"宋体\">】</font></span><span style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\"> </span><span style=\"font-size: 10.5pt; mso-ascii-font-family: Verdana; mso-hansi-font-family: Verdana\"><font face=\"宋体\">标签公用属性，可选值有：</font></span><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\"><br />\r\n0--</span><span style=\"font-size: 10.5pt; mso-ascii-font-family: Verdana; mso-hansi-font-family: Verdana\"><font face=\"宋体\">调用内嵌标签样式；</font></span><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\"><br />\r\n1--</span><span style=\"font-size: 10.5pt; mso-ascii-font-family: Verdana; mso-hansi-font-family: Verdana\"><font face=\"宋体\">调用用户自定义标签样式；</font></span><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\"><br />\r\n2--</span><span style=\"font-size: 10.5pt; mso-ascii-font-family: Verdana; mso-hansi-font-family: Verdana\"><font face=\"宋体\">调用系统预定义标签样式；</font></span><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\"><br />\r\n3--</span><span style=\"font-size: 10.5pt; mso-ascii-font-family: Verdana; mso-hansi-font-family: Verdana\"><font face=\"宋体\">调用用户预定义标签样式。</font></span><span lang=\"EN-US\" style=\"font-size: 10.5pt; font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;\"><o:p></o:p></span></p>\r\n<p>&nbsp;</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('196', '<p>asdfsdf</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('197', '<p>ffffff</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('198', '<p>3. 填写数据内容地址集，内容地址集指的是数据采集的列表，可以在采集地址上，打开源代码看到如图: <br />\r\n通过分析发现开始HTML为：&lt;ul class=&quot;list_009&quot;&gt;结束HTML为：&lt;/ul&gt;</p>\r\n<p style=\"text-align: center\">&nbsp;<img height=\"300\" alt=\"\" src=\"http://www.willcms.com/res_base/willcms_com_www/upload/article/image/2010_4/11_10/m5alggbn0ti3.jpg\" width=\"600\" /></p>\r\n<p>　　4.填写内容地址，内容地址是我们需要采集的数据的链接，比如想采集&lsquo;海口未出现航班延误及旅客大规模滞留情况&rsquo;这个新闻， 链接地址为<a href=\"http://news.sina.com.cn/c/2010-10-04/135721218756.shtml\">http://news.sina.com.cn/c/2010-10-04/135721218756.shtml</a> <br />\r\n通过分析发现开始HTML为：&lt;li&gt;&lt;a href=&quot; 结束HTML为：&quot; target=&quot;_blank&quot;</p>\r\n<p>　　5.填写标题，我们点进&lsquo;海口未出现航班延误及旅客大规模滞留情况&rsquo;这个新闻。查看源代码，可以看见如下图所示： <br />\r\n通过分析发现开始HTML为：&lt;title&gt; 结束HTML为：_新闻中心_新浪网&lt;/title&gt;</p>\r\n<p style=\"text-align: center\"><img height=\"121\" alt=\"\" src=\"http://www.willcms.com/res_base/willcms_com_www/upload/article/image/2010_4/11_10/3kv0ggbn224v.jpg\" width=\"600\" /></p>\r\n<p>　　6填写内容，这里的内容是我们要采集的新闻的正文部分。正文部分如下图： <br />\r\n通过分析发现开始HTML为：f_id=\'3\' --&gt; 结束HTML为：&lt;!-- publish_helper_end --&gt;</p>\r\n<p style=\"text-align: center\"><img height=\"105\" alt=\"\" src=\"http://www.willcms.com/res_base/willcms_com_www/upload/article/image/2010_4/11_10/aidvggbn3bij.jpg\" width=\"600\" /></p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('199', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <table cellspacing=\"0\" cellpadding=\"6\" width=\"100%\" align=\"center\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <p>（一）贯彻执行国家和省有关住房保障和城乡建设工作的方针政策和法律法规，组织起草有关地方性法规、规章和发展计划，拟订相关政策、标准并指导和监督实施。 <br />\r\n                        （二）指导协调全市住房制度改革与住房发展、住房保障工作，推进住房改革与发展；会同有关部门对省、市级财政廉租住房保障资金使用情况进行监督；会同有关部门对全市住房公积金管理法规、政策的执行情况进行监督管理。 <br />\r\n                        （三）指导、协调全市旧城区改造工作；负责城市房屋拆迁管理工作。负责核发特区范围内城市房屋拆迁项目的《房屋拆迁许可证》和《房屋拆迁资格证》。 <br />\r\n                        （四）负责建筑市场监督管理，规范建筑市场各方主体行为。负责全市勘察设计、建筑企业、建筑制品、工程监理、燃气、房产开发企业、造价咨询、招标代理机构的资质管理；指导全市工程建设、建筑业的改革发展。 <br />\r\n                        （五）制定和指导发布工程建设全市统一定额、工期定额标准并监督实施；负责市中心城区建筑业劳保费统筹管理。 <br />\r\n                        （六）负责市级管理的房屋建筑和市政基础设施工程的施工许可。 <br />\r\n                        （七）负责全市房屋建筑和市政基础设施建设工程招标投标活动的监督。 <br />\r\n                        （八）负责全市建设工程白蚁防治的监督管理。 <br />\r\n                        （九）承担建筑工程质量安全监督管理的责任。制定地方工程建设标准、规范、规程并监督实施；负责全市建筑工程质量和安全生产工作的指导和监督检查，负责大中型工程项目初步设计审查和建筑工程的施工图审查管理工作；负责工程建设监理、质量测试、工程质量与安全监督、工程竣工验收备案等工作；指导编制工程质量安全事故应急预案，组织或参与工程质量安全事故的调查和处理。 <br />\r\n                        （十）负责全市燃气行业的监督管理工作；指导澄海、潮阳、潮南区和南澳县编制燃气专项规划。 <br />\r\n                        （十一）承担推进建筑节能和行业科技发展的责任。组织建设科技项目研究开发，指导建设科技成果转化推广；负责建筑节能工作；负责推广应用散装水泥、商品混凝土、新型墙体材料和建筑新技术、新工艺、新材料；负责大中型建筑工程项目与市政工程项目的初步设计审查；负责房屋建筑工程的抗震设防监督管理工作。 <br />\r\n                        （十二）指导建设行业职工队伍培训和继续教育工作；会同有关部门实施行业的职称改革及专业技术职称评审工作；指导行业注册执业资格的申报和管理工作。指导、协调行业协会的业务工作。 <br />\r\n                        （十三）负责组织实施中心城区市级市政基础设施工程建设。负责全市风景名胜区的监督管理工作。 <br />\r\n                        （十四）承办市委、市政府和上级有关部门交办的其他事项。</p>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"1\" bgcolor=\"#c7c7c7\">&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td background=\"images/t2.gif\"><img height=\"5\" alt=\"\" width=\"5\" src=\"http://www.stjs.gov.cn/zwzx/images/corner_sw.gif\" /></td>\r\n            <td background=\"images/t2.gif\">\r\n            <div align=\"right\"><img height=\"5\" alt=\"\" width=\"5\" src=\"http://www.stjs.gov.cn/zwzx/images/corner_se.gif\" /></div>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<br />\r\n&nbsp;</p>\r\n<div class=\"zb_word2\" align=\"left\"><strong>汕头市住房和城乡建设局内设机构设置与职责</strong><br />\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"705\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td bgcolor=\"#1c70b4\" height=\"2\">&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</div>\r\n<p><br />\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td background=\"images/t1.gif\"><img height=\"5\" alt=\"\" width=\"5\" src=\"http://www.stjs.gov.cn/zwzx/images/corner_nw.gif\" /></td>\r\n            <td background=\"images/t1.gif\">\r\n            <div align=\"right\"><img height=\"5\" alt=\"\" width=\"5\" src=\"http://www.stjs.gov.cn/zwzx/images/corner_ne.gif\" /></div>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"1\" bgcolor=\"#c7c7c7\">&nbsp;</td>\r\n            <td>\r\n            <table cellspacing=\"0\" cellpadding=\"6\" width=\"100%\" align=\"center\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <p align=\"center\"><strong>副处级以上干部职位</strong></p>\r\n                        <div align=\"center\">\r\n                        <table cellspacing=\"1\" cellpadding=\"4\" width=\"487\" bgcolor=\"#999999\" border=\"0\">\r\n                            <tbody>\r\n                                <tr valign=\"top\" bgcolor=\"#f3f8fc\">\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=37996\')\"><font color=\"#0000ff\">局<br />\r\n                                    长<br />\r\n                                    、<br />\r\n                                    党<br />\r\n                                    组<br />\r\n                                    副<br />\r\n                                    书<br />\r\n                                    记<br />\r\n                                    徐<br />\r\n                                    凯</font></a></div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=20989\')\"><font color=\"#0000ff\">党<br />\r\n                                    组<br />\r\n                                    书<br />\r\n                                    记<br />\r\n                                    王<br />\r\n                                    德<br />\r\n                                    声</font></a></div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\">\r\n                                    <p><a href=\"javascript:News1(\'jgszinfo.asp?id=20994\')\"><font color=\"#0000ff\">副<br />\r\n                                    局<br />\r\n                                    长<br />\r\n                                    、<br />\r\n                                    党<br />\r\n                                    组<br />\r\n                                    成<br />\r\n                                    员<br />\r\n                                    郑</font><br />\r\n                                    <font color=\"#0000ff\">丽<br />\r\n                                    明<br />\r\n                                    </font></a></p>\r\n                                    </div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=20992\')\"><font color=\"#0000ff\">副<br />\r\n                                    局<br />\r\n                                    长<br />\r\n                                    、<br />\r\n                                    总<br />\r\n                                    工<br />\r\n                                    程<br />\r\n                                    师<br />\r\n                                    杨<br />\r\n                                    鮀<br />\r\n                                    生</font></a></div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=20993\')\"><font color=\"#0000ff\">副<br />\r\n                                    局<br />\r\n                                    长<br />\r\n                                    、<br />\r\n                                    党<br />\r\n                                    组<br />\r\n                                    成<br />\r\n                                    员<br />\r\n                                    陈<br />\r\n                                    淑<br />\r\n                                    雄</font></a></div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=37995\')\"><font color=\"#0000ff\">纪<br />\r\n                                    检<br />\r\n                                    组<br />\r\n                                    长<br />\r\n                                    、<br />\r\n                                    党<br />\r\n                                    组<br />\r\n                                    成<br />\r\n                                    员<br />\r\n                                    黄<br />\r\n                                    卡<br />\r\n                                    新</font></a></div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=37994\')\"><font color=\"#0000ff\">副<br />\r\n                                    调<br />\r\n                                    研<br />\r\n                                    员<br />\r\n                                    、<br />\r\n                                    党<br />\r\n                                    组<br />\r\n                                    成<br />\r\n                                    员<br />\r\n                                    许<br />\r\n                                    建<br />\r\n                                    生</font></a></div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=20990\')\"><font color=\"#0000ff\">调<br />\r\n                                    研<br />\r\n                                    员<br />\r\n                                    林<br />\r\n                                    耿<br />\r\n                                    明</font></a></div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=20991\')\"><font color=\"#0000ff\">调<br />\r\n                                    研<br />\r\n                                    员<br />\r\n                                    颜<br />\r\n                                    廷<br />\r\n                                    启</font></a></div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=20998\')\"><font color=\"#0000ff\">副<br />\r\n                                    调<br />\r\n                                    研<br />\r\n                                    员<br />\r\n                                    李<br />\r\n                                    舜<br />\r\n                                    通</font></a></div>\r\n                                    </td>\r\n                                    <td width=\"45\">\r\n                                    <div align=\"center\">\r\n                                    <p><a href=\"javascript:News1(\'jgszinfo.asp?id=31642\')\"><font color=\"#0000ff\">副<br />\r\n                                    调<br />\r\n                                    研<br />\r\n                                    员<br />\r\n                                    郑<br />\r\n                                    木<br />\r\n                                    山</font></a></p>\r\n                                    </div>\r\n                                    </td>\r\n                                </tr>\r\n                            </tbody>\r\n                        </table>\r\n                        </div>\r\n                        <p align=\"center\"><strong>局机关内设机构</strong><font color=\"#999999\">（点击查看相关机构的工作职责）</font></p>\r\n                        <div align=\"center\">\r\n                        <table cellspacing=\"1\" cellpadding=\"4\" width=\"520\" align=\"center\" bgcolor=\"#999999\" border=\"0\" style=\"line-height: 120%\">\r\n                            <tbody>\r\n                                <tr valign=\"top\" bgcolor=\"#f3f8fc\">\r\n                                    <td height=\"305\">\r\n                                    <div align=\"center\">\r\n                                    <p><a href=\"javascript:News1(\'jgszinfo.asp?id=75\')\"><font color=\"#0000ff\">办<br />\r\n                                    公<br />\r\n                                    室</font></a><br />\r\n                                    &nbsp;</p>\r\n                                    </div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=76\')\"><font color=\"#0000ff\">人<br />\r\n                                    事<br />\r\n                                    教<br />\r\n                                    育<br />\r\n                                    科</font></a><br />\r\n                                    <font color=\"#666666\">&and;<br />\r\n                                    与<br />\r\n                                    监<br />\r\n                                    察<br />\r\n                                    室<br />\r\n                                    、<br />\r\n                                    机<br />\r\n                                    关<br />\r\n                                    党<br />\r\n                                    委<br />\r\n                                    办<br />\r\n                                    公<br />\r\n                                    室<br />\r\n                                    合<br />\r\n                                    署<br />\r\n                                    &or;</font></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=77\')\"><font color=\"#0000ff\">计<br />\r\n                                    划<br />\r\n                                    财<br />\r\n                                    务<br />\r\n                                    科</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=78\')\"><font color=\"#0000ff\">勘<br />\r\n                                    察<br />\r\n                                    设<br />\r\n                                    计<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    科</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=79\')\"><font color=\"#0000ff\">建<br />\r\n                                    筑<br />\r\n                                    市<br />\r\n                                    场<br />\r\n                                    监<br />\r\n                                    管<br />\r\n                                    科</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=80\')\"><font color=\"#0000ff\">工<br />\r\n                                    程<br />\r\n                                    质<br />\r\n                                    量<br />\r\n                                    与<br />\r\n                                    安<br />\r\n                                    全<br />\r\n                                    监<br />\r\n                                    管<br />\r\n                                    科<br />\r\n                                    </font></a>\r\n                                    <div align=\"center\"><font color=\"#666666\">&and;<br />\r\n                                    建<br />\r\n                                    筑<br />\r\n                                    节<br />\r\n                                    能<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    科<br />\r\n                                    &or;</font></div>\r\n                                    </div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=81\')\"><font color=\"#0000ff\">住<br />\r\n                                    房<br />\r\n                                    保<br />\r\n                                    障<br />\r\n                                    与<br />\r\n                                    开<br />\r\n                                    发<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    科</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=82\')\"><font color=\"#0000ff\">市<br />\r\n                                    政<br />\r\n                                    工<br />\r\n                                    程<br />\r\n                                    建<br />\r\n                                    设<br />\r\n                                    科</font></a><br />\r\n                                    &nbsp;</div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=37478\')\"><font color=\"#0000ff\">法<br />\r\n                                    制<br />\r\n                                    与<br />\r\n                                    综<br />\r\n                                    合<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    科</font></a><font color=\"#666666\"><br />\r\n                                    &and;<br />\r\n                                    燃<br />\r\n                                    气<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    办<br />\r\n                                    公<br />\r\n                                    室<br />\r\n                                    &or;</font><br />\r\n                                    &nbsp;</div>\r\n                                    </td>\r\n                                </tr>\r\n                            </tbody>\r\n                        </table>\r\n                        </div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"1\" bgcolor=\"#c7c7c7\">&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>\r\n<div class=\"zb_word2\" align=\"left\"><strong>汕头市住房和城乡建设局归口管理单位和直属事业单位设置与职责</strong><br />\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"705\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td bgcolor=\"#1c70b4\" height=\"2\">&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</div>\r\n<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td background=\"images/t2.gif\"><img height=\"5\" alt=\"\" width=\"5\" src=\"http://www.stjs.gov.cn/zwzx/images/corner_sw.gif\" /></td>\r\n            <td background=\"images/t2.gif\">\r\n            <div align=\"right\"><img height=\"5\" alt=\"\" width=\"5\" src=\"http://www.stjs.gov.cn/zwzx/images/corner_se.gif\" /></div>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"1\" bgcolor=\"#c7c7c7\">&nbsp;</td>\r\n            <td>\r\n            <table cellspacing=\"0\" cellpadding=\"6\" width=\"100%\" align=\"center\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <p align=\"center\"><strong>汕头市住房和城乡建设局归口管理单位和直属事业单位</strong><font color=\"#999999\">（点击查看相关机构的工作职责）</font></p>\r\n                        <div align=\"center\">\r\n                        <table cellspacing=\"1\" cellpadding=\"4\" width=\"520\" align=\"center\" bgcolor=\"#999999\" border=\"0\" style=\"line-height: 120%\">\r\n                            <tbody>\r\n                                <tr valign=\"top\" bgcolor=\"#f3f8fc\">\r\n                                    <td>\r\n                                    <div align=\"center\"><font color=\"#0000ff\">市<br />\r\n                                    北<br />\r\n                                    山<br />\r\n                                    湾<br />\r\n                                    旅<br />\r\n                                    游<br />\r\n                                    度<br />\r\n                                    假<br />\r\n                                    区<br />\r\n                                    管<br />\r\n                                    委<br />\r\n                                    会</font></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><font color=\"#0000ff\">市<br />\r\n                                    房<br />\r\n                                    产<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    局<br />\r\n                                    </font></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=12541\')\"><font color=\"#0000ff\">市<br />\r\n                                    旧<br />\r\n                                    城<br />\r\n                                    区<br />\r\n                                    改<br />\r\n                                    造<br />\r\n                                    办<br />\r\n                                    公<br />\r\n                                    室</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><font color=\"#0000ff\">市<br />\r\n                                    礐<br />\r\n                                    石<br />\r\n                                    风<br />\r\n                                    景<br />\r\n                                    名<br />\r\n                                    胜<br />\r\n                                    区<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    局</font></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=83\')\"><font color=\"#0000ff\">市<br />\r\n                                    建<br />\r\n                                    设<br />\r\n                                    工<br />\r\n                                    程<br />\r\n                                    造<br />\r\n                                    价<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    站</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=84\')\"><font color=\"#0000ff\">市<br />\r\n                                    建<br />\r\n                                    设<br />\r\n                                    工<br />\r\n                                    程<br />\r\n                                    质<br />\r\n                                    量<br />\r\n                                    监<br />\r\n                                    督<br />\r\n                                    检<br />\r\n                                    测<br />\r\n                                    站</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=85\')\"><font color=\"#0000ff\">市<br />\r\n                                    工<br />\r\n                                    程<br />\r\n                                    建<br />\r\n                                    设<br />\r\n                                    安<br />\r\n                                    全<br />\r\n                                    监<br />\r\n                                    督<br />\r\n                                    总<br />\r\n                                    站</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=334\')\"><font color=\"#0000ff\">市<br />\r\n                                    城<br />\r\n                                    市<br />\r\n                                    建<br />\r\n                                    设<br />\r\n                                    档<br />\r\n                                    案<br />\r\n                                    馆</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=86\')\"><font color=\"#0000ff\">市<br />\r\n                                    散<br />\r\n                                    装<br />\r\n                                    水<br />\r\n                                    泥<br />\r\n                                    办<br />\r\n                                    公<br />\r\n                                    室</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=87\')\"><font color=\"#0000ff\">市<br />\r\n                                    建<br />\r\n                                    设<br />\r\n                                    工<br />\r\n                                    程<br />\r\n                                    交<br />\r\n                                    易<br />\r\n                                    中<br />\r\n                                    心</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=88\')\"><font color=\"#0000ff\">市<br />\r\n                                    测<br />\r\n                                    试<br />\r\n                                    技<br />\r\n                                    术<br />\r\n                                    研<br />\r\n                                    究<br />\r\n                                    院</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=89\')\"><font color=\"#0000ff\">市<br />\r\n                                    建<br />\r\n                                    筑<br />\r\n                                    施<br />\r\n                                    工<br />\r\n                                    劳<br />\r\n                                    保<br />\r\n                                    费<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    办<br />\r\n                                    公<br />\r\n                                    室</font></a></div>\r\n                                    <div align=\"center\">&nbsp;</div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=90\')\"><font color=\"#0000ff\">市<br />\r\n                                    住<br />\r\n                                    建<br />\r\n                                    局<br />\r\n                                    驻<br />\r\n                                    广<br />\r\n                                    州<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    处</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=90\')\"><font color=\"#0000ff\">市<br />\r\n                                    住<br />\r\n                                    建<br />\r\n                                    局<br />\r\n                                    驻<br />\r\n                                    深<br />\r\n                                    圳<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    处</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=90\')\"><font color=\"#0000ff\">市<br />\r\n                                    住<br />\r\n                                    建<br />\r\n                                    局<br />\r\n                                    驻<br />\r\n                                    厦<br />\r\n                                    门<br />\r\n                                    管<br />\r\n                                    理<br />\r\n                                    处</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=332\')\"><font color=\"#0000ff\">市<br />\r\n                                    建<br />\r\n                                    设<br />\r\n                                    职<br />\r\n                                    业<br />\r\n                                    技<br />\r\n                                    术<br />\r\n                                    学<br />\r\n                                    校</font></a></div>\r\n                                    </td>\r\n                                    <td>\r\n                                    <div align=\"center\"><a href=\"javascript:News1(\'jgszinfo.asp?id=333\')\"><font color=\"#0000ff\">中<br />\r\n                                    国<br />\r\n                                    建<br />\r\n                                    设<br />\r\n                                    报<br />\r\n                                    汕<br />\r\n                                    头<br />\r\n                                    记<br />\r\n                                    者<br />\r\n                                    站</font></a></div>\r\n                                    </td>\r\n                                </tr>\r\n                            </tbody>\r\n                        </table>\r\n                        </div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<p><a href=\"/u/cms/www/201106/201857178dqh.doc\">WORD文档下载</a></p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('200', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>为进一步改进机关作风，提高机关办事效率，特制定本制度。<br />\r\n            <br />\r\n            　　一、一次性告知制。市建设局工作人员应一次性向行政管理相对人告知有关政策法规、办理程序和要求的全部书面材料以及注意事项，对符合规定，手续齐全，应马上办理，不能马上办理的应出具回执并告知办事时限。<br />\r\n            <br />\r\n            　　二、二次终结制。市建设局工作人员对第二次前来办理业务的行政管理相对人，只要其提供的资料及手续齐全，并符合法定程序的，有关科室必须即办，并落实有关工作人员按本局的审批程序为其办妥有关手续。<br />\r\n            <br />\r\n            　　三、市建设局工作人员违反以上制度的，局将按《汕头市改进机关作风和提高行政效能的规定》，对有关科室的负责人和承办人员进行批评教育，责成该科室的负责人向服务对象赔礼道歉，并按有关政策规定进行处理。<br />\r\n            &nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td>&nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('201', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <p>　为进一步改进机关作风，规范办事行为，提高行政效能，特制定本制度。<br />\r\n            <br />\r\n            　　一、市建设局工作人员对通过各种方式来访、咨询、求助、要求办理有关城乡建设事务的服务对象，第一个被询问的工作人员为首问责任人。首问责任人不得以任何借口拒绝服务对象提出的正当合理的询问或对所提出的问题敷衍搪塞，应首问有答。<br />\r\n            <br />\r\n            　　二、凡属其工作范围内的事项，首问责任人要将有关政策法规和办事程序向服务对象一次讲清，能办的立即办，一时办不完的按规定请示后，向服务对象承诺服务时限；不能办的事项应向服务对象作出合理解释，并向直接行政领导报告并备案。<br />\r\n            <br />\r\n            　　三、对不属其工作范围内的事项，首问责任人应向服务对象说明情况，并将其带到相关科室，介绍给有关工作人员，经办科室没有工作人员在场时，应告知其联系电话。<br />\r\n            <br />\r\n            　　四、需要市建设局下属单位办理的事项，首问责任人应向服务对象提供具体承办单位详细地址和联系电话，请服务对象直接与其联系。<br />\r\n            <br />\r\n            　　五、对于不属市建设局业务范围的，有关工作人员应耐心解释清楚。<br />\r\n            <br />\r\n            　　六、凡因首问责任人没有履行职责而受到投诉的，按《汕头市改进机关作风和提高行政效能的规定》进行处理。 <br />\r\n            &nbsp;</p>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td>&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('202', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <p>为确保建设局政务公开工作健康有效开展，切实改进机关作风，提高行政效能，特制订如下措施：<br />\r\n            <br />\r\n            　　一、成立局纪检、监察、法制、人事部门负责同志参加的政务公开监督小组，负责对局机关及直属单位政务公开工作的监督检查。监督小组每季度召开一次会议，组织一次检查活动，向局政务公开领导小组作一次情况汇报。<br />\r\n            <br />\r\n            　　二、特邀政务公开义务监督员。聘请本系统企事业单位干部、职工代表担任本局政务公开义务监督员，及时听取他们的意见和建议，认真落实整改措施。<br />\r\n            <br />\r\n            　　三、自觉接受市人大、政协和监察机关的监督。邀请市人大代表、市政协委员、市监察机关领导，对本局政务公开工作进行检查指导。<br />\r\n            <br />\r\n            　　四、设立投诉电话和意见箱，自觉接受群众监督。局政务公开监督小组设在18楼1805房，投诉电话：8567119，意见箱设在办公楼一楼政务公开厅。<br />\r\n            <br />\r\n            　　五、实行政务公开工作奖惩制度。局机关及直属单位工作人员在政务公开工作中表现突出的，按照上级有关规定给予表扬奖励。如有下列情形之一的，则予以诫勉教育；情节严重的，予以效能告诫：<br />\r\n            　　（一） 对符合规定条件的申报事项应予受理而不受理，或对符合规定、手续齐全但不能马上办好的事项不予出具回执的；<br />\r\n            　　（二） 对申报人申报资料不全，未能一次清楚告知补充的；<br />\r\n            　　（三） 拒绝行政管理相对人，查询与其自身利益相关的办事结果的；<br />\r\n            　　（四） 无正当理由，不在规定或承诺的时限内，就所办事项作出决定或者提出意见的；<br />\r\n            　　（五） 不按规定、程序，或越权审批有关事项的；<br />\r\n            　　（六） 对申报事项没有指定人员代办，或指定人员不履行职责的；<br />\r\n            　　（七） 违反规定要求行政管理相对人承担义务的；<br />\r\n            　　（八） 刁难、敷衍塞责、推诿扯皮的；<br />\r\n            　　（九） 对上级决定、命令不执行的；<br />\r\n            　　（十） 其他违反规定的行为。<br />\r\n            <br />\r\n            　　一年内被告诫一次的，当年年度考核不能评为优秀；一年内被告诫两次（含两次）以上的，当年年度考核评定为不称职，并调整其工作岗位；达到辞退情形的，予以辞退处理。<br />\r\n            &nbsp;</p>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td>&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('203', '<p>2011年作为&ldquo;十二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广方面取得了显著的进步。东莞坚朗五金制品有限公司、广东和合五金制品有限公司、立兴杨氏门窗配件有限公司等企业不仅提高了产品质量，还为研发门窗系统、优化门窗产品设计作出了贡献，其研制出的新产品更加适合门窗节能的要求。此外，部分国际门窗品牌企业逐步在国内建厂。</p>\r\n<p>　　建筑铝型材行业稳步发展。2010年，我国原铝产量接近1690万吨，同比增长24.1%，达到了历史最好水平，2010年，挤压铝型材产量达到1100万吨，其中，建筑铝型材突破750万吨。在国家建筑节能政策的促进下，节能铝合金门窗及隔热铝型材的需求越来越大，技术水平全面提高，节能门窗需求量仍保持增长态势。</p>\r\n<p>　　铝型材行业的整体技术水平明显提升，我国的建筑用铝型材占铝挤出行业70%的份额。近两年铝型材厂出现一个好现象，铝型材厂开始积极配合门窗企业的门窗系统研发工作，其与五金件企业联合研发门窗通用型材产品，使门窗的节能性能大幅度提高。广东坚美铝型材厂、广亚铝型材厂、广东兴发铝型材厂、德国泰诺风公司等企业为编制行业标准和研究隔热铝型材的节能数据做了大量的试验，并积累了大量的技术数据。</p>\r\n<p>　　建筑玻璃行业发展前景乐观。2010年，我国的玻璃行业发展势头良好，平板玻璃产量达到了5.79亿重箱，占全世界平板玻璃产量的50%。这一年，由于建筑节能政策的影响，对节能玻璃的需求增加，其中，低辐射镀膜玻璃的产量约为6000万平方米、中空玻璃的产量为2.5亿平方米、钢化玻璃的产量为1.8亿平方米、夹层玻璃的产量为4000万平方米。几家专业生产建筑玻璃的企业，如深圳南玻、深圳信义玻璃等企业的总产值和销售额都有不俗表现。</p>\r\n<p>　　建筑密封胶行业竞争激烈。尽管面临着原材料和能源价格的上涨等多种因素的影响，但是对建筑密封胶的需求仍呈上升趋势。杭州之江、郑州中原、广州白云、成都硅宝、安泰化学等企业的产量在2010年都不同程度地实现了增长。建筑节能政策的实施增加了中空结构密封胶的使用量，耐候密封胶的需求也逐步增大，产品质量有所提高；硅酮结构密封胶随着幕墙设计结构的多样化，近几年的总量略有减少。</p>\r\n<p>　　建筑密封胶行业品牌效应突出，这也是化工产品本身的特性，除了道康宁、GE等国际品牌外，杭州之江、郑州中原、广州白云等一批企业都在采用各种方式打造企业品牌。目前，国内建筑用胶的主流市场已经基本确立。</p>\r\n<p>　　随着国内超高层建筑增多以及部分企业的结构密封胶出口，不少企业提议应当对结构密封胶的国家标准进行修订，尽快与欧洲标准接轨。</p>\r\n<p>　　2010年，国际经济环境略有好转，可世界经济复苏过程仍曲折缓慢，全</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('204', '<p>据新华社讯 上海易居房地产研究院综合部部长杨红旭告诉记者，房地产开发有一个过程，前期准备工作较多，因此前5个月开工率不高在情理之中，但接下来数月各地将迎来保障房大规模集中开工的热潮，第三季度也有可能成为保障房建设的&ldquo;问责季&rdquo;。</p>\r\n<p>　　据介绍，开发商仅《国有土地使用权证》、《建设用地规划许可证》、《建设工程规划许可证》、《建设工程施工许可证》这4证办下来就至少需要4个月时间，到银行申请贷款审核还需要两个月，如果前期准备工作没有做好，要想在接下来的5个月内开工建设，紧迫程度可想而知。</p>\r\n<p>　　银行贷款额度捉襟见肘</p>\r\n<p>　　一家商业银行上海分行房地产金融部负责人告诉记者，今年分行贷款目标是实现&ldquo;零增长&rdquo;，由于存款准备金率连续上调，银行可发放贷款的额度捉襟见肘，特别是房地产开发贷款，受政策限制虽然现在还不能说是暂停发放，但基本上已很少发放，即便是政策支持的保障房项目也很难贷款。</p>\r\n<p>　　记者从上海多家房地产开发企业了解到，目前确实很少从银行获得贷款支持。上海地产集团、绿地集团等参与多个大型保障房项目的开发企业也反映，贷款审批程序更加严格，审批时间更长，发放贷款额度也锐减。&ldquo;以前有《国有土地使用权证》、《建设用地规划许可证》两证就可申请贷款，现在必须四证齐全；以前贷款额往往有数亿、数十亿元，现在1亿元甚至5000万元的贷款也要去争取。&rdquo;一家参建上海某大型居住社区的企业负责人告诉记者，现在项目多资金少，是&ldquo;十口锅子八个盖&rdquo;，紧张程度不言而喻。</p>\r\n<p>　　另外一些开发企业反映，去年的保障房项目贷款一般是维持基准利率，甚至能享有下浮10％~15％的优惠；今年以来一般是上浮10％~15％，高的甚至达到30％。按这样的资金成本，经适房等项目的建设不但无微利可图，且极有可能亏本。</p>\r\n<p>　　据了解，今年一些城市经适住房、动迁房项目的新增资金缺口可能达数百亿元，对银行贷款的依赖度为8成左右。以往上半年的贷款基本能按时发放到位，但今年上半年新增贷款极少，如果这一形势继续下去，要在10月底前实现全部项目开工将十分困难。</p>\r\n<p>　　保障房建设亟待金融创新</p>\r\n<p>　　据估算，完成今年1000万套保障性住房建设的目标所需资金至少1．3万亿元。其中中央、省级和市县政府将承担5000多亿元，剩余的8000多亿元要通过社会机构投入和被保障对象以及所在企业筹集。财政部数据显示，截至5月20日，财政部已累计下拨2011年中央补助保障性安居工程专项资金617亿元，已完成全年预算59．9％。但要完成全年1000万套的保障性住房建设，中央财政1030亿元的投入显然不够。</p>\r\n<p>　　目前，保障性住房和商品住房的开发贷款都属于房地产开发贷款，被纳入楼市调控范围，这是保障房贷款受限的关键因素。业内人士建议，应顺应保障住房和商品住房&ldquo;双轨制&rdquo;的政策取向，将两类贷款实现分类管理，并落实中央关于支持保障性住房建设的金融政策，确保贷款额度和优惠利率；同时应加强监管，防止企业&ldquo;套贷&rdquo;用于商品住房开发。</p>\r\n<p>　　银监会主席助理阎庆民日前曾表示，保障房建设资金&ldquo;不能全部压在银行身上&rdquo;。由于保障房非商业地产，资金回报时间长，没有商业可持续性，因此银行只能在财政补充足额到位的基础上，适当给予支持，否则如果无法偿还信贷本息，就会形成平台贷款风险。</p>\r\n<p>　　事实上，各方对保障房资金来源一直在进行着多种探索和尝试。在刚落幕的2011陆家嘴论坛上，保监会主席吴定富表示，保监会将在政策允许范围内，在上海地区开展基础设施、股权和不动产等投资活动。目前，平安保险已发起债权投资计划，募集资金30亿元，用于支持上海保障性住房建设。去年底，北京市土地储备整理中心与7家保险资产管理公司也签订了总金额为700亿元~800亿元的债权投资计划。</p>\r\n<p>　　上海公积金管理中心日前还根据国家有关规定，首次使用公积金增值资金收购公共租赁住房项目&ldquo;新江湾尚景园&rdquo;，总投资14．98亿元，为上海的公租房&ldquo;储备库&rdquo;新增住宅2200余套。另外，天津、上海等地也在加快推动保障性住房投资信托基金设立工作。</p>\r\n<p>　　专家认为，加快保障性住房建设是一项系统工程，既需要完善银行贷款等&ldquo;主流&rdquo;融资渠道，也需要不断创新融资方式；既需要地方政府、企业的持续探索，也离不开中央有关部门、金融机构不断的机制创新。</p>\r\n<p align=\"right\">摘自：粤建网</p>\r\n<p>&nbsp;</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('205', '<p>广州日报讯 （记者欧阳媚峰、徐靖&nbsp; 通讯员张兰）从明天开始，央行将再次上调存款类金融机构人民币存款准备金率0.5个百分点。存款准备金率的再次上调，无异于给银行的信贷投放又加了一道&ldquo;紧箍咒&rdquo;。记者昨日获悉，有佛山银行已经在实际操作过程中将首套房的最低首付提高到四成。</p>\r\n<p>　　南海一品牌大盘营销部负责人昨日向记者透露，银行的房贷日渐紧缩了。&ldquo;先是有银行取消了二套房贷款，最近我们合作的中国银行也跟我们打招呼，说可能要上调首套房的首付，为了避免有些客户在申请贷款的时候卡在首付问题上，所以他们要求我们开始都按照四成的首付来做首套房的贷款，我们现在已经是照此执行了。&rdquo;该负责人如是说。</p>\r\n<p>　　尽管部分开发商说中国银行已经将首套房首付提高到了四成，但中国银行佛山分行办公室相关工作人员向记者表示，目前未收到上级部门关于房贷政策的调整通知，因此总体上依然参照&ldquo;首付不低于三成，利率参照同业标准，但不低于基准利率&rdquo;的政策执行。</p>\r\n<p>　　至于为何部分楼盘房贷客户的首付已经提至四成，该工作人员表示，政策规定首付不低于三成，因此不排除银行个贷部门根据客户的实际情况，对房贷政策进行灵活调整。</p>\r\n<p>　　记者昨日采访也发现，大部分银行暂时都是按照三成的首付。建行锦华支行的客户经理梁先生向记者表示，目前一套房的首付依然是不低于三成，利率不低于基准利率。而二手房的首付则要提高到四成，利率上浮10%到30%。</p>\r\n<p>　　记者随后又咨询了工行、农行、招行等银行营业网点的客户经理，他们均表示，目前依然执行的是首套房首付最低三成的政策。</p>\r\n<p>　　有银行个贷部门负责人提醒，目前通胀预期没有本质改观，不排除央行在年内会继续加息或提高存款准备金率，因此，房贷政策还有可能出现调整，市民若要在这段时间内买房，需要充分了解银行房贷政策，并预留充分的首付资金，合理安排好购房计划。</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('206', '<p>各区县建设局、市直施工企业：</p>\r\n<p>　　为配合省住建厅启动开展全省建筑业发展状况的调研工作，现将《关于印发&lt;广东省住房和城乡建设厅产业转型升级突破点工作方案&mdash;扶持建筑业专业承包企业发展&gt;的通知》（粤建市函[2011]363号）转发给你们。现将有关事项通知如下：</p>\r\n<p>　　1、请各建筑业企业结合自身实际，对推进我市建筑业转型升级提出意见和建议，其中，一级总承包企业应同时填报《企业科技进步水平情况摸查表》（附件2）；</p>\r\n<p>　　2、市直企业应于6月24日前向市住建局提交纸质资料；区属企业向所属区建设局提交资料，请各区建设局将收集后，于6月27日前报送我局。</p>\r\n<p>　　联系科室：建筑市场监管科，联系电话：88561516，传真：88562182。</p>\r\n<p>　　附件：1、<a href=\"http://www.stjs.gov.cn/m02-news/file/2011061712401.doc\">关于印发《广东省住房和城乡建设厅产业转型升级突破点工作方案&mdash;扶持建筑业专业承包企业发展》的通知（粤建市函[2011]363号）</a></p>\r\n<p>　　　　　2、<a href=\"http://www.stjs.gov.cn/m02-news/file/2011061712402.doc\">企业科技进步水平情况摸查表</a></p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('207', '<p>5月6日上午，由中宣部、国家发改委、解放军总政治部和四川省委共同组织的汶川特大地震抗震救灾和恢复重建先进事迹报告会在省委礼堂隆重举行。报告团由省住房城乡建设厅规划处处长邱衍庆、四川重灾区映秀镇党委书记廖军、陕西省宁强县广坪镇党委书记李阳、成都军区联勤部川藏兵站部副部长敖斌、中国东方电气集团东汽党委书记何显富和甘肃省康县阳坝镇党委书记范登奎等9人组成。会前，省委副书记、省长黄华华，省委常委、宣传部长林雄，省政府党组成员、省扶贫开发领导小组副组长李容根，省军区副政委黄善春等领导同志亲切会见了报告团全体成员。</p>\r\n<p>　　报告会上，6位报告团成员生动讲述了在抗震救灾和恢复重建过程中的亲身经历和真切感受，邱衍庆处长所作以《让生命在汶川大地闪光》为题的报告，深深打动了全场听众。邱处长是对口支援汶川县恢复重建工作组项目协调部部长，也是一名建筑学博士，国家一级规划师。他作为广东省第一批援建工作组成员，抱着对灾区人民最深沉的爱心、最强烈的责任心和使命感，为灾区的恢复重建付出了巨大心血。援建期间，他突患脑膜瘤，一个月内连续开了4刀，仍坚持完成援建任务。&ldquo;不管多苦多累多危险，我们都要自己扛！&rdquo;&ldquo;只要不倒下，我就要干下去！&rdquo;的崇高精神境界深深感染了现场听众，会场不时响起阵阵掌声。</p>\r\n<p>　　邱处长的感人事迹和崇高精神就在我们身边，我们要学习弘扬伟大的抗震救灾精神，把抗震救灾和恢复重建形成的宝贵精神财富转化为推动各项工作的强大动力，进一步推进住房城乡建设事业科学发展，以优异成绩向中国共产党成立90周年献礼。</p>\r\n<p>　　厅直属机关党委书记、副厅长杜挺同志带领厅机关和直属各单位50名同志参加了报告会。省对口援建干部、省直机关和广州市直机关干部、驻粤部队官兵、高校师生、省属国有企业职工以及社会各界代表1500人现场聆听了报告。</p>\r\n<p align=\"center\"><img height=\"313\" alt=\"\" width=\"500\" src=\"http://www.gdcic.net/ImsManager/UploadPhoto/20110510/20110510124922296.jpg\" /></p>\r\n<p align=\"center\">让生命在汶川大地闪光</p>\r\n<p align=\"center\">（广东省对口支援汶川县恢复重建工作组邱衍庆）</p>\r\n<p>各位领导、同志们：</p>\r\n<p>　　大家好！</p>\r\n<p>　　我叫邱衍庆，是广东援建工作组项目协调部部长。</p>\r\n<p>　　2010年1月13日，我从汶川前线被紧急运往广州军区总医院做第一次开颅手术。1月22日，是我人生中最难忘的日子。那天下午，我躺在病床上，妻子牵着2岁的女儿走进病房，女儿手里拎着一盒小小的蛋糕，跑到我床头：&ldquo;爸爸，今天是我生日！&rdquo;我的鼻子一酸&hellip;&hellip;女儿六个月大时，我去了汶川，今天是我第一次跟女儿过生日。</p>\r\n<p>　　记得2008年8月7日，我和57位同事作为广东第一批援建工作组进入汶川。灾区触目惊心的情景，让我立刻产生一种进入战场的使命感和紧迫感。</p>\r\n<p>　　灾后重建千头万绪，首要的任务就是制定援建规划，确定援建项目。我是一名国家注册规划师，又是建筑学博士，这时我本能地感到：报效人民的时刻到了，我一定要用所学的专业知识，打好重建家园这场硬仗！广东是全国唯一援建两省五县（区）的省份，援建汶川是重中之重。为了尽快敲定援建项目，我带着项目部的同志迅速投入到艰难的调研之中。有一次，我们去草坡乡调研，当车开到草坡电站时，突然，山石夹着泥沙从天而降，倾泻在离我们仅两、三米远的地方。刚逃过一劫，&ldquo;嘭&rdquo;地一声，一块石头又砸在吉普车上，侧面挡风玻璃&ldquo;哗&rdquo;地一声碎了，顿时我吓出一身冷汗。那天，我第一次想到了死。立马给妻子发了一条短信：&ldquo;老婆，差点没命了！&rdquo;组长知道后，狠狠地刮了我一顿。晚上吃饭时，组长破例地端起酒杯，严肃地对大家说：&ldquo;今天我要敬各位一杯酒，拜托各位，今后谁也不要把这里的危险说出去。多苦多累多危险我们都要扛着，千万不能让家里人为我们担心啊！&rdquo;话音未落，57个人&ldquo;唰&rdquo;地一声，全部站了起来，&ldquo;干&rdquo;，杯中酒一饮而尽&hellip;&hellip;从此以后，我怀着一颗平静的心，带领大家冒着随时可能&ldquo;壮烈&rdquo;的危险，跑遍了汶川13个乡镇，查看地形、了解灾情、倾听群众意愿，用最短的时间掌握了第一手资料；以最快的速度，组织完成了702个项目计划的制定工作。2008年11月，汶川县灾后恢复重建村镇体系规划和县城总体规划高效、高质完成，成为10个极重灾县中第一个通过省级技术审查的规划。映秀是震中，规划举世瞩目。为了把映秀镇建成为具有国际水平的灾后重建典范，我协调邀请了60多位国内外知名专家，组织召开&ldquo;映秀镇灾后重建国际研讨会&rdquo;，专门就映秀规划设计、抗震减灾等进行研讨。记得那天，我正在组织会议，妻子打来电话，女儿一直高烧不退，希望我回家一趟。当时我又急又愧，眼前立刻浮现出女儿烧得通红的小脸，恨不得插翅飞到女儿的身边&hellip;&hellip;然而，身边同事的感人事迹，却一次次浮现在我的眼前：温桂安胃部肿瘤手术，仍然坚守岗位；张彤摔断了腿，仍然拄着拐杖战斗在工地一线；19岁的秦春利测量时不幸落水，牺牲在他最后树起的标杆下&hellip;&hellip;而我这点困难又算得了什么呢？为了灾区成千上万的孩子，为了身上肩负的9千多万广东人民的嘱托，为了建设汶川美丽新家园，我一定要像战士一样坚守在岗位上。</p>\r\n<p>　　援建项目和规划确定后，接下来的任务就是抓规划的实施，抓项目的进度，抓工程的质量。</p>\r\n<p>　　水磨镇规划的实施，费了很多周折。我们设想结合滨水景观和街巷布局，打造川西民居与藏羌风格相融合的旅游小镇，可是镇上的居民不太理解。我就协调佛山援建组的同志带着他们，到成都洛带古镇和云南丽江参观；请当地羌族画家画出他们印象中的羌城，依据画中意向进行建筑设计；还请当地能工巧匠负责木件施工，精雕细刻，最后终于建成了这座国家4A级的风情小镇：如今，禅寿老街和水磨羌城，犹如两颗璀璨的明珠，掩映在雪</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('208', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\" width=\"760\" align=\"center\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <p>系统各有关单位： <br />\r\n            　　2010年，全市住房和城乡建设系统在市委、市政府的正确领导和省住房和城乡建设厅的关心指导下，以邓小平理论和&ldquo;三个代表&rdquo;重要思想为指导，深入实践科学发展观，认真贯彻党的十七届五中全会、省委十届八次全会和市委九届十次全会精神，锐意进取、扎实工作，圆满完成各项目标任务，并涌现出一批先进单位和先进企业。为树立榜样，激励先进，经研究，决定对汕头市龙湖区住房和城乡建设局等7个先进单位、汕头市濠江区城市建设与管理局等3个外出施工管理先进单位、汕头市建安（集团）公司等65个先进企业予以通报表彰。 <br />\r\n            　　希望受表彰的单位和企业戒骄戒躁，再接再厉，在新的一年再创佳绩。全市住房和城乡建设系统各单位要以先进为榜样，学习先进单位和先进企业的成功经验和做法，进一步解放思想，开拓创新，不断开创住房和城乡建设工作新局面，为全力推动科学发展、加快建设幸福汕头作出更大贡献！</p>\r\n            <p>　　附件：<a href=\"http://www.stjs.gov.cn/zwzx/2011gzhy/images/附件.doc\">先进单位和先进企业名单</a></p>\r\n            <p>&nbsp;</p>\r\n            <p align=\"right\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 二○一一年二月十日</p>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('209', '<p>同志们： <br />\r\n　　这次全市建设工作会议的主要任务是，认真贯彻党的十七届四中全会、省委十届六次全会和市委九届八次全会精神，认真贯彻全国、全省建设工作会议精神，深入学习实践科学发展观，总结去年全市建设工作，表彰先进，研究部署今年工作。市政府对这次会议高度重视，林梃副市长亲临会议并将作重要讲话，请大家认真贯彻落实。下面，我作全市建设工作报告。 <br />\r\n　　 一、2009年工作回顾 <br />\r\n　　 2009年，是我市积极应对国际金融危机挑战，危中</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('210', '<p>　 <span class=\"STYLE1\"><strong><font color=\"#ff3300\" size=\"2\">&ldquo;一核&rdquo;</font></strong></span>指汕头内海湾核心廊道，体现&ldquo;一湾两岸&rdquo;城市滨海景观，串接牛田洋湿地、人民广场、石炮台公园、华侨公园、蓝水星公园、礐石风景区等节点，长约93公里。<br />\r\n　　 <span class=\"STYLE1\"><strong><font color=\"#ff3300\" size=\"2\">&ldquo;两带&rdquo;</font></strong></span>指沿桑浦山、莲花山的山体人文景观带，以及沿田心湾、南山湾、北山湾和东海岸新城的滨海特色风光带。 &ldquo;两带&rdquo;串接汕头&ldquo;江、海、山、城、田&rdquo;，彰显汕头特色独具的自然、人文资源，总长约160公里。 &ldquo;两带&rdquo;是省立绿道的组成部分，对接揭阳、潮州市绿道。<br />\r\n　　 <span class=\"STYLE1\"><strong><font color=\"#ff3300\" size=\"2\">&ldquo;八环&rdquo;</font></strong></span>指都市休闲环、牛田洋生态湿地环、新津&mdash;莲阳河绿堤掩翠环、莲阳&mdash;东里河潮汕民居环、小北山田园风情环、濠江山海风光环、大南山红色印迹环、南澳生态海岛环。规划以&ldquo;八环&rdquo;为构架，形成8条市级环形绿道主线，串接城市功能组团和生态敏感区域，联系自然人文景点和地域</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('211', '<p>　 建设宜居城乡，让人民生活更加美好。建设宜居城乡，带动民生改善和民主发展，是这次解放思想学习讨论活动形成的一个新的认识和新的构想。建设宜居城乡是体现以人为本、促进科学发展的一个综合载体。过去人们认为只有&ldquo;烟囱林立，高楼大厦&rdquo;才是现代化，现在大家认识到经济发达、生态良好、环境宜居才是高水平的现代化。过去人们认为只要&ldquo;富起来&rdquo;，就是过上了幸福生活，现在人们追求的幸福生活，不只是物质享受，还包括环境享受、精神享受，以及社会、文化、民主权利的充分保障，乃至自我价值的实现。无论城市还是乡村，只有满足了这些要求，才是人们向往的美好家园，也只有在这样的家园中，人们才能凝聚成为秩序良好、活力充足、参与度高的社会共同体。从这个意义上说，宜居是一个蕴含经济建设、政治建设、文化建设、社会建设的综合概念和综合发展过程，是推进科学发展的目的所</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('212', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <table cellspacing=\"0\" cellpadding=\"6\" width=\"100%\" align=\"center\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>汇集汕头建设历史上的有关部门资料，对于了解和研究汕头建设之发展，当有裨益。经叶启轮同志组稿，汕头城建档案馆编撰出版了《汕头建设之最》一书，该书以丰富的史实，展示了汕头建设历史上的闪光点，讴歌了汕头人民艰苦奋斗，建设汕头的光辉业绩。 <br />\r\n                        　　现将其主要内容摘录如下，供热心人士了解学习研究。\r\n                        <p>&nbsp;</p>\r\n                        <p align=\"right\">汕头建设网2003年5月</p>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"1\" bgcolor=\"#c7c7c7\">&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"750\" align=\"center\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td valign=\"top\" align=\"center\" background=\"images/zhaobiao_bg2.gif\" height=\"291\" style=\"background: url(images/zhaobiao_bg2.gif) fixed no-repeat left top\">\r\n            <div align=\"left\">&nbsp;</div>\r\n            <div align=\"left\">&nbsp;</div>\r\n            <div align=\"left\">&nbsp;</div>\r\n            <div align=\"left\">\r\n            <table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" align=\"center\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td width=\"1\" bgcolor=\"#c7c7c7\">&nbsp;</td>\r\n                        <td>\r\n                        <table cellspacing=\"0\" cellpadding=\"6\" width=\"100%\" align=\"center\" border=\"0\">\r\n                            <tbody>\r\n                                <tr>\r\n                                    <td>\r\n                                    <table cellspacing=\"0\" cellpadding=\"2\" width=\"650\" border=\"0\">\r\n                                        <tbody>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=216\">汕头第一幢10层以上规模较大的高层楼房</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=215\">粤东地区城市最大的住宅区</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=214\">汕头新建的第一批楼房</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=213\">汕头市首次&ldquo;市花&rdquo;评选</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=212\">汕头最先建成的、最长的沿海带状绿化园林</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=211\">粤东地区最大的填海造地建成的人民广场</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=210\">汕头第一个经市经府正式决定建设的风景名胜区</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=209\">汕头历史最悠久的风景名胜区</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=208\">汕头最早被列为景观的是华坞盐田</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=207\">汕头第一个被列为省级文物保护单位的近代军事设施</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=206\">汕头最早的街心公园</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=205\">粤东地区最大的人工公园</a></td>\r\n                                            </tr>\r\n                                            <tr>\r\n                                                <td align=\"center\" width=\"24\">◇</td>\r\n                                                <td><a href=\"http://www.stjs.gov.cn/zwzx/info.asp?id=204\">粤东地区最高的电视塔</a></td>\r\n                                            </tr>\r\n                                        </tbody>\r\n                                    </table>\r\n                                    </td>\r\n                                </tr>\r\n                            </tbody>\r\n                        </table>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </div>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('213', '<p><span class=\"board_line01\">根据汕金机编[2005]20号文件通知，汕头市金平区建设局是主管全区城市建设工作的区人民政府工作部门。<br />\r\n一、主要职责<br />\r\n　　（一）、贯彻执行国家有关建设行政管理的方针、政策和法律、法规、规章。<br />\r\n　　（二）、负责指导辖区&ldquo;城中村&rdquo;改造建设计划的编制工作；负责区工业城的规划报建；负责辖区内私人房屋改建、修缮的审核批准。 <br />\r\n　　（三）、主管辖区工程建设。负</span></p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('214', '<p><span class=\"board_line01\">根据汕金机编[2005]20号文件通知，汕头市金平区建设局是主管全区城市建设工作的区人民政府工作部门。<br />\r\n一、主要职责<br />\r\n　　（一）、贯彻执行国负责指导辖区&ldquo;城中村&rdquo;改造建设计划的编制工作；负责区工业城的规划报建；负责辖区内私人房屋改建、修缮的审核批准。 <br />\r\n　　（三）、主管辖区工程建设。负</span></p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('215', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"384\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td class=\"a\" background=\"images/gcjsz_index1.jpg\" height=\"38\">业的基本概况</td>\r\n        </tr>\r\n        <tr>\r\n            <td background=\"images/gcjsz_indexbg.jpg\">\r\n            <table cellspacing=\"0\" cellpadding=\"0\" width=\"92%\" align=\"center\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <p><img height=\"47\" src=\"http://www.stjs.gov.cn/zwzx/jsj/hjjsj/images/gx_1.jpg\" width=\"39\" align=\"left\" alt=\"\" /><span class=\"board_line01\">濠江区是远近闻名的&ldquo;建筑之乡&rdquo;，建筑业历来比较发达，发展比较早，业务开拓以外向型为主。改革开发以来，建筑业更是得到长足发展，从上世纪80年代后期起已发展壮大为全区重要的支柱</span></p>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('216', '<p>展比较早，业务开拓以外向型为主。改革开发以来，建筑业更是得到长足</p>\r\n<p>&nbsp;</p>\r\n<p>发展，从上世纪80年代后期起已发展壮大为全区重要的支柱产业，近5年来</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('217', '<p>展比较早，业务开拓以外</p>\r\n<p>向型为主。改革开发以来，建</p>\r\n<p>筑业更是得到长足发展，从上世纪80年代后期起已发展壮大为全区重要的支柱产业，近5年来</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('218', '<p>2005]20号文件通知，汕头市金平区建设局是主管全区城市建设工作的区人民政府工作部门。<br />\r\n一、主要职责<br />\r\n（一）、贯彻执行国家有关建设行政管理的方针、政策和法律、法规、规章。<br />\r\n（二）、负责指导辖区&ldquo;城中村&rdquo;改造建设计划的编制工作；负责区工业城的规划报建；负责辖区内私人房</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('219', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td><img height=\"36\" src=\"http://www.stjs.gov.cn/zbtb/images/toubiao_title3.gif\" width=\"704\" alt=\"\" /></td>\r\n        </tr>\r\n        <tr>\r\n            <td align=\"center\" background=\"images/toubiao_titlebg2.gif\">\r\n            <table cellspacing=\"0\" cellpadding=\"0\" width=\"660\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <div align=\"center\"><a href=\"http://www.stjs.gov.cn/zbtb/info_xinxi.asp?id=908\"><img src=\"http://www.stjs.gov.cn/zbtb/images/spic/1_off.gif\" width=\"74\" border=\"0\" name=\"Image1\" osrc=\"http://www.stjs.gov.cn/zbtb/images/spic/1_off.gif\" alt=\"\" /></a></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img src=\"http://www.stjs.gov.cn/zbtb/images/spic/2_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"88\" src=\"http://www.stjs.gov.cn/zbtb/images/spic/c3_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img src=\"http://www.stjs.gov.cn/zbtb/images/spic/c4_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"88\" src=\"http://www.stjs.gov.cn/zbtb/images/spic/c5_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                    </tr>\r\n                    <tr>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"88\" src=\"http://www.stjs.gov.cn/zbtb/images/spic/c7_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"88\" src=\"http://www.stjs.gov.cn/zbtb/images/spic/c8_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>&nbsp;</td>\r\n                        <td>&nbsp;</td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td><img height=\"36\" src=\"http://www.stjs.gov.cn/zbtb/images/toubiao_title4.gif\" width=\"704\" alt=\"\" /></td>\r\n        </tr>\r\n        <tr>\r\n            <td><img height=\"7\" src=\"http://www.stjs.gov.cn/zbtb/images/null.gif\" width=\"200\" alt=\"\" /></td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('220', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td><img height=\"36\" src=\"http://www.stjs.gov.cn/zbtb/images/toubiao_title3.gif\" width=\"704\" alt=\"\" /></td>\r\n        </tr>\r\n        <tr>\r\n            <td align=\"center\" background=\"images/toubiao_titlebg2.gif\">\r\n            <table cellspacing=\"0\" cellpadding=\"0\" width=\"660\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <div align=\"center\"><a href=\"http://www.stjs.gov.cn/zbtb/info_xinxi.asp?id=908\"><img src=\"http://www.stjs.gov.cn/zbtb/images/spic/1_off.gif\" width=\"74\" border=\"0\" name=\"Image1\" osrc=\"http://www.stjs.gov.cn/zbtb/images/spic/1_off.gif\" alt=\"\" /></a></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img src=\"http://www.stjs.gov.cn/zbtb/images/spic/2_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"88\" src=\"http://www.stjs.gov.cn/zbtb/images/spic/c3_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img src=\"http://www.stjs.gov.cn/zbtb/images/spic/c4_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"88\" src=\"http://www.stjs.gov.cn/zbtb/images/spic/c5_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                    </tr>\r\n                    <tr>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"88\" src=\"http://www.stjs.gov.cn/zbtb/images/spic/c7_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"17\" src=\"http://www.stjs.gov.cn/zbtb/images/zb_zt.gif\" width=\"11\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\"><img height=\"88\" src=\"http://www.stjs.gov.cn/zbtb/images/spic/c8_no.gif\" width=\"74\" alt=\"\" /></div>\r\n                        </td>\r\n                        <td>&nbsp;</td>\r\n                        <td>&nbsp;</td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                        <td>\r\n                        <div align=\"center\">&nbsp;</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td><img height=\"36\" src=\"http://www.stjs.gov.cn/zbtb/images/toubiao_title4.gif\" width=\"704\" alt=\"\" /></td>\r\n        </tr>\r\n        <tr>\r\n            <td><img height=\"7\" src=\"http://www.stjs.gov.cn/zbtb/images/null.gif\" width=\"200\" alt=\"\" /></td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('221', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">公告编号</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕建交[2011]16</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程编号</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">440500201106030101</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广厦新城红荔园二期工程监理</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设单位</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市市区统建无房户住房指挥部、汕头市城市建设开发总公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广东建设工程监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">报名时间</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">2011-6-10 9:00 ～ 2011-6-10 17:00</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">序号</div>\r\n            </td>\r\n            <td bgcolor=\"#f2f2f2\" colspan=\"3\">\r\n            <div align=\"center\">投标申请人名称</div>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">1</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;汕头市城市建设监理公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">2</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;广东恒胜建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">3</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;汕头市统诚工程监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">4</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;珠海市城市建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">5</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;广东宏茂建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">6</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;广东联发工程咨询有限公司</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('222', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程编号</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">440500201106100101</td>\r\n            <td width=\"80\" bgcolor=\"#ffffff\">&nbsp;</td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">&nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">岐山北工业区10kv开关站</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设单位</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头金平工业园区管理办公室</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广东恒胜建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">序号</div>\r\n            </td>\r\n            <td bgcolor=\"#f2f2f2\" colspan=\"3\">\r\n            <div align=\"center\">投标申请人名称</div>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">1</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;汕头市中通建设实业有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">2</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;汕头市南华建筑有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">3</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;汕头市鮀岛建筑有限公司</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('223', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程编号</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">440500201106100101</td>\r\n            <td width=\"80\" bgcolor=\"#ffffff\">&nbsp;</td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">&nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">岐山北工业区10kv开关站</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设单位</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头金平工业园区管理办公室</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广东恒胜建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">序号</div>\r\n            </td>\r\n            <td bgcolor=\"#f2f2f2\" colspan=\"3\">\r\n            <div align=\"center\">投标申请人名称</div>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">1</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;汕头市中通建设实业有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">2</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;汕头市南华建筑有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">3</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">&nbsp;汕头市鮀岛建筑有限公司</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('224', '<p>10kv开关站\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">新城红荔园二期工程监理</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标人</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕头市市区统建无房户住房指挥部、汕头市城市建设开发总公司</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88441188</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">广东建设工程监理有限公司</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88888881</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程地点</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市金平区广厦新城，天山北路与金新北</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('225', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">公告编号</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕建交[2011]16</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <table cellspacing=\"0\" cellpadding=\"0\" width=\"80\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td align=\"center\">\r\n                        <div align=\"center\">工程编号</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">440500201106030101</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广厦新城红荔园二期工程监理</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标人</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕头市市区统建无房户住房指挥部、汕头市城市建设开发总公司</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88441188</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">广东建设工程监理有限公司</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88888881</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程地点</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市金平区广厦新城，天山北路与金新北路交界处</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设规模</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">工程预算造价约9400万元。南面为4栋6层商住楼，北面为4栋11层商住楼，地下室一层，楼层建筑高度为20.2m--35.2m，总建筑面积为51003.19㎡。其中地下室面积10241㎡，首层市场及商铺面积9647.74㎡，二层架空层面积2422.85㎡。</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">资金来源 <br />\r\n            及构成</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">自筹100%</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标内容</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">\r\n            <p>土建、装修、水电、消防、机电安装及配套项目等工程监理。</p>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">序号</div>\r\n            </td>\r\n            <td bgcolor=\"#f2f2f2\" colspan=\"3\">\r\n            <div align=\"center\">投标人</div>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">1</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市城市建设监理公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">2</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广东恒胜建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">3</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市统诚工程监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">4</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">珠海市城市建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">5</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广东宏茂建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">6</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广东联发工程咨询有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">行政监督部门</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕头市金平区住房和城乡建设局</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('226', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">告编号</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕建交[2011]09</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <table cellspacing=\"0\" cellpadding=\"0\" width=\"80\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td align=\"center\">\r\n                        <div align=\"center\">工程编号</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">440500201105050102</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市特殊教育学校第一期建设项目工程监理</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标人</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕头市残疾人联合会</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88252538</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕头市城市建设监理公司</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88910188-809</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程地点</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市长平东路以南、汕汾高速公路西侧的原商业学校旁边</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设规模</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">总建筑面积21060.84平方米，其中：2栋5层教学楼（含连廊及塔楼）13373.9m2、1栋6层综合楼4370.72 m2、1栋2层体育馆316.22 m2、消防水池、室外配套（运动场、停车场、道路等）等；工程造价58288336.19元；体育馆最大跨度36m。</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">资金来源 <br />\r\n            及构成</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">其它:财政投资及向社会筹集</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('227', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕建交[2011]16</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程编号</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">440500201106030101</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广厦新城红荔园二期工程监理</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设单位</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市市区统建无房户住房指挥部、汕头市城市建设开发总公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">序号</div>\r\n            </td>\r\n            <td bgcolor=\"#f2f2f2\" colspan=\"3\">\r\n            <div align=\"center\">入围单位</div>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">1</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市城市建设监理公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">2</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广东恒胜建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">3</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市统诚工程监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">4</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">珠海市城市建设监理有限公司</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('228', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广厦新城红荔园二期工程监理</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设单位</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市市区统建无房户住房指挥部、汕头市城市建设开发总公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">序号</div>\r\n            </td>\r\n            <td bgcolor=\"#f2f2f2\" colspan=\"3\">\r\n            <div align=\"center\">入围单位</div>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">1</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市城市建设监理公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">2</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">广东恒胜建设监理有限公司</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">3</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市统诚工程监理有限</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('229', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\" width=\"100%\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td width=\"537\" bgcolor=\"#ffffff\">广厦新城红荔园二期工程监理</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">领取招标文件时间</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">2011-6-17 16:00</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">提交书面答疑截止时间</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">2011-6-24 11:00</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">\r\n            <div align=\"center\">招标人答复截止时间</div>\r\n            </div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">&nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">递交标书</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">2011-7-8 9:30 -- 10:00</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">评标开标</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">2011-7-8 10:00</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('230', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\" width=\"100%\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td width=\"537\" bgcolor=\"#ffffff\">广厦新城红荔园二期工程监理</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">领取招标文件时间</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">2011-6-17 16:00</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">提交书面答疑截止时间</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">2011-6-24 11:00</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">\r\n            <div align=\"center\">招标人答复截止时间</div>\r\n            </div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">&nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">递交标书</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">2011-7-8 9:30 -- 10:00</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"122\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">评标开标</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\">2011-7-8 10:00</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('231', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\" height=\"1\">&nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#9c7da8\" height=\"2\">&nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#e1e1e1\">\r\n            <table cellspacing=\"1\" cellpadding=\"4\" width=\"100%\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td class=\"cRed2\" align=\"center\" width=\"61\" bgcolor=\"#f2f2f2\">问题1</td>\r\n                        <td width=\"598\" bgcolor=\"#ffffff\">请问招标编号是否按按招标公告中的工程编号填写?</td>\r\n                    </tr>\r\n                    <tr>\r\n                        <td bgcolor=\"#ffffff\" colspan=\"2\">\r\n                        <table cellspacing=\"2\" cellpadding=\"2\" width=\"95%\" align=\"center\" border=\"0\">\r\n                            <tbody>\r\n                                <tr>\r\n                                    <td class=\"dgtitle2\" valign=\"top\" align=\"right\" width=\"8%\">回答:</td>\r\n                                    <td width=\"92%\">否。按招标文件的招标编号（SCJ2011006）填写。</td>\r\n                                </tr>\r\n                            </tbody>\r\n                        </table>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('232', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td bgcolor=\"#f2f2f2\" height=\"1\">&nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#9c7da8\" height=\"2\">&nbsp;</td>\r\n        </tr>\r\n        <tr>\r\n            <td bgcolor=\"#e1e1e1\">\r\n            <table cellspacing=\"1\" cellpadding=\"4\" width=\"100%\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td class=\"cRed2\" align=\"center\" width=\"61\" bgcolor=\"#f2f2f2\">问题1</td>\r\n                        <td width=\"598\" bgcolor=\"#ffffff\">请问招标编号是否按按招标公告中的工程编号填写?</td>\r\n                    </tr>\r\n                    <tr>\r\n                        <td bgcolor=\"#ffffff\" colspan=\"2\">\r\n                        <table cellspacing=\"2\" cellpadding=\"2\" width=\"95%\" align=\"center\" border=\"0\">\r\n                            <tbody>\r\n                                <tr>\r\n                                    <td class=\"dgtitle2\" valign=\"top\" align=\"right\" width=\"8%\">回答:</td>\r\n                                    <td width=\"92%\">否。按招标文件的招标编号（SCJ2011006）填写。</td>\r\n                                </tr>\r\n                            </tbody>\r\n                        </table>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('233', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <table width=\"80\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td align=\"center\">\r\n                        <div align=\"center\">公告编号</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">\r\n            <table width=\"230\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>汕建交[2011]11</td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <table width=\"80\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <div align=\"center\">工程编号</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">\r\n            <table width=\"240\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>440500201105270101</td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">粤东高级技工学校学生宿舍及室外体育场建设项目</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标人</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">广东省粤东高级技工学校</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88307771</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕头市城市建设监理公司</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88910188-809</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程地点</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市濠江区东湖路粤东高级技工学校北山湾校区</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设规模</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">总建筑面积10106平方米，包括3栋学生宿舍、田径运动场、边坡及挡土墙等，工程造价约2320万元。</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">资金来源 <br />\r\n            及构成</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">自筹100%</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标内容</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">\r\n            <p>按广东南雅建筑工程设计有限公司设计的工程设计图纸内容和委托汕头市粤建工程造价咨询有限公司编制工程造价预算书内容。主要包括土建、电气安装、给排水、室外体育场及配套设施项目等。</p>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">开标日期</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">2011-6-17</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('234', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <table width=\"80\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td align=\"center\">\r\n                        <div align=\"center\">公告编号</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">\r\n            <table width=\"230\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>汕建交[2011]11</td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <table width=\"80\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <div align=\"center\">工程编号</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">\r\n            <table width=\"240\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>440500201105270101</td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">粤东高级技工学校学生宿舍及室外体育场建设项目</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标人</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">广东省粤东高级技工学校</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88307771</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕头市城市建设监理公司</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88910188-809</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程地点</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市濠江区东湖路粤东高级技工学校北山湾校区</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设规模</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">总建筑面积10106平方米，包括3栋学生宿舍、田径运动场、边坡及挡土墙等，工程造价约2320万元。</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">资金来源 <br />\r\n            及构成</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">自筹100%</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标内容</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">\r\n            <p>按广东南雅建筑工程设计有限公司设计的工程设计图纸内容和委托汕头市粤建工程造价咨询有限公司编制工程造价预算书内容。主要包括土建、电气安装、给排水、室外体育场及配套设施项目等。</p>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">开标日期</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">2011-6-17</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('235', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">\r\n            <table width=\"230\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>汕建交[2011]11</td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <table width=\"80\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <div align=\"center\">工程编号</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">\r\n            <table width=\"240\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>440500201105270101</td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">粤东高级技工学校学生宿舍及室外体育场建设项目</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标人</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">广东省粤东高级技工学校</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88307771</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕头市城市建设监理公司</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88910188-809</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程地点</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市濠江区东湖路粤东高级技工学校北山湾校区</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设规模</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">总建筑面积10106平方米，包括3栋学生宿舍、田径运动场、边坡及挡土墙等，工程造价约2320万元。</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">资金来源 <br />\r\n            及构成</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">自筹100%</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标内容</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">\r\n            <p>按广东南雅建筑工程设计有限公司设计的工程设计图纸内容和委托汕头市粤建工程造价咨询有限公司编制工程造价预算书内容。主要包括土建、电气安装、给排水、室外体育场及配套设施项目等。</p>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">开标日期</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">2011-6-17</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('236', '<p>\r\n<table cellspacing=\"1\" cellpadding=\"4\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">\r\n            <table width=\"230\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>汕建交[2011]11</td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <table width=\"80\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <div align=\"center\">工程编号</div>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">\r\n            <table width=\"240\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>440500201105270101</td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程名称</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">粤东高级技工学校学生宿舍及室外体育场建设项目</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标人</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">广东省粤东高级技工学校</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88307771</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标代理机构</div>\r\n            </td>\r\n            <td width=\"241\" bgcolor=\"#ffffff\">汕头市城市建设监理公司</td>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">联系电话</div>\r\n            </td>\r\n            <td width=\"240\" bgcolor=\"#ffffff\">0754-88910188-809</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">工程地点</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">汕头市濠江区东湖路粤东高级技工学校北山湾校区</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">建设规模</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">总建筑面积10106平方米，包括3栋学生宿舍、田径运动场、边坡及挡土墙等，工程造价约2320万元。</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">资金来源 <br />\r\n            及构成</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">自筹100%</td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">招标内容</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">\r\n            <p>按广东南雅建筑工程设计有限公司设计的工程设计图纸内容和委托汕头市粤建工程造价咨询有限公司编制工程造价预算书内容。主要包括土建、电气安装、给排水、室外体育场及配套设施项目等。</p>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td width=\"80\" bgcolor=\"#f2f2f2\">\r\n            <div align=\"center\">开标日期</div>\r\n            </td>\r\n            <td bgcolor=\"#ffffff\" colspan=\"3\">2011-6-17</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('237', '<p>电气安装、给据汕头市纠风办、工商局、物价局《关于印发〈汕头市关于开展治理公共服务行业侵害群众消费权益的方案〉的通知》精神，为规范燃气行业经营行为，维护广大群众的消费权益和良好的市场竞争秩序，我局决定开展治理燃气行业侵害群众消费权益行为工作，现将《汕头市关于开展治理燃气行业侵害群众消费权益的方案》印发给你们，请认真贯彻执行。</p>\r\n<p align=\"right\">二○○九年七月十三日</p>\r\n<p align=\"center\">汕头市关于开展治理燃气行业</p>\r\n<p align=\"center\">侵害群众消费权益的方案</p>\r\n<p>　　根据汕头市纠风办、工商局、物价局《关于印发〈汕头市关于开展治理公共服务行业侵害群众消费权益的方案〉的通知》精神，为规范燃气行业经营行为，维护广大群众的消费权益和良好的市场竞争秩序，特制定本方案。</p>\r\n<p>　　 一、指导思想</p>\r\n<p>　　 以邓小平理论和&ldquo;三个代表&rdquo;重要思想为指导，认</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('238', '<p>据汕头市纠风办、工商局、物价局《关于印发〈汕头市关于开展治理公共服务行业侵害群众消费权益的方案〉的通知》精神，为规范燃气行业经营行为，维护广大群众的消费权益和良好的市场竞争秩序，我局决定开展治理燃气行业侵害群众消费权益行为工作，现将《汕头市关于开展治理燃气行业侵害群众消费权益的方案》印发给你们，请认真贯彻执行。</p>\r\n<p align=\"right\">二○○九年七月十三日</p>\r\n<p align=\"center\">汕头市关于开展治理燃气行业</p>\r\n<p align=\"center\">侵害群众消费权益的方案</p>\r\n<p>　　根据汕头市纠风办、工商局、物价局《关于印发〈汕头市关于开展治理公共服务行业侵害群众消费权益的方案〉的通知》精神，为规范燃气行业经营行为，维护广大群众的消费权益和良好的市场竞争秩序，特制定本方案。</p>\r\n<p>　　 一、指导思想</p>\r\n<p>　　 以邓小平理论和&ldquo;三个代表&rdquo;重要思想为指导，认</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('239', '<p>局、物价局《关据汕头市纠风办、工商局、物价局《关于印发〈汕头市关于开展治理公共服务行业侵害群众消费权益的方案〉的通知》精神，为规范燃气行业经营行为，维护广大群众的消费权益和良好的市场竞争秩序，我局决定开展治理燃气行业侵害群众消费权益行为工作，现将《汕头市关于开展治理燃气行业侵害群众消费权益的方案》印发给你们，请认真贯彻执行。</p>\r\n<p align=\"right\">二○○九年七月十三日</p>\r\n<p align=\"center\">汕头市关于开展治理燃气行业</p>\r\n<p align=\"center\">侵害群众消费权益的方案</p>\r\n<p>　　根据汕头市纠风办、工商局、物价局《关于印发〈汕头市关于开展治理公共服务行业侵害群众消费权益的方案〉的通知》精神，为规范燃气行业经营行为，维护广大群众的消费权益和良好的市场竞争秩序，特制定本方案。</p>\r\n<p>　　 一、指导思想</p>\r\n<p>　　 以邓小平理论和&ldquo;三个代表&rdquo;重要思想为指导，认</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('240', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"740\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td height=\"10\">&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<table height=\"29\" cellspacing=\"0\" cellpadding=\"0\" width=\"705\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td align=\"center\" width=\"47\" background=\"images/newstitlebg.gif\"><strong>序号</strong></td>\r\n            <td width=\"9\" background=\"images/newstitlebg.gif\"><img height=\"17\" src=\"http://www.stjs.gov.cn/rqgl/images/line_news.gif\" width=\"2\" alt=\"\" /></td>\r\n            <td align=\"center\" width=\"260\" background=\"images/newstitlebg.gif\"><strong>企业名称</strong></td>\r\n            <td width=\"10\" background=\"images/newstitlebg.gif\"><img height=\"17\" src=\"http://www.stjs.gov.cn/rqgl/images/line_news.gif\" width=\"2\" alt=\"\" /></td>\r\n            <td align=\"center\" width=\"250\" background=\"images/newstitlebg.gif\"><strong>联系地址</strong></td>\r\n            <td width=\"10\" background=\"images/newstitlebg.gif\"><img height=\"17\" src=\"http://www.stjs.gov.cn/rqgl/images/line_news.gif\" width=\"2\" alt=\"\" /></td>\r\n            <td align=\"center\" background=\"images/newstitlebg.gif\"><strong>电话</strong></td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<table cellspacing=\"0\" cellpadding=\"4\" width=\"705\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">1</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司综合燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市新歧南路6号118</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8227088</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">2</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司珠池燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市珠池路华兴园2幢底层14号铺面</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8990035</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">3</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司中山燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;民权路17号02</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8270052</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">4</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司中山诚信燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;中山路353号</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8270841</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">5</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司振达燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市龙眼路73号之6</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8251430</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">6</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司永发燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;永泰路147号</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8433197</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">7</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司一直燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市二马路57号</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8101543</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">8</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司兴业燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;商业街4号楼下</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8270922</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">9</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新兴金砂燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市金砂新厝大路东四巷12号</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8301123</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">10</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新兴花园燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市花园路2幢107</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8459944</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">11</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新华燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市金湖路2号之17</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8106958</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">12</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新湖燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市陵海大路14号01</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8550624</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">13</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新潮燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;商平路15号10</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8443721</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">14</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司威达燃气经营部</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('241', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"740\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td height=\"10\">&nbsp;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<table height=\"29\" cellspacing=\"0\" cellpadding=\"0\" width=\"705\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td align=\"center\" width=\"47\" background=\"images/newstitlebg.gif\"><strong>序号</strong></td>\r\n            <td width=\"9\" background=\"images/newstitlebg.gif\"><img height=\"17\" src=\"http://www.stjs.gov.cn/rqgl/images/line_news.gif\" width=\"2\" alt=\"\" /></td>\r\n            <td align=\"center\" width=\"260\" background=\"images/newstitlebg.gif\"><strong>企业名称</strong></td>\r\n            <td width=\"10\" background=\"images/newstitlebg.gif\"><img height=\"17\" src=\"http://www.stjs.gov.cn/rqgl/images/line_news.gif\" width=\"2\" alt=\"\" /></td>\r\n            <td align=\"center\" width=\"250\" background=\"images/newstitlebg.gif\"><strong>联系地址</strong></td>\r\n            <td width=\"10\" background=\"images/newstitlebg.gif\"><img height=\"17\" src=\"http://www.stjs.gov.cn/rqgl/images/line_news.gif\" width=\"2\" alt=\"\" /></td>\r\n            <td align=\"center\" background=\"images/newstitlebg.gif\"><strong>电话</strong></td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<table cellspacing=\"0\" cellpadding=\"4\" width=\"705\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">1</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司综合燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市新歧南路6号118</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8227088</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">2</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司珠池燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市珠池路华兴园2幢底层14号铺面</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8990035</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">3</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司中山燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;民权路17号02</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8270052</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">4</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司中山诚信燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;中山路353号</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8270841</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">5</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司振达燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市龙眼路73号之6</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8251430</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">6</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司永发燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;永泰路147号</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8433197</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">7</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司一直燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市二马路57号</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8101543</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">8</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司兴业燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;商业街4号楼下</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8270922</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">9</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新兴金砂燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市金砂新厝大路东四巷12号</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8301123</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">10</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新兴花园燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市花园路2幢107</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8459944</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">11</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新华燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市金湖路2号之17</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8106958</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">12</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新湖燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;汕头市陵海大路14号01</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8550624</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">13</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司新潮燃气经营部</td>\r\n            <td class=\"newsline7\" align=\"center\" width=\"256\">&nbsp;商平路15号10</td>\r\n            <td class=\"newsline8\" align=\"center\" width=\"119\" bgcolor=\"#f9f9f9\">&nbsp;8443721</td>\r\n        </tr>\r\n        <tr>\r\n            <td class=\"newsline7\" align=\"center\" width=\"37\" height=\"29\">14</td>\r\n            <td class=\"newsline7\" width=\"261\" bgcolor=\"#f9f9f9\">汕头市龙翔石油气有限公司威达燃气经营部</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('242', '<p>冬、春季节是市民使用燃气器具不当，造成直接经济损失一氧化碳中毒事故的高发期。据悉，今年以来，在我市和梅县因一氧化碳中毒事故就发生 4起，造成2人死亡、2人住院。3日晚上，梅县白宫某公司一名青年男工在宿舍洗澡时紧闭门窗，导致煤气中毒，被人发现时已停止呼吸，经抢救无效死亡。当晚，白宫太平村一名10岁男孩也是洗澡因煤气泄漏中毒，幸亏抢救及时现已无生命危险。6日晚上，澄海某中学高二有一女生，洗澡时因煤气中毒，先后送至华侨医院和市中心医院抢救无效死亡。7日晚，某信息公司一女孩洗澡因煤气泄漏中毒，幸亏及时发现而没有发生生命危险。以上都是燃气热水器使用不当造成一氧化碳中毒事故。</p>\r\n<p>　　为确保您的生命财产安全和家庭幸福，您在使用燃气器具时，一定要保持室内通风，防止一氧化碳中毒。请查看您家中燃气热水器类型，对照下列安全使用条件：一是强制给排气式燃气热水器 (简称强制平衡式)，这类燃气热水器能将燃烧时需要的空气和燃烧后排放的废气通过烟道在室外进行强制交换，有效地保证室内空气新鲜，可安装在浴室内。二是自然给排气式(简称平衡式)燃气热水器，这类燃气热水器能将燃烧时需要的空气和燃烧后排放的废气通过烟道进行自然交换，较好地保证室内空气新鲜，可安装在浴室内。三是强制排气式燃气热水器，这类燃气热水器应安装在浴室外，必须正确安装烟道，安装热水器的房间在使用热水器时必须保障通风良好。四是自然排气式(简称烟道式)燃气热水器，这类燃气热</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('243', '<p>冬、春季节是市民使用燃气器具不当，造成直接经济损失一氧化碳中毒事故的高发期。据悉，今年以来，在我市和梅县因一氧化碳中毒事故就发生 4起，造成2人死亡、2人住院。3日晚上，梅县白宫某公司一名青年男工在宿舍洗澡时紧闭门窗，导致煤气中毒，被人发现时已停止呼吸，经抢救无效死亡。当晚，白宫太平村一名10岁男孩也是洗澡因煤气泄漏中毒，幸亏抢救及时现已无生命危险。6日晚上，澄海某中学高二有一女生，洗澡时因煤气中毒，先后送至华侨医院和市中心医院抢救无效死亡。7日晚，某信息公司一女孩洗澡因煤气泄漏中毒，幸亏及时发现而没有发生生命危险。以上都是燃气热水器使用不当造成一氧化碳中毒事故。</p>\r\n<p>　　为确保您的生命财产安全和家庭幸福，您在使用燃气器具时，一室内通风，防止一氧化碳中毒。请查看您家中燃气热水器类型，对照下列安全使用条件：一是强制给排气式燃气热水器 (简称强制平衡式)，这类燃气热水器能将燃烧时需要的空气和燃烧后排放的废气通过烟道在室外进行强制交换，有效地保证室内空气新鲜，可安装在浴室内。二是自然给排气式(简称平衡式)燃气热水器，这类燃气热水器能将燃烧时需要的空气和燃烧后排放的废气通过烟道进行自然交换，较好地保证室内空气新鲜，可安装在浴室内。三是强制排气式燃气热水器，这类燃气热水器应安装在浴室外，必须正确安装烟道，安装热水器的房间在使用热水器时必须保障通风良好。四是自然排气式(简称烟道式)燃气热水器，这类燃气热</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('244', '<p>定要保持\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"580\" align=\"center\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <p>　　燃气是液态石油气经过气化 (强制气化或自然气化)后变成气态石油气，然后送至各炉灶(热水器)等，作为供应居民的气体燃料。其构成及基本特点如下：<br />\r\n            　　1、成份：丙烷、丁烷、丙烯、丁稀等。 <br />\r\n            　　2、特性：无毒，本身无味(但为了泄漏时能及时发觉，在生产时人为地加入特殊臭味)，易燃、易爆。 <br />\r\n            　　3、重量：1.9&mdash;2.5千克／标米 3 。 <br />\r\n            　　4、比重：1.5&mdash;2.0，比空气重，一旦泄漏便会沉积于地面、低洼、沟底等处。 <br />\r\n            　　5、爆炸极限：1.5&mdash;9.5％(体积浓度)，液化气在此浓度范围内遇到明火或火花极易发生爆炸。 <br />\r\n            　　6、燃烧特点：管道燃气燃烧时，必须有约30倍的空气混合。一般分两次供给，即先向燃烧器前面的空气门(俗称风门)送入一次空气约70％，使之成为混合气；另外30％的空气在混合气燃烧时由火孔器(俗称炉头)补充,若空气调节不好就会影响燃烧效果。 <br />\r\n            　　7、火焰颜色：液化石油气燃烧时的正常火焰颜色应该是浅蓝色、无烟。如果火焰发黄有烟，就是一次空气不足。此时液化石油气没有完全燃烧，有一部分经热解变成碳的微小粒子即煤烟，而成废料。这不仅造成浪费，而且还会产生容易使人中毒的一氧化碳，所以使用液化石油气必须注意调节火焰。 <br />\r\n            　　8、燃烧后产物：液化石油气燃烧后，产生大量的二氧化碳和水份。例如：1立方米丙烷气体燃烧后生成了3立方米的二氧化碳和4立方米的水蒸气。所以，在室内如果长时间的燃烧液化石油气，应进行适当的通风和换气。 <br />\r\n            　　9、容易挥发：液化石油气如果以液体状态流出时，则会变成约250倍的气体而扩散。<br />\r\n            　　10、易燃易爆：液化石油气和空气混合后易燃、易爆，无论气温多麽寒冷，遇到明火或火花极易发生燃烧或爆炸。<br />\r\n            &nbsp;</p>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('245', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td><img height=\"7\" src=\"http://www.stjs.gov.cn/rqgl/images/null.gif\" width=\"200\" alt=\"\" /></td>\r\n        </tr>\r\n        <tr>\r\n            <td><img height=\"36\" src=\"http://www.stjs.gov.cn/rqgl/images/title3.gif\" width=\"704\" alt=\"\" /></td>\r\n        </tr>\r\n        <tr>\r\n            <td align=\"center\" background=\"../images/titlebg.gif\">\r\n            <table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <p>汕头新奥燃气有限公司<br />\r\n                        客服电话：0754-88995628<br />\r\n                        抢修电话：0754-88620473<br />\r\n                        营业厅地址：<br />\r\n                        &nbsp;</p>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('246', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"704\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td><img height=\"7\" src=\"http://www.stjs.gov.cn/rqgl/images/null.gif\" width=\"200\" alt=\"\" /></td>\r\n        </tr>\r\n        <tr>\r\n            <td><img height=\"36\" src=\"http://www.stjs.gov.cn/rqgl/images/title3.gif\" width=\"704\" alt=\"\" /></td>\r\n        </tr>\r\n        <tr>\r\n            <td align=\"center\" background=\"../images/titlebg.gif\">\r\n            <table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n                <tbody>\r\n                    <tr>\r\n                        <td>\r\n                        <p>汕头新奥燃气有限公司<br />\r\n                        客服电话：0754-88995628<br />\r\n                        抢修电话：0754-88620473<br />\r\n                        营业厅地址：<br />\r\n                        &nbsp;</p>\r\n                        </td>\r\n                    </tr>\r\n                </tbody>\r\n            </table>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('247', '<p align=\"center\">中华人民共和国主席令</p>\r\n<p align=\"center\">第六十二号</p>\r\n<p>　　《中华人民共和国物权法》已由中华人民共和国第十届全国人民代表大会第五次会议于2007年3月16日通过，现予公布，自2007年10月1日起施行。</p>\r\n<p align=\"right\">中华人民共和国主席　胡锦涛</p>\r\n<p align=\"right\">2007年3月16日</p>\r\n<p align=\"center\">中华人民共和国物权法</p>\r\n<p align=\"center\">（2007年3月16日第十届全国人民代表大会第五次会议通过）</p>\r\n<p>　　目 录</p>\r\n<p>　　第一编 总 则</p>\r\n<p>　　第一章 基本原则</p>\r\n<p>　　第二章 物权的设立、变更、转让和消灭</p>\r\n<p>　　第一节 不动产登记</p>\r\n<p>　　第二节 动产交付</p>\r\n<p>　　第三节 其他规定</p>\r\n<p>　　第三章 物权的保护</p>\r\n<p>　　第二编 所有权</p>\r\n<p>　　第四章 一般规定</p>\r\n<p>　　第五章 国家所有权和集体所有权、私人所有权</p>\r\n<p>　　第六章 业主的建筑物区分所有权</p>\r\n<p>　　第七章 相邻关系</p>\r\n<p>　　第八章 共有</p>\r\n<p>　　第九章 所有权取得的特别规定</p>\r\n<p>　　第三编 用益物权</p>\r\n<p>　　第十章 一般规定</p>\r\n<p>　　第十一章 土地承包经营权</p>\r\n<p>　　第十二章 建设用地使用权</p>\r\n<p>　　第十三章 宅基地使用权</p>\r\n<p>　　第十四章 地役权</p>\r\n<p>　　第四编 担保物权</p>\r\n<p>　　第十五章 一般规定</p>\r\n<p>　　第十六章 抵押权</p>\r\n<p>　　第一节 一般抵押权</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('248', '<p align=\"center\">中华人民共和国主席令</p>\r\n<p align=\"center\">第六十二号</p>\r\n<p>　　《中华人民共和国物权法》已由中华人民共和国第十届全国人民代表大会第五次会议于2007年3月16日通过，现予公布，自2007年10月1日起施行。</p>\r\n<p align=\"right\">中华人民共和国主席　胡锦涛</p>\r\n<p align=\"right\">2007年3月16日</p>\r\n<p align=\"center\">中华人民共和国物权法</p>\r\n<p align=\"center\">（2007年3月16日第十届全国人民代表大会第五次会议通过）</p>\r\n<p>　　目 录</p>\r\n<p>　　第一编 总 则</p>\r\n<p>　　第一章 基本原则</p>\r\n<p>　　第二章 物权的设立、变更、转让和消灭</p>\r\n<p>　　第一节 不动产登记</p>\r\n<p>　　第二节 动产交付</p>\r\n<p>　　第三节 其他规定</p>\r\n<p>　　第三章 物权的保护</p>\r\n<p>　　第二编 所有权</p>\r\n<p>　　第四章 一般规定</p>\r\n<p>　　第五章 国家所有权和集体所有权、私人所有权</p>\r\n<p>　　第六章 业主的建筑物区分所有权</p>\r\n<p>　　第七章 相邻关系</p>\r\n<p>　　第八章 共有</p>\r\n<p>　　第九章 所有权取得的特别规定</p>\r\n<p>　　第三编 用益物权</p>\r\n<p>　　第十章 一般规定</p>\r\n<p>　　第十一章 土地承包经营权</p>\r\n<p>　　第十二章 建设用地使用权</p>\r\n<p>　　第十三章 宅基地使用权</p>\r\n<p>　　第十四章 地役权</p>\r\n<p>　　第四编 担保物权</p>\r\n<p>　　第十五章 一般规定</p>\r\n<p>　　第十六章 抵押权</p>\r\n<p>　　第一节 一般抵押权</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('249', '<p>&nbsp;一般规定</p>\r\n<p align=\"center\">中华人民共和国主席令</p>\r\n<p align=\"center\">第六十二号</p>\r\n<p>　　《中华人民共和国物权法》已由中华人民共和国第十届全国人民代表大会第五次会议于2007年3月16日通过，现予公布，自2007年10月1日起施行。</p>\r\n<p align=\"right\">中华人民共和国主席　胡锦涛</p>\r\n<p align=\"right\">2007年3月16日</p>\r\n<p align=\"center\">中华人民共和国物权法</p>\r\n<p align=\"center\">（2007年3月16日第十届全国人民代表大会第五次会议通过）</p>\r\n<p>　　目 录</p>\r\n<p>　　第一编 总 则</p>\r\n<p>　　第一章 基本原则</p>\r\n<p>　　第二章 物权的设立、变更、转让和消灭</p>\r\n<p>　　第一节 不动产登记</p>\r\n<p>　　第二节 动产交付</p>\r\n<p>　　第三节 其他规定</p>\r\n<p>　　第三章 物权的保护</p>\r\n<p>　　第二编 所有权</p>\r\n<p>　　第四章 一般规定</p>\r\n<p>　　第五章 国家所有权和集体所有权、私人所有权</p>\r\n<p>　　第六章 业主的建筑物区分所有权</p>\r\n<p>　　第七章 相邻关系</p>\r\n<p>　　第八章 共有</p>\r\n<p>　　第九章 所有权取得的特别规定</p>\r\n<p>　　第三编 用益物权</p>\r\n<p>　　第十章 一般规定</p>\r\n<p>　　第十一章 土地承包经营权</p>\r\n<p>　　第十二章 建设用地使用权</p>\r\n<p>　　第十三章 宅基地使用权</p>\r\n<p>　　第十四章 地役权</p>\r\n<p>　　第四编 担保物权</p>\r\n<p>　　第十五章 一般规定</p>\r\n<p>　　第十六章 抵押权</p>\r\n<p>　　第一节 一般抵押权</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('250', '<p>&nbsp;一般规定</p>\r\n<p align=\"center\">中华人民共和国主席令</p>\r\n<p align=\"center\">第六十二号</p>\r\n<p>　　《中华人民共和国物权法》已由中华人民共和国第十届全国人民代表大会第五次会议于2007年3月16日通过，现予公布，自2007年10月1日起施行。</p>\r\n<p align=\"right\">中华人民共和国主席　胡锦涛</p>\r\n<p align=\"right\">2007年3月16日</p>\r\n<p align=\"center\">中华人民共和国物权法</p>\r\n<p align=\"center\">（2007年3月16日第十届全国人民代表大会第五次会议通过）</p>\r\n<p>　　目 录</p>\r\n<p>　　第一编 总 则</p>\r\n<p>　　第一章 基本原则</p>\r\n<p>　　第二章 物权的设立、变更、转让和消灭</p>\r\n<p>　　第一节 不动产登记</p>\r\n<p>　　第二节 动产交付</p>\r\n<p>　　第三节 其他规定</p>\r\n<p>　　第三章 物权的保护</p>\r\n<p>　　第二编 所有权</p>\r\n<p>　　第四章 一般规定</p>\r\n<p>　　第五章 国家所有权和集体所有权、私人所有权</p>\r\n<p>　　第六章 业主的建筑物区分所有权</p>\r\n<p>　　第七章 相邻关系</p>\r\n<p>　　第八章 共有</p>\r\n<p>　　第九章 所有权取得的特别规定</p>\r\n<p>　　第三编 用益物权</p>\r\n<p>　　第十章 一般规定</p>\r\n<p>　　第十一章 土地承包经营权</p>\r\n<p>　　第十二章 建设用地使用权</p>\r\n<p>　　第十三章 宅基地使用权</p>\r\n<p>　　第十四章 地役权</p>\r\n<p>　　第四编 担保物权</p>\r\n<p>　　第十五章 一般规定</p>\r\n<p>　　第十六章 抵押权</p>\r\n<p>　　第一节 一般抵押权</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('251', '<p align=\"center\">中华人民共和国主席令</p>\r\n<p align=\"center\">第六十二号</p>\r\n<p>　　《中华人民共和国物权法》已由中华人民共和国第十届全国人民代表大会第五次会议于2007年3月16日通过，现予公布，自2007年10月1日起施行。</p>\r\n<p align=\"right\">中华人民共和国主席　胡锦涛</p>\r\n<p align=\"right\">2007年3月16日</p>\r\n<p align=\"center\">中华人民共和国物权法</p>\r\n<p align=\"center\">（2007年3月16日第十届全国人民代表大会第五次会议通过）</p>\r\n<p>　　目 录</p>\r\n<p>　　第一编 总 则</p>\r\n<p>　　第一章 基本原则</p>\r\n<p>　　第二章 物权的设立、变更、转让和消灭</p>\r\n<p>　　第一节 不动产登记</p>\r\n<p>　　第二节 动产交付</p>\r\n<p>　　第三节 其他规定</p>\r\n<p>　　第三章 物权的保护</p>\r\n<p>　　第二编 所有权</p>\r\n<p>　　第四章 一般规定</p>\r\n<p>　　第五章 国家所有权和集体所有权、私人所有权</p>\r\n<p>　　第六章 业主的建筑物区分所有权</p>\r\n<p>　　第七章 相邻关系</p>\r\n<p>　　第八章 共有</p>\r\n<p>　　第九章 所有权取得的特别规定</p>\r\n<p>　　第三编 用益物权</p>\r\n<p>　　第十章 一般规定</p>\r\n<p>　　第十一章 土地承包经营权</p>\r\n<p>　　第十二章 建设用地使用权</p>\r\n<p>　　第十三章 宅基地使用权</p>\r\n<p>　　第十四章 地役权</p>\r\n<p>　　第四编 担保物权</p>\r\n<p>　　第十五章 一般规定</p>\r\n<p>　　第十六章 抵押权</p>\r\n<p>　　第一节 一般抵押权</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('252', '<p align=\"center\">中华人民共和国主席令</p>\r\n<p align=\"center\">第六十二号</p>\r\n<p>　　《中华人民共和国物权法》已由中华人民共和国第十届全国人民代表大会第五次会议于2007年3月16日通过，现予公布，自2007年10月1日起施行。</p>\r\n<p align=\"right\">中华人民共和国主席　胡锦涛</p>\r\n<p align=\"right\">2007年3月16日</p>\r\n<p align=\"center\">中华人民共和国物权法</p>\r\n<p align=\"center\">（2007年3月16日第十届全国人民代表大会第五次会议通过）</p>\r\n<p>　　目 录</p>\r\n<p>　　第一编 总 则</p>\r\n<p>　　第一章 基本原则</p>\r\n<p>　　第二章 物权的设立、变更、转让和消灭</p>\r\n<p>　　第一节 不动产登记</p>\r\n<p>　　第二节 动产交付</p>\r\n<p>　　第三节 其他规定</p>\r\n<p>　　第三章 物权的保护</p>\r\n<p>　　第二编 所有权</p>\r\n<p>　　第四章 一般规定</p>\r\n<p>　　第五章 国家所有权和集体所有权、私人所有权</p>\r\n<p>　　第六章 业主的建筑物区分所有权</p>\r\n<p>　　第七章 相邻关系</p>\r\n<p>　　第八章 共有</p>\r\n<p>　　第九章 所有权取得的特别规定</p>\r\n<p>　　第三编 用益物权</p>\r\n<p>　　第十章 一般规定</p>\r\n<p>　　第十一章 土地承包经营权</p>\r\n<p>　　第十二章 建设用地使用权</p>\r\n<p>　　第十三章 宅基地使用权</p>\r\n<p>　　第十四章 地役权</p>\r\n<p>　　第四编 担保物权</p>\r\n<p>　　第十五章 一般规定</p>\r\n<p>　　第十六章 抵押权</p>\r\n<p>　　第一节 一般抵押权</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('253', '<p align=\"center\">中华人民共和国主席令</p>\r\n<p align=\"center\">第六十二号</p>\r\n<p>　　《中华人民共和国物权法》已由中华人民共和国第十届全国人民代表大会第五次会议于2007年3月16日通过，现予公布，自2007年10月1日起施行。</p>\r\n<p align=\"right\">中华人民共和国主席　胡锦涛</p>\r\n<p align=\"right\">2007年3月16日</p>\r\n<p align=\"center\">中华人民共和国物权法</p>\r\n<p align=\"center\">（2007年3月16日第十届全国人民代表大会第五次会议通过）</p>\r\n<p>　　目 录</p>\r\n<p>　　第一编 总 则</p>\r\n<p>　　第一章 基本原则</p>\r\n<p>　　第二章 物权的设立、变更、转让和消灭</p>\r\n<p>　　第一节 不动产登记</p>\r\n<p>　　第二节 动产交付</p>\r\n<p>　　第三节 其他规定</p>\r\n<p>　　第三章 物权的保护</p>\r\n<p>　　第二编 所有权</p>\r\n<p>　　第四章 一般规定</p>\r\n<p>　　第五章 国家所有权和集体所有权、私人所有权</p>\r\n<p>　　第六章 业主的建筑物区分所有权</p>\r\n<p>　　第七章 相邻关系</p>\r\n<p>　　第八章 共有</p>\r\n<p>　　第九章 所有权取得的特别规定</p>\r\n<p>　　第三编 用益物权</p>\r\n<p>　　第十章 一般规定</p>\r\n<p>　　第十一章 土地承包经营权</p>\r\n<p>　　第十二章 建设用地使用权</p>\r\n<p>　　第十三章 宅基地使用权</p>\r\n<p>　　第十四章 地役权</p>\r\n<p>　　第四编 担保物权</p>\r\n<p>　　第十五章 一般规定</p>\r\n<p>　　第十六章 抵押权</p>\r\n<p>　　第一节 一般抵押权</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('254', '<p>般规定</p>\r\n<p align=\"center\">中华人民共和国主席令</p>\r\n<p align=\"center\">第六十二号</p>\r\n<p>　　《中华人民共和国物权法》已由中华人民共和国第十届全国人民代表大会第五次会议于2007年3月16日通过，现予公布，自2007年10月1日起施行。</p>\r\n<p align=\"right\">中华人民共和国主席　胡锦涛</p>\r\n<p align=\"right\">2007年3月16日</p>\r\n<p align=\"center\">中华人民共和国物权法</p>\r\n<p align=\"center\">（2007年3月16日第十届全国人民代表大会第五次会议通过）</p>\r\n<p>　　目 录</p>\r\n<p>　　第一编 总 则</p>\r\n<p>　　第一章 基本原则</p>\r\n<p>　　第二章 物权的设立、变更、转让和消灭</p>\r\n<p>　　第一节 不动产登记</p>\r\n<p>　　第二节 动产交付</p>\r\n<p>　　第三节 其他规定</p>\r\n<p>　　第三章 物权的保护</p>\r\n<p>　　第二编 所有权</p>\r\n<p>　　第四章 一般规定</p>\r\n<p>　　第五章 国家所有权和集体所有权、私人所有权</p>\r\n<p>　　第六章 业主的建筑物区分所有权</p>\r\n<p>　　第七章 相邻关系</p>\r\n<p>　　第八章 共有</p>\r\n<p>　　第九章 所有权取得的特别规定</p>\r\n<p>　　第三编 用益物权</p>\r\n<p>　　第十章 一般规定</p>\r\n<p>　　第十一章 土地承包经营权</p>\r\n<p>　　第十二章 建设用地使用权</p>\r\n<p>　　第十三章 宅基地使用权</p>\r\n<p>　　第十四章 地役权</p>\r\n<p>　　第四编 担保物权</p>\r\n<p>　　第十五章 一般规定</p>\r\n<p>　　第十六章 抵押权</p>\r\n<p>　　第一节 一般抵押权</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('255', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <p>机关各科室、各有关单位：</p>\r\n            <p>　　现将《汕头建设网信息发布管理规定》印发给你们，请认真贯彻执行。</p>\r\n            <p align=\"right\">二〇〇九年六月十七日</p>\r\n            <p align=\"center\">汕头建设网信息发布管理规定</p>\r\n            <p align=\"left\">　　第一条　为加强汕头建设网信息发布的管理，确保网络安全、可靠、稳定地运行，促进网站的健康发展，根据《中华人民共和国计算机信息网络国际联网管理暂行规定》和《计算机信息网络国际联网安全保护管理办法》的有关规定，结合汕头建设网的实际，制定本规定。</p>\r\n            <p align=\"left\">　　第二条　汕头建设网发布的信息包括政务信息、企业信息、个人信息和公众咨询、建议、提问等其他信息。网站信息的发布实行审核制度，未经审核的，一律不予发布。</p>\r\n            <p align=\"left\">　　第三条　汕头市建设局各科室、直属各事业单位信息员撰写的政务信息须经所在部门负责人、办公室审核、分管领导同意后，由网站管理人员上网发布。</p>\r\n            <p align=\"left\">　　汕头市建设系统各归口管理单位、各区县建设局信息员撰写的政务信息须经所在部门负责人、办公室审核后，由网站</p>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('256', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <p>机关各科室、各有关单位：</p>\r\n            <p>　　现将《汕头建设网信息发布管理规定》印发给你们，请认真贯彻执行。</p>\r\n            <p align=\"right\">二〇〇九年六月十七日</p>\r\n            <p align=\"center\">汕头建设网信息发布管理规定</p>\r\n            <p align=\"left\">　　第一条　为加强汕头建设网信息发布的管理，确保网络安全、可靠、稳定地运行，促进网站的健康发展，根据《中华人民共和国计算机信息网络国际联网管理暂行规定》和《计算机信息网络国际联网安全保护管理办法》的有关规定，结合汕头建设网的实际，制定本规定。</p>\r\n            <p align=\"left\">　　第二条　汕头建设网发布的信息包括政务信息、企业信息、个人信息和公众咨询、建议、提问等其他信息。网站信息的发布实行审核制度，未经审核的，一律不予发布。</p>\r\n            <p align=\"left\">　　第三条　汕头市建设局各科室、直属各事业单位信息员撰写的政务信息须经所在部门负责人、办公室审核、分管领导同意后，由网站管理人员上网发布。</p>\r\n            <p align=\"left\">　　汕头市建设系统各归口管理单位、各区县建设局信息员撰写的政务信息须经所在部门负责人、办公室审核后，由网站</p>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('257', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"680\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <p>机关各科室、各有关单位：</p>\r\n            <p>　　现将《汕头建设网信息发布管理规定》印发给你们，请认真贯彻执行。</p>\r\n            <p align=\"right\">二〇〇九年六月十七日</p>\r\n            <p align=\"center\">汕头建设网信息发布管理规定</p>\r\n            <p align=\"left\">　　第一条　为加强汕头建设网信息发布的管理，确保网络安全、可靠、稳定地运行，促进网站的健康发展，根据《中华人民共和国计算机信息网络国际联网管理暂行规定》和《计算机信息网络国际联网安全保护管理办法》的有关规定，结合汕头建设网的实际，制定本规定。</p>\r\n            <p align=\"left\">　　第二条　汕头建设网发布的信息包括政务信息、企业信息、个人信息和公众咨询、建议、提问等其他信息。网站信息的发布实行审核制度，未经审核的，一律不予发布。</p>\r\n            <p align=\"left\">　　第三条　汕头市建设局各科室、直属各事业单位信息员撰写的政务信息须经所在部门负责人、办公室审核、分管领导同意后，由网站管理人员上网发布。</p>\r\n            <p align=\"left\">　　汕头市建设系统各归口管理单位、各区县建设局信息员撰写的政务信息须经所在部门负责人、办公室审核后，由网站</p>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('258', '<p>　　根据《行政许可法》、《房地产开发企业资质管理规定》（国家建设部令第77号）及《广东省房地产开发经营条例》的有关规定，我局于2008年9月组织对全市（不含南澳县）三级及三级以下房地产开发企业进行资质证书换证工作。经审查，汕头市顺泰房产开发有限公司等30家企业不符合房地产开发资质证书换证条件，我局作出&ldquo;不予换证&rdquo;的处理意见，并于2009年1月10日在《汕头日报》和&ldquo;汕头建设网&rdquo;上予以公示。公示期间，下列29家房地产开发企业未提出异议和主张陈述权利。现对这些房地产开发企业作出不予换发房地产开发资质证书的决定，原资质证书自本决定发布之日起作废。不予换证的29家房地产开发企业名单如下：</p>\r\n<p>　　 1、汕头市顺泰房产开发有限公司</p>\r\n<p>　　 2、汕头市旅游房地产总公司</p>\r\n<p>　　 3、汕头航空房地产开发公司</p>\r\n<p>　　 4、汕头经济特区大发房地产公司</p>\r\n<p>　　 5、汕头经济特区航空建设开发公司</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('259', '<p>　　根据《行政许可法》、《房地产开发企业资质管理规定》（国家建设部令第77号）及《广东省房地产开发经营条例》的有关规定，我局于2008年9月组织对全市（不含南澳县）三级及三级以下房地产开发企业进行资质证书换证工作。经审查，汕头市顺泰房产开发有限公司等30家企业不符合房地产开发资质证书换证条件，我局作出&ldquo;不予换证&rdquo;的处理意见，并于2009年1月10日在《汕头日报》和&ldquo;汕头建设网&rdquo;上予以公示。公示期间，下列29家房地产开发企业未提出异议和主张陈述权利。现对这些房地产开发企业作出不予换发房地产开发资质证书的决定，原资质证书自本决定发布之日起作废。不予换证的29家房地产开发企业名单如下：</p>\r\n<p>　　 1、汕头市顺泰房产开发有限公司</p>\r\n<p>　　 2、汕头市旅游房地产总公司</p>\r\n<p>　　 3、汕头航空房地产开发公司</p>\r\n<p>　　 4、汕头经济特区大发房地产公司</p>\r\n<p>　　 5、汕头经济特区航空建设开发公司</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('260', '<p><strong>事项名称： <br />\r\n</strong>　　房地产开发企业三级及三级以下资质核准 <br />\r\n　　<strong>二、办理内容： </strong><br />\r\n　　1、新设立房地产开发企业暂定资质核准。 <br />\r\n　　2、房地产开发企业四级资质核准。 <br />\r\n　　3、房地产开发企业三级资质核准。 <br />\r\n　　4、外资（外商独资、中外合资、中外合作）房地产项目公司暂定资质核准。 <br />\r\n　　<strong>三、办理依据： </strong><br />\r\n　　1、《中华人民共和国城市房地产管理法》（2007年8月30日全国人大常委会第二十九次会议修正）<strong> </strong><br />\r\n　　2、《城市房地产开发经营管理条例》(国务院令第248号 ) ； <br />\r\n　　3、《广东省房地产开发经营条例》（1997年9月22日修订）； <br />\r\n　　4、《房地产开发企业资质管理规定》(建设部令第77号)； <br />\r\n　　5、《国家发展改革委关于进一步加强和规范外商投资项目管理的通知》（发改外资〔2008〕1773号）； <br />\r\n　　6、《关于外商投资房地产开发企业资质核准有关问题的通知》（粤建房字〔2004〕161号）； <br />\r\n　　7、《国务院关于调整部分行业固定资产投资项目资本金的通知》（国发〔2004〕13号）； <br />\r\n　　8、《关于规范房地产市场外资准入和管理的意见》（建住房</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('261', '<p><strong>事项名称： <br />\r\n</strong>　　房地产开发企业三级及三级以下资质核准 <br />\r\n　　<strong>二、办理内容： </strong><br />\r\n　　1、新设立房地产开发企业暂定资质核准。 <br />\r\n　　2、房地产开发企业四级资质核准。 <br />\r\n　　3、房地产开发企业三级资质核准。 <br />\r\n　　4、外资（外商独资、中外合资、中外合作）房地产项目公司暂定资质核准。 <br />\r\n　　<strong>三、办理依据： </strong><br />\r\n　　1、《中华人民共和国城市房地产管理法》（2007年8月30日全国人大常委会第二十九次会议修正）<strong> </strong><br />\r\n　　2、《城市房地产开发经营管理条例》(国务院令第248号 ) ； <br />\r\n　　3、《广东省房地产开发经营条例》（1997年9月22日修订）； <br />\r\n　　4、《房地产开发企业资质管理规定》(建设部令第77号)； <br />\r\n　　5、《国家发展改革委关于进一步加强和规范外商投资项目管理的通知》（发改外资〔2008〕1773号）； <br />\r\n　　6、《关于外商投资房地产开发企业资质核准有关问题的通知》（粤建房字〔2004〕161号）； <br />\r\n　　7、《国务院关于调整部分行业固定资产投资项目资本金的通知》（国发〔2004〕13号）； <br />\r\n　　8、《关于规范房地产市场外资准入和管理的意见》（建住房</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('264', '<p>区（县）建设局、市直建筑业各有关单位：</p>\r\n<p>　　根据省建设厅《关于做好2008年建设系统职工教育统计工作的通知》（粤建办函〔2008〕320号）精神，为做好2008年我市建设系统职工教育统计工作，现将有关事项通知如下：</p>\r\n<p>　　一、 统计范围</p>\r\n<p>　　本次统计的范围为全市三级资质以上的建设工程勘察、工程设计、图纸审查、房地产开发、工程施工、项目招标代理、工程监理、工程造价咨询、工程质量检测等建设行业企业。</p>\r\n<p>　　二、 统计报表报送时间及渠道</p>\r\n<p>　　（一）各区（县）建设局负责所属区域建设行业职工教育统计工作，并于2月10日前将所属区域的企业按类别、资质等级和所有制性质分别进行汇总后，报市建设局人事教育科。报送报表时连同其电子文档一并报送。</p>\r\n<p>　　（二）市直单位的统计报表于2月5日前按以下渠道分别报送市建设局</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('265', '<p>区（县）建设局、市直建筑业各有关单位：</p>\r\n<p>　　根据省建设厅《关于做好2008年建设系统职工教育统计工作的通知》（粤建办函〔2008〕320号）精神，为做好2008年我市建设系统职工教育统计工作，现将有关事项通知如下：</p>\r\n<p>　　一、 统计范围</p>\r\n<p>　　本次统计的范围为全市三级资质以上的建设工程勘察、工程设计、图纸审查、房地产开发、工程施工、项目招标代理、工程监理、工程造价咨询、工程质量检测等建设行业企业。</p>\r\n<p>　　二、 统计报表报送时间及渠道</p>\r\n<p>　　（一）各区（县）建设局负责所属区域建设行业职工教育统计工作，并于2月10日前将所属区域的企业按类别、资质等级和所有制性质分别进行汇总后，报市建设局人事教育科。报送报表时连同其电子文档一并报送。</p>\r\n<p>　　（二）市直单位的统计报表于2月5日前按以下渠道分别报送市建设局</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('266', '<p>区（县）建设局、市直建筑业各有关单位：</p>\r\n<p>　　根据省建设厅《关于做好2008年建设系统职工教育统计工作的通知》（粤建办函〔2008〕320号）精神，为做好2008年我市建设系统职工教育统计工作，现将有关事项通知如下：</p>\r\n<p>　　一、 统计范围</p>\r\n<p>　　本次统计的范围为全市三级资质以上的建设工程勘察、工程设计、图纸审查、房地产开发、工程施工、项目招标代理、工程监理、工程造价咨询、工程质量检测等建设行业企业。</p>\r\n<p>　　二、 统计报表报送时间及渠道</p>\r\n<p>　　（一）各区（县）建设局负责所属区域建设行业职工教育统计工作，并于2月10日前将所属区域的企业按类别、资质等级和所有制性质分别进行汇总后，报市建设局人事教育科。报送报表时连同其电子文档一并报送。</p>\r\n<p>　　（二）市直单位的统计报表于2月5日前按以下渠道分别报送市建设局</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('267', '<p>建设行业职工区（县）建设局、市直建筑业各有关单位：</p>\r\n<p>　　根据省建设厅《关于做好2008年建设系统职工教育统计工作的通知》（粤建办函〔2008〕320号）精神，为做好2008年我市建设系统职工教育统计工作，现将有关事项通知如下：</p>\r\n<p>　　一、 统计范围</p>\r\n<p>　　本次统计的范围为全市三级资质以上的建设工程勘察、工程设计、图纸审查、房地产开发、工程施工、项目招标代理、工程监理、工程造价咨询、工程质量检测等建设行业企业。</p>\r\n<p>　　二、 统计报表报送时间及渠道</p>\r\n<p>　　（一）各区（县）建设局负责所属区域建设行业职工教育统计工作，并于2月10日前将所属区域的企业按类别、资质等级和所有制性质分别进行汇总后，报市建设局人事教育科。报送报表时连同其电子文档一并报送。</p>\r\n<p>　　（二）市直单位的统计报表于2月5日前按以下渠道分别报送市建设局</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('268', '<p>区（县）建设局、市直建筑业各有关单位：</p>\r\n<p>　　根据省建设厅《关于做好2008年建设系统职工教育统计工作的通知》（粤建办函〔2008〕320号）精神，为做好2008年我市建设系统职工教育统计工作，现将有关事项通知如下：</p>\r\n<p>　　一、 统计范围</p>\r\n<p>　　本次统计的范围为全市三级资质以上的建设工程勘察、工程设计、图纸审查、房地产开发、工程施工、项目招标代理、工程监理、工程造价咨询、工程质量检测等建设行业企业。</p>\r\n<p>　　二、 统计报表报送时间及渠道</p>\r\n<p>　　（一）各区（县）建设局负责所属区域建设行业职工教育统计工作，并于2月10日前将所属区域的企业按类别、资质等级和所有制性质分别进行汇总后，报市建设局人事教育科。报送报表时连同其电子文档一并报送。</p>\r\n<p>　　（二）市直单位的统计报表于2月5日前按以下渠道分别报送市建设局</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('269', '<p>区（县）建设局、市直建筑业各有关单位：</p>\r\n<p>　　根据省建设厅《关于做好2008年建设系统职工教育统计工作的通知》（粤建办函〔2008〕320号）精神，为做好2008年我市建设系统职工教育统计工作，现将有关事项通知如下：</p>\r\n<p>　　一、 统计范围</p>\r\n<p>　　本次统计的范围为全市三级资质以上的建设工程勘察、工程设计、图纸审查、房地产开发、工程施工、项目招标代理、工程监理、工程造价咨询、工程质量检测等建设行业企业。</p>\r\n<p>　　二、 统计报表报送时间　　（一）各区（县）建设局负责所属区域建设行业职工教育统计工作，并于2月10日前将所属区域的企业按类别、资质等级和所有制性质分别进行汇总后，报市建设局人事教育科。报送报表时连同其电子文档一并报送。</p>\r\n<p>　　（二）市直单位的统计报表于2月5日前按以下渠道分别报送市建设局</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('270', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\"center\"><img src=\"http://www.stjs.gov.cn/stfdc/longg/ygha/0002.jpg\" alt=\"\" /></div>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td>　</td>\r\n        </tr>\r\n        <tr>\r\n            <td>\r\n            <div align=\"center\"><img src=\"http://www.stjs.gov.cn/stfdc/longg/ygha/0008.jpg\" alt=\"\" /></div>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('271', '<p>\r\n<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" border=\"0\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\"center\"><img src=\"http://www.stjs.gov.cn/stfdc/longg/ygha/0002.jpg\" alt=\"\" /></div>\r\n            </td>\r\n        </tr>\r\n        <tr>\r\n            <td>　</td>\r\n        </tr>\r\n        <tr>\r\n            <td>\r\n            <div align=\"center\"><img src=\"http://www.stjs.gov.cn/stfdc/longg/ygha/0008.jpg\" alt=\"\" /></div>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('272', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('273', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('274', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('275', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('276', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('277', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('278', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('279', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('280', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('281', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('282', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('283', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('284', '<p>二五&rdquo;规划开局之年，铝门窗幕墙行业将面临新的挑战。在过去一年里，铝门窗幕墙行业的发展紧跟时代脉搏，大力发展节能新品，为我国建筑节能事业作出了卓越贡献。</p>\r\n<p>　　中国建筑金属结构协会铝门窗幕墙委员会主任黄圻介绍说，2010年，我国铝门窗幕墙行业总体发展情况良好，铝合金门窗、建筑幕墙、建筑用铝型材、门窗五金配件、玻璃、建筑用胶等上下游行业，总产值和销售额都有所增长。这说明中央政府针对国际经济环境以及我国经济发展形势所采取的一系列调整手段是十分成功的，对促进我国建筑门窗幕墙行业发展十分有效。</p>\r\n<p>　　2010年，我国幕墙行业形成了以100多家大型企业为主体，以50多家产值超过10亿元的骨干企业为代表的技术创新体系，这批大型骨干企业完成的工业产值约占全行业工业总产值的50%以上。其中，沈阳远大铝业2010年的销售额相比2009年的销售额增加了25%；北京江河幕墙2010年的销售额比2009年增加了10%。</p>\r\n<p>　　2010年，铝门窗幕墙行业中又有3家企业上市，这3家企业分别是：成都硅宝科技股份有限公司、广东金钢玻璃科技股份有限公司、北京嘉寓门窗幕墙股份有限公司。</p>\r\n<p>　　黄圻说，按照国家节能政策的要求，新建建筑全面实行节能50％的设计标准，中国引进穿条式和浇注式隔热断桥铝合金门窗，配合低辐射镀膜玻璃和优质五金配件，使铝合金节能门窗产品有了较大改进。2010年，节能铝合金门窗产量明显增加，产值达到了近773亿元，比2009年翻了一番。</p>\r\n<p>　　几年来，根据新型门窗节能的需要，门窗五金配件企业积极配合新型节能门窗研发，研发出了一系列多功能门窗五金配件、优质密封条等配套产品。近几年，一批国有门窗五金配件企业在产品研发和产品推广</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('285', '<p>2222222222222222222222222222222222222222222222</p>\r\n<p>111111111111111111111</p>\r\n<p>&nbsp;</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('286', '<p>sssssssssssssssssssssssssss</p>\r\n<p>&nbsp;</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('287', '<p>sdfsdfsdfsdfsdf</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('288', '<p>sdfsadfsdfffffffffffffffffff</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('289', '<p>sdfsdfffffffffffffffffffffffffffffffffffffffffffffffaaaaaaaaaaaaaaaa</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('290', '<p>aaaaaaaaaaaaaaaaaaaaaa</p>', null, null, null);
INSERT INTO `jc_content_txt` VALUES ('291', '<p>&nbsp;aaaaaaaaaassssssssssssssss<img src=\"/cms/u/cms/www/201507/27085010y502.gif\" width=\"300\" height=\"200\" alt=\"\" /></p>', null, null, null);

-- ----------------------------
-- Table structure for `jc_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_type`;
CREATE TABLE `jc_content_type` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(20) NOT NULL COMMENT '名称',
  `img_width` int(11) DEFAULT NULL COMMENT '图片宽',
  `img_height` int(11) DEFAULT NULL COMMENT '图片高',
  `has_image` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有图片',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容类型表';

-- ----------------------------
-- Records of jc_content_type
-- ----------------------------
INSERT INTO `jc_content_type` VALUES ('1', '普通', '100', '100', '0', '0');
INSERT INTO `jc_content_type` VALUES ('2', '图文', '143', '98', '1', '0');
INSERT INTO `jc_content_type` VALUES ('3', '焦点', '280', '200', '1', '0');
INSERT INTO `jc_content_type` VALUES ('4', '头条', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `jc_department`
-- ----------------------------
DROP TABLE IF EXISTS `jc_department`;
CREATE TABLE `jc_department` (
  `depart_id` int(11) NOT NULL AUTO_INCREMENT,
  `depart_name` varchar(255) NOT NULL DEFAULT '' COMMENT '部门名称',
  `site_id` int(11) NOT NULL COMMENT '站点',
  `priority` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  `weights` int(11) NOT NULL DEFAULT '1' COMMENT '权重(值越大，级别越高)',
  PRIMARY KEY (`depart_id`),
  KEY `fk_jc_department_site` (`site_id`),
  CONSTRAINT `fk_jc_department_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
-- Records of jc_department
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_file`
-- ----------------------------
DROP TABLE IF EXISTS `jc_file`;
CREATE TABLE `jc_file` (
  `file_path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(255) DEFAULT '' COMMENT '文件名字',
  `file_isvalid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有效',
  `content_id` int(11) DEFAULT NULL COMMENT '内容id',
  PRIMARY KEY (`file_path`),
  KEY `fk_jc_file_content` (`content_id`),
  CONSTRAINT `fk_jc_file_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_file
-- ----------------------------
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201209/12202444nrg3.jpg', 's.jpg', '1', '291');
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201209/122024588nsq.jpeg', 'verifycode1347419153779.jpeg', '1', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201209/12202945k1p9.jpeg', 'verifycode1347419153779.jpeg', '1', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201209/12204713ytdw.jpg', 's.jpg', '1', '343');
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201209/12205024yvt6.jpg', '2.jpg', '1', '344');
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/22185623whmr.png', '/cms/u/cms/www/201507/22185623whmr.png', '1', '218');
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/221900285ay4.flv', '/cms/u/cms/www/201507/221900285ay4.flv', '1', '218');
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/22190306roo1.jpg', '/cms/u/cms/www/201507/22190306roo1.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/22190730v7m2.flv', '/cms/u/cms/www/201507/22190730v7m2.flv', '1', '291');
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/22191049uszb.rmvb', '/cms/u/cms/www/201507/22191049uszb.rmvb', '1', '291');
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/252311265ny6.jpg', '/cms/u/cms/www/201507/252311265ny6.jpg', '1', '291');
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/25232555ku5l.gif', '/cms/u/cms/www/201507/25232555ku5l.gif', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27000014jmob.gif', '/cms/u/cms/www/201507/27000014jmob.gif', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/270000326j7x.gif', '/cms/u/cms/www/201507/270000326j7x.gif', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/2708553458ga.flv', '/cms/u/cms/www/201507/2708553458ga.flv', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27085602eb9y.flv', '/cms/u/cms/www/201507/27085602eb9y.flv', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27111103ldvj.mp4', '/cms/u/cms/www/201507/27111103ldvj.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27141132ur21.mp4', '/cms/u/cms/www/201507/27141132ur21.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27141236mu4s.mp4', '/cms/u/cms/www/201507/27141236mu4s.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27225704exug.mp4', '/cms/u/cms/www/201507/27225704exug.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27225711moxb.mp4', '/cms/u/cms/www/201507/27225711moxb.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27232753r0xw.mp4', '/cms/u/cms/www/201507/27232753r0xw.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/272329366cha.mp4', '/cms/u/cms/www/201507/272329366cha.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27233013kca2.mp4', '/cms/u/cms/www/201507/27233013kca2.mp4', '0', null);
INSERT INTO `jc_file` VALUES ('/cms/u/cms/www/201507/27233233ayzb.mp4', '/cms/u/cms/www/201507/27233233ayzb.mp4', '1', '291');
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17095324wp2z.jpg', '', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/171410455sqq.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17141056zbjl.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17141320s4xy.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17141341je98.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/171415447op5.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17141604lrhh.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17144805im1p.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17145028j3bj.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/171545290lr9.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17161125k5kt.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/171611397af9.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/171612286b6w.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17161242nbqp.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/171612535rhr.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17161324z8jn.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17165616uvy4.', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17165616uvy4.swf', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17171653nfp8.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/171717039zq7.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17171709jdjw.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/17171716ivqv.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/18155751wi1k.gif', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190837201odl.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19090143y6m0.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19090536qbxp.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19090946s78x.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190922058498.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19092939oy7r.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093226mevs.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093508z0je.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093530anjq.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093534pbhx.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093538klmo.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093544rdou.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190935502lvi.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093742dmvl.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190938494dpy.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093849begu.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093854n45u.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093857hrzl.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093900wjkf.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093911o5g2.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19093953zqpx.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094122mc5z.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094240v28v.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094329a5xa.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094332tbdx.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190943347cma.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094339inmu.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190943477255.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094508jfde.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190945185h1l.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190946273j5i.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094631wo80.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190947003jp4.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190947311x4l.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094831t9hq.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1909485814nz.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190949019o6w.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094903k37i.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094907y45o.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190949132edb.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19094951qk1a.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190949521eei.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095026h3ca.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095103kcpr.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190952289wxr.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095231lcq8.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095231picz.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095234gz2e.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095237hsr4.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095244lvkp.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190953537bvn.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095401xwwr.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190954435nww.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095533hv75.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095559cx9e.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190956509gt3.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190956531lp5.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/190956567pd6.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095659npus.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095711di9x.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095752235i.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095824t0mi.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095858mdri.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19095940zkzo.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19100045xs61.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19100130dqrl.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191002428q2p.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19100427q41v.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19100730yqkm.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19100732rbr3.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19100735jhtm.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19100738xu07.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19100819q0nh.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101104l8gx.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101107fyhz.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101110t0zj.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191011141hrz.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101159t0ld.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101258cu07.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101300vgo6.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191013028ees.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101306te5g.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101310nlax.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101405vhee.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191016542zol.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191016566066.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1910170103if.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101705pqim.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101815my5b.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191018173g5w.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19101820duyo.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1910182468l0.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191019506xu1.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19102057h28j.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1910215201yl.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19102230f277.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19102233g7ot.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191022359mqb.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191022388uvv.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19102314gfph.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191026320f2y.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19102634814r.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19102637g8wu.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191026405ljl.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1910271036lr.gif', '', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19102719hx2v.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1910294695ky.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19102949nry1.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191029525wi9.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191029566nps.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19103035b3ll.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19103318bgac.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191033227v2n.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19103325i7eh.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19103329ra1y.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19103403xlfg.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191035531l49.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19103555yzl9.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19103559ef8r.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19103603lu7z.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191036587tik.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191047224mmx.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19110822fin2.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19111015xsud.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191116447msi.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19111647quq9.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191116504sdn.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19111654zbf8.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19111756gll3.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19111932a9xv.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19111935140r.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19111938y8xu.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19111941j2ox.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112136dax2.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112139m5p5.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112142aniu.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191121451voq.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112223q81f.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191124260dyw.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112428i5di.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112431i6yl.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191124347he2.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112511nfma.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112623820c.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112627baql.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112630rnkd.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112633k9hl.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1911263840lw.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112700bypf.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191127127do2.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19112925s625.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113108a4tf.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113111l3z3.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113114xqvt.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113119mokz.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113155zjrt.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191133047hli.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113306vsom.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1911330905lu.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191133124ekg.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113349wi0o.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113455w6da.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113458qtv5.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113500lodt.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113504ak3b.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113545y1n3.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1911384005xa.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113842vbep.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191138453a05.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19113849s58m.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191139257lag.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114043tp85.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114055fyqx.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191140578xaj.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114100zis1.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114104hajf.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191141333snd.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114201tdir.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191143031z9j.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114305b0sj.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114309f164.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114312te0u.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114320y7x2.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19114342fmb2.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19115459jnds.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19115513v9k3.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19115528h893.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19115540rghk.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191201449moh.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19120206ddre.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191203538tdp.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19131809acqm.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19131949r2ge.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19132320u46d.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191342393mlg.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19134448qvza.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19134542a8qu.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19134858biqw.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191351590e53.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19135339f6l6.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19135345g1s7.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19135642zjak.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19135645ge7r.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19135821ij0m.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19135949d13f.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19140010z9z1.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19140340fri2.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19140601kgid.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19140803w9fg.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191408344rwj.gif', '', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191408471iyj.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19141012lh2q.gif', '', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19141042cfu8.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19141139noa7.png', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19141200ip5c.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19141255yrfb.gif', '', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19141318apz1.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19141401rp2d.gif', '', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191415078pzs.gif', '', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19141700opui.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19141756u9sa.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191418286eoi.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19142041eu8x.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19142201umby.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19142206y73m.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19142430589t.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19142451945q.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191425405rka.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/1914272808rj.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19142818yvty.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19142840ycm6.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19143017qxs3.zip', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19151533k5ey.jpg', '', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19154302hxkg.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19154430myw1.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191545434coc.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19154549gc3w.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19154650hare.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19155032l0ql.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19155034wvyj.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19155038k2do.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191550415nco.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191553100g34.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19155314sxs8.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/19155317zg9k.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201112/191553207vdb.jpg', '', '1', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201507/221900285ay4.flv', '/u/cms/www/201507/221900285ay4.flv', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201507/252311265ny6.jpg', '/u/cms/www/201507/252311265ny6.jpg', '0', null);
INSERT INTO `jc_file` VALUES ('/u/cms/www/201507/27233233ayzb.mp4', '/u/cms/www/201507/27233233ayzb.mp4', '0', null);

-- ----------------------------
-- Table structure for `jc_friendlink`
-- ----------------------------
DROP TABLE IF EXISTS `jc_friendlink`;
CREATE TABLE `jc_friendlink` (
  `friendlink_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_id` int(11) NOT NULL,
  `site_name` varchar(150) NOT NULL COMMENT '网站名称',
  `domain` varchar(255) NOT NULL COMMENT '网站地址',
  `logo` varchar(150) DEFAULT NULL COMMENT '图标',
  `email` varchar(100) DEFAULT NULL COMMENT '站长邮箱',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '点击次数',
  `is_enabled` char(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  PRIMARY KEY (`friendlink_id`),
  KEY `fk_jc_ctg_friendlink` (`friendlinkctg_id`),
  KEY `fk_jc_friendlink_site` (`site_id`),
  CONSTRAINT `fk_jc_ctg_friendlink` FOREIGN KEY (`friendlinkctg_id`) REFERENCES `jc_friendlink_ctg` (`friendlinkctg_id`),
  CONSTRAINT `fk_jc_friendlink_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='CMS友情链接';

-- ----------------------------
-- Records of jc_friendlink
-- ----------------------------
INSERT INTO `jc_friendlink` VALUES ('3', '1', '2', '京东商城', 'http://www.360buy.com/', '/u/cms/www/201112/1910271036lr.gif', '', '', '1', '1', '10');
INSERT INTO `jc_friendlink` VALUES ('4', '1', '2', '当当网', 'http://www.dangdang.com/', '/u/cms/www/201112/191408344rwj.gif', '', '', '0', '1', '10');
INSERT INTO `jc_friendlink` VALUES ('5', '1', '2', '亚马逊', 'http://www.amazon.cn/', '/u/cms/www/201112/19141012lh2q.gif', '', '', '0', '1', '10');
INSERT INTO `jc_friendlink` VALUES ('6', '1', '2', 'ihush', 'http://www.ihush.com/', '/u/cms/www/201112/19141255yrfb.gif', '', '', '0', '1', '10');
INSERT INTO `jc_friendlink` VALUES ('7', '1', '2', '名品打折', 'http://temai.dazhe.cn', '/u/cms/www/201112/19141401rp2d.gif', '', '', '0', '1', '10');
INSERT INTO `jc_friendlink` VALUES ('8', '1', '2', '优品', 'http://temai.dazhe.cn', '/u/cms/www/201112/191415078pzs.gif', '', '', '1', '1', '10');

-- ----------------------------
-- Table structure for `jc_friendlink_ctg`
-- ----------------------------
DROP TABLE IF EXISTS `jc_friendlink_ctg`;
CREATE TABLE `jc_friendlink_ctg` (
  `friendlinkctg_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_name` varchar(50) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  PRIMARY KEY (`friendlinkctg_id`),
  KEY `fk_jc_friendlinkctg_site` (`site_id`),
  CONSTRAINT `fk_jc_friendlinkctg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS友情链接类别';

-- ----------------------------
-- Records of jc_friendlink_ctg
-- ----------------------------
INSERT INTO `jc_friendlink_ctg` VALUES ('1', '1', '文字链接', '1');
INSERT INTO `jc_friendlink_ctg` VALUES ('2', '1', '品牌专区（图片链接）', '2');

-- ----------------------------
-- Table structure for `jc_group`
-- ----------------------------
DROP TABLE IF EXISTS `jc_group`;
CREATE TABLE `jc_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `need_captcha` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要验证码',
  `need_check` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要审核',
  `allow_per_day` int(11) NOT NULL DEFAULT '4096' COMMENT '每日允许上传KB',
  `allow_max_file` int(11) NOT NULL DEFAULT '1024' COMMENT '每个文件最大KB',
  `allow_suffix` varchar(255) DEFAULT 'jpg,jpeg,gif,png,bmp' COMMENT '允许上传的后缀',
  `is_reg_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认会员组',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='CMS会员组表';

-- ----------------------------
-- Records of jc_group
-- ----------------------------
INSERT INTO `jc_group` VALUES ('1', '普通会员', '10', '1', '1', '4096', '1024', 'jpg,jpeg,gif,png,bmp', '1');
INSERT INTO `jc_group` VALUES ('2', '企业会员', '10', '1', '1', '0', '0', '', '0');
INSERT INTO `jc_group` VALUES ('3', '机构会员', '10', '1', '1', '0', '0', '', '0');

-- ----------------------------
-- Table structure for `jc_guestbook`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook`;
CREATE TABLE `jc_guestbook` (
  `guestbook_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `guestbookctg_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL COMMENT '留言会员',
  `admin_id` int(11) DEFAULT NULL COMMENT '回复管理员',
  `ip` varchar(50) NOT NULL COMMENT '留言IP',
  `create_time` datetime NOT NULL COMMENT '留言时间',
  `replay_time` datetime DEFAULT NULL COMMENT '回复时间',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  PRIMARY KEY (`guestbook_id`),
  KEY `fk_jc_ctg_guestbook` (`guestbookctg_id`),
  KEY `fk_jc_guestbook_admin` (`admin_id`),
  KEY `fk_jc_guestbook_member` (`member_id`),
  KEY `fk_jc_guestbook_site` (`site_id`),
  CONSTRAINT `fk_jc_ctg_guestbook` FOREIGN KEY (`guestbookctg_id`) REFERENCES `jc_guestbook_ctg` (`guestbookctg_id`),
  CONSTRAINT `fk_jc_guestbook_admin` FOREIGN KEY (`admin_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_guestbook_member` FOREIGN KEY (`member_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_guestbook_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='CMS留言';

-- ----------------------------
-- Records of jc_guestbook
-- ----------------------------
INSERT INTO `jc_guestbook` VALUES ('5', '1', '1', '1', null, '192.168.0.202', '2011-06-20 18:41:57', null, '1', '1');
INSERT INTO `jc_guestbook` VALUES ('6', '1', '1', null, null, '127.0.0.1', '2011-06-29 16:58:40', null, '1', '0');
INSERT INTO `jc_guestbook` VALUES ('7', '1', '1', null, null, '127.0.0.1', '2011-06-29 16:58:56', null, '0', '0');
INSERT INTO `jc_guestbook` VALUES ('8', '1', '1', null, null, '127.0.0.1', '2011-07-02 11:50:26', null, '0', '0');

-- ----------------------------
-- Table structure for `jc_guestbook_ctg`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook_ctg`;
CREATE TABLE `jc_guestbook_ctg` (
  `guestbookctg_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `ctg_name` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`guestbookctg_id`),
  KEY `fk_jc_guestbookctg_site` (`site_id`),
  CONSTRAINT `fk_jc_guestbookctg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='CMS留言类别';

-- ----------------------------
-- Records of jc_guestbook_ctg
-- ----------------------------
INSERT INTO `jc_guestbook_ctg` VALUES ('1', '1', '法律咨询', '1', '招标咨询');
INSERT INTO `jc_guestbook_ctg` VALUES ('2', '1', '信息咨询', '10', '投诉建议投诉建议');
INSERT INTO `jc_guestbook_ctg` VALUES ('3', '1', '意见咨询', '10', '');
INSERT INTO `jc_guestbook_ctg` VALUES ('4', '1', '网上回复', '10', '');
INSERT INTO `jc_guestbook_ctg` VALUES ('5', '1', '施工项目招标投标网上答疑', '10', '');

-- ----------------------------
-- Table structure for `jc_guestbook_ctg_department`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook_ctg_department`;
CREATE TABLE `jc_guestbook_ctg_department` (
  `guestbookctg_id` int(11) NOT NULL,
  `depart_id` int(11) NOT NULL,
  PRIMARY KEY (`guestbookctg_id`,`depart_id`),
  KEY `fk_jc_channel_department` (`depart_id`),
  CONSTRAINT `fk_jc_department_guestbook_ctg` FOREIGN KEY (`guestbookctg_id`) REFERENCES `jc_guestbook_ctg` (`guestbookctg_id`),
  CONSTRAINT `fk_jc_guestbook_ctg_department` FOREIGN KEY (`depart_id`) REFERENCES `jc_department` (`depart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS留言类别部门关联表';

-- ----------------------------
-- Records of jc_guestbook_ctg_department
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_guestbook_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook_ext`;
CREATE TABLE `jc_guestbook_ext` (
  `guestbook_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '留言标题',
  `content` longtext COMMENT '留言内容',
  `reply` longtext COMMENT '回复内容',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(100) DEFAULT NULL COMMENT '电话',
  `qq` varchar(50) DEFAULT NULL COMMENT 'QQ',
  KEY `fk_jc_ext_guestbook` (`guestbook_id`),
  CONSTRAINT `fk_jc_ext_guestbook` FOREIGN KEY (`guestbook_id`) REFERENCES `jc_guestbook` (`guestbook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS留言内容';

-- ----------------------------
-- Records of jc_guestbook_ext
-- ----------------------------
INSERT INTO `jc_guestbook_ext` VALUES ('5', '啊啊啊啊啊', '啊啊啊啊啊啊啊啊啊啊啊啊啊', '不错，好同学', 'kelea@ads.com', '15511199999', '222111');
INSERT INTO `jc_guestbook_ext` VALUES ('6', 'fs', 'fd', null, null, null, null);
INSERT INTO `jc_guestbook_ext` VALUES ('7', 'asdf', 'asdf', null, null, null, null);
INSERT INTO `jc_guestbook_ext` VALUES ('8', 'fff', 'ffff', 'ffff', 'ff', 'ff', 'ff');

-- ----------------------------
-- Table structure for `jc_keyword`
-- ----------------------------
DROP TABLE IF EXISTS `jc_keyword`;
CREATE TABLE `jc_keyword` (
  `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL COMMENT '站点ID',
  `keyword_name` varchar(100) NOT NULL COMMENT '名称',
  `url` varchar(255) NOT NULL COMMENT '链接',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`keyword_id`),
  KEY `fk_jc_keyword_site` (`site_id`),
  CONSTRAINT `fk_jc_keyword_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS内容关键词表';

-- ----------------------------
-- Records of jc_keyword
-- ----------------------------
INSERT INTO `jc_keyword` VALUES ('1', null, '内容管理系统', '<a href=\"http://www.willcms.com/\" target=\"_blank\">内容管理系统</a>', '0');

-- ----------------------------
-- Table structure for `jc_log`
-- ----------------------------
DROP TABLE IF EXISTS `jc_log`;
CREATE TABLE `jc_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `category` int(11) NOT NULL COMMENT '日志类型',
  `log_time` datetime NOT NULL COMMENT '日志时间',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL地址',
  `title` varchar(255) DEFAULT NULL COMMENT '日志标题',
  `content` varchar(255) DEFAULT NULL COMMENT '日志内容',
  PRIMARY KEY (`log_id`),
  KEY `fk_jc_log_site` (`site_id`),
  KEY `fk_jc_log_user` (`user_id`),
  CONSTRAINT `fk_jc_log_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_log_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='CMS日志表';

-- ----------------------------
-- Records of jc_log
-- ----------------------------
INSERT INTO `jc_log` VALUES ('4', '1', null, '1', '2015-07-21 21:35:27', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('5', '1', null, '1', '2015-07-21 21:41:22', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('6', '1', null, '1', '2015-07-21 21:52:51', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('7', '1', null, '1', '2015-07-21 21:53:55', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('8', '1', null, '1', '2015-07-21 21:56:44', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('9', '1', null, '1', '2015-07-22 18:55:17', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('10', '1', '1', '3', '2015-07-22 18:57:21', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=218;title=设置与职责');
INSERT INTO `jc_log` VALUES ('11', '1', '1', '3', '2015-07-22 18:58:00', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=218;title=设置与职责');
INSERT INTO `jc_log` VALUES ('12', '1', '1', '3', '2015-07-22 18:59:41', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=218;title=设置与职责');
INSERT INTO `jc_log` VALUES ('13', '1', '1', '3', '2015-07-22 19:00:09', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=218;title=设置与职责');
INSERT INTO `jc_log` VALUES ('14', '1', '1', '3', '2015-07-22 19:00:37', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=218;title=设置与职责');
INSERT INTO `jc_log` VALUES ('15', '1', '1', '3', '2015-07-22 19:01:08', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=218;title=设置与职责');
INSERT INTO `jc_log` VALUES ('16', '1', '1', '3', '2015-07-22 19:03:25', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=218;title=设置与职责');
INSERT INTO `jc_log` VALUES ('17', '1', '1', '3', '2015-07-22 19:03:45', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=218;title=设置与职责');
INSERT INTO `jc_log` VALUES ('18', '1', '1', '3', '2015-07-22 19:08:13', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_save.do', '增加文章', 'id=291;title=aaaaaaaaaaaaaaaaaa');
INSERT INTO `jc_log` VALUES ('19', '1', '1', '3', '2015-07-22 19:11:07', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=291;title=aaaaaaaaaaaaaaaaaa');
INSERT INTO `jc_log` VALUES ('20', '1', null, '1', '2015-07-22 20:58:18', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('21', '1', null, '1', '2015-07-25 21:50:44', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('22', '1', '1', '3', '2015-07-25 23:11:58', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=291;title=aaaaaaaaaaaaaaaaaa');
INSERT INTO `jc_log` VALUES ('23', '1', null, '1', '2015-07-26 15:21:41', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('24', '1', null, '1', '2015-07-26 23:56:49', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('25', '1', null, '1', '2015-07-26 23:59:57', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('26', '1', '1', '3', '2015-07-27 00:09:11', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/config/o_mark_update.do', '修改水印设置', null);
INSERT INTO `jc_log` VALUES ('27', '1', null, '1', '2015-07-27 08:40:32', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('28', '1', null, '1', '2015-07-27 08:48:48', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('29', '1', '1', '3', '2015-07-27 08:52:26', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=291;title=aaaaaaaaaaaaaaaaaa');
INSERT INTO `jc_log` VALUES ('30', '1', null, '1', '2015-07-27 11:10:49', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('31', '1', null, '1', '2015-07-27 13:55:10', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('32', '1', null, '1', '2015-07-27 22:51:23', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('33', '1', null, '1', '2015-07-27 22:58:46', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('34', '1', null, '1', '2015-07-27 23:29:11', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('35', '1', '1', '3', '2015-07-27 23:33:40', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=291;title=aaaaaaaaaaaaaaaaaa');
INSERT INTO `jc_log` VALUES ('36', '1', '1', '3', '2015-07-27 23:33:55', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/content/o_update.do', '修改文章', 'id=291;title=aaaaaaaaaaaaaaaaaa');
INSERT INTO `jc_log` VALUES ('37', '1', null, '1', '2015-07-28 00:16:23', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('38', '1', null, '1', '2015-07-28 00:56:33', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('39', '1', null, '1', '2015-07-28 10:54:44', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('40', '1', '1', '3', '2015-07-28 11:00:15', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/channel/o_update.do', '修改栏目', 'id=40;name=机构设置 ');
INSERT INTO `jc_log` VALUES ('41', '1', '1', '3', '2015-07-28 11:00:37', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/channel/o_update.do', '修改栏目', 'id=40;name=机构设置 ');
INSERT INTO `jc_log` VALUES ('42', '1', '1', '3', '2015-07-28 11:01:40', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/channel/o_update.do', '修改栏目', 'id=40;name=机构设置 ');
INSERT INTO `jc_log` VALUES ('43', '1', '1', '3', '2015-07-28 11:02:36', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/channel/o_update.do', '修改栏目', 'id=42;name=行业新闻 ');
INSERT INTO `jc_log` VALUES ('44', '1', '1', '3', '2015-07-28 11:02:53', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/channel/o_update.do', '修改栏目', 'id=42;name=行业新闻 ');
INSERT INTO `jc_log` VALUES ('45', '1', '1', '3', '2015-07-28 11:03:13', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/channel/o_update.do', '修改栏目', 'id=42;name=行业新闻 ');
INSERT INTO `jc_log` VALUES ('46', '1', null, '1', '2015-07-28 12:22:52', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('47', '1', null, '1', '2015-07-28 12:23:27', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);
INSERT INTO `jc_log` VALUES ('48', '1', null, '1', '2015-07-28 16:02:33', '0:0:0:0:0:0:0:1', '/cms/willadmin/willcms/login.do', '登录成功', null);

-- ----------------------------
-- Table structure for `jc_message`
-- ----------------------------
DROP TABLE IF EXISTS `jc_message`;
CREATE TABLE `jc_message` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `msg_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `msg_content` longtext COMMENT '站内信息内容',
  `send_time` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `msg_send_user` int(11) NOT NULL DEFAULT '1' COMMENT '发信息人',
  `msg_receiver_user` int(11) NOT NULL DEFAULT '0' COMMENT '接收人',
  `site_id` int(11) NOT NULL DEFAULT '1' COMMENT '站点',
  `msg_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息状态0未读，1已读',
  `msg_box` int(2) NOT NULL DEFAULT '1' COMMENT '消息信箱 0收件箱 1发件箱 2草稿箱 3垃圾箱',
  PRIMARY KEY (`msg_id`),
  KEY `fk_jc_message_user_send` (`msg_send_user`),
  KEY `fk_jc_message_user_receiver` (`msg_receiver_user`),
  KEY `fk_jc_message_site` (`site_id`),
  CONSTRAINT `fk_jc_message_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_message_user_receiver` FOREIGN KEY (`msg_receiver_user`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_message_user_send` FOREIGN KEY (`msg_send_user`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站内信';

-- ----------------------------
-- Records of jc_message
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_model`
-- ----------------------------
DROP TABLE IF EXISTS `jc_model`;
CREATE TABLE `jc_model` (
  `model_id` int(11) NOT NULL,
  `model_name` varchar(100) NOT NULL COMMENT '名称',
  `model_path` varchar(100) NOT NULL COMMENT '路径',
  `tpl_channel_prefix` varchar(20) DEFAULT NULL COMMENT '栏目模板前缀',
  `tpl_content_prefix` varchar(20) DEFAULT NULL COMMENT '内容模板前缀',
  `title_img_width` int(11) NOT NULL DEFAULT '139' COMMENT '栏目标题图宽度',
  `title_img_height` int(11) NOT NULL DEFAULT '139' COMMENT '栏目标题图高度',
  `content_img_width` int(11) NOT NULL DEFAULT '310' COMMENT '栏目内容图宽度',
  `content_img_height` int(11) NOT NULL DEFAULT '310' COMMENT '栏目内容图高度',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `has_content` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有内容',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认模型',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS模型表';

-- ----------------------------
-- Records of jc_model
-- ----------------------------
INSERT INTO `jc_model` VALUES ('1', '新闻', '1', '新闻栏目', '新闻内容', '139', '139', '310', '310', '1', '1', '0', '0');
INSERT INTO `jc_model` VALUES ('2', '单页', '2', '单页', '', '139', '139', '310', '310', '2', '0', '0', '0');
INSERT INTO `jc_model` VALUES ('3', '作品', '3', '作品栏目', '作品内容', '139', '139', '310', '310', '3', '1', '0', '0');
INSERT INTO `jc_model` VALUES ('4', '下载', '4', '下载栏目', '下载内容', '139', '139', '310', '310', '4', '1', '0', '0');

-- ----------------------------
-- Table structure for `jc_model_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_model_item`;
CREATE TABLE `jc_model_item` (
  `modelitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `item_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '70' COMMENT '排列顺序',
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `opt_value` varchar(255) DEFAULT NULL COMMENT '可选项',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) NOT NULL DEFAULT '1' COMMENT '数据类型',
  `is_single` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否独占一行',
  `is_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否栏目模型项',
  `is_custom` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否自定义',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  PRIMARY KEY (`modelitem_id`),
  KEY `fk_jc_item_model` (`model_id`),
  CONSTRAINT `fk_jc_item_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 COMMENT='CMS模型项表';

-- ----------------------------
-- Records of jc_model_item
-- ----------------------------
INSERT INTO `jc_model_item` VALUES ('1', '1', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('2', '1', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('3', '1', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('4', '1', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('5', '1', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('6', '1', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('7', '1', 'tplContent', '内容模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('8', '1', 'channelStatic', '栏目静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('9', '1', 'contentStatic', '内容静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('10', '1', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('11', '1', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('12', '1', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('13', '1', 'finalStep', '终审级别', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('14', '1', 'afterCheck', '审核后', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('15', '1', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('16', '1', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('17', '1', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('18', '1', 'contriGroupIds', '投稿权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('19', '1', 'userIds', '管理权限', '10', null, null, null, null, null, null, null, '7', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('20', '1', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('21', '1', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('22', '1', 'channelId', '栏目', '10', null, null, null, null, null, null, null, '6', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('23', '1', 'title', '标题', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('24', '1', 'shortTitle', '简短标题', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('25', '1', 'titleColor', '标题颜色', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('26', '1', 'tagStr', 'Tag标签', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('27', '1', 'description', '摘要', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('28', '1', 'author', '作者', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('29', '1', 'origin', '来源', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('30', '1', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('31', '1', 'topLevel', '固顶级别', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('32', '1', 'releaseDate', '发布时间', '10', null, null, null, null, null, null, null, '5', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('33', '1', 'typeId', '内容类型', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('34', '1', 'tplContent', '指定模板', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('35', '1', 'typeImg', '类型图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('36', '1', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('37', '1', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('38', '1', 'attachments', '附件', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('39', '1', 'media', '多媒体', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('40', '1', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('41', '1', 'pictures', '图片集', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('42', '2', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('43', '2', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('44', '2', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('45', '2', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('46', '2', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('47', '2', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('48', '2', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('49', '2', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('50', '2', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('51', '2', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('52', '2', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('53', '2', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('54', '3', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('55', '3', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('56', '3', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('57', '3', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('58', '3', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('59', '3', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('60', '3', 'tplContent', '内容模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('61', '3', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('62', '3', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('63', '3', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('64', '3', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('65', '3', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('66', '3', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('67', '3', 'contriGroupIds', '投稿权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('68', '3', 'userIds', '管理权限', '10', null, null, null, null, null, null, null, '7', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('69', '3', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('70', '3', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('73', '3', 'channelId', '栏目', '10', null, null, null, null, null, null, null, '6', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('74', '3', 'title', '标题', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('75', '3', 'shortTitle', '简短标题', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('76', '3', 'titleColor', '标题颜色', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('77', '3', 'tagStr', 'Tag标签', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('78', '3', 'description', '摘要', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('79', '3', 'author', '作者', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('80', '3', 'origin', '来源', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('81', '3', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('82', '3', 'topLevel', '固顶级别', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('83', '3', 'releaseDate', '发布时间', '10', null, null, null, null, null, null, null, '5', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('84', '3', 'typeId', '内容类型', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('85', '3', 'tplContent', '指定模板', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('86', '3', 'typeImg', '类型图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('87', '3', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('88', '3', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('89', '3', 'attachments', '附件', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('90', '3', 'media', '多媒体', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('91', '3', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('92', '3', 'pictures', '图片集', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('93', '4', 'name', '栏目名称', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('94', '4', 'path', '访问路径', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('95', '4', 'title', 'meta标题', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('96', '4', 'keywords', 'meta关键字', '10', null, null, null, null, null, null, null, '1', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('97', '4', 'description', 'meta描述', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('98', '4', 'tplChannel', '栏目模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('99', '4', 'tplContent', '内容模板', '10', null, null, null, null, null, null, null, '6', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('100', '4', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('101', '4', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('102', '4', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('103', '4', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('104', '4', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('105', '4', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('106', '4', 'userIds', '管理权限', '10', null, null, null, null, null, null, null, '7', '1', '1', '0', '1');
INSERT INTO `jc_model_item` VALUES ('107', '4', 'channelId', '栏目', '1', null, null, null, null, null, null, null, '6', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('108', '4', 'title', '软件名称', '2', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('109', '4', 'shortTitle', '软件简称', '3', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('110', '4', 'titleColor', '标题颜色', '4', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('111', '4', 'description', '摘要', '5', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('112', '4', 'author', '发布人', '6', null, null, null, null, null, null, null, '1', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('113', '4', 'viewGroupIds', '浏览权限', '7', null, null, null, null, null, null, null, '7', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('114', '4', 'topLevel', '固顶级别', '8', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('115', '4', 'releaseDate', '发布时间', '9', null, null, null, null, null, null, null, '5', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('116', '4', 'typeId', '内容类型', '21', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('117', '4', 'tplContent', '指定模板', '22', null, null, null, null, null, null, null, '6', '0', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('118', '4', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('119', '4', 'attachments', '软件上传', '11', null, null, null, null, null, null, null, '1', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('120', '4', 'txt', '软件介绍', '20', null, null, null, null, null, null, null, '4', '1', '0', '0', '1');
INSERT INTO `jc_model_item` VALUES ('121', '4', 'softType', '软件类型', '12', '国产软件', '国产软件,国外软件', '100', '3', '30', null, null, '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('122', '4', 'warrant', '软件授权', '13', '免费版', '免费版,共享版', '', '3', '30', '', '', '6', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('123', '4', 'relatedLink', '相关链接', '14', 'http://', '', '50', '3', '30', '', '', '1', '0', '0', '1', '1');
INSERT INTO `jc_model_item` VALUES ('124', '4', 'demoUrl', '演示地址', '15', 'http://', null, '60', '3', '30', null, null, '1', '0', '0', '1', '1');

-- ----------------------------
-- Table structure for `jc_receiver_message`
-- ----------------------------
DROP TABLE IF EXISTS `jc_receiver_message`;
CREATE TABLE `jc_receiver_message` (
  `msg_re_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `msg_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `msg_content` longtext COMMENT '站内信息内容',
  `send_time` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `msg_send_user` int(11) NOT NULL DEFAULT '1' COMMENT '发信息人',
  `msg_receiver_user` int(11) NOT NULL DEFAULT '0' COMMENT '接收人',
  `site_id` int(11) NOT NULL DEFAULT '1' COMMENT '站点',
  `msg_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息状态0未读，1已读',
  `msg_box` int(2) NOT NULL DEFAULT '1' COMMENT '消息信箱 0收件箱 1发件箱 2草稿箱 3垃圾箱',
  `msg_id` int(11) DEFAULT NULL COMMENT '发信的信件id',
  PRIMARY KEY (`msg_re_id`),
  KEY `jc_receiver_message_user_send` (`msg_send_user`),
  KEY `jc_receiver_message_user_receiver` (`msg_receiver_user`),
  KEY `jc_receiver_message_site` (`site_id`),
  KEY `jc_receiver_message_message` (`msg_re_id`),
  KEY `fk_jc_receiver_message_message` (`msg_id`),
  CONSTRAINT `fk_jc_receiver_message_message` FOREIGN KEY (`msg_id`) REFERENCES `jc_message` (`msg_id`),
  CONSTRAINT `fk_jc_receiver_message_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_receiver_message_user_receiver` FOREIGN KEY (`msg_receiver_user`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_receiver_message_user_send` FOREIGN KEY (`msg_send_user`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站内信收信表';

-- ----------------------------
-- Records of jc_receiver_message
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_role`
-- ----------------------------
DROP TABLE IF EXISTS `jc_role`;
CREATE TABLE `jc_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `role_name` varchar(100) NOT NULL COMMENT '角色名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_super` char(1) NOT NULL DEFAULT '0' COMMENT '拥有所有权限',
  PRIMARY KEY (`role_id`),
  KEY `fk_jc_role_site` (`site_id`),
  CONSTRAINT `fk_jc_role_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS角色表';

-- ----------------------------
-- Records of jc_role
-- ----------------------------
INSERT INTO `jc_role` VALUES ('1', null, '管理员', '10', '1');
INSERT INTO `jc_role` VALUES ('2', null, '机构管理员', '10', '0');

-- ----------------------------
-- Table structure for `jc_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `jc_role_permission`;
CREATE TABLE `jc_role_permission` (
  `role_id` int(11) NOT NULL,
  `uri` varchar(100) NOT NULL,
  KEY `fk_jc_permission_role` (`role_id`),
  CONSTRAINT `fk_jc_permission_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS角色授权表';

-- ----------------------------
-- Records of jc_role_permission
-- ----------------------------
INSERT INTO `jc_role_permission` VALUES ('2', '/common/o_image_cut.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/top.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/main.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/v_tree_channels.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/index.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/common/v_image_area_select.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/fck/upload.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/o_upload_attachment.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/frame/content');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/v_view.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/v_left.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/o_save.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/v_list.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/v_tree.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/o_reject.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/right.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/left.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/common/o_upload_image.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/personal/');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/o_upload_media.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/o_update.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/o_check.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/v_edit.do');
INSERT INTO `jc_role_permission` VALUES ('2', '/content/v_add.do');

-- ----------------------------
-- Table structure for `jc_sensitivity`
-- ----------------------------
DROP TABLE IF EXISTS `jc_sensitivity`;
CREATE TABLE `jc_sensitivity` (
  `sensitivity_id` int(11) NOT NULL AUTO_INCREMENT,
  `search` varchar(255) NOT NULL COMMENT '敏感词',
  `replacement` varchar(255) NOT NULL COMMENT '替换词',
  PRIMARY KEY (`sensitivity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS敏感词表';

-- ----------------------------
-- Records of jc_sensitivity
-- ----------------------------
INSERT INTO `jc_sensitivity` VALUES ('1', '法论功', '***');

-- ----------------------------
-- Table structure for `jc_site`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site`;
CREATE TABLE `jc_site` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL COMMENT '配置ID',
  `ftp_upload_id` int(11) DEFAULT NULL COMMENT '上传ftp',
  `domain` varchar(50) NOT NULL COMMENT '域名',
  `site_path` varchar(20) NOT NULL COMMENT '路径',
  `site_name` varchar(100) NOT NULL COMMENT '网站名称',
  `short_name` varchar(100) NOT NULL COMMENT '简短名称',
  `protocol` varchar(20) NOT NULL DEFAULT 'http://' COMMENT '协议',
  `dynamic_suffix` varchar(10) NOT NULL DEFAULT '.jhtml' COMMENT '动态页后缀',
  `static_suffix` varchar(10) NOT NULL DEFAULT '.html' COMMENT '静态页后缀',
  `static_dir` varchar(50) DEFAULT NULL COMMENT '静态页存放目录',
  `is_index_to_root` char(1) NOT NULL DEFAULT '0' COMMENT '是否使用将首页放在根目录下',
  `is_static_index` char(1) NOT NULL DEFAULT '0' COMMENT '是否静态化首页',
  `locale_admin` varchar(10) NOT NULL DEFAULT 'zh_CN' COMMENT '后台本地化',
  `locale_front` varchar(10) NOT NULL DEFAULT 'zh_CN' COMMENT '前台本地化',
  `tpl_solution` varchar(50) NOT NULL DEFAULT 'default' COMMENT '模板方案',
  `final_step` tinyint(4) NOT NULL DEFAULT '2' COMMENT '终审级别',
  `after_check` tinyint(4) NOT NULL DEFAULT '2' COMMENT '审核后(1:不能修改删除;2:修改后退回;3:修改后不变)',
  `is_relative_path` char(1) NOT NULL DEFAULT '1' COMMENT '是否使用相对路径',
  `is_recycle_on` char(1) NOT NULL DEFAULT '1' COMMENT '是否开启回收站',
  `domain_alias` varchar(255) DEFAULT NULL COMMENT '域名别名',
  `domain_redirect` varchar(255) DEFAULT NULL COMMENT '域名重定向',
  `is_master` tinyint(1) DEFAULT '0' COMMENT '是否主站',
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `ak_domain` (`domain`),
  KEY `fk_jc_site_config` (`config_id`),
  KEY `fk_jc_site_upload_ftp` (`ftp_upload_id`),
  CONSTRAINT `fk_jc_site_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`),
  CONSTRAINT `fk_jc_site_upload_ftp` FOREIGN KEY (`ftp_upload_id`) REFERENCES `jo_ftp` (`ftp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS站点表';

-- ----------------------------
-- Records of jc_site
-- ----------------------------
INSERT INTO `jc_site` VALUES ('1', '1', null, 'localhost', 'www', '汕头潮阳建设网', '潮阳建设网', 'http://', '.jhtml', '.html', '', '0', '0', 'zh_CN', 'zh_CN', 'red', '2', '2', '1', '1', '', '', '0');

-- ----------------------------
-- Table structure for `jc_site_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_attr`;
CREATE TABLE `jc_site_attr` (
  `site_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_site` (`site_id`),
  CONSTRAINT `fk_jc_attr_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点属性表';

-- ----------------------------
-- Records of jc_site_attr
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_site_cfg`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_cfg`;
CREATE TABLE `jc_site_cfg` (
  `site_id` int(11) NOT NULL,
  `cfg_name` varchar(30) NOT NULL COMMENT '名称',
  `cfg_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_cfg_site` (`site_id`),
  CONSTRAINT `fk_jc_cfg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点配置表';

-- ----------------------------
-- Records of jc_site_cfg
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_site_flow`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_flow`;
CREATE TABLE `jc_site_flow` (
  `flow_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `access_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '访问者ip',
  `access_date` varchar(50) DEFAULT NULL COMMENT '访问日期',
  `access_time` datetime DEFAULT NULL COMMENT '访问时间',
  `access_page` varchar(255) NOT NULL DEFAULT '' COMMENT '访问页面',
  `referer_website` varchar(255) DEFAULT NULL COMMENT '来访网站',
  `referer_page` varchar(255) DEFAULT NULL COMMENT '来访页面',
  `referer_keyword` varchar(255) DEFAULT NULL COMMENT '来访关键字',
  `area` varchar(50) DEFAULT NULL COMMENT '地区',
  `session_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'cookie信息',
  PRIMARY KEY (`flow_id`),
  KEY `fk_jc_flow_site` (`site_id`),
  CONSTRAINT `fk_jc_flow_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='站点流量统计表';

-- ----------------------------
-- Records of jc_site_flow
-- ----------------------------
INSERT INTO `jc_site_flow` VALUES ('1', '1', '0:0:0:0:0:0:0:1', '2015-7-1', '2015-07-01 21:22:25', 'http://localhost:8080/cms/', 'http://localhost:8080', 'http://localhost:8080/cms/willadmin/willcms/top.do', '', '', 'F1402D1FEFAB6D6DD796E7F500980E14');
INSERT INTO `jc_site_flow` VALUES ('2', '1', '0:0:0:0:0:0:0:1', '2015-7-1', '2015-07-01 21:29:54', 'http://localhost:8080/cms/news/index.jhtml', 'http://localhost:8080', 'http://localhost:8080/cms/', '', '', 'F1402D1FEFAB6D6DD796E7F500980E14');

-- ----------------------------
-- Table structure for `jc_site_model`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_model`;
CREATE TABLE `jc_site_model` (
  `model_id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `model_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `upload_path` varchar(100) DEFAULT NULL COMMENT '上传路径',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) DEFAULT '1' COMMENT '0:编辑器;1:文本框;2:文本区;3:图片;4:附件',
  `is_single` tinyint(1) DEFAULT '1' COMMENT '是否独占一行',
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `ak_field` (`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点信息模型表';

-- ----------------------------
-- Records of jc_site_model
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_site_txt`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_txt`;
CREATE TABLE `jc_site_txt` (
  `site_id` int(11) NOT NULL,
  `txt_name` varchar(30) NOT NULL COMMENT '名称',
  `txt_value` longtext COMMENT '值',
  KEY `fk_jc_txt_site` (`site_id`),
  CONSTRAINT `fk_jc_txt_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点文本表';

-- ----------------------------
-- Records of jc_site_txt
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_topic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_topic`;
CREATE TABLE `jc_topic` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) DEFAULT NULL,
  `topic_name` varchar(150) NOT NULL COMMENT '名称',
  `short_name` varchar(150) DEFAULT NULL COMMENT '简称',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `title_img` varchar(100) DEFAULT NULL COMMENT '标题图',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '专题模板',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推??',
  PRIMARY KEY (`topic_id`),
  KEY `fk_jc_topic_channel` (`channel_id`),
  CONSTRAINT `fk_jc_topic_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='CMS专题表';

-- ----------------------------
-- Records of jc_topic
-- ----------------------------
INSERT INTO `jc_topic` VALUES ('1', null, '2010年南非世界杯', '世界杯', '世界杯', '2010年世界杯将在南非约翰内斯堡拉开帷幕，32路豪强将在一个月的时间里，为大力神杯展开争夺。', 'http://a2.att.hudong.com/08/61/01300000406647124377613651616.jpg', 'http://i0.sinaimg.cn/ty/news/2010/0611/sjbsc.jpg', '', '10', '1');
INSERT INTO `jc_topic` VALUES ('2', null, '上海世博会专题', '世博', '世博', '人类文明的盛会，我们大家的世博，精彩开篇，“满月”有余。随着上海世博会的有序前行，人们从中收获的感悟也由表及里。', 'http://xwcb.eastday.com/c/20061116/images/00033531.jpg', 'http://news.china.com/zh_cn/focus/expo2010/images/top_pic.jpg', '', '10', '1');
INSERT INTO `jc_topic` VALUES ('3', null, '低碳经济', '低碳', '低碳', '所谓低碳经济，是指在可持续发展理念指导下，通过技术创新、制度创新、产业转型、新能源开发等多种手段，尽可能地减少煤炭石油等高碳能源消耗，减少温室气体排放，达到经济社会发展与生态环境保护双赢的一种经济发展形态。', 'http://www.6788.cn/bscyw/upfiles/0125/1f0aaff5/fery/w1tg.jpg', '/u/cms/www/201106/21163025x5vf.jpg', '', '10', '0');

-- ----------------------------
-- Table structure for `jc_user`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user`;
CREATE TABLE `jc_user` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `register_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '注册IP',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '最后登录IP',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `rank` int(11) NOT NULL DEFAULT '0' COMMENT '管理员级别',
  `upload_total` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传总大小',
  `upload_size` int(11) NOT NULL DEFAULT '0' COMMENT '上传大小',
  `upload_date` date DEFAULT NULL COMMENT '上传日期',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否管理员',
  `is_viewonly_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否只读管理员',
  `is_self_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否只管理自己的数据',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ak_username` (`username`),
  KEY `fk_jc_user_group` (`group_id`),
  CONSTRAINT `fk_jc_user_group` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户表';

-- ----------------------------
-- Records of jc_user
-- ----------------------------
INSERT INTO `jc_user` VALUES ('1', '1', 'admin', 'admin@yahoo.com', '2011-01-03 00:00:00', '127.0.0.1', '2015-07-28 16:02:33', '0:0:0:0:0:0:0:1', '92', '9', '0', '0', null, '1', '0', '0', '0');
INSERT INTO `jc_user` VALUES ('3', '1', 'asdfasdfasdf', 'sadf@xb.com', '2011-06-18 15:48:29', '127.0.0.1', '2011-06-18 15:48:42', '127.0.0.1', '1', '0', '0', '0', '2011-06-18', '0', '0', '0', '0');
INSERT INTO `jc_user` VALUES ('4', '3', 'cyjsw', '', '2011-06-20 19:08:05', '192.168.0.202', '2011-06-20 19:18:34', '192.168.0.202', '4', '3', '0', '0', '2011-06-20', '1', '0', '1', '0');

-- ----------------------------
-- Table structure for `jc_user_collection`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_collection`;
CREATE TABLE `jc_user_collection` (
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `content_id` int(11) NOT NULL DEFAULT '0' COMMENT '内容id',
  PRIMARY KEY (`user_id`,`content_id`),
  KEY `fk_jc_user_collection_con` (`content_id`),
  CONSTRAINT `fk_jc_user_collection_con` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_user_collection_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户收藏关联表';

-- ----------------------------
-- Records of jc_user_collection
-- ----------------------------
INSERT INTO `jc_user_collection` VALUES ('1', '237');

-- ----------------------------
-- Table structure for `jc_user_department`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_department`;
CREATE TABLE `jc_user_department` (
  `department_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`department_id`,`user_id`),
  KEY `fk_jc_department_user` (`user_id`),
  CONSTRAINT `fk_jc_department_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_department` FOREIGN KEY (`department_id`) REFERENCES `jc_department` (`depart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户部门关联表';

-- ----------------------------
-- Records of jc_user_department
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_user_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_ext`;
CREATE TABLE `jc_user_ext` (
  `user_id` int(11) NOT NULL,
  `realname` varchar(100) DEFAULT NULL COMMENT '真实姓名',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '出生日期',
  `intro` varchar(255) DEFAULT NULL COMMENT '个人介绍',
  `comefrom` varchar(150) DEFAULT NULL COMMENT '来自',
  `qq` varchar(100) DEFAULT NULL COMMENT 'QQ',
  `msn` varchar(100) DEFAULT NULL COMMENT 'MSN',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `user_img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `user_signature` varchar(255) DEFAULT NULL COMMENT '用户个性签名',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_jc_ext_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户扩展信息表';

-- ----------------------------
-- Records of jc_user_ext
-- ----------------------------
INSERT INTO `jc_user_ext` VALUES ('1', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `jc_user_ext` VALUES ('3', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `jc_user_ext` VALUES ('4', null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `jc_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_role`;
CREATE TABLE `jc_user_role` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `fk_jc_role_user` (`user_id`),
  CONSTRAINT `fk_jc_role_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户角色关联表';

-- ----------------------------
-- Records of jc_user_role
-- ----------------------------
INSERT INTO `jc_user_role` VALUES ('1', '1');
INSERT INTO `jc_user_role` VALUES ('2', '4');

-- ----------------------------
-- Table structure for `jc_user_site`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_site`;
CREATE TABLE `jc_user_site` (
  `usersite_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `check_step` tinyint(4) NOT NULL DEFAULT '1' COMMENT '审核级别',
  `is_all_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否拥有所有栏目的权限',
  PRIMARY KEY (`usersite_id`),
  KEY `fk_jc_site_user` (`user_id`),
  KEY `fk_jc_user_site` (`site_id`),
  CONSTRAINT `fk_jc_site_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS管理员站点表';

-- ----------------------------
-- Records of jc_user_site
-- ----------------------------
INSERT INTO `jc_user_site` VALUES ('1', '1', '1', '2', '1');
INSERT INTO `jc_user_site` VALUES ('2', '4', '1', '1', '0');

-- ----------------------------
-- Table structure for `jc_vote_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_item`;
CREATE TABLE `jc_vote_item` (
  `voteitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `votetopic_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `vote_count` int(11) NOT NULL DEFAULT '0' COMMENT '投票数量',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  PRIMARY KEY (`voteitem_id`),
  KEY `fk_jc_vote_item_topic` (`votetopic_id`),
  CONSTRAINT `fk_jc_vote_item_topic` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='CMS投票项';

-- ----------------------------
-- Records of jc_vote_item
-- ----------------------------
INSERT INTO `jc_vote_item` VALUES ('1', '1', '基于java技术，安全稳定，易扩展', '20', '1');
INSERT INTO `jc_vote_item` VALUES ('4', '1', 'jsp是未来发展的趋势', '23', '4');
INSERT INTO `jc_vote_item` VALUES ('5', '1', 'java执行速度快，性能优良', '5', '5');
INSERT INTO `jc_vote_item` VALUES ('6', '1', '跨平台，支持windows、linux、unix', '6', '6');
INSERT INTO `jc_vote_item` VALUES ('7', '1', '学习研究', '11', '7');
INSERT INTO `jc_vote_item` VALUES ('8', '1', '其它', '10', '8');

-- ----------------------------
-- Table structure for `jc_vote_record`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_record`;
CREATE TABLE `jc_vote_record` (
  `voterecored_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `votetopic_id` int(11) NOT NULL,
  `vote_time` datetime NOT NULL COMMENT '投票时间',
  `vote_ip` varchar(50) NOT NULL COMMENT '投票IP',
  `vote_cookie` varchar(32) NOT NULL COMMENT '投票COOKIE',
  PRIMARY KEY (`voterecored_id`),
  KEY `fk_jc_vote_record_topic` (`votetopic_id`),
  KEY `fk_jc_voterecord_user` (`user_id`),
  CONSTRAINT `fk_jc_voterecord_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_vote_record_topic` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS投票记录';

-- ----------------------------
-- Records of jc_vote_record
-- ----------------------------

-- ----------------------------
-- Table structure for `jc_vote_topic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_topic`;
CREATE TABLE `jc_vote_topic` (
  `votetopic_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `repeate_hour` int(11) DEFAULT NULL COMMENT '重复投票限制时间，单位小时，为空不允许重复投票',
  `total_count` int(11) NOT NULL DEFAULT '0' COMMENT '总投票数',
  `multi_select` int(11) NOT NULL DEFAULT '1' COMMENT '最多可以选择几项',
  `is_restrict_member` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制会员',
  `is_restrict_ip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制IP',
  `is_restrict_cookie` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制COOKIE',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认主题',
  PRIMARY KEY (`votetopic_id`),
  KEY `fk_jc_votetopic_site` (`site_id`),
  CONSTRAINT `fk_jc_votetopic_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS投票主题';

-- ----------------------------
-- Records of jc_vote_topic
-- ----------------------------
INSERT INTO `jc_vote_topic` VALUES ('1', '1', '您为什么选择jsp cms,java cms? ', '在php cms为建站主流CMS的年代，您为什么选择jsp cms,java cms？请给出您的意见吧！', null, null, null, '75', '3', '0', '0', '1', '0', '1');

-- ----------------------------
-- Table structure for `jo_authentication`
-- ----------------------------
DROP TABLE IF EXISTS `jo_authentication`;
CREATE TABLE `jo_authentication` (
  `authentication_id` char(32) NOT NULL COMMENT '认证ID',
  `userid` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `login_time` datetime NOT NULL COMMENT '登录时间',
  `login_ip` varchar(50) NOT NULL COMMENT '登录ip',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`authentication_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='认证信息表';

-- ----------------------------
-- Records of jo_authentication
-- ----------------------------
INSERT INTO `jo_authentication` VALUES ('13d285effdab4ea893c796ff015cff00', '1', 'admin', 'admin@yahoo.com', '2015-07-28 00:16:22', '0:0:0:0:0:0:0:1', '2015-07-28 00:26:11');
INSERT INTO `jo_authentication` VALUES ('1e92b22115b147dea4c60ac289548cf7', '1', 'admin', 'admin@yahoo.com', '2015-07-28 00:56:33', '0:0:0:0:0:0:0:1', '2015-07-28 00:57:06');
INSERT INTO `jo_authentication` VALUES ('293f0dd347ce43979e9b74624626c75c', '1', 'admin', 'admin@yahoo.com', '2015-07-27 23:29:10', '0:0:0:0:0:0:0:1', '2015-07-27 23:41:40');
INSERT INTO `jo_authentication` VALUES ('39d37caa9efb4584aa90d2ae0ec62e82', '1', 'admin', 'admin@yahoo.com', '2015-07-27 22:51:23', '0:0:0:0:0:0:0:1', '2015-07-27 22:57:11');
INSERT INTO `jo_authentication` VALUES ('5eee2a4b9b2f4a34835c886fea786735', '1', 'admin', 'admin@yahoo.com', '2015-07-28 16:02:33', '0:0:0:0:0:0:0:1', '2015-07-28 16:03:04');
INSERT INTO `jo_authentication` VALUES ('89c2421e67444146914ef91846f0f124', '1', 'admin', 'admin@yahoo.com', '2015-07-27 22:58:46', '0:0:0:0:0:0:0:1', '2015-07-27 22:59:26');
INSERT INTO `jo_authentication` VALUES ('924cb2be685c4eddb6a200d4974b09b7', '1', 'admin', 'admin@yahoo.com', '2015-07-28 12:23:26', '0:0:0:0:0:0:0:1', '2015-07-28 12:30:02');
INSERT INTO `jo_authentication` VALUES ('d5315623085d4fc8bb75fdf3b0415a4a', '1', 'admin', 'admin@yahoo.com', '2015-07-28 10:54:44', '0:0:0:0:0:0:0:1', '2015-07-28 11:03:37');

-- ----------------------------
-- Table structure for `jo_config`
-- ----------------------------
DROP TABLE IF EXISTS `jo_config`;
CREATE TABLE `jo_config` (
  `cfg_key` varchar(50) NOT NULL COMMENT '配置KEY',
  `cfg_value` varchar(255) DEFAULT NULL COMMENT '配置VALUE',
  PRIMARY KEY (`cfg_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置表';

-- ----------------------------
-- Records of jo_config
-- ----------------------------
INSERT INTO `jo_config` VALUES ('email_encoding', '');
INSERT INTO `jo_config` VALUES ('email_host', 'smtp.163.com');
INSERT INTO `jo_config` VALUES ('email_password', '1');
INSERT INTO `jo_config` VALUES ('email_personal', '');
INSERT INTO `jo_config` VALUES ('email_port', null);
INSERT INTO `jo_config` VALUES ('email_username', 'willcms@163.com');
INSERT INTO `jo_config` VALUES ('login_error_interval', '30');
INSERT INTO `jo_config` VALUES ('login_error_times', '3');
INSERT INTO `jo_config` VALUES ('message_subject', 'willcms会员密码找回信息');
INSERT INTO `jo_config` VALUES ('message_text', '感谢您使用willcms系统会员密码找回功能，请记住以下找回信息：\r\n用户ID：${uid}\r\n用户名：${username}\r\n您的新密码为：${resetPwd}\r\n请访问如下链接新密码才能生效：\r\nhttp://localhost/member/password_reset.jspx?uid=${uid}&key=${resetKey}\r\n');

-- ----------------------------
-- Table structure for `jo_ftp`
-- ----------------------------
DROP TABLE IF EXISTS `jo_ftp`;
CREATE TABLE `jo_ftp` (
  `ftp_id` int(11) NOT NULL AUTO_INCREMENT,
  `ftp_name` varchar(100) NOT NULL COMMENT '名称',
  `ip` varchar(50) NOT NULL COMMENT 'IP',
  `port` int(11) NOT NULL DEFAULT '21' COMMENT '端口号',
  `username` varchar(100) DEFAULT NULL COMMENT '登录名',
  `password` varchar(100) DEFAULT NULL COMMENT '登陆密码',
  `encoding` varchar(20) NOT NULL DEFAULT 'UTF-8' COMMENT '编码',
  `timeout` int(11) DEFAULT NULL COMMENT '超时时间',
  `ftp_path` varchar(255) DEFAULT NULL COMMENT '路径',
  `url` varchar(255) NOT NULL COMMENT '访问URL',
  PRIMARY KEY (`ftp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FTP表';

-- ----------------------------
-- Records of jo_ftp
-- ----------------------------

-- ----------------------------
-- Table structure for `jo_template`
-- ----------------------------
DROP TABLE IF EXISTS `jo_template`;
CREATE TABLE `jo_template` (
  `tpl_name` varchar(150) NOT NULL COMMENT '模板名称',
  `tpl_source` longtext COMMENT '模板内容',
  `last_modified` bigint(20) NOT NULL COMMENT '最后修改时间',
  `is_directory` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否目录',
  PRIMARY KEY (`tpl_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模板表';

-- ----------------------------
-- Records of jo_template
-- ----------------------------

-- ----------------------------
-- Table structure for `jo_upload`
-- ----------------------------
DROP TABLE IF EXISTS `jo_upload`;
CREATE TABLE `jo_upload` (
  `filename` varchar(150) NOT NULL COMMENT '文件名',
  `length` int(11) NOT NULL COMMENT '文件大小(字节)',
  `last_modified` bigint(20) NOT NULL COMMENT '最后修改时间',
  `content` longblob NOT NULL COMMENT '内容',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上传附件表';

-- ----------------------------
-- Records of jo_upload
-- ----------------------------

-- ----------------------------
-- Table structure for `jo_user`
-- ----------------------------
DROP TABLE IF EXISTS `jo_user`;
CREATE TABLE `jo_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `password` char(32) NOT NULL COMMENT '密码',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `register_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '注册IP',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '最后登录IP',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reset_key` char(32) DEFAULT NULL COMMENT '重置密码KEY',
  `reset_pwd` varchar(10) DEFAULT NULL COMMENT '重置密码VALUE',
  `error_time` datetime DEFAULT NULL COMMENT '登录错误时间',
  `error_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录错误次数',
  `error_ip` varchar(50) DEFAULT NULL COMMENT '登录错误IP',
  `activation` tinyint(1) NOT NULL DEFAULT '1' COMMENT '激活状态',
  `activation_code` char(32) DEFAULT NULL COMMENT '激活码',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ak_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of jo_user
-- ----------------------------
INSERT INTO `jo_user` VALUES ('1', 'admin', 'admin@yahoo.com', '5f4dcc3b5aa765d61d8327deb882cf99', '2011-01-03 00:00:00', '127.0.0.1', '2015-07-28 16:02:33', '0:0:0:0:0:0:0:1', '92', null, null, null, '0', null, '1', null);
INSERT INTO `jo_user` VALUES ('3', 'asdfasdfasdf', 'sadf@xb.com', 'a95c530a7af5f492a74499e70578d150', '2011-06-18 15:48:29', '127.0.0.1', '2011-06-18 15:48:42', '127.0.0.1', '1', null, null, null, '0', null, '1', null);
INSERT INTO `jo_user` VALUES ('4', 'cyjsw', null, 'add414b321ee9996c786dccb1bbf3d87', '2011-06-20 19:08:05', '192.168.0.202', '2011-06-20 19:18:34', '192.168.0.202', '4', null, null, null, '0', null, '1', null);
