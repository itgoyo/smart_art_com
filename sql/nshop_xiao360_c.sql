/*
Navicat MySQL Data Transfer

Source Server         : nshop
Source Server Version : 50719
Source Host           : 120.79.104.186:3306
Source Database       : nshop_xiao360_c

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2019-02-14 09:08:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for nc_cms_article
-- ----------------------------
DROP TABLE IF EXISTS `nc_cms_article`;
CREATE TABLE `nc_cms_article` (
  `article_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章编号',
  `title` varchar(50) NOT NULL COMMENT '文章标题',
  `class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章分类编号',
  `short_title` varchar(50) NOT NULL DEFAULT '' COMMENT '文章短标题',
  `source` varchar(50) NOT NULL DEFAULT '' COMMENT '文章来源',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '文章来源链接',
  `author` varchar(50) NOT NULL COMMENT '文章作者',
  `summary` varchar(140) NOT NULL DEFAULT '' COMMENT '文章摘要',
  `content` text NOT NULL COMMENT '文章正文',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '文章标题图片',
  `keyword` varchar(255) NOT NULL DEFAULT '' COMMENT '文章关键字',
  `article_id_array` varchar(255) NOT NULL DEFAULT '' COMMENT '相关文章',
  `click` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章点击量',
  `sort` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '文章排序0-255',
  `commend_flag` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '文章推荐标志0-未推荐，1-已推荐',
  `comment_flag` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '文章是否允许评论1-允许，0-不允许',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0-草稿、1-待审核、2-已发布、-1-回收站',
  `attachment_path` text NOT NULL COMMENT '文章附件路径',
  `tag` varchar(255) NOT NULL DEFAULT '' COMMENT '文章标签',
  `comment_count` int(10) unsigned NOT NULL COMMENT '文章评论数',
  `share_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章分享数',
  `publisher_name` varchar(50) NOT NULL COMMENT '发布者用户名 ',
  `uid` int(10) unsigned NOT NULL COMMENT '发布者编号',
  `last_comment_time` int(11) DEFAULT '0' COMMENT '最新评论时间',
  `public_time` int(11) DEFAULT '0' COMMENT '发布时间',
  `create_time` int(11) DEFAULT '0' COMMENT '文章发布时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '文章修改时间',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=6553 COMMENT='CMS文章表';

-- ----------------------------
-- Records of nc_cms_article
-- ----------------------------
INSERT INTO `nc_cms_article` VALUES ('1', '第一篇新闻', '1', '短标题', '', '', 'admin', '文章摘要', '<p>文章内容</p>', '', '', '', '0', '0', '0', '0', '2', '', '', '0', '0', '1', '1', '0', '1544156298', '1544156298', '1544498884');
INSERT INTO `nc_cms_article` VALUES ('2', '第二篇新闻', '2', '', '', '', 'admin', '', '<p>文章内容</p>', '', '', '', '0', '1', '0', '0', '2', '', '', '0', '0', '1', '1', '0', '1544169168', '1544169168', '1544498891');

-- ----------------------------
-- Table structure for nc_cms_article_class
-- ----------------------------
DROP TABLE IF EXISTS `nc_cms_article_class`;
CREATE TABLE `nc_cms_article_class` (
  `class_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类编号 ',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '上级分类',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1170 COMMENT='cms文章分类表';

-- ----------------------------
-- Records of nc_cms_article_class
-- ----------------------------
INSERT INTO `nc_cms_article_class` VALUES ('1', '0', '公司新闻', '0');
INSERT INTO `nc_cms_article_class` VALUES ('2', '0', '行业新闻', '1');

-- ----------------------------
-- Table structure for nc_cms_comment
-- ----------------------------
DROP TABLE IF EXISTS `nc_cms_comment`;
CREATE TABLE `nc_cms_comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论编号',
  `text` varchar(2000) NOT NULL COMMENT '评论内容',
  `uid` int(10) unsigned NOT NULL COMMENT '评论人编号',
  `quote_comment_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论引用',
  `up` int(10) unsigned NOT NULL COMMENT '点赞数量',
  `comment_time` int(10) unsigned NOT NULL COMMENT '评论时间',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='CMS评论表';

-- ----------------------------
-- Records of nc_cms_comment
-- ----------------------------

-- ----------------------------
-- Table structure for nc_cms_topic
-- ----------------------------
DROP TABLE IF EXISTS `nc_cms_topic`;
CREATE TABLE `nc_cms_topic` (
  `topic_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题编号',
  `instance_id` int(10) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `title` varchar(255) NOT NULL COMMENT '专题标题',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '专题封面',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '专题状态  0草稿  1发布',
  `content` text NOT NULL COMMENT '专题内容',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`topic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='专题';

-- ----------------------------
-- Records of nc_cms_topic
-- ----------------------------
INSERT INTO `nc_cms_topic` VALUES ('1', '0', '专题一', 'upload/common/1544169278.jpg', '1', '<p>专题一内容</p>', '1544169287', '0');

-- ----------------------------
-- Table structure for ns_account
-- ----------------------------
DROP TABLE IF EXISTS `ns_account`;
CREATE TABLE `ns_account` (
  `account_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `account_profit` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '平台的总营业额',
  `account_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '平台资金总余额',
  `account_return` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '平台利润总额',
  `account_deposit` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '保证金总额',
  `account_order` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商城订单总额',
  `account_withdraw` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商城提现总额',
  `account_shop` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺总余额',
  `account_shop_withdraw` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺总提现',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='商城资金统计';

-- ----------------------------
-- Records of ns_account
-- ----------------------------

-- ----------------------------
-- Table structure for ns_account_assistant_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_account_assistant_records`;
CREATE TABLE `ns_account_assistant_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `serial_no` varchar(50) NOT NULL DEFAULT '' COMMENT '流水号',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '对应金额',
  `account_type` tinyint(1) NOT NULL COMMENT '账户类型',
  `type_alis_id` int(11) NOT NULL COMMENT '关联ID',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招商员支付记录';

-- ----------------------------
-- Records of ns_account_assistant_records
-- ----------------------------

-- ----------------------------
-- Table structure for ns_account_order_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_account_order_records`;
CREATE TABLE `ns_account_order_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `serial_no` varchar(50) NOT NULL DEFAULT '' COMMENT '流水号',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '对应金额',
  `account_type` tinyint(1) NOT NULL COMMENT '账户类型',
  `type_alis_id` int(11) NOT NULL COMMENT '关联ID',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='金额账户记录';

-- ----------------------------
-- Records of ns_account_order_records
-- ----------------------------

-- ----------------------------
-- Table structure for ns_account_period
-- ----------------------------
DROP TABLE IF EXISTS `ns_account_period`;
CREATE TABLE `ns_account_period` (
  `period_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `period_year` int(10) NOT NULL COMMENT '账期年份',
  `period_month` int(10) NOT NULL COMMENT '账期月份',
  `account_profit` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账期总营业额',
  `account_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账期总发生余额',
  `account_return` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账期利润总额',
  `account_deposit` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账期保证金总额',
  `account_order` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账期订单总额',
  `account_withdraw` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账期店铺提现总额',
  `account_shop` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账期店铺总发生额',
  `account_shop_withdraw` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账期店铺总提现额',
  `start_time` int(11) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '结束时间',
  PRIMARY KEY (`period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='商城账期结算表';

-- ----------------------------
-- Records of ns_account_period
-- ----------------------------

-- ----------------------------
-- Table structure for ns_account_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_account_records`;
CREATE TABLE `ns_account_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '对应金额',
  `account_type` tinyint(1) NOT NULL COMMENT '账户类型',
  `type_alis_id` int(11) NOT NULL COMMENT '关联ID',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `is_calculate` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否参与计算',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1092 COMMENT='金额账户记录';

-- ----------------------------
-- Records of ns_account_records
-- ----------------------------

-- ----------------------------
-- Table structure for ns_account_return_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_account_return_records`;
CREATE TABLE `ns_account_return_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `return_type` int(11) NOT NULL DEFAULT '0' COMMENT '提成类型',
  `type_alis_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  `is_display` int(11) NOT NULL DEFAULT '0' COMMENT '是否显示',
  `is_calculate` int(11) NOT NULL DEFAULT '0' COMMENT '是否计算',
  `remark` varchar(255) NOT NULL DEFAULT '0' COMMENT '备注',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=910 COMMENT='平台的利润的记录';

-- ----------------------------
-- Records of ns_account_return_records
-- ----------------------------

-- ----------------------------
-- Table structure for ns_account_withdraw_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_account_withdraw_records`;
CREATE TABLE `ns_account_withdraw_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `serial_no` varchar(50) NOT NULL DEFAULT '' COMMENT '流水号',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '对应金额',
  `account_type` tinyint(1) NOT NULL COMMENT '账户类型',
  `type_alis_id` int(11) NOT NULL COMMENT '关联ID',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='金额账户记录';

-- ----------------------------
-- Records of ns_account_withdraw_records
-- ----------------------------

-- ----------------------------
-- Table structure for ns_account_withdraw_user_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_account_withdraw_user_records`;
CREATE TABLE `ns_account_withdraw_user_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `serial_no` varchar(50) NOT NULL DEFAULT '' COMMENT '流水号',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '对应金额',
  `account_type` tinyint(1) NOT NULL COMMENT '账户类型',
  `type_alis_id` int(11) NOT NULL COMMENT '关联ID',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员提现记录表';

-- ----------------------------
-- Records of ns_account_withdraw_user_records
-- ----------------------------

-- ----------------------------
-- Table structure for ns_attribute
-- ----------------------------
DROP TABLE IF EXISTS `ns_attribute`;
CREATE TABLE `ns_attribute` (
  `attr_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品属性ID',
  `attr_name` varchar(255) NOT NULL DEFAULT '' COMMENT '属性名称',
  `is_use` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否使用',
  `spec_id_array` varchar(255) NOT NULL DEFAULT '' COMMENT '关联规格',
  `sort` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`attr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='商品相关属性';

-- ----------------------------
-- Records of ns_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for ns_attribute_value
-- ----------------------------
DROP TABLE IF EXISTS `ns_attribute_value`;
CREATE TABLE `ns_attribute_value` (
  `attr_value_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性值ID',
  `attr_value_name` varchar(50) NOT NULL DEFAULT '' COMMENT '属性值名称',
  `attr_id` int(11) NOT NULL COMMENT '属性ID',
  `value` varchar(1000) NOT NULL DEFAULT '' COMMENT '属性对应相关数据',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '属性对应输入类型1.直接2.单选3.多选',
  `sort` int(11) NOT NULL DEFAULT '1999' COMMENT '排序号',
  `is_search` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否使用',
  PRIMARY KEY (`attr_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=4096 COMMENT='商品属性值';

-- ----------------------------
-- Records of ns_attribute_value
-- ----------------------------

-- ----------------------------
-- Table structure for ns_cart
-- ----------------------------
DROP TABLE IF EXISTS `ns_cart`;
CREATE TABLE `ns_cart` (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `buyer_id` int(11) NOT NULL DEFAULT '0' COMMENT '买家id',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `shop_name` varchar(100) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_name` varchar(200) NOT NULL COMMENT '商品名称',
  `sku_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品的skuid',
  `sku_name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品的sku名称',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `num` smallint(5) NOT NULL DEFAULT '1' COMMENT '购买商品数量',
  `goods_picture` int(11) NOT NULL DEFAULT '0' COMMENT '商品图片',
  `bl_id` mediumint(8) NOT NULL DEFAULT '0' COMMENT '组合套装ID',
  PRIMARY KEY (`cart_id`),
  KEY `member_id` (`buyer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1170 COMMENT='购物车表';

-- ----------------------------
-- Records of ns_cart
-- ----------------------------
INSERT INTO `ns_cart` VALUES ('13', '3488', '0', '', '1', '72色粉笔', '1', '', '30.00', '6', '6', '0');
INSERT INTO `ns_cart` VALUES ('14', '3488', '0', '', '4', '小丑拼图', '4', '', '5.00', '15', '8', '0');
INSERT INTO `ns_cart` VALUES ('15', '3488', '0', '', '5', '颜料套装', '5', '', '288.00', '4', '9', '0');
INSERT INTO `ns_cart` VALUES ('16', '3488', '0', '', '2', '斯玛特笔帘', '2', '', '30.00', '3', '4', '0');

-- ----------------------------
-- Table structure for ns_click_fabulous
-- ----------------------------
DROP TABLE IF EXISTS `ns_click_fabulous`;
CREATE TABLE `ns_click_fabulous` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `shop_id` int(11) NOT NULL COMMENT '店铺id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `create_time` int(11) DEFAULT '0' COMMENT '点赞时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '点赞状态 0 未点赞 1 点赞',
  `number` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='商品点赞记录表';

-- ----------------------------
-- Records of ns_click_fabulous
-- ----------------------------
INSERT INTO `ns_click_fabulous` VALUES ('1', '3073', '0', '3', '1544134156', '1', '0.00');
INSERT INTO `ns_click_fabulous` VALUES ('2', '3073', '0', '1', '1544176884', '1', '0.00');
INSERT INTO `ns_click_fabulous` VALUES ('3', '3073', '0', '4', '1544309237', '1', '1.00');
INSERT INTO `ns_click_fabulous` VALUES ('4', '3073', '0', '7', '1546583291', '1', '1.00');
INSERT INTO `ns_click_fabulous` VALUES ('5', '3488', '0', '4', '1546826143', '1', '1.00');

-- ----------------------------
-- Table structure for ns_consult
-- ----------------------------
DROP TABLE IF EXISTS `ns_consult`;
CREATE TABLE `ns_consult` (
  `consult_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '咨询编号',
  `goods_id` int(11) unsigned DEFAULT '0' COMMENT '商品编号',
  `goods_name` varchar(100) NOT NULL COMMENT '商品名称',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '咨询发布者会员编号(0：游客)',
  `member_name` varchar(100) NOT NULL DEFAULT '' COMMENT '会员名称',
  `shop_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '店铺编号',
  `shop_name` varchar(50) NOT NULL COMMENT '店铺名称',
  `ct_id` int(10) unsigned NOT NULL COMMENT '咨询类型',
  `consult_content` varchar(255) NOT NULL DEFAULT '' COMMENT '咨询内容',
  `consult_reply` varchar(255) NOT NULL DEFAULT '' COMMENT '咨询回复内容',
  `isanonymous` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0表示不匿名 1表示匿名',
  `consult_addtime` int(11) DEFAULT '0' COMMENT '咨询发布时间',
  `consult_reply_time` int(11) DEFAULT '0' COMMENT '咨询回复时间',
  PRIMARY KEY (`consult_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1638 COMMENT='咨询类型表';

-- ----------------------------
-- Records of ns_consult
-- ----------------------------

-- ----------------------------
-- Table structure for ns_consult_type
-- ----------------------------
DROP TABLE IF EXISTS `ns_consult_type`;
CREATE TABLE `ns_consult_type` (
  `ct_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '咨询类型id',
  `ct_name` varchar(50) NOT NULL DEFAULT '' COMMENT '咨询类型名称',
  `ct_introduce` text NOT NULL COMMENT '咨询类型详细介绍',
  `ct_sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`ct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='咨询类型表';

-- ----------------------------
-- Records of ns_consult_type
-- ----------------------------

-- ----------------------------
-- Table structure for ns_coupon
-- ----------------------------
DROP TABLE IF EXISTS `ns_coupon`;
CREATE TABLE `ns_coupon` (
  `coupon_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '优惠券id',
  `coupon_type_id` int(11) NOT NULL COMMENT '优惠券类型id',
  `shop_id` int(11) NOT NULL COMMENT '店铺Id',
  `coupon_code` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券编码',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '领用人',
  `use_order_id` int(11) NOT NULL DEFAULT '0' COMMENT '优惠券使用订单id',
  `create_order_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建订单id(优惠券只有是完成订单发放的优惠券时才有值)',
  `money` decimal(10,2) NOT NULL COMMENT '面额',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '优惠券状态 0未领用 1已领用（未使用） 2已使用 3已过期',
  `get_type` int(11) NOT NULL DEFAULT '0' COMMENT '获取方式1订单2.首页领取',
  `fetch_time` int(11) DEFAULT '0' COMMENT '领取时间',
  `use_time` int(11) DEFAULT '0' COMMENT '使用时间',
  `start_time` int(11) DEFAULT '0' COMMENT '有效期开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '有效期结束时间',
  PRIMARY KEY (`coupon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=148 COMMENT='优惠券表';

-- ----------------------------
-- Records of ns_coupon
-- ----------------------------
INSERT INTO `ns_coupon` VALUES ('1', '1', '0', '1544241680384', '3073', '0', '0', '20.00', '3', '2', '1544241721', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('2', '1', '0', '1544241680641', '0', '0', '0', '20.00', '3', '0', '0', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('3', '1', '0', '1544241680720', '0', '0', '0', '20.00', '3', '0', '0', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('4', '1', '0', '1544241680785', '0', '0', '0', '20.00', '3', '0', '0', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('5', '1', '0', '1544241680480', '0', '0', '0', '20.00', '3', '0', '0', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('6', '1', '0', '1544241680575', '0', '0', '0', '20.00', '3', '0', '0', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('7', '1', '0', '1544241680717', '0', '0', '0', '20.00', '3', '0', '0', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('8', '1', '0', '1544241680475', '0', '0', '0', '20.00', '3', '0', '0', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('9', '1', '0', '1544241680918', '0', '0', '0', '20.00', '3', '0', '0', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('10', '1', '0', '1544241680258', '0', '0', '0', '20.00', '3', '0', '0', '0', '1544241659', '1546228863');
INSERT INTO `ns_coupon` VALUES ('11', '2', '0', '1544241815928', '3073', '0', '0', '50.00', '3', '3', '1544254862', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('12', '2', '0', '1544241815998', '0', '0', '0', '50.00', '3', '0', '0', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('13', '2', '0', '1544241815830', '0', '0', '0', '50.00', '3', '0', '0', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('14', '2', '0', '1544241815642', '0', '0', '0', '50.00', '3', '0', '0', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('15', '2', '0', '1544241815395', '0', '0', '0', '50.00', '3', '0', '0', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('16', '2', '0', '1544241815318', '0', '0', '0', '50.00', '3', '0', '0', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('17', '2', '0', '1544241815866', '0', '0', '0', '50.00', '3', '0', '0', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('18', '2', '0', '1544241815525', '0', '0', '0', '50.00', '3', '0', '0', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('19', '2', '0', '1544241815693', '0', '0', '0', '50.00', '3', '0', '0', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('20', '2', '0', '1544241815937', '0', '0', '0', '50.00', '3', '0', '0', '0', '1544241808', '1546229010');
INSERT INTO `ns_coupon` VALUES ('21', '3', '0', '1544255330548', '3073', '0', '0', '2.00', '3', '3', '1544255367', '0', '1544255321', '1546242523');
INSERT INTO `ns_coupon` VALUES ('22', '3', '0', '1544255330199', '0', '0', '0', '2.00', '3', '0', '0', '0', '1544255321', '1546242523');
INSERT INTO `ns_coupon` VALUES ('23', '3', '0', '1544255330753', '0', '0', '0', '2.00', '3', '0', '0', '0', '1544255321', '1546242523');
INSERT INTO `ns_coupon` VALUES ('24', '3', '0', '1544255330353', '0', '0', '0', '2.00', '3', '0', '0', '0', '1544255321', '1546242523');
INSERT INTO `ns_coupon` VALUES ('25', '3', '0', '1544255330503', '0', '0', '0', '2.00', '3', '0', '0', '0', '1544255321', '1546242523');
INSERT INTO `ns_coupon` VALUES ('26', '3', '0', '1544255330417', '0', '0', '0', '2.00', '3', '0', '0', '0', '1544255321', '1546242523');
INSERT INTO `ns_coupon` VALUES ('27', '3', '0', '1544255330823', '0', '0', '0', '2.00', '3', '0', '0', '0', '1544255321', '1546242523');
INSERT INTO `ns_coupon` VALUES ('28', '3', '0', '1544255330537', '0', '0', '0', '2.00', '3', '0', '0', '0', '1544255321', '1546242523');
INSERT INTO `ns_coupon` VALUES ('29', '3', '0', '1544255330272', '0', '0', '0', '2.00', '3', '0', '0', '0', '1544255321', '1546242523');
INSERT INTO `ns_coupon` VALUES ('30', '3', '0', '1544255330826', '0', '0', '0', '2.00', '3', '0', '0', '0', '1544255321', '1546242523');

-- ----------------------------
-- Table structure for ns_coupon_goods
-- ----------------------------
DROP TABLE IF EXISTS `ns_coupon_goods`;
CREATE TABLE `ns_coupon_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_type_id` int(11) NOT NULL COMMENT '优惠券类型id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=606 COMMENT='优惠券使用商品表';

-- ----------------------------
-- Records of ns_coupon_goods
-- ----------------------------

-- ----------------------------
-- Table structure for ns_coupon_type
-- ----------------------------
DROP TABLE IF EXISTS `ns_coupon_type`;
CREATE TABLE `ns_coupon_type` (
  `coupon_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '优惠券类型Id',
  `shop_id` int(11) NOT NULL DEFAULT '1' COMMENT '店铺ID',
  `coupon_name` varchar(50) NOT NULL DEFAULT '' COMMENT '优惠券名称',
  `money` decimal(10,2) NOT NULL COMMENT '发放面额',
  `count` int(11) NOT NULL COMMENT '发放数量',
  `max_fetch` int(11) NOT NULL DEFAULT '0' COMMENT '每人最大领取个数 0无限制',
  `at_least` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '满多少元使用 0代表无限制',
  `need_user_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '领取人会员等级',
  `range_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '使用范围0部分产品使用 1全场产品使用',
  `is_show` int(11) NOT NULL DEFAULT '0' COMMENT '是否允许首页显示0不显示1显示',
  `start_time` int(11) DEFAULT '0' COMMENT '有效日期开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '有效日期结束时间',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`coupon_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1365 COMMENT='优惠券类型表';

-- ----------------------------
-- Records of ns_coupon_type
-- ----------------------------
INSERT INTO `ns_coupon_type` VALUES ('1', '0', '20元商城通用券', '20.00', '10', '1', '200.00', '0', '1', '0', '1544241659', '1546228863', '0', '0');
INSERT INTO `ns_coupon_type` VALUES ('2', '0', '50元商城通用券', '50.00', '10', '1', '500.00', '0', '1', '0', '1544241808', '1546229010', '0', '0');
INSERT INTO `ns_coupon_type` VALUES ('3', '0', '2元商城通用券', '2.00', '10', '1', '20.00', '0', '1', '0', '1544255321', '1546242523', '0', '0');

-- ----------------------------
-- Table structure for ns_express_company
-- ----------------------------
DROP TABLE IF EXISTS `ns_express_company`;
CREATE TABLE `ns_express_company` (
  `co_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表序号',
  `shop_id` int(11) NOT NULL COMMENT '商铺id',
  `company_name` varchar(50) NOT NULL DEFAULT '' COMMENT '物流公司名称',
  `express_no` varchar(20) NOT NULL DEFAULT '' COMMENT '物流编号',
  `is_enabled` int(11) NOT NULL DEFAULT '1' COMMENT '使用状态',
  `image` varchar(255) DEFAULT '' COMMENT '物流公司模版图片',
  `phone` varchar(50) NOT NULL DEFAULT '' COMMENT '联系电话',
  `orders` int(11) DEFAULT NULL,
  `express_logo` varchar(255) DEFAULT '' COMMENT '公司logo',
  `is_default` int(11) NOT NULL DEFAULT '0' COMMENT '是否设置为默认 0未设置 1 默认',
  PRIMARY KEY (`co_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=420 COMMENT='物流公司';

-- ----------------------------
-- Records of ns_express_company
-- ----------------------------
INSERT INTO `ns_express_company` VALUES ('1', '0', '顺丰快递', '123456789', '1', '', '', '0', '', '1');
INSERT INTO `ns_express_company` VALUES ('2', '0', '圆通快递', '536536256538', '1', '', '16363476374', '1', '', '0');

-- ----------------------------
-- Table structure for ns_express_shipping
-- ----------------------------
DROP TABLE IF EXISTS `ns_express_shipping`;
CREATE TABLE `ns_express_shipping` (
  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '运单模版id',
  `shop_id` int(11) NOT NULL COMMENT '店铺id',
  `template_name` varchar(255) NOT NULL DEFAULT '' COMMENT '模版名称',
  `co_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流公司 id',
  `size_type` smallint(6) NOT NULL DEFAULT '1' COMMENT '尺寸类型 1像素px  2毫米mm',
  `width` smallint(6) NOT NULL DEFAULT '0' COMMENT '宽度',
  `height` smallint(6) NOT NULL DEFAULT '0' COMMENT '长度',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '快递单图片',
  PRIMARY KEY (`sid`),
  KEY `IDX_express_shipping_co_id` (`co_id`),
  KEY `IDX_express_shipping_shopId` (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=5461 COMMENT='运单模板';

-- ----------------------------
-- Records of ns_express_shipping
-- ----------------------------
INSERT INTO `ns_express_shipping` VALUES ('1', '0', '顺丰快递', '1', '1', '0', '0', '');
INSERT INTO `ns_express_shipping` VALUES ('2', '0', '圆通快递', '2', '1', '0', '0', '');

-- ----------------------------
-- Table structure for ns_express_shipping_items
-- ----------------------------
DROP TABLE IF EXISTS `ns_express_shipping_items`;
CREATE TABLE `ns_express_shipping_items` (
  `sid` int(11) NOT NULL DEFAULT '0' COMMENT '运单模版id',
  `field_name` varchar(30) NOT NULL COMMENT '字段名称',
  `field_display_name` varchar(255) NOT NULL COMMENT '打印项名称',
  `is_print` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否打印',
  `x` int(11) NOT NULL DEFAULT '0' COMMENT 'x',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT 'y',
  PRIMARY KEY (`sid`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=420 COMMENT='物流模板打印项';

-- ----------------------------
-- Records of ns_express_shipping_items
-- ----------------------------
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A1', '订单编号', '1', '10', '11');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A10', '收件人邮编', '1', '10', '86');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A11', '货到付款物流编号', '1', '10', '286');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A12', '代收金额', '1', '10', '186');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A13', '备注', '1', '10', '311');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A2', '发件人公司', '1', '10', '36');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A3', '发件人地址', '1', '10', '136');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A4', '发件人姓名', '1', '10', '111');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A5', '发件人电话', '1', '10', '211');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A6', '发件人邮编', '1', '10', '236');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A7', '收件人地址', '1', '10', '261');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A8', '收件人姓名', '1', '10', '61');
INSERT INTO `ns_express_shipping_items` VALUES ('1', 'A9', '收件人电话', '1', '10', '161');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A1', '订单编号', '1', '10', '11');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A10', '收件人邮编', '1', '10', '86');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A11', '货到付款物流编号', '1', '10', '286');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A12', '代收金额', '1', '10', '186');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A13', '备注', '1', '10', '311');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A2', '发件人公司', '1', '10', '36');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A3', '发件人地址', '1', '10', '136');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A4', '发件人姓名', '1', '10', '111');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A5', '发件人电话', '1', '10', '211');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A6', '发件人邮编', '1', '10', '236');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A7', '收件人地址', '1', '10', '261');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A8', '收件人姓名', '1', '10', '61');
INSERT INTO `ns_express_shipping_items` VALUES ('2', 'A9', '收件人电话', '1', '10', '161');

-- ----------------------------
-- Table structure for ns_express_shipping_items_library
-- ----------------------------
DROP TABLE IF EXISTS `ns_express_shipping_items_library`;
CREATE TABLE `ns_express_shipping_items_library` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '物流模版打印项库ID',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `field_name` varchar(50) NOT NULL COMMENT '字段名',
  `field_display_name` varchar(50) NOT NULL COMMENT '字段显示名',
  `is_enabled` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否启用',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1260 COMMENT='物流模版打印项库';

-- ----------------------------
-- Records of ns_express_shipping_items_library
-- ----------------------------
INSERT INTO `ns_express_shipping_items_library` VALUES ('1', '0', 'A1', '订单编号', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('2', '0', 'A2', '发件人公司', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('3', '0', 'A8', '收件人姓名', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('4', '0', 'A10', '收件人邮编', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('5', '0', 'A4', '发件人姓名', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('6', '0', 'A3', '发件人地址', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('7', '0', 'A9', '收件人电话', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('8', '0', 'A12', '代收金额', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('9', '0', 'A5', '发件人电话', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('10', '0', 'A6', '发件人邮编', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('11', '0', 'A7', '收件人地址', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('12', '0', 'A11', '货到付款物流编号', '');
INSERT INTO `ns_express_shipping_items_library` VALUES ('13', '0', 'A13', '备注', '');

-- ----------------------------
-- Table structure for ns_gift_grant_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_gift_grant_records`;
CREATE TABLE `ns_gift_grant_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gift_id` int(11) NOT NULL COMMENT '赠送活动ID',
  `goods_id` int(11) NOT NULL COMMENT '赠送商品ID',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '赠送商品名称',
  `goods_img` varchar(255) NOT NULL DEFAULT '' COMMENT '赠送商品图片',
  `num` int(11) NOT NULL DEFAULT '1' COMMENT '赠送数量',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '发放方式',
  `type_id` int(11) NOT NULL DEFAULT '0' COMMENT '发放相关ID',
  `memo` text NOT NULL COMMENT '备注',
  `create_time` int(11) DEFAULT '0' COMMENT '赠送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='赠品发放记录';

-- ----------------------------
-- Records of ns_gift_grant_records
-- ----------------------------

-- ----------------------------
-- Table structure for ns_goods
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods`;
CREATE TABLE `ns_goods` (
  `goods_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id(SKU)',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `shop_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '店铺id',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类id',
  `category_id_1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一级分类id',
  `category_id_2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '二级分类id',
  `category_id_3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '三级分类id',
  `brand_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '品牌id',
  `group_id_array` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺分类id 首尾用,隔开',
  `promotion_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '促销类型 0无促销，1团购，2限时折扣',
  `promote_id` int(11) NOT NULL DEFAULT '0' COMMENT '促销活动ID',
  `goods_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '实物或虚拟商品标志 1实物商品 0 虚拟商品 2 F码商品',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '商品原价格',
  `promotion_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品促销价格',
  `cost_price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '成本价',
  `point_exchange_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '积分兑换类型 0 非积分兑换 1 只能积分兑换 ',
  `point_exchange` int(11) NOT NULL DEFAULT '0' COMMENT '积分兑换',
  `give_point` int(11) NOT NULL DEFAULT '0' COMMENT '购买商品赠送积分',
  `is_member_discount` int(1) NOT NULL DEFAULT '0' COMMENT '参与会员折扣',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '运费 0为免运费',
  `shipping_fee_id` int(11) NOT NULL DEFAULT '0' COMMENT '售卖区域id 物流模板id  ns_order_shipping_fee 表id',
  `stock` int(10) NOT NULL DEFAULT '0' COMMENT '商品库存',
  `max_buy` int(11) NOT NULL DEFAULT '0' COMMENT '限购 0 不限购',
  `clicks` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品点击数量',
  `min_stock_alarm` int(11) NOT NULL DEFAULT '0' COMMENT '库存预警值',
  `sales` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '销售数量',
  `collects` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `star` tinyint(3) unsigned NOT NULL DEFAULT '5' COMMENT '好评星级',
  `evaluates` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价数',
  `shares` int(11) NOT NULL DEFAULT '0' COMMENT '分享数',
  `province_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一级地区id',
  `city_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '二级地区id',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT '商品主图',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '商品关键词',
  `introduction` varchar(255) NOT NULL DEFAULT '' COMMENT '商品简介，促销语',
  `description` text NOT NULL COMMENT '商品详情',
  `QRcode` varchar(255) NOT NULL DEFAULT '' COMMENT '商品二维码',
  `code` varchar(50) NOT NULL DEFAULT '' COMMENT '商家编号',
  `is_stock_visible` int(1) NOT NULL DEFAULT '0' COMMENT '页面不显示库存',
  `is_hot` int(1) NOT NULL DEFAULT '0' COMMENT '是否热销商品',
  `is_recommend` int(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_new` int(1) NOT NULL DEFAULT '0' COMMENT '是否新品',
  `is_pre_sale` int(11) DEFAULT '0',
  `is_bill` int(1) NOT NULL DEFAULT '0' COMMENT '是否开具增值税发票 1是，0否',
  `state` tinyint(3) NOT NULL DEFAULT '1' COMMENT '商品状态 0下架，1正常，10违规（禁售）',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `img_id_array` varchar(1000) DEFAULT NULL COMMENT '商品图片序列',
  `sku_img_array` varchar(1000) DEFAULT NULL COMMENT '商品sku应用图片列表  属性,属性值，图片ID',
  `match_point` float(10,2) DEFAULT NULL COMMENT '实物与描述相符（根据评价计算）',
  `match_ratio` float(10,2) DEFAULT NULL COMMENT '实物与描述相符（根据评价计算）百分比',
  `real_sales` int(10) NOT NULL DEFAULT '0' COMMENT '实际销量',
  `goods_attribute_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品类型',
  `goods_spec_format` text NOT NULL COMMENT '商品规格',
  `goods_weight` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品重量',
  `goods_volume` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品体积',
  `shipping_fee_type` int(11) NOT NULL DEFAULT '1' COMMENT '计价方式1.重量2.体积3.计件',
  `extend_category_id` varchar(255) DEFAULT NULL,
  `extend_category_id_1` varchar(255) DEFAULT NULL,
  `extend_category_id_2` varchar(255) DEFAULT NULL,
  `extend_category_id_3` varchar(255) DEFAULT NULL,
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供货商id',
  `sale_date` int(11) DEFAULT '0' COMMENT '上下架时间',
  `create_time` int(11) DEFAULT '0' COMMENT '商品添加时间',
  `update_time` int(11) DEFAULT '0' COMMENT '商品编辑时间',
  `min_buy` int(11) NOT NULL DEFAULT '0' COMMENT '最少买几件',
  PRIMARY KEY (`goods_id`),
  KEY `UK_ns_goods_brand_id` (`brand_id`),
  KEY `UK_ns_goods_category_id` (`category_id`),
  KEY `UK_ns_goods_category_id_1` (`category_id_1`),
  KEY `UK_ns_goods_category_id_2` (`category_id_2`),
  KEY `UK_ns_goods_category_id_3` (`category_id_3`),
  KEY `UK_ns_goods_extend_category_id` (`extend_category_id`),
  KEY `UK_ns_goods_extend_category_id_1` (`extend_category_id_1`),
  KEY `UK_ns_goods_extend_category_id_2` (`extend_category_id_2`),
  KEY `UK_ns_goods_extend_category_id_3` (`extend_category_id_3`),
  KEY `UK_ns_goods_goods_attribute_id` (`goods_attribute_id`),
  KEY `UK_ns_goods_group_id_array` (`group_id_array`),
  KEY `UK_ns_goods_promotion_price` (`promotion_price`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16554 COMMENT='商品表';

-- ----------------------------
-- Records of ns_goods
-- ----------------------------
INSERT INTO `ns_goods` VALUES ('1', '72色粉笔', '0', '1', '1', '0', '0', '0', '', '0', '0', '1', '0.00', '30.00', '30.00', '0.00', '0', '0', '0', '0', '0.00', '0', '998', '0', '0', '30', '4', '0', '0', '0', '0', '19', '199', '6', '', '', '<p>72色粉笔</p>', 'upload/goods_qrcode/goods_qrcode_1.png', '', '1', '0', '0', '0', '0', '0', '1', '0', '6', '', null, null, '4', '1', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1543999356', '1543999356', '1544255961', '0');
INSERT INTO `ns_goods` VALUES ('2', '斯玛特笔帘', '0', '1', '1', '0', '0', '0', '', '0', '0', '1', '0.00', '30.00', '30.00', '0.00', '0', '0', '0', '0', '0.00', '0', '999', '5', '0', '30', '12', '0', '0', '0', '0', '0', '0', '4', '笔', '', '<p>商品描述</p>', 'upload/goods_qrcode/goods_qrcode_2.png', '', '1', '0', '0', '0', '0', '0', '1', '0', '4', '', null, null, '12', '1', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1544087845', '1544087845', '1544255974', '1');
INSERT INTO `ns_goods` VALUES ('3', '斯玛特玩偶', '0', '3', '3', '0', '0', '0', '', '0', '0', '1', '0.00', '40.00', '40.00', '0.00', '0', '0', '0', '0', '0.00', '0', '1000', '0', '0', '10', '1', '0', '0', '0', '0', '0', '0', '7', '', '', '<p>斯玛特玩偶</p>', 'upload/goods_qrcode/goods_qrcode_3.png', '', '1', '0', '0', '0', '0', '0', '1', '0', '7', '', null, null, '1', '1', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1544088213', '1544088213', '1548295311', '0');
INSERT INTO `ns_goods` VALUES ('4', '小丑拼图', '0', '2', '2', '0', '0', '0', '', '0', '0', '1', '0.00', '0.01', '0.01', '0.00', '0', '0', '0', '0', '0.00', '0', '97', '0', '0', '10', '33', '0', '0', '0', '0', '19', '199', '8', '', '', '<p>小丑拼图</p>', 'upload/goods_qrcode/goods_qrcode_4.png', '', '1', '0', '0', '0', '0', '0', '1', '0', '8', '', null, null, '33', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '2', '1544088525', '1544088525', '1547171261', '0');
INSERT INTO `ns_goods` VALUES ('5', '颜料套装', '0', '4', '4', '0', '0', '0', '', '0', '0', '1', '0.00', '288.00', '288.00', '0.00', '0', '0', '0', '0', '0.00', '0', '0', '0', '0', '10', '3', '0', '0', '0', '0', '19', '199', '9', '', '', '<p>颜料盘</p>', 'upload/goods_qrcode/goods_qrcode_5.png', '', '1', '0', '0', '0', '0', '0', '1', '8', '9', '', null, null, '3', '1', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1544088837', '1544088837', '1546570081', '0');
INSERT INTO `ns_goods` VALUES ('6', '总库存', '0', '1', '1', '0', '0', '0', '', '0', '0', '1', '0.00', '12.00', '12.00', '0.00', '0', '0', '0', '0', '0.00', '0', '0', '0', '0', '10', '0', '0', '0', '0', '0', '0', '0', '8', '', '', '<p>库存测试</p><p><img src=\"/upload/goods/20181206/e329fb34593096c07fd183dc0e8bead6.jpg\"/></p><p>点高品位<img src=\"/upload/goods/20181205/9c6f1c006b731509cf75d857e9d1638d.png\"/></p><p>非常好</p><p><img src=\"/upload/goods/20181206/d03bb13279de84da24d4d32d3d8c4c1a.jpg\"/></p>', 'upload/goods_qrcode/goods_qrcode_6.png', '', '1', '0', '0', '0', '0', '0', '1', '2', '8,6', '', null, null, '0', '1', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1546570274', '1546570274', '1547780161', '0');
INSERT INTO `ns_goods` VALUES ('7', '测试', '0', '2', '2', '0', '0', '0', '', '0', '0', '1', '0.00', '0.01', '0.01', '0.00', '0', '0', '0', '0', '0.00', '0', '70', '0', '0', '5', '63', '0', '0', '0', '0', '0', '0', '10', '', '', '<p>009</p>', 'upload/goods_qrcode/goods_qrcode_7.png', '', '1', '0', '0', '0', '0', '0', '1', '3', '10', '', null, null, '63', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '2', '1546576382', '1546576382', '1548414185', '0');
INSERT INTO `ns_goods` VALUES ('8', '纸杯', '0', '1', '1', '0', '0', '0', '', '0', '0', '1', '0.00', '400.00', '400.00', '0.00', '0', '0', '0', '0', '0.00', '0', '0', '0', '0', '10', '3', '0', '0', '0', '0', '0', '0', '14', '', '', '<p data-spm-anchor-id=\"2013.1.0.i0.558a6bcepDLJk9\" style=\"margin-top: 1.12em; margin-bottom: 1.12em; padding: 0px;\"><span data-spm-anchor-id=\"2013.1.0.i1.558a6bcepDLJk9\" style=\"font-size: 36px;\">一箱起售，不拆箱，不可定制地址电话，统一排版设计好的纸杯，一箱2000个，包邮，偏远地区补差价</span></p><p><span data-spm-anchor-id=\"2013.1.0.i1.558a6bcepDLJk9\" style=\"font-size: 36px;\"><br/></span></p><p><br/></p>', 'upload/goods_qrcode/goods_qrcode_8.png', '', '1', '0', '0', '0', '0', '0', '1', '4', '14', '', null, null, '3', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1546913875', '1546913875', '1546917643', '0');
INSERT INTO `ns_goods` VALUES ('9', '画笔', '0', '10', '10', '0', '0', '2', '', '0', '0', '1', '0.00', '2.30', '2.30', '0.00', '0', '0', '0', '0', '0.00', '0', '0', '0', '0', '500', '110', '1', '0', '0', '0', '1', '1', '15', '', '', '<p><strong><img src=\"http://img.baidu.com/hi/jx2/j_0006.gif\"/><img src=\"http://img.baidu.com/hi/jx2/j_0006.gif\"/><img src=\"http://img.baidu.com/hi/jx2/j_0006.gif\"/><img src=\"http://img.baidu.com/hi/jx2/j_0006.gif\"/><img src=\"http://img.baidu.com/hi/jx2/j_0006.gif\"/></strong></p><p><br/></p><p><strong>用途：</strong></p><p>用于描字 画画 小面积涂刷等各个领域 操作简单</p><p><br/></p><p><strong>基本信息：</strong></p><p>大、小两个规格，高档优质木杆</p><p>大号画笔： 长度约200mm，笔头宽约15mm</p><p>小号画笔：长度约190mm，笔头宽约7mm</p><p><br/></p><p><strong>单价/订量：</strong></p><p>大号画笔2.3元/支</p><p>小号画笔1.8元/支</p><p>100支起订包邮（可混采）</p><p><br/></p>', 'upload/goods_qrcode/goods_qrcode_9.png', '', '1', '0', '0', '0', '0', '0', '1', '5', '15', '', null, null, '110', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '3', '1546914506', '1546914506', '1546917658', '100');
INSERT INTO `ns_goods` VALUES ('10', '期刊杂志(第六期)', '0', '3', '3', '0', '0', '0', '', '0', '0', '1', '0.00', '10.00', '10.00', '0.00', '0', '0', '0', '0', '0.00', '0', '0', '0', '0', '500', '0', '0', '0', '0', '0', '1', '1', '16', '', '', '<p><span style=\"font-size: 36px;\">本期内刊进行了学术升级，收集了NAEA、清华美院、国家教育部艺术教育委员会专家学者的学术文章和精彩观点，以及斯玛特校长、教师、家长的教育心得分享，斯玛特学员的冬奥会主题作品。</span></p><p><span style=\"font-size: 36px;\"><br/></span></p><p><span style=\"font-size: 36px;\">温馨提示：如您收到货物有破损请拒签退回并联系客服告知情况,签收后概不退货！</span></p>', 'upload/goods_qrcode/goods_qrcode_10.png', '', '1', '0', '0', '0', '0', '0', '1', '6', '16', '', null, null, '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1546917244', '1546917244', '0', '30');
INSERT INTO `ns_goods` VALUES ('11', '白皮书', '0', '3', '3', '0', '0', '2', '', '0', '0', '1', '0.00', '10.00', '10.00', '0.00', '0', '0', '0', '0', '0.00', '0', '0', '0', '0', '499', '0', '0', '0', '0', '0', '1', '1', '17', '', '', '<p><span style=\"font-size: 36px;\">SMART教育会上，研究中心推出《SMART教育》白皮书，并由教育部艺术教育委员会委员、SMART教育研究中心核心专家孔新苗先生进行解读，指出：“SMART教育理念的提出是源于对中国教育实践的反思，是对当今教育功利化价值观的思考，努力让教育落实到育人的过程中，在这样的过程中，去培养孩子的核心素养，让孩子拥有适应个人终身发展和社会发展需要的必备品格和关键能力。”</span></p>', 'upload/goods_qrcode/goods_qrcode_11.png', '', '1', '0', '0', '0', '0', '0', '1', '7', '17', '', null, null, '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1546917606', '1546917606', '0', '30');
INSERT INTO `ns_goods` VALUES ('12', '文件袋', '0', '3', '3', '0', '0', '2', '', '0', '0', '1', '0.00', '2.65', '2.65', '0.00', '0', '0', '0', '0', '0.00', '0', '5', '0', '0', '500', '0', '0', '0', '0', '0', '0', '0', '18', '', '', '<p><span style=\"font-size: 36px;\">尺寸:220*310mm&nbsp;&nbsp;</span></p><p><span style=\"font-size: 36px;\">工艺:牛皮纸全面积烫银工艺&nbsp;</span></p><p><span style=\"font-size: 36px;\">园所必备！！100个起订包邮！！</span></p><p><br/></p>', 'upload/goods_qrcode/goods_qrcode_12.png', '', '1', '0', '0', '0', '0', '0', '1', '0', '18', '', null, null, '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '2', '1546918290', '1546918290', '1546918328', '100');
INSERT INTO `ns_goods` VALUES ('13', 'U盘', '0', '3', '3', '0', '0', '2', '', '0', '0', '1', '0.00', '55.00', '55.00', '0.00', '0', '0', '0', '0', '0.00', '0', '0', '0', '0', '50', '0', '0', '0', '0', '0', '1', '1', '19', '', '', '<p><span style=\"font-size: 36px;\">外部硅胶材质，表面呈立体凹凸感，内存16G</span></p><p><br/></p>', 'upload/goods_qrcode/goods_qrcode_13.png', '', '1', '0', '0', '0', '0', '0', '1', '2', '19', '', null, null, '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '2', '1546918790', '1546918790', '0', '5');
INSERT INTO `ns_goods` VALUES ('14', '胸针', '0', '3', '3', '0', '0', '2', '', '0', '0', '1', '0.00', '3.00', '3.00', '0.00', '0', '0', '0', '0', '0.00', '0', '0', '0', '0', '48', '0', '1', '0', '0', '0', '1', '1', '20', '', '', '<p><span style=\"font-size: 36px;\">材质：PVC软胶&nbsp; 尺寸：60*55.9mm</span></p><p><br/></p>', 'upload/goods_qrcode/goods_qrcode_14.png', '', '1', '0', '0', '0', '0', '0', '1', '1', '20', '', null, null, '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '2', '1546919094', '1546919094', '0', '30');
INSERT INTO `ns_goods` VALUES ('15', '课程卡单', '0', '3', '3', '0', '0', '0', '', '0', '0', '1', '0.00', '530.00', '530.00', '0.00', '0', '0', '0', '0', '0.00', '0', '0', '0', '0', '10', '0', '0', '0', '0', '0', '0', '0', '21', '', '', '<p><span style=\"font-size: 36px;\">每一套课程卡单都是含外套+5个年龄段的课程体系简介，530元是一百套的价格，不拆包单，最低就是100套，下单前有疑问可咨询客服。</span></p><p><span style=\"font-size: 36px;\">温馨提示：收到货物如有破损可拒绝签收并联系客服告知情况，签收后概不退换，谨慎下单！</span></p><p><br/></p>', 'upload/goods_qrcode/goods_qrcode_15.png', '', '1', '0', '0', '0', '0', '0', '1', '0', '21', '', null, null, '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '2', '1546919789', '1546919789', '0', '0');
INSERT INTO `ns_goods` VALUES ('16', '水粉颜料', '0', '1', '1', '0', '0', '2', '', '0', '0', '1', '0.00', '180.00', '180.00', '0.00', '0', '0', '0', '0', '0.00', '0', '110', '0', '0', '120', '2', '0', '0', '0', '0', '1', '1', '22', '', '', '<p><span style=\"font-size: 36px;\">500ml/瓶，10瓶/箱，每箱一个颜色</span></p><p><span style=\"font-size: 36px;\">常规色：（10色-永固白、生赭、洋红、淡绿、群青蓝、蓝绿、亮橙、朱红、宝石翠绿、基本黄）</span></p><p><span style=\"font-size: 36px;\">①可直接接触儿童皮肤。</span></p><p><span style=\"font-size: 36px;\">②添加苦味剂防止孩子误食。</span></p><p><span style=\"font-size: 36px;\">③质感细腻、流畅、易于儿童使用。</span></p><p><span style=\"font-size: 36px;\">④干燥迅速、色彩迟久强。</span></p><p><span style=\"font-size: 36px;\">PS:清水或者肥皂水清洗，应用于纸张、画板、木材等。</span></p><p><span style=\"font-size: 36px;\"></span><br/></p><p><br/></p>', 'upload/goods_qrcode/goods_qrcode_16.png', '', '1', '0', '0', '0', '0', '0', '1', '2', '22', '', null, null, '2', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '2', '1546920262', '1546920262', '1548921086', '0');
INSERT INTO `ns_goods` VALUES ('17', '《给孩子的艺术百科》普通版', '0', '10', '10', '0', '0', '2', '', '0', '0', '1', '198.00', '198.00', '198.00', '0.00', '0', '0', '0', '0', '0.00', '0', '5', '0', '0', '100', '44', '0', '0', '0', '0', '1', '1', '23', '', '', '<p><span style=\"font-size: 36px;\">①斯玛特独有免费延展性知识配套音频</span></p><p><span style=\"font-size: 36px;\">②油墨、纸张、印刷工艺均符合国际标准环保印刷</span></p><p><span style=\"font-size: 36px;\">③ISBN国际标准书号 可以在国家级图书馆查询到的图书</span></p><p><img src=\"/upload/goods/20190108/69c1c076a3f792f5bfdc6e1e4b9978d8.png\"/></p>', 'upload/goods_qrcode/goods_qrcode_17.png', '', '1', '0', '0', '0', '0', '0', '1', '5', '23', '', null, null, '44', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '2', '1546920572', '1546920572', '1548918477', '1');
INSERT INTO `ns_goods` VALUES ('18', '钢结构房管局', '0', '2', '2', '0', '0', '2', '', '0', '0', '1', '0.00', '166.00', '166.00', '0.00', '0', '0', '0', '0', '0.00', '0', '80', '0', '0', '50', '1', '0', '0', '0', '0', '0', '0', '10', '', '', '<p>飞机空间大萨福克斯大家好大师傅尽量</p>', 'upload/goods_qrcode/goods_qrcode_18.png', '', '1', '0', '0', '0', '0', '0', '1', '1', '10', '', null, null, '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '2', '1548919340', '1548919340', '1548921030', '0');

-- ----------------------------
-- Table structure for ns_goods_attribute
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_attribute`;
CREATE TABLE `ns_goods_attribute` (
  `attr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `attr_value_id` int(11) NOT NULL COMMENT '属性值id',
  `attr_value` varchar(255) NOT NULL DEFAULT '' COMMENT '属性值名称',
  `attr_value_name` varchar(255) NOT NULL DEFAULT '' COMMENT '属性值对应数据值',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`attr_id`),
  KEY `UK_ns_goods_attribute_attr_value_id` (`attr_value_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=315 COMMENT='商品属性表';

-- ----------------------------
-- Records of ns_goods_attribute
-- ----------------------------
INSERT INTO `ns_goods_attribute` VALUES ('9', '3', '0', '1', '名称', '', '1', '1544088213');
INSERT INTO `ns_goods_attribute` VALUES ('10', '3', '0', '2', '价格', '', '2', '1544088213');
INSERT INTO `ns_goods_attribute` VALUES ('17', '1', '0', '1', '名称', '小号', '1', '1544255961');
INSERT INTO `ns_goods_attribute` VALUES ('18', '1', '0', '2', '价格', '30', '2', '1544255961');
INSERT INTO `ns_goods_attribute` VALUES ('19', '2', '0', '1', '名称', '', '1', '1544255974');
INSERT INTO `ns_goods_attribute` VALUES ('20', '2', '0', '2', '价格', '', '2', '1544255974');
INSERT INTO `ns_goods_attribute` VALUES ('21', '5', '0', '1', '名称', '', '1', '1546570081');
INSERT INTO `ns_goods_attribute` VALUES ('22', '5', '0', '2', '价格', '', '2', '1546570081');
INSERT INTO `ns_goods_attribute` VALUES ('27', '6', '0', '1', '名称', '', '1', '1546575311');
INSERT INTO `ns_goods_attribute` VALUES ('28', '6', '0', '2', '价格', '', '2', '1546575311');

-- ----------------------------
-- Table structure for ns_goods_attribute_deleted
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_attribute_deleted`;
CREATE TABLE `ns_goods_attribute_deleted` (
  `attr_id` int(10) NOT NULL,
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `attr_value_id` int(11) NOT NULL COMMENT '属性值id',
  `attr_value` varchar(255) NOT NULL DEFAULT '' COMMENT '属性值名称',
  `attr_value_name` varchar(255) NOT NULL DEFAULT '' COMMENT '属性值对应数据值',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=315 COMMENT='商品属性回收站表';

-- ----------------------------
-- Records of ns_goods_attribute_deleted
-- ----------------------------

-- ----------------------------
-- Table structure for ns_goods_attribute_value
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_attribute_value`;
CREATE TABLE `ns_goods_attribute_value` (
  `attr_value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品属性值ID',
  `attr_id` int(11) NOT NULL COMMENT '商品属性ID',
  `attr_value` varchar(255) NOT NULL DEFAULT '' COMMENT '值名称',
  `is_visible` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否可视',
  `sort` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`attr_value_id`),
  KEY `IDX_category_propvalues_c_pId` (`attr_id`),
  KEY `IDX_category_propvalues_orders` (`sort`),
  KEY `IDX_category_propvalues_value` (`attr_value`),
  KEY `UK_ns_goods_attribute_value_attr_value_id` (`attr_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1092 COMMENT='商品规格值模版表';

-- ----------------------------
-- Records of ns_goods_attribute_value
-- ----------------------------

-- ----------------------------
-- Table structure for ns_goods_brand
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_brand`;
CREATE TABLE `ns_goods_brand` (
  `brand_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `brand_name` varchar(100) NOT NULL COMMENT '品牌名称',
  `brand_initial` varchar(1) NOT NULL COMMENT '品牌首字母',
  `brand_pic` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `brand_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐，0为否，1为是，默认为0',
  `sort` int(11) DEFAULT NULL,
  `brand_category_name` varchar(50) NOT NULL DEFAULT '' COMMENT '类别名称',
  `category_id_array` varchar(1000) NOT NULL DEFAULT '' COMMENT '所属分类id组',
  `brand_ads` varchar(255) NOT NULL DEFAULT '' COMMENT '品牌推荐广告',
  `category_name` varchar(50) NOT NULL DEFAULT '' COMMENT '品牌所属分类名称',
  `category_id_1` int(11) NOT NULL DEFAULT '0' COMMENT '一级分类ID',
  `category_id_2` int(11) NOT NULL DEFAULT '0' COMMENT '二级分类ID',
  `category_id_3` int(11) NOT NULL DEFAULT '0' COMMENT '三级分类ID',
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1024 COMMENT='品牌表';

-- ----------------------------
-- Records of ns_goods_brand
-- ----------------------------
INSERT INTO `ns_goods_brand` VALUES ('2', '0', 'SMART', 'S', '', '1', '1', '', '', '', '', '0', '-1', '-1');
INSERT INTO `ns_goods_brand` VALUES ('3', '0', '斯玛特集团产品', 'J', '', '1', '1', '', '', '', '教学物料', '10', '0', '0');

-- ----------------------------
-- Table structure for ns_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_category`;
CREATE TABLE `ns_goods_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL DEFAULT '',
  `short_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品分类简称 ',
  `pid` int(11) NOT NULL DEFAULT '0',
  `level` tinyint(4) NOT NULL DEFAULT '0',
  `is_visible` int(11) NOT NULL DEFAULT '1' COMMENT '是否显示  1 显示 0 不显示',
  `attr_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联商品类型ID',
  `attr_name` varchar(255) NOT NULL DEFAULT '' COMMENT '关联类型名称',
  `keywords` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `sort` int(11) DEFAULT NULL,
  `category_pic` varchar(255) NOT NULL DEFAULT '' COMMENT '商品分类图片',
  `category_icon` varchar(255) NOT NULL DEFAULT '' COMMENT '分类图标',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=244 COMMENT='商品分类表';

-- ----------------------------
-- Records of ns_goods_category
-- ----------------------------
INSERT INTO `ns_goods_category` VALUES ('1', '必备耗材', '必备耗材', '0', '1', '1', '0', '', '玩具', '', '1', 'upload/goods_category/1544087359.jpg', 'upload/goods_category/1546598221.png');
INSERT INTO `ns_goods_category` VALUES ('2', '节日礼品', '节日礼品', '0', '1', '1', '0', '', '', '', '2', 'upload/goods_category/1544087369.jpg', 'upload/goods_category/1546598245.png');
INSERT INTO `ns_goods_category` VALUES ('3', '宣传物料', '宣传物料', '0', '1', '1', '0', '', '', '', '3', 'upload/goods_category/1544087379.jpg', 'upload/goods_category/1546598254.png');
INSERT INTO `ns_goods_category` VALUES ('4', '衍生品', '衍生品', '0', '1', '1', '0', '', '', '', '4', 'upload/goods_category/1544087394.jpg', 'upload/goods_category/1546598262.png');
INSERT INTO `ns_goods_category` VALUES ('10', '教学物料', '教学物料', '0', '1', '1', '0', '', '', '', '5', '', 'upload/goods_category/1547082763.png');

-- ----------------------------
-- Table structure for ns_goods_category_block
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_category_block`;
CREATE TABLE `ns_goods_category_block` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '实例id',
  `category_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '分类id',
  `category_alias` varchar(50) NOT NULL DEFAULT '' COMMENT '分类别名',
  `color` varchar(255) DEFAULT '#FFFFFF' COMMENT '颜色',
  `is_show` int(11) NOT NULL DEFAULT '1' COMMENT '是否显示 1显示 0 不显示',
  `is_show_lower_category` int(11) NOT NULL DEFAULT '0' COMMENT '是否显示下级分类',
  `is_show_brand` int(11) NOT NULL DEFAULT '0' COMMENT '是否显示品牌',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `ad_picture` varchar(255) NOT NULL DEFAULT '' COMMENT '广告图  {["title":"","subtitle":"","picture":"","url":"","background":""]}',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `short_name` varchar(255) DEFAULT '' COMMENT '分类简称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='商品分类楼层表';

-- ----------------------------
-- Records of ns_goods_category_block
-- ----------------------------
INSERT INTO `ns_goods_category_block` VALUES ('3', '0', '必备耗材', '1', '必备耗材', '#00ff00', '1', '0', '0', '0', '', '1543999021', '1546598360', '必备耗材');
INSERT INTO `ns_goods_category_block` VALUES ('4', '0', '节日礼品', '2', '节日礼品', '#00ff00', '1', '0', '0', '0', '', '1544082763', '1546598247', '节日礼品');
INSERT INTO `ns_goods_category_block` VALUES ('5', '0', '宣传物料', '3', '宣传物料', '#00ff00', '1', '0', '0', '0', '', '1544082796', '1546598255', '宣传物料');
INSERT INTO `ns_goods_category_block` VALUES ('6', '0', '衍生品', '4', '衍生品', '#00ff00', '1', '0', '0', '0', '', '1544082841', '1546598264', '衍生品');
INSERT INTO `ns_goods_category_block` VALUES ('8', '0', '教学物料', '10', '教学物料', '#FFFFFF', '1', '0', '0', '0', '', '1546914129', '1547082764', '教学物料');

-- ----------------------------
-- Table structure for ns_goods_comment
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_comment`;
CREATE TABLE `ns_goods_comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `shop_id` int(11) NOT NULL COMMENT '店铺id',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `create_time` int(11) DEFAULT '0' COMMENT '评论创建时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '评论状态 0未评论 1已评论',
  `number` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='商品评论送积分记录表';

-- ----------------------------
-- Records of ns_goods_comment
-- ----------------------------

-- ----------------------------
-- Table structure for ns_goods_deleted
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_deleted`;
CREATE TABLE `ns_goods_deleted` (
  `goods_id` int(10) NOT NULL DEFAULT '0' COMMENT '商品id(SKU)',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `shop_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '店铺id',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类id',
  `category_id_1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一级分类id',
  `category_id_2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '二级分类id',
  `category_id_3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '三级分类id',
  `brand_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '品牌id',
  `group_id_array` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺分类id 首尾用,隔开',
  `promotion_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '促销类型 0无促销，1团购，2限时折扣',
  `promote_id` int(11) NOT NULL DEFAULT '0' COMMENT '促销活动ID',
  `goods_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '实物或虚拟商品标志 1实物商品 0 虚拟商品 2 F码商品',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '商品原价格',
  `promotion_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品促销价格',
  `cost_price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '成本价',
  `point_exchange_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '积分兑换类型 0 非积分兑换 1 只能积分兑换 ',
  `point_exchange` int(11) NOT NULL DEFAULT '0' COMMENT '积分兑换',
  `give_point` int(11) NOT NULL DEFAULT '0' COMMENT '购买商品赠送积分',
  `is_member_discount` int(1) NOT NULL DEFAULT '0' COMMENT '参与会员折扣',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '运费 0为免运费',
  `shipping_fee_id` int(11) NOT NULL DEFAULT '0' COMMENT '售卖区域id 物流模板id  ns_order_shipping_fee 表id',
  `stock` int(10) NOT NULL DEFAULT '0' COMMENT '商品库存',
  `max_buy` int(11) NOT NULL DEFAULT '0' COMMENT '限购 0 不限购',
  `clicks` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品点击数量',
  `min_stock_alarm` int(11) NOT NULL DEFAULT '0' COMMENT '库存预警值',
  `sales` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '销售数量',
  `collects` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `star` tinyint(3) unsigned NOT NULL DEFAULT '5' COMMENT '好评星级',
  `evaluates` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价数',
  `shares` int(11) NOT NULL DEFAULT '0' COMMENT '分享数',
  `province_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一级地区id',
  `city_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '二级地区id',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT '商品主图',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '商品关键词',
  `introduction` varchar(255) NOT NULL DEFAULT '' COMMENT '商品简介，促销语',
  `description` text NOT NULL COMMENT '商品详情',
  `QRcode` varchar(255) NOT NULL DEFAULT '' COMMENT '商品二维码',
  `code` varchar(50) NOT NULL DEFAULT '' COMMENT '商家编号',
  `is_stock_visible` int(1) NOT NULL DEFAULT '0' COMMENT '页面不显示库存',
  `is_hot` int(1) NOT NULL DEFAULT '0' COMMENT '是否热销商品',
  `is_recommend` int(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_new` int(1) NOT NULL DEFAULT '0' COMMENT '是否新品',
  `is_pre_sale` int(1) NOT NULL DEFAULT '0' COMMENT '是否预售',
  `is_bill` int(1) NOT NULL DEFAULT '0' COMMENT '是否开具增值税发票 1是，0否',
  `state` tinyint(3) NOT NULL DEFAULT '1' COMMENT '商品状态 0下架，1正常，10违规（禁售）',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `img_id_array` varchar(1000) DEFAULT NULL COMMENT '商品图片序列',
  `sku_img_array` varchar(1000) DEFAULT NULL COMMENT '商品sku应用图片列表  属性,属性值，图片ID',
  `match_point` float(10,2) DEFAULT NULL COMMENT '实物与描述相符（根据评价计算）',
  `match_ratio` float(10,2) DEFAULT NULL COMMENT '实物与描述相符（根据评价计算）百分比',
  `real_sales` int(10) NOT NULL DEFAULT '0' COMMENT '实际销量',
  `goods_attribute_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品类型',
  `goods_spec_format` text NOT NULL COMMENT '商品规格',
  `goods_weight` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品重量',
  `goods_volume` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品体积',
  `shipping_fee_type` int(11) NOT NULL DEFAULT '1' COMMENT '计价方式1.重量2.体积3.计件',
  `extend_category_id` varchar(255) DEFAULT NULL,
  `extend_category_id_1` varchar(255) DEFAULT NULL,
  `extend_category_id_2` varchar(255) DEFAULT NULL,
  `extend_category_id_3` varchar(255) DEFAULT NULL,
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供货商id',
  `sale_date` int(11) DEFAULT '0' COMMENT '上下架时间',
  `create_time` int(11) DEFAULT '0' COMMENT '商品添加时间',
  `update_time` int(11) DEFAULT '0' COMMENT '商品编辑时间',
  `min_buy` int(11) NOT NULL DEFAULT '0' COMMENT '最少买几件'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='商品回收站表';

-- ----------------------------
-- Records of ns_goods_deleted
-- ----------------------------
INSERT INTO `ns_goods_deleted` VALUES ('19', '1-副本', '0', '1', '1', '0', '0', '0', '', '0', '0', '1', '0.00', '1.00', '1.00', '0.00', '0', '0', '0', '0', '0.00', '0', '1', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '24', '', '', '<p>111</p>', 'upload/goods_qrcode/goods_qrcode_19.png', '', '1', '0', '0', '0', '0', '0', '0', '0', '24', '', '0.00', '0.00', '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1546926283', '1546926283', '1546926297', '0');
INSERT INTO `ns_goods_deleted` VALUES ('18', '1', '0', '1', '1', '0', '0', '0', '', '0', '0', '1', '0.00', '1.00', '1.00', '0.00', '0', '0', '0', '0', '0.00', '0', '1', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '24', '', '', '<p>111</p>', 'upload/goods_qrcode/goods_qrcode_18.png', '', '1', '0', '0', '0', '0', '0', '1', '0', '24', '', '0.00', '0.00', '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1546926244', '1546926244', '1546926303', '0');
INSERT INTO `ns_goods_deleted` VALUES ('20', '人偶', '0', '10', '10', '0', '0', '0', '', '0', '0', '1', '0.00', '10.00', '10.00', '0.00', '0', '0', '0', '0', '0.00', '0', '10', '0', '0', '15', '0', '0', '0', '0', '0', '0', '0', '25', '', '', '<p>2156561651</p>', 'upload/goods_qrcode/goods_qrcode_20.png', '', '1', '0', '0', '0', '0', '0', '0', '0', '25', '', '0.00', '0.00', '0', '0', '[]', '0.00', '0.00', '3', '', '', '', '', '0', '1546997940', '1546997940', '1546997963', '0');

-- ----------------------------
-- Table structure for ns_goods_evaluate
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_evaluate`;
CREATE TABLE `ns_goods_evaluate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `order_no` bigint(20) unsigned NOT NULL COMMENT '订单编号',
  `order_goods_id` int(11) NOT NULL COMMENT '订单项ID',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `goods_name` varchar(100) NOT NULL COMMENT '商品名称',
  `goods_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `goods_image` varchar(255) NOT NULL DEFAULT '' COMMENT '商品图片',
  `shop_id` int(11) NOT NULL COMMENT '店铺ID',
  `shop_name` varchar(100) NOT NULL COMMENT '店铺名称',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '评价内容',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '评价图片',
  `explain_first` varchar(255) NOT NULL DEFAULT '' COMMENT '解释内容',
  `member_name` varchar(100) NOT NULL DEFAULT '' COMMENT '评价人名称',
  `uid` int(11) NOT NULL COMMENT '评价人编号',
  `is_anonymous` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0表示不是 1表示是匿名评价',
  `scores` tinyint(1) NOT NULL COMMENT '1-5分',
  `again_content` varchar(255) NOT NULL DEFAULT '' COMMENT '追加评价内容',
  `again_image` varchar(255) NOT NULL DEFAULT '' COMMENT '追加评价图片',
  `again_explain` varchar(255) NOT NULL DEFAULT '' COMMENT '追加解释内容',
  `explain_type` int(11) DEFAULT '0' COMMENT '1好评2中评3差评',
  `is_show` int(1) DEFAULT '1' COMMENT '1显示 0隐藏',
  `addtime` int(11) DEFAULT '0' COMMENT '评价时间',
  `again_addtime` int(11) DEFAULT '0' COMMENT '追加评价时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1489 COMMENT='商品评价表';

-- ----------------------------
-- Records of ns_goods_evaluate
-- ----------------------------

-- ----------------------------
-- Table structure for ns_goods_group
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_group`;
CREATE TABLE `ns_goods_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `group_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '上级id 最多2级',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '级别',
  `is_visible` int(1) NOT NULL DEFAULT '1' COMMENT '是否可视',
  `group_pic` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=160 COMMENT='商品本店分类';

-- ----------------------------
-- Records of ns_goods_group
-- ----------------------------
INSERT INTO `ns_goods_group` VALUES ('2', '0', 'ceshi', '0', '1', '1', '', '0');

-- ----------------------------
-- Table structure for ns_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_sku`;
CREATE TABLE `ns_goods_sku` (
  `sku_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表序号',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品编号',
  `sku_name` varchar(500) NOT NULL DEFAULT '' COMMENT 'SKU名称',
  `attr_value_items` varchar(255) NOT NULL DEFAULT '' COMMENT '属性和属性值 id串 attribute + attribute value 表ID分号分隔',
  `attr_value_items_format` varchar(500) NOT NULL DEFAULT '' COMMENT '属性和属性值id串组合json格式',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `promote_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '促销价格',
  `cost_price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '成本价',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT '如果是第一个sku编码, 可以加图片',
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '商家编码',
  `QRcode` varchar(255) NOT NULL DEFAULT '' COMMENT '商品二维码',
  `create_date` int(11) DEFAULT '0' COMMENT '创建时间',
  `update_date` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=481 COMMENT='商品skui规格价格库存信息表';

-- ----------------------------
-- Records of ns_goods_sku
-- ----------------------------
INSERT INTO `ns_goods_sku` VALUES ('1', '1', '', '', '', '0.00', '30.00', '30.00', '0.00', '998', '0', '', '', '1543999356', '1544255961');
INSERT INTO `ns_goods_sku` VALUES ('2', '2', '', '', '', '0.00', '30.00', '30.00', '0.00', '999', '0', '', '', '1544087845', '1544255974');
INSERT INTO `ns_goods_sku` VALUES ('3', '3', '', '', '', '0.00', '40.00', '40.00', '0.00', '1000', '0', '', '', '1544088213', '0');
INSERT INTO `ns_goods_sku` VALUES ('4', '4', '', '', '', '0.00', '0.01', '0.01', '0.00', '97', '0', '', '', '1544088525', '1547171261');
INSERT INTO `ns_goods_sku` VALUES ('5', '5', '', '', '', '0.00', '288.00', '288.00', '0.00', '0', '0', '', '', '1544088837', '1546570081');
INSERT INTO `ns_goods_sku` VALUES ('6', '6', '', '', '', '0.00', '12.00', '12.00', '0.00', '0', '0', '', '', '1546570274', '1546575311');
INSERT INTO `ns_goods_sku` VALUES ('7', '7', '', '', '', '0.00', '0.01', '0.01', '0.00', '70', '0', '', '', '1546576382', '1547083568');
INSERT INTO `ns_goods_sku` VALUES ('8', '8', '', '', '', '0.00', '400.00', '400.00', '0.00', '0', '0', '', '', '1546913875', '1546917643');
INSERT INTO `ns_goods_sku` VALUES ('9', '9', '', '', '', '0.00', '2.30', '2.30', '0.00', '0', '0', '', '', '1546914506', '1546917658');
INSERT INTO `ns_goods_sku` VALUES ('10', '10', '', '', '', '0.00', '10.00', '10.00', '0.00', '0', '0', '', '', '1546917244', '0');
INSERT INTO `ns_goods_sku` VALUES ('11', '11', '', '', '', '0.00', '10.00', '10.00', '0.00', '0', '0', '', '', '1546917606', '0');
INSERT INTO `ns_goods_sku` VALUES ('12', '12', '', '', '', '0.00', '2.65', '2.65', '0.00', '5', '0', '', '', '1546918290', '1546918328');
INSERT INTO `ns_goods_sku` VALUES ('13', '13', '', '', '', '0.00', '55.00', '55.00', '0.00', '0', '0', '', '', '1546918790', '0');
INSERT INTO `ns_goods_sku` VALUES ('14', '14', '', '', '', '0.00', '3.00', '3.00', '0.00', '0', '0', '', '', '1546919094', '0');
INSERT INTO `ns_goods_sku` VALUES ('15', '15', '', '', '', '0.00', '530.00', '530.00', '0.00', '0', '0', '', '', '1546919789', '0');
INSERT INTO `ns_goods_sku` VALUES ('16', '16', '', '', '', '0.00', '180.00', '180.00', '0.00', '110', '0', '', '', '1546920262', '1548921086');
INSERT INTO `ns_goods_sku` VALUES ('17', '17', '', '', '', '198.00', '198.00', '198.00', '0.00', '5', '0', '', '', '1546920572', '1548918477');
INSERT INTO `ns_goods_sku` VALUES ('18', '18', '', '', '', '0.00', '166.00', '166.00', '0.00', '80', '0', '', '', '1548919340', '1548921030');

-- ----------------------------
-- Table structure for ns_goods_sku_deleted
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_sku_deleted`;
CREATE TABLE `ns_goods_sku_deleted` (
  `sku_id` int(11) NOT NULL DEFAULT '0' COMMENT '表序号',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品编号',
  `sku_name` varchar(500) NOT NULL DEFAULT '' COMMENT 'SKU名称',
  `attr_value_items` varchar(255) NOT NULL DEFAULT '' COMMENT '属性和属性值 id串 attribute + attribute value 表ID分号分隔',
  `attr_value_items_format` varchar(500) NOT NULL DEFAULT '' COMMENT '属性和属性值id串组合json格式',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `promote_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '促销价格',
  `cost_price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '成本价',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT '如果是第一个sku编码, 可以加图片',
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '商家编码',
  `QRcode` varchar(255) NOT NULL DEFAULT '' COMMENT '商品二维码',
  `create_date` int(11) DEFAULT '0' COMMENT '创建时间',
  `update_date` int(11) DEFAULT '0' COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1638 COMMENT='商品skui规格价格库存信息回收站表';

-- ----------------------------
-- Records of ns_goods_sku_deleted
-- ----------------------------
INSERT INTO `ns_goods_sku_deleted` VALUES ('19', '19', '', '', '', '0.00', '1.00', '1.00', '0.00', '1', '0', '', '', '1546926283', '1546926297');
INSERT INTO `ns_goods_sku_deleted` VALUES ('18', '18', '', '', '', '0.00', '1.00', '1.00', '0.00', '1', '0', '', '', '1546926244', '1546926303');
INSERT INTO `ns_goods_sku_deleted` VALUES ('20', '20', '', '', '', '0.00', '10.00', '10.00', '0.00', '10', '0', '', '', '1546997940', '1546997963');

-- ----------------------------
-- Table structure for ns_goods_sku_picture
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_sku_picture`;
CREATE TABLE `ns_goods_sku_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品id',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `spec_id` int(11) NOT NULL DEFAULT '0' COMMENT '主规格id',
  `spec_value_id` int(11) NOT NULL DEFAULT '0' COMMENT '规格值id',
  `sku_img_array` varchar(1000) NOT NULL DEFAULT '' COMMENT '图片id 多个用逗号隔开',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品sku多图';

-- ----------------------------
-- Records of ns_goods_sku_picture
-- ----------------------------

-- ----------------------------
-- Table structure for ns_goods_sku_picture_delete
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_sku_picture_delete`;
CREATE TABLE `ns_goods_sku_picture_delete` (
  `id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品id',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `spec_id` int(11) NOT NULL DEFAULT '0' COMMENT '主规格id',
  `spec_value_id` int(11) NOT NULL DEFAULT '0' COMMENT '规格值id',
  `sku_img_array` varchar(1000) NOT NULL DEFAULT '' COMMENT '图片id 多个用逗号隔开',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=4096 COMMENT='商品sku多图';

-- ----------------------------
-- Records of ns_goods_sku_picture_delete
-- ----------------------------

-- ----------------------------
-- Table structure for ns_goods_spec
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_spec`;
CREATE TABLE `ns_goods_spec` (
  `spec_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性ID',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `spec_name` varchar(255) NOT NULL DEFAULT '' COMMENT '属性名称',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可视',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `show_type` int(11) NOT NULL DEFAULT '1' COMMENT '展示方式 1 文字 2 颜色 3 图片',
  `create_time` int(11) DEFAULT '0' COMMENT '创建日期',
  `is_screen` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否参与筛选 0 不参与 1 参与',
  PRIMARY KEY (`spec_id`),
  KEY `IDX_category_props_categoryId` (`shop_id`),
  KEY `IDX_category_props_orders` (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=3276 COMMENT='商品属性（规格）表';

-- ----------------------------
-- Records of ns_goods_spec
-- ----------------------------
INSERT INTO `ns_goods_spec` VALUES ('3', '0', '大号', '1', '2', '1', '1546914556', '1');
INSERT INTO `ns_goods_spec` VALUES ('4', '0', '小号', '1', '1', '1', '1546914565', '1');

-- ----------------------------
-- Table structure for ns_goods_spec_value
-- ----------------------------
DROP TABLE IF EXISTS `ns_goods_spec_value`;
CREATE TABLE `ns_goods_spec_value` (
  `spec_value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品属性值ID',
  `spec_id` int(11) NOT NULL COMMENT '商品属性ID',
  `spec_value_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品属性值名称',
  `spec_value_data` varchar(255) NOT NULL DEFAULT '' COMMENT '商品属性值数据',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可视',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`spec_value_id`),
  KEY `IDX_category_propvalues_c_pId` (`spec_id`),
  KEY `IDX_category_propvalues_orders` (`sort`),
  KEY `IDX_category_propvalues_value` (`spec_value_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1092 COMMENT='商品规格值模版表';

-- ----------------------------
-- Records of ns_goods_spec_value
-- ----------------------------
INSERT INTO `ns_goods_spec_value` VALUES ('3', '3', '200*15mm', '', '1', '0', '1546914584');
INSERT INTO `ns_goods_spec_value` VALUES ('4', '4', '190*7mm', '', '1', '0', '1546914598');

-- ----------------------------
-- Table structure for ns_member
-- ----------------------------
DROP TABLE IF EXISTS `ns_member`;
CREATE TABLE `ns_member` (
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `member_name` varchar(50) NOT NULL DEFAULT '' COMMENT '前台用户名',
  `member_level` int(11) NOT NULL DEFAULT '47' COMMENT '会员等级',
  `memo` varchar(1000) DEFAULT NULL COMMENT '备注',
  `reg_time` int(11) DEFAULT '0' COMMENT '注册时间',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=147 COMMENT='前台用户表';

-- ----------------------------
-- Records of ns_member
-- ----------------------------
INSERT INTO `ns_member` VALUES ('1', 'admin', '47', '', '2017');
INSERT INTO `ns_member` VALUES ('3073', 'xushuqing', '51', null, '1544000816');
INSERT INTO `ns_member` VALUES ('3348', '任卉洁', '47', '江苏无锡滨湖海岸城中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3349', '斯玛特扬州广陵区中集文昌中心', '47', '江苏扬州广陵中集文昌商业中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3350', '江苏南京建邺奥体中心', '47', '江苏南京建邺奥体中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3351', '广东惠州四季商业中心', '47', '广东惠州四季商业中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3352', '甘肃庆阳西峰中心', '47', '甘肃庆阳西峰中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3353', '阿拉尔管理员', '47', '新疆阿拉尔领先商业街中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3354', '吴文勤', '47', '安徽黄山屯溪玉屏府中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3355', '辽宁铁岭银州中心', '47', '辽宁铁岭银州中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3356', '吉林四平公主岭岭西紫金星城中心', '47', '吉林四平公主岭岭西紫金星城中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3357', '山东曲阜星光天地中心', '47', '山东曲阜星光天地中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3358', '山东菏泽曹县中心', '47', '山东菏泽曹县中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3359', '山东菏泽定陶中心', '47', '山东菏泽定陶中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3360', '贵州贵阳小河缤纷中心', '47', '贵州贵阳小河缤纷中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3361', '贵州贵阳云岩586中心', '47', '贵州贵阳云岩586中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3362', '贵阳金融城恒大中央公园中心', '47', '贵阳金融城恒大中央公园中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3363', '天津南开天拖美坪园中心', '47', '天津南开天拖美坪园中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3364', '张菁', '47', '湖北武汉青山奥山世纪城中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3365', '湖北武汉洪山泛悦坊都会中心', '47', '湖北武汉洪山泛悦坊都会中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3366', '青海西宁城西万达中心', '47', '青海西宁城西万达中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3367', 'Kitty', '47', '陕西西安长安大学城中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3368', '河北邢台隆尧中心', '47', '河北邢台隆尧中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3369', '河北保定满城惠友中心', '47', '河北保定满城惠友中心', '1544233687');
INSERT INTO `ns_member` VALUES ('3370', '湖南长沙雨花丰升德润中心', '47', '湖南长沙雨花丰升德润中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3371', '浙江嘉兴桐乡吾悦广场中心', '47', '浙江嘉兴桐乡吾悦广场中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3372', '浙江嘉兴嘉善中心', '47', '浙江嘉兴嘉善中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3373', '浙江金华兰溪溪西', '47', '浙江金华兰溪溪西', '1544233688');
INSERT INTO `ns_member` VALUES ('3374', '浙江宁波慈溪中心', '47', '浙江宁波慈溪中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3375', '浙江绍兴柯桥中心', '47', '浙江绍兴柯桥中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3376', '四川成都简阳万安山峰中心', '47', '四川成都简阳万安山峰中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3377', '河南郑州郑东新区中心', '47', '河南郑州郑东新区中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3378', '河南安阳景诗雅苑中心 ', '47', '河南安阳景诗雅苑中心 ', '1544233688');
INSERT INTO `ns_member` VALUES ('3379', '马培军', '47', '河南许昌长葛伊顿公馆中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3380', '韩老师', '47', '广西省柳州河东中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3381', '江西萍乡莲花富丽花苑中心', '47', '江西萍乡莲花富丽花苑中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3382', '重庆渝中中心', '47', '重庆渝中中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3383', '广西南宁江南中心', '47', '广西南宁江南中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3384', '河南长葛中心', '47', '河南长葛中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3385', '桂仪锋', '47', '江西九江铜锣湾中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3386', '江苏常州武进御城中心', '47', '江苏常州武进御城中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3387', '冯丹丹', '47', '吉林通化东昌区丽景中心', '1544233688');
INSERT INTO `ns_member` VALUES ('3388', '湖南怀化鹤城锦绣五溪广场中心', '47', '湖南怀化鹤城锦绣五溪广场中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3389', '郭新民', '47', ' 河北承德双桥德汇大厦中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3390', '河北邯郸永年时代广场中心', '47', '河北邯郸永年时代广场中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3391', '河北承德平泉中心', '47', '河北承德平泉中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3392', '河北保定定州实验高中中心', '47', '河北保定定州实验高中中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3393', '浙江温州龙湾中心', '47', '浙江温州龙湾中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3394', '浙江绍兴上虞大通购物广场', '47', '浙江绍兴上虞大通购物广场', '1544233689');
INSERT INTO `ns_member` VALUES ('3395', '浙江金华东阳银泰城中心', '47', '浙江金华东阳银泰城中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3396', '浙江温州鹿城中心', '47', '浙江温州鹿城中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3397', '河北唐山曹妃甸中心', '47', '河北唐山曹妃甸中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3398', '北京良乡北潞园中心', '47', '北京良乡北潞园中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3399', '江西南昌象湖新城中心 ', '47', '江西南昌象湖新城中心 ', '1544233689');
INSERT INTO `ns_member` VALUES ('3400', '河南驻马店驿城CBD中心', '47', '河南驻马店驿城CBD中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3401', '耿康', '47', '河北邯郸丛台连城中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3402', '江苏常州溧阳万达广场中心', '47', '江苏常州溧阳万达广场中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3403', '辽宁阜新海州和平路中心', '47', '辽宁阜新海州和平路中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3404', '内蒙古赤峰红山万达广场中心', '47', '内蒙古赤峰红山万达广场中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3405', ' 安徽蚌埠固镇中心', '47', ' 安徽蚌埠固镇中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3406', '河北邢台巨鹿中心', '47', '河北邢台巨鹿中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3407', '河北张家口张北新世纪中心', '47', '河北张家口张北新世纪中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3408', '湖南衡阳耒阳金阳路中心', '47', '湖南衡阳耒阳金阳路中心', '1544233689');
INSERT INTO `ns_member` VALUES ('3409', '山东济宁微山中心', '47', '山东济宁微山中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3410', '山东临沂平邑中心', '47', '山东临沂平邑中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3411', '北京海淀万柳中心', '47', '北京海淀万柳碧水云天中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3412', '河南洛阳宜阳锦花中心 ', '47', '河南洛阳宜阳锦花中心 ', '1544233690');
INSERT INTO `ns_member` VALUES ('3413', '河南商丘睢阳中心', '47', '河南商丘睢阳中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3414', '河南焦作王府井中心', '47', '河南焦作王府井中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3415', '河南开封开元广场中心', '47', '河南开封开元广场中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3416', '福建泉州石狮中心', '47', '福建泉州石狮中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3417', '万隽', '47', '四川乐山市中区美加中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3418', '黄丽君', '47', '福建福州晋安中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3419', '高礼燕', '47', '山东临沂临沭中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3420', '河北石家庄长安阿尔卡迪亚中心', '47', '河北石家庄长安阿尔卡迪亚中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3421', '河北衡水冀州都会城中心', '47', '河北衡水冀州都会城中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3422', ' 尤晓玉', '47', '河北唐山滦南正通中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3423', '山东临沂沂水中心', '47', '山东临沂沂水中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3424', '山东聊城东昌府鸿顺中心', '47', '山东聊城东昌府鸿顺中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3425', '山东青岛胶州香港花园中心', '47', '山东青岛胶州香港花园中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3426', '山东菏泽单县中心', '47', '山东菏泽单县中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3427', '山东东营广饶中心', '47', '山东东营广饶中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3428', '张伟', '47', '山东东营万达中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3429', '天津津南首创中心', '47', '天津津南首创中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3430', '云南保山腾冲腾越中心', '47', '云南保山腾冲腾越中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3431', ' 河南漯河会展中心', '47', ' 河南漯河会展中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3432', '山西阳泉盂县中心', '47', '山西阳泉盂县中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3433', '福建厦门湖里301中心', '47', '福建厦门湖里宝龙一城中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3434', '宁夏银川贺兰中心', '47', '宁夏银川贺兰中心', '1544233690');
INSERT INTO `ns_member` VALUES ('3435', '安徽合肥蜀山天h中心', '47', '安徽合肥蜀山中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3436', '安徽芜湖鸠江公园大道中心', '47', '安徽芜湖鸠江公园大道中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3437', '江苏镇江润州美的城中心', '47', '江苏镇江润州美的城中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3438', '江苏扬州邗江万达中心', '47', '江苏扬州邗江万达中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3439', '上海闵行龙柏中心', '47', '上海闵行龙柏中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3440', '吉林吉林丰满水韵名城中心', '47', '吉林吉林丰满水韵名城中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3441', '内蒙古通辽科尔沁中心', '47', '内蒙古通辽科尔沁中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3442', '宁夏银川兴庆中心', '47', '宁夏银川兴庆中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3443', '广东佛山顺德乐从中心  ', '47', '广东佛山顺德乐从中心  ', '1544233691');
INSERT INTO `ns_member` VALUES ('3444', '广东深圳南山蛇口海上世界中心', '47', '广东深圳南山蛇口海上世界中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3445', '广东东莞厚街', '47', '广东东莞厚街', '1544233691');
INSERT INTO `ns_member` VALUES ('3446', '天津津南首创中心', '47', '天津津南首创中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3447', '园长', '47', '黑龙江哈尔滨松北万达中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3448', '山东淄博临淄凤凰城中心', '47', '山东淄博临淄凤凰城中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3449', '辽宁朝阳双塔天盛嘉苑中心', '47', '辽宁朝阳双塔天盛嘉苑中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3450', '123123', '47', '123123', '1544233691');
INSERT INTO `ns_member` VALUES ('3451', '福建厦门翔安泰禾中心', '47', '福建厦门翔安泰禾中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3452', '广东韶关武江太阳城中心', '47', '广东韶关武江太阳城中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3453', '广东韶关浈江凤凰城中心', '47', '广东韶关浈江凤凰城中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3454', '山东青岛莱西香港路中心', '47', '山东青岛莱西香港路中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3455', '天津武清荔隆中心', '47', '天津武清荔隆中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3456', '天津河西田园商业广场中心', '47', '天津河西田园商业广场中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3457', '天津武清创意米兰中心', '47', '天津武清创意米兰中心', '1544233691');
INSERT INTO `ns_member` VALUES ('3458', '张琴', '47', '上海宝山宝龙广场中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3459', '云南红河弥勒中心', '47', '云南红河弥勒中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3460', '天津塘沽金水畔广场中心', '47', '天津塘沽金水畔广场中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3461', '安徽合肥巢湖华邦书香里中心', '47', '安徽合肥巢湖华邦书香里中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3462', '河南信阳浉河中心  ', '47', '河南信阳浉河中心  ', '1544233692');
INSERT INTO `ns_member` VALUES ('3463', '上海浦东新区惠南中心', '47', '上海浦东新区惠南中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3464', '辽宁锦州太和万达中心', '47', '辽宁锦州太和万达中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3465', '河南南阳宛城华鑫商务中心', '47', '河南南阳宛城华鑫商务中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3466', '陕西咸阳秦都玉景台中心', '47', '陕西咸阳秦都玉景台中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3467', '河北唐山玉田县中心', '47', '河北唐山玉田县中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3468', '河北沧州黄骅中捷友谊广场中心', '47', '河北沧州黄骅中捷友谊广场中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3469', '河北衡水安平中心', '47', '河北衡水安平中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3470', '河北衡水武邑县中心', '47', '河北衡水武邑县中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3471', '河北石家庄裕华中心', '47', '河北石家庄裕华中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3472', '河北唐山路北汇金中心', '47', '河北唐山路北汇金中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3473', '河南济源济中心', '47', '河南济源济中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3474', '江苏宜兴官林尚岛豪庭中心', '47', '江苏宜兴官林尚岛豪庭中心', '1544233692');
INSERT INTO `ns_member` VALUES ('3475', '陕西安康汉滨金坊国际中心', '47', '陕西安康汉滨金坊国际中心', '1544233693');
INSERT INTO `ns_member` VALUES ('3476', '上海浦东新区博硕创意园中心', '47', '上海浦东新区博硕创意园中心', '1544233693');
INSERT INTO `ns_member` VALUES ('3477', '吉林长春高新富强天玺中心', '47', '吉林长春高新富强天玺中心', '1544233693');
INSERT INTO `ns_member` VALUES ('3478', '江苏南京栖霞万达中心', '47', '江苏南京栖霞万达中心', '1544233693');
INSERT INTO `ns_member` VALUES ('3479', '李实', '47', '江苏宿迁宿城区中远现代城中心', '1544233693');
INSERT INTO `ns_member` VALUES ('3480', '宁夏银川吉泰润园中心', '47', '宁夏银川吉泰润园中心', '1544233693');
INSERT INTO `ns_member` VALUES ('3481', 'shizhi01', '47', null, '1544235945');
INSERT INTO `ns_member` VALUES ('3482', 'shizhi02', '47', null, '1544236302');
INSERT INTO `ns_member` VALUES ('3485', 'shizhi06', '47', null, '1544237334');
INSERT INTO `ns_member` VALUES ('3486', 'miaohua', '47', null, '1544513701');
INSERT INTO `ns_member` VALUES ('3487', 'goods', '47', null, '1546590699');
INSERT INTO `ns_member` VALUES ('3488', 'luyao', '47', null, '1546662082');
INSERT INTO `ns_member` VALUES ('3489', 'yangxiuzhi', '47', null, '1546662368');
INSERT INTO `ns_member` VALUES ('3490', 'caiwu', '47', null, '1547805778');
INSERT INTO `ns_member` VALUES ('3491', 'cangwu', '47', null, '1547805792');

-- ----------------------------
-- Table structure for ns_member_account
-- ----------------------------
DROP TABLE IF EXISTS `ns_member_account`;
CREATE TABLE `ns_member_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '会员uid',
  `shop_id` int(11) NOT NULL COMMENT '店铺ID',
  `point` int(11) NOT NULL DEFAULT '0' COMMENT '会员积分',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '购物币',
  `member_cunsum` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '会员消费',
  `member_sum_point` int(11) NOT NULL DEFAULT '0' COMMENT '会员累计积分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=3276 COMMENT='会员账户统计表';

-- ----------------------------
-- Records of ns_member_account
-- ----------------------------
INSERT INTO `ns_member_account` VALUES ('1', '3073', '0', '1', '0.03', '0', '0.42', '1');
INSERT INTO `ns_member_account` VALUES ('2', '3488', '0', '1', '0.00', '0', '0.00', '1');
INSERT INTO `ns_member_account` VALUES ('3', '1', '0', '0', '0.00', '0', '0.00', '0');

-- ----------------------------
-- Table structure for ns_member_account_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_member_account_records`;
CREATE TABLE `ns_member_account_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `account_type` int(11) NOT NULL DEFAULT '1' COMMENT '账户类型1.积分2.余额3.购物币',
  `sign` smallint(6) NOT NULL DEFAULT '1' COMMENT '正负号',
  `number` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '数量',
  `from_type` smallint(6) NOT NULL DEFAULT '0' COMMENT '产生方式1.商城订单2.订单退还3.兑换4.充值5.签到6.分享7.注册8.提现9提现退还',
  `data_id` int(11) NOT NULL DEFAULT '0' COMMENT '相关表的数据ID',
  `text` varchar(255) NOT NULL DEFAULT '' COMMENT '数据相关内容描述文本',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=108 COMMENT='会员流水账表';

-- ----------------------------
-- Records of ns_member_account_records
-- ----------------------------
INSERT INTO `ns_member_account_records` VALUES ('1', '3073', '0', '1', '1', '0.00', '19', '0', '点赞赠送积分', '1544134156');
INSERT INTO `ns_member_account_records` VALUES ('2', '3073', '0', '1', '1', '0.00', '19', '0', '点赞赠送积分', '1544176884');
INSERT INTO `ns_member_account_records` VALUES ('3', '3073', '0', '1', '1', '1.00', '19', '0', '点赞赠送积分', '1544309237');
INSERT INTO `ns_member_account_records` VALUES ('4', '3073', '0', '1', '1', '1.00', '19', '0', '点赞赠送积分', '1546583291');
INSERT INTO `ns_member_account_records` VALUES ('5', '3073', '0', '1', '0', '-2.00', '3', '0', '积分兑换余额', '1546592052');
INSERT INTO `ns_member_account_records` VALUES ('6', '3073', '0', '2', '1', '0.02', '3', '0', '积分兑换余额', '1546592052');
INSERT INTO `ns_member_account_records` VALUES ('7', '3073', '0', '1', '1', '1.00', '5', '0', '签到赠送积分', '1546592261');
INSERT INTO `ns_member_account_records` VALUES ('8', '3488', '0', '1', '1', '1.00', '19', '0', '点赞赠送积分', '1546826143');
INSERT INTO `ns_member_account_records` VALUES ('9', '3073', '0', '2', '1', '0.01', '4', '4', '微信充值', '1547082408');
INSERT INTO `ns_member_account_records` VALUES ('10', '3073', '0', '1', '1', '0.00', '1', '18', '订单商品赠送积分', '1547273667');
INSERT INTO `ns_member_account_records` VALUES ('11', '3073', '0', '1', '1', '0.00', '1', '15', '订单商品赠送积分', '1547777642');
INSERT INTO `ns_member_account_records` VALUES ('12', '3073', '0', '1', '1', '0.00', '1', '28', '订单商品赠送积分', '1547777897');
INSERT INTO `ns_member_account_records` VALUES ('13', '1', '0', '1', '1', '0.00', '1', '107', '订单商品赠送积分', '1549955312');

-- ----------------------------
-- Table structure for ns_member_balance_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `ns_member_balance_withdraw`;
CREATE TABLE `ns_member_balance_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL COMMENT '店铺编号',
  `withdraw_no` varchar(255) NOT NULL DEFAULT '' COMMENT '提现流水号',
  `uid` int(11) NOT NULL COMMENT '会员id',
  `bank_name` varchar(50) NOT NULL COMMENT '提现银行名称',
  `account_number` varchar(50) NOT NULL COMMENT '提现银行账号',
  `realname` varchar(10) NOT NULL COMMENT '提现账户姓名',
  `mobile` varchar(20) NOT NULL COMMENT '手机',
  `cash` decimal(10,2) NOT NULL COMMENT '提现金额',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT '当前状态 0已申请(等待处理) 1已同意 -1 已拒绝',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `ask_for_date` int(11) DEFAULT '0' COMMENT '提现日期',
  `payment_date` int(11) DEFAULT '0' COMMENT '到账日期',
  `modify_date` int(11) DEFAULT '0' COMMENT '修改日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=4096 COMMENT='会员余额提现记录表';

-- ----------------------------
-- Records of ns_member_balance_withdraw
-- ----------------------------

-- ----------------------------
-- Table structure for ns_member_bank_account
-- ----------------------------
DROP TABLE IF EXISTS `ns_member_bank_account`;
CREATE TABLE `ns_member_bank_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '会员id',
  `bank_type` varchar(50) NOT NULL DEFAULT '1' COMMENT '账号类型 1银行卡2支付宝',
  `branch_bank_name` varchar(50) DEFAULT NULL COMMENT '支行信息',
  `realname` varchar(50) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `account_number` varchar(50) NOT NULL DEFAULT '' COMMENT '银行账号',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `is_default` int(11) NOT NULL DEFAULT '0' COMMENT '是否默认账号',
  `create_date` int(11) DEFAULT '0' COMMENT '创建日期',
  `modify_date` int(11) DEFAULT '0' COMMENT '修改日期',
  PRIMARY KEY (`id`),
  KEY `IDX_member_bank_account_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='会员提现账号';

-- ----------------------------
-- Records of ns_member_bank_account
-- ----------------------------

-- ----------------------------
-- Table structure for ns_member_express_address
-- ----------------------------
DROP TABLE IF EXISTS `ns_member_express_address`;
CREATE TABLE `ns_member_express_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '会员基本资料表ID',
  `consigner` varchar(255) NOT NULL DEFAULT '' COMMENT '收件人',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '固定电话',
  `province` int(11) NOT NULL DEFAULT '0' COMMENT '省',
  `city` int(11) NOT NULL DEFAULT '0' COMMENT '市',
  `district` int(11) NOT NULL DEFAULT '0' COMMENT '区县',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `zip_code` varchar(6) NOT NULL DEFAULT '' COMMENT '邮编',
  `alias` varchar(50) NOT NULL DEFAULT '' COMMENT '地址别名',
  `is_default` int(11) NOT NULL DEFAULT '0' COMMENT '默认收货地址',
  PRIMARY KEY (`id`),
  KEY `IDX_member_express_address_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2340 COMMENT='会员收货地址管理';

-- ----------------------------
-- Records of ns_member_express_address
-- ----------------------------
INSERT INTO `ns_member_express_address` VALUES ('1', '3073', '徐舒青', '17727750995', '', '19', '199', '1769', '清水河街道10a05', '', '', '1');
INSERT INTO `ns_member_express_address` VALUES ('2', '3073', '周海云', '18270717192', '', '19', '199', '1770', '景新花园', '', '', '0');
INSERT INTO `ns_member_express_address` VALUES ('3', '3215', '史智', '18071575136', '', '19', '199', '1772', '1111', '', '', '1');
INSERT INTO `ns_member_express_address` VALUES ('4', '3348', '阿拉斯加', '13928211122', '', '19', '217', '1863', '大是大非上对方', '', '', '1');
INSERT INTO `ns_member_express_address` VALUES ('5', '1', '黄中山', '13728748996', '', '19', '199', '1773', '坂田街道', '', '', '0');
INSERT INTO `ns_member_express_address` VALUES ('6', '1', '大鹏', '15810762702', '', '1', '1', '6', '总部基地', '', '', '1');

-- ----------------------------
-- Table structure for ns_member_favorites
-- ----------------------------
DROP TABLE IF EXISTS `ns_member_favorites`;
CREATE TABLE `ns_member_favorites` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `fav_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品或店铺ID',
  `fav_type` varchar(20) NOT NULL DEFAULT 'goods' COMMENT '类型:goods为商品,shop为店铺,默认为商品',
  `shop_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `shop_name` varchar(20) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `shop_logo` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺logo',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_image` varchar(300) DEFAULT NULL,
  `log_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品收藏时价格',
  `log_msg` varchar(1000) NOT NULL DEFAULT '' COMMENT '收藏备注',
  `fav_time` int(11) DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='收藏表';

-- ----------------------------
-- Records of ns_member_favorites
-- ----------------------------
INSERT INTO `ns_member_favorites` VALUES ('1', '3073', '2', 'goods', '0', '斯玛特商场', 'upload/common/1543908623.png', '斯玛特笔帘', 'upload/goods/20181206/fd8fe76eada28a96964b322ab562f6a83.jpg', '30.00', '斯玛特笔帘', '1544089996');
INSERT INTO `ns_member_favorites` VALUES ('7', '3488', '4', 'goods', '0', '斯玛特加盟商电商系统', 'upload/common/1544172200.png', '小丑拼图', 'upload/goods/20181206/d5347234b5d9bd8b7e4faaffb816ca9e3.jpg', '5.00', '小丑拼图', '1546826183');
INSERT INTO `ns_member_favorites` VALUES ('8', '3073', '17', 'goods', '0', '斯玛特加盟商电商系统', 'upload/common/1544172200.png', '《给孩子的艺术百科》普通版', 'upload/goods/20190108/97e4c91c575ec2ad0cf6f9abc21900da3.png', '110.00', '《给孩子的艺术百科》普通版', '1547114976');
INSERT INTO `ns_member_favorites` VALUES ('9', '3073', '9', 'goods', '0', '斯玛特加盟商电商系统', 'upload/common/1544172200.png', '画笔', 'upload/goods/20190108/b4eb38ee41342a1627e6724040c710493.png', '2.30', '画笔', '1547114999');
INSERT INTO `ns_member_favorites` VALUES ('10', '3073', '14', 'goods', '0', '斯玛特加盟商电商系统', 'upload/common/1544172200.png', '胸针', 'upload/goods/20190108/040508287b89eb5be75e460cd4846ac03.png', '3.00', '胸针', '1547115016');

-- ----------------------------
-- Table structure for ns_member_gift
-- ----------------------------
DROP TABLE IF EXISTS `ns_member_gift`;
CREATE TABLE `ns_member_gift` (
  `gift_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NOT NULL COMMENT '会员ID',
  `promotion_gift_id` int(11) NOT NULL COMMENT '赠品活动ID',
  `goods_id` int(11) NOT NULL COMMENT '赠品ID',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '赠品名称',
  `goods_picture` int(11) NOT NULL DEFAULT '0' COMMENT '赠品图片',
  `num` int(11) NOT NULL DEFAULT '1' COMMENT '赠品数量',
  `get_type` int(11) NOT NULL DEFAULT '1' COMMENT '获取方式',
  `get_type_id` int(11) NOT NULL COMMENT '获取方式对应ID',
  `desc` text NOT NULL COMMENT '说明',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`gift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员赠品表';

-- ----------------------------
-- Records of ns_member_gift
-- ----------------------------

-- ----------------------------
-- Table structure for ns_member_level
-- ----------------------------
DROP TABLE IF EXISTS `ns_member_level`;
CREATE TABLE `ns_member_level` (
  `level_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '等级ID',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `level_name` varchar(50) NOT NULL DEFAULT '' COMMENT '等级名称',
  `min_integral` int(11) NOT NULL DEFAULT '0' COMMENT '累计积分',
  `goods_discount` decimal(3,2) NOT NULL DEFAULT '1.00' COMMENT '折扣率',
  `desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '等级描述',
  `is_default` int(11) NOT NULL DEFAULT '0' COMMENT '是否是默认',
  `quota` int(11) NOT NULL DEFAULT '0' COMMENT '消费额度',
  `upgrade` int(11) NOT NULL COMMENT '升级条件  1.累计积分 2.消费额度 3.同时满足',
  `relation` int(11) NOT NULL DEFAULT '1' COMMENT '1.或 2. 且',
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='会员等级';

-- ----------------------------
-- Records of ns_member_level
-- ----------------------------
INSERT INTO `ns_member_level` VALUES ('47', '0', '普通会员', '0', '1.00', '', '1', '0', '0', '2');
INSERT INTO `ns_member_level` VALUES ('48', '0', '铜牌会员', '0', '0.95', '', '0', '1999', '2', '1');
INSERT INTO `ns_member_level` VALUES ('49', '0', '银牌会员', '0', '0.90', '', '0', '9999', '2', '1');
INSERT INTO `ns_member_level` VALUES ('50', '0', '金牌会员', '0', '0.85', '', '0', '29999', '2', '1');
INSERT INTO `ns_member_level` VALUES ('51', '0', '钻石会员', '0', '0.80', '', '0', '30000', '2', '1');

-- ----------------------------
-- Table structure for ns_member_recharge
-- ----------------------------
DROP TABLE IF EXISTS `ns_member_recharge`;
CREATE TABLE `ns_member_recharge` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `recharge_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '支付金额',
  `uid` varchar(255) NOT NULL COMMENT '用户uid',
  `out_trade_no` varchar(255) NOT NULL DEFAULT '' COMMENT '支付流水号',
  `create_time` varchar(255) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `is_pay` varchar(255) NOT NULL DEFAULT '0' COMMENT '是否支付',
  `status` varchar(255) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='会员充值余额记录';

-- ----------------------------
-- Records of ns_member_recharge
-- ----------------------------
INSERT INTO `ns_member_recharge` VALUES ('1', '1000.00', '3073', '1544513804', '0', '0', '0');
INSERT INTO `ns_member_recharge` VALUES ('2', '1200.00', '3073', '1546570737', '0', '0', '0');
INSERT INTO `ns_member_recharge` VALUES ('3', '10.00', '1', '1546663150', '0', '0', '0');
INSERT INTO `ns_member_recharge` VALUES ('4', '0.01', '3073', '1547082388', '0', '1', '1');

-- ----------------------------
-- Table structure for ns_notice
-- ----------------------------
DROP TABLE IF EXISTS `ns_notice`;
CREATE TABLE `ns_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `notice_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `notice_content` text NOT NULL COMMENT '公告内容',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='店铺公告表';

-- ----------------------------
-- Records of ns_notice
-- ----------------------------
INSERT INTO `ns_notice` VALUES ('1', '2018年双12大促', '&lt;p&gt;2018年双12大促&lt;/p&gt;&lt;p&gt;2018年双12大促&lt;/p&gt;&lt;p&gt;2018年双12大促&lt;/p&gt;', '0', '0', '1544170366', '0');
INSERT INTO `ns_notice` VALUES ('2', '首页公告二', '&lt;p&gt;首页公告二&lt;/p&gt;', '0', '1', '1544261546', '0');

-- ----------------------------
-- Table structure for ns_offpay_area
-- ----------------------------
DROP TABLE IF EXISTS `ns_offpay_area`;
CREATE TABLE `ns_offpay_area` (
  `shop_id` int(11) DEFAULT NULL COMMENT '店铺Id',
  `province_id` text COMMENT '省Id组合',
  `city_id` text COMMENT '市Id组合',
  `district_id` text COMMENT '县Id组合'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='货到付款支持地区表';

-- ----------------------------
-- Records of ns_offpay_area
-- ----------------------------

-- ----------------------------
-- Table structure for ns_order
-- ----------------------------
DROP TABLE IF EXISTS `ns_order`;
CREATE TABLE `ns_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_no` varchar(255) DEFAULT '' COMMENT '订单编号',
  `out_trade_no` varchar(100) NOT NULL DEFAULT '0' COMMENT '外部交易号',
  `order_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '订单类型',
  `payment_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付类型。取值范围：\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nWEIXIN (微信自有支付)\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nWEIXIN_DAIXIAO (微信代销支付)\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nALIPAY (支付宝支付)',
  `shipping_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '订单配送方式',
  `order_from` varchar(255) NOT NULL DEFAULT '' COMMENT '订单来源',
  `buyer_id` int(11) NOT NULL COMMENT '买家id',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '买家会员名称',
  `buyer_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '买家ip',
  `buyer_message` varchar(255) NOT NULL DEFAULT '' COMMENT '买家附言',
  `buyer_invoice` varchar(255) NOT NULL DEFAULT '' COMMENT '买家发票信息',
  `receiver_mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '收货人的手机号码',
  `receiver_province` int(11) NOT NULL COMMENT '收货人所在省',
  `receiver_city` int(11) NOT NULL COMMENT '收货人所在城市',
  `receiver_district` int(11) NOT NULL COMMENT '收货人所在街道',
  `receiver_address` varchar(255) NOT NULL DEFAULT '' COMMENT '收货人详细地址',
  `receiver_zip` varchar(6) NOT NULL DEFAULT '' COMMENT '收货人邮编',
  `receiver_name` varchar(50) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `shop_id` int(11) NOT NULL COMMENT '卖家店铺id',
  `shop_name` varchar(100) NOT NULL DEFAULT '' COMMENT '卖家店铺名称',
  `seller_star` tinyint(4) NOT NULL DEFAULT '0' COMMENT '卖家对订单的标注星标',
  `seller_memo` varchar(255) NOT NULL DEFAULT '' COMMENT '卖家对订单的备注',
  `consign_time_adjust` int(11) NOT NULL DEFAULT '0' COMMENT '卖家延迟发货时间',
  `goods_money` decimal(19,2) NOT NULL COMMENT '商品总价',
  `order_money` decimal(10,2) NOT NULL COMMENT '订单总价',
  `point` int(11) NOT NULL COMMENT '订单消耗积分',
  `point_money` decimal(10,2) NOT NULL COMMENT '订单消耗积分抵多少钱',
  `coupon_money` decimal(10,2) NOT NULL COMMENT '订单代金券支付金额',
  `coupon_id` int(11) NOT NULL COMMENT '订单代金券id',
  `user_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单余额支付金额',
  `user_platform_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户平台余额支付',
  `promotion_money` decimal(10,2) NOT NULL COMMENT '订单优惠活动金额',
  `shipping_money` decimal(10,2) NOT NULL COMMENT '订单运费',
  `pay_money` decimal(10,2) NOT NULL COMMENT '订单实付金额',
  `refund_money` decimal(10,2) NOT NULL COMMENT '订单退款金额',
  `coin_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '购物币金额',
  `give_point` int(11) NOT NULL COMMENT '订单赠送积分',
  `give_coin` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单成功之后返购物币',
  `order_status` tinyint(4) NOT NULL COMMENT '订单状态',
  `pay_status` tinyint(4) NOT NULL COMMENT '订单付款状态',
  `check_pay_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '货款是否到账',
  `shipping_status` tinyint(4) NOT NULL COMMENT '订单配送状态',
  `review_status` tinyint(4) NOT NULL COMMENT '订单评价状态',
  `feedback_status` tinyint(4) NOT NULL COMMENT '订单维权状态',
  `is_evaluate` smallint(6) NOT NULL DEFAULT '0' COMMENT '是否评价 0为未评价 1为已评价 2为已追评',
  `tax_money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `shipping_company_id` int(11) NOT NULL DEFAULT '0' COMMENT '配送物流公司ID',
  `give_point_type` int(11) NOT NULL DEFAULT '1' COMMENT '积分返还类型 1 订单完成  2 订单收货 3  支付订单',
  `pay_time` int(11) DEFAULT '0' COMMENT '订单付款时间',
  `shipping_time` int(11) DEFAULT '0' COMMENT '买家要求配送时间',
  `sign_time` int(11) DEFAULT '0' COMMENT '买家签收时间',
  `consign_time` int(11) DEFAULT '0' COMMENT '卖家发货时间',
  `create_time` int(11) DEFAULT '0' COMMENT '订单创建时间',
  `finish_time` int(11) DEFAULT '0' COMMENT '订单完成时间',
  `is_deleted` int(1) NOT NULL DEFAULT '0' COMMENT '订单是否已删除',
  `operator_type` int(1) NOT NULL DEFAULT '0' COMMENT '操作人类型  1店铺  2用户',
  `operator_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作人id',
  `refund_balance_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单退款余额',
  PRIMARY KEY (`order_id`),
  KEY `UK_ns_order_buyer_id` (`buyer_id`),
  KEY `UK_ns_order_order_no` (`order_no`),
  KEY `UK_ns_order_pay_status` (`pay_status`),
  KEY `UK_ns_order_status` (`order_status`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=440 COMMENT='订单表';

-- ----------------------------
-- Records of ns_order
-- ----------------------------
INSERT INTO `ns_order` VALUES ('49', '201901250000001', '154840944229661000', '1', '0', '1', '3', '1', '360用户', '1', '', '', '15810762702', '1', '1', '6', '总部基地', '', '大鹏', '0', '斯玛特加盟商电商系统', '0', '', '0', '30.00', '30.00', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '30.00', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548408919', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('50', '201901250000002', '154840950939421000', '1', '0', '1', '1', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548409509', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('51', '201901250000003', '154841150699791000', '1', '0', '1', '1', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548411506', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('52', '201901250000004', '154846720324481000', '1', '0', '1', '2', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548411635', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('53', '201901250000005', '154841185599931000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.02', '0.02', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.02', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548411855', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('54', '201901250000006', '154841187555221000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.02', '0.02', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.02', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548411876', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('55', '201901250000007', '154841229892841000', '1', '0', '1', '3', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548412298', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('56', '201901250000008', '154841249517121000', '1', '1', '1', '3', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '1', '2', '1', '0', '0', '0', '0', '0.00', '1', '1', '1548412530', '0', '0', '0', '1548412495', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('57', '201901250000009', '154841264055011000', '1', '1', '1', '3', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '1', '2', '1', '0', '0', '0', '0', '0.00', '1', '1', '1548412671', '0', '0', '0', '1548412641', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('58', '201901250000010', '154841284280901000', '1', '0', '1', '1', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548412842', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('59', '201901250000011', '154841390426091000', '1', '0', '1', '1', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.02', '0.02', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.02', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548413905', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('60', '201901250000012', '154841439624601000', '1', '0', '1', '1', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548414396', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('61', '201901250000013', '154848747639641000', '1', '0', '1', '2', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548414558', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('62', '201901250000014', '154841475934601000', '1', '0', '1', '1', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.02', '0.02', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.02', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548414759', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('63', '201901260000001', '154849872862611000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548467167', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('64', '201901260000002', '154865943166411000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548467187', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('65', '201901280000001', '154865715465061000', '1', '1', '1', '3', '1', '360用户', '1', '', '', '15810762702', '1', '1', '6', '总部基地', '', '大鹏', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.01', '0.00', '0', '0.00', '5', '2', '1', '2', '0', '0', '0', '0.00', '1', '1', '1548657216', '0', '1548657351', '1548657342', '1548657154', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('66', '201901280000002', '154865935581181000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548659355', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('67', '201901280000003', '154866035792061000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548659375', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('68', '201901280000004', '154866480993521000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548664809', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('69', '201901280000005', '154866494888231000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548664948', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('70', '201901280000006', '154866507927631000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548665079', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('71', '201901280000007', '154867292898721000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548665342', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('72', '201901280000008', '154867111073441000', '1', '1', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '1', '2', '1', '0', '0', '0', '0', '0.00', '1', '1', '1548671125', '0', '0', '0', '1548667501', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('73', '201901280000009', '154867000199331000', '1', '0', '1', '1', '1', '360用户', '1', '', '', '15810762702', '1', '1', '6', '总部基地', '', '大鹏', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548670001', '0', '1', '2', '1', '0.00');
INSERT INTO `ns_order` VALUES ('74', '201901280000010', '154867044132571000', '1', '0', '1', '1', '1', '360用户', '1', '', '', '15810762702', '1', '1', '6', '总部基地', '', '大鹏', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548670441', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('75', '201901290000001', '154872847784231000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548724627', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('76', '201901290000002', '154872863661701000', '1', '1', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '1', '2', '1', '0', '0', '0', '0', '0.00', '1', '1', '1548728585', '0', '0', '0', '1548728512', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('77', '201901290000003', '154872861685161000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548728616', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('78', '201901290000004', '154872863626421001', '1', '1', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '1', '2', '1', '0', '0', '0', '0', '0.00', '1', '1', '1548728704', '0', '0', '0', '1548728636', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('79', '201901290000005', '154872902131801000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548729021', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('80', '201901290000006', '154872925465661000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548729254', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('81', '201901290000007', '154872948325511000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548729483', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('82', '201901290000008', '154872953789411000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548729537', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('90', '201901290000009', '154873001124691000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548730011', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('91', '201901290000010', '154873007050491000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548730070', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('93', '201901290000011', '154873017045611000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548730170', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('94', '201901290000012', '154873022866171000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548730228', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('95', '201901290000013', '154873045354761000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548730454', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('96', '201901290000014', '154873065372971000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548730653', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('97', '201901290000015', '154873068014401000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548730681', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('98', '201901290000016', '154873094724841000', '1', '1', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '1', '2', '1', '0', '0', '0', '0', '0.00', '1', '1', '1548730959', '0', '0', '0', '1548730811', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('99', '201901290000017', '154873129746031000', '1', '0', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548731297', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('100', '201901290000018', '154874960394651000', '1', '1', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '1', '2', '1', '0', '0', '0', '0', '0.00', '1', '1', '1548749553', '0', '0', '0', '1548731469', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('101', '201901290000019', '154874877734191000', '1', '1', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.01', '0.00', '0', '0.00', '5', '2', '1', '1', '0', '0', '0', '0.00', '1', '1', '1548748808', '0', '0', '1549959919', '1548748777', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('102', '201901290000020', '154874957131571000', '1', '1', '1', '1', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.01', '0.00', '0', '0.00', '5', '2', '1', '1', '0', '0', '0', '0.00', '1', '1', '1548749581', '0', '0', '1548755002', '1548749571', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('103', '201901310000001', '154890200073601000', '1', '0', '1', '3', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '30.00', '30.00', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '30.00', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548902000', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('104', '201901310000002', '154890287629101000', '1', '1', '1', '3', '3348', '任卉洁', '1', '', '', '13928211122', '19', '217', '1863', '大是大非上对方', '', '阿拉斯加', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.01', '0.00', '0', '0.00', '5', '2', '1', '0', '0', '0', '0', '0.00', '1', '1', '1548902909', '0', '0', '0', '1548902876', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('105', '201901310000003', '154892134224161000', '1', '1', '1', '3', '1', '360用户', '1', '', '', '15810762702', '1', '1', '6', '总部基地', '', '大鹏', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.01', '0.00', '0', '0.00', '5', '2', '1', '1', '0', '0', '0', '0.00', '1', '1', '1548921365', '0', '0', '1548922069', '1548921342', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('106', '201901310000004', '154892166058851000', '1', '0', '1', '3', '1', '360用户', '1', '', '', '15810762702', '1', '1', '6', '总部基地', '', '大鹏', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.02', '0.03', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.01', '0.03', '0.00', '0.00', '0', '0.00', '5', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1548921570', '0', '1', '1', '0', '0.00');
INSERT INTO `ns_order` VALUES ('107', '201901310000005', '154892282776011000', '1', '1', '1', '1', '1', '360用户', '1', '', '', '15810762702', '1', '1', '6', '总部基地', '', '大鹏', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '4', '2', '1', '2', '0', '0', '0', '0.00', '1', '1', '1548922852', '0', '1549955201', '1548923399', '1548922827', '1549955312', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('108', '201902120000001', '154996401993791000', '1', '1', '1', '3', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.02', '0.02', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.02', '0.00', '0.00', '0', '0.00', '2', '2', '1', '1', '0', '0', '0', '0.00', '1', '1', '1549964092', '0', '0', '1549966016', '1549964019', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('109', '201902120000002', '155002525669091000', '1', '0', '1', '3', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.00', '0.00', '0', '0.00', '0', '0', '0', '0', '0', '0', '0', '0.00', '1', '1', '0', '0', '0', '0', '1549966666', '0', '0', '0', '0', '0.00');
INSERT INTO `ns_order` VALUES ('110', '201902130000001', '155002522027191000', '1', '2', '1', '3', '3073', '徐舒青', '1', '', '', '17727750995', '19', '199', '1769', '清水河街道10a05', '', '徐舒青', '0', '斯玛特加盟商电商系统', '0', '', '0', '0.01', '0.01', '0', '0.00', '0.00', '0', '0.00', '0.00', '0.00', '0.00', '0.01', '0.01', '0.00', '0', '0.00', '5', '2', '0', '0', '0', '0', '0', '0.00', '1', '1', '1550025244', '0', '0', '0', '1550024683', '0', '0', '0', '0', '0.00');

-- ----------------------------
-- Table structure for ns_order_action
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_action`;
CREATE TABLE `ns_order_action` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '动作id',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `action` varchar(255) NOT NULL DEFAULT '' COMMENT '动作内容',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '操作人id',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '操作人',
  `order_status` int(11) NOT NULL COMMENT '订单大状态',
  `order_status_text` varchar(255) NOT NULL DEFAULT '' COMMENT '订单状态名称',
  `action_time` int(11) DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`action_id`)
) ENGINE=MEMORY AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1706 COMMENT='订单操作表';

-- ----------------------------
-- Records of ns_order_action
-- ----------------------------
INSERT INTO `ns_order_action` VALUES ('1', '99', '交易关闭', '0', 'system', '5', '已关闭', '1549938176');
INSERT INTO `ns_order_action` VALUES ('2', '107', '订单收货', '1', '360用户', '3', '已收货', '1549955201');
INSERT INTO `ns_order_action` VALUES ('3', '107', '交易完成', '0', 'system', '4', '已完成', '1549955312');
INSERT INTO `ns_order_action` VALUES ('4', '101', '订单发货', '1', '360用户', '2', '已发货', '1549959919');
INSERT INTO `ns_order_action` VALUES ('5', '108', '创建订单', '3073', '徐舒青', '0', '待付款', '1549964019');
INSERT INTO `ns_order_action` VALUES ('6', '108', '订单支付', '3073', '徐舒青', '0', '待付款', '1549964092');
INSERT INTO `ns_order_action` VALUES ('7', '105', '交易关闭', '1', '360用户', '5', '已关闭', '1549964184');
INSERT INTO `ns_order_action` VALUES ('8', '108', '订单发货', '1', '360用户', '2', '已发货', '1549966016');
INSERT INTO `ns_order_action` VALUES ('9', '109', '创建订单', '3073', '徐舒青', '0', '待付款', '1549966666');
INSERT INTO `ns_order_action` VALUES ('10', '110', '创建订单', '3073', '徐舒青', '0', '待付款', '1550024683');
INSERT INTO `ns_order_action` VALUES ('11', '110', '订单支付', '3073', '徐舒青', '0', '待付款', '1550025244');
INSERT INTO `ns_order_action` VALUES ('12', '110', '交易关闭', '1', '360用户', '5', '已关闭', '1550025366');
INSERT INTO `ns_order_action` VALUES ('13', '104', '交易关闭', '1', '360用户', '5', '已关闭', '1550026106');
INSERT INTO `ns_order_action` VALUES ('14', '102', '交易关闭', '1', '360用户', '5', '已关闭', '1550026171');
INSERT INTO `ns_order_action` VALUES ('15', '65', '交易关闭', '1', '360用户', '5', '已关闭', '1550026193');
INSERT INTO `ns_order_action` VALUES ('16', '101', '交易关闭', '1', '360用户', '5', '已关闭', '1550026280');

-- ----------------------------
-- Table structure for ns_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_goods`;
CREATE TABLE `ns_order_goods` (
  `order_goods_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单项ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `goods_name` varchar(50) NOT NULL COMMENT '商品名称',
  `sku_id` int(11) NOT NULL COMMENT 'skuID',
  `sku_name` varchar(50) NOT NULL COMMENT 'sku名称',
  `price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `cost_price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '商品成本价',
  `num` varchar(255) NOT NULL DEFAULT '0' COMMENT '购买数量',
  `adjust_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '调整金额',
  `goods_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品总价',
  `goods_picture` int(11) NOT NULL DEFAULT '0' COMMENT '商品图片',
  `shop_id` int(11) NOT NULL DEFAULT '1' COMMENT '店铺ID',
  `buyer_id` int(11) NOT NULL DEFAULT '0' COMMENT '购买人ID',
  `point_exchange_type` int(11) NOT NULL DEFAULT '0' COMMENT '积分兑换类型0.非积分兑换1.积分兑换',
  `goods_type` varchar(255) NOT NULL DEFAULT '1' COMMENT '商品类型',
  `promotion_id` int(11) NOT NULL DEFAULT '0' COMMENT '促销ID',
  `promotion_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '促销类型',
  `order_type` int(11) NOT NULL DEFAULT '1' COMMENT '订单类型',
  `order_status` int(11) NOT NULL DEFAULT '0' COMMENT '订单状态',
  `give_point` int(11) NOT NULL DEFAULT '0' COMMENT '积分数量',
  `shipping_status` int(11) NOT NULL DEFAULT '0' COMMENT '物流状态',
  `refund_type` int(11) NOT NULL DEFAULT '1' COMMENT '退款方式',
  `refund_require_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '退款金额',
  `refund_reason` varchar(255) NOT NULL DEFAULT '' COMMENT '退款原因',
  `refund_shipping_code` varchar(255) NOT NULL DEFAULT '' COMMENT '退款物流单号',
  `refund_shipping_company` varchar(255) NOT NULL DEFAULT '0' COMMENT '退款物流公司名称',
  `refund_real_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际退款金额',
  `check_refund_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核退款',
  `reason` varchar(255) DEFAULT NULL COMMENT '仓库决绝退款原因',
  `refund_status` int(1) NOT NULL DEFAULT '0' COMMENT '退款状态',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `is_evaluate` smallint(6) NOT NULL DEFAULT '0' COMMENT '是否评价 0为未评价 1为已评价 2为已追评',
  `refund_time` int(11) DEFAULT '0' COMMENT '退款时间',
  `refund_balance_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单退款余额',
  `tmp_express_company` varchar(255) NOT NULL DEFAULT '' COMMENT '批量打印时添加的临时物流公司',
  `tmp_express_company_id` int(11) NOT NULL DEFAULT '0' COMMENT '批量打印时添加的临时物流公司id',
  `tmp_express_no` varchar(50) NOT NULL DEFAULT '' COMMENT '批量打印时添加的临时订单编号',
  PRIMARY KEY (`order_goods_id`),
  KEY `UK_ns_order_goods_buyer_id` (`buyer_id`),
  KEY `UK_ns_order_goods_goods_id` (`goods_id`),
  KEY `UK_ns_order_goods_order_id` (`order_id`),
  KEY `UK_ns_order_goods_promotion_id` (`promotion_id`),
  KEY `UK_ns_order_goods_sku_id` (`sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=289 COMMENT='订单商品表';

-- ----------------------------
-- Records of ns_order_goods
-- ----------------------------
INSERT INTO `ns_order_goods` VALUES ('61', '49', '1', '72色粉笔', '1', '', '30.00', '0.00', '1', '0.00', '30.00', '6', '0', '1', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('62', '50', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('63', '51', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('64', '52', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('65', '53', '4', '小丑拼图', '4', '', '0.01', '0.00', '2', '0.00', '0.02', '8', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('66', '54', '4', '小丑拼图', '4', '', '0.01', '0.00', '2', '0.00', '0.02', '8', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('67', '55', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('68', '56', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('69', '57', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.01', '买/卖双方协商一致', '', '0', '0.00', '0', null, '-2', '', '0', '1548902184', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('70', '58', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('71', '59', '7', '测试', '7', '', '0.01', '0.00', '2', '0.00', '0.02', '10', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('72', '60', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('73', '61', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('74', '62', '7', '测试', '7', '', '0.01', '0.00', '2', '0.00', '0.02', '10', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('75', '63', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('76', '64', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('77', '65', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '1', '0', '1', '0', '0', '1', '0', '0', '1', '1', '0.01', '买/卖双方协商一致', '', '0', '0.01', '0', null, '5', '', '0', '1548657379', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('78', '66', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('79', '67', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('80', '68', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('81', '69', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('82', '70', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('83', '71', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('84', '72', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('85', '73', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '1', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('86', '74', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '1', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('87', '75', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('88', '76', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('89', '77', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('90', '78', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('91', '79', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('92', '80', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('93', '81', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('94', '82', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('97', '90', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('98', '91', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('100', '93', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('101', '94', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('102', '95', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('103', '96', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('104', '97', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('105', '98', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('106', '99', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('107', '100', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('108', '101', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '1', '2', '0.01', '买/卖双方协商一致', '37574857485', '顺丰快递', '0.01', '0', null, '5', '', '0', '1549959936', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('109', '102', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '1', '2', '0.01', '买/卖双方协商一致', '3837587387583', '圆通快递', '0.01', '0', null, '5', '', '0', '1548755031', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('110', '103', '1', '72色粉笔', '1', '', '30.00', '0.00', '1', '0.00', '30.00', '6', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('111', '104', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3348', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.01', '买/卖双方协商一致', '', '0', '0.01', '0', null, '5', '', '0', '1548903706', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('112', '105', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '1', '0', '1', '0', '0', '1', '0', '0', '1', '1', '0.01', '买/卖双方协商一致', '', '0', '0.01', '0', null, '5', '', '0', '1548922104', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('113', '106', '7', '测试', '7', '', '0.01', '0.00', '1', '0.01', '0.02', '10', '0', '1', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('114', '107', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '1', '0', '1', '0', '0', '1', '0', '0', '1', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('115', '108', '7', '测试', '7', '', '0.01', '0.00', '1', '0.00', '0.01', '10', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '1', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('116', '108', '4', '小丑拼图', '4', '', '0.01', '0.00', '1', '0.00', '0.01', '8', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '1', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('117', '109', '4', '小丑拼图', '4', '', '0.01', '0.00', '1', '0.00', '0.01', '8', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.00', '', '', '0', '0.00', '0', null, '0', '', '0', '0', '0.00', '', '0', '');
INSERT INTO `ns_order_goods` VALUES ('118', '110', '4', '小丑拼图', '4', '', '0.01', '0.00', '1', '0.00', '0.01', '8', '0', '3073', '0', '1', '0', '0', '1', '0', '0', '0', '1', '0.01', '买/卖双方协商一致', '', '0', '0.01', '0', null, '5', '', '0', '1550025336', '0.00', '', '0', '');

-- ----------------------------
-- Table structure for ns_order_goods_express
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_goods_express`;
CREATE TABLE `ns_order_goods_express` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `order_goods_id_array` varchar(255) NOT NULL COMMENT '订单项商品组合列表',
  `express_name` varchar(50) NOT NULL DEFAULT '' COMMENT '包裹名称  （包裹- 1 包裹 - 2）',
  `shipping_type` tinyint(4) NOT NULL COMMENT '发货方式1 需要物流 0无需物流',
  `express_company_id` int(11) NOT NULL COMMENT '快递公司id',
  `express_company` varchar(255) NOT NULL DEFAULT '' COMMENT '物流公司名称',
  `express_no` varchar(50) NOT NULL COMMENT '运单编号',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `user_name` varchar(50) NOT NULL COMMENT '用户名',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `shipping_time` int(11) DEFAULT '0' COMMENT '发货时间',
  PRIMARY KEY (`id`),
  KEY `UK_ns_order_goods_express_order_goods_id_array` (`order_goods_id_array`),
  KEY `UK_ns_order_goods_express_order_id` (`order_id`),
  KEY `UK_ns_order_goods_express_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=606 COMMENT='商品订单物流信息表（多次发货）';

-- ----------------------------
-- Records of ns_order_goods_express
-- ----------------------------
INSERT INTO `ns_order_goods_express` VALUES ('27', '102', '109', '顺丰快递', '1', '1', '顺丰快递', '783583475793', '1', 'admin', '', '1548755002');
INSERT INTO `ns_order_goods_express` VALUES ('28', '101', '108', '顺丰快递', '1', '1', '顺丰快递', '75385683675', '1', 'admin', '', '1549959919');
INSERT INTO `ns_order_goods_express` VALUES ('29', '108', '115,116', '顺丰快递', '1', '1', '顺丰快递', '784758475545', '1', 'admin', '', '1549966016');

-- ----------------------------
-- Table structure for ns_order_goods_promotion_details
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_goods_promotion_details`;
CREATE TABLE `ns_order_goods_promotion_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `sku_id` int(11) NOT NULL COMMENT '商品skuid',
  `promotion_type` varbinary(255) NOT NULL COMMENT '优惠类型规则ID（满减对应规则）',
  `promotion_id` int(11) NOT NULL COMMENT '优惠ID',
  `discount_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠的金额，单位：元，精确到小数点后两位',
  `used_time` int(11) DEFAULT '0' COMMENT '使用时间',
  PRIMARY KEY (`id`),
  KEY `IDX_ns_order_goods_promotion_d_order_id` (`order_id`),
  KEY `IDX_ns_order_goods_promotion_d_promotion_id` (`promotion_id`),
  KEY `IDX_ns_order_goods_promotion_d_promotion_type` (`promotion_type`),
  KEY `IDX_ns_order_goods_promotion_d_sku_id` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='订单商品优惠详情';

-- ----------------------------
-- Records of ns_order_goods_promotion_details
-- ----------------------------

-- ----------------------------
-- Table structure for ns_order_payment
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_payment`;
CREATE TABLE `ns_order_payment` (
  `out_trade_no` varchar(30) NOT NULL COMMENT '支付单编号',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '执行支付的相关店铺ID（0平台）',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '订单类型1.商城订单2.交易商支付',
  `type_alis_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单类型关联ID',
  `pay_body` varchar(255) NOT NULL DEFAULT '' COMMENT '订单支付简介',
  `pay_detail` varchar(1000) NOT NULL DEFAULT '' COMMENT '订单支付详情',
  `pay_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '支付金额',
  `pay_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付状态',
  `pay_type` int(11) NOT NULL DEFAULT '1' COMMENT '支付方式',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `pay_time` int(11) DEFAULT '0' COMMENT '支付时间',
  `trade_no` varchar(30) NOT NULL DEFAULT '' COMMENT '交易号，支付宝退款用，微信传入空',
  KEY `IDX_ns_order_payment_out_trade_no` (`out_trade_no`),
  KEY `IDX_ns_order_payment_pay_status` (`pay_status`),
  KEY `IDX_ns_order_payment_pay_type` (`pay_type`),
  KEY `IDX_ns_order_payment_shop_id` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=963 COMMENT='订单支付表';

-- ----------------------------
-- Records of ns_order_payment
-- ----------------------------
INSERT INTO `ns_order_payment` VALUES ('154840944229661000', '0', '1', '49', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '30.00', '0', '1', '1548408919', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154840950939421000', '0', '1', '50', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548409509', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154841150699791000', '0', '1', '51', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548411506', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154846720324481000', '0', '1', '52', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548411635', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154841185599931000', '0', '1', '53', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.02', '0', '1', '1548411855', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154841187555221000', '0', '1', '54', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.02', '0', '1', '1548411876', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154841229892841000', '0', '1', '55', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548412298', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154841249517121000', '0', '1', '56', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548412495', '1548412530', '');
INSERT INTO `ns_order_payment` VALUES ('154841264055011000', '0', '1', '57', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548412641', '1548412670', '');
INSERT INTO `ns_order_payment` VALUES ('154841284280901000', '0', '1', '58', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548412842', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154841390426091000', '0', '1', '59', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.02', '0', '1', '1548413905', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154841439624601000', '0', '1', '60', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548414396', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154848747639641000', '0', '1', '61', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548414558', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154841475934601000', '0', '1', '62', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.02', '0', '1', '1548414759', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154849872862611000', '0', '1', '63', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548467167', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154865943166411000', '0', '1', '64', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548467187', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154865715465061000', '0', '1', '65', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548657154', '1548657216', '');
INSERT INTO `ns_order_payment` VALUES ('154865935581181000', '0', '1', '66', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548659355', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154866035792061000', '0', '1', '67', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548659375', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154866480993521000', '0', '1', '68', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548664809', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154866494888231000', '0', '1', '69', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548664948', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154866507927631000', '0', '1', '70', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548665079', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154867292898721000', '0', '1', '71', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548665342', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154867111073441000', '0', '1', '72', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548667501', '1548671125', '');
INSERT INTO `ns_order_payment` VALUES ('154867000199331000', '0', '1', '73', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548670001', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154867044132571000', '0', '1', '74', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548670441', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154872847784231000', '0', '1', '75', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548724627', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154872863661701000', '0', '1', '76', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548728512', '1548728585', '');
INSERT INTO `ns_order_payment` VALUES ('154872861685161000', '0', '1', '77', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548728616', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154872863626421001', '0', '1', '78', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548728636', '1548728704', '');
INSERT INTO `ns_order_payment` VALUES ('154872902131801000', '0', '1', '79', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548729021', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154872925465661000', '0', '1', '80', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548729254', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154872948325511000', '0', '1', '81', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548729483', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154872953789411000', '0', '1', '82', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548729537', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154873001124691000', '0', '1', '90', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548730011', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154873007050491000', '0', '1', '91', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548730070', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154873017045611000', '0', '1', '93', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548730170', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154873022866171000', '0', '1', '94', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548730228', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154873045354761000', '0', '1', '95', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548730454', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154873065372971000', '0', '1', '96', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548730653', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154873068014401000', '0', '1', '97', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548730681', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154873094724841000', '0', '1', '98', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548730811', '1548730959', '');
INSERT INTO `ns_order_payment` VALUES ('154873129746031000', '0', '1', '99', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1548731297', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154874960394651000', '0', '1', '100', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548731469', '1548749553', '');
INSERT INTO `ns_order_payment` VALUES ('154874877734191000', '0', '1', '101', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548748777', '1548748808', '');
INSERT INTO `ns_order_payment` VALUES ('154874957131571000', '0', '1', '102', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548749571', '1548749581', '');
INSERT INTO `ns_order_payment` VALUES ('154890200073601000', '0', '1', '103', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '30.00', '0', '1', '1548902000', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154890287629101000', '0', '1', '104', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548902876', '1548902909', '');
INSERT INTO `ns_order_payment` VALUES ('154892134224161000', '0', '1', '105', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548921342', '1548921365', '');
INSERT INTO `ns_order_payment` VALUES ('154892166058851000', '0', '1', '106', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.03', '0', '1', '1548921570', '0', '');
INSERT INTO `ns_order_payment` VALUES ('154892282776011000', '0', '1', '107', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '1', '1548922827', '1548922852', '');
INSERT INTO `ns_order_payment` VALUES ('154996401993791000', '0', '1', '108', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.02', '1', '1', '1549964019', '1549964092', '');
INSERT INTO `ns_order_payment` VALUES ('155002525669091000', '0', '1', '109', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '0', '1', '1549966666', '0', '');
INSERT INTO `ns_order_payment` VALUES ('155002522027191000', '0', '1', '110', '斯玛特加盟商电商系统订单', '斯玛特加盟商电商系统订单', '0.01', '1', '2', '1550024683', '1550025244', '2019021322001490441017839230');

-- ----------------------------
-- Table structure for ns_order_pickup
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_pickup`;
CREATE TABLE `ns_order_pickup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `name` varchar(255) NOT NULL COMMENT '自提点名称',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '自提点地址',
  `contact` varchar(255) NOT NULL DEFAULT '' COMMENT '联系人',
  `phone` varchar(255) NOT NULL DEFAULT '' COMMENT '联系电话',
  `city_id` int(11) NOT NULL COMMENT '市ID',
  `province_id` int(11) NOT NULL COMMENT '省ID',
  `district_id` int(11) NOT NULL COMMENT '区县ID',
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供应门店ID',
  `longitude` varchar(255) NOT NULL DEFAULT '' COMMENT '经度',
  `latitude` varchar(255) NOT NULL DEFAULT '' COMMENT '维度',
  `buyer_name` varchar(50) NOT NULL DEFAULT '' COMMENT '提货人姓名',
  `buyer_mobile` varchar(255) NOT NULL DEFAULT '' COMMENT '提货人电话',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '提货备注信息',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='订单自提点管理';

-- ----------------------------
-- Records of ns_order_pickup
-- ----------------------------

-- ----------------------------
-- Table structure for ns_order_promotion_details
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_promotion_details`;
CREATE TABLE `ns_order_promotion_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `promotion_type_id` int(11) NOT NULL COMMENT '优惠类型规则ID（满减对应规则）',
  `promotion_id` int(11) NOT NULL COMMENT '优惠ID',
  `promotion_type` varchar(255) NOT NULL COMMENT '优惠类型',
  `promotion_name` varchar(50) NOT NULL COMMENT '该优惠活动的名称',
  `promotion_condition` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠使用条件说明',
  `discount_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠的金额，单位：元，精确到小数点后两位',
  `used_time` int(11) DEFAULT '0' COMMENT '使用时间',
  PRIMARY KEY (`id`),
  KEY `UK_ns_order_promotion_details_order_id` (`order_id`),
  KEY `UK_ns_order_promotion_details_promotion_id` (`promotion_id`),
  KEY `UK_ns_order_promotion_details_promotion_type` (`promotion_type`),
  KEY `UK_ns_order_promotion_details_promotion_type_id` (`promotion_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=364 COMMENT='订单优惠详情';

-- ----------------------------
-- Records of ns_order_promotion_details
-- ----------------------------

-- ----------------------------
-- Table structure for ns_order_refund
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_refund`;
CREATE TABLE `ns_order_refund` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_goods_id` int(11) NOT NULL COMMENT '订单商品表id',
  `refund_status` varchar(255) NOT NULL COMMENT '操作状态\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n流程状态(refund_status)	状态名称(refund_status_name)	操作时间\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n1	买家申请	发起了退款申请,等待卖家处理\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n2	等待买家退货	卖家已同意退款申请,等待买家退货\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n3	等待卖家确认收货	买家已退货,等待卖家确认收货\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n4	等待卖家确认退款	卖家同意退款\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n0	退款已成功	卖家退款给买家，本次维权结束\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n-1	退款已拒绝	卖家拒绝本次退款，本次维权结束\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n-2	退款已关闭	主动撤销退款，退款关闭\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n-3	退款申请不通过	拒绝了本次退款申请,等待买家修改\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
  `action` varchar(255) NOT NULL COMMENT '退款操作内容描述',
  `action_way` tinyint(4) NOT NULL DEFAULT '0' COMMENT '操作方 1 买家 2 卖家',
  `action_userid` varchar(255) NOT NULL DEFAULT '0' COMMENT '操作人id',
  `action_username` varchar(255) NOT NULL DEFAULT '' COMMENT '操作人姓名',
  `action_time` int(11) DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=108 COMMENT='订单商品退货退款操作表';

-- ----------------------------
-- Records of ns_order_refund
-- ----------------------------
INSERT INTO `ns_order_refund` VALUES ('120', '77', '1', '买家申请退款', '1', '1', 'admin', '1548657379');
INSERT INTO `ns_order_refund` VALUES ('121', '77', '4', '等待卖家确认退款', '2', '1', 'admin', '1548657412');
INSERT INTO `ns_order_refund` VALUES ('122', '109', '1', '买家申请退款', '1', '3073', 'xushuqing', '1548755031');
INSERT INTO `ns_order_refund` VALUES ('123', '109', '2', '等待买家退货', '2', '1', 'admin', '1548755049');
INSERT INTO `ns_order_refund` VALUES ('124', '109', '3', '等待卖家确认收货', '1', '3073', 'xushuqing', '1548755071');
INSERT INTO `ns_order_refund` VALUES ('125', '109', '4', '等待卖家确认退款', '2', '1', 'admin', '1548755083');
INSERT INTO `ns_order_refund` VALUES ('126', '69', '1', '买家申请退款', '1', '3348', '15961616718', '1548902184');
INSERT INTO `ns_order_refund` VALUES ('127', '69', '-2', '退款已关闭', '1', '3348', '15961616718', '1548902935');
INSERT INTO `ns_order_refund` VALUES ('128', '111', '1', '买家申请退款', '1', '3348', '15961616718', '1548903706');
INSERT INTO `ns_order_refund` VALUES ('129', '111', '4', '等待卖家确认退款', '2', '1', 'admin', '1548922000');
INSERT INTO `ns_order_refund` VALUES ('130', '112', '1', '买家申请退款', '1', '1', 'admin', '1548922104');
INSERT INTO `ns_order_refund` VALUES ('131', '112', '4', '等待卖家确认退款', '2', '1', 'admin', '1548923925');
INSERT INTO `ns_order_refund` VALUES ('132', '108', '1', '买家申请退款', '1', '3073', 'xushuqing', '1549959936');
INSERT INTO `ns_order_refund` VALUES ('133', '108', '2', '等待买家退货', '2', '1', 'admin', '1549959973');
INSERT INTO `ns_order_refund` VALUES ('134', '112', '5', '退款已成功', '2', '1', 'admin', '1549964184');
INSERT INTO `ns_order_refund` VALUES ('135', '118', '1', '买家申请退款', '1', '3073', 'xushuqing', '1550025336');
INSERT INTO `ns_order_refund` VALUES ('136', '118', '4', '等待卖家确认退款', '2', '1', 'admin', '1550025351');
INSERT INTO `ns_order_refund` VALUES ('137', '118', '5', '退款已成功', '2', '1', 'admin', '1550025366');
INSERT INTO `ns_order_refund` VALUES ('138', '111', '5', '退款已成功', '2', '1', 'admin', '1550026106');
INSERT INTO `ns_order_refund` VALUES ('139', '109', '5', '退款已成功', '2', '1', 'admin', '1550026171');
INSERT INTO `ns_order_refund` VALUES ('140', '77', '5', '退款已成功', '2', '1', 'admin', '1550026193');
INSERT INTO `ns_order_refund` VALUES ('141', '108', '3', '等待卖家确认收货', '1', '3073', 'xushuqing', '1550026247');
INSERT INTO `ns_order_refund` VALUES ('142', '108', '4', '等待卖家确认退款', '2', '1', 'admin', '1550026259');
INSERT INTO `ns_order_refund` VALUES ('143', '108', '5', '退款已成功', '2', '1', 'admin', '1550026280');

-- ----------------------------
-- Table structure for ns_order_refund_account_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_refund_account_records`;
CREATE TABLE `ns_order_refund_account_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_goods_id` int(11) NOT NULL COMMENT '订单项id',
  `refund_trade_no` varchar(55) NOT NULL COMMENT '退款交易号',
  `refund_money` decimal(10,2) NOT NULL COMMENT '退款金额',
  `refund_way` int(11) NOT NULL COMMENT '退款方式（1：微信，2：支付宝，10：线下）',
  `buyer_id` int(11) NOT NULL COMMENT '买家id',
  `refund_time` int(11) NOT NULL COMMENT '退款时间',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='订单退款账户记录';

-- ----------------------------
-- Records of ns_order_refund_account_records
-- ----------------------------
INSERT INTO `ns_order_refund_account_records` VALUES ('1', '112', '20190212173624903735', '0.01', '10', '1', '1549964184', '订单编号:201901310000003，退款方式为:[线下支付]，退款金额:0.01元，退款余额：0元');
INSERT INTO `ns_order_refund_account_records` VALUES ('2', '118', '20190213103605359894', '0.01', '2', '3073', '1550025366', '订单编号:201902130000001，退款方式为:[支付宝]，退款金额:0.01元，退款余额：0元');
INSERT INTO `ns_order_refund_account_records` VALUES ('3', '111', '20190213104824932342', '0.01', '1', '3348', '1550026106', '订单编号:201901310000002，退款方式为:[微信支付]，退款金额:0.01元，退款余额：0元');
INSERT INTO `ns_order_refund_account_records` VALUES ('4', '109', '20190213104930206754', '0.01', '1', '3073', '1550026171', '订单编号:201901290000020，退款方式为:[微信支付]，退款金额:0.01元，退款余额：0元');
INSERT INTO `ns_order_refund_account_records` VALUES ('5', '77', '20190213104952729193', '0.01', '1', '1', '1550026193', '订单编号:201901280000001，退款方式为:[微信支付]，退款金额:0.01元，退款余额：0元');
INSERT INTO `ns_order_refund_account_records` VALUES ('6', '108', '20190213105119874273', '0.01', '1', '3073', '1550026280', '订单编号:201901290000019，退款方式为:[微信支付]，退款金额:0.01元，退款余额：0元');

-- ----------------------------
-- Table structure for ns_order_shipping_fee
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_shipping_fee`;
CREATE TABLE `ns_order_shipping_fee` (
  `shipping_fee_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '运费模板ID',
  `shipping_fee_name` varchar(30) NOT NULL DEFAULT '' COMMENT '运费模板名称',
  `is_default` int(11) NOT NULL DEFAULT '0' COMMENT '是否是默认模板',
  `co_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流公司ID',
  `shop_id` int(11) NOT NULL COMMENT '店铺ID',
  `province_id_array` text NOT NULL COMMENT '省ID组',
  `city_id_array` text NOT NULL COMMENT '市ID组',
  `weight_is_use` int(11) NOT NULL DEFAULT '1' COMMENT '是否启用重量运费',
  `weight_snum` decimal(8,2) NOT NULL DEFAULT '1.00' COMMENT '首重',
  `weight_sprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '首重运费',
  `weight_xnum` decimal(8,2) NOT NULL DEFAULT '1.00' COMMENT '续重',
  `weight_xprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '续重运费',
  `volume_is_use` int(11) NOT NULL DEFAULT '1' COMMENT '是否启用体积计算运费',
  `volume_snum` decimal(8,2) NOT NULL DEFAULT '1.00' COMMENT '首体积量',
  `volume_sprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '首体积运费',
  `volume_xnum` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '续体积量',
  `volume_xprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '续体积运费',
  `bynum_is_use` int(11) NOT NULL DEFAULT '1' COMMENT '是否启用计件方式运费',
  `bynum_snum` int(11) NOT NULL DEFAULT '0' COMMENT '首件',
  `bynum_sprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '首件运费',
  `bynum_xnum` int(11) NOT NULL DEFAULT '1' COMMENT '续件',
  `bynum_xprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '续件运费',
  `create_time` int(11) DEFAULT '0' COMMENT '创建日期',
  `update_time` int(11) DEFAULT '0' COMMENT '最后更新时间',
  `district_id_array` text COMMENT '区县ID组',
  PRIMARY KEY (`shipping_fee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='运费模板';

-- ----------------------------
-- Records of ns_order_shipping_fee
-- ----------------------------
INSERT INTO `ns_order_shipping_fee` VALUES ('1', '模板1', '1', '1', '0', '', '', '1', '0.00', '0.00', '0.00', '0.00', '1', '0.00', '0.00', '0.00', '0.00', '1', '1', '10.00', '1', '5.00', '1544093739', '0', '');
INSERT INTO `ns_order_shipping_fee` VALUES ('2', '模板一', '0', '2', '0', '19,20,21,13', '197,198,199,200,201,202,203,204,205,206,207,208,210,211,212,213,214,215,216,217,209,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,115,116,117,118,119,120,121,122,123', '1', '3.00', '10.00', '1.00', '5.00', '1', '1.00', '50.00', '1.00', '30.00', '1', '1', '10.00', '1', '5.00', '1548295359', '0', '1747,1748,1749,1750,1751,1752,1753,1754,1755,1756,1757,1759,1760,1761,1762,1763,1764,1765,1766,1767,1768,1769,1770,1771,1772,1773,1774,1775,1776,1777,1778,1779,1780,1781,1782,1783,1784,1785,1786,1787,1788,1789,1790,1791,1792,1793,1794,1795,1796,1797,1798,1799,1800,1801,1802,1803,1804,1805,1806,1807,1808,1809,1810,1811,1812,1813,1814,1815,1816,1817,1818,1819,1820,1821,1822,1823,1824,1825,1826,1827,1828,1829,1830,1831,1832,1837,1838,1839,1840,1841,1842,1843,1844,1845,1846,1847,1848,1849,1850,1851,1852,1853,1854,1855,1856,1857,1858,1859,1860,1861,1862,1863,1864,1865,1866,1867,1833,1834,1835,1836,1868,1869,1870,1871,1872,1873,1874,1875,1876,1877,1878,1879,1880,1881,1882,1883,1884,1885,1886,1887,1888,1889,1898,1906,1905,1904,1903,1902,1901,1900,1899,1890,1897,1896,1895,1894,1893,1892,1891,1907,1908,1909,1910,1911,1912,1913,1914,1915,1916,1917,1918,1919,1920,1921,1922,1923,1924,1925,1926,1927,1928,1929,1930,1931,1932,1933,1934,1935,1936,1937,1938,1939,1940,1941,1942,1943,1944,1945,1946,1947,1948,1949,1950,1951,1952,1953,1954,1955,1956,1957,1958,1959,1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1990,1999,1998,1997,1996,1995,1994,1993,1992,1991,1981,1989,1988,1987,1986,1985,1984,1983,1982,1039,1040,1041,1042,1043,1044,1045,1046,1047,1048,1049,1050,1051,1052,1053,1054,1055,1056,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1070,1071,1072,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1093,1094,1095,1096,1097,1098,1099,1100,1101,1102,1103,1104,1105,1106,1107,1108,1109,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119,1120,1121,1122,1123');

-- ----------------------------
-- Table structure for ns_order_shop_return
-- ----------------------------
DROP TABLE IF EXISTS `ns_order_shop_return`;
CREATE TABLE `ns_order_shop_return` (
  `shop_id` int(11) NOT NULL,
  `shop_address` varchar(255) NOT NULL DEFAULT '' COMMENT '商家地址',
  `seller_name` varchar(50) NOT NULL DEFAULT '' COMMENT '收件人',
  `seller_mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '收件人手机号',
  `seller_zipcode` varchar(20) NOT NULL DEFAULT '' COMMENT '邮编',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='店铺退货设置';

-- ----------------------------
-- Records of ns_order_shop_return
-- ----------------------------
INSERT INTO `ns_order_shop_return` VALUES ('0', '深圳市龙岗区', '张三', '13563728376', '510000', '1544093847', '1547708037');

-- ----------------------------
-- Table structure for ns_pickup_point
-- ----------------------------
DROP TABLE IF EXISTS `ns_pickup_point`;
CREATE TABLE `ns_pickup_point` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `name` varchar(255) NOT NULL COMMENT '自提点名称',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '自提点地址',
  `contact` varchar(255) NOT NULL DEFAULT '' COMMENT '联系人',
  `phone` varchar(255) NOT NULL DEFAULT '' COMMENT '联系电话',
  `city_id` int(11) NOT NULL COMMENT '市ID',
  `province_id` int(11) NOT NULL COMMENT '省ID',
  `district_id` int(11) NOT NULL COMMENT '区县ID',
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供应门店ID',
  `longitude` varchar(255) NOT NULL DEFAULT '' COMMENT '经度',
  `latitude` varchar(255) NOT NULL DEFAULT '' COMMENT '维度',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=4096 COMMENT='自提点管理';

-- ----------------------------
-- Records of ns_pickup_point
-- ----------------------------

-- ----------------------------
-- Table structure for ns_platform_adv
-- ----------------------------
DROP TABLE IF EXISTS `ns_platform_adv`;
CREATE TABLE `ns_platform_adv` (
  `adv_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告自增标识编号',
  `ap_id` mediumint(8) unsigned NOT NULL COMMENT '广告位id',
  `adv_title` varchar(255) NOT NULL DEFAULT '' COMMENT '广告内容描述',
  `adv_url` text,
  `adv_image` varchar(1000) NOT NULL DEFAULT '' COMMENT '广告内容图片',
  `slide_sort` int(11) DEFAULT NULL,
  `click_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '广告点击率',
  `background` varchar(255) NOT NULL DEFAULT '#FFFFFF' COMMENT '背景色',
  PRIMARY KEY (`adv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1170 COMMENT='广告表';

-- ----------------------------
-- Records of ns_platform_adv
-- ----------------------------
INSERT INTO `ns_platform_adv` VALUES ('1', '1105', '广告二', 'javascript:;', 'upload/image_collection/1544155982.jpg', '1', '0', '#000000');
INSERT INTO `ns_platform_adv` VALUES ('2', '1105', '广告二', 'javascript:;', 'upload/image_collection/1544155970.jpg', '2', '0', '#000000');
INSERT INTO `ns_platform_adv` VALUES ('3', '1105', '广告三', 'javascript:;', 'upload/image_collection/1544156002.jpg', '3', '0', '#000000');
INSERT INTO `ns_platform_adv` VALUES ('5', '1053', '广告一', 'javascript:;', 'upload/image_collection/1544242810.png', '0', '0', '#000000');
INSERT INTO `ns_platform_adv` VALUES ('6', '1053', '广告二', 'javascript:;', 'upload/image_collection/1544242833.png', '1', '0', '#000000');
INSERT INTO `ns_platform_adv` VALUES ('7', '1053', '广告三', 'javascript:;', 'upload/image_collection/1544242856.png', '2', '0', '#000000');

-- ----------------------------
-- Table structure for ns_platform_adv_position
-- ----------------------------
DROP TABLE IF EXISTS `ns_platform_adv_position`;
CREATE TABLE `ns_platform_adv_position` (
  `ap_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '广告位置id',
  `ap_name` varchar(100) NOT NULL COMMENT '广告位置名',
  `ap_intro` varchar(255) NOT NULL COMMENT '广告位简介',
  `ap_class` smallint(1) unsigned NOT NULL COMMENT '广告类别：0图片1文字2幻灯3Flash',
  `ap_display` smallint(1) unsigned NOT NULL COMMENT '广告展示方式：0幻灯片1多广告展示2单广告展示',
  `is_use` smallint(1) unsigned NOT NULL COMMENT '广告位是否启用：0不启用1启用',
  `ap_height` int(10) NOT NULL COMMENT '广告位高度',
  `ap_width` int(10) NOT NULL COMMENT '广告位宽度',
  `ap_price` int(10) NOT NULL DEFAULT '0' COMMENT '广告位单价',
  `adv_num` int(10) NOT NULL DEFAULT '0' COMMENT '拥有的广告数',
  `click_num` int(10) NOT NULL DEFAULT '0' COMMENT '广告位点击率',
  `default_content` varchar(300) DEFAULT NULL,
  `ap_background_color` varchar(50) NOT NULL DEFAULT '#FFFFFF' COMMENT '广告位背景色 默认白色',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '广告位所在位置类型   1 pc端  2 手机端',
  `instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `is_del` int(11) DEFAULT '0',
  PRIMARY KEY (`ap_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1166 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1489 COMMENT='广告位表';

-- ----------------------------
-- Records of ns_platform_adv_position
-- ----------------------------
INSERT INTO `ns_platform_adv_position` VALUES ('1051', '商城首页最顶部广告位', '商城首页最顶部广告位', '0', '2', '0', '1000', '1000', '0', '0', '0', '', '#000000', '1', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1052', '商城首页logo右侧小广告', '商城首页logo右侧小广告', '0', '2', '0', '90', '170', '0', '0', '0', 'public/static/images/default_img_url/shouyelogo.png', '#FFFFFF', '1', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1053', '商城首页滚动图广告位', '商城首页滚动图广告位', '0', '0', '1', '500', '1920', '0', '0', '0', 'upload/image_collection/1544242770.png', '#ffffff', '1', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1054', '商城首页中部推荐广告位', '商城首页中部推荐广告位（140*242）', '0', '2', '0', '140', '242', '0', '0', '0', '', '', '1', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1056', '商城限时折扣轮播广告位', '商城限时折扣轮播广告位', '0', '2', '0', '443', '1903', '0', '0', '0', 'public/static/images/default_img_url/xianshizhekou.png', '#FFFFFF', '1', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1075', '商城品牌专区轮播广告位', '商城品牌专区轮播广告位', '0', '0', '0', '443', '1210', '0', '0', '0', 'public/static/images/default_img_url/pinpaizhuanqu.png', '#000000', '1', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1076', '商城积分中心轮播广告位', '商城积分中心轮播广告位', '0', '2', '0', '320', '910', '0', '0', '0', 'public/static/images/default_img_url/jifenzhongxin.jpg', '#000000', '1', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1102', '商城积分中心中部广告位', '商城积分中心中部广告位', '0', '2', '0', '60', '1210', '0', '0', '0', 'public/static/images/default_img_url/jifenzhongxinzhongbu.jpg', '#000000', '1', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1103', '商城登录页面轮播广告位', '商城登录页面轮播广告位', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '1', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1105', '手机端首页轮播广告位', '手机端首页轮播广告位', '0', '1', '1', '175', '320', '0', '0', '0', 'upload/image_collection/1544091433.png', '#000000', '2', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1152', '手机端会员中心广告位', '手机端会员中心广告位', '0', '2', '0', '100', '750', '0', '0', '0', 'public/static/images/default_img_url/waphuiyuanzhongxin.png', '', '2', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1162', '手机端品牌专区广告位', '品牌专区广告', '0', '2', '0', '192', '720', '0', '0', '0', 'public/static/images/default_img_url/wappinpaizhuanqu.png', '', '2', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1163', '手机端限时折扣专区广告位', '限时折扣专区广告位', '0', '2', '0', '130', '720', '0', '0', '0', 'public/static/images/default_img_url/wapxianshizhekou.png', '', '2', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1164', '手机端首页商城热卖广告位', '手机端商城热卖', '0', '2', '0', '100', '100', '0', '0', '0', 'public/static/images/default_img_url/wapshangchengremai.png', '#000000', '2', '0', '1');
INSERT INTO `ns_platform_adv_position` VALUES ('1165', '手机端积分中心广告位', '积分中心广告位', '0', '2', '0', '100', '100', '0', '0', '0', 'public/static/images/default_img_url/wapjifenzhongxin.png', '#000000', '2', '0', '1');

-- ----------------------------
-- Table structure for ns_platform_block
-- ----------------------------
DROP TABLE IF EXISTS `ns_platform_block`;
CREATE TABLE `ns_platform_block` (
  `block_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_display` smallint(4) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `block_color` varchar(255) NOT NULL COMMENT '颜色风格',
  `sort` int(11) DEFAULT NULL,
  `block_name` varchar(50) NOT NULL DEFAULT '' COMMENT '板块名称',
  `block_short_name` varchar(50) DEFAULT NULL COMMENT '板块简称',
  `recommend_ad_image_name` varchar(50) NOT NULL DEFAULT '' COMMENT '推荐单图广告位名称',
  `recommend_ad_image` int(11) NOT NULL DEFAULT '0' COMMENT '推荐单图广告位',
  `recommend_ad_slide_name` varchar(50) NOT NULL DEFAULT '' COMMENT '推荐幻灯广告位名称',
  `recommend_ad_slide` int(11) NOT NULL COMMENT '推荐幻灯广告位',
  `recommend_ad_images_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '推荐多图广告位名称',
  `recommend_ad_images` int(11) NOT NULL DEFAULT '0' COMMENT '推荐多图广告位',
  `recommend_brands` varchar(255) NOT NULL DEFAULT '' COMMENT '推荐品牌',
  `recommend_categorys` varchar(255) NOT NULL DEFAULT '' COMMENT '推荐商品分类',
  `recommend_goods_category_name_1` varchar(50) NOT NULL DEFAULT '' COMMENT '推荐分类商品别名',
  `recommend_goods_category_1` int(11) NOT NULL DEFAULT '0' COMMENT '推荐显示商品分类',
  `recommend_goods_category_name_2` varchar(50) NOT NULL DEFAULT '' COMMENT '推荐分类商品别名',
  `recommend_goods_category_2` int(11) NOT NULL DEFAULT '0' COMMENT '推荐显示商品分类',
  `recommend_goods_category_name_3` varchar(50) NOT NULL DEFAULT '' COMMENT '推荐分类商品别名',
  `recommend_goods_category_3` int(11) NOT NULL DEFAULT '0' COMMENT '推荐显示商品分类',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `block_data` longtext COMMENT '板块数据',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2340 COMMENT='首页促销板块';

-- ----------------------------
-- Records of ns_platform_block
-- ----------------------------

-- ----------------------------
-- Table structure for ns_platform_goods_recommend
-- ----------------------------
DROP TABLE IF EXISTS `ns_platform_goods_recommend`;
CREATE TABLE `ns_platform_goods_recommend` (
  `recommend_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int(11) NOT NULL COMMENT '推荐商品ID',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '推荐状态',
  `class_id` int(11) NOT NULL DEFAULT '1' COMMENT '推荐类型',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`recommend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=442 COMMENT='平台商品推荐';

-- ----------------------------
-- Records of ns_platform_goods_recommend
-- ----------------------------

-- ----------------------------
-- Table structure for ns_platform_goods_recommend_class
-- ----------------------------
DROP TABLE IF EXISTS `ns_platform_goods_recommend_class`;
CREATE TABLE `ns_platform_goods_recommend_class` (
  `class_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `class_name` varchar(50) NOT NULL DEFAULT '' COMMENT '类型名称',
  `class_type` int(11) NOT NULL DEFAULT '1' COMMENT '推荐模块1.系统固有模块2.平台增加模块',
  `is_use` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否使用',
  `sort` int(11) NOT NULL DEFAULT '255' COMMENT '排序号',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `show_type` int(11) NOT NULL DEFAULT '0' COMMENT '展示类型  0电脑端  1手机端',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2340 COMMENT='店铺商品推荐类别';

-- ----------------------------
-- Records of ns_platform_goods_recommend_class
-- ----------------------------

-- ----------------------------
-- Table structure for ns_platform_help_class
-- ----------------------------
DROP TABLE IF EXISTS `ns_platform_help_class`;
CREATE TABLE `ns_platform_help_class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1.帮助类别2.会员协议类别3.开店协议类别',
  `class_name` varchar(50) NOT NULL DEFAULT '' COMMENT '类型名称',
  `parent_class_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级ID',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序号',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=4096 COMMENT='平台说明类型';

-- ----------------------------
-- Records of ns_platform_help_class
-- ----------------------------
INSERT INTO `ns_platform_help_class` VALUES ('1', '1', '新手上路', '0', '1');
INSERT INTO `ns_platform_help_class` VALUES ('2', '1', '配送与支付', '0', '2');
INSERT INTO `ns_platform_help_class` VALUES ('3', '1', '会员中心', '0', '3');
INSERT INTO `ns_platform_help_class` VALUES ('4', '1', '服务保证', '0', '4');
INSERT INTO `ns_platform_help_class` VALUES ('5', '1', '联系我们', '0', '5');

-- ----------------------------
-- Table structure for ns_platform_help_document
-- ----------------------------
DROP TABLE IF EXISTS `ns_platform_help_document`;
CREATE TABLE `ns_platform_help_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `uid` int(11) NOT NULL COMMENT '最后修改人ID',
  `class_id` int(11) NOT NULL COMMENT '所属说明类型ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '主题',
  `link_url` varchar(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序号',
  `content` text NOT NULL COMMENT '内容',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modufy_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1489 COMMENT='平台说明内容';

-- ----------------------------
-- Records of ns_platform_help_document
-- ----------------------------
INSERT INTO `ns_platform_help_document` VALUES ('1', '1', '1', '购物流程', '', '0', '', '', '0', '1544155834');
INSERT INTO `ns_platform_help_document` VALUES ('2', '2', '2', '支付方式说明', '', '5', '<p>支付方式说明</p>', '', '0', '1493810155');
INSERT INTO `ns_platform_help_document` VALUES ('3', '87', '3', '售后流程', '', '1', '', '', '0', '1499240296');
INSERT INTO `ns_platform_help_document` VALUES ('5', '2', '3', '资金管理', '', '6', '<p>资金管理</p>', '', '0', '1493964639');
INSERT INTO `ns_platform_help_document` VALUES ('7', '2', '2', '货到付款区域', '', '3', '<p>货到付款区域</p>', '', '1487559901', '1493810113');
INSERT INTO `ns_platform_help_document` VALUES ('8', '2', '2', '配送支付智能查询', '', '4', '<p>配送支付智能查询</p>', '', '1487559942', '1493810133');
INSERT INTO `ns_platform_help_document` VALUES ('9', '2', '4', '退换货原则', '', '9', '<p>退换货原则</p>', '', '1487560238', '1493809406');
INSERT INTO `ns_platform_help_document` VALUES ('10', '2', '4', '售后服务保证', '', '9', '<p>售后服务保证</p>', '', '1487560263', '1493809427');
INSERT INTO `ns_platform_help_document` VALUES ('11', '2', '4', '产品质量保证', '', '10', '<p>产品质量保证</p>', '', '1487560296', '1493809443');
INSERT INTO `ns_platform_help_document` VALUES ('12', '2', '5', '网站故障报告', '', '11', '<p>网站故障报告</p>', '', '1487560338', '1493809546');
INSERT INTO `ns_platform_help_document` VALUES ('13', '87', '13', '订购方式', '', '2', '', '', '1493206148', '1498469763');
INSERT INTO `ns_platform_help_document` VALUES ('15', '2', '5', '选机咨询', '', '12', '<p>选机咨询</p>', '', '1493809482', '1493809565');
INSERT INTO `ns_platform_help_document` VALUES ('16', '2', '5', '投诉与建议', '', '13', '<p>投诉与建议</p>', '', '1493809511', '1493964721');
INSERT INTO `ns_platform_help_document` VALUES ('17', '87', '6', '用户注册协议', '', '0', '<p><span style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft Yahei&quot;, &quot;Lucida Grande&quot;, Verdana, Lucida, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">牛酷商城用户注册协议本协议是您与牛酷商城网站（简称&quot;本站&quot;）所有者（以下简称为&quot;牛酷商城&quot;）之间就牛酷商城网站服务等相关事宜所订立的契约，请您仔细阅读本注册协议，您点击&quot;同意并继续&quot;按钮后，本协议即构成对双方有约束力的法律文件。第1条 本站服务条款的确认和接纳1.1本站的各项电子服务的所有权和运作权归牛酷商城所有。用户同意所有注册协议条款并完成注册程序，才能成为本站的正式用户。用户确认：本协议条款是处理双方权利义务的契约，始终有效，法律另有强制性规定或双方另有特别约定的，依其规定。1.2用户点击同意本协议的，即视为用户确认自己具有享受本站服务、下单购物等相应的权利能力和行为能力，能够独立承担法律责任。1.3如果您在18周岁以下，您只能在父母或监护人的监护参与下才能使用本站。第2条 本站服务2.1牛酷商城通过互联网依法为用户提供互联网信息等服务，用户在完全同意本协议及本站规定的情况下，方有权使用本站的相关服务。2.2用户必须自行准备如下设备和承担如下开支：（1）上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；（2）上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。第3条 用户信息3.1用户应自行诚信向本站提供注册资料，用户同意其提供的注册资料真实、准确、完整、合法有效，用户注册资料如有变动的，应及时更新其注册资料。如果用户提供的注册资料不合法、不真实、不准确、不详尽的，用户需承担因此引起的相应责任及后果，并且牛酷商城保留终止用户使用牛酷商城各项服务的权利。3.2用户在本站进行浏览、下单购物等活动时，涉及用户真实姓名/名称、通信地址、联系电话、电子邮箱等隐私信息的，本站将予以严格保密，除非得到用户的授权或法律另有规定，本站不会向外界披露用户隐私信息。第4条 用户依法言行义务本协议依据国家相关法律法规规章制定，用户同意严格遵守以下义务：（1）不得传输或发表：煽动抗拒、破坏宪法和法律、行政法规实施的言论，煽动颠覆国家政权，推翻社会主义制度的言论，煽动分裂国家、破坏国家统一的的言论，煽动民族仇恨、民族歧视、破坏民族团结的言论；（2）从中国大陆向境外传输资料信息时必须符合中国有关法规；第5条 其他5.1牛酷商城网站所有者是指在政府部门依法许可或备案的牛酷商城网站经营主体。5.2您点击本协议下方的&quot;同意并继续&quot;按钮即视为您完全接受本协议，在点击之前请您再次确认已知悉并完全理解本协议的全部内容。</span></p>', '', '1499325553', '1499325616');

-- ----------------------------
-- Table structure for ns_platform_link
-- ----------------------------
DROP TABLE IF EXISTS `ns_platform_link`;
CREATE TABLE `ns_platform_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引id',
  `link_title` varchar(100) NOT NULL COMMENT '标题',
  `link_url` varchar(100) NOT NULL COMMENT '链接',
  `link_pic` varchar(100) NOT NULL COMMENT '图片',
  `link_sort` int(11) DEFAULT NULL,
  `is_blank` int(11) NOT NULL DEFAULT '1' COMMENT '是否新窗口打开 1.是 2.否',
  `is_show` int(11) NOT NULL DEFAULT '1' COMMENT '是否显示 1.是 2.否',
  PRIMARY KEY (`link_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=50 COMMENT='友情链接表';

-- ----------------------------
-- Records of ns_platform_link
-- ----------------------------
INSERT INTO `ns_platform_link` VALUES ('1', '百度', 'http://www.baidu.com', 'upload/common/1544170305.jpg', '0', '1', '1');

-- ----------------------------
-- Table structure for ns_point_config
-- ----------------------------
DROP TABLE IF EXISTS `ns_point_config`;
CREATE TABLE `ns_point_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) NOT NULL COMMENT '店铺ID',
  `is_open` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否启动',
  `convert_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '1积分对应金额',
  `desc` text NOT NULL COMMENT '积分说明',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='积分设置表';

-- ----------------------------
-- Records of ns_point_config
-- ----------------------------
INSERT INTO `ns_point_config` VALUES ('1', '0', '0', '0.01', '', '1544134197', '1546592230');

-- ----------------------------
-- Table structure for ns_promotion_bundling
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_bundling`;
CREATE TABLE `ns_promotion_bundling` (
  `bl_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组合ID',
  `bl_name` varchar(50) NOT NULL COMMENT '组合名称',
  `shop_id` int(11) NOT NULL COMMENT '店铺id',
  `shop_name` varchar(100) NOT NULL COMMENT '店铺名称',
  `bl_price` decimal(10,2) NOT NULL COMMENT '商品组合价格',
  `shipping_fee_type` tinyint(1) NOT NULL COMMENT '运费承担方式 1卖家承担运费 2买家承担运费',
  `shipping_fee` decimal(10,2) NOT NULL COMMENT '运费',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '组合状态 0-关闭/1-开启',
  PRIMARY KEY (`bl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合销售活动表';

-- ----------------------------
-- Records of ns_promotion_bundling
-- ----------------------------

-- ----------------------------
-- Table structure for ns_promotion_bundling_goods
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_bundling_goods`;
CREATE TABLE `ns_promotion_bundling_goods` (
  `bl_goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组合商品id',
  `bl_id` int(11) NOT NULL COMMENT '组合id',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `goods_name` varchar(50) NOT NULL COMMENT '商品名称',
  `goods_picture` varchar(100) NOT NULL COMMENT '商品图片',
  `bl_goods_price` decimal(10,2) NOT NULL COMMENT '商品组合价格',
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`bl_goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合销售活动商品表';

-- ----------------------------
-- Records of ns_promotion_bundling_goods
-- ----------------------------

-- ----------------------------
-- Table structure for ns_promotion_discount
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_discount`;
CREATE TABLE `ns_promotion_discount` (
  `discount_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) NOT NULL DEFAULT '1' COMMENT '店铺ID',
  `shop_name` varchar(50) NOT NULL DEFAULT '' COMMENT '店铺名称',
  `discount_name` varchar(255) NOT NULL DEFAULT '' COMMENT '活动名称',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '活动状态(0-未发布/1-正常/3-关闭/4-结束)',
  `remark` text NOT NULL COMMENT '备注',
  `start_time` int(11) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '结束时间',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`discount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=4096 COMMENT='限时折扣';

-- ----------------------------
-- Records of ns_promotion_discount
-- ----------------------------

-- ----------------------------
-- Table structure for ns_promotion_discount_goods
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_discount_goods`;
CREATE TABLE `ns_promotion_discount_goods` (
  `discount_goods_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `discount_id` int(11) NOT NULL COMMENT '对应活动',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `discount` decimal(10,2) NOT NULL COMMENT '活动折扣或者减现信息',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_picture` int(11) NOT NULL COMMENT '商品图片',
  `start_time` int(11) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '结束时间',
  PRIMARY KEY (`discount_goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=712 COMMENT='限时折扣商品列表';

-- ----------------------------
-- Records of ns_promotion_discount_goods
-- ----------------------------

-- ----------------------------
-- Table structure for ns_promotion_full_mail
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_full_mail`;
CREATE TABLE `ns_promotion_full_mail` (
  `mail_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `is_open` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否开启 0未开启 1已开启',
  `full_mail_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '包邮所需订单金额',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '更新时间',
  `no_mail_province_id_array` text NOT NULL COMMENT '不包邮省id组',
  `no_mail_city_id_array` text NOT NULL COMMENT '不包邮市id组',
  PRIMARY KEY (`mail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='满额包邮';

-- ----------------------------
-- Records of ns_promotion_full_mail
-- ----------------------------
INSERT INTO `ns_promotion_full_mail` VALUES ('1', '0', '0', '0.00', '1543999356', '0', '', '');

-- ----------------------------
-- Table structure for ns_promotion_gift
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_gift`;
CREATE TABLE `ns_promotion_gift` (
  `gift_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠品活动id ',
  `days` int(10) unsigned NOT NULL COMMENT '领取有效期(多少天)',
  `max_num` varchar(50) NOT NULL COMMENT '领取限制(次/人 (0表示不限领取次数))',
  `shop_id` varchar(100) NOT NULL COMMENT '店铺id',
  `gift_name` varchar(255) NOT NULL COMMENT '赠品活动名称',
  `start_time` int(11) DEFAULT '0' COMMENT '赠品有效期开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '赠品有效期结束时间',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`gift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='赠品活动表';

-- ----------------------------
-- Records of ns_promotion_gift
-- ----------------------------

-- ----------------------------
-- Table structure for ns_promotion_gift_goods
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_gift_goods`;
CREATE TABLE `ns_promotion_gift_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id ',
  `gift_id` int(10) unsigned NOT NULL COMMENT '赠品id ',
  `goods_id` int(10) unsigned NOT NULL COMMENT '商品id',
  `goods_name` varchar(50) NOT NULL COMMENT '商品名称',
  `goods_picture` varchar(100) NOT NULL COMMENT '商品图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='商品赠品表';

-- ----------------------------
-- Records of ns_promotion_gift_goods
-- ----------------------------

-- ----------------------------
-- Table structure for ns_promotion_mansong
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_mansong`;
CREATE TABLE `ns_promotion_mansong` (
  `mansong_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '满送活动编号',
  `mansong_name` varchar(50) NOT NULL COMMENT '活动名称',
  `shop_id` int(10) unsigned NOT NULL COMMENT '店铺编号',
  `shop_name` varchar(50) NOT NULL COMMENT '店铺名称',
  `status` tinyint(1) unsigned NOT NULL COMMENT '活动状态(0-未发布/1-正常/3-关闭/4-结束)',
  `remark` varchar(200) NOT NULL COMMENT '备注',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1.普通优惠  2.多级优惠',
  `range_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1全部商品 0部分商品',
  `start_time` int(11) DEFAULT '0' COMMENT '活动开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '活动结束时间',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`mansong_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1638 COMMENT='满就送活动表';

-- ----------------------------
-- Records of ns_promotion_mansong
-- ----------------------------

-- ----------------------------
-- Table structure for ns_promotion_mansong_goods
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_mansong_goods`;
CREATE TABLE `ns_promotion_mansong_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mansong_id` int(11) NOT NULL COMMENT '满减送ID',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_picture` varchar(255) NOT NULL DEFAULT '' COMMENT '商品图片',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '活动状态',
  `start_time` int(11) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1489 COMMENT='满减送商品';

-- ----------------------------
-- Records of ns_promotion_mansong_goods
-- ----------------------------

-- ----------------------------
-- Table structure for ns_promotion_mansong_rule
-- ----------------------------
DROP TABLE IF EXISTS `ns_promotion_mansong_rule`;
CREATE TABLE `ns_promotion_mansong_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则编号',
  `mansong_id` int(10) unsigned NOT NULL COMMENT '活动编号',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '级别价格(满多少)',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '减现金优惠金额（减多少金额）',
  `free_shipping` tinyint(4) NOT NULL DEFAULT '0' COMMENT '免邮费',
  `give_point` int(11) NOT NULL DEFAULT '0' COMMENT '送积分数量（0表示不送）',
  `give_coupon` int(11) NOT NULL DEFAULT '0' COMMENT '送优惠券的id（0表示不送）',
  `gift_id` int(11) NOT NULL COMMENT '礼品(赠品)id',
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1170 COMMENT='满就送活动规则表';

-- ----------------------------
-- Records of ns_promotion_mansong_rule
-- ----------------------------

-- ----------------------------
-- Table structure for ns_purchase
-- ----------------------------
DROP TABLE IF EXISTS `ns_purchase`;
CREATE TABLE `ns_purchase` (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '采购单id',
  `purchase_no` varchar(255) DEFAULT '' COMMENT '采购单编号',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '采购总金额',
  `purchase_time` int(11) DEFAULT '0' COMMENT '采购下单时间',
  `shipping_time` int(11) DEFAULT '0' COMMENT '要求到货时间',
  `create_time` int(11) DEFAULT '0' COMMENT '订单创建时间',
  `finish_time` int(11) DEFAULT '0' COMMENT '订单完成时间',
  `is_deleted` int(1) NOT NULL DEFAULT '0' COMMENT '订单是否已删除',
  `check_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:待审核 2：完成审核',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态:0未到货  1部分到货  2已到货',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '操作人id',
  `user_name` varchar(64) DEFAULT '' COMMENT '操作人姓名',
  PRIMARY KEY (`purchase_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='采购订单表';

-- ----------------------------
-- Records of ns_purchase
-- ----------------------------
INSERT INTO `ns_purchase` VALUES ('11', '2019012416351191051', '3500.00', '1548318911', '1548777600', '1548318911', '0', '0', '1', '0', '', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('12', '2019012416565795670', '50.00', '1548320217', '1548777600', '1548320217', '0', '0', '1', '1', '测试采购', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('13', '2019012417161133826', '30.00', '1548321371', '1548777600', '1548321371', '0', '0', '1', '0', '商品需要全新的', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('14', '2019012519042775583', '1.00', '1548414267', '1548345600', '1548414267', '1548259200', '0', '2', '2', '', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('15', '2019012519053195394', '0.00', '1548414331', '1548259200', '1548414331', '0', '0', '2', '0', '', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('16', '2019013115522778186', '120.00', '1548921147', '1547481600', '1548921147', '0', '0', '2', '1', '', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('17', '2019021214461322829', '100.00', '1549953973', '1549987200', '1549953973', '0', '0', '2', '0', '商品采购', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('18', '2019021214474848973', '500.00', '1549954068', '1549987200', '1549954068', '0', '0', '2', '0', '', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('19', '2019021215561512575', '200.00', '1549958175', '1550419200', '1549958175', '0', '0', '1', '0', '', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('20', '2019021215565325530', '300.00', '1549958213', '1550419200', '1549958213', '0', '0', '1', '0', '', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('21', '2019021215580955589', '300.00', '1549958289', '1550419200', '1549958289', '0', '0', '1', '0', '商品采购', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('22', '2019021215593513230', '50.00', '1549958375', '1550419200', '1549958375', '0', '0', '1', '0', '商品采购', '1', 'admin');
INSERT INTO `ns_purchase` VALUES ('23', '2019021217322423555', '1000.00', '1549963944', '1549900800', '1549963944', '1549900800', '0', '2', '2', '测试采购', '1', 'admin');

-- ----------------------------
-- Table structure for ns_purchase_goods
-- ----------------------------
DROP TABLE IF EXISTS `ns_purchase_goods`;
CREATE TABLE `ns_purchase_goods` (
  `purchase_goods_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单项ID',
  `purchase_id` int(11) NOT NULL COMMENT '订单ID',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `goods_name` varchar(50) NOT NULL COMMENT '商品名称',
  `goods_picture` int(11) NOT NULL DEFAULT '0' COMMENT '图片ID',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '入库状态 0：待入库 1：部分入库 2：全部入库',
  `price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '采购价格',
  `num` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '购买数量',
  `in_num` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '到货数量',
  `goods_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品总价',
  `supplier_id` int(11) NOT NULL DEFAULT '1' COMMENT '供应商ID',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`purchase_goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='采购订单条目表';

-- ----------------------------
-- Records of ns_purchase_goods
-- ----------------------------
INSERT INTO `ns_purchase_goods` VALUES ('15', '11', '17', '《给孩子的艺术百科》普通版', '23', '0', '50.00', '10.00', '0.00', '500.00', '2', '1548318911');
INSERT INTO `ns_purchase_goods` VALUES ('16', '11', '16', '水粉颜料', '22', '0', '40.00', '20.00', '0.00', '800.00', '3', '1548318911');
INSERT INTO `ns_purchase_goods` VALUES ('17', '11', '15', '课程卡单', '21', '0', '30.00', '30.00', '0.00', '900.00', '2', '1548318911');
INSERT INTO `ns_purchase_goods` VALUES ('18', '11', '14', '胸针', '20', '0', '20.00', '40.00', '0.00', '800.00', '3', '1548318911');
INSERT INTO `ns_purchase_goods` VALUES ('19', '11', '13', 'U盘', '19', '0', '10.00', '50.00', '0.00', '500.00', '2', '1548318911');
INSERT INTO `ns_purchase_goods` VALUES ('20', '12', '12', '文件袋', '18', '1', '5.00', '10.00', '5.00', '50.00', '2', '1548320218');
INSERT INTO `ns_purchase_goods` VALUES ('21', '13', '9', '画笔', '15', '0', '3.00', '10.00', '0.00', '30.00', '3', '1548321371');
INSERT INTO `ns_purchase_goods` VALUES ('22', '14', '7', '测试', '10', '2', '0.01', '100.00', '100.00', '1.00', '2', '1548414267');
INSERT INTO `ns_purchase_goods` VALUES ('23', '15', '7', '测试', '10', '0', '0.00', '100.00', '0.00', '0.00', '2', '1548414331');
INSERT INTO `ns_purchase_goods` VALUES ('24', '16', '18', '钢结构房管局', '10', '1', '1.20', '100.00', '80.00', '120.00', '3', '1548921147');
INSERT INTO `ns_purchase_goods` VALUES ('25', '17', '18', '钢结构房管局', '10', '0', '10.00', '10.00', '0.00', '100.00', '2', '1549953973');
INSERT INTO `ns_purchase_goods` VALUES ('26', '18', '18', '钢结构房管局', '10', '0', '20.00', '10.00', '0.00', '200.00', '2', '1549954068');
INSERT INTO `ns_purchase_goods` VALUES ('27', '18', '17', '《给孩子的艺术百科》普通版', '23', '0', '30.00', '10.00', '0.00', '300.00', '2', '1549954068');
INSERT INTO `ns_purchase_goods` VALUES ('28', '19', '15', '课程卡单', '21', '0', '10.00', '20.00', '0.00', '200.00', '2', '1549958175');
INSERT INTO `ns_purchase_goods` VALUES ('29', '20', '16', '水粉颜料', '22', '0', '10.00', '30.00', '0.00', '300.00', '2', '1549958213');
INSERT INTO `ns_purchase_goods` VALUES ('30', '21', '14', '胸针', '20', '0', '10.00', '30.00', '0.00', '300.00', '2', '1549958289');
INSERT INTO `ns_purchase_goods` VALUES ('31', '22', '18', '钢结构房管局', '10', '0', '5.00', '10.00', '0.00', '50.00', '2', '1549958375');
INSERT INTO `ns_purchase_goods` VALUES ('32', '23', '4', '小丑拼图', '8', '2', '10.00', '100.00', '100.00', '1000.00', '2', '1549963944');

-- ----------------------------
-- Table structure for ns_reward_rule
-- ----------------------------
DROP TABLE IF EXISTS `ns_reward_rule`;
CREATE TABLE `ns_reward_rule` (
  `shop_id` int(10) unsigned NOT NULL,
  `sign_point` int(11) NOT NULL DEFAULT '0' COMMENT '签到送积分',
  `share_point` int(11) NOT NULL DEFAULT '0' COMMENT '分享送积分',
  `reg_member_self_point` int(11) NOT NULL DEFAULT '0' COMMENT '注册会员 自己获得的积分',
  `reg_member_one_point` int(11) NOT NULL DEFAULT '0' COMMENT '注册会员 上级获得的积分',
  `reg_member_two_point` int(11) NOT NULL DEFAULT '0' COMMENT '注册会员 上上级获得的积分',
  `reg_member_three_point` int(11) NOT NULL DEFAULT '0' COMMENT '注册会员 上上上级获得的积分',
  `reg_promoter_self_point` int(11) NOT NULL DEFAULT '0' COMMENT '成为推广员 自己获得的积分',
  `reg_promoter_one_point` int(11) NOT NULL DEFAULT '0' COMMENT '成为推广员 上级获得的积分',
  `reg_promoter_two_point` int(11) NOT NULL DEFAULT '0' COMMENT '成为推广员 上上级获得的积分',
  `reg_promoter_three_point` int(11) NOT NULL DEFAULT '0' COMMENT '成为推广员 上上上级获得的积分',
  `reg_partner_self_point` int(11) NOT NULL DEFAULT '0' COMMENT '成为股东 自己获得的积分',
  `reg_partner_one_point` int(11) NOT NULL DEFAULT '0' COMMENT '成为股东 上级获得的积分',
  `reg_partner_two_point` int(11) NOT NULL DEFAULT '0' COMMENT '成为股东 上上级获得的积分',
  `reg_partner_three_point` int(11) NOT NULL DEFAULT '0' COMMENT '成为股东 上上上级获得的积分',
  `into_store_coupon` int(11) NOT NULL DEFAULT '0' COMMENT '进店领用优惠券  存入优惠券id(coupon_id)',
  `share_coupon` int(11) NOT NULL DEFAULT '0' COMMENT '分享领用优惠券  存入优惠券id(coupon_id)',
  `click_point` int(11) NOT NULL DEFAULT '0' COMMENT '点赞送积分',
  `comment_point` int(11) NOT NULL DEFAULT '0' COMMENT '评论送积分',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='奖励规则表';

-- ----------------------------
-- Records of ns_reward_rule
-- ----------------------------
INSERT INTO `ns_reward_rule` VALUES ('0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '1');

-- ----------------------------
-- Table structure for ns_shop
-- ----------------------------
DROP TABLE IF EXISTS `ns_shop`;
CREATE TABLE `ns_shop` (
  `shop_id` int(11) NOT NULL COMMENT '店铺索引id',
  `shop_name` varchar(50) NOT NULL COMMENT '店铺名称',
  `shop_type` int(11) NOT NULL COMMENT '店铺类型等级',
  `uid` int(11) NOT NULL COMMENT '会员id',
  `shop_group_id` int(11) NOT NULL COMMENT '店铺分类',
  `shop_company_name` varchar(50) DEFAULT NULL COMMENT '店铺公司名称',
  `province_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '店铺所在省份ID',
  `city_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '店铺所在市ID',
  `shop_address` varchar(100) NOT NULL DEFAULT '' COMMENT '详细地区',
  `shop_zip` varchar(10) NOT NULL DEFAULT '' COMMENT '邮政编码',
  `shop_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '店铺状态，0关闭，1开启，2审核中',
  `shop_close_info` varchar(255) DEFAULT NULL COMMENT '店铺关闭原因',
  `shop_sort` int(11) NOT NULL DEFAULT '0' COMMENT '店铺排序',
  `shop_logo` varchar(255) DEFAULT NULL COMMENT '店铺logo',
  `shop_banner` varchar(255) DEFAULT NULL COMMENT '店铺横幅',
  `shop_avatar` varchar(150) DEFAULT NULL COMMENT '店铺头像',
  `shop_keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺seo关键字',
  `shop_description` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺seo描述',
  `shop_qq` varchar(50) DEFAULT NULL COMMENT 'QQ',
  `shop_ww` varchar(50) DEFAULT NULL COMMENT '阿里旺旺',
  `shop_phone` varchar(20) DEFAULT NULL COMMENT '商家电话',
  `shop_domain` varchar(50) DEFAULT NULL COMMENT '店铺二级域名',
  `shop_domain_times` tinyint(1) unsigned DEFAULT '0' COMMENT '二级域名修改次数',
  `shop_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐，0为否，1为是，默认为0',
  `shop_credit` int(10) NOT NULL DEFAULT '0' COMMENT '店铺信用',
  `shop_desccredit` float NOT NULL DEFAULT '0' COMMENT '描述相符度分数',
  `shop_servicecredit` float NOT NULL DEFAULT '0' COMMENT '服务态度分数',
  `shop_deliverycredit` float NOT NULL DEFAULT '0' COMMENT '发货速度分数',
  `shop_collect` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺收藏数量',
  `shop_stamp` varchar(200) DEFAULT NULL COMMENT '店铺印章',
  `shop_printdesc` varchar(500) DEFAULT NULL COMMENT '打印订单页面下方说明文字',
  `shop_sales` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺销售额（不计算退款）',
  `shop_account` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺账户余额',
  `shop_cash` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺可提现金额',
  `shop_workingtime` varchar(100) DEFAULT NULL COMMENT '工作时间',
  `live_store_name` varchar(255) DEFAULT NULL COMMENT '商铺名称',
  `live_store_address` varchar(255) DEFAULT NULL COMMENT '商家地址',
  `live_store_tel` varchar(255) DEFAULT NULL COMMENT '商铺电话',
  `live_store_bus` varchar(255) DEFAULT NULL COMMENT '公交线路',
  `shop_vrcode_prefix` char(3) DEFAULT NULL COMMENT '商家兑换码前缀',
  `store_qtian` tinyint(1) DEFAULT '0' COMMENT '7天退换',
  `shop_zhping` tinyint(1) DEFAULT '0' COMMENT '正品保障',
  `shop_erxiaoshi` tinyint(1) DEFAULT '0' COMMENT '两小时发货',
  `shop_tuihuo` tinyint(1) DEFAULT '0' COMMENT '退货承诺',
  `shop_shiyong` tinyint(1) DEFAULT '0' COMMENT '试用中心',
  `shop_shiti` tinyint(1) DEFAULT '0' COMMENT '实体验证',
  `shop_xiaoxie` tinyint(1) DEFAULT '0' COMMENT '消协保证',
  `shop_huodaofk` tinyint(1) DEFAULT '0' COMMENT '货到付款',
  `shop_free_time` varchar(10) DEFAULT NULL COMMENT '商家配送时间',
  `shop_region` varchar(50) DEFAULT NULL COMMENT '店铺默认配送区域',
  `recommend_uid` int(11) NOT NULL DEFAULT '0' COMMENT '推荐招商员用户id',
  `shop_qrcode` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺公众号',
  `shop_create_time` int(11) DEFAULT '0' COMMENT '店铺时间',
  `shop_end_time` int(11) DEFAULT '0' COMMENT '店铺关闭时间',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='店铺数据表';

-- ----------------------------
-- Records of ns_shop
-- ----------------------------

-- ----------------------------
-- Table structure for ns_shop_ad
-- ----------------------------
DROP TABLE IF EXISTS `ns_shop_ad`;
CREATE TABLE `ns_shop_ad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `ad_image` varchar(255) NOT NULL DEFAULT '' COMMENT '广告图片',
  `link_url` varchar(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '类型 0 -- pc端  1-- 手机端 ',
  `background` varchar(255) NOT NULL DEFAULT '#FFFFFF' COMMENT '背景色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=5461 COMMENT='店铺广告设置';

-- ----------------------------
-- Records of ns_shop_ad
-- ----------------------------

-- ----------------------------
-- Table structure for ns_shop_coin_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_shop_coin_records`;
CREATE TABLE `ns_shop_coin_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL COMMENT '店铺ID',
  `num` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '购物币数量',
  `account_type` int(11) NOT NULL DEFAULT '1' COMMENT '增加或减少类型',
  `type_alis_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联ID',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `text` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺购物币记录';

-- ----------------------------
-- Records of ns_shop_coin_records
-- ----------------------------

-- ----------------------------
-- Table structure for ns_shop_express_address
-- ----------------------------
DROP TABLE IF EXISTS `ns_shop_express_address`;
CREATE TABLE `ns_shop_express_address` (
  `express_address_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '物流地址id',
  `shop_id` int(11) NOT NULL COMMENT '商铺id',
  `contact` varchar(100) NOT NULL DEFAULT '' COMMENT '联系人',
  `mobile` varchar(50) NOT NULL DEFAULT '' COMMENT '手机',
  `phone` varchar(50) NOT NULL DEFAULT '' COMMENT '电话',
  `company_name` varchar(100) NOT NULL DEFAULT '' COMMENT '公司名称',
  `province` smallint(6) NOT NULL DEFAULT '0' COMMENT '所在地省',
  `city` smallint(6) NOT NULL DEFAULT '0' COMMENT '所在地市',
  `district` smallint(6) NOT NULL DEFAULT '0' COMMENT '所在地区县',
  `zipcode` varchar(6) NOT NULL DEFAULT '' COMMENT '邮编',
  `address` varchar(100) NOT NULL DEFAULT '' COMMENT '详细地址',
  `is_consigner` tinyint(2) NOT NULL DEFAULT '0' COMMENT '发货地址标记',
  `is_receiver` tinyint(2) NOT NULL DEFAULT '0' COMMENT '收货地址标记',
  `create_date` int(11) DEFAULT '0' COMMENT '创建日期',
  `modify_date` int(11) DEFAULT '0' COMMENT '修改日期',
  PRIMARY KEY (`express_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1092 COMMENT='物流地址';

-- ----------------------------
-- Records of ns_shop_express_address
-- ----------------------------

-- ----------------------------
-- Table structure for ns_shop_group
-- ----------------------------
DROP TABLE IF EXISTS `ns_shop_group`;
CREATE TABLE `ns_shop_group` (
  `shop_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分组ID',
  `group_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分组名称',
  `group_sort` int(11) NOT NULL DEFAULT '1' COMMENT '分组排序号',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`shop_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2730 COMMENT='店铺分组表';

-- ----------------------------
-- Records of ns_shop_group
-- ----------------------------

-- ----------------------------
-- Table structure for ns_shop_navigation
-- ----------------------------
DROP TABLE IF EXISTS `ns_shop_navigation`;
CREATE TABLE `ns_shop_navigation` (
  `nav_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) NOT NULL COMMENT '店铺ID',
  `nav_title` varchar(255) NOT NULL DEFAULT '' COMMENT '导航名称',
  `nav_url` varchar(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `type` int(11) NOT NULL DEFAULT '3' COMMENT '纵向所在位置1.头部2.中部3底部',
  `sort` int(11) NOT NULL COMMENT '排序号',
  `align` int(11) NOT NULL DEFAULT '1' COMMENT '横向所在位置1 左  2  右',
  `nav_type` int(11) DEFAULT '1',
  `is_blank` int(11) DEFAULT '0',
  `template_name` varchar(255) DEFAULT '',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`nav_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1489 COMMENT='店铺导航管理';

-- ----------------------------
-- Records of ns_shop_navigation
-- ----------------------------
INSERT INTO `ns_shop_navigation` VALUES ('2', '0', '首页', '/index', '1', '0', '0', '0', '0', '首页', '1544258764', '1544258784');
INSERT INTO `ns_shop_navigation` VALUES ('4', '0', '新闻中心', '/cms/articlelist', '1', '6', '0', '0', '0', '新闻中心', '1544259153', '1544259153');
INSERT INTO `ns_shop_navigation` VALUES ('5', '0', '帮助中心', '/helpcenter/index', '1', '7', '0', '0', '0', '帮助中心', '1544259574', '1544262878');
INSERT INTO `ns_shop_navigation` VALUES ('6', '0', '必备耗材', 'http://nshop.xiao360.com/index.php?s=/goods/goodslist&amp;category_id=1', '1', '1', '0', '1', '0', '', '1544259800', '1544259833');
INSERT INTO `ns_shop_navigation` VALUES ('7', '0', '节日礼品', 'http://nshop.xiao360.com/index.php?s=/goods/goodslist&amp;category_id=2', '1', '2', '0', '1', '0', '', '1544259868', '1544259868');
INSERT INTO `ns_shop_navigation` VALUES ('8', '0', '宣传物料', 'http://nshop.xiao360.com/index.php?s=/goods/goodslist&amp;category_id=3', '1', '3', '0', '1', '0', '', '1544259893', '1544259893');
INSERT INTO `ns_shop_navigation` VALUES ('9', '0', '衍生品', 'http://nshop.xiao360.com/index.php?s=/goods/goodslist&amp;category_id=4', '1', '4', '0', '1', '0', '', '1544259917', '1544259917');
INSERT INTO `ns_shop_navigation` VALUES ('10', '0', '教学物料', 'http://nshop.xiao360.com/index.php?s=/goods/goodslist&amp;category_id=10', '1', '5', '0', '1', '0', '', '1546916347', '1546916347');

-- ----------------------------
-- Table structure for ns_shop_navigation_template
-- ----------------------------
DROP TABLE IF EXISTS `ns_shop_navigation_template`;
CREATE TABLE `ns_shop_navigation_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(50) NOT NULL DEFAULT '' COMMENT '模板名称',
  `template_url` varchar(255) NOT NULL DEFAULT '' COMMENT '访问路径',
  `is_use` int(11) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `use_type` int(11) NOT NULL COMMENT '1 shop端 0wap端',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=5461 COMMENT='导航 的 系统默认模板';

-- ----------------------------
-- Records of ns_shop_navigation_template
-- ----------------------------
INSERT INTO `ns_shop_navigation_template` VALUES ('1', '首页', '/index', '1', '1', '1497706628');
INSERT INTO `ns_shop_navigation_template` VALUES ('2', '限时折扣', '/index/discount', '1', '1', '1497706628');
INSERT INTO `ns_shop_navigation_template` VALUES ('3', '品牌列表', '/goods/brandlist', '1', '1', '1497706628');
INSERT INTO `ns_shop_navigation_template` VALUES ('4', '积分中心', '/goods/integralcenter', '1', '1', '1500717235');
INSERT INTO `ns_shop_navigation_template` VALUES ('5', '新闻中心', '/cms/articlelist', '1', '1', '1500717235');
INSERT INTO `ns_shop_navigation_template` VALUES ('6', '帮助中心', '/helpcenter/index', '1', '1', '1500717235');

-- ----------------------------
-- Table structure for ns_shop_order_account_records
-- ----------------------------
DROP TABLE IF EXISTS `ns_shop_order_account_records`;
CREATE TABLE `ns_shop_order_account_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL COMMENT '店铺ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `order_no` varchar(255) NOT NULL DEFAULT '' COMMENT '订单编号',
  `order_goods_id` int(11) NOT NULL COMMENT '订单项ID',
  `goods_pay_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单项实际支付金额',
  `rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品平台佣金比率',
  `shop_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺获取金额',
  `platform_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '平台获取金额',
  `is_refund` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否产生退款',
  `refund_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际退款金额',
  `shop_refund_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺扣减余额',
  `platform_refund_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '平台扣减余额',
  `is_issue` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已经结算',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=655 COMMENT='店铺针对订单的金额分配';

-- ----------------------------
-- Records of ns_shop_order_account_records
-- ----------------------------

-- ----------------------------
-- Table structure for ns_shop_weixin_share
-- ----------------------------
DROP TABLE IF EXISTS `ns_shop_weixin_share`;
CREATE TABLE `ns_shop_weixin_share` (
  `shop_id` int(11) NOT NULL,
  `goods_param_1` varchar(255) NOT NULL DEFAULT '' COMMENT '商品分享价格标示',
  `goods_param_2` varchar(255) NOT NULL DEFAULT '' COMMENT '商品分享内容',
  `shop_param_1` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺分享标题',
  `shop_param_2` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺分享主题',
  `shop_param_3` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺分享内容',
  `qrcode_param_1` varchar(255) NOT NULL DEFAULT '' COMMENT '二维码分享主题',
  `qrcode_param_2` varchar(255) NOT NULL DEFAULT '' COMMENT '二维码分享内容',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='店铺分享内容设置';

-- ----------------------------
-- Records of ns_shop_weixin_share
-- ----------------------------
INSERT INTO `ns_shop_weixin_share` VALUES ('0', '', '', '', '', '', '', '');

-- ----------------------------
-- Table structure for ns_stock
-- ----------------------------
DROP TABLE IF EXISTS `ns_stock`;
CREATE TABLE `ns_stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺ID',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `nums` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `money` varchar(32) NOT NULL DEFAULT '0' COMMENT '金额',
  `time` int(11) NOT NULL DEFAULT '0' COMMENT '时间',
  `stock_type` int(11) NOT NULL DEFAULT '0' COMMENT '类型 1：采购入库 2：退货入库 3：其他入库 4：订单出库 5：非订单出库',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '操作时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '操作人id',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '操作人',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='出入库表';

-- ----------------------------
-- Records of ns_stock
-- ----------------------------
INSERT INTO `ns_stock` VALUES ('53', '0', '12', '文件袋', '5', '25', '1548777600', '1', '还有一部分 没有入库', '1548320248', '1548320248', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('54', '0', '7', '测试', '100', '1', '1548259200', '1', '', '1548414366', '1548414366', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('55', '0', '7', '测试', '10', '0.01', '1548259200', '3', '', '1548418556', '1548418556', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('56', '0', '7', '测试', '1', '0.01', '1548604800', '4', '发货出库', '1548657342', '1548657342', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('57', '0', '7', '测试', '1', '0.01', '1548691200', '4', '发货出库', '1548755002', '1548755002', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('58', '0', '18', '钢结构房管局', '80', '96', '1548864000', '1', '', '1548921244', '1548921244', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('59', '0', '7', '测试', '1', '0.01', '1548864000', '4', '发货出库', '1548922069', '1548922069', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('60', '0', '7', '测试', '1', '0.01', '1548864000', '4', '发货出库', '1548923399', '1548923399', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('61', '0', '7', '测试', '1', '0.01', '1549900800', '4', '发货出库', '1549959919', '1549959919', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('62', '0', '4', '小丑拼图', '100', '1000', '1549900800', '1', '商品全部入库', '1549963987', '1549963987', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('63', '0', '7', '测试', '1', '0.01', '1549900800', '4', '发货出库', '1549966016', '1549966016', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('64', '0', '4', '小丑拼图', '1', '0.01', '1549900800', '4', '发货出库', '1549966016', '1549966016', '1', 'admin');
INSERT INTO `ns_stock` VALUES ('65', '0', '7', '测试', '1', '0.01', '1549987200', '2', '退货入库', '1550026259', '1550026259', '1', 'admin');

-- ----------------------------
-- Table structure for ns_supplier
-- ----------------------------
DROP TABLE IF EXISTS `ns_supplier`;
CREATE TABLE `ns_supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `supplier_name` varchar(50) NOT NULL DEFAULT '' COMMENT '供货商名称',
  `desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '供货商描述',
  `linkman_tel` varchar(255) NOT NULL DEFAULT '' COMMENT '联系人电话',
  `linkman_name` varchar(50) NOT NULL DEFAULT '' COMMENT '联系人姓名',
  `linkman_address` varchar(255) NOT NULL DEFAULT '' COMMENT '联系人地址',
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='供货商表';

-- ----------------------------
-- Records of ns_supplier
-- ----------------------------
INSERT INTO `ns_supplier` VALUES ('2', '0', '浪腾', '', '1213212311', '黄先生', '北京');
INSERT INTO `ns_supplier` VALUES ('3', '0', '校360', '', '1364846843', '李四', '深圳市龙岗区');

-- ----------------------------
-- Table structure for sys_addons
-- ----------------------------
DROP TABLE IF EXISTS `sys_addons`;
CREATE TABLE `sys_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  `has_addonslist` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有插件列表',
  `content` text NOT NULL COMMENT '详情',
  `config_hook` varchar(255) NOT NULL DEFAULT '' COMMENT '自定义配置文件钩子',
  `create_time` int(11) DEFAULT '0' COMMENT '安装时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of sys_addons
-- ----------------------------
INSERT INTO `sys_addons` VALUES ('2', 'wxtemplatemsg', '微信模板消息', '微信模板消息', '1', '[]', 'niushop', '1.0', '0', '0', '', 'wxtemplatemsg', '1544154260');

-- ----------------------------
-- Table structure for sys_addons_weixin_template_msg
-- ----------------------------
DROP TABLE IF EXISTS `sys_addons_weixin_template_msg`;
CREATE TABLE `sys_addons_weixin_template_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `instance_id` int(11) NOT NULL COMMENT '店铺id（单店版为0）',
  `template_no` varchar(55) NOT NULL COMMENT '模版编号',
  `template_id` varbinary(55) DEFAULT NULL COMMENT '微信模板消息的ID',
  `title` varchar(100) NOT NULL COMMENT '模版标题',
  `is_enable` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `headtext` varchar(255) NOT NULL COMMENT '头部文字',
  `bottomtext` varchar(255) NOT NULL COMMENT '底部文字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=4096 COMMENT='微信实例消息';

-- ----------------------------
-- Records of sys_addons_weixin_template_msg
-- ----------------------------
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('1', '0', 'OPENTM203347141', '', '会员注册成功通知', '1', '恭喜，您已成功注册为会员！', '恭喜，您已成为会员，您将享受会员所有权利！');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('2', '0', 'OPENTM200444240', '', '订单提交成功通知', '1', '亲！您已成功创建订单，点击进入完成付款。', '感谢您的支持，我们将为您提供更好的服务。');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('3', '0', 'OPENTM201541214', '', '订单发货通知', '1', '亲，你的订单已发货', '请关注订单,注意查收');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('4', '0', 'OPENTM200444326', '', '订单付款成功通知', '1', '亲！您的订单已成功付款。', '');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('5', '0', 'OPENTM207103254', '', '退款申请', '1', '您已申请退款，我们将尽快处理您提交的退款申请。您可以在“退换货”中查看退款进度', '如您的退款有疑问，请联系我们的客服人员，帮助您解决处理！');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('6', '0', 'OPENTM205986235', '', '退款结果通知', '1', '亲，您的退款已处理。', '如您还有疑问，请与客服人员联系。');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('7', '0', 'OPENTM207292959', '', '提现申请提醒', '1', '亲，您的提现申请已提交', '我们将在1到3个工作日内处理完毕，请耐心等待。');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('8', '0', 'OPENTM207292959', '', '提现审核结果通知', '1', '亲，您提现申请已通过', '我们将在1到3个工作日内处理完毕，请耐心等待。');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('9', '0', 'OPENTM409846856', '', '申请通过通知', '1', '您的推广员申请已经通过', '如您还有疑问，请与客服人员联系。');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('10', '0', 'OPENTM409846856', '', '下级申请通过通知', '1', '您的下级推广员申请已经通过', '如您还有疑问，请与客服人员联系。');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('11', '0', 'OPENTM409846856', '', '下下级申请通过通知', '1', '您的下下级推广员申请已经通过', '如您还有疑问，请与客服人员联系。');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('12', '0', 'OPENTM201010537', '', '本店分销订单提成通知', '1', '亲，您已成功分销出一笔订单，继续努力哦', '');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('13', '0', 'OPENTM201010537', '', '下级分店分销订单提成通知', '1', '亲，您的下级推广员成功分销出一笔订单，继续努力哦', '');
INSERT INTO `sys_addons_weixin_template_msg` VALUES ('14', '0', 'OPENTM201010537', '', '下下级分店分销订单提成通知', '1', '亲，您的下下级推广员成功分销出一笔订单，继续努力哦', '');

-- ----------------------------
-- Table structure for sys_album_class
-- ----------------------------
DROP TABLE IF EXISTS `sys_album_class`;
CREATE TABLE `sys_album_class` (
  `album_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '相册id',
  `shop_id` int(10) NOT NULL DEFAULT '1' COMMENT '店铺id',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '上级相册ID',
  `album_name` varchar(100) NOT NULL COMMENT '相册名称',
  `album_cover` varchar(255) NOT NULL DEFAULT '' COMMENT '相册封面',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为默认相册,1代表默认',
  `sort` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`album_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='相册表';

-- ----------------------------
-- Records of sys_album_class
-- ----------------------------
INSERT INTO `sys_album_class` VALUES ('30', '0', '0', '默认相册', '0', '1', '1', '1497064831');
INSERT INTO `sys_album_class` VALUES ('31', '0', '0', '书籍商品图片', '', '0', '1', '1543999560');

-- ----------------------------
-- Table structure for sys_album_picture
-- ----------------------------
DROP TABLE IF EXISTS `sys_album_picture`;
CREATE TABLE `sys_album_picture` (
  `pic_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '相册图片表id',
  `shop_id` int(10) unsigned DEFAULT '1' COMMENT '所属实例id',
  `album_id` int(10) unsigned NOT NULL COMMENT '相册id',
  `is_wide` int(11) NOT NULL DEFAULT '0' COMMENT '是否宽屏',
  `pic_name` varchar(100) NOT NULL COMMENT '图片名称',
  `pic_tag` varchar(255) NOT NULL DEFAULT '' COMMENT '图片标签',
  `pic_cover` varchar(255) NOT NULL COMMENT '原图图片路径',
  `pic_size` varchar(255) NOT NULL COMMENT '原图大小',
  `pic_spec` varchar(100) NOT NULL COMMENT '原图规格',
  `pic_cover_big` varchar(255) NOT NULL DEFAULT '' COMMENT '大图路径',
  `pic_size_big` varchar(255) NOT NULL DEFAULT '0' COMMENT '大图大小',
  `pic_spec_big` varchar(100) NOT NULL DEFAULT '' COMMENT '大图规格',
  `pic_cover_mid` varchar(255) NOT NULL DEFAULT '' COMMENT '中图路径',
  `pic_size_mid` varchar(255) NOT NULL DEFAULT '0' COMMENT '中图大小',
  `pic_spec_mid` varchar(100) NOT NULL DEFAULT '' COMMENT '中图规格',
  `pic_cover_small` varchar(255) NOT NULL DEFAULT '' COMMENT '小图路径',
  `pic_size_small` varchar(255) NOT NULL DEFAULT '0' COMMENT '小图大小',
  `pic_spec_small` varchar(255) NOT NULL DEFAULT '' COMMENT '小图规格',
  `pic_cover_micro` varchar(255) NOT NULL DEFAULT '' COMMENT '微图路径',
  `pic_size_micro` varchar(255) NOT NULL DEFAULT '0' COMMENT '微图大小',
  `pic_spec_micro` varchar(255) NOT NULL DEFAULT '' COMMENT '微图规格',
  `upload_time` int(11) DEFAULT '0' COMMENT '图片上传时间',
  `upload_type` int(11) DEFAULT '1' COMMENT '图片外链',
  `domain` varchar(255) DEFAULT '' COMMENT '图片外链',
  `bucket` varchar(255) DEFAULT '' COMMENT '存储空间名称',
  PRIMARY KEY (`pic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=204 COMMENT='相册图片表';

-- ----------------------------
-- Records of sys_album_picture
-- ----------------------------
INSERT INTO `sys_album_picture` VALUES ('1', '0', '30', '0', 'login1543999312', 'login', 'upload/goods/20181205/9c6f1c006b731509cf75d857e9d1638d.png', '750,363', '750,363', 'upload/goods/20181205/68020b4d396691a1e5dc804c74e626271.png', '700,700', '700,700', 'upload/goods/20181205/68020b4d396691a1e5dc804c74e626272.png', '360,360', '360,360', 'upload/goods/20181205/68020b4d396691a1e5dc804c74e626273.png', '240,240', '240,240', 'upload/goods/20181205/68020b4d396691a1e5dc804c74e626274.png', '60,60', '60,60', '1543999317', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('3', '0', '30', '0', 'login1543999584', 'login', 'upload/goods/20181205/40211fda0640f4aaa5e1a125c0d2cbb6.png', '750,363', '750,363', 'upload/goods/20181205/2f885537ec267758dca9d98f3ff60bcb1.png', '700,700', '700,700', 'upload/goods/20181205/2f885537ec267758dca9d98f3ff60bcb2.png', '360,360', '360,360', 'upload/goods/20181205/2f885537ec267758dca9d98f3ff60bcb3.png', '240,240', '240,240', 'upload/goods/20181205/2f885537ec267758dca9d98f3ff60bcb4.png', '60,60', '60,60', '1543999588', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('4', '0', '30', '0', 'bl1544087790', 'bl', 'upload/goods/20181206/c0cdfd1e67ddd977e7589766d77d5e9d.jpg', '500,432', '500,432', 'upload/goods/20181206/fd8fe76eada28a96964b322ab562f6a81.jpg', '700,700', '700,700', 'upload/goods/20181206/fd8fe76eada28a96964b322ab562f6a82.jpg', '360,360', '360,360', 'upload/goods/20181206/fd8fe76eada28a96964b322ab562f6a83.jpg', '240,240', '240,240', 'upload/goods/20181206/fd8fe76eada28a96964b322ab562f6a84.jpg', '60,60', '60,60', '1544087792', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('5', '0', '30', '0', 'bl1544087922', 'bl', 'upload/goods/20181206/37f5952c3914b8572a5807e5d34d685d.jpg', '500,432', '500,432', 'upload/goods/20181206/63e2ced3d53192fd181777713a6542fd1.jpg', '700,700', '700,700', 'upload/goods/20181206/63e2ced3d53192fd181777713a6542fd2.jpg', '360,360', '360,360', 'upload/goods/20181206/63e2ced3d53192fd181777713a6542fd3.jpg', '240,240', '240,240', 'upload/goods/20181206/63e2ced3d53192fd181777713a6542fd4.jpg', '60,60', '60,60', '1544087925', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('6', '0', '30', '0', 'fb1544087931', 'fb', 'upload/goods/20181206/d03bb13279de84da24d4d32d3d8c4c1a.jpg', '500,432', '500,432', 'upload/goods/20181206/976e31c70357c6b012163f3179c846391.jpg', '700,700', '700,700', 'upload/goods/20181206/976e31c70357c6b012163f3179c846392.jpg', '360,360', '360,360', 'upload/goods/20181206/976e31c70357c6b012163f3179c846393.jpg', '240,240', '240,240', 'upload/goods/20181206/976e31c70357c6b012163f3179c846394.jpg', '60,60', '60,60', '1544087933', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('7', '0', '30', '0', 'wo1544088193', 'wo', 'upload/goods/20181206/e329fb34593096c07fd183dc0e8bead6.jpg', '500,380', '500,380', 'upload/goods/20181206/ff8415ab502c981867380d97a2d08e791.jpg', '700,700', '700,700', 'upload/goods/20181206/ff8415ab502c981867380d97a2d08e792.jpg', '360,360', '360,360', 'upload/goods/20181206/ff8415ab502c981867380d97a2d08e793.jpg', '240,240', '240,240', 'upload/goods/20181206/ff8415ab502c981867380d97a2d08e794.jpg', '60,60', '60,60', '1544088198', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('8', '0', '30', '0', 'pt1544088505', 'pt', 'upload/goods/20181206/6e1d349d7ff69f1f012486f6f811f235.jpg', '1280,960', '1280,960', 'upload/goods/20181206/d5347234b5d9bd8b7e4faaffb816ca9e1.jpg', '700,700', '700,700', 'upload/goods/20181206/d5347234b5d9bd8b7e4faaffb816ca9e2.jpg', '360,360', '360,360', 'upload/goods/20181206/d5347234b5d9bd8b7e4faaffb816ca9e3.jpg', '240,240', '240,240', 'upload/goods/20181206/d5347234b5d9bd8b7e4faaffb816ca9e4.jpg', '60,60', '60,60', '1544088510', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('9', '0', '30', '0', 'ylp1544088823', 'ylp', 'upload/goods/20181206/b2273a979b3b3437ae62e16ff7325c4b.jpg', '226,180', '226,180', 'upload/goods/20181206/695dc5f94cdcb1675f61b1eeccd24f021.jpg', '700,700', '700,700', 'upload/goods/20181206/695dc5f94cdcb1675f61b1eeccd24f022.jpg', '360,360', '360,360', 'upload/goods/20181206/695dc5f94cdcb1675f61b1eeccd24f023.jpg', '240,240', '240,240', 'upload/goods/20181206/695dc5f94cdcb1675f61b1eeccd24f024.jpg', '60,60', '60,60', '1544088824', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('10', '0', '30', '0', '收钱吧收款账户1546576366', '收钱吧收款账户', 'upload/goods/20190104/050df97822990375faf1000537c6c50c.jpg', '680,945', '680,945', 'upload/goods/20190104/7eb5a4920722bc60af62d8e0f44997921.jpg', '700,700', '700,700', 'upload/goods/20190104/7eb5a4920722bc60af62d8e0f44997922.jpg', '360,360', '360,360', 'upload/goods/20190104/7eb5a4920722bc60af62d8e0f44997923.jpg', '240,240', '240,240', 'upload/goods/20190104/7eb5a4920722bc60af62d8e0f44997924.jpg', '60,60', '60,60', '1546576367', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('11', '0', '30', '0', '微信截图_201901081007111546913246', '微信截图_20190108100711', 'upload/goods/20190108/093ad938f1b778be22d5f7599c42fa40.png', '720,643', '720,643', 'upload/goods/20190108/98c50326a9295c9b6b7ca90112a982561.png', '700,700', '700,700', 'upload/goods/20190108/98c50326a9295c9b6b7ca90112a982562.png', '360,360', '360,360', 'upload/goods/20190108/98c50326a9295c9b6b7ca90112a982563.png', '240,240', '240,240', 'upload/goods/20190108/98c50326a9295c9b6b7ca90112a982564.png', '60,60', '60,60', '1546913248', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('12', '0', '30', '0', '微信截图_201901081008251546913315', '微信截图_20190108100825', 'upload/goods/20190108/24bd4026816711076135cd6de8157a0a.png', '968,644', '968,644', 'upload/goods/20190108/44eee55c9c5b08e4399f3cb5689745ef1.png', '700,700', '700,700', 'upload/goods/20190108/44eee55c9c5b08e4399f3cb5689745ef2.png', '360,360', '360,360', 'upload/goods/20190108/44eee55c9c5b08e4399f3cb5689745ef3.png', '240,240', '240,240', 'upload/goods/20190108/44eee55c9c5b08e4399f3cb5689745ef4.png', '60,60', '60,60', '1546913317', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('13', '0', '30', '0', '微信截图_201901081010381546913452', '微信截图_20190108101038', 'upload/goods/20190108/66e5e36bb463f12bee9ebd7ed5e573c1.png', '800,652', '800,652', 'upload/goods/20190108/0fbdb5fee2b8a1966f751820ec8f8bdc1.png', '700,700', '700,700', 'upload/goods/20190108/0fbdb5fee2b8a1966f751820ec8f8bdc2.png', '360,360', '360,360', 'upload/goods/20190108/0fbdb5fee2b8a1966f751820ec8f8bdc3.png', '240,240', '240,240', 'upload/goods/20190108/0fbdb5fee2b8a1966f751820ec8f8bdc4.png', '60,60', '60,60', '1546913454', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('14', '0', '30', '0', '微信截图_201901081010381546913664', '微信截图_20190108101038', 'upload/goods/20190108/05ba33eb53965bd00c6bfd0b3f783eaa.png', '800,652', '800,652', 'upload/goods/20190108/48504d03f298a0589c317575247e4f161.png', '700,700', '700,700', 'upload/goods/20190108/48504d03f298a0589c317575247e4f162.png', '360,360', '360,360', 'upload/goods/20190108/48504d03f298a0589c317575247e4f163.png', '240,240', '240,240', 'upload/goods/20190108/48504d03f298a0589c317575247e4f164.png', '60,60', '60,60', '1546913666', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('15', '0', '30', '0', '微信截图_201901081021011546914324', '微信截图_20190108102101', 'upload/goods/20190108/e75df0478c109e5b202bb078dc5f10a8.png', '800,652', '800,652', 'upload/goods/20190108/b4eb38ee41342a1627e6724040c710491.png', '700,700', '700,700', 'upload/goods/20190108/b4eb38ee41342a1627e6724040c710492.png', '360,360', '360,360', 'upload/goods/20190108/b4eb38ee41342a1627e6724040c710493.png', '240,240', '240,240', 'upload/goods/20190108/b4eb38ee41342a1627e6724040c710494.png', '60,60', '60,60', '1546914325', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('16', '0', '30', '0', '微信截图_201901081106411546916989', '微信截图_20190108110641', 'upload/goods/20190108/c826b85d90dfa4048191cb21442157b0.png', '800,652', '800,652', 'upload/goods/20190108/7d52c69126f995591f86b0bf24b6b6801.png', '700,700', '700,700', 'upload/goods/20190108/7d52c69126f995591f86b0bf24b6b6802.png', '360,360', '360,360', 'upload/goods/20190108/7d52c69126f995591f86b0bf24b6b6803.png', '240,240', '240,240', 'upload/goods/20190108/7d52c69126f995591f86b0bf24b6b6804.png', '60,60', '60,60', '1546916993', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('17', '0', '30', '0', '微信截图_201901081115461546917426', '微信截图_20190108111546', 'upload/goods/20190108/9811cd3dfc741138908b61ec0ba92b95.png', '800,641', '800,641', 'upload/goods/20190108/a4257b60f7af277580debdd8437539c01.png', '700,700', '700,700', 'upload/goods/20190108/a4257b60f7af277580debdd8437539c02.png', '360,360', '360,360', 'upload/goods/20190108/a4257b60f7af277580debdd8437539c03.png', '240,240', '240,240', 'upload/goods/20190108/a4257b60f7af277580debdd8437539c04.png', '60,60', '60,60', '1546917429', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('18', '0', '30', '0', '微信截图_201901081124091546918282', '微信截图_20190108112409', 'upload/goods/20190108/f1b5c928e7f133d933c11cbe94635b48.png', '800,652', '800,652', 'upload/goods/20190108/a0a09f9e7c04b42b589c9a21c125df4e1.png', '700,700', '700,700', 'upload/goods/20190108/a0a09f9e7c04b42b589c9a21c125df4e2.png', '360,360', '360,360', 'upload/goods/20190108/a0a09f9e7c04b42b589c9a21c125df4e3.png', '240,240', '240,240', 'upload/goods/20190108/a0a09f9e7c04b42b589c9a21c125df4e4.png', '60,60', '60,60', '1546918285', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('19', '0', '30', '0', '微信截图_201901081136281546918666', '微信截图_20190108113628', 'upload/goods/20190108/321e74220220bcb820edce840a6a7863.png', '800,652', '800,652', 'upload/goods/20190108/bd13cec12a25e97ba025e2bdd83156851.png', '700,700', '700,700', 'upload/goods/20190108/bd13cec12a25e97ba025e2bdd83156852.png', '360,360', '360,360', 'upload/goods/20190108/bd13cec12a25e97ba025e2bdd83156853.png', '240,240', '240,240', 'upload/goods/20190108/bd13cec12a25e97ba025e2bdd83156854.png', '60,60', '60,60', '1546918668', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('20', '0', '30', '0', '微信截图_201901081141301546919032', '微信截图_20190108114130', 'upload/goods/20190108/a41a79f14a3897192e529ed4e0127aeb.png', '800,652', '800,652', 'upload/goods/20190108/040508287b89eb5be75e460cd4846ac01.png', '700,700', '700,700', 'upload/goods/20190108/040508287b89eb5be75e460cd4846ac02.png', '360,360', '360,360', 'upload/goods/20190108/040508287b89eb5be75e460cd4846ac03.png', '240,240', '240,240', 'upload/goods/20190108/040508287b89eb5be75e460cd4846ac04.png', '60,60', '60,60', '1546919033', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('21', '0', '30', '0', '微信截图_201901081154551546919721', '微信截图_20190108115455', 'upload/goods/20190108/ab287f219d318ee8e3323d9c4a4d53af.png', '800,652', '800,652', 'upload/goods/20190108/7c07726aa4e3d609eb3a550747c921bd1.png', '700,700', '700,700', 'upload/goods/20190108/7c07726aa4e3d609eb3a550747c921bd2.png', '360,360', '360,360', 'upload/goods/20190108/7c07726aa4e3d609eb3a550747c921bd3.png', '240,240', '240,240', 'upload/goods/20190108/7c07726aa4e3d609eb3a550747c921bd4.png', '60,60', '60,60', '1546919724', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('22', '0', '30', '0', '微信截图_201901081158361546920148', '微信截图_20190108115836', 'upload/goods/20190108/950db7d9fbfc26540693a5adb16bc17b.png', '800,652', '800,652', 'upload/goods/20190108/c2812ba19ffeba6c48024aa5542498671.png', '700,700', '700,700', 'upload/goods/20190108/c2812ba19ffeba6c48024aa5542498672.png', '360,360', '360,360', 'upload/goods/20190108/c2812ba19ffeba6c48024aa5542498673.png', '240,240', '240,240', 'upload/goods/20190108/c2812ba19ffeba6c48024aa5542498674.png', '60,60', '60,60', '1546920151', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('23', '0', '30', '0', '微信截图_201901081205381546920531', '微信截图_20190108120538', 'upload/goods/20190108/294ca34344f210ad6d21e4ab8ca1a26f.png', '800,652', '800,652', 'upload/goods/20190108/97e4c91c575ec2ad0cf6f9abc21900da1.png', '700,700', '700,700', 'upload/goods/20190108/97e4c91c575ec2ad0cf6f9abc21900da2.png', '360,360', '360,360', 'upload/goods/20190108/97e4c91c575ec2ad0cf6f9abc21900da3.png', '240,240', '240,240', 'upload/goods/20190108/97e4c91c575ec2ad0cf6f9abc21900da4.png', '60,60', '60,60', '1546920533', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('24', '0', '30', '0', '微信截图_201901081205381546926235', '微信截图_20190108120538', 'upload/goods/20190108/69c1c076a3f792f5bfdc6e1e4b9978d8.png', '800,652', '800,652', 'upload/goods/20190108/371d7cc08694a3166355b7a0b45a85561.png', '700,700', '700,700', 'upload/goods/20190108/371d7cc08694a3166355b7a0b45a85562.png', '360,360', '360,360', 'upload/goods/20190108/371d7cc08694a3166355b7a0b45a85563.png', '240,240', '240,240', 'upload/goods/20190108/371d7cc08694a3166355b7a0b45a85564.png', '60,60', '60,60', '1546926237', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('25', '0', '30', '0', '武总身份证反面1546997917', '武总身份证反面', 'upload/goods/20190109/709fe111613f0effa4a9c0f463a0ed20.jpg', '896,1920', '896,1920', 'upload/goods/20190109/38e8183c89c78ce36a3a6155b095f1e61.jpg', '700,700', '700,700', 'upload/goods/20190109/38e8183c89c78ce36a3a6155b095f1e62.jpg', '360,360', '360,360', 'upload/goods/20190109/38e8183c89c78ce36a3a6155b095f1e63.jpg', '240,240', '240,240', 'upload/goods/20190109/38e8183c89c78ce36a3a6155b095f1e64.jpg', '60,60', '60,60', '1546997918', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('26', '0', '30', '0', 'QQ截图201901241621081548318160', 'QQ截图20190124162108', 'upload/goods/20190124/13df497d2e3c104f483d295ddc1c6350.png', '523,371', '523,371', 'upload/goods/20190124/ec484f0cc2470e57dcaace9a5da17a681.png', '700,700', '700,700', 'upload/goods/20190124/ec484f0cc2470e57dcaace9a5da17a682.png', '360,360', '360,360', 'upload/goods/20190124/ec484f0cc2470e57dcaace9a5da17a683.png', '240,240', '240,240', 'upload/goods/20190124/ec484f0cc2470e57dcaace9a5da17a684.png', '60,60', '60,60', '1548318162', '1', '', '');
INSERT INTO `sys_album_picture` VALUES ('27', '0', '30', '0', 'QQ截图201901241621081548318478', 'QQ截图20190124162108', 'upload/goods/20190124/81f36f950041b3c96ffefb9d95d53b3b.png', '523,371', '523,371', 'upload/goods/20190124/3bd5c10a83692d45e2e07d4ea49a42101.png', '700,700', '700,700', 'upload/goods/20190124/3bd5c10a83692d45e2e07d4ea49a42102.png', '360,360', '360,360', 'upload/goods/20190124/3bd5c10a83692d45e2e07d4ea49a42103.png', '240,240', '240,240', 'upload/goods/20190124/3bd5c10a83692d45e2e07d4ea49a42104.png', '60,60', '60,60', '1548318480', '1', '', '');

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(50) NOT NULL DEFAULT '',
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2048 COMMENT='全部区域表';

-- ----------------------------
-- Records of sys_area
-- ----------------------------
INSERT INTO `sys_area` VALUES ('1', '华东', '0');
INSERT INTO `sys_area` VALUES ('2', '华北', '0');
INSERT INTO `sys_area` VALUES ('3', '华南', '0');
INSERT INTO `sys_area` VALUES ('4', '华中', '0');
INSERT INTO `sys_area` VALUES ('5', '东北', '0');
INSERT INTO `sys_area` VALUES ('6', '西北', '0');
INSERT INTO `sys_area` VALUES ('7', '西南', '0');
INSERT INTO `sys_area` VALUES ('8', '港澳台', '0');

-- ----------------------------
-- Table structure for sys_city
-- ----------------------------
DROP TABLE IF EXISTS `sys_city`;
CREATE TABLE `sys_city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `province_id` int(11) NOT NULL DEFAULT '0',
  `city_name` varchar(255) NOT NULL DEFAULT '',
  `zipcode` varchar(6) NOT NULL DEFAULT '',
  `sort` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`city_id`),
  KEY `IDX_g_city_CityName` (`city_name`)
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=135;

-- ----------------------------
-- Records of sys_city
-- ----------------------------
INSERT INTO `sys_city` VALUES ('1', '1', '北京市', '100000', '1');
INSERT INTO `sys_city` VALUES ('2', '2', '天津市', '100000', '0');
INSERT INTO `sys_city` VALUES ('3', '3', '石家庄市', '050000', '0');
INSERT INTO `sys_city` VALUES ('4', '3', '唐山市', '063000', '0');
INSERT INTO `sys_city` VALUES ('5', '3', '秦皇岛市', '066000', '0');
INSERT INTO `sys_city` VALUES ('6', '3', '邯郸市', '056000', '0');
INSERT INTO `sys_city` VALUES ('7', '3', '邢台市', '054000', '0');
INSERT INTO `sys_city` VALUES ('8', '3', '保定市', '071000', '0');
INSERT INTO `sys_city` VALUES ('9', '3', '张家口市', '075000', '0');
INSERT INTO `sys_city` VALUES ('10', '3', '承德市', '067000', '0');
INSERT INTO `sys_city` VALUES ('11', '3', '沧州市', '061000', '0');
INSERT INTO `sys_city` VALUES ('12', '3', '廊坊市', '065000', '0');
INSERT INTO `sys_city` VALUES ('13', '3', '衡水市', '053000', '0');
INSERT INTO `sys_city` VALUES ('14', '4', '太原市', '030000', '0');
INSERT INTO `sys_city` VALUES ('15', '4', '大同市', '037000', '0');
INSERT INTO `sys_city` VALUES ('16', '4', '阳泉市', '045000', '0');
INSERT INTO `sys_city` VALUES ('17', '4', '长治市', '046000', '0');
INSERT INTO `sys_city` VALUES ('18', '4', '晋城市', '048000', '0');
INSERT INTO `sys_city` VALUES ('19', '4', '朔州市', '036000', '0');
INSERT INTO `sys_city` VALUES ('20', '4', '晋中市', '030600', '0');
INSERT INTO `sys_city` VALUES ('21', '4', '运城市', '044000', '0');
INSERT INTO `sys_city` VALUES ('22', '4', '忻州市', '034000', '0');
INSERT INTO `sys_city` VALUES ('23', '4', '临汾市', '041000', '0');
INSERT INTO `sys_city` VALUES ('24', '4', '吕梁市', '030500', '0');
INSERT INTO `sys_city` VALUES ('25', '5', '呼和浩特市', '010000', '0');
INSERT INTO `sys_city` VALUES ('26', '5', '包头市', '014000', '0');
INSERT INTO `sys_city` VALUES ('27', '5', '乌海市', '016000', '0');
INSERT INTO `sys_city` VALUES ('28', '5', '赤峰市', '024000', '0');
INSERT INTO `sys_city` VALUES ('29', '5', '通辽市', '028000', '0');
INSERT INTO `sys_city` VALUES ('30', '5', '鄂尔多斯市', '010300', '0');
INSERT INTO `sys_city` VALUES ('31', '5', '呼伦贝尔市', '021000', '0');
INSERT INTO `sys_city` VALUES ('32', '5', '巴彦淖尔市', '014400', '0');
INSERT INTO `sys_city` VALUES ('33', '5', '乌兰察布市', '011800', '0');
INSERT INTO `sys_city` VALUES ('34', '5', '兴安盟', '137500', '0');
INSERT INTO `sys_city` VALUES ('35', '5', '锡林郭勒盟', '011100', '0');
INSERT INTO `sys_city` VALUES ('36', '5', '阿拉善盟', '016000', '0');
INSERT INTO `sys_city` VALUES ('37', '6', '沈阳市', '110000', '0');
INSERT INTO `sys_city` VALUES ('38', '6', '大连市', '116000', '0');
INSERT INTO `sys_city` VALUES ('39', '6', '鞍山市', '114000', '0');
INSERT INTO `sys_city` VALUES ('40', '6', '抚顺市', '113000', '0');
INSERT INTO `sys_city` VALUES ('41', '6', '本溪市', '117000', '0');
INSERT INTO `sys_city` VALUES ('42', '6', '丹东市', '118000', '0');
INSERT INTO `sys_city` VALUES ('43', '6', '锦州市', '121000', '0');
INSERT INTO `sys_city` VALUES ('44', '6', '营口市', '115000', '0');
INSERT INTO `sys_city` VALUES ('45', '6', '阜新市', '123000', '0');
INSERT INTO `sys_city` VALUES ('46', '6', '辽阳市', '111000', '0');
INSERT INTO `sys_city` VALUES ('47', '6', '盘锦市', '124000', '0');
INSERT INTO `sys_city` VALUES ('48', '6', '铁岭市', '112000', '0');
INSERT INTO `sys_city` VALUES ('49', '6', '朝阳市', '122000', '0');
INSERT INTO `sys_city` VALUES ('50', '6', '葫芦岛市', '125000', '0');
INSERT INTO `sys_city` VALUES ('51', '7', '长春市', '130000', '0');
INSERT INTO `sys_city` VALUES ('52', '7', '吉林市', '132000', '0');
INSERT INTO `sys_city` VALUES ('53', '7', '四平市', '136000', '0');
INSERT INTO `sys_city` VALUES ('54', '7', '辽源市', '136200', '0');
INSERT INTO `sys_city` VALUES ('55', '7', '通化市', '134000', '0');
INSERT INTO `sys_city` VALUES ('56', '7', '白山市', '134300', '0');
INSERT INTO `sys_city` VALUES ('57', '7', '松原市', '131100', '0');
INSERT INTO `sys_city` VALUES ('58', '7', '白城市', '137000', '0');
INSERT INTO `sys_city` VALUES ('59', '7', '延边朝鲜族自治州', '133000', '0');
INSERT INTO `sys_city` VALUES ('60', '8', '哈尔滨市', '150000', '0');
INSERT INTO `sys_city` VALUES ('61', '8', '齐齐哈尔市', '161000', '0');
INSERT INTO `sys_city` VALUES ('62', '8', '鸡西市', '158100', '0');
INSERT INTO `sys_city` VALUES ('63', '8', '鹤岗市', '154100', '0');
INSERT INTO `sys_city` VALUES ('64', '8', '双鸭山市', '155100', '0');
INSERT INTO `sys_city` VALUES ('65', '8', '大庆市', '163000', '0');
INSERT INTO `sys_city` VALUES ('66', '8', '伊春市', '152300', '0');
INSERT INTO `sys_city` VALUES ('67', '8', '佳木斯市', '154000', '0');
INSERT INTO `sys_city` VALUES ('68', '8', '七台河市', '154600', '0');
INSERT INTO `sys_city` VALUES ('69', '8', '牡丹江市', '157000', '0');
INSERT INTO `sys_city` VALUES ('70', '8', '黑河市', '164300', '0');
INSERT INTO `sys_city` VALUES ('71', '8', '绥化市', '152000', '0');
INSERT INTO `sys_city` VALUES ('72', '8', '大兴安岭地区', '165000', '0');
INSERT INTO `sys_city` VALUES ('73', '9', '上海市', '200000', '0');
INSERT INTO `sys_city` VALUES ('74', '10', '南京市', '210000', '0');
INSERT INTO `sys_city` VALUES ('75', '10', '无锡市', '214000', '0');
INSERT INTO `sys_city` VALUES ('76', '10', '徐州市', '221000', '0');
INSERT INTO `sys_city` VALUES ('77', '10', '常州市', '213000', '0');
INSERT INTO `sys_city` VALUES ('78', '10', '苏州市', '215000', '0');
INSERT INTO `sys_city` VALUES ('79', '10', '南通市', '226000', '0');
INSERT INTO `sys_city` VALUES ('80', '10', '连云港市', '222000', '0');
INSERT INTO `sys_city` VALUES ('81', '10', '淮安市', '223200', '0');
INSERT INTO `sys_city` VALUES ('82', '10', '盐城市', '224000', '0');
INSERT INTO `sys_city` VALUES ('83', '10', '扬州市', '225000', '0');
INSERT INTO `sys_city` VALUES ('84', '10', '镇江市', '212000', '0');
INSERT INTO `sys_city` VALUES ('85', '10', '泰州市', '225300', '0');
INSERT INTO `sys_city` VALUES ('86', '10', '宿迁市', '223800', '0');
INSERT INTO `sys_city` VALUES ('87', '11', '杭州市', '310000', '0');
INSERT INTO `sys_city` VALUES ('88', '11', '宁波市', '315000', '0');
INSERT INTO `sys_city` VALUES ('89', '11', '温州市', '325000', '0');
INSERT INTO `sys_city` VALUES ('90', '11', '嘉兴市', '314000', '0');
INSERT INTO `sys_city` VALUES ('91', '11', '湖州市', '313000', '0');
INSERT INTO `sys_city` VALUES ('92', '11', '绍兴市', '312000', '0');
INSERT INTO `sys_city` VALUES ('93', '11', '金华市', '321000', '0');
INSERT INTO `sys_city` VALUES ('94', '11', '衢州市', '324000', '0');
INSERT INTO `sys_city` VALUES ('95', '11', '舟山市', '316000', '0');
INSERT INTO `sys_city` VALUES ('96', '11', '台州市', '318000', '0');
INSERT INTO `sys_city` VALUES ('97', '11', '丽水市', '323000', '0');
INSERT INTO `sys_city` VALUES ('98', '12', '合肥市', '230000', '0');
INSERT INTO `sys_city` VALUES ('99', '12', '芜湖市', '241000', '0');
INSERT INTO `sys_city` VALUES ('100', '12', '蚌埠市', '233000', '0');
INSERT INTO `sys_city` VALUES ('101', '12', '淮南市', '232000', '0');
INSERT INTO `sys_city` VALUES ('102', '12', '马鞍山市', '243000', '0');
INSERT INTO `sys_city` VALUES ('103', '12', '淮北市', '235000', '0');
INSERT INTO `sys_city` VALUES ('104', '12', '铜陵市', '244000', '0');
INSERT INTO `sys_city` VALUES ('105', '12', '安庆市', '246000', '0');
INSERT INTO `sys_city` VALUES ('106', '12', '黄山市', '242700', '0');
INSERT INTO `sys_city` VALUES ('107', '12', '滁州市', '239000', '0');
INSERT INTO `sys_city` VALUES ('108', '12', '阜阳市', '236100', '0');
INSERT INTO `sys_city` VALUES ('109', '12', '宿州市', '234100', '0');
INSERT INTO `sys_city` VALUES ('110', '12', '巢湖市', '238000', '0');
INSERT INTO `sys_city` VALUES ('111', '12', '六安市', '237000', '0');
INSERT INTO `sys_city` VALUES ('112', '12', '亳州市', '236800', '0');
INSERT INTO `sys_city` VALUES ('113', '12', '池州市', '247100', '0');
INSERT INTO `sys_city` VALUES ('114', '12', '宣城市', '366000', '0');
INSERT INTO `sys_city` VALUES ('115', '13', '福州市', '350000', '0');
INSERT INTO `sys_city` VALUES ('116', '13', '厦门市', '361000', '0');
INSERT INTO `sys_city` VALUES ('117', '13', '莆田市', '351100', '0');
INSERT INTO `sys_city` VALUES ('118', '13', '三明市', '365000', '0');
INSERT INTO `sys_city` VALUES ('119', '13', '泉州市', '362000', '0');
INSERT INTO `sys_city` VALUES ('120', '13', '漳州市', '363000', '0');
INSERT INTO `sys_city` VALUES ('121', '13', '南平市', '353000', '0');
INSERT INTO `sys_city` VALUES ('122', '13', '龙岩市', '364000', '0');
INSERT INTO `sys_city` VALUES ('123', '13', '宁德市', '352100', '0');
INSERT INTO `sys_city` VALUES ('124', '14', '南昌市', '330000', '0');
INSERT INTO `sys_city` VALUES ('125', '14', '景德镇市', '333000', '0');
INSERT INTO `sys_city` VALUES ('126', '14', '萍乡市', '337000', '0');
INSERT INTO `sys_city` VALUES ('127', '14', '九江市', '332000', '0');
INSERT INTO `sys_city` VALUES ('128', '14', '新余市', '338000', '0');
INSERT INTO `sys_city` VALUES ('129', '14', '鹰潭市', '335000', '0');
INSERT INTO `sys_city` VALUES ('130', '14', '赣州市', '341000', '0');
INSERT INTO `sys_city` VALUES ('131', '14', '吉安市', '343000', '0');
INSERT INTO `sys_city` VALUES ('132', '14', '宜春市', '336000', '0');
INSERT INTO `sys_city` VALUES ('133', '14', '抚州市', '332900', '0');
INSERT INTO `sys_city` VALUES ('134', '14', '上饶市', '334000', '0');
INSERT INTO `sys_city` VALUES ('135', '15', '济南市', '250000', '0');
INSERT INTO `sys_city` VALUES ('136', '15', '青岛市', '266000', '0');
INSERT INTO `sys_city` VALUES ('137', '15', '淄博市', '255000', '0');
INSERT INTO `sys_city` VALUES ('138', '15', '枣庄市', '277100', '0');
INSERT INTO `sys_city` VALUES ('139', '15', '东营市', '257000', '0');
INSERT INTO `sys_city` VALUES ('140', '15', '烟台市', '264000', '0');
INSERT INTO `sys_city` VALUES ('141', '15', '潍坊市', '261000', '0');
INSERT INTO `sys_city` VALUES ('142', '15', '济宁市', '272100', '0');
INSERT INTO `sys_city` VALUES ('143', '15', '泰安市', '271000', '0');
INSERT INTO `sys_city` VALUES ('144', '15', '威海市', '265700', '0');
INSERT INTO `sys_city` VALUES ('145', '15', '日照市', '276800', '0');
INSERT INTO `sys_city` VALUES ('146', '15', '莱芜市', '271100', '0');
INSERT INTO `sys_city` VALUES ('147', '15', '临沂市', '276000', '0');
INSERT INTO `sys_city` VALUES ('148', '15', '德州市', '253000', '0');
INSERT INTO `sys_city` VALUES ('149', '15', '聊城市', '252000', '0');
INSERT INTO `sys_city` VALUES ('150', '15', '滨州市', '256600', '0');
INSERT INTO `sys_city` VALUES ('151', '15', '荷泽市', '255000', '0');
INSERT INTO `sys_city` VALUES ('152', '16', '郑州市', '450000', '0');
INSERT INTO `sys_city` VALUES ('153', '16', '开封市', '475000', '0');
INSERT INTO `sys_city` VALUES ('154', '16', '洛阳市', '471000', '0');
INSERT INTO `sys_city` VALUES ('155', '16', '平顶山市', '467000', '0');
INSERT INTO `sys_city` VALUES ('156', '16', '安阳市', '454900', '0');
INSERT INTO `sys_city` VALUES ('157', '16', '鹤壁市', '456600', '0');
INSERT INTO `sys_city` VALUES ('158', '16', '新乡市', '453000', '0');
INSERT INTO `sys_city` VALUES ('159', '16', '焦作市', '454100', '0');
INSERT INTO `sys_city` VALUES ('160', '16', '濮阳市', '457000', '0');
INSERT INTO `sys_city` VALUES ('161', '16', '许昌市', '461000', '0');
INSERT INTO `sys_city` VALUES ('162', '16', '漯河市', '462000', '0');
INSERT INTO `sys_city` VALUES ('163', '16', '三门峡市', '472000', '0');
INSERT INTO `sys_city` VALUES ('164', '16', '南阳市', '473000', '0');
INSERT INTO `sys_city` VALUES ('165', '16', '商丘市', '476000', '0');
INSERT INTO `sys_city` VALUES ('166', '16', '信阳市', '464000', '0');
INSERT INTO `sys_city` VALUES ('167', '16', '周口市', '466000', '0');
INSERT INTO `sys_city` VALUES ('168', '16', '驻马店市', '463000', '0');
INSERT INTO `sys_city` VALUES ('169', '17', '武汉市', '430000', '0');
INSERT INTO `sys_city` VALUES ('170', '17', '黄石市', '435000', '0');
INSERT INTO `sys_city` VALUES ('171', '17', '十堰市', '442000', '0');
INSERT INTO `sys_city` VALUES ('172', '17', '宜昌市', '443000', '0');
INSERT INTO `sys_city` VALUES ('173', '17', '襄樊市', '441000', '0');
INSERT INTO `sys_city` VALUES ('174', '17', '鄂州市', '436000', '0');
INSERT INTO `sys_city` VALUES ('175', '17', '荆门市', '448000', '0');
INSERT INTO `sys_city` VALUES ('176', '17', '孝感市', '432100', '0');
INSERT INTO `sys_city` VALUES ('177', '17', '荆州市', '434000', '0');
INSERT INTO `sys_city` VALUES ('178', '17', '黄冈市', '438000', '0');
INSERT INTO `sys_city` VALUES ('179', '17', '咸宁市', '437000', '0');
INSERT INTO `sys_city` VALUES ('180', '17', '随州市', '441300', '0');
INSERT INTO `sys_city` VALUES ('181', '17', '恩施土家族苗族自治州', '445000', '0');
INSERT INTO `sys_city` VALUES ('182', '17', '神农架', '442400', '0');
INSERT INTO `sys_city` VALUES ('183', '18', '长沙市', '410000', '0');
INSERT INTO `sys_city` VALUES ('184', '18', '株洲市', '412000', '0');
INSERT INTO `sys_city` VALUES ('185', '18', '湘潭市', '411100', '0');
INSERT INTO `sys_city` VALUES ('186', '18', '衡阳市', '421000', '0');
INSERT INTO `sys_city` VALUES ('187', '18', '邵阳市', '422000', '0');
INSERT INTO `sys_city` VALUES ('188', '18', '岳阳市', '414000', '0');
INSERT INTO `sys_city` VALUES ('189', '18', '常德市', '415000', '0');
INSERT INTO `sys_city` VALUES ('190', '18', '张家界市', '427000', '0');
INSERT INTO `sys_city` VALUES ('191', '18', '益阳市', '413000', '0');
INSERT INTO `sys_city` VALUES ('192', '18', '郴州市', '423000', '0');
INSERT INTO `sys_city` VALUES ('193', '18', '永州市', '425000', '0');
INSERT INTO `sys_city` VALUES ('194', '18', '怀化市', '418000', '0');
INSERT INTO `sys_city` VALUES ('195', '18', '娄底市', '417000', '0');
INSERT INTO `sys_city` VALUES ('196', '18', '湘西土家族苗族自治州', '416000', '0');
INSERT INTO `sys_city` VALUES ('197', '19', '广州市', '510000', '0');
INSERT INTO `sys_city` VALUES ('198', '19', '韶关市', '521000', '0');
INSERT INTO `sys_city` VALUES ('199', '19', '深圳市', '518000', '0');
INSERT INTO `sys_city` VALUES ('200', '19', '珠海市', '519000', '0');
INSERT INTO `sys_city` VALUES ('201', '19', '汕头市', '515000', '0');
INSERT INTO `sys_city` VALUES ('202', '19', '佛山市', '528000', '0');
INSERT INTO `sys_city` VALUES ('203', '19', '江门市', '529000', '0');
INSERT INTO `sys_city` VALUES ('204', '19', '湛江市', '524000', '0');
INSERT INTO `sys_city` VALUES ('205', '19', '茂名市', '525000', '0');
INSERT INTO `sys_city` VALUES ('206', '19', '肇庆市', '526000', '0');
INSERT INTO `sys_city` VALUES ('207', '19', '惠州市', '516000', '0');
INSERT INTO `sys_city` VALUES ('208', '19', '梅州市', '514000', '0');
INSERT INTO `sys_city` VALUES ('209', '19', '汕尾市', '516600', '1');
INSERT INTO `sys_city` VALUES ('210', '19', '河源市', '517000', '0');
INSERT INTO `sys_city` VALUES ('211', '19', '阳江市', '529500', '0');
INSERT INTO `sys_city` VALUES ('212', '19', '清远市', '511500', '0');
INSERT INTO `sys_city` VALUES ('213', '19', '东莞市', '511700', '0');
INSERT INTO `sys_city` VALUES ('214', '19', '中山市', '528400', '0');
INSERT INTO `sys_city` VALUES ('215', '19', '潮州市', '515600', '0');
INSERT INTO `sys_city` VALUES ('216', '19', '揭阳市', '522000', '0');
INSERT INTO `sys_city` VALUES ('217', '19', '云浮市', '527300', '0');
INSERT INTO `sys_city` VALUES ('218', '20', '南宁市', '530000', '0');
INSERT INTO `sys_city` VALUES ('219', '20', '柳州市', '545000', '0');
INSERT INTO `sys_city` VALUES ('220', '20', '桂林市', '541000', '0');
INSERT INTO `sys_city` VALUES ('221', '20', '梧州市', '543000', '0');
INSERT INTO `sys_city` VALUES ('222', '20', '北海市', '536000', '0');
INSERT INTO `sys_city` VALUES ('223', '20', '防城港市', '538000', '0');
INSERT INTO `sys_city` VALUES ('224', '20', '钦州市', '535000', '0');
INSERT INTO `sys_city` VALUES ('225', '20', '贵港市', '537100', '0');
INSERT INTO `sys_city` VALUES ('226', '20', '玉林市', '537000', '0');
INSERT INTO `sys_city` VALUES ('227', '20', '百色市', '533000', '0');
INSERT INTO `sys_city` VALUES ('228', '20', '贺州市', '542800', '0');
INSERT INTO `sys_city` VALUES ('229', '20', '河池市', '547000', '0');
INSERT INTO `sys_city` VALUES ('230', '20', '来宾市', '546100', '0');
INSERT INTO `sys_city` VALUES ('231', '20', '崇左市', '532200', '0');
INSERT INTO `sys_city` VALUES ('232', '21', '海口市', '570000', '0');
INSERT INTO `sys_city` VALUES ('233', '21', '三亚市', '572000', '0');
INSERT INTO `sys_city` VALUES ('234', '22', '重庆市', '400000', '0');
INSERT INTO `sys_city` VALUES ('235', '23', '成都市', '610000', '0');
INSERT INTO `sys_city` VALUES ('236', '23', '自贡市', '643000', '0');
INSERT INTO `sys_city` VALUES ('237', '23', '攀枝花市', '617000', '0');
INSERT INTO `sys_city` VALUES ('238', '23', '泸州市', '646100', '0');
INSERT INTO `sys_city` VALUES ('239', '23', '德阳市', '618000', '0');
INSERT INTO `sys_city` VALUES ('240', '23', '绵阳市', '621000', '0');
INSERT INTO `sys_city` VALUES ('241', '23', '广元市', '628000', '0');
INSERT INTO `sys_city` VALUES ('242', '23', '遂宁市', '629000', '0');
INSERT INTO `sys_city` VALUES ('243', '23', '内江市', '641000', '0');
INSERT INTO `sys_city` VALUES ('244', '23', '乐山市', '614000', '0');
INSERT INTO `sys_city` VALUES ('245', '23', '南充市', '637000', '0');
INSERT INTO `sys_city` VALUES ('246', '23', '眉山市', '612100', '0');
INSERT INTO `sys_city` VALUES ('247', '23', '宜宾市', '644000', '0');
INSERT INTO `sys_city` VALUES ('248', '23', '广安市', '638000', '0');
INSERT INTO `sys_city` VALUES ('249', '23', '达州市', '635000', '0');
INSERT INTO `sys_city` VALUES ('250', '23', '雅安市', '625000', '0');
INSERT INTO `sys_city` VALUES ('251', '23', '巴中市', '635500', '0');
INSERT INTO `sys_city` VALUES ('252', '23', '资阳市', '641300', '0');
INSERT INTO `sys_city` VALUES ('253', '23', '阿坝藏族羌族自治州', '624600', '0');
INSERT INTO `sys_city` VALUES ('254', '23', '甘孜藏族自治州', '626000', '0');
INSERT INTO `sys_city` VALUES ('255', '23', '凉山彝族自治州', '615000', '0');
INSERT INTO `sys_city` VALUES ('256', '24', '贵阳市', '55000', '0');
INSERT INTO `sys_city` VALUES ('257', '24', '六盘水市', '553000', '0');
INSERT INTO `sys_city` VALUES ('258', '24', '遵义市', '563000', '0');
INSERT INTO `sys_city` VALUES ('259', '24', '安顺市', '561000', '0');
INSERT INTO `sys_city` VALUES ('260', '24', '铜仁地区', '554300', '0');
INSERT INTO `sys_city` VALUES ('261', '24', '黔西南布依族苗族自治州', '551500', '0');
INSERT INTO `sys_city` VALUES ('262', '24', '毕节地区', '551700', '0');
INSERT INTO `sys_city` VALUES ('263', '24', '黔东南苗族侗族自治州', '551500', '0');
INSERT INTO `sys_city` VALUES ('264', '24', '黔南布依族苗族自治州', '550100', '0');
INSERT INTO `sys_city` VALUES ('265', '25', '昆明市', '650000', '0');
INSERT INTO `sys_city` VALUES ('266', '25', '曲靖市', '655000', '0');
INSERT INTO `sys_city` VALUES ('267', '25', '玉溪市', '653100', '0');
INSERT INTO `sys_city` VALUES ('268', '25', '保山市', '678000', '0');
INSERT INTO `sys_city` VALUES ('269', '25', '昭通市', '657000', '0');
INSERT INTO `sys_city` VALUES ('270', '25', '丽江市', '674100', '0');
INSERT INTO `sys_city` VALUES ('271', '25', '思茅市', '665000', '0');
INSERT INTO `sys_city` VALUES ('272', '25', '临沧市', '677000', '0');
INSERT INTO `sys_city` VALUES ('273', '25', '楚雄彝族自治州', '675000', '0');
INSERT INTO `sys_city` VALUES ('274', '25', '红河哈尼族彝族自治州', '654400', '0');
INSERT INTO `sys_city` VALUES ('275', '25', '文山壮族苗族自治州', '663000', '0');
INSERT INTO `sys_city` VALUES ('276', '25', '西双版纳傣族自治州', '666200', '0');
INSERT INTO `sys_city` VALUES ('277', '25', '大理白族自治州', '671000', '0');
INSERT INTO `sys_city` VALUES ('278', '25', '德宏傣族景颇族自治州', '678400', '0');
INSERT INTO `sys_city` VALUES ('279', '25', '怒江傈僳族自治州', '671400', '0');
INSERT INTO `sys_city` VALUES ('280', '25', '迪庆藏族自治州', '674400', '0');
INSERT INTO `sys_city` VALUES ('281', '26', '拉萨市', '850000', '0');
INSERT INTO `sys_city` VALUES ('282', '26', '昌都地区', '854000', '0');
INSERT INTO `sys_city` VALUES ('283', '26', '山南地区', '856000', '0');
INSERT INTO `sys_city` VALUES ('284', '26', '日喀则地区', '857000', '0');
INSERT INTO `sys_city` VALUES ('285', '26', '那曲地区', '852000', '0');
INSERT INTO `sys_city` VALUES ('286', '26', '阿里地区', '859100', '0');
INSERT INTO `sys_city` VALUES ('287', '26', '林芝地区', '860100', '0');
INSERT INTO `sys_city` VALUES ('288', '27', '西安市', '710000', '0');
INSERT INTO `sys_city` VALUES ('289', '27', '铜川市', '727000', '0');
INSERT INTO `sys_city` VALUES ('290', '27', '宝鸡市', '721000', '0');
INSERT INTO `sys_city` VALUES ('291', '27', '咸阳市', '712000', '0');
INSERT INTO `sys_city` VALUES ('292', '27', '渭南市', '714000', '0');
INSERT INTO `sys_city` VALUES ('293', '27', '延安市', '716000', '0');
INSERT INTO `sys_city` VALUES ('294', '27', '汉中市', '723000', '0');
INSERT INTO `sys_city` VALUES ('295', '27', '榆林市', '719000', '0');
INSERT INTO `sys_city` VALUES ('296', '27', '安康市', '725000', '0');
INSERT INTO `sys_city` VALUES ('297', '27', '商洛市', '711500', '0');
INSERT INTO `sys_city` VALUES ('298', '28', '兰州市', '730000', '0');
INSERT INTO `sys_city` VALUES ('299', '28', '嘉峪关市', '735100', '0');
INSERT INTO `sys_city` VALUES ('300', '28', '金昌市', '737100', '0');
INSERT INTO `sys_city` VALUES ('301', '28', '白银市', '730900', '0');
INSERT INTO `sys_city` VALUES ('302', '28', '天水市', '741000', '0');
INSERT INTO `sys_city` VALUES ('303', '28', '武威市', '733000', '0');
INSERT INTO `sys_city` VALUES ('304', '28', '张掖市', '734000', '0');
INSERT INTO `sys_city` VALUES ('305', '28', '平凉市', '744000', '0');
INSERT INTO `sys_city` VALUES ('306', '28', '酒泉市', '735000', '0');
INSERT INTO `sys_city` VALUES ('307', '28', '庆阳市', '744500', '0');
INSERT INTO `sys_city` VALUES ('308', '28', '定西市', '743000', '0');
INSERT INTO `sys_city` VALUES ('309', '28', '陇南市', '742100', '0');
INSERT INTO `sys_city` VALUES ('310', '28', '临夏回族自治州', '731100', '0');
INSERT INTO `sys_city` VALUES ('311', '28', '甘南藏族自治州', '747000', '0');
INSERT INTO `sys_city` VALUES ('312', '29', '西宁市', '810000', '0');
INSERT INTO `sys_city` VALUES ('313', '29', '海东地区', '810600', '0');
INSERT INTO `sys_city` VALUES ('314', '29', '海北藏族自治州', '810300', '0');
INSERT INTO `sys_city` VALUES ('315', '29', '黄南藏族自治州', '811300', '0');
INSERT INTO `sys_city` VALUES ('316', '29', '海南藏族自治州', '813000', '0');
INSERT INTO `sys_city` VALUES ('317', '29', '果洛藏族自治州', '814000', '0');
INSERT INTO `sys_city` VALUES ('318', '29', '玉树藏族自治州', '815000', '0');
INSERT INTO `sys_city` VALUES ('319', '29', '海西蒙古族藏族自治州', '817000', '0');
INSERT INTO `sys_city` VALUES ('320', '30', '银川市', '750000', '0');
INSERT INTO `sys_city` VALUES ('321', '30', '石嘴山市', '753000', '0');
INSERT INTO `sys_city` VALUES ('322', '30', '吴忠市', '751100', '0');
INSERT INTO `sys_city` VALUES ('323', '30', '固原市', '756000', '0');
INSERT INTO `sys_city` VALUES ('324', '30', '中卫市', '751700', '0');
INSERT INTO `sys_city` VALUES ('325', '31', '乌鲁木齐市', '830000', '0');
INSERT INTO `sys_city` VALUES ('326', '31', '克拉玛依市', '834000', '0');
INSERT INTO `sys_city` VALUES ('327', '31', '吐鲁番地区', '838000', '0');
INSERT INTO `sys_city` VALUES ('328', '31', '哈密地区', '839000', '0');
INSERT INTO `sys_city` VALUES ('329', '31', '昌吉回族自治州', '831100', '0');
INSERT INTO `sys_city` VALUES ('330', '31', '博尔塔拉蒙古自治州', '833400', '0');
INSERT INTO `sys_city` VALUES ('331', '31', '巴音郭楞蒙古自治州', '841000', '0');
INSERT INTO `sys_city` VALUES ('332', '31', '阿克苏地区', '843000', '0');
INSERT INTO `sys_city` VALUES ('333', '31', '克孜勒苏柯尔克孜自治州', '835600', '0');
INSERT INTO `sys_city` VALUES ('334', '31', '喀什地区', '844000', '0');
INSERT INTO `sys_city` VALUES ('335', '31', '和田地区', '848000', '0');
INSERT INTO `sys_city` VALUES ('336', '31', '伊犁哈萨克自治州', '833200', '0');
INSERT INTO `sys_city` VALUES ('337', '31', '塔城地区', '834700', '0');
INSERT INTO `sys_city` VALUES ('338', '31', '阿勒泰地区', '836500', '0');
INSERT INTO `sys_city` VALUES ('339', '31', '石河子市', '832000', '0');
INSERT INTO `sys_city` VALUES ('340', '31', '阿拉尔市', '843300', '0');
INSERT INTO `sys_city` VALUES ('341', '31', '图木舒克市', '843900', '0');
INSERT INTO `sys_city` VALUES ('342', '31', '五家渠市', '831300', '0');
INSERT INTO `sys_city` VALUES ('343', '32', '香港特别行政区', '000000', '0');
INSERT INTO `sys_city` VALUES ('344', '33', '澳门特别行政区', '000000', '0');
INSERT INTO `sys_city` VALUES ('345', '34', '台湾省', '000000', '0');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `instance_id` int(11) NOT NULL DEFAULT '1' COMMENT '实例ID',
  `key` varchar(255) NOT NULL DEFAULT '' COMMENT '配置项WCHAT,QQ,WPAY,ALIPAY...',
  `value` varchar(1000) NOT NULL DEFAULT '' COMMENT '配置值json',
  `desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '描述',
  `is_use` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否启用 1启用 0不启用',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=963 COMMENT='第三方配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('12', '0', 'USERNOTICE', '', '', '1', '1487830081', '1497102938');
INSERT INTO `sys_config` VALUES ('13', '0', 'HOTKEY', '[]', '', '1', '1487831749', '1546597111');
INSERT INTO `sys_config` VALUES ('14', '0', 'DEFAULTKEY', '\"\"', '', '1', '1487831788', '1546597132');
INSERT INTO `sys_config` VALUES ('17', '0', 'QQLOGIN', '{\"APP_KEY\":\"\",\"APP_SECRET\":\"\",\"AUTHORIZE\":\"http:\\/\\/b2c1.01.niushop.com.cn\",\"CALLBACK\":\"http:\\/\\/b2c1.01.niushop.com.cn\\/wap\\/login\\/callback\"}', 'qq', '0', '1488350925', '1544070682');
INSERT INTO `sys_config` VALUES ('18', '0', 'WCHAT', '{\"APP_KEY\":\"\",\"APP_SECRET\":\"\",\"AUTHORIZE\":\"http:\\/\\/b2c1.01.niushop.com.cn\",\"CALLBACK\":\"http:\\/\\/b2c1.01.niushop.com.cn\\/wap\\/Login\\/callback\"}', '微信', '0', '1488350947', '1544070680');
INSERT INTO `sys_config` VALUES ('21', '0', 'ALIPAY', '{\"ali_partnerid\":\"2088521599430134\",\"ali_seller\":\"zhaixiaoxue@smart-art.com.cn\",\"ali_key\":\"vd7yp60sa64y67x48psu9xpznvv6zmf8\"}', '', '1', '1488442697', '1550024656');
INSERT INTO `sys_config` VALUES ('22', '0', 'EMAILMESSAGE', '{\"email_host\":\"smtp.163.com\",\"email_port\":\"465\",\"email_addr\":\"\",\"email_id\":\"\",\"email_pass\":\"\",\"email_is_security\":\"false\"}', '', '0', '1488524450', '1548731218');
INSERT INTO `sys_config` VALUES ('125', '0', 'WPAY', '{\"appid\":\"wx6da31c992e716fbe\",\"appkey\":\"8a85ad205aa4e29c71d59e2fd3c6f441\",\"mch_id\":\"1429847302\",\"mch_key\":\"smartart123456artsmartwuzhiwuzhi\"}', '', '1', '1497087123', '1548728144');
INSERT INTO `sys_config` VALUES ('127', '0', 'SHOPWCHAT', '{\"appid\":\"\",\"appsecret\":\"\"}', '', '1', '1497088090', '1498736290');
INSERT INTO `sys_config` VALUES ('137', '0', 'REGISTERANDVISIT', '{\"is_register\":\"1\",\"register_info\":\"plain\",\"name_keyword\":\"admin\",\"pwd_len\":\"6\",\"pwd_complexity\":\"number,letter\",\"is_requiretel\":\"0\",\"terms_of_service\":\"\"}', '', '1', '1499310581', '1546569094');
INSERT INTO `sys_config` VALUES ('138', '0', 'SERVICE_ADDR', '{\"service_addr\":\"https:\\/\\/e-137010.chatnow.meiqia.com\\/dist\\/standalone.html\"}', '美洽客服链接地址', '0', '1542638209', '1546594322');
INSERT INTO `sys_config` VALUES ('144', '0', 'USE_PC_TEMPLATE', 'blue', '当前使用的PC端模板文件夹', '1', '1544169488', '1544169488');
INSERT INTO `sys_config` VALUES ('146', '0', 'UPLOAD_TYPE', '1', '上传方式 1 本地  2 七牛', '1', '1543476260', '0');
INSERT INTO `sys_config` VALUES ('147', '0', 'QINIU_CONFIG', '{\"Accesskey\":\"\",\"Secretkey\":\"\",\"Bucket\":\"\",\"QiniuUrl\":\"\"}', '七牛云存储参数配置', '1', '1543476260', '0');
INSERT INTO `sys_config` VALUES ('153', '0', 'X360', '{\"host\":\"smtjy\",\"apikey\":\"XUSHUQING_API_KEY\"}', '校360配置', '1', '1543904241', '1544062144');
INSERT INTO `sys_config` VALUES ('154', '0', 'UI', '{\"icon\":\"upload\\/common\\/1544153672.ico\",\"logo\":\"upload\\/common\\/1544001940.png\",\"banner\":\"upload\\/common\\/1544068552.png\",\"reg\":\"upload\\/common\\/1544152017.png\",\"member\":\"upload\\/common\\/1544078973.png\",\"pclogin\":\"upload\\/common\\/1544235759.png\",\"pcreg\":\"upload\\/common\\/1544235767.png\",\"adminlogin\":\"upload\\/common\\/1544235774.png\",\"adminlogo\":\"upload\\/common\\/1544235778.png\"}', '界面配置', '1', '1543914069', '1544235780');
INSERT INTO `sys_config` VALUES ('155', '0', 'COPYRIGHT', '{\"copyright_logo\":\"upload\\/common\\/1544061902.png\",\"copyright_link\":\"http:\\/\\/www.smtjy.com\",\"copyright_desc\":\"pro.x360 \\u00a9 2017 Powered by Lantel\",\"copyright_companyname\":\"\\u65af\\u739b\\u7279\\u52a0\\u76df\\u5546\\u7535\\u5546\\u7cfb\\u7edf\",\"bot\":\"upload\\/common\\/1544068296.png\"}', '版权配置', '1', '1543917863', '1544068297');
INSERT INTO `sys_config` VALUES ('169', '0', 'IMG_THUMB', '{\"thumb_type\":\"3\",\"upload_size\":\"0\",\"upload_ext\":\"gif,jpg,jpeg,bmp,png\"}', 'thumb_type(缩略)  3 居中裁剪 2 缩放后填充 4 左上角裁剪 5 右下角裁剪 6 固定尺寸缩放', '1', '1543998613', '0');
INSERT INTO `sys_config` VALUES ('170', '0', 'REGISTER_INTEGRAL', '0', '注册送积分', '1', '1544001195', '1546592294');
INSERT INTO `sys_config` VALUES ('171', '0', 'SIGN_INTEGRAL', '0', '签到送积分', '1', '1544001195', '1546592294');
INSERT INTO `sys_config` VALUES ('172', '0', 'SHARE_INTEGRAL', '0', '分享送积分', '1', '1544001195', '1546592294');
INSERT INTO `sys_config` VALUES ('174', '0', 'USE_WAP_TEMPLATE', 'default', '当前使用的手机端模板文件夹', '1', '1544091455', '1544091465');
INSERT INTO `sys_config` VALUES ('175', '0', 'IS_RECOMMEND', '{\"is_recommend\":\"\"}', '首页商城促销版块显示设置', '0', '1544091455', '0');
INSERT INTO `sys_config` VALUES ('176', '0', 'IS_CATEGORY', '{\"is_category\":\"\"}', '首页商品分类是否显示设置', '0', '1544091455', '0');
INSERT INTO `sys_config` VALUES ('177', '0', 'ORDER_AUTO_DELIVERY', '14', '订单多长时间自动完成', '1', '1544093555', '1544168959');
INSERT INTO `sys_config` VALUES ('178', '0', 'ORDER_BALANCE_PAY', '0', '是否开启余额支付', '1', '1544093555', '1544168959');
INSERT INTO `sys_config` VALUES ('179', '0', 'ORDER_DELIVERY_COMPLETE_TIME', '0', '收货后多长时间自动完成', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('180', '0', 'ORDER_SHOW_BUY_RECORD', '1', '是否显示购买记录', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('181', '0', 'ORDER_INVOICE_TAX', '0', '发票税率', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('182', '0', 'ORDER_INVOICE_CONTENT', '', '发票内容', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('183', '0', 'ORDER_DELIVERY_PAY', '0', '是否开启货到付款', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('184', '0', 'ORDER_BUY_CLOSE_TIME', '3600', '订单自动关闭时间', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('185', '0', 'BUYER_SELF_LIFTING', '0', '是否开启买家自提', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('186', '0', 'ORDER_SELLER_DISPATCHING', '1', '是否开启商家配送', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('187', '0', 'ORDER_IS_LOGISTICS', '1', '是否允许选择物流', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('188', '0', 'SHOPPING_BACK_POINTS', '1', '购物返积分设置', '1', '1544093555', '1544168960');
INSERT INTO `sys_config` VALUES ('189', '0', 'WITHDRAW_BALANCE', '{\"withdraw_cash_min\":0,\"withdraw_multiple\":0,\"withdraw_poundage\":0,\"withdraw_message\":\"\"}', '会员余额提现设置', '0', '1544093867', '0');
INSERT INTO `sys_config` VALUES ('190', '0', 'SEO_TITLE', '斯玛特加盟商电商平台', '标题附加字', '1', '1544146299', '1544146390');
INSERT INTO `sys_config` VALUES ('191', '0', 'SEO_META', '斯玛特加盟商电商平台', '商城关键词', '1', '1544146299', '1544146390');
INSERT INTO `sys_config` VALUES ('192', '0', 'SEO_DESC', '斯玛特加盟商电商平台', '关键词描述', '1', '1544146299', '1544146390');
INSERT INTO `sys_config` VALUES ('193', '0', 'SEO_OTHER', '斯玛特加盟商电商平台', '其他页头信息', '1', '1544146299', '1544146390');
INSERT INTO `sys_config` VALUES ('194', '0', 'LOGINVERIFYCODE', '{\"platform\":0,\"admin\":\"0\",\"pc\":\"1\"}', '', '1', '1544146757', '1544146852');
INSERT INTO `sys_config` VALUES ('195', '0', 'ORDER_EXPRESS_MESSAGE', '{\"appid\":\"XUSHUIQNG_APP_ID\",\"appkey\":\"XUSHUIQNG_APP_KEY\",\"back_url\":\"http:\\/\\/www.baidu.com\"}', '物流跟踪配置信息', '0', '1544147038', '1544147101');
INSERT INTO `sys_config` VALUES ('196', '0', 'ORIGINAL_ROAD_REFUND_SETTING_WECHAT', '{\"is_use\":1,\"apiclient_cert\":\"/www/wwwroot/nshop.xiao360.com/data/extend/weixin/cert/apiclient_cert.pem\",\"apiclient_key\":\"/www/wwwroot/nshop.xiao360.com/data/extend/weixin/cert/apiclient_key.pem\"}', '', '1', '1547707986', '1550026085');
INSERT INTO `sys_config` VALUES ('197', '0', 'ORIGINAL_ROAD_REFUND_SETTING_ALIPAY', '{\"is_use\":1}', '', '1', '1550025310', '1550025314');

-- ----------------------------
-- Table structure for sys_custom_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_custom_template`;
CREATE TABLE `sys_custom_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `template_name` varchar(250) DEFAULT NULL COMMENT '自定义模板名称（暂时预留）',
  `template_data` text NOT NULL COMMENT '模板数据（JSON格式）',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间戳',
  `modify_time` int(11) DEFAULT NULL COMMENT '修改时间戳',
  `is_enable` int(11) NOT NULL DEFAULT '0' COMMENT '是否启用 0 不启用 1 启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='手机端自定义模板';

-- ----------------------------
-- Records of sys_custom_template
-- ----------------------------

-- ----------------------------
-- Table structure for sys_district
-- ----------------------------
DROP TABLE IF EXISTS `sys_district`;
CREATE TABLE `sys_district` (
  `district_id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) DEFAULT '0',
  `district_name` varchar(255) NOT NULL DEFAULT '',
  `sort` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`district_id`),
  KEY `IDX_g_district_DistrictName` (`district_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2870 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=50;

-- ----------------------------
-- Records of sys_district
-- ----------------------------
INSERT INTO `sys_district` VALUES ('1', '1', '东城区', '0');
INSERT INTO `sys_district` VALUES ('2', '1', '西城区', '0');
INSERT INTO `sys_district` VALUES ('3', '1', '崇文区', '0');
INSERT INTO `sys_district` VALUES ('4', '1', '宣武区', '0');
INSERT INTO `sys_district` VALUES ('5', '1', '朝阳区', '0');
INSERT INTO `sys_district` VALUES ('6', '1', '丰台区', '0');
INSERT INTO `sys_district` VALUES ('7', '1', '石景山区', '0');
INSERT INTO `sys_district` VALUES ('8', '1', '海淀区', '0');
INSERT INTO `sys_district` VALUES ('9', '1', '门头沟区', '0');
INSERT INTO `sys_district` VALUES ('10', '1', '房山区', '0');
INSERT INTO `sys_district` VALUES ('11', '1', '通州区', '0');
INSERT INTO `sys_district` VALUES ('12', '1', '顺义区', '0');
INSERT INTO `sys_district` VALUES ('13', '1', '昌平区', '0');
INSERT INTO `sys_district` VALUES ('14', '1', '大兴区', '0');
INSERT INTO `sys_district` VALUES ('15', '1', '怀柔区', '0');
INSERT INTO `sys_district` VALUES ('16', '1', '平谷区', '0');
INSERT INTO `sys_district` VALUES ('17', '1', '密云县', '0');
INSERT INTO `sys_district` VALUES ('18', '1', '延庆县', '0');
INSERT INTO `sys_district` VALUES ('19', '2', '和平区', '0');
INSERT INTO `sys_district` VALUES ('20', '2', '河东区', '0');
INSERT INTO `sys_district` VALUES ('21', '2', '河西区', '0');
INSERT INTO `sys_district` VALUES ('22', '2', '南开区', '0');
INSERT INTO `sys_district` VALUES ('23', '2', '河北区', '0');
INSERT INTO `sys_district` VALUES ('24', '2', '红桥区', '0');
INSERT INTO `sys_district` VALUES ('25', '2', '塘沽区', '0');
INSERT INTO `sys_district` VALUES ('26', '2', '汉沽区', '0');
INSERT INTO `sys_district` VALUES ('27', '2', '大港区', '0');
INSERT INTO `sys_district` VALUES ('28', '2', '东丽区', '0');
INSERT INTO `sys_district` VALUES ('29', '2', '西青区', '0');
INSERT INTO `sys_district` VALUES ('30', '2', '津南区', '0');
INSERT INTO `sys_district` VALUES ('31', '2', '北辰区', '0');
INSERT INTO `sys_district` VALUES ('32', '2', '武清区', '0');
INSERT INTO `sys_district` VALUES ('33', '2', '宝坻区', '0');
INSERT INTO `sys_district` VALUES ('34', '2', '宁河县', '0');
INSERT INTO `sys_district` VALUES ('35', '2', '静海县', '0');
INSERT INTO `sys_district` VALUES ('36', '2', '蓟县', '0');
INSERT INTO `sys_district` VALUES ('37', '3', '长安区', '0');
INSERT INTO `sys_district` VALUES ('38', '3', '桥东区', '0');
INSERT INTO `sys_district` VALUES ('39', '3', '桥西区', '0');
INSERT INTO `sys_district` VALUES ('40', '3', '新华区', '0');
INSERT INTO `sys_district` VALUES ('41', '3', '井陉矿区', '0');
INSERT INTO `sys_district` VALUES ('42', '3', '裕华区', '0');
INSERT INTO `sys_district` VALUES ('43', '3', '井陉县', '0');
INSERT INTO `sys_district` VALUES ('44', '3', '正定县', '0');
INSERT INTO `sys_district` VALUES ('45', '3', '栾城县', '0');
INSERT INTO `sys_district` VALUES ('46', '3', '行唐县', '0');
INSERT INTO `sys_district` VALUES ('47', '3', '灵寿县', '0');
INSERT INTO `sys_district` VALUES ('48', '3', '高邑县', '0');
INSERT INTO `sys_district` VALUES ('49', '3', '深泽县', '0');
INSERT INTO `sys_district` VALUES ('50', '3', '赞皇县', '0');
INSERT INTO `sys_district` VALUES ('51', '3', '无极县', '0');
INSERT INTO `sys_district` VALUES ('52', '3', '平山县', '0');
INSERT INTO `sys_district` VALUES ('53', '3', '元氏县', '0');
INSERT INTO `sys_district` VALUES ('54', '3', '赵县', '0');
INSERT INTO `sys_district` VALUES ('55', '3', '辛集市', '0');
INSERT INTO `sys_district` VALUES ('56', '3', '藁城市', '0');
INSERT INTO `sys_district` VALUES ('57', '3', '晋州市', '0');
INSERT INTO `sys_district` VALUES ('58', '3', '新乐市', '0');
INSERT INTO `sys_district` VALUES ('59', '3', '鹿泉市', '0');
INSERT INTO `sys_district` VALUES ('60', '4', '路南区', '0');
INSERT INTO `sys_district` VALUES ('61', '4', '路北区', '0');
INSERT INTO `sys_district` VALUES ('62', '4', '古冶区', '0');
INSERT INTO `sys_district` VALUES ('63', '4', '开平区', '0');
INSERT INTO `sys_district` VALUES ('64', '4', '丰南区', '0');
INSERT INTO `sys_district` VALUES ('65', '4', '丰润区', '0');
INSERT INTO `sys_district` VALUES ('66', '4', '滦县', '0');
INSERT INTO `sys_district` VALUES ('67', '4', '滦南县', '0');
INSERT INTO `sys_district` VALUES ('68', '4', '乐亭县', '0');
INSERT INTO `sys_district` VALUES ('69', '4', '迁西县', '0');
INSERT INTO `sys_district` VALUES ('70', '4', '玉田县', '0');
INSERT INTO `sys_district` VALUES ('71', '4', '唐海县', '0');
INSERT INTO `sys_district` VALUES ('72', '4', '遵化市', '0');
INSERT INTO `sys_district` VALUES ('73', '4', '迁安市', '0');
INSERT INTO `sys_district` VALUES ('74', '5', '海港区', '0');
INSERT INTO `sys_district` VALUES ('75', '5', '山海关区', '0');
INSERT INTO `sys_district` VALUES ('76', '5', '北戴河区', '0');
INSERT INTO `sys_district` VALUES ('77', '5', '青龙满族自治县', '0');
INSERT INTO `sys_district` VALUES ('78', '5', '昌黎县', '0');
INSERT INTO `sys_district` VALUES ('79', '5', '抚宁县', '0');
INSERT INTO `sys_district` VALUES ('80', '5', '卢龙县', '0');
INSERT INTO `sys_district` VALUES ('81', '6', '邯山区', '0');
INSERT INTO `sys_district` VALUES ('82', '6', '丛台区', '0');
INSERT INTO `sys_district` VALUES ('83', '6', '复兴区', '0');
INSERT INTO `sys_district` VALUES ('84', '6', '峰峰矿区', '0');
INSERT INTO `sys_district` VALUES ('85', '6', '邯郸县', '0');
INSERT INTO `sys_district` VALUES ('86', '6', '临漳县', '0');
INSERT INTO `sys_district` VALUES ('87', '6', '成安县', '0');
INSERT INTO `sys_district` VALUES ('88', '6', '大名县', '0');
INSERT INTO `sys_district` VALUES ('89', '6', '涉县', '0');
INSERT INTO `sys_district` VALUES ('90', '6', '磁县', '0');
INSERT INTO `sys_district` VALUES ('91', '6', '肥乡县', '0');
INSERT INTO `sys_district` VALUES ('92', '6', '永年县', '0');
INSERT INTO `sys_district` VALUES ('93', '6', '邱县', '0');
INSERT INTO `sys_district` VALUES ('94', '6', '鸡泽县', '0');
INSERT INTO `sys_district` VALUES ('95', '6', '广平县', '0');
INSERT INTO `sys_district` VALUES ('96', '6', '馆陶县', '0');
INSERT INTO `sys_district` VALUES ('97', '6', '魏县', '0');
INSERT INTO `sys_district` VALUES ('98', '6', '曲周县', '0');
INSERT INTO `sys_district` VALUES ('99', '6', '武安市', '0');
INSERT INTO `sys_district` VALUES ('100', '7', '桥东区', '0');
INSERT INTO `sys_district` VALUES ('101', '7', '桥西区', '0');
INSERT INTO `sys_district` VALUES ('102', '7', '邢台县', '0');
INSERT INTO `sys_district` VALUES ('103', '7', '临城县', '0');
INSERT INTO `sys_district` VALUES ('104', '7', '内丘县', '0');
INSERT INTO `sys_district` VALUES ('105', '7', '柏乡县', '0');
INSERT INTO `sys_district` VALUES ('106', '7', '隆尧县', '0');
INSERT INTO `sys_district` VALUES ('107', '7', '任县', '0');
INSERT INTO `sys_district` VALUES ('108', '7', '南和县', '0');
INSERT INTO `sys_district` VALUES ('109', '7', '宁晋县', '0');
INSERT INTO `sys_district` VALUES ('110', '7', '巨鹿县', '0');
INSERT INTO `sys_district` VALUES ('111', '7', '新河县', '0');
INSERT INTO `sys_district` VALUES ('112', '7', '广宗县', '0');
INSERT INTO `sys_district` VALUES ('113', '7', '平乡县', '0');
INSERT INTO `sys_district` VALUES ('114', '7', '威县', '0');
INSERT INTO `sys_district` VALUES ('115', '7', '清河县', '0');
INSERT INTO `sys_district` VALUES ('116', '7', '临西县', '0');
INSERT INTO `sys_district` VALUES ('117', '7', '南宫市', '0');
INSERT INTO `sys_district` VALUES ('118', '7', '沙河市', '0');
INSERT INTO `sys_district` VALUES ('119', '8', '新市区', '0');
INSERT INTO `sys_district` VALUES ('120', '8', '北市区', '0');
INSERT INTO `sys_district` VALUES ('121', '8', '南市区', '0');
INSERT INTO `sys_district` VALUES ('122', '8', '满城县', '0');
INSERT INTO `sys_district` VALUES ('123', '8', '清苑县', '0');
INSERT INTO `sys_district` VALUES ('124', '8', '涞水县', '0');
INSERT INTO `sys_district` VALUES ('125', '8', '阜平县', '0');
INSERT INTO `sys_district` VALUES ('126', '8', '徐水县', '0');
INSERT INTO `sys_district` VALUES ('127', '8', '定兴县', '0');
INSERT INTO `sys_district` VALUES ('128', '8', '唐县', '0');
INSERT INTO `sys_district` VALUES ('129', '8', '高阳县', '0');
INSERT INTO `sys_district` VALUES ('130', '8', '容城县', '0');
INSERT INTO `sys_district` VALUES ('131', '8', '涞源县', '0');
INSERT INTO `sys_district` VALUES ('132', '8', '望都县', '0');
INSERT INTO `sys_district` VALUES ('133', '8', '安新县', '0');
INSERT INTO `sys_district` VALUES ('134', '8', '易县', '0');
INSERT INTO `sys_district` VALUES ('135', '8', '曲阳县', '0');
INSERT INTO `sys_district` VALUES ('136', '8', '蠡县', '0');
INSERT INTO `sys_district` VALUES ('137', '8', '顺平县', '0');
INSERT INTO `sys_district` VALUES ('138', '8', '博野县', '0');
INSERT INTO `sys_district` VALUES ('139', '8', '雄县', '0');
INSERT INTO `sys_district` VALUES ('140', '8', '涿州市', '0');
INSERT INTO `sys_district` VALUES ('141', '8', '定州市', '0');
INSERT INTO `sys_district` VALUES ('142', '8', '安国市', '0');
INSERT INTO `sys_district` VALUES ('143', '8', '高碑店市', '0');
INSERT INTO `sys_district` VALUES ('144', '9', '桥东区', '0');
INSERT INTO `sys_district` VALUES ('145', '9', '桥西区', '0');
INSERT INTO `sys_district` VALUES ('146', '9', '宣化区', '0');
INSERT INTO `sys_district` VALUES ('147', '9', '下花园区', '0');
INSERT INTO `sys_district` VALUES ('148', '9', '宣化县', '0');
INSERT INTO `sys_district` VALUES ('149', '9', '张北县', '0');
INSERT INTO `sys_district` VALUES ('150', '9', '康保县', '0');
INSERT INTO `sys_district` VALUES ('151', '9', '沽源县', '0');
INSERT INTO `sys_district` VALUES ('152', '9', '尚义县', '0');
INSERT INTO `sys_district` VALUES ('153', '9', '蔚县', '0');
INSERT INTO `sys_district` VALUES ('154', '9', '阳原县', '0');
INSERT INTO `sys_district` VALUES ('155', '9', '怀安县', '0');
INSERT INTO `sys_district` VALUES ('156', '9', '万全县', '0');
INSERT INTO `sys_district` VALUES ('157', '9', '怀来县', '0');
INSERT INTO `sys_district` VALUES ('158', '9', '涿鹿县', '0');
INSERT INTO `sys_district` VALUES ('159', '9', '赤城县', '0');
INSERT INTO `sys_district` VALUES ('160', '9', '崇礼县', '0');
INSERT INTO `sys_district` VALUES ('161', '10', '双桥区', '0');
INSERT INTO `sys_district` VALUES ('162', '10', '双滦区', '0');
INSERT INTO `sys_district` VALUES ('163', '10', '鹰手营子矿区', '0');
INSERT INTO `sys_district` VALUES ('164', '10', '承德县', '0');
INSERT INTO `sys_district` VALUES ('165', '10', '兴隆县', '0');
INSERT INTO `sys_district` VALUES ('166', '10', '平泉县', '0');
INSERT INTO `sys_district` VALUES ('167', '10', '滦平县', '0');
INSERT INTO `sys_district` VALUES ('168', '10', '隆化县', '0');
INSERT INTO `sys_district` VALUES ('169', '10', '丰宁满族自治县', '0');
INSERT INTO `sys_district` VALUES ('170', '10', '宽城满族自治县', '0');
INSERT INTO `sys_district` VALUES ('171', '10', '围场满族蒙古族自治县', '0');
INSERT INTO `sys_district` VALUES ('172', '11', '新华区', '0');
INSERT INTO `sys_district` VALUES ('173', '11', '运河区', '0');
INSERT INTO `sys_district` VALUES ('174', '11', '沧县', '0');
INSERT INTO `sys_district` VALUES ('175', '11', '青县', '0');
INSERT INTO `sys_district` VALUES ('176', '11', '东光县', '0');
INSERT INTO `sys_district` VALUES ('177', '11', '海兴县', '0');
INSERT INTO `sys_district` VALUES ('178', '11', '盐山县', '0');
INSERT INTO `sys_district` VALUES ('179', '11', '肃宁县', '0');
INSERT INTO `sys_district` VALUES ('180', '11', '南皮县', '0');
INSERT INTO `sys_district` VALUES ('181', '11', '吴桥县', '0');
INSERT INTO `sys_district` VALUES ('182', '11', '献县', '0');
INSERT INTO `sys_district` VALUES ('183', '11', '孟村回族自治县', '0');
INSERT INTO `sys_district` VALUES ('184', '11', '泊头市', '0');
INSERT INTO `sys_district` VALUES ('185', '11', '任丘市', '0');
INSERT INTO `sys_district` VALUES ('186', '11', '黄骅市', '0');
INSERT INTO `sys_district` VALUES ('187', '11', '河间市', '0');
INSERT INTO `sys_district` VALUES ('188', '12', '安次区', '0');
INSERT INTO `sys_district` VALUES ('189', '12', '广阳区', '0');
INSERT INTO `sys_district` VALUES ('190', '12', '固安县', '0');
INSERT INTO `sys_district` VALUES ('191', '12', '永清县', '0');
INSERT INTO `sys_district` VALUES ('192', '12', '香河县', '0');
INSERT INTO `sys_district` VALUES ('193', '12', '大城县', '0');
INSERT INTO `sys_district` VALUES ('194', '12', '文安县', '0');
INSERT INTO `sys_district` VALUES ('195', '12', '大厂回族自治县', '0');
INSERT INTO `sys_district` VALUES ('196', '12', '霸州市', '0');
INSERT INTO `sys_district` VALUES ('197', '12', '三河市', '0');
INSERT INTO `sys_district` VALUES ('198', '13', '桃城区', '0');
INSERT INTO `sys_district` VALUES ('199', '13', '枣强县', '0');
INSERT INTO `sys_district` VALUES ('200', '13', '武邑县', '0');
INSERT INTO `sys_district` VALUES ('201', '13', '武强县', '0');
INSERT INTO `sys_district` VALUES ('202', '13', '饶阳县', '0');
INSERT INTO `sys_district` VALUES ('203', '13', '安平县', '0');
INSERT INTO `sys_district` VALUES ('204', '13', '故城县', '0');
INSERT INTO `sys_district` VALUES ('205', '13', '景县', '0');
INSERT INTO `sys_district` VALUES ('206', '13', '阜城县', '0');
INSERT INTO `sys_district` VALUES ('207', '13', '冀州市', '0');
INSERT INTO `sys_district` VALUES ('208', '13', '深州市', '0');
INSERT INTO `sys_district` VALUES ('209', '14', '小店区', '0');
INSERT INTO `sys_district` VALUES ('210', '14', '迎泽区', '0');
INSERT INTO `sys_district` VALUES ('211', '14', '杏花岭区', '0');
INSERT INTO `sys_district` VALUES ('212', '14', '尖草坪区', '0');
INSERT INTO `sys_district` VALUES ('213', '14', '万柏林区', '0');
INSERT INTO `sys_district` VALUES ('214', '14', '晋源区', '0');
INSERT INTO `sys_district` VALUES ('215', '14', '清徐县', '0');
INSERT INTO `sys_district` VALUES ('216', '14', '阳曲县', '0');
INSERT INTO `sys_district` VALUES ('217', '14', '娄烦县', '0');
INSERT INTO `sys_district` VALUES ('218', '14', '古交市', '0');
INSERT INTO `sys_district` VALUES ('219', '15', '城区', '0');
INSERT INTO `sys_district` VALUES ('220', '15', '矿区', '0');
INSERT INTO `sys_district` VALUES ('221', '15', '南郊区', '0');
INSERT INTO `sys_district` VALUES ('222', '15', '新荣区', '0');
INSERT INTO `sys_district` VALUES ('223', '15', '阳高县', '0');
INSERT INTO `sys_district` VALUES ('224', '15', '天镇县', '0');
INSERT INTO `sys_district` VALUES ('225', '15', '广灵县', '0');
INSERT INTO `sys_district` VALUES ('226', '15', '灵丘县', '0');
INSERT INTO `sys_district` VALUES ('227', '15', '浑源县', '0');
INSERT INTO `sys_district` VALUES ('228', '15', '左云县', '0');
INSERT INTO `sys_district` VALUES ('229', '15', '大同县', '0');
INSERT INTO `sys_district` VALUES ('230', '16', '城区', '0');
INSERT INTO `sys_district` VALUES ('231', '16', '矿区', '0');
INSERT INTO `sys_district` VALUES ('232', '16', '郊区', '0');
INSERT INTO `sys_district` VALUES ('233', '16', '平定县', '0');
INSERT INTO `sys_district` VALUES ('234', '16', '盂县', '0');
INSERT INTO `sys_district` VALUES ('235', '17', '城区', '0');
INSERT INTO `sys_district` VALUES ('236', '17', '郊区', '0');
INSERT INTO `sys_district` VALUES ('237', '17', '长治县', '0');
INSERT INTO `sys_district` VALUES ('238', '17', '襄垣县', '0');
INSERT INTO `sys_district` VALUES ('239', '17', '屯留县', '0');
INSERT INTO `sys_district` VALUES ('240', '17', '平顺县', '0');
INSERT INTO `sys_district` VALUES ('241', '17', '黎城县', '0');
INSERT INTO `sys_district` VALUES ('242', '17', '壶关县', '0');
INSERT INTO `sys_district` VALUES ('243', '17', '长子县', '0');
INSERT INTO `sys_district` VALUES ('244', '17', '武乡县', '0');
INSERT INTO `sys_district` VALUES ('245', '17', '沁县', '0');
INSERT INTO `sys_district` VALUES ('246', '17', '沁源县', '0');
INSERT INTO `sys_district` VALUES ('247', '17', '潞城市', '0');
INSERT INTO `sys_district` VALUES ('248', '18', '城区', '0');
INSERT INTO `sys_district` VALUES ('249', '18', '沁水县', '0');
INSERT INTO `sys_district` VALUES ('250', '18', '阳城县', '0');
INSERT INTO `sys_district` VALUES ('251', '18', '陵川县', '0');
INSERT INTO `sys_district` VALUES ('252', '18', '泽州县', '0');
INSERT INTO `sys_district` VALUES ('253', '18', '高平市', '0');
INSERT INTO `sys_district` VALUES ('254', '19', '朔城区', '0');
INSERT INTO `sys_district` VALUES ('255', '19', '平鲁区', '0');
INSERT INTO `sys_district` VALUES ('256', '19', '山阴县', '0');
INSERT INTO `sys_district` VALUES ('257', '19', '应县', '0');
INSERT INTO `sys_district` VALUES ('258', '19', '右玉县', '0');
INSERT INTO `sys_district` VALUES ('259', '19', '怀仁县', '0');
INSERT INTO `sys_district` VALUES ('260', '20', '榆次区', '0');
INSERT INTO `sys_district` VALUES ('261', '20', '榆社县', '0');
INSERT INTO `sys_district` VALUES ('262', '20', '左权县', '0');
INSERT INTO `sys_district` VALUES ('263', '20', '和顺县', '0');
INSERT INTO `sys_district` VALUES ('264', '20', '昔阳县', '0');
INSERT INTO `sys_district` VALUES ('265', '20', '寿阳县', '0');
INSERT INTO `sys_district` VALUES ('266', '20', '太谷县', '0');
INSERT INTO `sys_district` VALUES ('267', '20', '祁县', '0');
INSERT INTO `sys_district` VALUES ('268', '20', '平遥县', '0');
INSERT INTO `sys_district` VALUES ('269', '20', '灵石县', '0');
INSERT INTO `sys_district` VALUES ('270', '20', '介休市', '0');
INSERT INTO `sys_district` VALUES ('271', '21', '盐湖区', '0');
INSERT INTO `sys_district` VALUES ('272', '21', '临猗县', '0');
INSERT INTO `sys_district` VALUES ('273', '21', '万荣县', '0');
INSERT INTO `sys_district` VALUES ('274', '21', '闻喜县', '0');
INSERT INTO `sys_district` VALUES ('275', '21', '稷山县', '0');
INSERT INTO `sys_district` VALUES ('276', '21', '新绛县', '0');
INSERT INTO `sys_district` VALUES ('277', '21', '绛县', '0');
INSERT INTO `sys_district` VALUES ('278', '21', '垣曲县', '0');
INSERT INTO `sys_district` VALUES ('279', '21', '夏县', '0');
INSERT INTO `sys_district` VALUES ('280', '21', '平陆县', '0');
INSERT INTO `sys_district` VALUES ('281', '21', '芮城县', '0');
INSERT INTO `sys_district` VALUES ('282', '21', '永济市', '0');
INSERT INTO `sys_district` VALUES ('283', '21', '河津市', '0');
INSERT INTO `sys_district` VALUES ('284', '22', '忻府区', '0');
INSERT INTO `sys_district` VALUES ('285', '22', '定襄县', '0');
INSERT INTO `sys_district` VALUES ('286', '22', '五台县', '0');
INSERT INTO `sys_district` VALUES ('287', '22', '代县', '0');
INSERT INTO `sys_district` VALUES ('288', '22', '繁峙县', '0');
INSERT INTO `sys_district` VALUES ('289', '22', '宁武县', '0');
INSERT INTO `sys_district` VALUES ('290', '22', '静乐县', '0');
INSERT INTO `sys_district` VALUES ('291', '22', '神池县', '0');
INSERT INTO `sys_district` VALUES ('292', '22', '五寨县', '0');
INSERT INTO `sys_district` VALUES ('293', '22', '岢岚县', '0');
INSERT INTO `sys_district` VALUES ('294', '22', '河曲县', '0');
INSERT INTO `sys_district` VALUES ('295', '22', '保德县', '0');
INSERT INTO `sys_district` VALUES ('296', '22', '偏关县', '0');
INSERT INTO `sys_district` VALUES ('297', '22', '原平市', '0');
INSERT INTO `sys_district` VALUES ('298', '23', '尧都区', '0');
INSERT INTO `sys_district` VALUES ('299', '23', '曲沃县', '0');
INSERT INTO `sys_district` VALUES ('300', '23', '翼城县', '0');
INSERT INTO `sys_district` VALUES ('301', '23', '襄汾县', '0');
INSERT INTO `sys_district` VALUES ('302', '23', '洪洞县', '0');
INSERT INTO `sys_district` VALUES ('303', '23', '古县', '0');
INSERT INTO `sys_district` VALUES ('304', '23', '安泽县', '0');
INSERT INTO `sys_district` VALUES ('305', '23', '浮山县', '0');
INSERT INTO `sys_district` VALUES ('306', '23', '吉县', '0');
INSERT INTO `sys_district` VALUES ('307', '23', '乡宁县', '0');
INSERT INTO `sys_district` VALUES ('308', '23', '大宁县', '0');
INSERT INTO `sys_district` VALUES ('309', '23', '隰县', '0');
INSERT INTO `sys_district` VALUES ('310', '23', '永和县', '0');
INSERT INTO `sys_district` VALUES ('311', '23', '蒲县', '0');
INSERT INTO `sys_district` VALUES ('312', '23', '汾西县', '0');
INSERT INTO `sys_district` VALUES ('313', '23', '侯马市', '0');
INSERT INTO `sys_district` VALUES ('314', '23', '霍州市', '0');
INSERT INTO `sys_district` VALUES ('315', '24', '离石区', '0');
INSERT INTO `sys_district` VALUES ('316', '24', '文水县', '0');
INSERT INTO `sys_district` VALUES ('317', '24', '交城县', '0');
INSERT INTO `sys_district` VALUES ('318', '24', '兴县', '0');
INSERT INTO `sys_district` VALUES ('319', '24', '临县', '0');
INSERT INTO `sys_district` VALUES ('320', '24', '柳林县', '0');
INSERT INTO `sys_district` VALUES ('321', '24', '石楼县', '0');
INSERT INTO `sys_district` VALUES ('322', '24', '岚县', '0');
INSERT INTO `sys_district` VALUES ('323', '24', '方山县', '0');
INSERT INTO `sys_district` VALUES ('324', '24', '中阳县', '0');
INSERT INTO `sys_district` VALUES ('325', '24', '交口县', '0');
INSERT INTO `sys_district` VALUES ('326', '24', '孝义市', '0');
INSERT INTO `sys_district` VALUES ('327', '24', '汾阳市', '0');
INSERT INTO `sys_district` VALUES ('328', '25', '新城区', '0');
INSERT INTO `sys_district` VALUES ('329', '25', '回民区', '0');
INSERT INTO `sys_district` VALUES ('330', '25', '玉泉区', '0');
INSERT INTO `sys_district` VALUES ('331', '25', '赛罕区', '0');
INSERT INTO `sys_district` VALUES ('332', '25', '土默特左旗', '0');
INSERT INTO `sys_district` VALUES ('333', '25', '托克托县', '0');
INSERT INTO `sys_district` VALUES ('334', '25', '和林格尔县', '0');
INSERT INTO `sys_district` VALUES ('335', '25', '清水河县', '0');
INSERT INTO `sys_district` VALUES ('336', '25', '武川县', '0');
INSERT INTO `sys_district` VALUES ('337', '26', '东河区', '0');
INSERT INTO `sys_district` VALUES ('338', '26', '昆都仑区', '0');
INSERT INTO `sys_district` VALUES ('339', '26', '青山区', '0');
INSERT INTO `sys_district` VALUES ('340', '26', '石拐区', '0');
INSERT INTO `sys_district` VALUES ('341', '26', '白云矿区', '0');
INSERT INTO `sys_district` VALUES ('342', '26', '九原区', '0');
INSERT INTO `sys_district` VALUES ('343', '26', '土默特右旗', '0');
INSERT INTO `sys_district` VALUES ('344', '26', '固阳县', '0');
INSERT INTO `sys_district` VALUES ('345', '26', '达尔罕茂明安联合旗', '0');
INSERT INTO `sys_district` VALUES ('346', '27', '海勃湾区', '0');
INSERT INTO `sys_district` VALUES ('347', '27', '海南区', '0');
INSERT INTO `sys_district` VALUES ('348', '27', '乌达区', '0');
INSERT INTO `sys_district` VALUES ('349', '28', '红山区', '0');
INSERT INTO `sys_district` VALUES ('350', '28', '元宝山区', '0');
INSERT INTO `sys_district` VALUES ('351', '28', '松山区', '0');
INSERT INTO `sys_district` VALUES ('352', '28', '阿鲁科尔沁旗', '0');
INSERT INTO `sys_district` VALUES ('353', '28', '巴林左旗', '0');
INSERT INTO `sys_district` VALUES ('354', '28', '巴林右旗', '0');
INSERT INTO `sys_district` VALUES ('355', '28', '林西县', '0');
INSERT INTO `sys_district` VALUES ('356', '28', '克什克腾旗', '0');
INSERT INTO `sys_district` VALUES ('357', '28', '翁牛特旗', '0');
INSERT INTO `sys_district` VALUES ('358', '28', '喀喇沁旗', '0');
INSERT INTO `sys_district` VALUES ('359', '28', '宁城县', '0');
INSERT INTO `sys_district` VALUES ('360', '28', '敖汉旗', '0');
INSERT INTO `sys_district` VALUES ('361', '29', '科尔沁区', '0');
INSERT INTO `sys_district` VALUES ('362', '29', '科尔沁左翼中旗', '0');
INSERT INTO `sys_district` VALUES ('363', '29', '科尔沁左翼后旗', '0');
INSERT INTO `sys_district` VALUES ('364', '29', '开鲁县', '0');
INSERT INTO `sys_district` VALUES ('365', '29', '库伦旗', '0');
INSERT INTO `sys_district` VALUES ('366', '29', '奈曼旗', '0');
INSERT INTO `sys_district` VALUES ('367', '29', '扎鲁特旗', '0');
INSERT INTO `sys_district` VALUES ('368', '29', '霍林郭勒市', '0');
INSERT INTO `sys_district` VALUES ('369', '30', '东胜区', '0');
INSERT INTO `sys_district` VALUES ('370', '30', '达拉特旗', '0');
INSERT INTO `sys_district` VALUES ('371', '30', '准格尔旗', '0');
INSERT INTO `sys_district` VALUES ('372', '30', '鄂托克前旗', '0');
INSERT INTO `sys_district` VALUES ('373', '30', '鄂托克旗', '0');
INSERT INTO `sys_district` VALUES ('374', '30', '杭锦旗', '0');
INSERT INTO `sys_district` VALUES ('375', '30', '乌审旗', '0');
INSERT INTO `sys_district` VALUES ('376', '30', '伊金霍洛旗', '0');
INSERT INTO `sys_district` VALUES ('377', '31', '海拉尔区', '0');
INSERT INTO `sys_district` VALUES ('378', '31', '阿荣旗', '0');
INSERT INTO `sys_district` VALUES ('379', '31', '莫力达瓦达斡尔族自治旗', '0');
INSERT INTO `sys_district` VALUES ('380', '31', '鄂伦春自治旗', '0');
INSERT INTO `sys_district` VALUES ('381', '31', '鄂温克族自治旗', '0');
INSERT INTO `sys_district` VALUES ('382', '31', '陈巴尔虎旗', '0');
INSERT INTO `sys_district` VALUES ('383', '31', '新巴尔虎左旗', '0');
INSERT INTO `sys_district` VALUES ('384', '31', '新巴尔虎右旗', '0');
INSERT INTO `sys_district` VALUES ('385', '31', '满洲里市', '0');
INSERT INTO `sys_district` VALUES ('386', '31', '牙克石市', '0');
INSERT INTO `sys_district` VALUES ('387', '31', '扎兰屯市', '0');
INSERT INTO `sys_district` VALUES ('388', '31', '额尔古纳市', '0');
INSERT INTO `sys_district` VALUES ('389', '31', '根河市', '0');
INSERT INTO `sys_district` VALUES ('390', '32', '临河区', '0');
INSERT INTO `sys_district` VALUES ('391', '32', '五原县', '0');
INSERT INTO `sys_district` VALUES ('392', '32', '磴口县', '0');
INSERT INTO `sys_district` VALUES ('393', '32', '乌拉特前旗', '0');
INSERT INTO `sys_district` VALUES ('394', '32', '乌拉特中旗', '0');
INSERT INTO `sys_district` VALUES ('395', '32', '乌拉特后旗', '0');
INSERT INTO `sys_district` VALUES ('396', '32', '杭锦后旗', '0');
INSERT INTO `sys_district` VALUES ('397', '33', '集宁区', '0');
INSERT INTO `sys_district` VALUES ('398', '33', '卓资县', '0');
INSERT INTO `sys_district` VALUES ('399', '33', '化德县', '0');
INSERT INTO `sys_district` VALUES ('400', '33', '商都县', '0');
INSERT INTO `sys_district` VALUES ('401', '33', '兴和县', '0');
INSERT INTO `sys_district` VALUES ('402', '33', '凉城县', '0');
INSERT INTO `sys_district` VALUES ('403', '33', '察哈尔右翼前旗', '0');
INSERT INTO `sys_district` VALUES ('404', '33', '察哈尔右翼中旗', '0');
INSERT INTO `sys_district` VALUES ('405', '33', '察哈尔右翼后旗', '0');
INSERT INTO `sys_district` VALUES ('406', '33', '四子王旗', '0');
INSERT INTO `sys_district` VALUES ('407', '33', '丰镇市', '0');
INSERT INTO `sys_district` VALUES ('408', '34', '乌兰浩特市', '0');
INSERT INTO `sys_district` VALUES ('409', '34', '阿尔山市', '0');
INSERT INTO `sys_district` VALUES ('410', '34', '科尔沁右翼前旗', '0');
INSERT INTO `sys_district` VALUES ('411', '34', '科尔沁右翼中旗', '0');
INSERT INTO `sys_district` VALUES ('412', '34', '扎赉特旗', '0');
INSERT INTO `sys_district` VALUES ('413', '34', '突泉县', '0');
INSERT INTO `sys_district` VALUES ('414', '35', '二连浩特市', '0');
INSERT INTO `sys_district` VALUES ('415', '35', '锡林浩特市', '0');
INSERT INTO `sys_district` VALUES ('416', '35', '阿巴嘎旗', '0');
INSERT INTO `sys_district` VALUES ('417', '35', '苏尼特左旗', '0');
INSERT INTO `sys_district` VALUES ('418', '35', '苏尼特右旗', '0');
INSERT INTO `sys_district` VALUES ('419', '35', '东乌珠穆沁旗', '0');
INSERT INTO `sys_district` VALUES ('420', '35', '西乌珠穆沁旗', '0');
INSERT INTO `sys_district` VALUES ('421', '35', '太仆寺旗', '0');
INSERT INTO `sys_district` VALUES ('422', '35', '镶黄旗', '0');
INSERT INTO `sys_district` VALUES ('423', '35', '正镶白旗', '0');
INSERT INTO `sys_district` VALUES ('424', '35', '正蓝旗', '0');
INSERT INTO `sys_district` VALUES ('425', '35', '多伦县', '0');
INSERT INTO `sys_district` VALUES ('426', '36', '阿拉善左旗', '0');
INSERT INTO `sys_district` VALUES ('427', '36', '阿拉善右旗', '0');
INSERT INTO `sys_district` VALUES ('428', '36', '额济纳旗', '0');
INSERT INTO `sys_district` VALUES ('429', '37', '和平区', '0');
INSERT INTO `sys_district` VALUES ('430', '37', '沈河区', '0');
INSERT INTO `sys_district` VALUES ('431', '37', '大东区', '0');
INSERT INTO `sys_district` VALUES ('432', '37', '皇姑区', '0');
INSERT INTO `sys_district` VALUES ('433', '37', '铁西区', '0');
INSERT INTO `sys_district` VALUES ('434', '37', '苏家屯区', '0');
INSERT INTO `sys_district` VALUES ('435', '37', '东陵区', '0');
INSERT INTO `sys_district` VALUES ('436', '37', '新城子区', '0');
INSERT INTO `sys_district` VALUES ('437', '37', '于洪区', '0');
INSERT INTO `sys_district` VALUES ('438', '37', '辽中县', '0');
INSERT INTO `sys_district` VALUES ('439', '37', '康平县', '0');
INSERT INTO `sys_district` VALUES ('440', '37', '法库县', '0');
INSERT INTO `sys_district` VALUES ('441', '37', '新民市', '0');
INSERT INTO `sys_district` VALUES ('442', '38', '中山区', '0');
INSERT INTO `sys_district` VALUES ('443', '38', '西岗区', '0');
INSERT INTO `sys_district` VALUES ('444', '38', '沙河口区', '0');
INSERT INTO `sys_district` VALUES ('445', '38', '甘井子区', '0');
INSERT INTO `sys_district` VALUES ('446', '38', '旅顺口区', '0');
INSERT INTO `sys_district` VALUES ('447', '38', '金州区', '0');
INSERT INTO `sys_district` VALUES ('448', '38', '长海县', '0');
INSERT INTO `sys_district` VALUES ('449', '38', '瓦房店市', '0');
INSERT INTO `sys_district` VALUES ('450', '38', '普兰店市', '0');
INSERT INTO `sys_district` VALUES ('451', '38', '庄河市', '0');
INSERT INTO `sys_district` VALUES ('452', '39', '铁东区', '0');
INSERT INTO `sys_district` VALUES ('453', '39', '铁西区', '0');
INSERT INTO `sys_district` VALUES ('454', '39', '立山区', '0');
INSERT INTO `sys_district` VALUES ('455', '39', '千山区', '0');
INSERT INTO `sys_district` VALUES ('456', '39', '台安县', '0');
INSERT INTO `sys_district` VALUES ('457', '39', '岫岩满族自治县', '0');
INSERT INTO `sys_district` VALUES ('458', '39', '海城市', '0');
INSERT INTO `sys_district` VALUES ('459', '40', '新抚区', '0');
INSERT INTO `sys_district` VALUES ('460', '40', '东洲区', '0');
INSERT INTO `sys_district` VALUES ('461', '40', '望花区', '0');
INSERT INTO `sys_district` VALUES ('462', '40', '顺城区', '0');
INSERT INTO `sys_district` VALUES ('463', '40', '抚顺县', '0');
INSERT INTO `sys_district` VALUES ('464', '40', '新宾满族自治县', '0');
INSERT INTO `sys_district` VALUES ('465', '40', '清原满族自治县', '0');
INSERT INTO `sys_district` VALUES ('466', '41', '平山区', '0');
INSERT INTO `sys_district` VALUES ('467', '41', '溪湖区', '0');
INSERT INTO `sys_district` VALUES ('468', '41', '明山区', '0');
INSERT INTO `sys_district` VALUES ('469', '41', '南芬区', '0');
INSERT INTO `sys_district` VALUES ('470', '41', '本溪满族自治县', '0');
INSERT INTO `sys_district` VALUES ('471', '41', '桓仁满族自治县', '0');
INSERT INTO `sys_district` VALUES ('472', '42', '元宝区', '0');
INSERT INTO `sys_district` VALUES ('473', '42', '振兴区', '0');
INSERT INTO `sys_district` VALUES ('474', '42', '振安区', '0');
INSERT INTO `sys_district` VALUES ('475', '42', '宽甸满族自治县', '0');
INSERT INTO `sys_district` VALUES ('476', '42', '东港市', '0');
INSERT INTO `sys_district` VALUES ('477', '42', '凤城市', '0');
INSERT INTO `sys_district` VALUES ('478', '43', '古塔区', '0');
INSERT INTO `sys_district` VALUES ('479', '43', '凌河区', '0');
INSERT INTO `sys_district` VALUES ('480', '43', '太和区', '0');
INSERT INTO `sys_district` VALUES ('481', '43', '黑山县', '0');
INSERT INTO `sys_district` VALUES ('482', '43', '义县', '0');
INSERT INTO `sys_district` VALUES ('483', '43', '凌海市', '0');
INSERT INTO `sys_district` VALUES ('484', '43', '北宁市', '0');
INSERT INTO `sys_district` VALUES ('485', '44', '站前区', '0');
INSERT INTO `sys_district` VALUES ('486', '44', '西市区', '0');
INSERT INTO `sys_district` VALUES ('487', '44', '鲅鱼圈区', '0');
INSERT INTO `sys_district` VALUES ('488', '44', '老边区', '0');
INSERT INTO `sys_district` VALUES ('489', '44', '盖州市', '0');
INSERT INTO `sys_district` VALUES ('490', '44', '大石桥市', '0');
INSERT INTO `sys_district` VALUES ('491', '45', '海州区', '0');
INSERT INTO `sys_district` VALUES ('492', '45', '新邱区', '0');
INSERT INTO `sys_district` VALUES ('493', '45', '太平区', '0');
INSERT INTO `sys_district` VALUES ('494', '45', '清河门区', '0');
INSERT INTO `sys_district` VALUES ('495', '45', '细河区', '0');
INSERT INTO `sys_district` VALUES ('496', '45', '阜新蒙古族自治县', '0');
INSERT INTO `sys_district` VALUES ('497', '45', '彰武县', '0');
INSERT INTO `sys_district` VALUES ('498', '46', '白塔区', '0');
INSERT INTO `sys_district` VALUES ('499', '46', '文圣区', '0');
INSERT INTO `sys_district` VALUES ('500', '46', '宏伟区', '0');
INSERT INTO `sys_district` VALUES ('501', '46', '弓长岭区', '0');
INSERT INTO `sys_district` VALUES ('502', '46', '太子河区', '0');
INSERT INTO `sys_district` VALUES ('503', '46', '辽阳县', '0');
INSERT INTO `sys_district` VALUES ('504', '46', '灯塔市', '0');
INSERT INTO `sys_district` VALUES ('505', '47', '双台子区', '0');
INSERT INTO `sys_district` VALUES ('506', '47', '兴隆台区', '0');
INSERT INTO `sys_district` VALUES ('507', '47', '大洼县', '0');
INSERT INTO `sys_district` VALUES ('508', '47', '盘山县', '0');
INSERT INTO `sys_district` VALUES ('509', '48', '银州区', '0');
INSERT INTO `sys_district` VALUES ('510', '48', '清河区', '0');
INSERT INTO `sys_district` VALUES ('511', '48', '铁岭县', '0');
INSERT INTO `sys_district` VALUES ('512', '48', '西丰县', '0');
INSERT INTO `sys_district` VALUES ('513', '48', '昌图县', '0');
INSERT INTO `sys_district` VALUES ('514', '48', '调兵山市', '0');
INSERT INTO `sys_district` VALUES ('515', '48', '开原市', '0');
INSERT INTO `sys_district` VALUES ('516', '49', '双塔区', '0');
INSERT INTO `sys_district` VALUES ('517', '49', '龙城区', '0');
INSERT INTO `sys_district` VALUES ('518', '49', '朝阳县', '0');
INSERT INTO `sys_district` VALUES ('519', '49', '建平县', '0');
INSERT INTO `sys_district` VALUES ('520', '49', '喀喇沁左翼蒙古族自治县', '0');
INSERT INTO `sys_district` VALUES ('521', '49', '北票市', '0');
INSERT INTO `sys_district` VALUES ('522', '49', '凌源市', '0');
INSERT INTO `sys_district` VALUES ('523', '50', '连山区', '0');
INSERT INTO `sys_district` VALUES ('524', '50', '龙港区', '0');
INSERT INTO `sys_district` VALUES ('525', '50', '南票区', '0');
INSERT INTO `sys_district` VALUES ('526', '50', '绥中县', '0');
INSERT INTO `sys_district` VALUES ('527', '50', '建昌县', '0');
INSERT INTO `sys_district` VALUES ('528', '50', '兴城市', '0');
INSERT INTO `sys_district` VALUES ('529', '51', '南关区', '0');
INSERT INTO `sys_district` VALUES ('530', '51', '宽城区', '0');
INSERT INTO `sys_district` VALUES ('531', '51', '朝阳区', '0');
INSERT INTO `sys_district` VALUES ('532', '51', '二道区', '0');
INSERT INTO `sys_district` VALUES ('533', '51', '绿园区', '0');
INSERT INTO `sys_district` VALUES ('534', '51', '双阳区', '0');
INSERT INTO `sys_district` VALUES ('535', '51', '农安县', '0');
INSERT INTO `sys_district` VALUES ('536', '51', '九台市', '0');
INSERT INTO `sys_district` VALUES ('537', '51', '榆树市', '0');
INSERT INTO `sys_district` VALUES ('538', '51', '德惠市', '0');
INSERT INTO `sys_district` VALUES ('539', '52', '昌邑区', '0');
INSERT INTO `sys_district` VALUES ('540', '52', '龙潭区', '0');
INSERT INTO `sys_district` VALUES ('541', '52', '船营区', '0');
INSERT INTO `sys_district` VALUES ('542', '52', '丰满区', '0');
INSERT INTO `sys_district` VALUES ('543', '52', '永吉县', '0');
INSERT INTO `sys_district` VALUES ('544', '52', '蛟河市', '0');
INSERT INTO `sys_district` VALUES ('545', '52', '桦甸市', '0');
INSERT INTO `sys_district` VALUES ('546', '52', '舒兰市', '0');
INSERT INTO `sys_district` VALUES ('547', '52', '磐石市', '0');
INSERT INTO `sys_district` VALUES ('548', '53', '铁西区', '0');
INSERT INTO `sys_district` VALUES ('549', '53', '铁东区', '0');
INSERT INTO `sys_district` VALUES ('550', '53', '梨树县', '0');
INSERT INTO `sys_district` VALUES ('551', '53', '伊通满族自治县', '0');
INSERT INTO `sys_district` VALUES ('552', '53', '公主岭市', '0');
INSERT INTO `sys_district` VALUES ('553', '53', '双辽市', '0');
INSERT INTO `sys_district` VALUES ('554', '54', '龙山区', '0');
INSERT INTO `sys_district` VALUES ('555', '54', '西安区', '0');
INSERT INTO `sys_district` VALUES ('556', '54', '东丰县', '0');
INSERT INTO `sys_district` VALUES ('557', '54', '东辽县', '0');
INSERT INTO `sys_district` VALUES ('558', '55', '东昌区', '0');
INSERT INTO `sys_district` VALUES ('559', '55', '二道江区', '0');
INSERT INTO `sys_district` VALUES ('560', '55', '通化县', '0');
INSERT INTO `sys_district` VALUES ('561', '55', '辉南县', '0');
INSERT INTO `sys_district` VALUES ('562', '55', '柳河县', '0');
INSERT INTO `sys_district` VALUES ('563', '55', '梅河口市', '0');
INSERT INTO `sys_district` VALUES ('564', '55', '集安市', '0');
INSERT INTO `sys_district` VALUES ('565', '56', '八道江区', '0');
INSERT INTO `sys_district` VALUES ('566', '56', '抚松县', '0');
INSERT INTO `sys_district` VALUES ('567', '56', '靖宇县', '0');
INSERT INTO `sys_district` VALUES ('568', '56', '长白朝鲜族自治县', '0');
INSERT INTO `sys_district` VALUES ('569', '56', '江源县', '0');
INSERT INTO `sys_district` VALUES ('570', '56', '临江市', '0');
INSERT INTO `sys_district` VALUES ('571', '57', '宁江区', '0');
INSERT INTO `sys_district` VALUES ('572', '57', '前郭尔罗斯蒙古族自治县', '0');
INSERT INTO `sys_district` VALUES ('573', '57', '长岭县', '0');
INSERT INTO `sys_district` VALUES ('574', '57', '乾安县', '0');
INSERT INTO `sys_district` VALUES ('575', '57', '扶余县', '0');
INSERT INTO `sys_district` VALUES ('576', '58', '洮北区', '0');
INSERT INTO `sys_district` VALUES ('577', '58', '镇赉县', '0');
INSERT INTO `sys_district` VALUES ('578', '58', '通榆县', '0');
INSERT INTO `sys_district` VALUES ('579', '58', '洮南市', '0');
INSERT INTO `sys_district` VALUES ('580', '58', '大安市', '0');
INSERT INTO `sys_district` VALUES ('581', '59', '延吉市', '0');
INSERT INTO `sys_district` VALUES ('582', '59', '图们市', '0');
INSERT INTO `sys_district` VALUES ('583', '59', '敦化市', '0');
INSERT INTO `sys_district` VALUES ('584', '59', '珲春市', '0');
INSERT INTO `sys_district` VALUES ('585', '59', '龙井市', '0');
INSERT INTO `sys_district` VALUES ('586', '59', '和龙市', '0');
INSERT INTO `sys_district` VALUES ('587', '59', '汪清县', '0');
INSERT INTO `sys_district` VALUES ('588', '59', '安图县', '0');
INSERT INTO `sys_district` VALUES ('589', '60', '道里区', '0');
INSERT INTO `sys_district` VALUES ('590', '60', '南岗区', '0');
INSERT INTO `sys_district` VALUES ('591', '60', '道外区', '0');
INSERT INTO `sys_district` VALUES ('592', '60', '香坊区', '0');
INSERT INTO `sys_district` VALUES ('593', '60', '动力区', '0');
INSERT INTO `sys_district` VALUES ('594', '60', '平房区', '0');
INSERT INTO `sys_district` VALUES ('595', '60', '松北区', '0');
INSERT INTO `sys_district` VALUES ('596', '60', '呼兰区', '0');
INSERT INTO `sys_district` VALUES ('597', '60', '依兰县', '0');
INSERT INTO `sys_district` VALUES ('598', '60', '方正县', '0');
INSERT INTO `sys_district` VALUES ('599', '60', '宾县', '0');
INSERT INTO `sys_district` VALUES ('600', '60', '巴彦县', '0');
INSERT INTO `sys_district` VALUES ('601', '60', '木兰县', '0');
INSERT INTO `sys_district` VALUES ('602', '60', '通河县', '0');
INSERT INTO `sys_district` VALUES ('603', '60', '延寿县', '0');
INSERT INTO `sys_district` VALUES ('604', '60', '阿城市', '0');
INSERT INTO `sys_district` VALUES ('605', '60', '双城市', '0');
INSERT INTO `sys_district` VALUES ('606', '60', '尚志市', '0');
INSERT INTO `sys_district` VALUES ('607', '60', '五常市', '0');
INSERT INTO `sys_district` VALUES ('608', '61', '龙沙区', '0');
INSERT INTO `sys_district` VALUES ('609', '61', '建华区', '0');
INSERT INTO `sys_district` VALUES ('610', '61', '铁锋区', '0');
INSERT INTO `sys_district` VALUES ('611', '61', '昂昂溪区', '0');
INSERT INTO `sys_district` VALUES ('612', '61', '富拉尔基区', '0');
INSERT INTO `sys_district` VALUES ('613', '61', '碾子山区', '0');
INSERT INTO `sys_district` VALUES ('614', '61', '梅里斯达斡尔族区', '0');
INSERT INTO `sys_district` VALUES ('615', '61', '龙江县', '0');
INSERT INTO `sys_district` VALUES ('616', '61', '依安县', '0');
INSERT INTO `sys_district` VALUES ('617', '61', '泰来县', '0');
INSERT INTO `sys_district` VALUES ('618', '61', '甘南县', '0');
INSERT INTO `sys_district` VALUES ('619', '61', '富裕县', '0');
INSERT INTO `sys_district` VALUES ('620', '61', '克山县', '0');
INSERT INTO `sys_district` VALUES ('621', '61', '克东县', '0');
INSERT INTO `sys_district` VALUES ('622', '61', '拜泉县', '0');
INSERT INTO `sys_district` VALUES ('623', '61', '讷河市', '0');
INSERT INTO `sys_district` VALUES ('624', '62', '鸡冠区', '0');
INSERT INTO `sys_district` VALUES ('625', '62', '恒山区', '0');
INSERT INTO `sys_district` VALUES ('626', '62', '滴道区', '0');
INSERT INTO `sys_district` VALUES ('627', '62', '梨树区', '0');
INSERT INTO `sys_district` VALUES ('628', '62', '城子河区', '0');
INSERT INTO `sys_district` VALUES ('629', '62', '麻山区', '0');
INSERT INTO `sys_district` VALUES ('630', '62', '鸡东县', '0');
INSERT INTO `sys_district` VALUES ('631', '62', '虎林市', '0');
INSERT INTO `sys_district` VALUES ('632', '62', '密山市', '0');
INSERT INTO `sys_district` VALUES ('633', '63', '向阳区', '0');
INSERT INTO `sys_district` VALUES ('634', '63', '工农区', '0');
INSERT INTO `sys_district` VALUES ('635', '63', '南山区', '0');
INSERT INTO `sys_district` VALUES ('636', '63', '兴安区', '0');
INSERT INTO `sys_district` VALUES ('637', '63', '东山区', '0');
INSERT INTO `sys_district` VALUES ('638', '63', '兴山区', '0');
INSERT INTO `sys_district` VALUES ('639', '63', '萝北县', '0');
INSERT INTO `sys_district` VALUES ('640', '63', '绥滨县', '0');
INSERT INTO `sys_district` VALUES ('641', '64', '尖山区', '0');
INSERT INTO `sys_district` VALUES ('642', '64', '岭东区', '0');
INSERT INTO `sys_district` VALUES ('643', '64', '四方台区', '0');
INSERT INTO `sys_district` VALUES ('644', '64', '宝山区', '0');
INSERT INTO `sys_district` VALUES ('645', '64', '集贤县', '0');
INSERT INTO `sys_district` VALUES ('646', '64', '友谊县', '0');
INSERT INTO `sys_district` VALUES ('647', '64', '宝清县', '0');
INSERT INTO `sys_district` VALUES ('648', '64', '饶河县', '0');
INSERT INTO `sys_district` VALUES ('649', '65', '萨尔图区', '0');
INSERT INTO `sys_district` VALUES ('650', '65', '龙凤区', '0');
INSERT INTO `sys_district` VALUES ('651', '65', '让胡路区', '0');
INSERT INTO `sys_district` VALUES ('652', '65', '红岗区', '0');
INSERT INTO `sys_district` VALUES ('653', '65', '大同区', '0');
INSERT INTO `sys_district` VALUES ('654', '65', '肇州县', '0');
INSERT INTO `sys_district` VALUES ('655', '65', '肇源县', '0');
INSERT INTO `sys_district` VALUES ('656', '65', '林甸县', '0');
INSERT INTO `sys_district` VALUES ('657', '65', '杜尔伯特蒙古族自治县', '0');
INSERT INTO `sys_district` VALUES ('658', '66', '伊春区', '0');
INSERT INTO `sys_district` VALUES ('659', '66', '南岔区', '0');
INSERT INTO `sys_district` VALUES ('660', '66', '友好区', '0');
INSERT INTO `sys_district` VALUES ('661', '66', '西林区', '0');
INSERT INTO `sys_district` VALUES ('662', '66', '翠峦区', '0');
INSERT INTO `sys_district` VALUES ('663', '66', '新青区', '0');
INSERT INTO `sys_district` VALUES ('664', '66', '美溪区', '0');
INSERT INTO `sys_district` VALUES ('665', '66', '金山屯区', '0');
INSERT INTO `sys_district` VALUES ('666', '66', '五营区', '0');
INSERT INTO `sys_district` VALUES ('667', '66', '乌马河区', '0');
INSERT INTO `sys_district` VALUES ('668', '66', '汤旺河区', '0');
INSERT INTO `sys_district` VALUES ('669', '66', '带岭区', '0');
INSERT INTO `sys_district` VALUES ('670', '66', '乌伊岭区', '0');
INSERT INTO `sys_district` VALUES ('671', '66', '红星区', '0');
INSERT INTO `sys_district` VALUES ('672', '66', '上甘岭区', '0');
INSERT INTO `sys_district` VALUES ('673', '66', '嘉荫县', '0');
INSERT INTO `sys_district` VALUES ('674', '66', '铁力市', '0');
INSERT INTO `sys_district` VALUES ('675', '67', '永红区', '0');
INSERT INTO `sys_district` VALUES ('676', '67', '向阳区', '0');
INSERT INTO `sys_district` VALUES ('677', '67', '前进区', '0');
INSERT INTO `sys_district` VALUES ('678', '67', '东风区', '0');
INSERT INTO `sys_district` VALUES ('679', '67', '郊区', '0');
INSERT INTO `sys_district` VALUES ('680', '67', '桦南县', '0');
INSERT INTO `sys_district` VALUES ('681', '67', '桦川县', '0');
INSERT INTO `sys_district` VALUES ('682', '67', '汤原县', '0');
INSERT INTO `sys_district` VALUES ('683', '67', '抚远县', '0');
INSERT INTO `sys_district` VALUES ('684', '67', '同江市', '0');
INSERT INTO `sys_district` VALUES ('685', '67', '富锦市', '0');
INSERT INTO `sys_district` VALUES ('686', '68', '新兴区', '0');
INSERT INTO `sys_district` VALUES ('687', '68', '桃山区', '0');
INSERT INTO `sys_district` VALUES ('688', '68', '茄子河区', '0');
INSERT INTO `sys_district` VALUES ('689', '68', '勃利县', '0');
INSERT INTO `sys_district` VALUES ('690', '69', '东安区', '0');
INSERT INTO `sys_district` VALUES ('691', '69', '阳明区', '0');
INSERT INTO `sys_district` VALUES ('692', '69', '爱民区', '0');
INSERT INTO `sys_district` VALUES ('693', '69', '西安区', '0');
INSERT INTO `sys_district` VALUES ('694', '69', '东宁县', '0');
INSERT INTO `sys_district` VALUES ('695', '69', '林口县', '0');
INSERT INTO `sys_district` VALUES ('696', '69', '绥芬河市', '0');
INSERT INTO `sys_district` VALUES ('697', '69', '海林市', '0');
INSERT INTO `sys_district` VALUES ('698', '69', '宁安市', '0');
INSERT INTO `sys_district` VALUES ('699', '69', '穆棱市', '0');
INSERT INTO `sys_district` VALUES ('700', '70', '爱辉区', '0');
INSERT INTO `sys_district` VALUES ('701', '70', '嫩江县', '0');
INSERT INTO `sys_district` VALUES ('702', '70', '逊克县', '0');
INSERT INTO `sys_district` VALUES ('703', '70', '孙吴县', '0');
INSERT INTO `sys_district` VALUES ('704', '70', '北安市', '0');
INSERT INTO `sys_district` VALUES ('705', '70', '五大连池市', '0');
INSERT INTO `sys_district` VALUES ('706', '71', '北林区', '0');
INSERT INTO `sys_district` VALUES ('707', '71', '望奎县', '0');
INSERT INTO `sys_district` VALUES ('708', '71', '兰西县', '0');
INSERT INTO `sys_district` VALUES ('709', '71', '青冈县', '0');
INSERT INTO `sys_district` VALUES ('710', '71', '庆安县', '0');
INSERT INTO `sys_district` VALUES ('711', '71', '明水县', '0');
INSERT INTO `sys_district` VALUES ('712', '71', '绥棱县', '0');
INSERT INTO `sys_district` VALUES ('713', '71', '安达市', '0');
INSERT INTO `sys_district` VALUES ('714', '71', '肇东市', '0');
INSERT INTO `sys_district` VALUES ('715', '71', '海伦市', '0');
INSERT INTO `sys_district` VALUES ('716', '72', '呼玛县', '0');
INSERT INTO `sys_district` VALUES ('717', '72', '塔河县', '0');
INSERT INTO `sys_district` VALUES ('718', '72', '漠河县', '0');
INSERT INTO `sys_district` VALUES ('719', '73', '黄浦区', '0');
INSERT INTO `sys_district` VALUES ('720', '73', '卢湾区', '0');
INSERT INTO `sys_district` VALUES ('721', '73', '徐汇区', '0');
INSERT INTO `sys_district` VALUES ('722', '73', '长宁区', '0');
INSERT INTO `sys_district` VALUES ('723', '73', '静安区', '0');
INSERT INTO `sys_district` VALUES ('724', '73', '普陀区', '0');
INSERT INTO `sys_district` VALUES ('725', '73', '闸北区', '0');
INSERT INTO `sys_district` VALUES ('726', '73', '虹口区', '0');
INSERT INTO `sys_district` VALUES ('727', '73', '杨浦区', '0');
INSERT INTO `sys_district` VALUES ('728', '73', '闵行区', '0');
INSERT INTO `sys_district` VALUES ('729', '73', '宝山区', '0');
INSERT INTO `sys_district` VALUES ('730', '73', '嘉定区', '0');
INSERT INTO `sys_district` VALUES ('731', '73', '浦东新区', '0');
INSERT INTO `sys_district` VALUES ('732', '73', '金山区', '0');
INSERT INTO `sys_district` VALUES ('733', '73', '松江区', '0');
INSERT INTO `sys_district` VALUES ('734', '73', '青浦区', '0');
INSERT INTO `sys_district` VALUES ('735', '73', '南汇区', '0');
INSERT INTO `sys_district` VALUES ('736', '73', '奉贤区', '0');
INSERT INTO `sys_district` VALUES ('737', '73', '崇明县', '0');
INSERT INTO `sys_district` VALUES ('738', '74', '玄武区', '0');
INSERT INTO `sys_district` VALUES ('739', '74', '白下区', '0');
INSERT INTO `sys_district` VALUES ('740', '74', '秦淮区', '0');
INSERT INTO `sys_district` VALUES ('741', '74', '建邺区', '0');
INSERT INTO `sys_district` VALUES ('742', '74', '鼓楼区', '0');
INSERT INTO `sys_district` VALUES ('743', '74', '下关区', '0');
INSERT INTO `sys_district` VALUES ('744', '74', '浦口区', '0');
INSERT INTO `sys_district` VALUES ('745', '74', '栖霞区', '0');
INSERT INTO `sys_district` VALUES ('746', '74', '雨花台区', '0');
INSERT INTO `sys_district` VALUES ('747', '74', '江宁区', '0');
INSERT INTO `sys_district` VALUES ('748', '74', '六合区', '0');
INSERT INTO `sys_district` VALUES ('749', '74', '溧水县', '0');
INSERT INTO `sys_district` VALUES ('750', '74', '高淳县', '0');
INSERT INTO `sys_district` VALUES ('751', '75', '崇安区', '0');
INSERT INTO `sys_district` VALUES ('752', '75', '南长区', '0');
INSERT INTO `sys_district` VALUES ('753', '75', '北塘区', '0');
INSERT INTO `sys_district` VALUES ('754', '75', '锡山区', '0');
INSERT INTO `sys_district` VALUES ('755', '75', '惠山区', '0');
INSERT INTO `sys_district` VALUES ('756', '75', '滨湖区', '0');
INSERT INTO `sys_district` VALUES ('757', '75', '江阴市', '0');
INSERT INTO `sys_district` VALUES ('758', '75', '宜兴市', '0');
INSERT INTO `sys_district` VALUES ('759', '76', '鼓楼区', '0');
INSERT INTO `sys_district` VALUES ('760', '76', '云龙区', '0');
INSERT INTO `sys_district` VALUES ('761', '76', '九里区', '0');
INSERT INTO `sys_district` VALUES ('762', '76', '贾汪区', '0');
INSERT INTO `sys_district` VALUES ('763', '76', '泉山区', '0');
INSERT INTO `sys_district` VALUES ('764', '76', '丰县', '0');
INSERT INTO `sys_district` VALUES ('765', '76', '沛县', '0');
INSERT INTO `sys_district` VALUES ('766', '76', '铜山县', '0');
INSERT INTO `sys_district` VALUES ('767', '76', '睢宁县', '0');
INSERT INTO `sys_district` VALUES ('768', '76', '新沂市', '0');
INSERT INTO `sys_district` VALUES ('769', '76', '邳州市', '0');
INSERT INTO `sys_district` VALUES ('770', '77', '天宁区', '0');
INSERT INTO `sys_district` VALUES ('771', '77', '钟楼区', '0');
INSERT INTO `sys_district` VALUES ('772', '77', '戚墅堰区', '0');
INSERT INTO `sys_district` VALUES ('773', '77', '新北区', '0');
INSERT INTO `sys_district` VALUES ('774', '77', '武进区', '0');
INSERT INTO `sys_district` VALUES ('775', '77', '溧阳市', '0');
INSERT INTO `sys_district` VALUES ('776', '77', '金坛市', '0');
INSERT INTO `sys_district` VALUES ('777', '78', '沧浪区', '0');
INSERT INTO `sys_district` VALUES ('778', '78', '平江区', '0');
INSERT INTO `sys_district` VALUES ('779', '78', '金阊区', '0');
INSERT INTO `sys_district` VALUES ('780', '78', '虎丘区', '0');
INSERT INTO `sys_district` VALUES ('781', '78', '吴中区', '0');
INSERT INTO `sys_district` VALUES ('782', '78', '相城区', '0');
INSERT INTO `sys_district` VALUES ('783', '78', '常熟市', '0');
INSERT INTO `sys_district` VALUES ('784', '78', '张家港市', '0');
INSERT INTO `sys_district` VALUES ('785', '78', '昆山市', '0');
INSERT INTO `sys_district` VALUES ('786', '78', '吴江市', '0');
INSERT INTO `sys_district` VALUES ('787', '78', '太仓市', '0');
INSERT INTO `sys_district` VALUES ('788', '79', '崇川区', '0');
INSERT INTO `sys_district` VALUES ('789', '79', '港闸区', '0');
INSERT INTO `sys_district` VALUES ('790', '79', '海安县', '0');
INSERT INTO `sys_district` VALUES ('791', '79', '如东县', '0');
INSERT INTO `sys_district` VALUES ('792', '79', '启东市', '0');
INSERT INTO `sys_district` VALUES ('793', '79', '如皋市', '0');
INSERT INTO `sys_district` VALUES ('794', '79', '通州市', '0');
INSERT INTO `sys_district` VALUES ('795', '79', '海门市', '0');
INSERT INTO `sys_district` VALUES ('796', '80', '连云区', '0');
INSERT INTO `sys_district` VALUES ('797', '80', '新浦区', '0');
INSERT INTO `sys_district` VALUES ('798', '80', '海州区', '0');
INSERT INTO `sys_district` VALUES ('799', '80', '赣榆县', '0');
INSERT INTO `sys_district` VALUES ('800', '80', '东海县', '0');
INSERT INTO `sys_district` VALUES ('801', '80', '灌云县', '0');
INSERT INTO `sys_district` VALUES ('802', '80', '灌南县', '0');
INSERT INTO `sys_district` VALUES ('803', '81', '清河区', '0');
INSERT INTO `sys_district` VALUES ('804', '81', '楚州区', '0');
INSERT INTO `sys_district` VALUES ('805', '81', '淮阴区', '0');
INSERT INTO `sys_district` VALUES ('806', '81', '清浦区', '0');
INSERT INTO `sys_district` VALUES ('807', '81', '涟水县', '0');
INSERT INTO `sys_district` VALUES ('808', '81', '洪泽县', '0');
INSERT INTO `sys_district` VALUES ('809', '81', '盱眙县', '0');
INSERT INTO `sys_district` VALUES ('810', '81', '金湖县', '0');
INSERT INTO `sys_district` VALUES ('811', '82', '亭湖区', '0');
INSERT INTO `sys_district` VALUES ('812', '82', '盐都区', '0');
INSERT INTO `sys_district` VALUES ('813', '82', '响水县', '0');
INSERT INTO `sys_district` VALUES ('814', '82', '滨海县', '0');
INSERT INTO `sys_district` VALUES ('815', '82', '阜宁县', '0');
INSERT INTO `sys_district` VALUES ('816', '82', '射阳县', '0');
INSERT INTO `sys_district` VALUES ('817', '82', '建湖县', '0');
INSERT INTO `sys_district` VALUES ('818', '82', '东台市', '0');
INSERT INTO `sys_district` VALUES ('819', '82', '大丰市', '0');
INSERT INTO `sys_district` VALUES ('820', '83', '广陵区', '0');
INSERT INTO `sys_district` VALUES ('821', '83', '邗江区', '0');
INSERT INTO `sys_district` VALUES ('822', '83', '维扬区', '0');
INSERT INTO `sys_district` VALUES ('823', '83', '宝应县', '0');
INSERT INTO `sys_district` VALUES ('824', '83', '仪征市', '0');
INSERT INTO `sys_district` VALUES ('825', '83', '高邮市', '0');
INSERT INTO `sys_district` VALUES ('826', '83', '江都市', '0');
INSERT INTO `sys_district` VALUES ('827', '84', '京口区', '0');
INSERT INTO `sys_district` VALUES ('828', '84', '润州区', '0');
INSERT INTO `sys_district` VALUES ('829', '84', '丹徒区', '0');
INSERT INTO `sys_district` VALUES ('830', '84', '丹阳市', '0');
INSERT INTO `sys_district` VALUES ('831', '84', '扬中市', '0');
INSERT INTO `sys_district` VALUES ('832', '84', '句容市', '0');
INSERT INTO `sys_district` VALUES ('833', '85', '海陵区', '0');
INSERT INTO `sys_district` VALUES ('834', '85', '高港区', '0');
INSERT INTO `sys_district` VALUES ('835', '85', '兴化市', '0');
INSERT INTO `sys_district` VALUES ('836', '85', '靖江市', '0');
INSERT INTO `sys_district` VALUES ('837', '85', '泰兴市', '0');
INSERT INTO `sys_district` VALUES ('838', '85', '姜堰市', '0');
INSERT INTO `sys_district` VALUES ('839', '86', '宿城区', '0');
INSERT INTO `sys_district` VALUES ('840', '86', '宿豫区', '0');
INSERT INTO `sys_district` VALUES ('841', '86', '沭阳县', '0');
INSERT INTO `sys_district` VALUES ('842', '86', '泗阳县', '0');
INSERT INTO `sys_district` VALUES ('843', '86', '泗洪县', '0');
INSERT INTO `sys_district` VALUES ('844', '87', '上城区', '0');
INSERT INTO `sys_district` VALUES ('845', '87', '下城区', '0');
INSERT INTO `sys_district` VALUES ('846', '87', '江干区', '0');
INSERT INTO `sys_district` VALUES ('847', '87', '拱墅区', '0');
INSERT INTO `sys_district` VALUES ('848', '87', '西湖区', '0');
INSERT INTO `sys_district` VALUES ('849', '87', '滨江区', '0');
INSERT INTO `sys_district` VALUES ('850', '87', '萧山区', '0');
INSERT INTO `sys_district` VALUES ('851', '87', '余杭区', '0');
INSERT INTO `sys_district` VALUES ('852', '87', '桐庐县', '0');
INSERT INTO `sys_district` VALUES ('853', '87', '淳安县', '0');
INSERT INTO `sys_district` VALUES ('854', '87', '建德市', '0');
INSERT INTO `sys_district` VALUES ('855', '87', '富阳市', '0');
INSERT INTO `sys_district` VALUES ('856', '87', '临安市', '0');
INSERT INTO `sys_district` VALUES ('857', '88', '海曙区', '0');
INSERT INTO `sys_district` VALUES ('858', '88', '江东区', '0');
INSERT INTO `sys_district` VALUES ('859', '88', '江北区', '0');
INSERT INTO `sys_district` VALUES ('860', '88', '北仑区', '0');
INSERT INTO `sys_district` VALUES ('861', '88', '镇海区', '0');
INSERT INTO `sys_district` VALUES ('862', '88', '鄞州区', '0');
INSERT INTO `sys_district` VALUES ('863', '88', '象山县', '0');
INSERT INTO `sys_district` VALUES ('864', '88', '宁海县', '0');
INSERT INTO `sys_district` VALUES ('865', '88', '余姚市', '0');
INSERT INTO `sys_district` VALUES ('866', '88', '慈溪市', '0');
INSERT INTO `sys_district` VALUES ('867', '88', '奉化市', '0');
INSERT INTO `sys_district` VALUES ('868', '89', '鹿城区', '0');
INSERT INTO `sys_district` VALUES ('869', '89', '龙湾区', '0');
INSERT INTO `sys_district` VALUES ('870', '89', '瓯海区', '0');
INSERT INTO `sys_district` VALUES ('871', '89', '洞头县', '0');
INSERT INTO `sys_district` VALUES ('872', '89', '永嘉县', '0');
INSERT INTO `sys_district` VALUES ('873', '89', '平阳县', '0');
INSERT INTO `sys_district` VALUES ('874', '89', '苍南县', '0');
INSERT INTO `sys_district` VALUES ('875', '89', '文成县', '0');
INSERT INTO `sys_district` VALUES ('876', '89', '泰顺县', '0');
INSERT INTO `sys_district` VALUES ('877', '89', '瑞安市', '0');
INSERT INTO `sys_district` VALUES ('878', '89', '乐清市', '0');
INSERT INTO `sys_district` VALUES ('879', '90', '秀城区', '0');
INSERT INTO `sys_district` VALUES ('880', '90', '秀洲区', '0');
INSERT INTO `sys_district` VALUES ('881', '90', '嘉善县', '0');
INSERT INTO `sys_district` VALUES ('882', '90', '海盐县', '0');
INSERT INTO `sys_district` VALUES ('883', '90', '海宁市', '0');
INSERT INTO `sys_district` VALUES ('884', '90', '平湖市', '0');
INSERT INTO `sys_district` VALUES ('885', '90', '桐乡市', '0');
INSERT INTO `sys_district` VALUES ('886', '91', '吴兴区', '0');
INSERT INTO `sys_district` VALUES ('887', '91', '南浔区', '0');
INSERT INTO `sys_district` VALUES ('888', '91', '德清县', '0');
INSERT INTO `sys_district` VALUES ('889', '91', '长兴县', '0');
INSERT INTO `sys_district` VALUES ('890', '91', '安吉县', '0');
INSERT INTO `sys_district` VALUES ('891', '92', '越城区', '0');
INSERT INTO `sys_district` VALUES ('892', '92', '绍兴县', '0');
INSERT INTO `sys_district` VALUES ('893', '92', '新昌县', '0');
INSERT INTO `sys_district` VALUES ('894', '92', '诸暨市', '0');
INSERT INTO `sys_district` VALUES ('895', '92', '上虞市', '0');
INSERT INTO `sys_district` VALUES ('896', '92', '嵊州市', '0');
INSERT INTO `sys_district` VALUES ('897', '93', '婺城区', '0');
INSERT INTO `sys_district` VALUES ('898', '93', '金东区', '0');
INSERT INTO `sys_district` VALUES ('899', '93', '武义县', '0');
INSERT INTO `sys_district` VALUES ('900', '93', '浦江县', '0');
INSERT INTO `sys_district` VALUES ('901', '93', '磐安县', '0');
INSERT INTO `sys_district` VALUES ('902', '93', '兰溪市', '0');
INSERT INTO `sys_district` VALUES ('903', '93', '义乌市', '0');
INSERT INTO `sys_district` VALUES ('904', '93', '东阳市', '0');
INSERT INTO `sys_district` VALUES ('905', '93', '永康市', '0');
INSERT INTO `sys_district` VALUES ('906', '94', '柯城区', '0');
INSERT INTO `sys_district` VALUES ('907', '94', '衢江区', '0');
INSERT INTO `sys_district` VALUES ('908', '94', '常山县', '0');
INSERT INTO `sys_district` VALUES ('909', '94', '开化县', '0');
INSERT INTO `sys_district` VALUES ('910', '94', '龙游县', '0');
INSERT INTO `sys_district` VALUES ('911', '94', '江山市', '0');
INSERT INTO `sys_district` VALUES ('912', '95', '定海区', '0');
INSERT INTO `sys_district` VALUES ('913', '95', '普陀区', '0');
INSERT INTO `sys_district` VALUES ('914', '95', '岱山县', '0');
INSERT INTO `sys_district` VALUES ('915', '95', '嵊泗县', '0');
INSERT INTO `sys_district` VALUES ('916', '96', '椒江区', '0');
INSERT INTO `sys_district` VALUES ('917', '96', '黄岩区', '0');
INSERT INTO `sys_district` VALUES ('918', '96', '路桥区', '0');
INSERT INTO `sys_district` VALUES ('919', '96', '玉环县', '0');
INSERT INTO `sys_district` VALUES ('920', '96', '三门县', '0');
INSERT INTO `sys_district` VALUES ('921', '96', '天台县', '0');
INSERT INTO `sys_district` VALUES ('922', '96', '仙居县', '0');
INSERT INTO `sys_district` VALUES ('923', '96', '温岭市', '0');
INSERT INTO `sys_district` VALUES ('924', '96', '临海市', '0');
INSERT INTO `sys_district` VALUES ('925', '97', '莲都区', '0');
INSERT INTO `sys_district` VALUES ('926', '97', '青田县', '0');
INSERT INTO `sys_district` VALUES ('927', '97', '缙云县', '0');
INSERT INTO `sys_district` VALUES ('928', '97', '遂昌县', '0');
INSERT INTO `sys_district` VALUES ('929', '97', '松阳县', '0');
INSERT INTO `sys_district` VALUES ('930', '97', '云和县', '0');
INSERT INTO `sys_district` VALUES ('931', '97', '庆元县', '0');
INSERT INTO `sys_district` VALUES ('932', '97', '景宁畲族自治县', '0');
INSERT INTO `sys_district` VALUES ('933', '97', '龙泉市', '0');
INSERT INTO `sys_district` VALUES ('934', '98', '瑶海区', '0');
INSERT INTO `sys_district` VALUES ('935', '98', '庐阳区', '0');
INSERT INTO `sys_district` VALUES ('936', '98', '蜀山区', '0');
INSERT INTO `sys_district` VALUES ('937', '98', '包河区', '0');
INSERT INTO `sys_district` VALUES ('938', '98', '长丰县', '0');
INSERT INTO `sys_district` VALUES ('939', '98', '肥东县', '0');
INSERT INTO `sys_district` VALUES ('940', '98', '肥西县', '0');
INSERT INTO `sys_district` VALUES ('941', '99', '镜湖区', '0');
INSERT INTO `sys_district` VALUES ('942', '99', '马塘区', '0');
INSERT INTO `sys_district` VALUES ('943', '99', '新芜区', '0');
INSERT INTO `sys_district` VALUES ('944', '99', '鸠江区', '0');
INSERT INTO `sys_district` VALUES ('945', '99', '芜湖县', '0');
INSERT INTO `sys_district` VALUES ('946', '99', '繁昌县', '0');
INSERT INTO `sys_district` VALUES ('947', '99', '南陵县', '0');
INSERT INTO `sys_district` VALUES ('948', '100', '龙子湖区', '0');
INSERT INTO `sys_district` VALUES ('949', '100', '蚌山区', '0');
INSERT INTO `sys_district` VALUES ('950', '100', '禹会区', '0');
INSERT INTO `sys_district` VALUES ('951', '100', '淮上区', '0');
INSERT INTO `sys_district` VALUES ('952', '100', '怀远县', '0');
INSERT INTO `sys_district` VALUES ('953', '100', '五河县', '0');
INSERT INTO `sys_district` VALUES ('954', '100', '固镇县', '0');
INSERT INTO `sys_district` VALUES ('955', '101', '大通区', '0');
INSERT INTO `sys_district` VALUES ('956', '101', '田家庵区', '0');
INSERT INTO `sys_district` VALUES ('957', '101', '谢家集区', '0');
INSERT INTO `sys_district` VALUES ('958', '101', '八公山区', '0');
INSERT INTO `sys_district` VALUES ('959', '101', '潘集区', '0');
INSERT INTO `sys_district` VALUES ('960', '101', '凤台县', '0');
INSERT INTO `sys_district` VALUES ('961', '102', '金家庄区', '0');
INSERT INTO `sys_district` VALUES ('962', '102', '花山区', '0');
INSERT INTO `sys_district` VALUES ('963', '102', '雨山区', '0');
INSERT INTO `sys_district` VALUES ('964', '102', '当涂县', '0');
INSERT INTO `sys_district` VALUES ('965', '103', '杜集区', '0');
INSERT INTO `sys_district` VALUES ('966', '103', '相山区', '0');
INSERT INTO `sys_district` VALUES ('967', '103', '烈山区', '0');
INSERT INTO `sys_district` VALUES ('968', '103', '濉溪县', '0');
INSERT INTO `sys_district` VALUES ('969', '104', '铜官山区', '0');
INSERT INTO `sys_district` VALUES ('970', '104', '狮子山区', '0');
INSERT INTO `sys_district` VALUES ('971', '104', '郊区', '0');
INSERT INTO `sys_district` VALUES ('972', '104', '铜陵县', '0');
INSERT INTO `sys_district` VALUES ('973', '105', '迎江区', '0');
INSERT INTO `sys_district` VALUES ('974', '105', '大观区', '0');
INSERT INTO `sys_district` VALUES ('975', '105', '郊区', '0');
INSERT INTO `sys_district` VALUES ('976', '105', '怀宁县', '0');
INSERT INTO `sys_district` VALUES ('977', '105', '枞阳县', '0');
INSERT INTO `sys_district` VALUES ('978', '105', '潜山县', '0');
INSERT INTO `sys_district` VALUES ('979', '105', '太湖县', '0');
INSERT INTO `sys_district` VALUES ('980', '105', '宿松县', '0');
INSERT INTO `sys_district` VALUES ('981', '105', '望江县', '0');
INSERT INTO `sys_district` VALUES ('982', '105', '岳西县', '0');
INSERT INTO `sys_district` VALUES ('983', '105', '桐城市', '0');
INSERT INTO `sys_district` VALUES ('984', '106', '屯溪区', '0');
INSERT INTO `sys_district` VALUES ('985', '106', '黄山区', '0');
INSERT INTO `sys_district` VALUES ('986', '106', '徽州区', '0');
INSERT INTO `sys_district` VALUES ('987', '106', '歙县', '0');
INSERT INTO `sys_district` VALUES ('988', '106', '休宁县', '0');
INSERT INTO `sys_district` VALUES ('989', '106', '黟县', '0');
INSERT INTO `sys_district` VALUES ('990', '106', '祁门县', '0');
INSERT INTO `sys_district` VALUES ('991', '107', '琅琊区', '0');
INSERT INTO `sys_district` VALUES ('992', '107', '南谯区', '0');
INSERT INTO `sys_district` VALUES ('993', '107', '来安县', '0');
INSERT INTO `sys_district` VALUES ('994', '107', '全椒县', '0');
INSERT INTO `sys_district` VALUES ('995', '107', '定远县', '0');
INSERT INTO `sys_district` VALUES ('996', '107', '凤阳县', '0');
INSERT INTO `sys_district` VALUES ('997', '107', '天长市', '0');
INSERT INTO `sys_district` VALUES ('998', '107', '明光市', '0');
INSERT INTO `sys_district` VALUES ('999', '108', '颍州区', '0');
INSERT INTO `sys_district` VALUES ('1000', '108', '颍东区', '0');
INSERT INTO `sys_district` VALUES ('1001', '108', '颍泉区', '0');
INSERT INTO `sys_district` VALUES ('1002', '108', '临泉县', '0');
INSERT INTO `sys_district` VALUES ('1003', '108', '太和县', '0');
INSERT INTO `sys_district` VALUES ('1004', '108', '阜南县', '0');
INSERT INTO `sys_district` VALUES ('1005', '108', '颍上县', '0');
INSERT INTO `sys_district` VALUES ('1006', '108', '界首市', '0');
INSERT INTO `sys_district` VALUES ('1007', '109', '埇桥区', '0');
INSERT INTO `sys_district` VALUES ('1008', '109', '砀山县', '0');
INSERT INTO `sys_district` VALUES ('1009', '109', '萧县', '0');
INSERT INTO `sys_district` VALUES ('1010', '109', '灵璧县', '0');
INSERT INTO `sys_district` VALUES ('1011', '109', '泗县', '0');
INSERT INTO `sys_district` VALUES ('1012', '110', '居巢区', '0');
INSERT INTO `sys_district` VALUES ('1013', '110', '庐江县', '0');
INSERT INTO `sys_district` VALUES ('1014', '110', '无为县', '0');
INSERT INTO `sys_district` VALUES ('1015', '110', '含山县', '0');
INSERT INTO `sys_district` VALUES ('1016', '110', '和县', '0');
INSERT INTO `sys_district` VALUES ('1017', '111', '金安区', '0');
INSERT INTO `sys_district` VALUES ('1018', '111', '裕安区', '0');
INSERT INTO `sys_district` VALUES ('1019', '111', '寿县', '0');
INSERT INTO `sys_district` VALUES ('1020', '111', '霍邱县', '0');
INSERT INTO `sys_district` VALUES ('1021', '111', '舒城县', '0');
INSERT INTO `sys_district` VALUES ('1022', '111', '金寨县', '0');
INSERT INTO `sys_district` VALUES ('1023', '111', '霍山县', '0');
INSERT INTO `sys_district` VALUES ('1024', '112', '谯城区', '0');
INSERT INTO `sys_district` VALUES ('1025', '112', '涡阳县', '0');
INSERT INTO `sys_district` VALUES ('1026', '112', '蒙城县', '0');
INSERT INTO `sys_district` VALUES ('1027', '112', '利辛县', '0');
INSERT INTO `sys_district` VALUES ('1028', '113', '贵池区', '0');
INSERT INTO `sys_district` VALUES ('1029', '113', '东至县', '0');
INSERT INTO `sys_district` VALUES ('1030', '113', '石台县', '0');
INSERT INTO `sys_district` VALUES ('1031', '113', '青阳县', '0');
INSERT INTO `sys_district` VALUES ('1032', '114', '宣州区', '0');
INSERT INTO `sys_district` VALUES ('1033', '114', '郎溪县', '0');
INSERT INTO `sys_district` VALUES ('1034', '114', '广德县', '0');
INSERT INTO `sys_district` VALUES ('1035', '114', '泾县', '0');
INSERT INTO `sys_district` VALUES ('1036', '114', '绩溪县', '0');
INSERT INTO `sys_district` VALUES ('1037', '114', '旌德县', '0');
INSERT INTO `sys_district` VALUES ('1038', '114', '宁国市', '0');
INSERT INTO `sys_district` VALUES ('1039', '115', '鼓楼区', '0');
INSERT INTO `sys_district` VALUES ('1040', '115', '台江区', '0');
INSERT INTO `sys_district` VALUES ('1041', '115', '仓山区', '0');
INSERT INTO `sys_district` VALUES ('1042', '115', '马尾区', '0');
INSERT INTO `sys_district` VALUES ('1043', '115', '晋安区', '0');
INSERT INTO `sys_district` VALUES ('1044', '115', '闽侯县', '0');
INSERT INTO `sys_district` VALUES ('1045', '115', '连江县', '0');
INSERT INTO `sys_district` VALUES ('1046', '115', '罗源县', '0');
INSERT INTO `sys_district` VALUES ('1047', '115', '闽清县', '0');
INSERT INTO `sys_district` VALUES ('1048', '115', '永泰县', '0');
INSERT INTO `sys_district` VALUES ('1049', '115', '平潭县', '0');
INSERT INTO `sys_district` VALUES ('1050', '115', '福清市', '0');
INSERT INTO `sys_district` VALUES ('1051', '115', '长乐市', '0');
INSERT INTO `sys_district` VALUES ('1052', '116', '思明区', '0');
INSERT INTO `sys_district` VALUES ('1053', '116', '海沧区', '0');
INSERT INTO `sys_district` VALUES ('1054', '116', '湖里区', '0');
INSERT INTO `sys_district` VALUES ('1055', '116', '集美区', '0');
INSERT INTO `sys_district` VALUES ('1056', '116', '同安区', '0');
INSERT INTO `sys_district` VALUES ('1057', '116', '翔安区', '0');
INSERT INTO `sys_district` VALUES ('1058', '117', '城厢区', '0');
INSERT INTO `sys_district` VALUES ('1059', '117', '涵江区', '0');
INSERT INTO `sys_district` VALUES ('1060', '117', '荔城区', '0');
INSERT INTO `sys_district` VALUES ('1061', '117', '秀屿区', '0');
INSERT INTO `sys_district` VALUES ('1062', '117', '仙游县', '0');
INSERT INTO `sys_district` VALUES ('1063', '118', '梅列区', '0');
INSERT INTO `sys_district` VALUES ('1064', '118', '三元区', '0');
INSERT INTO `sys_district` VALUES ('1065', '118', '明溪县', '0');
INSERT INTO `sys_district` VALUES ('1066', '118', '清流县', '0');
INSERT INTO `sys_district` VALUES ('1067', '118', '宁化县', '0');
INSERT INTO `sys_district` VALUES ('1068', '118', '大田县', '0');
INSERT INTO `sys_district` VALUES ('1069', '118', '尤溪县', '0');
INSERT INTO `sys_district` VALUES ('1070', '118', '沙县', '0');
INSERT INTO `sys_district` VALUES ('1071', '118', '将乐县', '0');
INSERT INTO `sys_district` VALUES ('1072', '118', '泰宁县', '0');
INSERT INTO `sys_district` VALUES ('1073', '118', '建宁县', '0');
INSERT INTO `sys_district` VALUES ('1074', '118', '永安市', '0');
INSERT INTO `sys_district` VALUES ('1075', '119', '鲤城区', '0');
INSERT INTO `sys_district` VALUES ('1076', '119', '丰泽区', '0');
INSERT INTO `sys_district` VALUES ('1077', '119', '洛江区', '0');
INSERT INTO `sys_district` VALUES ('1078', '119', '泉港区', '0');
INSERT INTO `sys_district` VALUES ('1079', '119', '惠安县', '0');
INSERT INTO `sys_district` VALUES ('1080', '119', '安溪县', '0');
INSERT INTO `sys_district` VALUES ('1081', '119', '永春县', '0');
INSERT INTO `sys_district` VALUES ('1082', '119', '德化县', '0');
INSERT INTO `sys_district` VALUES ('1083', '119', '金门县', '0');
INSERT INTO `sys_district` VALUES ('1084', '119', '石狮市', '0');
INSERT INTO `sys_district` VALUES ('1085', '119', '晋江市', '0');
INSERT INTO `sys_district` VALUES ('1086', '119', '南安市', '0');
INSERT INTO `sys_district` VALUES ('1087', '120', '芗城区', '0');
INSERT INTO `sys_district` VALUES ('1088', '120', '龙文区', '0');
INSERT INTO `sys_district` VALUES ('1089', '120', '云霄县', '0');
INSERT INTO `sys_district` VALUES ('1090', '120', '漳浦县', '0');
INSERT INTO `sys_district` VALUES ('1091', '120', '诏安县', '0');
INSERT INTO `sys_district` VALUES ('1092', '120', '长泰县', '0');
INSERT INTO `sys_district` VALUES ('1093', '120', '东山县', '0');
INSERT INTO `sys_district` VALUES ('1094', '120', '南靖县', '0');
INSERT INTO `sys_district` VALUES ('1095', '120', '平和县', '0');
INSERT INTO `sys_district` VALUES ('1096', '120', '华安县', '0');
INSERT INTO `sys_district` VALUES ('1097', '120', '龙海市', '0');
INSERT INTO `sys_district` VALUES ('1098', '121', '延平区', '0');
INSERT INTO `sys_district` VALUES ('1099', '121', '顺昌县', '0');
INSERT INTO `sys_district` VALUES ('1100', '121', '浦城县', '0');
INSERT INTO `sys_district` VALUES ('1101', '121', '光泽县', '0');
INSERT INTO `sys_district` VALUES ('1102', '121', '松溪县', '0');
INSERT INTO `sys_district` VALUES ('1103', '121', '政和县', '0');
INSERT INTO `sys_district` VALUES ('1104', '121', '邵武市', '0');
INSERT INTO `sys_district` VALUES ('1105', '121', '武夷山市', '0');
INSERT INTO `sys_district` VALUES ('1106', '121', '建瓯市', '0');
INSERT INTO `sys_district` VALUES ('1107', '121', '建阳市', '0');
INSERT INTO `sys_district` VALUES ('1108', '122', '新罗区', '0');
INSERT INTO `sys_district` VALUES ('1109', '122', '长汀县', '0');
INSERT INTO `sys_district` VALUES ('1110', '122', '永定县', '0');
INSERT INTO `sys_district` VALUES ('1111', '122', '上杭县', '0');
INSERT INTO `sys_district` VALUES ('1112', '122', '武平县', '0');
INSERT INTO `sys_district` VALUES ('1113', '122', '连城县', '0');
INSERT INTO `sys_district` VALUES ('1114', '122', '漳平市', '0');
INSERT INTO `sys_district` VALUES ('1115', '123', '蕉城区', '0');
INSERT INTO `sys_district` VALUES ('1116', '123', '霞浦县', '0');
INSERT INTO `sys_district` VALUES ('1117', '123', '古田县', '0');
INSERT INTO `sys_district` VALUES ('1118', '123', '屏南县', '0');
INSERT INTO `sys_district` VALUES ('1119', '123', '寿宁县', '0');
INSERT INTO `sys_district` VALUES ('1120', '123', '周宁县', '0');
INSERT INTO `sys_district` VALUES ('1121', '123', '柘荣县', '0');
INSERT INTO `sys_district` VALUES ('1122', '123', '福安市', '0');
INSERT INTO `sys_district` VALUES ('1123', '123', '福鼎市', '0');
INSERT INTO `sys_district` VALUES ('1124', '124', '东湖区', '0');
INSERT INTO `sys_district` VALUES ('1125', '124', '西湖区', '0');
INSERT INTO `sys_district` VALUES ('1126', '124', '青云谱区', '0');
INSERT INTO `sys_district` VALUES ('1127', '124', '湾里区', '0');
INSERT INTO `sys_district` VALUES ('1128', '124', '青山湖区', '0');
INSERT INTO `sys_district` VALUES ('1129', '124', '南昌县', '0');
INSERT INTO `sys_district` VALUES ('1130', '124', '新建县', '0');
INSERT INTO `sys_district` VALUES ('1131', '124', '安义县', '0');
INSERT INTO `sys_district` VALUES ('1132', '124', '进贤县', '0');
INSERT INTO `sys_district` VALUES ('1133', '125', '昌江区', '0');
INSERT INTO `sys_district` VALUES ('1134', '125', '珠山区', '0');
INSERT INTO `sys_district` VALUES ('1135', '125', '浮梁县', '0');
INSERT INTO `sys_district` VALUES ('1136', '125', '乐平市', '0');
INSERT INTO `sys_district` VALUES ('1137', '126', '安源区', '0');
INSERT INTO `sys_district` VALUES ('1138', '126', '湘东区', '0');
INSERT INTO `sys_district` VALUES ('1139', '126', '莲花县', '0');
INSERT INTO `sys_district` VALUES ('1140', '126', '上栗县', '0');
INSERT INTO `sys_district` VALUES ('1141', '126', '芦溪县', '0');
INSERT INTO `sys_district` VALUES ('1142', '127', '庐山区', '0');
INSERT INTO `sys_district` VALUES ('1143', '127', '浔阳区', '0');
INSERT INTO `sys_district` VALUES ('1144', '127', '九江县', '0');
INSERT INTO `sys_district` VALUES ('1145', '127', '武宁县', '0');
INSERT INTO `sys_district` VALUES ('1146', '127', '修水县', '0');
INSERT INTO `sys_district` VALUES ('1147', '127', '永修县', '0');
INSERT INTO `sys_district` VALUES ('1148', '127', '德安县', '0');
INSERT INTO `sys_district` VALUES ('1149', '127', '星子县', '0');
INSERT INTO `sys_district` VALUES ('1150', '127', '都昌县', '0');
INSERT INTO `sys_district` VALUES ('1151', '127', '湖口县', '0');
INSERT INTO `sys_district` VALUES ('1152', '127', '彭泽县', '0');
INSERT INTO `sys_district` VALUES ('1153', '127', '瑞昌市', '0');
INSERT INTO `sys_district` VALUES ('1154', '128', '渝水区', '0');
INSERT INTO `sys_district` VALUES ('1155', '128', '分宜县', '0');
INSERT INTO `sys_district` VALUES ('1156', '129', '月湖区', '0');
INSERT INTO `sys_district` VALUES ('1157', '129', '余江县', '0');
INSERT INTO `sys_district` VALUES ('1158', '129', '贵溪市', '0');
INSERT INTO `sys_district` VALUES ('1159', '130', '章贡区', '0');
INSERT INTO `sys_district` VALUES ('1160', '130', '赣县', '0');
INSERT INTO `sys_district` VALUES ('1161', '130', '信丰县', '0');
INSERT INTO `sys_district` VALUES ('1162', '130', '大余县', '0');
INSERT INTO `sys_district` VALUES ('1163', '130', '上犹县', '0');
INSERT INTO `sys_district` VALUES ('1164', '130', '崇义县', '0');
INSERT INTO `sys_district` VALUES ('1165', '130', '安远县', '0');
INSERT INTO `sys_district` VALUES ('1166', '130', '龙南县', '0');
INSERT INTO `sys_district` VALUES ('1167', '130', '定南县', '0');
INSERT INTO `sys_district` VALUES ('1168', '130', '全南县', '0');
INSERT INTO `sys_district` VALUES ('1169', '130', '宁都县', '0');
INSERT INTO `sys_district` VALUES ('1170', '130', '于都县', '0');
INSERT INTO `sys_district` VALUES ('1171', '130', '兴国县', '0');
INSERT INTO `sys_district` VALUES ('1172', '130', '会昌县', '0');
INSERT INTO `sys_district` VALUES ('1173', '130', '寻乌县', '0');
INSERT INTO `sys_district` VALUES ('1174', '130', '石城县', '0');
INSERT INTO `sys_district` VALUES ('1175', '130', '瑞金市', '0');
INSERT INTO `sys_district` VALUES ('1176', '130', '南康市', '0');
INSERT INTO `sys_district` VALUES ('1177', '131', '吉州区', '0');
INSERT INTO `sys_district` VALUES ('1178', '131', '青原区', '0');
INSERT INTO `sys_district` VALUES ('1179', '131', '吉安县', '0');
INSERT INTO `sys_district` VALUES ('1180', '131', '吉水县', '0');
INSERT INTO `sys_district` VALUES ('1181', '131', '峡江县', '0');
INSERT INTO `sys_district` VALUES ('1182', '131', '新干县', '0');
INSERT INTO `sys_district` VALUES ('1183', '131', '永丰县', '0');
INSERT INTO `sys_district` VALUES ('1184', '131', '泰和县', '0');
INSERT INTO `sys_district` VALUES ('1185', '131', '遂川县', '0');
INSERT INTO `sys_district` VALUES ('1186', '131', '万安县', '0');
INSERT INTO `sys_district` VALUES ('1187', '131', '安福县', '0');
INSERT INTO `sys_district` VALUES ('1188', '131', '永新县', '0');
INSERT INTO `sys_district` VALUES ('1189', '131', '井冈山市', '0');
INSERT INTO `sys_district` VALUES ('1190', '132', '袁州区', '0');
INSERT INTO `sys_district` VALUES ('1191', '132', '奉新县', '0');
INSERT INTO `sys_district` VALUES ('1192', '132', '万载县', '0');
INSERT INTO `sys_district` VALUES ('1193', '132', '上高县', '0');
INSERT INTO `sys_district` VALUES ('1194', '132', '宜丰县', '0');
INSERT INTO `sys_district` VALUES ('1195', '132', '靖安县', '0');
INSERT INTO `sys_district` VALUES ('1196', '132', '铜鼓县', '0');
INSERT INTO `sys_district` VALUES ('1197', '132', '丰城市', '0');
INSERT INTO `sys_district` VALUES ('1198', '132', '樟树市', '0');
INSERT INTO `sys_district` VALUES ('1199', '132', '高安市', '0');
INSERT INTO `sys_district` VALUES ('1200', '133', '临川区', '0');
INSERT INTO `sys_district` VALUES ('1201', '133', '南城县', '0');
INSERT INTO `sys_district` VALUES ('1202', '133', '黎川县', '0');
INSERT INTO `sys_district` VALUES ('1203', '133', '南丰县', '0');
INSERT INTO `sys_district` VALUES ('1204', '133', '崇仁县', '0');
INSERT INTO `sys_district` VALUES ('1205', '133', '乐安县', '0');
INSERT INTO `sys_district` VALUES ('1206', '133', '宜黄县', '0');
INSERT INTO `sys_district` VALUES ('1207', '133', '金溪县', '0');
INSERT INTO `sys_district` VALUES ('1208', '133', '资溪县', '0');
INSERT INTO `sys_district` VALUES ('1209', '133', '东乡县', '0');
INSERT INTO `sys_district` VALUES ('1210', '133', '广昌县', '0');
INSERT INTO `sys_district` VALUES ('1211', '134', '信州区', '0');
INSERT INTO `sys_district` VALUES ('1212', '134', '上饶县', '0');
INSERT INTO `sys_district` VALUES ('1213', '134', '广丰县', '0');
INSERT INTO `sys_district` VALUES ('1214', '134', '玉山县', '0');
INSERT INTO `sys_district` VALUES ('1215', '134', '铅山县', '0');
INSERT INTO `sys_district` VALUES ('1216', '134', '横峰县', '0');
INSERT INTO `sys_district` VALUES ('1217', '134', '弋阳县', '0');
INSERT INTO `sys_district` VALUES ('1218', '134', '余干县', '0');
INSERT INTO `sys_district` VALUES ('1219', '134', '鄱阳县', '0');
INSERT INTO `sys_district` VALUES ('1220', '134', '万年县', '0');
INSERT INTO `sys_district` VALUES ('1221', '134', '婺源县', '0');
INSERT INTO `sys_district` VALUES ('1222', '134', '德兴市', '0');
INSERT INTO `sys_district` VALUES ('1223', '135', '历下区', '0');
INSERT INTO `sys_district` VALUES ('1224', '135', '市中区', '0');
INSERT INTO `sys_district` VALUES ('1225', '135', '槐荫区', '0');
INSERT INTO `sys_district` VALUES ('1226', '135', '天桥区', '0');
INSERT INTO `sys_district` VALUES ('1227', '135', '历城区', '0');
INSERT INTO `sys_district` VALUES ('1228', '135', '长清区', '0');
INSERT INTO `sys_district` VALUES ('1229', '135', '平阴县', '0');
INSERT INTO `sys_district` VALUES ('1230', '135', '济阳县', '0');
INSERT INTO `sys_district` VALUES ('1231', '135', '商河县', '0');
INSERT INTO `sys_district` VALUES ('1232', '135', '章丘市', '0');
INSERT INTO `sys_district` VALUES ('1233', '136', '市南区', '0');
INSERT INTO `sys_district` VALUES ('1234', '136', '市北区', '0');
INSERT INTO `sys_district` VALUES ('1235', '136', '四方区', '0');
INSERT INTO `sys_district` VALUES ('1236', '136', '黄岛区', '0');
INSERT INTO `sys_district` VALUES ('1237', '136', '崂山区', '0');
INSERT INTO `sys_district` VALUES ('1238', '136', '李沧区', '0');
INSERT INTO `sys_district` VALUES ('1239', '136', '城阳区', '0');
INSERT INTO `sys_district` VALUES ('1240', '136', '胶州市', '0');
INSERT INTO `sys_district` VALUES ('1241', '136', '即墨市', '0');
INSERT INTO `sys_district` VALUES ('1242', '136', '平度市', '0');
INSERT INTO `sys_district` VALUES ('1243', '136', '胶南市', '0');
INSERT INTO `sys_district` VALUES ('1244', '136', '莱西市', '0');
INSERT INTO `sys_district` VALUES ('1245', '137', '淄川区', '0');
INSERT INTO `sys_district` VALUES ('1246', '137', '张店区', '0');
INSERT INTO `sys_district` VALUES ('1247', '137', '博山区', '0');
INSERT INTO `sys_district` VALUES ('1248', '137', '临淄区', '0');
INSERT INTO `sys_district` VALUES ('1249', '137', '周村区', '0');
INSERT INTO `sys_district` VALUES ('1250', '137', '桓台县', '0');
INSERT INTO `sys_district` VALUES ('1251', '137', '高青县', '0');
INSERT INTO `sys_district` VALUES ('1252', '137', '沂源县', '0');
INSERT INTO `sys_district` VALUES ('1253', '138', '市中区', '0');
INSERT INTO `sys_district` VALUES ('1254', '138', '薛城区', '0');
INSERT INTO `sys_district` VALUES ('1255', '138', '峄城区', '0');
INSERT INTO `sys_district` VALUES ('1256', '138', '台儿庄区', '0');
INSERT INTO `sys_district` VALUES ('1257', '138', '山亭区', '0');
INSERT INTO `sys_district` VALUES ('1258', '138', '滕州市', '0');
INSERT INTO `sys_district` VALUES ('1259', '139', '东营区', '0');
INSERT INTO `sys_district` VALUES ('1260', '139', '河口区', '0');
INSERT INTO `sys_district` VALUES ('1261', '139', '垦利县', '0');
INSERT INTO `sys_district` VALUES ('1262', '139', '利津县', '0');
INSERT INTO `sys_district` VALUES ('1263', '139', '广饶县', '0');
INSERT INTO `sys_district` VALUES ('1264', '140', '芝罘区', '0');
INSERT INTO `sys_district` VALUES ('1265', '140', '福山区', '0');
INSERT INTO `sys_district` VALUES ('1266', '140', '牟平区', '0');
INSERT INTO `sys_district` VALUES ('1267', '140', '莱山区', '0');
INSERT INTO `sys_district` VALUES ('1268', '140', '长岛县', '0');
INSERT INTO `sys_district` VALUES ('1269', '140', '龙口市', '0');
INSERT INTO `sys_district` VALUES ('1270', '140', '莱阳市', '0');
INSERT INTO `sys_district` VALUES ('1271', '140', '莱州市', '0');
INSERT INTO `sys_district` VALUES ('1272', '140', '蓬莱市', '0');
INSERT INTO `sys_district` VALUES ('1273', '140', '招远市', '0');
INSERT INTO `sys_district` VALUES ('1274', '140', '栖霞市', '0');
INSERT INTO `sys_district` VALUES ('1275', '140', '海阳市', '0');
INSERT INTO `sys_district` VALUES ('1276', '141', '潍城区', '0');
INSERT INTO `sys_district` VALUES ('1277', '141', '寒亭区', '0');
INSERT INTO `sys_district` VALUES ('1278', '141', '坊子区', '0');
INSERT INTO `sys_district` VALUES ('1279', '141', '奎文区', '0');
INSERT INTO `sys_district` VALUES ('1280', '141', '临朐县', '0');
INSERT INTO `sys_district` VALUES ('1281', '141', '昌乐县', '0');
INSERT INTO `sys_district` VALUES ('1282', '141', '青州市', '0');
INSERT INTO `sys_district` VALUES ('1283', '141', '诸城市', '0');
INSERT INTO `sys_district` VALUES ('1284', '141', '寿光市', '0');
INSERT INTO `sys_district` VALUES ('1285', '141', '安丘市', '0');
INSERT INTO `sys_district` VALUES ('1286', '141', '高密市', '0');
INSERT INTO `sys_district` VALUES ('1287', '141', '昌邑市', '0');
INSERT INTO `sys_district` VALUES ('1288', '142', '市中区', '0');
INSERT INTO `sys_district` VALUES ('1289', '142', '任城区', '0');
INSERT INTO `sys_district` VALUES ('1290', '142', '微山县', '0');
INSERT INTO `sys_district` VALUES ('1291', '142', '鱼台县', '0');
INSERT INTO `sys_district` VALUES ('1292', '142', '金乡县', '0');
INSERT INTO `sys_district` VALUES ('1293', '142', '嘉祥县', '0');
INSERT INTO `sys_district` VALUES ('1294', '142', '汶上县', '0');
INSERT INTO `sys_district` VALUES ('1295', '142', '泗水县', '0');
INSERT INTO `sys_district` VALUES ('1296', '142', '梁山县', '0');
INSERT INTO `sys_district` VALUES ('1297', '142', '曲阜市', '0');
INSERT INTO `sys_district` VALUES ('1298', '142', '兖州市', '0');
INSERT INTO `sys_district` VALUES ('1299', '142', '邹城市', '0');
INSERT INTO `sys_district` VALUES ('1300', '143', '泰山区', '0');
INSERT INTO `sys_district` VALUES ('1301', '143', '岱岳区', '0');
INSERT INTO `sys_district` VALUES ('1302', '143', '宁阳县', '0');
INSERT INTO `sys_district` VALUES ('1303', '143', '东平县', '0');
INSERT INTO `sys_district` VALUES ('1304', '143', '新泰市', '0');
INSERT INTO `sys_district` VALUES ('1305', '143', '肥城市', '0');
INSERT INTO `sys_district` VALUES ('1306', '144', '环翠区', '0');
INSERT INTO `sys_district` VALUES ('1307', '144', '文登市', '0');
INSERT INTO `sys_district` VALUES ('1308', '144', '荣成市', '0');
INSERT INTO `sys_district` VALUES ('1309', '144', '乳山市', '0');
INSERT INTO `sys_district` VALUES ('1310', '145', '东港区', '0');
INSERT INTO `sys_district` VALUES ('1311', '145', '岚山区', '0');
INSERT INTO `sys_district` VALUES ('1312', '145', '五莲县', '0');
INSERT INTO `sys_district` VALUES ('1313', '145', '莒县', '0');
INSERT INTO `sys_district` VALUES ('1314', '146', '莱城区', '0');
INSERT INTO `sys_district` VALUES ('1315', '146', '钢城区', '0');
INSERT INTO `sys_district` VALUES ('1316', '147', '兰山区', '0');
INSERT INTO `sys_district` VALUES ('1317', '147', '罗庄区', '0');
INSERT INTO `sys_district` VALUES ('1318', '147', '河东区', '0');
INSERT INTO `sys_district` VALUES ('1319', '147', '沂南县', '0');
INSERT INTO `sys_district` VALUES ('1320', '147', '郯城县', '0');
INSERT INTO `sys_district` VALUES ('1321', '147', '沂水县', '0');
INSERT INTO `sys_district` VALUES ('1322', '147', '苍山县', '0');
INSERT INTO `sys_district` VALUES ('1323', '147', '费县', '0');
INSERT INTO `sys_district` VALUES ('1324', '147', '平邑县', '0');
INSERT INTO `sys_district` VALUES ('1325', '147', '莒南县', '0');
INSERT INTO `sys_district` VALUES ('1326', '147', '蒙阴县', '0');
INSERT INTO `sys_district` VALUES ('1327', '147', '临沭县', '0');
INSERT INTO `sys_district` VALUES ('1328', '148', '德城区', '0');
INSERT INTO `sys_district` VALUES ('1329', '148', '陵县', '0');
INSERT INTO `sys_district` VALUES ('1330', '148', '宁津县', '0');
INSERT INTO `sys_district` VALUES ('1331', '148', '庆云县', '0');
INSERT INTO `sys_district` VALUES ('1332', '148', '临邑县', '0');
INSERT INTO `sys_district` VALUES ('1333', '148', '齐河县', '0');
INSERT INTO `sys_district` VALUES ('1334', '148', '平原县', '0');
INSERT INTO `sys_district` VALUES ('1335', '148', '夏津县', '0');
INSERT INTO `sys_district` VALUES ('1336', '148', '武城县', '0');
INSERT INTO `sys_district` VALUES ('1337', '148', '乐陵市', '0');
INSERT INTO `sys_district` VALUES ('1338', '148', '禹城市', '0');
INSERT INTO `sys_district` VALUES ('1339', '149', '东昌府区', '0');
INSERT INTO `sys_district` VALUES ('1340', '149', '阳谷县', '0');
INSERT INTO `sys_district` VALUES ('1341', '149', '莘县', '0');
INSERT INTO `sys_district` VALUES ('1342', '149', '茌平县', '0');
INSERT INTO `sys_district` VALUES ('1343', '149', '东阿县', '0');
INSERT INTO `sys_district` VALUES ('1344', '149', '冠县', '0');
INSERT INTO `sys_district` VALUES ('1345', '149', '高唐县', '0');
INSERT INTO `sys_district` VALUES ('1346', '149', '临清市', '0');
INSERT INTO `sys_district` VALUES ('1347', '150', '滨城区', '0');
INSERT INTO `sys_district` VALUES ('1348', '150', '惠民县', '0');
INSERT INTO `sys_district` VALUES ('1349', '150', '阳信县', '0');
INSERT INTO `sys_district` VALUES ('1350', '150', '无棣县', '0');
INSERT INTO `sys_district` VALUES ('1351', '150', '沾化县', '0');
INSERT INTO `sys_district` VALUES ('1352', '150', '博兴县', '0');
INSERT INTO `sys_district` VALUES ('1353', '150', '邹平县', '0');
INSERT INTO `sys_district` VALUES ('1354', '151', '牡丹区', '0');
INSERT INTO `sys_district` VALUES ('1355', '151', '曹县', '0');
INSERT INTO `sys_district` VALUES ('1356', '151', '单县', '0');
INSERT INTO `sys_district` VALUES ('1357', '151', '成武县', '0');
INSERT INTO `sys_district` VALUES ('1358', '151', '巨野县', '0');
INSERT INTO `sys_district` VALUES ('1359', '151', '郓城县', '0');
INSERT INTO `sys_district` VALUES ('1360', '151', '鄄城县', '0');
INSERT INTO `sys_district` VALUES ('1361', '151', '定陶县', '0');
INSERT INTO `sys_district` VALUES ('1362', '151', '东明县', '0');
INSERT INTO `sys_district` VALUES ('1363', '152', '中原区', '0');
INSERT INTO `sys_district` VALUES ('1364', '152', '二七区', '0');
INSERT INTO `sys_district` VALUES ('1365', '152', '管城回族区', '0');
INSERT INTO `sys_district` VALUES ('1366', '152', '金水区', '0');
INSERT INTO `sys_district` VALUES ('1367', '152', '上街区', '0');
INSERT INTO `sys_district` VALUES ('1368', '152', '惠济区', '0');
INSERT INTO `sys_district` VALUES ('1369', '152', '中牟县', '0');
INSERT INTO `sys_district` VALUES ('1370', '152', '巩义市', '0');
INSERT INTO `sys_district` VALUES ('1371', '152', '荥阳市', '0');
INSERT INTO `sys_district` VALUES ('1372', '152', '新密市', '0');
INSERT INTO `sys_district` VALUES ('1373', '152', '新郑市', '0');
INSERT INTO `sys_district` VALUES ('1374', '152', '登封市', '0');
INSERT INTO `sys_district` VALUES ('1375', '153', '龙亭区', '0');
INSERT INTO `sys_district` VALUES ('1376', '153', '顺河回族区', '0');
INSERT INTO `sys_district` VALUES ('1377', '153', '鼓楼区', '0');
INSERT INTO `sys_district` VALUES ('1378', '153', '南关区', '0');
INSERT INTO `sys_district` VALUES ('1379', '153', '郊区', '0');
INSERT INTO `sys_district` VALUES ('1380', '153', '杞县', '0');
INSERT INTO `sys_district` VALUES ('1381', '153', '通许县', '0');
INSERT INTO `sys_district` VALUES ('1382', '153', '尉氏县', '0');
INSERT INTO `sys_district` VALUES ('1383', '153', '开封县', '0');
INSERT INTO `sys_district` VALUES ('1384', '153', '兰考县', '0');
INSERT INTO `sys_district` VALUES ('1385', '154', '老城区', '0');
INSERT INTO `sys_district` VALUES ('1386', '154', '西工区', '0');
INSERT INTO `sys_district` VALUES ('1387', '154', '廛河回族区', '0');
INSERT INTO `sys_district` VALUES ('1388', '154', '涧西区', '0');
INSERT INTO `sys_district` VALUES ('1389', '154', '吉利区', '0');
INSERT INTO `sys_district` VALUES ('1390', '154', '洛龙区', '0');
INSERT INTO `sys_district` VALUES ('1391', '154', '孟津县', '0');
INSERT INTO `sys_district` VALUES ('1392', '154', '新安县', '0');
INSERT INTO `sys_district` VALUES ('1393', '154', '栾川县', '0');
INSERT INTO `sys_district` VALUES ('1394', '154', '嵩县', '0');
INSERT INTO `sys_district` VALUES ('1395', '154', '汝阳县', '0');
INSERT INTO `sys_district` VALUES ('1396', '154', '宜阳县', '0');
INSERT INTO `sys_district` VALUES ('1397', '154', '洛宁县', '0');
INSERT INTO `sys_district` VALUES ('1398', '154', '伊川县', '0');
INSERT INTO `sys_district` VALUES ('1399', '154', '偃师市', '0');
INSERT INTO `sys_district` VALUES ('1400', '155', '新华区', '0');
INSERT INTO `sys_district` VALUES ('1401', '155', '卫东区', '0');
INSERT INTO `sys_district` VALUES ('1402', '155', '石龙区', '0');
INSERT INTO `sys_district` VALUES ('1403', '155', '湛河区', '0');
INSERT INTO `sys_district` VALUES ('1404', '155', '宝丰县', '0');
INSERT INTO `sys_district` VALUES ('1405', '155', '叶县', '0');
INSERT INTO `sys_district` VALUES ('1406', '155', '鲁山县', '0');
INSERT INTO `sys_district` VALUES ('1407', '155', '郏县', '0');
INSERT INTO `sys_district` VALUES ('1408', '155', '舞钢市', '0');
INSERT INTO `sys_district` VALUES ('1409', '155', '汝州市', '0');
INSERT INTO `sys_district` VALUES ('1410', '156', '文峰区', '0');
INSERT INTO `sys_district` VALUES ('1411', '156', '北关区', '0');
INSERT INTO `sys_district` VALUES ('1412', '156', '殷都区', '0');
INSERT INTO `sys_district` VALUES ('1413', '156', '龙安区', '0');
INSERT INTO `sys_district` VALUES ('1414', '156', '安阳县', '0');
INSERT INTO `sys_district` VALUES ('1415', '156', '汤阴县', '0');
INSERT INTO `sys_district` VALUES ('1416', '156', '滑县', '0');
INSERT INTO `sys_district` VALUES ('1417', '156', '内黄县', '0');
INSERT INTO `sys_district` VALUES ('1418', '156', '林州市', '0');
INSERT INTO `sys_district` VALUES ('1419', '157', '鹤山区', '0');
INSERT INTO `sys_district` VALUES ('1420', '157', '山城区', '0');
INSERT INTO `sys_district` VALUES ('1421', '157', '淇滨区', '0');
INSERT INTO `sys_district` VALUES ('1422', '157', '浚县', '0');
INSERT INTO `sys_district` VALUES ('1423', '157', '淇县', '0');
INSERT INTO `sys_district` VALUES ('1424', '158', '红旗区', '0');
INSERT INTO `sys_district` VALUES ('1425', '158', '卫滨区', '0');
INSERT INTO `sys_district` VALUES ('1426', '158', '凤泉区', '0');
INSERT INTO `sys_district` VALUES ('1427', '158', '牧野区', '0');
INSERT INTO `sys_district` VALUES ('1428', '158', '新乡县', '0');
INSERT INTO `sys_district` VALUES ('1429', '158', '获嘉县', '0');
INSERT INTO `sys_district` VALUES ('1430', '158', '原阳县', '0');
INSERT INTO `sys_district` VALUES ('1431', '158', '延津县', '0');
INSERT INTO `sys_district` VALUES ('1432', '158', '封丘县', '0');
INSERT INTO `sys_district` VALUES ('1433', '158', '长垣县', '0');
INSERT INTO `sys_district` VALUES ('1434', '158', '卫辉市', '0');
INSERT INTO `sys_district` VALUES ('1435', '158', '辉县市', '0');
INSERT INTO `sys_district` VALUES ('1436', '159', '解放区', '0');
INSERT INTO `sys_district` VALUES ('1437', '159', '中站区', '0');
INSERT INTO `sys_district` VALUES ('1438', '159', '马村区', '0');
INSERT INTO `sys_district` VALUES ('1439', '159', '山阳区', '0');
INSERT INTO `sys_district` VALUES ('1440', '159', '修武县', '0');
INSERT INTO `sys_district` VALUES ('1441', '159', '博爱县', '0');
INSERT INTO `sys_district` VALUES ('1442', '159', '武陟县', '0');
INSERT INTO `sys_district` VALUES ('1443', '159', '温县', '0');
INSERT INTO `sys_district` VALUES ('1444', '159', '济源市', '0');
INSERT INTO `sys_district` VALUES ('1445', '159', '沁阳市', '0');
INSERT INTO `sys_district` VALUES ('1446', '159', '孟州市', '0');
INSERT INTO `sys_district` VALUES ('1447', '160', '华龙区', '0');
INSERT INTO `sys_district` VALUES ('1448', '160', '清丰县', '0');
INSERT INTO `sys_district` VALUES ('1449', '160', '南乐县', '0');
INSERT INTO `sys_district` VALUES ('1450', '160', '范县', '0');
INSERT INTO `sys_district` VALUES ('1451', '160', '台前县', '0');
INSERT INTO `sys_district` VALUES ('1452', '160', '濮阳县', '0');
INSERT INTO `sys_district` VALUES ('1453', '161', '魏都区', '0');
INSERT INTO `sys_district` VALUES ('1454', '161', '许昌县', '0');
INSERT INTO `sys_district` VALUES ('1455', '161', '鄢陵县', '0');
INSERT INTO `sys_district` VALUES ('1456', '161', '襄城县', '0');
INSERT INTO `sys_district` VALUES ('1457', '161', '禹州市', '0');
INSERT INTO `sys_district` VALUES ('1458', '161', '长葛市', '0');
INSERT INTO `sys_district` VALUES ('1459', '162', '源汇区', '0');
INSERT INTO `sys_district` VALUES ('1460', '162', '郾城区', '0');
INSERT INTO `sys_district` VALUES ('1461', '162', '召陵区', '0');
INSERT INTO `sys_district` VALUES ('1462', '162', '舞阳县', '0');
INSERT INTO `sys_district` VALUES ('1463', '162', '临颍县', '0');
INSERT INTO `sys_district` VALUES ('1464', '163', '市辖区', '0');
INSERT INTO `sys_district` VALUES ('1465', '163', '湖滨区', '0');
INSERT INTO `sys_district` VALUES ('1466', '163', '渑池县', '0');
INSERT INTO `sys_district` VALUES ('1467', '163', '陕县', '0');
INSERT INTO `sys_district` VALUES ('1468', '163', '卢氏县', '0');
INSERT INTO `sys_district` VALUES ('1469', '163', '义马市', '0');
INSERT INTO `sys_district` VALUES ('1470', '163', '灵宝市', '0');
INSERT INTO `sys_district` VALUES ('1471', '164', '宛城区', '0');
INSERT INTO `sys_district` VALUES ('1472', '164', '卧龙区', '0');
INSERT INTO `sys_district` VALUES ('1473', '164', '南召县', '0');
INSERT INTO `sys_district` VALUES ('1474', '164', '方城县', '0');
INSERT INTO `sys_district` VALUES ('1475', '164', '西峡县', '0');
INSERT INTO `sys_district` VALUES ('1476', '164', '镇平县', '0');
INSERT INTO `sys_district` VALUES ('1477', '164', '内乡县', '0');
INSERT INTO `sys_district` VALUES ('1478', '164', '淅川县', '0');
INSERT INTO `sys_district` VALUES ('1479', '164', '社旗县', '0');
INSERT INTO `sys_district` VALUES ('1480', '164', '唐河县', '0');
INSERT INTO `sys_district` VALUES ('1481', '164', '新野县', '0');
INSERT INTO `sys_district` VALUES ('1482', '164', '桐柏县', '0');
INSERT INTO `sys_district` VALUES ('1483', '164', '邓州市', '0');
INSERT INTO `sys_district` VALUES ('1484', '165', '梁园区', '0');
INSERT INTO `sys_district` VALUES ('1485', '165', '睢阳区', '0');
INSERT INTO `sys_district` VALUES ('1486', '165', '民权县', '0');
INSERT INTO `sys_district` VALUES ('1487', '165', '睢县', '0');
INSERT INTO `sys_district` VALUES ('1488', '165', '宁陵县', '0');
INSERT INTO `sys_district` VALUES ('1489', '165', '柘城县', '0');
INSERT INTO `sys_district` VALUES ('1490', '165', '虞城县', '0');
INSERT INTO `sys_district` VALUES ('1491', '165', '夏邑县', '0');
INSERT INTO `sys_district` VALUES ('1492', '165', '永城市', '0');
INSERT INTO `sys_district` VALUES ('1493', '166', '浉河区', '0');
INSERT INTO `sys_district` VALUES ('1494', '166', '平桥区', '0');
INSERT INTO `sys_district` VALUES ('1495', '166', '罗山县', '0');
INSERT INTO `sys_district` VALUES ('1496', '166', '光山县', '0');
INSERT INTO `sys_district` VALUES ('1497', '166', '新县', '0');
INSERT INTO `sys_district` VALUES ('1498', '166', '商城县', '0');
INSERT INTO `sys_district` VALUES ('1499', '166', '固始县', '0');
INSERT INTO `sys_district` VALUES ('1500', '166', '潢川县', '0');
INSERT INTO `sys_district` VALUES ('1501', '166', '淮滨县', '0');
INSERT INTO `sys_district` VALUES ('1502', '166', '息县', '0');
INSERT INTO `sys_district` VALUES ('1503', '167', '川汇区', '0');
INSERT INTO `sys_district` VALUES ('1504', '167', '扶沟县', '0');
INSERT INTO `sys_district` VALUES ('1505', '167', '西华县', '0');
INSERT INTO `sys_district` VALUES ('1506', '167', '商水县', '0');
INSERT INTO `sys_district` VALUES ('1507', '167', '沈丘县', '0');
INSERT INTO `sys_district` VALUES ('1508', '167', '郸城县', '0');
INSERT INTO `sys_district` VALUES ('1509', '167', '淮阳县', '0');
INSERT INTO `sys_district` VALUES ('1510', '167', '太康县', '0');
INSERT INTO `sys_district` VALUES ('1511', '167', '鹿邑县', '0');
INSERT INTO `sys_district` VALUES ('1512', '167', '项城市', '0');
INSERT INTO `sys_district` VALUES ('1513', '168', '驿城区', '0');
INSERT INTO `sys_district` VALUES ('1514', '168', '西平县', '0');
INSERT INTO `sys_district` VALUES ('1515', '168', '上蔡县', '0');
INSERT INTO `sys_district` VALUES ('1516', '168', '平舆县', '0');
INSERT INTO `sys_district` VALUES ('1517', '168', '正阳县', '0');
INSERT INTO `sys_district` VALUES ('1518', '168', '确山县', '0');
INSERT INTO `sys_district` VALUES ('1519', '168', '泌阳县', '0');
INSERT INTO `sys_district` VALUES ('1520', '168', '汝南县', '0');
INSERT INTO `sys_district` VALUES ('1521', '168', '遂平县', '0');
INSERT INTO `sys_district` VALUES ('1522', '168', '新蔡县', '0');
INSERT INTO `sys_district` VALUES ('1523', '169', '江岸区', '0');
INSERT INTO `sys_district` VALUES ('1524', '169', '江汉区', '0');
INSERT INTO `sys_district` VALUES ('1525', '169', '硚口区', '0');
INSERT INTO `sys_district` VALUES ('1526', '169', '汉阳区', '0');
INSERT INTO `sys_district` VALUES ('1527', '169', '武昌区', '0');
INSERT INTO `sys_district` VALUES ('1528', '169', '青山区', '0');
INSERT INTO `sys_district` VALUES ('1529', '169', '洪山区', '0');
INSERT INTO `sys_district` VALUES ('1530', '169', '东西湖区', '0');
INSERT INTO `sys_district` VALUES ('1531', '169', '汉南区', '0');
INSERT INTO `sys_district` VALUES ('1532', '169', '蔡甸区', '0');
INSERT INTO `sys_district` VALUES ('1533', '169', '江夏区', '0');
INSERT INTO `sys_district` VALUES ('1534', '169', '黄陂区', '0');
INSERT INTO `sys_district` VALUES ('1535', '169', '新洲区', '0');
INSERT INTO `sys_district` VALUES ('1536', '170', '黄石港区', '0');
INSERT INTO `sys_district` VALUES ('1537', '170', '西塞山区', '0');
INSERT INTO `sys_district` VALUES ('1538', '170', '下陆区', '0');
INSERT INTO `sys_district` VALUES ('1539', '170', '铁山区', '0');
INSERT INTO `sys_district` VALUES ('1540', '170', '阳新县', '0');
INSERT INTO `sys_district` VALUES ('1541', '170', '大冶市', '0');
INSERT INTO `sys_district` VALUES ('1542', '171', '茅箭区', '0');
INSERT INTO `sys_district` VALUES ('1543', '171', '张湾区', '0');
INSERT INTO `sys_district` VALUES ('1544', '171', '郧县', '0');
INSERT INTO `sys_district` VALUES ('1545', '171', '郧西县', '0');
INSERT INTO `sys_district` VALUES ('1546', '171', '竹山县', '0');
INSERT INTO `sys_district` VALUES ('1547', '171', '竹溪县', '0');
INSERT INTO `sys_district` VALUES ('1548', '171', '房县', '0');
INSERT INTO `sys_district` VALUES ('1549', '171', '丹江口市', '0');
INSERT INTO `sys_district` VALUES ('1550', '172', '西陵区', '0');
INSERT INTO `sys_district` VALUES ('1551', '172', '伍家岗区', '0');
INSERT INTO `sys_district` VALUES ('1552', '172', '点军区', '0');
INSERT INTO `sys_district` VALUES ('1553', '172', '猇亭区', '0');
INSERT INTO `sys_district` VALUES ('1554', '172', '夷陵区', '0');
INSERT INTO `sys_district` VALUES ('1555', '172', '远安县', '0');
INSERT INTO `sys_district` VALUES ('1556', '172', '兴山县', '0');
INSERT INTO `sys_district` VALUES ('1557', '172', '秭归县', '0');
INSERT INTO `sys_district` VALUES ('1558', '172', '长阳土家族自治县', '0');
INSERT INTO `sys_district` VALUES ('1559', '172', '五峰土家族自治县', '0');
INSERT INTO `sys_district` VALUES ('1560', '172', '宜都市', '0');
INSERT INTO `sys_district` VALUES ('1561', '172', '当阳市', '0');
INSERT INTO `sys_district` VALUES ('1562', '172', '枝江市', '0');
INSERT INTO `sys_district` VALUES ('1563', '173', '襄城区', '0');
INSERT INTO `sys_district` VALUES ('1564', '173', '樊城区', '0');
INSERT INTO `sys_district` VALUES ('1565', '173', '襄阳区', '0');
INSERT INTO `sys_district` VALUES ('1566', '173', '南漳县', '0');
INSERT INTO `sys_district` VALUES ('1567', '173', '谷城县', '0');
INSERT INTO `sys_district` VALUES ('1568', '173', '保康县', '0');
INSERT INTO `sys_district` VALUES ('1569', '173', '老河口市', '0');
INSERT INTO `sys_district` VALUES ('1570', '173', '枣阳市', '0');
INSERT INTO `sys_district` VALUES ('1571', '173', '宜城市', '0');
INSERT INTO `sys_district` VALUES ('1572', '174', '梁子湖区', '0');
INSERT INTO `sys_district` VALUES ('1573', '174', '华容区', '0');
INSERT INTO `sys_district` VALUES ('1574', '174', '鄂城区', '0');
INSERT INTO `sys_district` VALUES ('1575', '175', '东宝区', '0');
INSERT INTO `sys_district` VALUES ('1576', '175', '掇刀区', '0');
INSERT INTO `sys_district` VALUES ('1577', '175', '京山县', '0');
INSERT INTO `sys_district` VALUES ('1578', '175', '沙洋县', '0');
INSERT INTO `sys_district` VALUES ('1579', '175', '钟祥市', '0');
INSERT INTO `sys_district` VALUES ('1580', '176', '孝南区', '0');
INSERT INTO `sys_district` VALUES ('1581', '176', '孝昌县', '0');
INSERT INTO `sys_district` VALUES ('1582', '176', '大悟县', '0');
INSERT INTO `sys_district` VALUES ('1583', '176', '云梦县', '0');
INSERT INTO `sys_district` VALUES ('1584', '176', '应城市', '0');
INSERT INTO `sys_district` VALUES ('1585', '176', '安陆市', '0');
INSERT INTO `sys_district` VALUES ('1586', '176', '汉川市', '0');
INSERT INTO `sys_district` VALUES ('1587', '177', '沙市区', '0');
INSERT INTO `sys_district` VALUES ('1588', '177', '荆州区', '0');
INSERT INTO `sys_district` VALUES ('1589', '177', '公安县', '0');
INSERT INTO `sys_district` VALUES ('1590', '177', '监利县', '0');
INSERT INTO `sys_district` VALUES ('1591', '177', '江陵县', '0');
INSERT INTO `sys_district` VALUES ('1592', '177', '石首市', '0');
INSERT INTO `sys_district` VALUES ('1593', '177', '洪湖市', '0');
INSERT INTO `sys_district` VALUES ('1594', '177', '松滋市', '0');
INSERT INTO `sys_district` VALUES ('1595', '178', '黄州区', '0');
INSERT INTO `sys_district` VALUES ('1596', '178', '团风县', '0');
INSERT INTO `sys_district` VALUES ('1597', '178', '红安县', '0');
INSERT INTO `sys_district` VALUES ('1598', '178', '罗田县', '0');
INSERT INTO `sys_district` VALUES ('1599', '178', '英山县', '0');
INSERT INTO `sys_district` VALUES ('1600', '178', '浠水县', '0');
INSERT INTO `sys_district` VALUES ('1601', '178', '蕲春县', '0');
INSERT INTO `sys_district` VALUES ('1602', '178', '黄梅县', '0');
INSERT INTO `sys_district` VALUES ('1603', '178', '麻城市', '0');
INSERT INTO `sys_district` VALUES ('1604', '178', '武穴市', '0');
INSERT INTO `sys_district` VALUES ('1605', '179', '咸安区', '0');
INSERT INTO `sys_district` VALUES ('1606', '179', '嘉鱼县', '0');
INSERT INTO `sys_district` VALUES ('1607', '179', '通城县', '0');
INSERT INTO `sys_district` VALUES ('1608', '179', '崇阳县', '0');
INSERT INTO `sys_district` VALUES ('1609', '179', '通山县', '0');
INSERT INTO `sys_district` VALUES ('1610', '179', '赤壁市', '0');
INSERT INTO `sys_district` VALUES ('1611', '180', '曾都区', '0');
INSERT INTO `sys_district` VALUES ('1612', '180', '广水市', '0');
INSERT INTO `sys_district` VALUES ('1613', '181', '恩施市', '0');
INSERT INTO `sys_district` VALUES ('1614', '181', '利川市', '0');
INSERT INTO `sys_district` VALUES ('1615', '181', '建始县', '0');
INSERT INTO `sys_district` VALUES ('1616', '181', '巴东县', '0');
INSERT INTO `sys_district` VALUES ('1617', '181', '宣恩县', '0');
INSERT INTO `sys_district` VALUES ('1618', '181', '咸丰县', '0');
INSERT INTO `sys_district` VALUES ('1619', '181', '来凤县', '0');
INSERT INTO `sys_district` VALUES ('1620', '181', '鹤峰县', '0');
INSERT INTO `sys_district` VALUES ('1621', '182', '仙桃市', '0');
INSERT INTO `sys_district` VALUES ('1622', '182', '潜江市', '0');
INSERT INTO `sys_district` VALUES ('1623', '182', '天门市', '0');
INSERT INTO `sys_district` VALUES ('1624', '182', '神农架林区', '0');
INSERT INTO `sys_district` VALUES ('1625', '183', '芙蓉区', '0');
INSERT INTO `sys_district` VALUES ('1626', '183', '天心区', '0');
INSERT INTO `sys_district` VALUES ('1627', '183', '岳麓区', '0');
INSERT INTO `sys_district` VALUES ('1628', '183', '开福区', '0');
INSERT INTO `sys_district` VALUES ('1629', '183', '雨花区', '0');
INSERT INTO `sys_district` VALUES ('1630', '183', '长沙县', '0');
INSERT INTO `sys_district` VALUES ('1631', '183', '望城县', '0');
INSERT INTO `sys_district` VALUES ('1632', '183', '宁乡县', '0');
INSERT INTO `sys_district` VALUES ('1633', '183', '浏阳市', '0');
INSERT INTO `sys_district` VALUES ('1634', '184', '荷塘区', '0');
INSERT INTO `sys_district` VALUES ('1635', '184', '芦淞区', '0');
INSERT INTO `sys_district` VALUES ('1636', '184', '石峰区', '0');
INSERT INTO `sys_district` VALUES ('1637', '184', '天元区', '0');
INSERT INTO `sys_district` VALUES ('1638', '184', '株洲县', '0');
INSERT INTO `sys_district` VALUES ('1639', '184', '攸县', '0');
INSERT INTO `sys_district` VALUES ('1640', '184', '茶陵县', '0');
INSERT INTO `sys_district` VALUES ('1641', '184', '炎陵县', '0');
INSERT INTO `sys_district` VALUES ('1642', '184', '醴陵市', '0');
INSERT INTO `sys_district` VALUES ('1643', '185', '雨湖区', '0');
INSERT INTO `sys_district` VALUES ('1644', '185', '岳塘区', '0');
INSERT INTO `sys_district` VALUES ('1645', '185', '湘潭县', '0');
INSERT INTO `sys_district` VALUES ('1646', '185', '湘乡市', '0');
INSERT INTO `sys_district` VALUES ('1647', '185', '韶山市', '0');
INSERT INTO `sys_district` VALUES ('1648', '186', '珠晖区', '0');
INSERT INTO `sys_district` VALUES ('1649', '186', '雁峰区', '0');
INSERT INTO `sys_district` VALUES ('1650', '186', '石鼓区', '0');
INSERT INTO `sys_district` VALUES ('1651', '186', '蒸湘区', '0');
INSERT INTO `sys_district` VALUES ('1652', '186', '南岳区', '0');
INSERT INTO `sys_district` VALUES ('1653', '186', '衡阳县', '0');
INSERT INTO `sys_district` VALUES ('1654', '186', '衡南县', '0');
INSERT INTO `sys_district` VALUES ('1655', '186', '衡山县', '0');
INSERT INTO `sys_district` VALUES ('1656', '186', '衡东县', '0');
INSERT INTO `sys_district` VALUES ('1657', '186', '祁东县', '0');
INSERT INTO `sys_district` VALUES ('1658', '186', '耒阳市', '0');
INSERT INTO `sys_district` VALUES ('1659', '186', '常宁市', '0');
INSERT INTO `sys_district` VALUES ('1660', '187', '双清区', '0');
INSERT INTO `sys_district` VALUES ('1661', '187', '大祥区', '0');
INSERT INTO `sys_district` VALUES ('1662', '187', '北塔区', '0');
INSERT INTO `sys_district` VALUES ('1663', '187', '邵东县', '0');
INSERT INTO `sys_district` VALUES ('1664', '187', '新邵县', '0');
INSERT INTO `sys_district` VALUES ('1665', '187', '邵阳县', '0');
INSERT INTO `sys_district` VALUES ('1666', '187', '隆回县', '0');
INSERT INTO `sys_district` VALUES ('1667', '187', '洞口县', '0');
INSERT INTO `sys_district` VALUES ('1668', '187', '绥宁县', '0');
INSERT INTO `sys_district` VALUES ('1669', '187', '新宁县', '0');
INSERT INTO `sys_district` VALUES ('1670', '187', '城步苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1671', '187', '武冈市', '0');
INSERT INTO `sys_district` VALUES ('1672', '188', '岳阳楼区', '0');
INSERT INTO `sys_district` VALUES ('1673', '188', '云溪区', '0');
INSERT INTO `sys_district` VALUES ('1674', '188', '君山区', '0');
INSERT INTO `sys_district` VALUES ('1675', '188', '岳阳县', '0');
INSERT INTO `sys_district` VALUES ('1676', '188', '华容县', '0');
INSERT INTO `sys_district` VALUES ('1677', '188', '湘阴县', '0');
INSERT INTO `sys_district` VALUES ('1678', '188', '平江县', '0');
INSERT INTO `sys_district` VALUES ('1679', '188', '汨罗市', '0');
INSERT INTO `sys_district` VALUES ('1680', '188', '临湘市', '0');
INSERT INTO `sys_district` VALUES ('1681', '189', '武陵区', '0');
INSERT INTO `sys_district` VALUES ('1682', '189', '鼎城区', '0');
INSERT INTO `sys_district` VALUES ('1683', '189', '安乡县', '0');
INSERT INTO `sys_district` VALUES ('1684', '189', '汉寿县', '0');
INSERT INTO `sys_district` VALUES ('1685', '189', '澧县', '0');
INSERT INTO `sys_district` VALUES ('1686', '189', '临澧县', '0');
INSERT INTO `sys_district` VALUES ('1687', '189', '桃源县', '0');
INSERT INTO `sys_district` VALUES ('1688', '189', '石门县', '0');
INSERT INTO `sys_district` VALUES ('1689', '189', '津市市', '0');
INSERT INTO `sys_district` VALUES ('1690', '190', '永定区', '0');
INSERT INTO `sys_district` VALUES ('1691', '190', '武陵源区', '0');
INSERT INTO `sys_district` VALUES ('1692', '190', '慈利县', '0');
INSERT INTO `sys_district` VALUES ('1693', '190', '桑植县', '0');
INSERT INTO `sys_district` VALUES ('1694', '191', '资阳区', '0');
INSERT INTO `sys_district` VALUES ('1695', '191', '赫山区', '0');
INSERT INTO `sys_district` VALUES ('1696', '191', '南县', '0');
INSERT INTO `sys_district` VALUES ('1697', '191', '桃江县', '0');
INSERT INTO `sys_district` VALUES ('1698', '191', '安化县', '0');
INSERT INTO `sys_district` VALUES ('1699', '191', '沅江市', '0');
INSERT INTO `sys_district` VALUES ('1700', '192', '北湖区', '0');
INSERT INTO `sys_district` VALUES ('1701', '192', '苏仙区', '0');
INSERT INTO `sys_district` VALUES ('1702', '192', '桂阳县', '0');
INSERT INTO `sys_district` VALUES ('1703', '192', '宜章县', '0');
INSERT INTO `sys_district` VALUES ('1704', '192', '永兴县', '0');
INSERT INTO `sys_district` VALUES ('1705', '192', '嘉禾县', '0');
INSERT INTO `sys_district` VALUES ('1706', '192', '临武县', '0');
INSERT INTO `sys_district` VALUES ('1707', '192', '汝城县', '0');
INSERT INTO `sys_district` VALUES ('1708', '192', '桂东县', '0');
INSERT INTO `sys_district` VALUES ('1709', '192', '安仁县', '0');
INSERT INTO `sys_district` VALUES ('1710', '192', '资兴市', '0');
INSERT INTO `sys_district` VALUES ('1711', '193', '芝山区', '0');
INSERT INTO `sys_district` VALUES ('1712', '193', '冷水滩区', '0');
INSERT INTO `sys_district` VALUES ('1713', '193', '祁阳县', '0');
INSERT INTO `sys_district` VALUES ('1714', '193', '东安县', '0');
INSERT INTO `sys_district` VALUES ('1715', '193', '双牌县', '0');
INSERT INTO `sys_district` VALUES ('1716', '193', '道县', '0');
INSERT INTO `sys_district` VALUES ('1717', '193', '江永县', '0');
INSERT INTO `sys_district` VALUES ('1718', '193', '宁远县', '0');
INSERT INTO `sys_district` VALUES ('1719', '193', '蓝山县', '0');
INSERT INTO `sys_district` VALUES ('1720', '193', '新田县', '0');
INSERT INTO `sys_district` VALUES ('1721', '193', '江华瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1722', '194', '鹤城区', '0');
INSERT INTO `sys_district` VALUES ('1723', '194', '中方县', '0');
INSERT INTO `sys_district` VALUES ('1724', '194', '沅陵县', '0');
INSERT INTO `sys_district` VALUES ('1725', '194', '辰溪县', '0');
INSERT INTO `sys_district` VALUES ('1726', '194', '溆浦县', '0');
INSERT INTO `sys_district` VALUES ('1727', '194', '会同县', '0');
INSERT INTO `sys_district` VALUES ('1728', '194', '麻阳苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1729', '194', '新晃侗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1730', '194', '芷江侗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1731', '194', '靖州苗族侗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1732', '194', '通道侗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1733', '194', '洪江市', '0');
INSERT INTO `sys_district` VALUES ('1734', '195', '娄星区', '0');
INSERT INTO `sys_district` VALUES ('1735', '195', '双峰县', '0');
INSERT INTO `sys_district` VALUES ('1736', '195', '新化县', '0');
INSERT INTO `sys_district` VALUES ('1737', '195', '冷水江市', '0');
INSERT INTO `sys_district` VALUES ('1738', '195', '涟源市', '0');
INSERT INTO `sys_district` VALUES ('1739', '196', '吉首市', '0');
INSERT INTO `sys_district` VALUES ('1740', '196', '泸溪县', '0');
INSERT INTO `sys_district` VALUES ('1741', '196', '凤凰县', '0');
INSERT INTO `sys_district` VALUES ('1742', '196', '花垣县', '0');
INSERT INTO `sys_district` VALUES ('1743', '196', '保靖县', '0');
INSERT INTO `sys_district` VALUES ('1744', '196', '古丈县', '0');
INSERT INTO `sys_district` VALUES ('1745', '196', '永顺县', '0');
INSERT INTO `sys_district` VALUES ('1746', '196', '龙山县', '0');
INSERT INTO `sys_district` VALUES ('1747', '197', '东山区', '0');
INSERT INTO `sys_district` VALUES ('1748', '197', '荔湾区', '0');
INSERT INTO `sys_district` VALUES ('1749', '197', '越秀区', '0');
INSERT INTO `sys_district` VALUES ('1750', '197', '海珠区', '0');
INSERT INTO `sys_district` VALUES ('1751', '197', '天河区', '0');
INSERT INTO `sys_district` VALUES ('1752', '197', '芳村区', '0');
INSERT INTO `sys_district` VALUES ('1753', '197', '白云区', '0');
INSERT INTO `sys_district` VALUES ('1754', '197', '黄埔区', '0');
INSERT INTO `sys_district` VALUES ('1755', '197', '番禺区', '0');
INSERT INTO `sys_district` VALUES ('1756', '197', '花都区', '0');
INSERT INTO `sys_district` VALUES ('1757', '197', '增城市', '0');
INSERT INTO `sys_district` VALUES ('1759', '198', '武江区', '0');
INSERT INTO `sys_district` VALUES ('1760', '198', '浈江区', '0');
INSERT INTO `sys_district` VALUES ('1761', '198', '曲江区', '0');
INSERT INTO `sys_district` VALUES ('1762', '198', '始兴县', '0');
INSERT INTO `sys_district` VALUES ('1763', '198', '仁化县', '0');
INSERT INTO `sys_district` VALUES ('1764', '198', '翁源县', '0');
INSERT INTO `sys_district` VALUES ('1765', '198', '乳源瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1766', '198', '新丰县', '0');
INSERT INTO `sys_district` VALUES ('1767', '198', '乐昌市', '0');
INSERT INTO `sys_district` VALUES ('1768', '198', '南雄市', '0');
INSERT INTO `sys_district` VALUES ('1769', '199', '罗湖区', '0');
INSERT INTO `sys_district` VALUES ('1770', '199', '福田区', '0');
INSERT INTO `sys_district` VALUES ('1771', '199', '南山区', '0');
INSERT INTO `sys_district` VALUES ('1772', '199', '宝安区', '0');
INSERT INTO `sys_district` VALUES ('1773', '199', '龙岗区', '0');
INSERT INTO `sys_district` VALUES ('1774', '199', '盐田区', '0');
INSERT INTO `sys_district` VALUES ('1775', '200', '香洲区', '0');
INSERT INTO `sys_district` VALUES ('1776', '200', '斗门区', '0');
INSERT INTO `sys_district` VALUES ('1777', '200', '金湾区', '0');
INSERT INTO `sys_district` VALUES ('1778', '201', '龙湖区', '0');
INSERT INTO `sys_district` VALUES ('1779', '201', '金平区', '0');
INSERT INTO `sys_district` VALUES ('1780', '201', '濠江区', '0');
INSERT INTO `sys_district` VALUES ('1781', '201', '潮阳区', '0');
INSERT INTO `sys_district` VALUES ('1782', '201', '潮南区', '0');
INSERT INTO `sys_district` VALUES ('1783', '201', '澄海区', '0');
INSERT INTO `sys_district` VALUES ('1784', '201', '南澳县', '0');
INSERT INTO `sys_district` VALUES ('1785', '202', '禅城区', '0');
INSERT INTO `sys_district` VALUES ('1786', '202', '南海区', '0');
INSERT INTO `sys_district` VALUES ('1787', '202', '顺德区', '0');
INSERT INTO `sys_district` VALUES ('1788', '202', '三水区', '0');
INSERT INTO `sys_district` VALUES ('1789', '202', '高明区', '0');
INSERT INTO `sys_district` VALUES ('1790', '203', '蓬江区', '0');
INSERT INTO `sys_district` VALUES ('1791', '203', '江海区', '0');
INSERT INTO `sys_district` VALUES ('1792', '203', '新会区', '0');
INSERT INTO `sys_district` VALUES ('1793', '203', '台山市', '0');
INSERT INTO `sys_district` VALUES ('1794', '203', '开平市', '0');
INSERT INTO `sys_district` VALUES ('1795', '203', '鹤山市', '0');
INSERT INTO `sys_district` VALUES ('1796', '203', '恩平市', '0');
INSERT INTO `sys_district` VALUES ('1797', '204', '赤坎区', '0');
INSERT INTO `sys_district` VALUES ('1798', '204', '霞山区', '0');
INSERT INTO `sys_district` VALUES ('1799', '204', '坡头区', '0');
INSERT INTO `sys_district` VALUES ('1800', '204', '麻章区', '0');
INSERT INTO `sys_district` VALUES ('1801', '204', '遂溪县', '0');
INSERT INTO `sys_district` VALUES ('1802', '204', '徐闻县', '0');
INSERT INTO `sys_district` VALUES ('1803', '204', '廉江市', '0');
INSERT INTO `sys_district` VALUES ('1804', '204', '雷州市', '0');
INSERT INTO `sys_district` VALUES ('1805', '204', '吴川市', '0');
INSERT INTO `sys_district` VALUES ('1806', '205', '茂南区', '0');
INSERT INTO `sys_district` VALUES ('1807', '205', '茂港区', '0');
INSERT INTO `sys_district` VALUES ('1808', '205', '电白县', '0');
INSERT INTO `sys_district` VALUES ('1809', '205', '高州市', '0');
INSERT INTO `sys_district` VALUES ('1810', '205', '化州市', '0');
INSERT INTO `sys_district` VALUES ('1811', '205', '信宜市', '0');
INSERT INTO `sys_district` VALUES ('1812', '206', '端州区', '0');
INSERT INTO `sys_district` VALUES ('1813', '206', '鼎湖区', '0');
INSERT INTO `sys_district` VALUES ('1814', '206', '广宁县', '0');
INSERT INTO `sys_district` VALUES ('1815', '206', '怀集县', '0');
INSERT INTO `sys_district` VALUES ('1816', '206', '封开县', '0');
INSERT INTO `sys_district` VALUES ('1817', '206', '德庆县', '0');
INSERT INTO `sys_district` VALUES ('1818', '206', '高要市', '0');
INSERT INTO `sys_district` VALUES ('1819', '206', '四会市', '0');
INSERT INTO `sys_district` VALUES ('1820', '207', '惠城区', '0');
INSERT INTO `sys_district` VALUES ('1821', '207', '惠阳区', '0');
INSERT INTO `sys_district` VALUES ('1822', '207', '博罗县', '0');
INSERT INTO `sys_district` VALUES ('1823', '207', '惠东县', '0');
INSERT INTO `sys_district` VALUES ('1824', '207', '龙门县', '0');
INSERT INTO `sys_district` VALUES ('1825', '208', '梅江区', '0');
INSERT INTO `sys_district` VALUES ('1826', '208', '梅县', '0');
INSERT INTO `sys_district` VALUES ('1827', '208', '大埔县', '0');
INSERT INTO `sys_district` VALUES ('1828', '208', '丰顺县', '0');
INSERT INTO `sys_district` VALUES ('1829', '208', '五华县', '0');
INSERT INTO `sys_district` VALUES ('1830', '208', '平远县', '0');
INSERT INTO `sys_district` VALUES ('1831', '208', '蕉岭县', '0');
INSERT INTO `sys_district` VALUES ('1832', '208', '兴宁市', '0');
INSERT INTO `sys_district` VALUES ('1833', '209', '城区', '0');
INSERT INTO `sys_district` VALUES ('1834', '209', '海丰县', '0');
INSERT INTO `sys_district` VALUES ('1835', '209', '陆河县', '0');
INSERT INTO `sys_district` VALUES ('1836', '209', '陆丰市', '0');
INSERT INTO `sys_district` VALUES ('1837', '210', '源城区', '0');
INSERT INTO `sys_district` VALUES ('1838', '210', '紫金县', '0');
INSERT INTO `sys_district` VALUES ('1839', '210', '龙川县', '0');
INSERT INTO `sys_district` VALUES ('1840', '210', '连平县', '0');
INSERT INTO `sys_district` VALUES ('1841', '210', '和平县', '0');
INSERT INTO `sys_district` VALUES ('1842', '210', '东源县', '0');
INSERT INTO `sys_district` VALUES ('1843', '211', '江城区', '0');
INSERT INTO `sys_district` VALUES ('1844', '211', '阳西县', '0');
INSERT INTO `sys_district` VALUES ('1845', '211', '阳东县', '0');
INSERT INTO `sys_district` VALUES ('1846', '211', '阳春市', '0');
INSERT INTO `sys_district` VALUES ('1847', '212', '清城区', '0');
INSERT INTO `sys_district` VALUES ('1848', '212', '佛冈县', '0');
INSERT INTO `sys_district` VALUES ('1849', '212', '阳山县', '0');
INSERT INTO `sys_district` VALUES ('1850', '212', '连山壮族瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1851', '212', '连南瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1852', '212', '清新县', '0');
INSERT INTO `sys_district` VALUES ('1853', '212', '英德市', '0');
INSERT INTO `sys_district` VALUES ('1854', '212', '连州市', '0');
INSERT INTO `sys_district` VALUES ('1855', '215', '湘桥区', '0');
INSERT INTO `sys_district` VALUES ('1856', '215', '潮安县', '0');
INSERT INTO `sys_district` VALUES ('1857', '215', '饶平县', '0');
INSERT INTO `sys_district` VALUES ('1858', '216', '榕城区', '0');
INSERT INTO `sys_district` VALUES ('1859', '216', '揭东县', '0');
INSERT INTO `sys_district` VALUES ('1860', '216', '揭西县', '0');
INSERT INTO `sys_district` VALUES ('1861', '216', '惠来县', '0');
INSERT INTO `sys_district` VALUES ('1862', '216', '普宁市', '0');
INSERT INTO `sys_district` VALUES ('1863', '217', '云城区', '0');
INSERT INTO `sys_district` VALUES ('1864', '217', '新兴县', '0');
INSERT INTO `sys_district` VALUES ('1865', '217', '郁南县', '0');
INSERT INTO `sys_district` VALUES ('1866', '217', '云安县', '0');
INSERT INTO `sys_district` VALUES ('1867', '217', '罗定市', '0');
INSERT INTO `sys_district` VALUES ('1868', '218', '兴宁区', '0');
INSERT INTO `sys_district` VALUES ('1869', '218', '青秀区', '0');
INSERT INTO `sys_district` VALUES ('1870', '218', '江南区', '0');
INSERT INTO `sys_district` VALUES ('1871', '218', '西乡塘区', '0');
INSERT INTO `sys_district` VALUES ('1872', '218', '良庆区', '0');
INSERT INTO `sys_district` VALUES ('1873', '218', '邕宁区', '0');
INSERT INTO `sys_district` VALUES ('1874', '218', '武鸣县', '0');
INSERT INTO `sys_district` VALUES ('1875', '218', '隆安县', '0');
INSERT INTO `sys_district` VALUES ('1876', '218', '马山县', '0');
INSERT INTO `sys_district` VALUES ('1877', '218', '上林县', '0');
INSERT INTO `sys_district` VALUES ('1878', '218', '宾阳县', '0');
INSERT INTO `sys_district` VALUES ('1879', '218', '横县', '0');
INSERT INTO `sys_district` VALUES ('1880', '219', '城中区', '0');
INSERT INTO `sys_district` VALUES ('1881', '219', '鱼峰区', '0');
INSERT INTO `sys_district` VALUES ('1882', '219', '柳南区', '0');
INSERT INTO `sys_district` VALUES ('1883', '219', '柳北区', '0');
INSERT INTO `sys_district` VALUES ('1884', '219', '柳江县', '0');
INSERT INTO `sys_district` VALUES ('1885', '219', '柳城县', '0');
INSERT INTO `sys_district` VALUES ('1886', '219', '鹿寨县', '0');
INSERT INTO `sys_district` VALUES ('1887', '219', '融安县', '0');
INSERT INTO `sys_district` VALUES ('1888', '219', '融水苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1889', '219', '三江侗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1890', '220', '秀峰区', '0');
INSERT INTO `sys_district` VALUES ('1891', '220', '叠彩区', '0');
INSERT INTO `sys_district` VALUES ('1892', '220', '象山区', '0');
INSERT INTO `sys_district` VALUES ('1893', '220', '七星区', '0');
INSERT INTO `sys_district` VALUES ('1894', '220', '雁山区', '0');
INSERT INTO `sys_district` VALUES ('1895', '220', '阳朔县', '0');
INSERT INTO `sys_district` VALUES ('1896', '220', '临桂县', '0');
INSERT INTO `sys_district` VALUES ('1897', '220', '灵川县', '0');
INSERT INTO `sys_district` VALUES ('1898', '220', '全州县', '0');
INSERT INTO `sys_district` VALUES ('1899', '220', '兴安县', '0');
INSERT INTO `sys_district` VALUES ('1900', '220', '永福县', '0');
INSERT INTO `sys_district` VALUES ('1901', '220', '灌阳县', '0');
INSERT INTO `sys_district` VALUES ('1902', '220', '龙胜各族自治县', '0');
INSERT INTO `sys_district` VALUES ('1903', '220', '资源县', '0');
INSERT INTO `sys_district` VALUES ('1904', '220', '平乐县', '0');
INSERT INTO `sys_district` VALUES ('1905', '220', '荔蒲县', '0');
INSERT INTO `sys_district` VALUES ('1906', '220', '恭城瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1907', '221', '万秀区', '0');
INSERT INTO `sys_district` VALUES ('1908', '221', '蝶山区', '0');
INSERT INTO `sys_district` VALUES ('1909', '221', '长洲区', '0');
INSERT INTO `sys_district` VALUES ('1910', '221', '苍梧县', '0');
INSERT INTO `sys_district` VALUES ('1911', '221', '藤县', '0');
INSERT INTO `sys_district` VALUES ('1912', '221', '蒙山县', '0');
INSERT INTO `sys_district` VALUES ('1913', '221', '岑溪市', '0');
INSERT INTO `sys_district` VALUES ('1914', '222', '海城区', '0');
INSERT INTO `sys_district` VALUES ('1915', '222', '银海区', '0');
INSERT INTO `sys_district` VALUES ('1916', '222', '铁山港区', '0');
INSERT INTO `sys_district` VALUES ('1917', '222', '合浦县', '0');
INSERT INTO `sys_district` VALUES ('1918', '223', '港口区', '0');
INSERT INTO `sys_district` VALUES ('1919', '223', '防城区', '0');
INSERT INTO `sys_district` VALUES ('1920', '223', '上思县', '0');
INSERT INTO `sys_district` VALUES ('1921', '223', '东兴市', '0');
INSERT INTO `sys_district` VALUES ('1922', '224', '钦南区', '0');
INSERT INTO `sys_district` VALUES ('1923', '224', '钦北区', '0');
INSERT INTO `sys_district` VALUES ('1924', '224', '灵山县', '0');
INSERT INTO `sys_district` VALUES ('1925', '224', '浦北县', '0');
INSERT INTO `sys_district` VALUES ('1926', '225', '港北区', '0');
INSERT INTO `sys_district` VALUES ('1927', '225', '港南区', '0');
INSERT INTO `sys_district` VALUES ('1928', '225', '覃塘区', '0');
INSERT INTO `sys_district` VALUES ('1929', '225', '平南县', '0');
INSERT INTO `sys_district` VALUES ('1930', '225', '桂平市', '0');
INSERT INTO `sys_district` VALUES ('1931', '226', '玉州区', '0');
INSERT INTO `sys_district` VALUES ('1932', '226', '容县', '0');
INSERT INTO `sys_district` VALUES ('1933', '226', '陆川县', '0');
INSERT INTO `sys_district` VALUES ('1934', '226', '博白县', '0');
INSERT INTO `sys_district` VALUES ('1935', '226', '兴业县', '0');
INSERT INTO `sys_district` VALUES ('1936', '226', '北流市', '0');
INSERT INTO `sys_district` VALUES ('1937', '227', '右江区', '0');
INSERT INTO `sys_district` VALUES ('1938', '227', '田阳县', '0');
INSERT INTO `sys_district` VALUES ('1939', '227', '田东县', '0');
INSERT INTO `sys_district` VALUES ('1940', '227', '平果县', '0');
INSERT INTO `sys_district` VALUES ('1941', '227', '德保县', '0');
INSERT INTO `sys_district` VALUES ('1942', '227', '靖西县', '0');
INSERT INTO `sys_district` VALUES ('1943', '227', '那坡县', '0');
INSERT INTO `sys_district` VALUES ('1944', '227', '凌云县', '0');
INSERT INTO `sys_district` VALUES ('1945', '227', '乐业县', '0');
INSERT INTO `sys_district` VALUES ('1946', '227', '田林县', '0');
INSERT INTO `sys_district` VALUES ('1947', '227', '西林县', '0');
INSERT INTO `sys_district` VALUES ('1948', '227', '隆林各族自治县', '0');
INSERT INTO `sys_district` VALUES ('1949', '228', '八步区', '0');
INSERT INTO `sys_district` VALUES ('1950', '228', '昭平县', '0');
INSERT INTO `sys_district` VALUES ('1951', '228', '钟山县', '0');
INSERT INTO `sys_district` VALUES ('1952', '228', '富川瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1953', '229', '金城江区', '0');
INSERT INTO `sys_district` VALUES ('1954', '229', '南丹县', '0');
INSERT INTO `sys_district` VALUES ('1955', '229', '天峨县', '0');
INSERT INTO `sys_district` VALUES ('1956', '229', '凤山县', '0');
INSERT INTO `sys_district` VALUES ('1957', '229', '东兰县', '0');
INSERT INTO `sys_district` VALUES ('1958', '229', '罗城仫佬族自治县', '0');
INSERT INTO `sys_district` VALUES ('1959', '229', '环江毛南族自治县', '0');
INSERT INTO `sys_district` VALUES ('1960', '229', '巴马瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1961', '229', '都安瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1962', '229', '大化瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1963', '229', '宜州市', '0');
INSERT INTO `sys_district` VALUES ('1964', '230', '兴宾区', '0');
INSERT INTO `sys_district` VALUES ('1965', '230', '忻城县', '0');
INSERT INTO `sys_district` VALUES ('1966', '230', '象州县', '0');
INSERT INTO `sys_district` VALUES ('1967', '230', '武宣县', '0');
INSERT INTO `sys_district` VALUES ('1968', '230', '金秀瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('1969', '230', '合山市', '0');
INSERT INTO `sys_district` VALUES ('1970', '231', '江洲区', '0');
INSERT INTO `sys_district` VALUES ('1971', '231', '扶绥县', '0');
INSERT INTO `sys_district` VALUES ('1972', '231', '宁明县', '0');
INSERT INTO `sys_district` VALUES ('1973', '231', '龙州县', '0');
INSERT INTO `sys_district` VALUES ('1974', '231', '大新县', '0');
INSERT INTO `sys_district` VALUES ('1975', '231', '天等县', '0');
INSERT INTO `sys_district` VALUES ('1976', '231', '凭祥市', '0');
INSERT INTO `sys_district` VALUES ('1977', '232', '秀英区', '0');
INSERT INTO `sys_district` VALUES ('1978', '232', '龙华区', '0');
INSERT INTO `sys_district` VALUES ('1979', '232', '琼山区', '0');
INSERT INTO `sys_district` VALUES ('1980', '232', '美兰区', '0');
INSERT INTO `sys_district` VALUES ('1981', '233', '五指山市', '0');
INSERT INTO `sys_district` VALUES ('1982', '233', '琼海市', '0');
INSERT INTO `sys_district` VALUES ('1983', '233', '儋州市', '0');
INSERT INTO `sys_district` VALUES ('1984', '233', '文昌市', '0');
INSERT INTO `sys_district` VALUES ('1985', '233', '万宁市', '0');
INSERT INTO `sys_district` VALUES ('1986', '233', '东方市', '0');
INSERT INTO `sys_district` VALUES ('1987', '233', '定安县', '0');
INSERT INTO `sys_district` VALUES ('1988', '233', '屯昌县', '0');
INSERT INTO `sys_district` VALUES ('1989', '233', '澄迈县', '0');
INSERT INTO `sys_district` VALUES ('1990', '233', '临高县', '0');
INSERT INTO `sys_district` VALUES ('1991', '233', '白沙黎族自治县', '0');
INSERT INTO `sys_district` VALUES ('1992', '233', '昌江黎族自治县', '0');
INSERT INTO `sys_district` VALUES ('1993', '233', '乐东黎族自治县', '0');
INSERT INTO `sys_district` VALUES ('1994', '233', '陵水黎族自治县', '0');
INSERT INTO `sys_district` VALUES ('1995', '233', '保亭黎族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1996', '233', '琼中黎族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('1997', '233', '西沙群岛', '0');
INSERT INTO `sys_district` VALUES ('1998', '233', '南沙群岛', '0');
INSERT INTO `sys_district` VALUES ('1999', '233', '中沙群岛的岛礁及其海域', '0');
INSERT INTO `sys_district` VALUES ('2000', '234', '万州区', '0');
INSERT INTO `sys_district` VALUES ('2001', '234', '涪陵区', '0');
INSERT INTO `sys_district` VALUES ('2002', '234', '渝中区', '0');
INSERT INTO `sys_district` VALUES ('2003', '234', '大渡口区', '0');
INSERT INTO `sys_district` VALUES ('2004', '234', '江北区', '0');
INSERT INTO `sys_district` VALUES ('2005', '234', '沙坪坝区', '0');
INSERT INTO `sys_district` VALUES ('2006', '234', '九龙坡区', '0');
INSERT INTO `sys_district` VALUES ('2007', '234', '南岸区', '0');
INSERT INTO `sys_district` VALUES ('2008', '234', '北碚区', '0');
INSERT INTO `sys_district` VALUES ('2009', '234', '万盛区', '0');
INSERT INTO `sys_district` VALUES ('2010', '234', '双桥区', '0');
INSERT INTO `sys_district` VALUES ('2011', '234', '渝北区', '0');
INSERT INTO `sys_district` VALUES ('2012', '234', '巴南区', '0');
INSERT INTO `sys_district` VALUES ('2013', '234', '黔江区', '0');
INSERT INTO `sys_district` VALUES ('2014', '234', '长寿区', '0');
INSERT INTO `sys_district` VALUES ('2015', '234', '綦江县', '0');
INSERT INTO `sys_district` VALUES ('2016', '234', '潼南县', '0');
INSERT INTO `sys_district` VALUES ('2017', '234', '铜梁县', '0');
INSERT INTO `sys_district` VALUES ('2018', '234', '大足县', '0');
INSERT INTO `sys_district` VALUES ('2019', '234', '荣昌县', '0');
INSERT INTO `sys_district` VALUES ('2020', '234', '璧山县', '0');
INSERT INTO `sys_district` VALUES ('2021', '234', '梁平县', '0');
INSERT INTO `sys_district` VALUES ('2022', '234', '城口县', '0');
INSERT INTO `sys_district` VALUES ('2023', '234', '丰都县', '0');
INSERT INTO `sys_district` VALUES ('2024', '234', '垫江县', '0');
INSERT INTO `sys_district` VALUES ('2025', '234', '武隆县', '0');
INSERT INTO `sys_district` VALUES ('2026', '234', '忠县', '0');
INSERT INTO `sys_district` VALUES ('2027', '234', '开县', '0');
INSERT INTO `sys_district` VALUES ('2028', '234', '云阳县', '0');
INSERT INTO `sys_district` VALUES ('2029', '234', '奉节县', '0');
INSERT INTO `sys_district` VALUES ('2030', '234', '巫山县', '0');
INSERT INTO `sys_district` VALUES ('2031', '234', '巫溪县', '0');
INSERT INTO `sys_district` VALUES ('2032', '234', '石柱土家族自治县', '0');
INSERT INTO `sys_district` VALUES ('2033', '234', '秀山土家族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2034', '234', '酉阳土家族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2035', '234', '彭水苗族土家族自治县', '0');
INSERT INTO `sys_district` VALUES ('2036', '234', '江津市', '0');
INSERT INTO `sys_district` VALUES ('2037', '234', '合川市', '0');
INSERT INTO `sys_district` VALUES ('2038', '234', '永川市', '0');
INSERT INTO `sys_district` VALUES ('2039', '234', '南川市', '0');
INSERT INTO `sys_district` VALUES ('2040', '235', '锦江区', '0');
INSERT INTO `sys_district` VALUES ('2041', '235', '青羊区', '0');
INSERT INTO `sys_district` VALUES ('2042', '235', '金牛区', '0');
INSERT INTO `sys_district` VALUES ('2043', '235', '武侯区', '0');
INSERT INTO `sys_district` VALUES ('2044', '235', '成华区', '0');
INSERT INTO `sys_district` VALUES ('2045', '235', '龙泉驿区', '0');
INSERT INTO `sys_district` VALUES ('2046', '235', '青白江区', '0');
INSERT INTO `sys_district` VALUES ('2047', '235', '新都区', '0');
INSERT INTO `sys_district` VALUES ('2048', '235', '温江区', '0');
INSERT INTO `sys_district` VALUES ('2049', '235', '金堂县', '0');
INSERT INTO `sys_district` VALUES ('2050', '235', '双流县', '0');
INSERT INTO `sys_district` VALUES ('2051', '235', '郫县', '0');
INSERT INTO `sys_district` VALUES ('2052', '235', '大邑县', '0');
INSERT INTO `sys_district` VALUES ('2053', '235', '蒲江县', '0');
INSERT INTO `sys_district` VALUES ('2054', '235', '新津县', '0');
INSERT INTO `sys_district` VALUES ('2055', '235', '都江堰市', '0');
INSERT INTO `sys_district` VALUES ('2056', '235', '彭州市', '0');
INSERT INTO `sys_district` VALUES ('2057', '235', '邛崃市', '0');
INSERT INTO `sys_district` VALUES ('2058', '235', '崇州市', '0');
INSERT INTO `sys_district` VALUES ('2059', '236', '自流井区', '0');
INSERT INTO `sys_district` VALUES ('2060', '236', '贡井区', '0');
INSERT INTO `sys_district` VALUES ('2061', '236', '大安区', '0');
INSERT INTO `sys_district` VALUES ('2062', '236', '沿滩区', '0');
INSERT INTO `sys_district` VALUES ('2063', '236', '荣县', '0');
INSERT INTO `sys_district` VALUES ('2064', '236', '富顺县', '0');
INSERT INTO `sys_district` VALUES ('2065', '237', '东区', '0');
INSERT INTO `sys_district` VALUES ('2066', '237', '西区', '0');
INSERT INTO `sys_district` VALUES ('2067', '237', '仁和区', '0');
INSERT INTO `sys_district` VALUES ('2068', '237', '米易县', '0');
INSERT INTO `sys_district` VALUES ('2069', '237', '盐边县', '0');
INSERT INTO `sys_district` VALUES ('2070', '238', '江阳区', '0');
INSERT INTO `sys_district` VALUES ('2071', '238', '纳溪区', '0');
INSERT INTO `sys_district` VALUES ('2072', '238', '龙马潭区', '0');
INSERT INTO `sys_district` VALUES ('2073', '238', '泸县', '0');
INSERT INTO `sys_district` VALUES ('2074', '238', '合江县', '0');
INSERT INTO `sys_district` VALUES ('2075', '238', '叙永县', '0');
INSERT INTO `sys_district` VALUES ('2076', '238', '古蔺县', '0');
INSERT INTO `sys_district` VALUES ('2077', '239', '旌阳区', '0');
INSERT INTO `sys_district` VALUES ('2078', '239', '中江县', '0');
INSERT INTO `sys_district` VALUES ('2079', '239', '罗江县', '0');
INSERT INTO `sys_district` VALUES ('2080', '239', '广汉市', '0');
INSERT INTO `sys_district` VALUES ('2081', '239', '什邡市', '0');
INSERT INTO `sys_district` VALUES ('2082', '239', '绵竹市', '0');
INSERT INTO `sys_district` VALUES ('2083', '240', '涪城区', '0');
INSERT INTO `sys_district` VALUES ('2084', '240', '游仙区', '0');
INSERT INTO `sys_district` VALUES ('2085', '240', '三台县', '0');
INSERT INTO `sys_district` VALUES ('2086', '240', '盐亭县', '0');
INSERT INTO `sys_district` VALUES ('2087', '240', '安县', '0');
INSERT INTO `sys_district` VALUES ('2088', '240', '梓潼县', '0');
INSERT INTO `sys_district` VALUES ('2089', '240', '北川羌族自治县', '0');
INSERT INTO `sys_district` VALUES ('2090', '240', '平武县', '0');
INSERT INTO `sys_district` VALUES ('2091', '240', '江油市', '0');
INSERT INTO `sys_district` VALUES ('2092', '241', '市中区', '0');
INSERT INTO `sys_district` VALUES ('2093', '241', '元坝区', '0');
INSERT INTO `sys_district` VALUES ('2094', '241', '朝天区', '0');
INSERT INTO `sys_district` VALUES ('2095', '241', '旺苍县', '0');
INSERT INTO `sys_district` VALUES ('2096', '241', '青川县', '0');
INSERT INTO `sys_district` VALUES ('2097', '241', '剑阁县', '0');
INSERT INTO `sys_district` VALUES ('2098', '241', '苍溪县', '0');
INSERT INTO `sys_district` VALUES ('2099', '242', '船山区', '0');
INSERT INTO `sys_district` VALUES ('2100', '242', '安居区', '0');
INSERT INTO `sys_district` VALUES ('2101', '242', '蓬溪县', '0');
INSERT INTO `sys_district` VALUES ('2102', '242', '射洪县', '0');
INSERT INTO `sys_district` VALUES ('2103', '242', '大英县', '0');
INSERT INTO `sys_district` VALUES ('2104', '243', '市中区', '0');
INSERT INTO `sys_district` VALUES ('2105', '243', '东兴区', '0');
INSERT INTO `sys_district` VALUES ('2106', '243', '威远县', '0');
INSERT INTO `sys_district` VALUES ('2107', '243', '资中县', '0');
INSERT INTO `sys_district` VALUES ('2108', '243', '隆昌县', '0');
INSERT INTO `sys_district` VALUES ('2109', '244', '市中区', '0');
INSERT INTO `sys_district` VALUES ('2110', '244', '沙湾区', '0');
INSERT INTO `sys_district` VALUES ('2111', '244', '五通桥区', '0');
INSERT INTO `sys_district` VALUES ('2112', '244', '金口河区', '0');
INSERT INTO `sys_district` VALUES ('2113', '244', '犍为县', '0');
INSERT INTO `sys_district` VALUES ('2114', '244', '井研县', '0');
INSERT INTO `sys_district` VALUES ('2115', '244', '夹江县', '0');
INSERT INTO `sys_district` VALUES ('2116', '244', '沐川县', '0');
INSERT INTO `sys_district` VALUES ('2117', '244', '峨边彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2118', '244', '马边彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2119', '244', '峨眉山市', '0');
INSERT INTO `sys_district` VALUES ('2120', '245', '顺庆区', '0');
INSERT INTO `sys_district` VALUES ('2121', '245', '高坪区', '0');
INSERT INTO `sys_district` VALUES ('2122', '245', '嘉陵区', '0');
INSERT INTO `sys_district` VALUES ('2123', '245', '南部县', '0');
INSERT INTO `sys_district` VALUES ('2124', '245', '营山县', '0');
INSERT INTO `sys_district` VALUES ('2125', '245', '蓬安县', '0');
INSERT INTO `sys_district` VALUES ('2126', '245', '仪陇县', '0');
INSERT INTO `sys_district` VALUES ('2127', '245', '西充县', '0');
INSERT INTO `sys_district` VALUES ('2128', '245', '阆中市', '0');
INSERT INTO `sys_district` VALUES ('2129', '246', '东坡区', '0');
INSERT INTO `sys_district` VALUES ('2130', '246', '仁寿县', '0');
INSERT INTO `sys_district` VALUES ('2131', '246', '彭山县', '0');
INSERT INTO `sys_district` VALUES ('2132', '246', '洪雅县', '0');
INSERT INTO `sys_district` VALUES ('2133', '246', '丹棱县', '0');
INSERT INTO `sys_district` VALUES ('2134', '246', '青神县', '0');
INSERT INTO `sys_district` VALUES ('2135', '247', '翠屏区', '0');
INSERT INTO `sys_district` VALUES ('2136', '247', '宜宾县', '0');
INSERT INTO `sys_district` VALUES ('2137', '247', '南溪县', '0');
INSERT INTO `sys_district` VALUES ('2138', '247', '江安县', '0');
INSERT INTO `sys_district` VALUES ('2139', '247', '长宁县', '0');
INSERT INTO `sys_district` VALUES ('2140', '247', '高县', '0');
INSERT INTO `sys_district` VALUES ('2141', '247', '珙县', '0');
INSERT INTO `sys_district` VALUES ('2142', '247', '筠连县', '0');
INSERT INTO `sys_district` VALUES ('2143', '247', '兴文县', '0');
INSERT INTO `sys_district` VALUES ('2144', '247', '屏山县', '0');
INSERT INTO `sys_district` VALUES ('2145', '248', '广安区', '0');
INSERT INTO `sys_district` VALUES ('2146', '248', '岳池县', '0');
INSERT INTO `sys_district` VALUES ('2147', '248', '武胜县', '0');
INSERT INTO `sys_district` VALUES ('2148', '248', '邻水县', '0');
INSERT INTO `sys_district` VALUES ('2149', '248', '华蓥市', '0');
INSERT INTO `sys_district` VALUES ('2150', '249', '通川区', '0');
INSERT INTO `sys_district` VALUES ('2151', '249', '达县', '0');
INSERT INTO `sys_district` VALUES ('2152', '249', '宣汉县', '0');
INSERT INTO `sys_district` VALUES ('2153', '249', '开江县', '0');
INSERT INTO `sys_district` VALUES ('2154', '249', '大竹县', '0');
INSERT INTO `sys_district` VALUES ('2155', '249', '渠县', '0');
INSERT INTO `sys_district` VALUES ('2156', '249', '万源市', '0');
INSERT INTO `sys_district` VALUES ('2157', '250', '雨城区', '0');
INSERT INTO `sys_district` VALUES ('2158', '250', '名山县', '0');
INSERT INTO `sys_district` VALUES ('2159', '250', '荥经县', '0');
INSERT INTO `sys_district` VALUES ('2160', '250', '汉源县', '0');
INSERT INTO `sys_district` VALUES ('2161', '250', '石棉县', '0');
INSERT INTO `sys_district` VALUES ('2162', '250', '天全县', '0');
INSERT INTO `sys_district` VALUES ('2163', '250', '芦山县', '0');
INSERT INTO `sys_district` VALUES ('2164', '250', '宝兴县', '0');
INSERT INTO `sys_district` VALUES ('2165', '251', '巴州区', '0');
INSERT INTO `sys_district` VALUES ('2166', '251', '通江县', '0');
INSERT INTO `sys_district` VALUES ('2167', '251', '南江县', '0');
INSERT INTO `sys_district` VALUES ('2168', '251', '平昌县', '0');
INSERT INTO `sys_district` VALUES ('2169', '252', '雁江区', '0');
INSERT INTO `sys_district` VALUES ('2170', '252', '安岳县', '0');
INSERT INTO `sys_district` VALUES ('2171', '252', '乐至县', '0');
INSERT INTO `sys_district` VALUES ('2172', '252', '简阳市', '0');
INSERT INTO `sys_district` VALUES ('2173', '253', '汶川县', '0');
INSERT INTO `sys_district` VALUES ('2174', '253', '理县', '0');
INSERT INTO `sys_district` VALUES ('2175', '253', '茂县', '0');
INSERT INTO `sys_district` VALUES ('2176', '253', '松潘县', '0');
INSERT INTO `sys_district` VALUES ('2177', '253', '九寨沟县', '0');
INSERT INTO `sys_district` VALUES ('2178', '253', '金川县', '0');
INSERT INTO `sys_district` VALUES ('2179', '253', '小金县', '0');
INSERT INTO `sys_district` VALUES ('2180', '253', '黑水县', '0');
INSERT INTO `sys_district` VALUES ('2181', '253', '马尔康县', '0');
INSERT INTO `sys_district` VALUES ('2182', '253', '壤塘县', '0');
INSERT INTO `sys_district` VALUES ('2183', '253', '阿坝县', '0');
INSERT INTO `sys_district` VALUES ('2184', '253', '若尔盖县', '0');
INSERT INTO `sys_district` VALUES ('2185', '253', '红原县', '0');
INSERT INTO `sys_district` VALUES ('2186', '254', '康定县', '0');
INSERT INTO `sys_district` VALUES ('2187', '254', '泸定县', '0');
INSERT INTO `sys_district` VALUES ('2188', '254', '丹巴县', '0');
INSERT INTO `sys_district` VALUES ('2189', '254', '九龙县', '0');
INSERT INTO `sys_district` VALUES ('2190', '254', '雅江县', '0');
INSERT INTO `sys_district` VALUES ('2191', '254', '道孚县', '0');
INSERT INTO `sys_district` VALUES ('2192', '254', '炉霍县', '0');
INSERT INTO `sys_district` VALUES ('2193', '254', '甘孜县', '0');
INSERT INTO `sys_district` VALUES ('2194', '254', '新龙县', '0');
INSERT INTO `sys_district` VALUES ('2195', '254', '德格县', '0');
INSERT INTO `sys_district` VALUES ('2196', '254', '白玉县', '0');
INSERT INTO `sys_district` VALUES ('2197', '254', '石渠县', '0');
INSERT INTO `sys_district` VALUES ('2198', '254', '色达县', '0');
INSERT INTO `sys_district` VALUES ('2199', '254', '理塘县', '0');
INSERT INTO `sys_district` VALUES ('2200', '254', '巴塘县', '0');
INSERT INTO `sys_district` VALUES ('2201', '254', '乡城县', '0');
INSERT INTO `sys_district` VALUES ('2202', '254', '稻城县', '0');
INSERT INTO `sys_district` VALUES ('2203', '254', '得荣县', '0');
INSERT INTO `sys_district` VALUES ('2204', '255', '西昌市', '0');
INSERT INTO `sys_district` VALUES ('2205', '255', '木里藏族自治县', '0');
INSERT INTO `sys_district` VALUES ('2206', '255', '盐源县', '0');
INSERT INTO `sys_district` VALUES ('2207', '255', '德昌县', '0');
INSERT INTO `sys_district` VALUES ('2208', '255', '会理县', '0');
INSERT INTO `sys_district` VALUES ('2209', '255', '会东县', '0');
INSERT INTO `sys_district` VALUES ('2210', '255', '宁南县', '0');
INSERT INTO `sys_district` VALUES ('2211', '255', '普格县', '0');
INSERT INTO `sys_district` VALUES ('2212', '255', '布拖县', '0');
INSERT INTO `sys_district` VALUES ('2213', '255', '金阳县', '0');
INSERT INTO `sys_district` VALUES ('2214', '255', '昭觉县', '0');
INSERT INTO `sys_district` VALUES ('2215', '255', '喜德县', '0');
INSERT INTO `sys_district` VALUES ('2216', '255', '冕宁县', '0');
INSERT INTO `sys_district` VALUES ('2217', '255', '越西县', '0');
INSERT INTO `sys_district` VALUES ('2218', '255', '甘洛县', '0');
INSERT INTO `sys_district` VALUES ('2219', '255', '美姑县', '0');
INSERT INTO `sys_district` VALUES ('2220', '255', '雷波县', '0');
INSERT INTO `sys_district` VALUES ('2221', '256', '南明区', '0');
INSERT INTO `sys_district` VALUES ('2222', '256', '云岩区', '0');
INSERT INTO `sys_district` VALUES ('2223', '256', '花溪区', '0');
INSERT INTO `sys_district` VALUES ('2224', '256', '乌当区', '0');
INSERT INTO `sys_district` VALUES ('2225', '256', '白云区', '0');
INSERT INTO `sys_district` VALUES ('2226', '256', '小河区', '0');
INSERT INTO `sys_district` VALUES ('2227', '256', '开阳县', '0');
INSERT INTO `sys_district` VALUES ('2228', '256', '息烽县', '0');
INSERT INTO `sys_district` VALUES ('2229', '256', '修文县', '0');
INSERT INTO `sys_district` VALUES ('2230', '256', '清镇市', '0');
INSERT INTO `sys_district` VALUES ('2231', '257', '钟山区', '0');
INSERT INTO `sys_district` VALUES ('2232', '257', '六枝特区', '0');
INSERT INTO `sys_district` VALUES ('2233', '257', '水城县', '0');
INSERT INTO `sys_district` VALUES ('2234', '257', '盘县', '0');
INSERT INTO `sys_district` VALUES ('2235', '258', '红花岗区', '0');
INSERT INTO `sys_district` VALUES ('2236', '258', '汇川区', '0');
INSERT INTO `sys_district` VALUES ('2237', '258', '遵义县', '0');
INSERT INTO `sys_district` VALUES ('2238', '258', '桐梓县', '0');
INSERT INTO `sys_district` VALUES ('2239', '258', '绥阳县', '0');
INSERT INTO `sys_district` VALUES ('2240', '258', '正安县', '0');
INSERT INTO `sys_district` VALUES ('2241', '258', '道真仡佬族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2242', '258', '务川仡佬族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2243', '258', '凤冈县', '0');
INSERT INTO `sys_district` VALUES ('2244', '258', '湄潭县', '0');
INSERT INTO `sys_district` VALUES ('2245', '258', '余庆县', '0');
INSERT INTO `sys_district` VALUES ('2246', '258', '习水县', '0');
INSERT INTO `sys_district` VALUES ('2247', '258', '赤水市', '0');
INSERT INTO `sys_district` VALUES ('2248', '258', '仁怀市', '0');
INSERT INTO `sys_district` VALUES ('2249', '259', '西秀区', '0');
INSERT INTO `sys_district` VALUES ('2250', '259', '平坝县', '0');
INSERT INTO `sys_district` VALUES ('2251', '259', '普定县', '0');
INSERT INTO `sys_district` VALUES ('2252', '259', '镇宁布依族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2253', '259', '关岭布依族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2254', '259', '紫云苗族布依族自治县', '0');
INSERT INTO `sys_district` VALUES ('2255', '260', '铜仁市', '0');
INSERT INTO `sys_district` VALUES ('2256', '260', '江口县', '0');
INSERT INTO `sys_district` VALUES ('2257', '260', '玉屏侗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2258', '260', '石阡县', '0');
INSERT INTO `sys_district` VALUES ('2259', '260', '思南县', '0');
INSERT INTO `sys_district` VALUES ('2260', '260', '印江土家族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2261', '260', '德江县', '0');
INSERT INTO `sys_district` VALUES ('2262', '260', '沿河土家族自治县', '0');
INSERT INTO `sys_district` VALUES ('2263', '260', '松桃苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2264', '260', '万山特区', '0');
INSERT INTO `sys_district` VALUES ('2265', '261', '兴义市', '0');
INSERT INTO `sys_district` VALUES ('2266', '261', '兴仁县', '0');
INSERT INTO `sys_district` VALUES ('2267', '261', '普安县', '0');
INSERT INTO `sys_district` VALUES ('2268', '261', '晴隆县', '0');
INSERT INTO `sys_district` VALUES ('2269', '261', '贞丰县', '0');
INSERT INTO `sys_district` VALUES ('2270', '261', '望谟县', '0');
INSERT INTO `sys_district` VALUES ('2271', '261', '册亨县', '0');
INSERT INTO `sys_district` VALUES ('2272', '261', '安龙县', '0');
INSERT INTO `sys_district` VALUES ('2273', '262', '毕节市', '0');
INSERT INTO `sys_district` VALUES ('2274', '262', '大方县', '0');
INSERT INTO `sys_district` VALUES ('2275', '262', '黔西县', '0');
INSERT INTO `sys_district` VALUES ('2276', '262', '金沙县', '0');
INSERT INTO `sys_district` VALUES ('2277', '262', '织金县', '0');
INSERT INTO `sys_district` VALUES ('2278', '262', '纳雍县', '0');
INSERT INTO `sys_district` VALUES ('2279', '262', '威宁彝族回族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2280', '262', '赫章县', '0');
INSERT INTO `sys_district` VALUES ('2281', '263', '凯里市', '0');
INSERT INTO `sys_district` VALUES ('2282', '263', '黄平县', '0');
INSERT INTO `sys_district` VALUES ('2283', '263', '施秉县', '0');
INSERT INTO `sys_district` VALUES ('2284', '263', '三穗县', '0');
INSERT INTO `sys_district` VALUES ('2285', '263', '镇远县', '0');
INSERT INTO `sys_district` VALUES ('2286', '263', '岑巩县', '0');
INSERT INTO `sys_district` VALUES ('2287', '263', '天柱县', '0');
INSERT INTO `sys_district` VALUES ('2288', '263', '锦屏县', '0');
INSERT INTO `sys_district` VALUES ('2289', '263', '剑河县', '0');
INSERT INTO `sys_district` VALUES ('2290', '263', '台江县', '0');
INSERT INTO `sys_district` VALUES ('2291', '263', '黎平县', '0');
INSERT INTO `sys_district` VALUES ('2292', '263', '榕江县', '0');
INSERT INTO `sys_district` VALUES ('2293', '263', '从江县', '0');
INSERT INTO `sys_district` VALUES ('2294', '263', '雷山县', '0');
INSERT INTO `sys_district` VALUES ('2295', '263', '麻江县', '0');
INSERT INTO `sys_district` VALUES ('2296', '263', '丹寨县', '0');
INSERT INTO `sys_district` VALUES ('2297', '264', '都匀市', '0');
INSERT INTO `sys_district` VALUES ('2298', '264', '福泉市', '0');
INSERT INTO `sys_district` VALUES ('2299', '264', '荔波县', '0');
INSERT INTO `sys_district` VALUES ('2300', '264', '贵定县', '0');
INSERT INTO `sys_district` VALUES ('2301', '264', '瓮安县', '0');
INSERT INTO `sys_district` VALUES ('2302', '264', '独山县', '0');
INSERT INTO `sys_district` VALUES ('2303', '264', '平塘县', '0');
INSERT INTO `sys_district` VALUES ('2304', '264', '罗甸县', '0');
INSERT INTO `sys_district` VALUES ('2305', '264', '长顺县', '0');
INSERT INTO `sys_district` VALUES ('2306', '264', '龙里县', '0');
INSERT INTO `sys_district` VALUES ('2307', '264', '惠水县', '0');
INSERT INTO `sys_district` VALUES ('2308', '264', '三都水族自治县', '0');
INSERT INTO `sys_district` VALUES ('2309', '265', '五华区', '0');
INSERT INTO `sys_district` VALUES ('2310', '265', '盘龙区', '0');
INSERT INTO `sys_district` VALUES ('2311', '265', '官渡区', '0');
INSERT INTO `sys_district` VALUES ('2312', '265', '西山区', '0');
INSERT INTO `sys_district` VALUES ('2313', '265', '东川区', '0');
INSERT INTO `sys_district` VALUES ('2314', '265', '呈贡县', '0');
INSERT INTO `sys_district` VALUES ('2315', '265', '晋宁县', '0');
INSERT INTO `sys_district` VALUES ('2316', '265', '富民县', '0');
INSERT INTO `sys_district` VALUES ('2317', '265', '宜良县', '0');
INSERT INTO `sys_district` VALUES ('2318', '265', '石林彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2319', '265', '嵩明县', '0');
INSERT INTO `sys_district` VALUES ('2320', '265', '禄劝彝族苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2321', '265', '寻甸回族彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2322', '265', '安宁市', '0');
INSERT INTO `sys_district` VALUES ('2323', '266', '麒麟区', '0');
INSERT INTO `sys_district` VALUES ('2324', '266', '马龙县', '0');
INSERT INTO `sys_district` VALUES ('2325', '266', '陆良县', '0');
INSERT INTO `sys_district` VALUES ('2326', '266', '师宗县', '0');
INSERT INTO `sys_district` VALUES ('2327', '266', '罗平县', '0');
INSERT INTO `sys_district` VALUES ('2328', '266', '富源县', '0');
INSERT INTO `sys_district` VALUES ('2329', '266', '会泽县', '0');
INSERT INTO `sys_district` VALUES ('2330', '266', '沾益县', '0');
INSERT INTO `sys_district` VALUES ('2331', '266', '宣威市', '0');
INSERT INTO `sys_district` VALUES ('2332', '267', '红塔区', '0');
INSERT INTO `sys_district` VALUES ('2333', '267', '江川县', '0');
INSERT INTO `sys_district` VALUES ('2334', '267', '澄江县', '0');
INSERT INTO `sys_district` VALUES ('2335', '267', '通海县', '0');
INSERT INTO `sys_district` VALUES ('2336', '267', '华宁县', '0');
INSERT INTO `sys_district` VALUES ('2337', '267', '易门县', '0');
INSERT INTO `sys_district` VALUES ('2338', '267', '峨山彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2339', '267', '新平彝族傣族自治县', '0');
INSERT INTO `sys_district` VALUES ('2340', '267', '元江哈尼族彝族傣族自治县', '0');
INSERT INTO `sys_district` VALUES ('2341', '268', '隆阳区', '0');
INSERT INTO `sys_district` VALUES ('2342', '268', '施甸县', '0');
INSERT INTO `sys_district` VALUES ('2343', '268', '腾冲县', '0');
INSERT INTO `sys_district` VALUES ('2344', '268', '龙陵县', '0');
INSERT INTO `sys_district` VALUES ('2345', '268', '昌宁县', '0');
INSERT INTO `sys_district` VALUES ('2346', '269', '昭阳区', '0');
INSERT INTO `sys_district` VALUES ('2347', '269', '鲁甸县', '0');
INSERT INTO `sys_district` VALUES ('2348', '269', '巧家县', '0');
INSERT INTO `sys_district` VALUES ('2349', '269', '盐津县', '0');
INSERT INTO `sys_district` VALUES ('2350', '269', '大关县', '0');
INSERT INTO `sys_district` VALUES ('2351', '269', '永善县', '0');
INSERT INTO `sys_district` VALUES ('2352', '269', '绥江县', '0');
INSERT INTO `sys_district` VALUES ('2353', '269', '镇雄县', '0');
INSERT INTO `sys_district` VALUES ('2354', '269', '彝良县', '0');
INSERT INTO `sys_district` VALUES ('2355', '269', '威信县', '0');
INSERT INTO `sys_district` VALUES ('2356', '269', '水富县', '0');
INSERT INTO `sys_district` VALUES ('2357', '270', '古城区', '0');
INSERT INTO `sys_district` VALUES ('2358', '270', '玉龙纳西族自治县', '0');
INSERT INTO `sys_district` VALUES ('2359', '270', '永胜县', '0');
INSERT INTO `sys_district` VALUES ('2360', '270', '华坪县', '0');
INSERT INTO `sys_district` VALUES ('2361', '270', '宁蒗彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2362', '271', '翠云区', '0');
INSERT INTO `sys_district` VALUES ('2363', '271', '普洱哈尼族彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2364', '271', '墨江哈尼族自治县', '0');
INSERT INTO `sys_district` VALUES ('2365', '271', '景东彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2366', '271', '景谷傣族彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2367', '271', '镇沅彝族哈尼族拉祜族自治县', '0');
INSERT INTO `sys_district` VALUES ('2368', '271', '江城哈尼族彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2369', '271', '孟连傣族拉祜族佤族自治县', '0');
INSERT INTO `sys_district` VALUES ('2370', '271', '澜沧拉祜族自治县', '0');
INSERT INTO `sys_district` VALUES ('2371', '271', '西盟佤族自治县', '0');
INSERT INTO `sys_district` VALUES ('2372', '272', '临翔区', '0');
INSERT INTO `sys_district` VALUES ('2373', '272', '凤庆县', '0');
INSERT INTO `sys_district` VALUES ('2374', '272', '云县', '0');
INSERT INTO `sys_district` VALUES ('2375', '272', '永德县', '0');
INSERT INTO `sys_district` VALUES ('2376', '272', '镇康县', '0');
INSERT INTO `sys_district` VALUES ('2377', '272', '双江拉祜族佤族布朗族傣族自治县', '0');
INSERT INTO `sys_district` VALUES ('2378', '272', '耿马傣族佤族自治县', '0');
INSERT INTO `sys_district` VALUES ('2379', '272', '沧源佤族自治县', '0');
INSERT INTO `sys_district` VALUES ('2380', '273', '楚雄市', '0');
INSERT INTO `sys_district` VALUES ('2381', '273', '双柏县', '0');
INSERT INTO `sys_district` VALUES ('2382', '273', '牟定县', '0');
INSERT INTO `sys_district` VALUES ('2383', '273', '南华县', '0');
INSERT INTO `sys_district` VALUES ('2384', '273', '姚安县', '0');
INSERT INTO `sys_district` VALUES ('2385', '273', '大姚县', '0');
INSERT INTO `sys_district` VALUES ('2386', '273', '永仁县', '0');
INSERT INTO `sys_district` VALUES ('2387', '273', '元谋县', '0');
INSERT INTO `sys_district` VALUES ('2388', '273', '武定县', '0');
INSERT INTO `sys_district` VALUES ('2389', '273', '禄丰县', '0');
INSERT INTO `sys_district` VALUES ('2390', '274', '个旧市', '0');
INSERT INTO `sys_district` VALUES ('2391', '274', '开远市', '0');
INSERT INTO `sys_district` VALUES ('2392', '274', '蒙自县', '0');
INSERT INTO `sys_district` VALUES ('2393', '274', '屏边苗族自治县', '0');
INSERT INTO `sys_district` VALUES ('2394', '274', '建水县', '0');
INSERT INTO `sys_district` VALUES ('2395', '274', '石屏县', '0');
INSERT INTO `sys_district` VALUES ('2396', '274', '弥勒县', '0');
INSERT INTO `sys_district` VALUES ('2397', '274', '泸西县', '0');
INSERT INTO `sys_district` VALUES ('2398', '274', '元阳县', '0');
INSERT INTO `sys_district` VALUES ('2399', '274', '红河县', '0');
INSERT INTO `sys_district` VALUES ('2400', '274', '金平苗族瑶族傣族自治县', '0');
INSERT INTO `sys_district` VALUES ('2401', '274', '绿春县', '0');
INSERT INTO `sys_district` VALUES ('2402', '274', '河口瑶族自治县', '0');
INSERT INTO `sys_district` VALUES ('2403', '275', '文山县', '0');
INSERT INTO `sys_district` VALUES ('2404', '275', '砚山县', '0');
INSERT INTO `sys_district` VALUES ('2405', '275', '西畴县', '0');
INSERT INTO `sys_district` VALUES ('2406', '275', '麻栗坡县', '0');
INSERT INTO `sys_district` VALUES ('2407', '275', '马关县', '0');
INSERT INTO `sys_district` VALUES ('2408', '275', '丘北县', '0');
INSERT INTO `sys_district` VALUES ('2409', '275', '广南县', '0');
INSERT INTO `sys_district` VALUES ('2410', '275', '富宁县', '0');
INSERT INTO `sys_district` VALUES ('2411', '276', '景洪市', '0');
INSERT INTO `sys_district` VALUES ('2412', '276', '勐海县', '0');
INSERT INTO `sys_district` VALUES ('2413', '276', '勐腊县', '0');
INSERT INTO `sys_district` VALUES ('2414', '277', '大理市', '0');
INSERT INTO `sys_district` VALUES ('2415', '277', '漾濞彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2416', '277', '祥云县', '0');
INSERT INTO `sys_district` VALUES ('2417', '277', '宾川县', '0');
INSERT INTO `sys_district` VALUES ('2418', '277', '弥渡县', '0');
INSERT INTO `sys_district` VALUES ('2419', '277', '南涧彝族自治县', '0');
INSERT INTO `sys_district` VALUES ('2420', '277', '巍山彝族回族自治县', '0');
INSERT INTO `sys_district` VALUES ('2421', '277', '永平县', '0');
INSERT INTO `sys_district` VALUES ('2422', '277', '云龙县', '0');
INSERT INTO `sys_district` VALUES ('2423', '277', '洱源县', '0');
INSERT INTO `sys_district` VALUES ('2424', '277', '剑川县', '0');
INSERT INTO `sys_district` VALUES ('2425', '277', '鹤庆县', '0');
INSERT INTO `sys_district` VALUES ('2426', '278', '瑞丽市', '0');
INSERT INTO `sys_district` VALUES ('2427', '278', '潞西市', '0');
INSERT INTO `sys_district` VALUES ('2428', '278', '梁河县', '0');
INSERT INTO `sys_district` VALUES ('2429', '278', '盈江县', '0');
INSERT INTO `sys_district` VALUES ('2430', '278', '陇川县', '0');
INSERT INTO `sys_district` VALUES ('2431', '279', '泸水县', '0');
INSERT INTO `sys_district` VALUES ('2432', '279', '福贡县', '0');
INSERT INTO `sys_district` VALUES ('2433', '279', '贡山独龙族怒族自治县', '0');
INSERT INTO `sys_district` VALUES ('2434', '279', '兰坪白族普米族自治县', '0');
INSERT INTO `sys_district` VALUES ('2435', '280', '香格里拉县', '0');
INSERT INTO `sys_district` VALUES ('2436', '280', '德钦县', '0');
INSERT INTO `sys_district` VALUES ('2437', '280', '维西傈僳族自治县', '0');
INSERT INTO `sys_district` VALUES ('2438', '281', '城关区', '0');
INSERT INTO `sys_district` VALUES ('2439', '281', '林周县', '0');
INSERT INTO `sys_district` VALUES ('2440', '281', '当雄县', '0');
INSERT INTO `sys_district` VALUES ('2441', '281', '尼木县', '0');
INSERT INTO `sys_district` VALUES ('2442', '281', '曲水县', '0');
INSERT INTO `sys_district` VALUES ('2443', '281', '堆龙德庆县', '0');
INSERT INTO `sys_district` VALUES ('2444', '281', '达孜县', '0');
INSERT INTO `sys_district` VALUES ('2445', '281', '墨竹工卡县', '0');
INSERT INTO `sys_district` VALUES ('2446', '282', '昌都县', '0');
INSERT INTO `sys_district` VALUES ('2447', '282', '江达县', '0');
INSERT INTO `sys_district` VALUES ('2448', '282', '贡觉县', '0');
INSERT INTO `sys_district` VALUES ('2449', '282', '类乌齐县', '0');
INSERT INTO `sys_district` VALUES ('2450', '282', '丁青县', '0');
INSERT INTO `sys_district` VALUES ('2451', '282', '察雅县', '0');
INSERT INTO `sys_district` VALUES ('2452', '282', '八宿县', '0');
INSERT INTO `sys_district` VALUES ('2453', '282', '左贡县', '0');
INSERT INTO `sys_district` VALUES ('2454', '282', '芒康县', '0');
INSERT INTO `sys_district` VALUES ('2455', '282', '洛隆县', '0');
INSERT INTO `sys_district` VALUES ('2456', '282', '边坝县', '0');
INSERT INTO `sys_district` VALUES ('2457', '283', '乃东县', '0');
INSERT INTO `sys_district` VALUES ('2458', '283', '扎囊县', '0');
INSERT INTO `sys_district` VALUES ('2459', '283', '贡嘎县', '0');
INSERT INTO `sys_district` VALUES ('2460', '283', '桑日县', '0');
INSERT INTO `sys_district` VALUES ('2461', '283', '琼结县', '0');
INSERT INTO `sys_district` VALUES ('2462', '283', '曲松县', '0');
INSERT INTO `sys_district` VALUES ('2463', '283', '措美县', '0');
INSERT INTO `sys_district` VALUES ('2464', '283', '洛扎县', '0');
INSERT INTO `sys_district` VALUES ('2465', '283', '加查县', '0');
INSERT INTO `sys_district` VALUES ('2466', '283', '隆子县', '0');
INSERT INTO `sys_district` VALUES ('2467', '283', '错那县', '0');
INSERT INTO `sys_district` VALUES ('2468', '283', '浪卡子县', '0');
INSERT INTO `sys_district` VALUES ('2469', '284', '日喀则市', '0');
INSERT INTO `sys_district` VALUES ('2470', '284', '南木林县', '0');
INSERT INTO `sys_district` VALUES ('2471', '284', '江孜县', '0');
INSERT INTO `sys_district` VALUES ('2472', '284', '定日县', '0');
INSERT INTO `sys_district` VALUES ('2473', '284', '萨迦县', '0');
INSERT INTO `sys_district` VALUES ('2474', '284', '拉孜县', '0');
INSERT INTO `sys_district` VALUES ('2475', '284', '昂仁县', '0');
INSERT INTO `sys_district` VALUES ('2476', '284', '谢通门县', '0');
INSERT INTO `sys_district` VALUES ('2477', '284', '白朗县', '0');
INSERT INTO `sys_district` VALUES ('2478', '284', '仁布县', '0');
INSERT INTO `sys_district` VALUES ('2479', '284', '康马县', '0');
INSERT INTO `sys_district` VALUES ('2480', '284', '定结县', '0');
INSERT INTO `sys_district` VALUES ('2481', '284', '仲巴县', '0');
INSERT INTO `sys_district` VALUES ('2482', '284', '亚东县', '0');
INSERT INTO `sys_district` VALUES ('2483', '284', '吉隆县', '0');
INSERT INTO `sys_district` VALUES ('2484', '284', '聂拉木县', '0');
INSERT INTO `sys_district` VALUES ('2485', '284', '萨嘎县', '0');
INSERT INTO `sys_district` VALUES ('2486', '284', '岗巴县', '0');
INSERT INTO `sys_district` VALUES ('2487', '285', '那曲县', '0');
INSERT INTO `sys_district` VALUES ('2488', '285', '嘉黎县', '0');
INSERT INTO `sys_district` VALUES ('2489', '285', '比如县', '0');
INSERT INTO `sys_district` VALUES ('2490', '285', '聂荣县', '0');
INSERT INTO `sys_district` VALUES ('2491', '285', '安多县', '0');
INSERT INTO `sys_district` VALUES ('2492', '285', '申扎县', '0');
INSERT INTO `sys_district` VALUES ('2493', '285', '索县', '0');
INSERT INTO `sys_district` VALUES ('2494', '285', '班戈县', '0');
INSERT INTO `sys_district` VALUES ('2495', '285', '巴青县', '0');
INSERT INTO `sys_district` VALUES ('2496', '285', '尼玛县', '0');
INSERT INTO `sys_district` VALUES ('2497', '286', '普兰县', '0');
INSERT INTO `sys_district` VALUES ('2498', '286', '札达县', '0');
INSERT INTO `sys_district` VALUES ('2499', '286', '噶尔县', '0');
INSERT INTO `sys_district` VALUES ('2500', '286', '日土县', '0');
INSERT INTO `sys_district` VALUES ('2501', '286', '革吉县', '0');
INSERT INTO `sys_district` VALUES ('2502', '286', '改则县', '0');
INSERT INTO `sys_district` VALUES ('2503', '286', '措勤县', '0');
INSERT INTO `sys_district` VALUES ('2504', '287', '林芝县', '0');
INSERT INTO `sys_district` VALUES ('2505', '287', '工布江达县', '0');
INSERT INTO `sys_district` VALUES ('2506', '287', '米林县', '0');
INSERT INTO `sys_district` VALUES ('2507', '287', '墨脱县', '0');
INSERT INTO `sys_district` VALUES ('2508', '287', '波密县', '0');
INSERT INTO `sys_district` VALUES ('2509', '287', '察隅县', '0');
INSERT INTO `sys_district` VALUES ('2510', '287', '朗县', '0');
INSERT INTO `sys_district` VALUES ('2511', '288', '新城区', '0');
INSERT INTO `sys_district` VALUES ('2512', '288', '碑林区', '0');
INSERT INTO `sys_district` VALUES ('2513', '288', '莲湖区', '0');
INSERT INTO `sys_district` VALUES ('2514', '288', '灞桥区', '0');
INSERT INTO `sys_district` VALUES ('2515', '288', '未央区', '0');
INSERT INTO `sys_district` VALUES ('2516', '288', '雁塔区', '0');
INSERT INTO `sys_district` VALUES ('2517', '288', '阎良区', '0');
INSERT INTO `sys_district` VALUES ('2518', '288', '临潼区', '0');
INSERT INTO `sys_district` VALUES ('2519', '288', '长安区', '0');
INSERT INTO `sys_district` VALUES ('2520', '288', '蓝田县', '0');
INSERT INTO `sys_district` VALUES ('2521', '288', '周至县', '0');
INSERT INTO `sys_district` VALUES ('2522', '288', '户县', '0');
INSERT INTO `sys_district` VALUES ('2523', '288', '高陵县', '0');
INSERT INTO `sys_district` VALUES ('2524', '289', '王益区', '0');
INSERT INTO `sys_district` VALUES ('2525', '289', '印台区', '0');
INSERT INTO `sys_district` VALUES ('2526', '289', '耀州区', '0');
INSERT INTO `sys_district` VALUES ('2527', '289', '宜君县', '0');
INSERT INTO `sys_district` VALUES ('2528', '290', '渭滨区', '0');
INSERT INTO `sys_district` VALUES ('2529', '290', '金台区', '0');
INSERT INTO `sys_district` VALUES ('2530', '290', '陈仓区', '0');
INSERT INTO `sys_district` VALUES ('2531', '290', '凤翔县', '0');
INSERT INTO `sys_district` VALUES ('2532', '290', '岐山县', '0');
INSERT INTO `sys_district` VALUES ('2533', '290', '扶风县', '0');
INSERT INTO `sys_district` VALUES ('2534', '290', '眉县', '0');
INSERT INTO `sys_district` VALUES ('2535', '290', '陇县', '0');
INSERT INTO `sys_district` VALUES ('2536', '290', '千阳县', '0');
INSERT INTO `sys_district` VALUES ('2537', '290', '麟游县', '0');
INSERT INTO `sys_district` VALUES ('2538', '290', '凤县', '0');
INSERT INTO `sys_district` VALUES ('2539', '290', '太白县', '0');
INSERT INTO `sys_district` VALUES ('2540', '291', '秦都区', '0');
INSERT INTO `sys_district` VALUES ('2541', '291', '杨凌区', '0');
INSERT INTO `sys_district` VALUES ('2542', '291', '渭城区', '0');
INSERT INTO `sys_district` VALUES ('2543', '291', '三原县', '0');
INSERT INTO `sys_district` VALUES ('2544', '291', '泾阳县', '0');
INSERT INTO `sys_district` VALUES ('2545', '291', '乾县', '0');
INSERT INTO `sys_district` VALUES ('2546', '291', '礼泉县', '0');
INSERT INTO `sys_district` VALUES ('2547', '291', '永寿县', '0');
INSERT INTO `sys_district` VALUES ('2548', '291', '彬县', '0');
INSERT INTO `sys_district` VALUES ('2549', '291', '长武县', '0');
INSERT INTO `sys_district` VALUES ('2550', '291', '旬邑县', '0');
INSERT INTO `sys_district` VALUES ('2551', '291', '淳化县', '0');
INSERT INTO `sys_district` VALUES ('2552', '291', '武功县', '0');
INSERT INTO `sys_district` VALUES ('2553', '291', '兴平市', '0');
INSERT INTO `sys_district` VALUES ('2554', '292', '临渭区', '0');
INSERT INTO `sys_district` VALUES ('2555', '292', '华县', '0');
INSERT INTO `sys_district` VALUES ('2556', '292', '潼关县', '0');
INSERT INTO `sys_district` VALUES ('2557', '292', '大荔县', '0');
INSERT INTO `sys_district` VALUES ('2558', '292', '合阳县', '0');
INSERT INTO `sys_district` VALUES ('2559', '292', '澄城县', '0');
INSERT INTO `sys_district` VALUES ('2560', '292', '蒲城县', '0');
INSERT INTO `sys_district` VALUES ('2561', '292', '白水县', '0');
INSERT INTO `sys_district` VALUES ('2562', '292', '富平县', '0');
INSERT INTO `sys_district` VALUES ('2563', '292', '韩城市', '0');
INSERT INTO `sys_district` VALUES ('2564', '292', '华阴市', '0');
INSERT INTO `sys_district` VALUES ('2565', '293', '宝塔区', '0');
INSERT INTO `sys_district` VALUES ('2566', '293', '延长县', '0');
INSERT INTO `sys_district` VALUES ('2567', '293', '延川县', '0');
INSERT INTO `sys_district` VALUES ('2568', '293', '子长县', '0');
INSERT INTO `sys_district` VALUES ('2569', '293', '安塞县', '0');
INSERT INTO `sys_district` VALUES ('2570', '293', '志丹县', '0');
INSERT INTO `sys_district` VALUES ('2571', '293', '吴旗县', '0');
INSERT INTO `sys_district` VALUES ('2572', '293', '甘泉县', '0');
INSERT INTO `sys_district` VALUES ('2573', '293', '富县', '0');
INSERT INTO `sys_district` VALUES ('2574', '293', '洛川县', '0');
INSERT INTO `sys_district` VALUES ('2575', '293', '宜川县', '0');
INSERT INTO `sys_district` VALUES ('2576', '293', '黄龙县', '0');
INSERT INTO `sys_district` VALUES ('2577', '293', '黄陵县', '0');
INSERT INTO `sys_district` VALUES ('2578', '294', '汉台区', '0');
INSERT INTO `sys_district` VALUES ('2579', '294', '南郑县', '0');
INSERT INTO `sys_district` VALUES ('2580', '294', '城固县', '0');
INSERT INTO `sys_district` VALUES ('2581', '294', '洋县', '0');
INSERT INTO `sys_district` VALUES ('2582', '294', '西乡县', '0');
INSERT INTO `sys_district` VALUES ('2583', '294', '勉县', '0');
INSERT INTO `sys_district` VALUES ('2584', '294', '宁强县', '0');
INSERT INTO `sys_district` VALUES ('2585', '294', '略阳县', '0');
INSERT INTO `sys_district` VALUES ('2586', '294', '镇巴县', '0');
INSERT INTO `sys_district` VALUES ('2587', '294', '留坝县', '0');
INSERT INTO `sys_district` VALUES ('2588', '294', '佛坪县', '0');
INSERT INTO `sys_district` VALUES ('2589', '295', '榆阳区', '0');
INSERT INTO `sys_district` VALUES ('2590', '295', '神木县', '0');
INSERT INTO `sys_district` VALUES ('2591', '295', '府谷县', '0');
INSERT INTO `sys_district` VALUES ('2592', '295', '横山县', '0');
INSERT INTO `sys_district` VALUES ('2593', '295', '靖边县', '0');
INSERT INTO `sys_district` VALUES ('2594', '295', '定边县', '0');
INSERT INTO `sys_district` VALUES ('2595', '295', '绥德县', '0');
INSERT INTO `sys_district` VALUES ('2596', '295', '米脂县', '0');
INSERT INTO `sys_district` VALUES ('2597', '295', '佳县', '0');
INSERT INTO `sys_district` VALUES ('2598', '295', '吴堡县', '0');
INSERT INTO `sys_district` VALUES ('2599', '295', '清涧县', '0');
INSERT INTO `sys_district` VALUES ('2600', '295', '子洲县', '0');
INSERT INTO `sys_district` VALUES ('2601', '296', '汉滨区', '0');
INSERT INTO `sys_district` VALUES ('2602', '296', '汉阴县', '0');
INSERT INTO `sys_district` VALUES ('2603', '296', '石泉县', '0');
INSERT INTO `sys_district` VALUES ('2604', '296', '宁陕县', '0');
INSERT INTO `sys_district` VALUES ('2605', '296', '紫阳县', '0');
INSERT INTO `sys_district` VALUES ('2606', '296', '岚皋县', '0');
INSERT INTO `sys_district` VALUES ('2607', '296', '平利县', '0');
INSERT INTO `sys_district` VALUES ('2608', '296', '镇坪县', '0');
INSERT INTO `sys_district` VALUES ('2609', '296', '旬阳县', '0');
INSERT INTO `sys_district` VALUES ('2610', '296', '白河县', '0');
INSERT INTO `sys_district` VALUES ('2611', '297', '商州区', '0');
INSERT INTO `sys_district` VALUES ('2612', '297', '洛南县', '0');
INSERT INTO `sys_district` VALUES ('2613', '297', '丹凤县', '0');
INSERT INTO `sys_district` VALUES ('2614', '297', '商南县', '0');
INSERT INTO `sys_district` VALUES ('2615', '297', '山阳县', '0');
INSERT INTO `sys_district` VALUES ('2616', '297', '镇安县', '0');
INSERT INTO `sys_district` VALUES ('2617', '297', '柞水县', '0');
INSERT INTO `sys_district` VALUES ('2618', '298', '城关区', '0');
INSERT INTO `sys_district` VALUES ('2619', '298', '七里河区', '0');
INSERT INTO `sys_district` VALUES ('2620', '298', '西固区', '0');
INSERT INTO `sys_district` VALUES ('2621', '298', '安宁区', '0');
INSERT INTO `sys_district` VALUES ('2622', '298', '红古区', '0');
INSERT INTO `sys_district` VALUES ('2623', '298', '永登县', '0');
INSERT INTO `sys_district` VALUES ('2624', '298', '皋兰县', '0');
INSERT INTO `sys_district` VALUES ('2625', '298', '榆中县', '0');
INSERT INTO `sys_district` VALUES ('2626', '300', '金川区', '0');
INSERT INTO `sys_district` VALUES ('2627', '300', '永昌县', '0');
INSERT INTO `sys_district` VALUES ('2628', '301', '白银区', '0');
INSERT INTO `sys_district` VALUES ('2629', '301', '平川区', '0');
INSERT INTO `sys_district` VALUES ('2630', '301', '靖远县', '0');
INSERT INTO `sys_district` VALUES ('2631', '301', '会宁县', '0');
INSERT INTO `sys_district` VALUES ('2632', '301', '景泰县', '0');
INSERT INTO `sys_district` VALUES ('2633', '302', '秦城区', '0');
INSERT INTO `sys_district` VALUES ('2634', '302', '北道区', '0');
INSERT INTO `sys_district` VALUES ('2635', '302', '清水县', '0');
INSERT INTO `sys_district` VALUES ('2636', '302', '秦安县', '0');
INSERT INTO `sys_district` VALUES ('2637', '302', '甘谷县', '0');
INSERT INTO `sys_district` VALUES ('2638', '302', '武山县', '0');
INSERT INTO `sys_district` VALUES ('2639', '302', '张家川回族自治县', '0');
INSERT INTO `sys_district` VALUES ('2640', '303', '凉州区', '0');
INSERT INTO `sys_district` VALUES ('2641', '303', '民勤县', '0');
INSERT INTO `sys_district` VALUES ('2642', '303', '古浪县', '0');
INSERT INTO `sys_district` VALUES ('2643', '303', '天祝藏族自治县', '0');
INSERT INTO `sys_district` VALUES ('2644', '304', '甘州区', '0');
INSERT INTO `sys_district` VALUES ('2645', '304', '肃南裕固族自治县', '0');
INSERT INTO `sys_district` VALUES ('2646', '304', '民乐县', '0');
INSERT INTO `sys_district` VALUES ('2647', '304', '临泽县', '0');
INSERT INTO `sys_district` VALUES ('2648', '304', '高台县', '0');
INSERT INTO `sys_district` VALUES ('2649', '304', '山丹县', '0');
INSERT INTO `sys_district` VALUES ('2650', '305', '崆峒区', '0');
INSERT INTO `sys_district` VALUES ('2651', '305', '泾川县', '0');
INSERT INTO `sys_district` VALUES ('2652', '305', '灵台县', '0');
INSERT INTO `sys_district` VALUES ('2653', '305', '崇信县', '0');
INSERT INTO `sys_district` VALUES ('2654', '305', '华亭县', '0');
INSERT INTO `sys_district` VALUES ('2655', '305', '庄浪县', '0');
INSERT INTO `sys_district` VALUES ('2656', '305', '静宁县', '0');
INSERT INTO `sys_district` VALUES ('2657', '306', '肃州区', '0');
INSERT INTO `sys_district` VALUES ('2658', '306', '金塔县', '0');
INSERT INTO `sys_district` VALUES ('2659', '306', '安西县', '0');
INSERT INTO `sys_district` VALUES ('2660', '306', '肃北蒙古族自治县', '0');
INSERT INTO `sys_district` VALUES ('2661', '306', '阿克塞哈萨克族自治县', '0');
INSERT INTO `sys_district` VALUES ('2662', '306', '玉门市', '0');
INSERT INTO `sys_district` VALUES ('2663', '306', '敦煌市', '0');
INSERT INTO `sys_district` VALUES ('2664', '307', '西峰区', '0');
INSERT INTO `sys_district` VALUES ('2665', '307', '庆城县', '0');
INSERT INTO `sys_district` VALUES ('2666', '307', '环县', '0');
INSERT INTO `sys_district` VALUES ('2667', '307', '华池县', '0');
INSERT INTO `sys_district` VALUES ('2668', '307', '合水县', '0');
INSERT INTO `sys_district` VALUES ('2669', '307', '正宁县', '0');
INSERT INTO `sys_district` VALUES ('2670', '307', '宁县', '0');
INSERT INTO `sys_district` VALUES ('2671', '307', '镇原县', '0');
INSERT INTO `sys_district` VALUES ('2672', '308', '安定区', '0');
INSERT INTO `sys_district` VALUES ('2673', '308', '通渭县', '0');
INSERT INTO `sys_district` VALUES ('2674', '308', '陇西县', '0');
INSERT INTO `sys_district` VALUES ('2675', '308', '渭源县', '0');
INSERT INTO `sys_district` VALUES ('2676', '308', '临洮县', '0');
INSERT INTO `sys_district` VALUES ('2677', '308', '漳县', '0');
INSERT INTO `sys_district` VALUES ('2678', '308', '岷县', '0');
INSERT INTO `sys_district` VALUES ('2679', '309', '武都区', '0');
INSERT INTO `sys_district` VALUES ('2680', '309', '成县', '0');
INSERT INTO `sys_district` VALUES ('2681', '309', '文县', '0');
INSERT INTO `sys_district` VALUES ('2682', '309', '宕昌县', '0');
INSERT INTO `sys_district` VALUES ('2683', '309', '康县', '0');
INSERT INTO `sys_district` VALUES ('2684', '309', '西和县', '0');
INSERT INTO `sys_district` VALUES ('2685', '309', '礼县', '0');
INSERT INTO `sys_district` VALUES ('2686', '309', '徽县', '0');
INSERT INTO `sys_district` VALUES ('2687', '309', '两当县', '0');
INSERT INTO `sys_district` VALUES ('2688', '310', '临夏市', '0');
INSERT INTO `sys_district` VALUES ('2689', '310', '临夏县', '0');
INSERT INTO `sys_district` VALUES ('2690', '310', '康乐县', '0');
INSERT INTO `sys_district` VALUES ('2691', '310', '永靖县', '0');
INSERT INTO `sys_district` VALUES ('2692', '310', '广河县', '0');
INSERT INTO `sys_district` VALUES ('2693', '310', '和政县', '0');
INSERT INTO `sys_district` VALUES ('2694', '310', '东乡族自治县', '0');
INSERT INTO `sys_district` VALUES ('2695', '310', '积石山保安族东乡族撒拉族自治县', '0');
INSERT INTO `sys_district` VALUES ('2696', '311', '合作市', '0');
INSERT INTO `sys_district` VALUES ('2697', '311', '临潭县', '0');
INSERT INTO `sys_district` VALUES ('2698', '311', '卓尼县', '0');
INSERT INTO `sys_district` VALUES ('2699', '311', '舟曲县', '0');
INSERT INTO `sys_district` VALUES ('2700', '311', '迭部县', '0');
INSERT INTO `sys_district` VALUES ('2701', '311', '玛曲县', '0');
INSERT INTO `sys_district` VALUES ('2702', '311', '碌曲县', '0');
INSERT INTO `sys_district` VALUES ('2703', '311', '夏河县', '0');
INSERT INTO `sys_district` VALUES ('2704', '312', '城东区', '0');
INSERT INTO `sys_district` VALUES ('2705', '312', '城中区', '0');
INSERT INTO `sys_district` VALUES ('2706', '312', '城西区', '0');
INSERT INTO `sys_district` VALUES ('2707', '312', '城北区', '0');
INSERT INTO `sys_district` VALUES ('2708', '312', '大通回族土族自治县', '0');
INSERT INTO `sys_district` VALUES ('2709', '312', '湟中县', '0');
INSERT INTO `sys_district` VALUES ('2710', '312', '湟源县', '0');
INSERT INTO `sys_district` VALUES ('2711', '313', '平安县', '0');
INSERT INTO `sys_district` VALUES ('2712', '313', '民和回族土族自治县', '0');
INSERT INTO `sys_district` VALUES ('2713', '313', '乐都县', '0');
INSERT INTO `sys_district` VALUES ('2714', '313', '互助土族自治县', '0');
INSERT INTO `sys_district` VALUES ('2715', '313', '化隆回族自治县', '0');
INSERT INTO `sys_district` VALUES ('2716', '313', '循化撒拉族自治县', '0');
INSERT INTO `sys_district` VALUES ('2717', '314', '门源回族自治县', '0');
INSERT INTO `sys_district` VALUES ('2718', '314', '祁连县', '0');
INSERT INTO `sys_district` VALUES ('2719', '314', '海晏县', '0');
INSERT INTO `sys_district` VALUES ('2720', '314', '刚察县', '0');
INSERT INTO `sys_district` VALUES ('2721', '315', '同仁县', '0');
INSERT INTO `sys_district` VALUES ('2722', '315', '尖扎县', '0');
INSERT INTO `sys_district` VALUES ('2723', '315', '泽库县', '0');
INSERT INTO `sys_district` VALUES ('2724', '315', '河南蒙古族自治县', '0');
INSERT INTO `sys_district` VALUES ('2725', '316', '共和县', '0');
INSERT INTO `sys_district` VALUES ('2726', '316', '同德县', '0');
INSERT INTO `sys_district` VALUES ('2727', '316', '贵德县', '0');
INSERT INTO `sys_district` VALUES ('2728', '316', '兴海县', '0');
INSERT INTO `sys_district` VALUES ('2729', '316', '贵南县', '0');
INSERT INTO `sys_district` VALUES ('2730', '317', '玛沁县', '0');
INSERT INTO `sys_district` VALUES ('2731', '317', '班玛县', '0');
INSERT INTO `sys_district` VALUES ('2732', '317', '甘德县', '0');
INSERT INTO `sys_district` VALUES ('2733', '317', '达日县', '0');
INSERT INTO `sys_district` VALUES ('2734', '317', '久治县', '0');
INSERT INTO `sys_district` VALUES ('2735', '317', '玛多县', '0');
INSERT INTO `sys_district` VALUES ('2736', '318', '玉树县', '0');
INSERT INTO `sys_district` VALUES ('2737', '318', '杂多县', '0');
INSERT INTO `sys_district` VALUES ('2738', '318', '称多县', '0');
INSERT INTO `sys_district` VALUES ('2739', '318', '治多县', '0');
INSERT INTO `sys_district` VALUES ('2740', '318', '囊谦县', '0');
INSERT INTO `sys_district` VALUES ('2741', '318', '曲麻莱县', '0');
INSERT INTO `sys_district` VALUES ('2742', '319', '格尔木市', '0');
INSERT INTO `sys_district` VALUES ('2743', '319', '德令哈市', '0');
INSERT INTO `sys_district` VALUES ('2744', '319', '乌兰县', '0');
INSERT INTO `sys_district` VALUES ('2745', '319', '都兰县', '0');
INSERT INTO `sys_district` VALUES ('2746', '319', '天峻县', '0');
INSERT INTO `sys_district` VALUES ('2747', '320', '兴庆区', '0');
INSERT INTO `sys_district` VALUES ('2748', '320', '西夏区', '0');
INSERT INTO `sys_district` VALUES ('2749', '320', '金凤区', '0');
INSERT INTO `sys_district` VALUES ('2750', '320', '永宁县', '0');
INSERT INTO `sys_district` VALUES ('2751', '320', '贺兰县', '0');
INSERT INTO `sys_district` VALUES ('2752', '320', '灵武市', '0');
INSERT INTO `sys_district` VALUES ('2753', '321', '大武口区', '0');
INSERT INTO `sys_district` VALUES ('2754', '321', '惠农区', '0');
INSERT INTO `sys_district` VALUES ('2755', '321', '平罗县', '0');
INSERT INTO `sys_district` VALUES ('2756', '322', '利通区', '0');
INSERT INTO `sys_district` VALUES ('2757', '322', '盐池县', '0');
INSERT INTO `sys_district` VALUES ('2758', '322', '同心县', '0');
INSERT INTO `sys_district` VALUES ('2759', '322', '青铜峡市', '0');
INSERT INTO `sys_district` VALUES ('2760', '323', '原州区', '0');
INSERT INTO `sys_district` VALUES ('2761', '323', '西吉县', '0');
INSERT INTO `sys_district` VALUES ('2762', '323', '隆德县', '0');
INSERT INTO `sys_district` VALUES ('2763', '323', '泾源县', '0');
INSERT INTO `sys_district` VALUES ('2764', '323', '彭阳县', '0');
INSERT INTO `sys_district` VALUES ('2765', '324', '沙坡头区', '0');
INSERT INTO `sys_district` VALUES ('2766', '324', '中宁县', '0');
INSERT INTO `sys_district` VALUES ('2767', '324', '海原县', '0');
INSERT INTO `sys_district` VALUES ('2768', '325', '天山区', '0');
INSERT INTO `sys_district` VALUES ('2769', '325', '沙依巴克区', '0');
INSERT INTO `sys_district` VALUES ('2770', '325', '新市区', '0');
INSERT INTO `sys_district` VALUES ('2771', '325', '水磨沟区', '0');
INSERT INTO `sys_district` VALUES ('2772', '325', '头屯河区', '0');
INSERT INTO `sys_district` VALUES ('2773', '325', '达坂城区', '0');
INSERT INTO `sys_district` VALUES ('2774', '325', '东山区', '0');
INSERT INTO `sys_district` VALUES ('2775', '325', '乌鲁木齐县', '0');
INSERT INTO `sys_district` VALUES ('2776', '326', '独山子区', '0');
INSERT INTO `sys_district` VALUES ('2777', '326', '克拉玛依区', '0');
INSERT INTO `sys_district` VALUES ('2778', '326', '白碱滩区', '0');
INSERT INTO `sys_district` VALUES ('2779', '326', '乌尔禾区', '0');
INSERT INTO `sys_district` VALUES ('2780', '327', '吐鲁番市', '0');
INSERT INTO `sys_district` VALUES ('2781', '327', '鄯善县', '0');
INSERT INTO `sys_district` VALUES ('2782', '327', '托克逊县', '0');
INSERT INTO `sys_district` VALUES ('2783', '328', '哈密市', '0');
INSERT INTO `sys_district` VALUES ('2784', '328', '巴里坤哈萨克自治县', '0');
INSERT INTO `sys_district` VALUES ('2785', '328', '伊吾县', '0');
INSERT INTO `sys_district` VALUES ('2786', '329', '昌吉市', '0');
INSERT INTO `sys_district` VALUES ('2787', '329', '阜康市', '0');
INSERT INTO `sys_district` VALUES ('2788', '329', '米泉市', '0');
INSERT INTO `sys_district` VALUES ('2789', '329', '呼图壁县', '0');
INSERT INTO `sys_district` VALUES ('2790', '329', '玛纳斯县', '0');
INSERT INTO `sys_district` VALUES ('2791', '329', '奇台县', '0');
INSERT INTO `sys_district` VALUES ('2792', '329', '吉木萨尔县', '0');
INSERT INTO `sys_district` VALUES ('2793', '329', '木垒哈萨克自治县', '0');
INSERT INTO `sys_district` VALUES ('2794', '330', '博乐市', '0');
INSERT INTO `sys_district` VALUES ('2795', '330', '精河县', '0');
INSERT INTO `sys_district` VALUES ('2796', '330', '温泉县', '0');
INSERT INTO `sys_district` VALUES ('2797', '331', '库尔勒市', '0');
INSERT INTO `sys_district` VALUES ('2798', '331', '轮台县', '0');
INSERT INTO `sys_district` VALUES ('2799', '331', '尉犁县', '0');
INSERT INTO `sys_district` VALUES ('2800', '331', '若羌县', '0');
INSERT INTO `sys_district` VALUES ('2801', '331', '且末县', '0');
INSERT INTO `sys_district` VALUES ('2802', '331', '焉耆回族自治县', '0');
INSERT INTO `sys_district` VALUES ('2803', '331', '和静县', '0');
INSERT INTO `sys_district` VALUES ('2804', '331', '和硕县', '0');
INSERT INTO `sys_district` VALUES ('2805', '331', '博湖县', '0');
INSERT INTO `sys_district` VALUES ('2806', '332', '阿克苏市', '0');
INSERT INTO `sys_district` VALUES ('2807', '332', '温宿县', '0');
INSERT INTO `sys_district` VALUES ('2808', '332', '库车县', '0');
INSERT INTO `sys_district` VALUES ('2809', '332', '沙雅县', '0');
INSERT INTO `sys_district` VALUES ('2810', '332', '新和县', '0');
INSERT INTO `sys_district` VALUES ('2811', '332', '拜城县', '0');
INSERT INTO `sys_district` VALUES ('2812', '332', '乌什县', '0');
INSERT INTO `sys_district` VALUES ('2813', '332', '阿瓦提县', '0');
INSERT INTO `sys_district` VALUES ('2814', '332', '柯坪县', '0');
INSERT INTO `sys_district` VALUES ('2815', '333', '阿图什市', '0');
INSERT INTO `sys_district` VALUES ('2816', '333', '阿克陶县', '0');
INSERT INTO `sys_district` VALUES ('2817', '333', '阿合奇县', '0');
INSERT INTO `sys_district` VALUES ('2818', '333', '乌恰县', '0');
INSERT INTO `sys_district` VALUES ('2819', '334', '喀什市', '0');
INSERT INTO `sys_district` VALUES ('2820', '334', '疏附县', '0');
INSERT INTO `sys_district` VALUES ('2821', '334', '疏勒县', '0');
INSERT INTO `sys_district` VALUES ('2822', '334', '英吉沙县', '0');
INSERT INTO `sys_district` VALUES ('2823', '334', '泽普县', '0');
INSERT INTO `sys_district` VALUES ('2824', '334', '莎车县', '0');
INSERT INTO `sys_district` VALUES ('2825', '334', '叶城县', '0');
INSERT INTO `sys_district` VALUES ('2826', '334', '麦盖提县', '0');
INSERT INTO `sys_district` VALUES ('2827', '334', '岳普湖县', '0');
INSERT INTO `sys_district` VALUES ('2828', '334', '伽师县', '0');
INSERT INTO `sys_district` VALUES ('2829', '334', '巴楚县', '0');
INSERT INTO `sys_district` VALUES ('2830', '334', '塔什库尔干塔吉克自治县', '0');
INSERT INTO `sys_district` VALUES ('2831', '335', '和田市', '0');
INSERT INTO `sys_district` VALUES ('2832', '335', '和田县', '0');
INSERT INTO `sys_district` VALUES ('2833', '335', '墨玉县', '0');
INSERT INTO `sys_district` VALUES ('2834', '335', '皮山县', '0');
INSERT INTO `sys_district` VALUES ('2835', '335', '洛浦县', '0');
INSERT INTO `sys_district` VALUES ('2836', '335', '策勒县', '0');
INSERT INTO `sys_district` VALUES ('2837', '335', '于田县', '0');
INSERT INTO `sys_district` VALUES ('2838', '335', '民丰县', '0');
INSERT INTO `sys_district` VALUES ('2839', '336', '伊宁市', '0');
INSERT INTO `sys_district` VALUES ('2840', '336', '奎屯市', '0');
INSERT INTO `sys_district` VALUES ('2841', '336', '伊宁县', '0');
INSERT INTO `sys_district` VALUES ('2842', '336', '察布查尔锡伯自治县', '0');
INSERT INTO `sys_district` VALUES ('2843', '336', '霍城县', '0');
INSERT INTO `sys_district` VALUES ('2844', '336', '巩留县', '0');
INSERT INTO `sys_district` VALUES ('2845', '336', '新源县', '0');
INSERT INTO `sys_district` VALUES ('2846', '336', '昭苏县', '0');
INSERT INTO `sys_district` VALUES ('2847', '336', '特克斯县', '0');
INSERT INTO `sys_district` VALUES ('2848', '336', '尼勒克县', '0');
INSERT INTO `sys_district` VALUES ('2849', '337', '塔城市', '0');
INSERT INTO `sys_district` VALUES ('2850', '337', '乌苏市', '0');
INSERT INTO `sys_district` VALUES ('2851', '337', '额敏县', '0');
INSERT INTO `sys_district` VALUES ('2852', '337', '沙湾县', '0');
INSERT INTO `sys_district` VALUES ('2853', '337', '托里县', '0');
INSERT INTO `sys_district` VALUES ('2854', '337', '裕民县', '0');
INSERT INTO `sys_district` VALUES ('2855', '337', '和布克赛尔蒙古自治县', '0');
INSERT INTO `sys_district` VALUES ('2856', '338', '阿勒泰市', '0');
INSERT INTO `sys_district` VALUES ('2857', '338', '布尔津县', '0');
INSERT INTO `sys_district` VALUES ('2858', '338', '富蕴县', '0');
INSERT INTO `sys_district` VALUES ('2859', '338', '福海县', '0');
INSERT INTO `sys_district` VALUES ('2860', '338', '哈巴河县', '0');
INSERT INTO `sys_district` VALUES ('2861', '338', '青河县', '0');
INSERT INTO `sys_district` VALUES ('2862', '338', '吉木乃县', '0');
INSERT INTO `sys_district` VALUES ('2867', '352', '宛平县', '1');
INSERT INTO `sys_district` VALUES ('2868', '352', '111111', '5');
INSERT INTO `sys_district` VALUES ('2869', '345', '台北', '2');

-- ----------------------------
-- Table structure for sys_hooks
-- ----------------------------
DROP TABLE IF EXISTS `sys_hooks`;
CREATE TABLE `sys_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型  1 视图 2 控制器',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  `status` tinyint(2) DEFAULT '1',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=65;

-- ----------------------------
-- Records of sys_hooks
-- ----------------------------
INSERT INTO `sys_hooks` VALUES ('23', 'login', '第三方登录', '1', 'Oauthlogin', '1', '1499327900');
INSERT INTO `sys_hooks` VALUES ('24', 'sms', '短信', '1', 'sms', '1', '1499487808');
INSERT INTO `sys_hooks` VALUES ('26', 'wxtemplatemsg', '微信模板消息设置', '1', 'wxtemplatemsg', '1', '1500013768');
INSERT INTO `sys_hooks` VALUES ('27', 'orderCreateSuccess', '订单创建成功', '2', 'wxtemplatemsg', '1', '1500025515');
INSERT INTO `sys_hooks` VALUES ('29', 'orderDeliverySuccess', '订单发货成功', '2', 'wxtemplatemsg', '1', '1500448695');
INSERT INTO `sys_hooks` VALUES ('30', 'orderPaySuccess', '订单付款成功', '2', 'wxtemplatemsg', '1', '1500448963');
INSERT INTO `sys_hooks` VALUES ('31', 'orderRefundApplyCreateSuccess', '订单申请退款创建成功', '2', 'wxtemplatemsg', '1', '1500449386');
INSERT INTO `sys_hooks` VALUES ('32', 'orderRefundSuccess', '订单退款成功', '2', 'wxtemplatemsg', '1', '1500450437');
INSERT INTO `sys_hooks` VALUES ('33', 'userWithdrawApplyCreateSuccess', '会员提现申请创建成功', '2', 'wxtemplatemsg', '1', '1500450601');
INSERT INTO `sys_hooks` VALUES ('34', 'userLoginSuccess', '用户登陆成功', '2', '', '1', '1500619318');
INSERT INTO `sys_hooks` VALUES ('35', 'userAddSuccess', '基础用户添加成功后', '2', '', '1', '1500619587');
INSERT INTO `sys_hooks` VALUES ('36', 'memberRegisterSuccess', '会员注册成功', '2', '', '1', '1500619688');
INSERT INTO `sys_hooks` VALUES ('37', 'memberLevelSaveSuccess', '会员等级保存成功', '2', '', '1', '1500620008');
INSERT INTO `sys_hooks` VALUES ('38', 'memberWithdrawApplyCreateSuccess', '会员提现申请创建成功', '2', 'wxtemplatemsg', '1', '1500620146');
INSERT INTO `sys_hooks` VALUES ('39', 'memberWithdrawAuditAgree', '会员提现审核通过', '2', 'wxtemplatemsg', '1', '1500620297');
INSERT INTO `sys_hooks` VALUES ('40', 'goodsSaveSuccess', '商品保存成功', '2', '', '1', '1500620784');
INSERT INTO `sys_hooks` VALUES ('41', 'goodsSaveBefore', '商品保存之前', '2', '', '1', '1500620803');
INSERT INTO `sys_hooks` VALUES ('42', 'goodsDeleteBefore', '商品删除之前', '2', '', '1', '1500621085');
INSERT INTO `sys_hooks` VALUES ('43', 'goodsDeleteSuccess', '商品删除成功', '2', '', '1', '1500621109');
INSERT INTO `sys_hooks` VALUES ('44', 'goodsOnlineSuccess', '商品上架成功', '2', '', '1', '1500621131');
INSERT INTO `sys_hooks` VALUES ('45', 'goodsOfflineSuccess', '商品下架成功', '2', '', '1', '1500621142');
INSERT INTO `sys_hooks` VALUES ('55', 'goodsCategorySaveSuccess', '商品分类保存成功', '2', '', '1', '1500621379');
INSERT INTO `sys_hooks` VALUES ('56', 'goodsCategoryDeleteSuccess', '商品分类删除成功', '2', '', '1', '1500621397');
INSERT INTO `sys_hooks` VALUES ('57', 'goodsBrandSaveSuccess', '商品品牌保存成功', '2', '', '1', '1500621414');
INSERT INTO `sys_hooks` VALUES ('58', 'goodsBrandDeleteSuccess', '商品品牌删除成功', '2', '', '1', '1500621428');
INSERT INTO `sys_hooks` VALUES ('59', 'goodsGroupSaveSuccess', '商品分组保存成功', '2', '', '1', '1500621441');
INSERT INTO `sys_hooks` VALUES ('60', 'goodsGroupDeleteSuccess', '商品分组删除成功', '2', '', '1', '1500621455');
INSERT INTO `sys_hooks` VALUES ('61', 'goodsSpecSaveSuccess', '商品规格保存成功', '2', '', '1', '1500621470');
INSERT INTO `sys_hooks` VALUES ('62', 'goodsSpecDeleteSuccess', '商品规格删除成功', '2', '', '1', '1500621483');
INSERT INTO `sys_hooks` VALUES ('63', 'goodsAttributeSaveSuccess', '商品类型保存成功', '2', '', '1', '1500621495');
INSERT INTO `sys_hooks` VALUES ('64', 'goodsAttributeDeleteSuccess', '商品类型删除成功', '2', '', '1', '1500621506');

-- ----------------------------
-- Table structure for sys_instance
-- ----------------------------
DROP TABLE IF EXISTS `sys_instance`;
CREATE TABLE `sys_instance` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `instance_name` varchar(50) NOT NULL DEFAULT '' COMMENT '实例名',
  `instance_typeid` int(11) NOT NULL DEFAULT '2' COMMENT '实例类型ID',
  `qrcode` varchar(255) NOT NULL DEFAULT '' COMMENT '实例二维码',
  `remark` text COMMENT '实例简介',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1365 COMMENT='系统实例表';

-- ----------------------------
-- Records of sys_instance
-- ----------------------------
INSERT INTO `sys_instance` VALUES ('19', 'Niushop开源商城', '1', '', '\'\'', '1477541018');

-- ----------------------------
-- Table structure for sys_instance_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_instance_type`;
CREATE TABLE `sys_instance_type` (
  `instance_typeid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '实例类型ID',
  `type_name` varchar(50) NOT NULL DEFAULT '' COMMENT '实例类型名称',
  `type_module_array` text NOT NULL COMMENT '实例类型权限',
  `type_desc` text NOT NULL COMMENT '实例类型说明',
  `type_sort` int(11) NOT NULL DEFAULT '1' COMMENT '排序号',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`instance_typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='实例类型';

-- ----------------------------
-- Records of sys_instance_type
-- ----------------------------

-- ----------------------------
-- Table structure for sys_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_module`;
CREATE TABLE `sys_module` (
  `module_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT '模块标题',
  `module` varchar(255) NOT NULL DEFAULT 'admin' COMMENT '项目名',
  `controller` varchar(255) NOT NULL DEFAULT '' COMMENT '控制器名',
  `method` varchar(255) NOT NULL DEFAULT '' COMMENT '方法名',
  `pid` int(10) NOT NULL DEFAULT '0' COMMENT '上级模块ID',
  `level` int(11) NOT NULL DEFAULT '1' COMMENT '深度等级',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `is_menu` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是菜单',
  `is_dev` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `desc` text COMMENT '模块描述',
  `module_picture` varchar(255) NOT NULL DEFAULT '' COMMENT '模块图片',
  `icon_class` varchar(255) NOT NULL DEFAULT '' COMMENT '矢量图class',
  `is_control_auth` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否控制权限',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10109 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=606 COMMENT='系统模块表';

-- ----------------------------
-- Records of sys_module
-- ----------------------------
INSERT INTO `sys_module` VALUES ('120', '系统', 'admin', 'system', 'modulelist', '0', '1', 'system/modulelist', '1', '0', '999', '\'\'', '', '', '1', '1477454152', '1477794717');
INSERT INTO `sys_module` VALUES ('121', '模块列表', 'admin', 'system', 'modulelist', '120', '2', 'system/modulelist', '1', '0', '2', '\'\'', '', '', '1', '0', null);
INSERT INTO `sys_module` VALUES ('122', '添加模块', 'admin', 'system', 'addmodule', '121', '3', 'system/addmodule', '0', '0', '1', '添加模块', '', '', '1', '0', '1479976597');
INSERT INTO `sys_module` VALUES ('123', '修改模块', 'admin', 'system', 'editmodule', '121', '3', 'system/editmodule', '0', '0', '2', '修改模块', '', '', '1', '0', '1479976646');
INSERT INTO `sys_module` VALUES ('126', '用户', 'admin', 'auth', 'userlist', '0', '1', 'auth/userlist', '1', '0', '11', '', '', '', '1', '0', '1484650663');
INSERT INTO `sys_module` VALUES ('127', '用户列表', 'admin', 'auth', 'userlist', '126', '2', 'auth/userlist', '1', '0', '0', null, '', '', '1', '0', null);
INSERT INTO `sys_module` VALUES ('128', '用户组列表', 'admin', 'auth', 'authgrouplist', '126', '2', 'auth/authgrouplist', '1', '0', '0', '用户组', '', '', '1', '0', '1479976919');
INSERT INTO `sys_module` VALUES ('129', '删除模块', 'admin', 'system', 'delmodule', '121', '3', 'system/delmodule', '0', '0', '0', '模块列表', '', '', '1', '1477618350', '1479976723');
INSERT INTO `sys_module` VALUES ('133', '添加用户组', 'admin', 'auth', 'addusergroup', '128', '3', 'auth/addusergroup', '0', '0', '2', '用户组', '', '', '1', '1477628544', '1479977008');
INSERT INTO `sys_module` VALUES ('137', '会员', 'admin', 'member', 'memberlist', '0', '1', 'member/memberlist', '1', '0', '5', '', '', '', '1', '1477994717', '1493206725');
INSERT INTO `sys_module` VALUES ('139', '相册管理', 'admin', 'system', 'albumlist', '149', '2', 'system/albumlist', '1', '0', '10', '相册管理', '', '', '1', '1478158094', '1496819610');
INSERT INTO `sys_module` VALUES ('144', '编辑用户', 'admin', 'auth', 'edituser', '127', '3', 'auth/edituser', '0', '0', '5', '用户', '', '', '1', '1478837447', '1479976963');
INSERT INTO `sys_module` VALUES ('145', '会员列表', 'admin', 'member', 'memberlist', '137', '2', 'member/memberlist', '1', '0', '1', '', '', '', '1', '1478846113', '1478846203');
INSERT INTO `sys_module` VALUES ('149', '商品', 'admin', 'goods', 'goodslist', '0', '1', 'goods/goodslist', '1', '0', '1', '商品模块', '', '', '1', '1479268148', '1493973167');
INSERT INTO `sys_module` VALUES ('150', '商品列表', 'admin', 'goods', 'goodslist', '149', '2', 'goods/goodslist', '1', '0', '1', '商品列表', '', '', '0', '1479268236', '1491898725');
INSERT INTO `sys_module` VALUES ('151', '商品发布', 'admin', 'goods', 'addgoods', '149', '2', 'goods/addgoods', '1', '0', '2', '商品发布', '', '', '1', '1479268307', null);
INSERT INTO `sys_module` VALUES ('169', '图片管理', 'admin', 'system', 'albumpicturelist', '139', '3', 'system/albumpicturelist', '0', '0', '5', 'sfgsdf', '', '', '1', '1479464708', '1479976790');
INSERT INTO `sys_module` VALUES ('170', '添加运费模板', 'admin', 'express', 'transportationadd', '164', '3', 'express/transportationadd', '0', '0', '1', '添加运费模板', '', '', '1', '1479700610', '1484894376');
INSERT INTO `sys_module` VALUES ('171', '商品标签', 'admin', 'goods', 'goodsgrouplist', '149', '2', 'goods/goodsgrouplist', '1', '0', '3', '商品分组', '', '', '1', '1479873298', '1479960182');
INSERT INTO `sys_module` VALUES ('172', '添加商品标签', 'admin', 'goods', 'addgoodsgroup', '171', '3', 'goods/addgoodsgroup', '0', '0', '6', '添加商品分组', '', '', '1', '1479873424', '1479960243');
INSERT INTO `sys_module` VALUES ('176', '运费模板修改', 'admin', 'express', 'transportationedit', '164', '3', 'express/transportationedit', '0', '0', '6', 'sd', '', '', '1', '1480040625', null);
INSERT INTO `sys_module` VALUES ('179', '营销', 'admin', 'promotion', 'coupontypelist', '0', '1', 'promotion/coupontypelist', '1', '0', '4', '优惠券类型列表', '', '', '1', '1480491652', '1480491725');
INSERT INTO `sys_module` VALUES ('180', '优惠券', 'admin', 'promotion', 'coupontypelist', '179', '2', 'promotion/coupontypelist', '1', '0', '1', '优惠券类型列表', '', '', '1', '1480491846', null);
INSERT INTO `sys_module` VALUES ('184', '订单', 'admin', 'order', 'orderlist', '0', '1', 'order/orderlist', '1', '0', '3', '订单列表', '', '', '1', '1480563137', null);
INSERT INTO `sys_module` VALUES ('185', '订单列表', 'admin', 'order', 'orderlist', '184', '2', 'order/orderlist', '1', '0', '1', '订单列表', '', '', '1', '1480563210', null);
INSERT INTO `sys_module` VALUES ('186', '添加优惠券', 'admin', 'promotion', 'addcoupontype', '180', '3', 'promotion/addcoupontype', '1', '0', '2', '添加优惠券类型', '', '', '1', '1480573171', null);
INSERT INTO `sys_module` VALUES ('187', '修改优惠券', 'admin', 'promotion', 'updatecoupontype', '180', '3', 'promotion/updatecoupontype', '1', '0', '3', '修改优惠券类型', '', '', '1', '1480904943', null);
INSERT INTO `sys_module` VALUES ('189', '物流公司', 'admin', 'express', 'expresscompany', '529', '3', 'express/expresscompany', '0', '0', '60', '物流公司', '', '', '1', '1481254866', '1484894344');
INSERT INTO `sys_module` VALUES ('190', '订单详情', 'admin', 'order', 'orderdetail', '185', '3', 'order/orderdetail', '0', '0', '1', '订单详情', '', '', '1', '1481258173', null);
INSERT INTO `sys_module` VALUES ('191', '添加物流公司', 'admin', 'express', 'addexpresscompany', '529', '3', 'express/addexpresscompany', '1', '0', '1', '添加物流公司', '', '', '1', '1481267828', null);
INSERT INTO `sys_module` VALUES ('192', '物流公司修改', 'admin', 'express', 'updateexpresscompany', '529', '3', 'express/updateexpresscompany', '1', '0', '2', '物流公司修改排序', '', '', '1', '1481271808', null);
INSERT INTO `sys_module` VALUES ('194', '退款详情', 'admin', 'order', 'orderrefunddetail', '185', '3', 'order/orderrefunddetail', '0', '0', '2', '退款详情', '', '', '1', '1481872074', null);
INSERT INTO `sys_module` VALUES ('195', '赠品', 'admin', 'promotion', 'giftlist', '179', '2', 'promotion/giftlist', '0', '0', '3', '', '', '', '1', '1482113074', '1494215988');
INSERT INTO `sys_module` VALUES ('196', '添加赠品', 'admin', 'promotion', 'addgift', '195', '3', 'promotion/addgift', '1', '0', '0', '添加赠品', '', '', '1', '1482113664', '1482117539');
INSERT INTO `sys_module` VALUES ('197', '修改赠品', 'admin', 'promotion', 'updategift', '195', '3', 'promotion/updategift', '1', '0', '0', '修改赠品', '', '', '1', '1482113715', '1482117558');
INSERT INTO `sys_module` VALUES ('198', '满减送', 'admin', 'promotion', 'mansonglist', '179', '2', 'promotion/mansonglist', '1', '0', '4', '满减送', '', '', '1', '1482138580', '1482138597');
INSERT INTO `sys_module` VALUES ('199', '添加满减满送', 'admin', 'promotion', 'addmansong', '198', '3', 'promotion/addmansong', '1', '0', '0', '满减送', '', '', '1', '1482140311', null);
INSERT INTO `sys_module` VALUES ('200', '编辑满减送', 'admin', 'promotion', 'updatemansong', '198', '3', 'promotion/updatemansong', '1', '0', '1', '编辑满减送', '', '', '1', '1482907059', null);
INSERT INTO `sys_module` VALUES ('201', '限时折扣', 'admin', 'promotion', 'getdiscountlist', '179', '2', 'promotion/getdiscountlist', '1', '0', '5', '限时折扣', '', '', '1', '1483949283', null);
INSERT INTO `sys_module` VALUES ('202', '添加限时折扣', 'admin', 'promotion', 'adddiscount', '201', '3', 'promotion/adddiscount', '1', '0', '0', '添加限时折扣', '', '', '1', '1483951104', null);
INSERT INTO `sys_module` VALUES ('203', '修改限时折扣', 'admin', 'promotion', 'updatediscount', '201', '3', 'promotion/updatediscount', '1', '0', '1', '修改限时折扣', '', '', '1', '1483951151', '1483958451');
INSERT INTO `sys_module` VALUES ('210', '修改商品标签', 'admin', 'goods', 'updategoodsgroup', '171', '3', 'goods/updategoodsgroup', '0', '0', '2', '修改商品分组', '', '', '1', '1484120298', '1484125917');
INSERT INTO `sys_module` VALUES ('218', '设置', 'admin', 'config', 'webconfig', '0', '1', 'config/webconfig', '1', '0', '12', '店铺设置', '', '', '1', '1484617355', '1493348177');
INSERT INTO `sys_module` VALUES ('221', '支付配置', 'admin', 'config', 'paymentconfig', '218', '2', 'config/paymentconfig', '1', '0', '40', '支付配置', '\'\'', '', '1', '1484623427', '1496820428');
INSERT INTO `sys_module` VALUES ('334', '咨询管理', 'admin', 'saleservice', 'consultlist', '149', '2', 'saleservice/consultlist', '1', '0', '8', '咨询管理，未回复咨询，已回复咨询', '', '', '1', '1488875702', '1496392553');
INSERT INTO `sys_module` VALUES ('335', '微信', 'admin', 'wchat', 'config', '0', '1', 'wchat/config', '1', '0', '9', '微信', '', '', '1', '1488945338', '1493015492');
INSERT INTO `sys_module` VALUES ('336', '公众号管理', 'admin', 'wchat', 'config', '335', '2', 'wchat/config', '1', '0', '1', '公众号管理', '', '', '1', '1488945416', null);
INSERT INTO `sys_module` VALUES ('339', '微信菜单管理', 'admin', 'wchat', 'menu', '335', '2', 'wchat/menu', '1', '0', '2', '微信菜单管理', '', '', '1', '1489046481', null);
INSERT INTO `sys_module` VALUES ('340', '推广二维码管理', 'admin', 'wchat', 'weixinqrcodetemplate', '335', '2', 'wchat/weixinqrcodetemplate', '1', '0', '3', '推广二维码管理', '', '', '1', '1489046596', '1490153341');
INSERT INTO `sys_module` VALUES ('341', '回复设置', 'admin', 'wchat', 'replayconfig', '335', '2', 'wchat/replayconfig', '1', '0', '4', '', '', '', '1', '1489046662', null);
INSERT INTO `sys_module` VALUES ('342', '消息素材管理', 'admin', 'wchat', 'materialmessage', '335', '2', 'wchat/materialmessage', '1', '0', '6', '', '', '', '1', '1489046731', null);
INSERT INTO `sys_module` VALUES ('343', '分享内容设置', 'admin', 'wchat', 'shareconfig', '335', '2', 'wchat/shareconfig', '1', '0', '7', '', '', '', '1', '1489046804', null);
INSERT INTO `sys_module` VALUES ('358', '自定义推广二维码', 'admin', 'wchat', 'qrcode', '340', '3', 'wchat/qrcode', '0', '0', '1', '自定义二维码', '', '', '1', '1490153257', '1490153278');
INSERT INTO `sys_module` VALUES ('359', '添加回复', 'admin', 'wchat', 'addorupdatekeyreplay', '341', '3', 'wchat/addorupdatekeyreplay', '1', '0', '1', '', '', '', '1', '1490236498', null);
INSERT INTO `sys_module` VALUES ('360', '添加用户', 'admin', 'auth', 'adduser', '127', '3', 'auth/adduser', '0', '0', '1', '添加用户', '', '', '1', '1490236731', null);
INSERT INTO `sys_module` VALUES ('361', '一键关注设置', 'admin', 'wchat', 'onekeysubscribe', '335', '2', 'wchat/onekeysubscribe', '0', '0', '6', '一键关注设置', '', '', '1', '1490318979', '1496386363');
INSERT INTO `sys_module` VALUES ('381', '广告位', 'admin', 'system', 'shopadvpositionlist', '477', '2', 'system/shopadvpositionlist', '1', '0', '9', '广告位设置', '', '', '1', '1490774263', '1496320676');
INSERT INTO `sys_module` VALUES ('382', '广告管理', 'admin', 'system', 'shopadvlist', '381', '3', 'system/shopadvlist', '0', '0', '0', '广告管理', '', '', '1', '1490785255', null);
INSERT INTO `sys_module` VALUES ('383', '添加广告位', 'admin', 'system', 'addshopadvposition', '381', '3', 'system/addshopadvposition', '0', '0', '0', '添加广告位', '', '', '1', '1490835009', null);
INSERT INTO `sys_module` VALUES ('387', '广告位编辑', 'admin', 'system', 'updateshopadvposition', '381', '3', 'system/updateshopadvposition', '1', '0', '0', '广告位编辑', '', '', '1', '1490851266', null);
INSERT INTO `sys_module` VALUES ('388', '添加广告', 'admin', 'system', 'addshopadv', '381', '3', 'system/addshopadv', '0', '0', '0', '添加广告', '', '', '1', '1490854140', null);
INSERT INTO `sys_module` VALUES ('389', '广告编辑', 'admin', 'system', 'updateshopadv', '381', '3', 'system/updateshopadv', '0', '0', '0', '', '', '', '1', '1490857038', null);
INSERT INTO `sys_module` VALUES ('390', '促销版块', 'admin', 'system', 'goodsrecommendclass', '10004', '3', 'system/goodsrecommendclass', '0', '0', '10', '促销版块管理', '', '', '1', '1490861814', '1496320694');
INSERT INTO `sys_module` VALUES ('392', '首页楼层', 'admin', 'system', 'blocklist', '10004', '3', 'system/blocklist', '0', '0', '11', '', '', '', '1', '1490947012', '1496320711');
INSERT INTO `sys_module` VALUES ('394', '添加楼层', 'admin', 'system', 'addblock', '10004', '3', 'system/addblock', '0', '0', '0', '', '', '', '1', '1490948318', null);
INSERT INTO `sys_module` VALUES ('395', '楼层编辑', 'admin', 'system', 'updateblock', '10004', '3', 'system/updateblock', '0', '0', '0', '', '', '', '1', '1490948388', '1490952538');
INSERT INTO `sys_module` VALUES ('398', '个人资料', 'admin', 'auth', 'userdetail', '126', '2', 'auth/userdetail', '1', '0', '0', '个人资料', '', '', '0', '1491029995', '1494298490');
INSERT INTO `sys_module` VALUES ('403', '销售排行', 'admin', 'account', 'shopgoodssalesrank', '409', '2', 'account/shopgoodssalesrank', '1', '0', '9', '商品销售排行', '', '', '1', '1491040090', '1496819701');
INSERT INTO `sys_module` VALUES ('405', '商品销售统计', 'admin', 'account', 'shopgoodsaccountlist', '403', '3', 'account/shopgoodsaccountlist', '0', '0', '6', '商品销售统计', '', '', '1', '1491042742', null);
INSERT INTO `sys_module` VALUES ('409', '财务', 'admin', 'account', 'shopsalesaccount', '0', '1', 'account/shopsalesaccount', '1', '0', '8', '资产', '', '', '1', '1493281488', '1547804470');
INSERT INTO `sys_module` VALUES ('418', '网站设置', 'admin', 'config', 'webconfig', '528', '3', 'config/webconfig', '0', '0', '2', '', '', '', '1', '1492755047', null);
INSERT INTO `sys_module` VALUES ('419', '商品分类', 'admin', 'goods', 'goodscategorylist', '149', '2', 'goods/goodscategorylist', '1', '0', '2', '商品分类', '', '', '1', '1492755701', null);
INSERT INTO `sys_module` VALUES ('420', '添加商品分类', 'admin', 'goods', 'addgoodscategory', '419', '3', 'goods/addgoodscategory', '1', '0', '2', '添加商品分类', '', '', '1', '1492755811', '1492755828');
INSERT INTO `sys_module` VALUES ('421', '修改商品分类', 'admin', 'goods', 'updategoodscategory', '419', '3', 'goods/updategoodscategory', '1', '0', '1', '修改商品分类', '', '', '1', '1492755920', null);
INSERT INTO `sys_module` VALUES ('422', '删除商品分类', 'admin', 'goods', 'deletegoodscategory', '419', '3', 'goods/deletegoodscategory', '1', '0', '2', '删除商品分类', '', '', '1', '1492755973', null);
INSERT INTO `sys_module` VALUES ('423', '商品品牌', 'admin', 'goods', 'goodsbrandlist', '149', '2', 'goods/goodsbrandlist', '1', '0', '3', '商品品牌列表', '', '', '1', '1492756038', null);
INSERT INTO `sys_module` VALUES ('424', '添加商品品牌', 'admin', 'goods', 'addgoodsbrand', '423', '3', 'goods/addgoodsbrand', '1', '0', '1', '添加商品品牌', '', '', '1', '1492756096', null);
INSERT INTO `sys_module` VALUES ('425', '修改商品品牌', 'admin', 'goods', 'updategoodsbrand', '423', '3', 'goods/updategoodsbrand', '1', '0', '4', '修改商品品牌', '', '', '1', '1492756169', null);
INSERT INTO `sys_module` VALUES ('427', '导航管理', 'admin', 'config', 'shopnavigationlist', '10004', '3', 'config/shopnavigationlist', '0', '0', '1', '导航', '', '', '1', '1492761752', '1496320733');
INSERT INTO `sys_module` VALUES ('428', '添加导航', 'admin', 'config', 'addshopnavigation', '10004', '3', 'config/addshopnavigation', '1', '0', '2', '添加导航', '', '', '0', '1492761909', null);
INSERT INTO `sys_module` VALUES ('429', '修改导航', 'admin', 'config', 'updateshopnavigation', '10004', '3', 'config/updateshopnavigation', '1', '0', '3', '修改导航', '', '', '0', '1492762515', null);
INSERT INTO `sys_module` VALUES ('430', '友情链接', 'admin', 'config', 'linklist', '10004', '3', 'config/linklist', '0', '0', '13', '友情链接', '', '', '1', '1492765269', '1496320750');
INSERT INTO `sys_module` VALUES ('431', '文章管理', 'admin', 'cms', 'articlelist', '477', '2', 'cms/articlelist', '1', '0', '18', 'Cms系统', '', '', '1', '1492782512', '1492782619');
INSERT INTO `sys_module` VALUES ('432', '文章列表', 'admin', 'cms', 'articlelist', '431', '3', 'cms/articlelist', '0', '0', '1', '文章列表', '', '', '1', '1492782808', '1492782837');
INSERT INTO `sys_module` VALUES ('433', '文章分类', 'admin', 'cms', 'articleclasslist', '431', '3', 'cms/articleclasslist', '0', '0', '2', '文章列表', '', '', '1', '1492782934', '1492782952');
INSERT INTO `sys_module` VALUES ('434', '评论列表', 'admin', 'cms', 'commentarticle', '431', '2', 'cms/commentarticle', '0', '0', '3', '评论列表', '', '', '1', '1492782991', '1497084797');
INSERT INTO `sys_module` VALUES ('435', '搜索设置', 'admin', 'config', 'searchconfig', '10004', '3', 'config/searchconfig', '0', '0', '14', '搜索设置', '', '', '1', '1493187802', '1496321601');
INSERT INTO `sys_module` VALUES ('436', '添加友情链接', 'admin', 'config', 'addlink', '10004', '3', 'config/addlink', '0', '0', '1', '添加友情链接', '', '', '1', '1493190273', '1493190306');
INSERT INTO `sys_module` VALUES ('437', '编辑友情链接', 'admin', 'config', 'updatelink', '10004', '3', 'config/updatelink', '0', '0', '2', '编辑友情链接', '', '', '1', '1493192018', null);
INSERT INTO `sys_module` VALUES ('438', '验证码设置', 'admin', 'config', 'codeconfig', '528', '3', 'config/codeconfig', '0', '0', '15', '验证码设置', '', '', '1', '1493192505', '1493192978');
INSERT INTO `sys_module` VALUES ('439', '通知系统', 'admin', 'config', 'notifyindex', '218', '2', 'config/notifyindex', '1', '0', '30', 'messageConfig', '', '', '1', '1493194795', '1496722814');
INSERT INTO `sys_module` VALUES ('440', '帮助类型', 'admin', 'config', 'helpclass', '530', '3', 'config/helpclass', '0', '0', '10', '帮助类型', '', '', '1', '1493199934', '1496320786');
INSERT INTO `sys_module` VALUES ('441', '帮助内容', 'admin', 'config', 'helpdocument', '530', '3', 'config/helpdocument', '0', '0', '18', '帮助内容', '', '', '1', '1493201598', '1496320803');
INSERT INTO `sys_module` VALUES ('442', '添加帮助类型', 'admin', 'config', 'addhelpclass', '530', '3', 'config/addhelpclass', '0', '0', '1', '添加帮助类型', '', '', '1', '1493201673', null);
INSERT INTO `sys_module` VALUES ('443', '修改帮助内容', 'admin', 'config', 'updatedocument', '530', '3', 'config/updatedocument', '0', '0', '2', 'updateDocument.html', '', '', '1', '1493203409', null);
INSERT INTO `sys_module` VALUES ('444', '添加帮助内容', 'admin', 'config', 'adddocument', '530', '3', 'config/adddocument', '0', '0', '2', 'aaddDocument', '', '', '1', '1493205866', null);
INSERT INTO `sys_module` VALUES ('445', '首页公告', 'admin', 'config', 'usernotice', '10004', '3', 'config/usernotice', '0', '0', '20', 'userNotice', '', '', '1', '1493206256', '1496321121');
INSERT INTO `sys_module` VALUES ('446', '积分管理', 'admin', 'promotion', 'pointconfig', '179', '2', 'promotion/pointconfig', '1', '0', '1', '1', '', '', '1', '1493206530', '1496894015');
INSERT INTO `sys_module` VALUES ('447', '粉丝列表', 'admin', 'member', 'weixinfanslist', '137', '2', 'member/weixinfanslist', '1', '0', '2', '粉丝列表', '', '', '1', '1493278702', null);
INSERT INTO `sys_module` VALUES ('450', '修改消息素材', 'admin', 'wchat', 'updatemedia', '342', '3', 'wchat/updatemedia', '1', '0', '1', '', '', '', '1', '1493282078', '1493282297');
INSERT INTO `sys_module` VALUES ('451', '添加消息素材', 'admin', 'wchat', 'addmedia', '342', '3', 'wchat/addmedia', '1', '0', '1', '', '', '', '1', '1493282371', null);
INSERT INTO `sys_module` VALUES ('452', '添加文章', 'admin', 'cms', 'addarticle', '431', '3', 'cms/addarticle', '0', '0', '4', '', '', '', '1', '1493287571', '1493289825');
INSERT INTO `sys_module` VALUES ('454', '销售统计', 'admin', 'account', 'orderaccountcount', '409', '2', 'account/orderaccountcount', '0', '0', '6', '', '', '', '1', '1493289961', '1493981704');
INSERT INTO `sys_module` VALUES ('455', '修改文章', 'admin', 'cms', 'updatearticle', '431', '3', 'cms/updatearticle', '0', '0', '2', '', '', '', '1', '1493343780', null);
INSERT INTO `sys_module` VALUES ('456', '第三方登录', 'admin', 'config', 'partylogin', '218', '2', 'config/partylogin', '1', '0', '20', '', '', '', '1', '1493347646', '1496903436');
INSERT INTO `sys_module` VALUES ('457', '销售明细', 'admin', 'account', 'orderrecordslist', '454', '3', 'account/orderrecordslist', '0', '0', '2', '', '', '', '1', '1493705080', '1493705419');
INSERT INTO `sys_module` VALUES ('459', '销售概况', 'admin', 'account', 'shopsalesaccount', '409', '2', 'account/shopsalesaccount', '1', '0', '1', '', '', '', '1', '1493776001', '1493974321');
INSERT INTO `sys_module` VALUES ('460', '热卖商品', 'admin', 'account', 'bestsellergoods', '463', '3', 'account/bestsellergoods', '0', '0', '1', '', '', '', '1', '1493867120', '1493972190');
INSERT INTO `sys_module` VALUES ('461', '同行热卖', 'admin', 'account', 'shopgoodsgroupsalecount', '409', '2', 'account/shopgoodsgroupsalecount', '1', '0', '4', '', '', '', '1', '1493946658', '1493950999');
INSERT INTO `sys_module` VALUES ('462', '运营报告', 'admin', 'account', 'shopreport', '409', '2', 'account/shopreport', '1', '0', '5', '', '', '', '1', '1493947412', null);
INSERT INTO `sys_module` VALUES ('463', '商品分析', 'admin', 'account', 'shopgoodssaleslist', '409', '2', 'account/shopgoodssaleslist', '1', '0', '2', '', '', '', '1', '1493949799', null);
INSERT INTO `sys_module` VALUES ('467', '首页', 'admin', 'index', 'index', '0', '1', 'index/index', '1', '0', '0', '', '', '', '0', '1494485612', '1497071676');
INSERT INTO `sys_module` VALUES ('469', '满额包邮', 'admin', 'promotion', 'fullshipping', '179', '2', 'promotion/fullshipping', '1', '0', '6', '满额包邮设置', '', '', '1', '1494928162', null);
INSERT INTO `sys_module` VALUES ('471', '商家地址', 'admin', 'order', 'returnsetting', '529', '3', 'order/returnsetting', '0', '0', '70', '退货设置', '', '', '1', '1496215760', '1496216046');
INSERT INTO `sys_module` VALUES ('472', '添加或修改', 'admin', 'order', 'addreturn', '529', '3', 'order/addreturn', '1', '0', '1', '添加退货', '', '', '1', '1496215892', '1496216067');
INSERT INTO `sys_module` VALUES ('474', '首页公告', 'admin', 'config', 'updatenotice', '10005', '3', 'config/updatenotice', '0', '0', '15', '公告', '', '', '1', '1496291567', '1496320766');
INSERT INTO `sys_module` VALUES ('477', '网站', 'admin', 'config', 'shopnavigationlist', '0', '1', 'config/shopnavigationlist', '1', '0', '10', '导航管理', '', '', '1', '1496303515', '1496821512');
INSERT INTO `sys_module` VALUES ('478', '商品评价', 'admin', 'goods', 'goodscomment', '149', '2', 'goods/goodscomment', '1', '0', '8', '', '', '', '1', '1496310914', null);
INSERT INTO `sys_module` VALUES ('479', '商品规格', 'admin', 'goods', 'goodsspeclist', '149', '2', 'goods/goodsspeclist', '1', '0', '6', '商品规格', '', '', '1', '1496314078', '1496368479');
INSERT INTO `sys_module` VALUES ('480', '添加商品规格', 'admin', 'goods', 'addgoodsspec', '479', '3', 'goods/addgoodsspec', '0', '0', '1', '', '', '', '1', '1496368895', null);
INSERT INTO `sys_module` VALUES ('481', '修改商品规格', 'admin', 'goods', 'updategoodsspec', '479', '3', 'goods/updategoodsspec', '0', '0', '0', '', '', '', '1', '1496386955', null);
INSERT INTO `sys_module` VALUES ('482', '商品类型', 'admin', 'goods', 'attributelist', '149', '2', 'goods/attributelist', '1', '0', '7', '', '', '', '1', '1496392434', '1496392497');
INSERT INTO `sys_module` VALUES ('484', '添加商品类型', 'admin', 'goods', 'addattributeservice', '482', '3', 'goods/addattributeservice', '0', '0', '0', '', '', '', '1', '1496395497', '1496457873');
INSERT INTO `sys_module` VALUES ('485', '修改商品类型', 'admin', 'goods', 'updategoodsattribute', '482', '3', 'goods/updategoodsattribute', '0', '0', '0', '', '', '', '1', '1496396084', null);
INSERT INTO `sys_module` VALUES ('486', '地区管理', 'admin', 'config', 'areamanagement', '529', '3', 'config/areamanagement', '0', '0', '50', '', '', '', '1', '1496452390', null);
INSERT INTO `sys_module` VALUES ('487', '模板编辑', 'admin', 'express', 'expresstemplate', '529', '3', 'express/expresstemplate', '0', '0', '0', '', '', '', '1', '1496459993', null);
INSERT INTO `sys_module` VALUES ('488', '会员等级', 'admin', 'member', 'memberlevellist', '137', '2', 'member/memberlevellist', '1', '0', '3', '会员等级', '', '', '1', '1496462360', null);
INSERT INTO `sys_module` VALUES ('489', '添加等级', 'admin', 'member', 'addmemberlevel', '488', '3', 'member/addmemberlevel', '1', '0', '1', '添加等级', '', '', '1', '1496483895', null);
INSERT INTO `sys_module` VALUES ('490', '修改等级', 'admin', 'member', 'updatememberlevel', '488', '3', 'member/updatememberlevel', '1', '0', '0', '修改等级', '', '', '1', '1496483933', '1496485692');
INSERT INTO `sys_module` VALUES ('491', '专题列表', 'admin', 'cms', 'topiclist', '477', '2', 'cms/topiclist', '1', '0', '19', '专题列表', '', '', '1', '1496630179', '1496632713');
INSERT INTO `sys_module` VALUES ('492', '添加专题', 'admin', 'cms', 'addtopic', '491', '3', 'cms/addtopic', '1', '0', '1', '添加专题', '', '', '1', '1496630640', '1496632753');
INSERT INTO `sys_module` VALUES ('493', '修改专题', 'admin', 'cms', 'updatetopic', '491', '3', 'cms/updatetopic', '1', '0', '2', '修改专题', '', '', '1', '1496630696', '1496632781');
INSERT INTO `sys_module` VALUES ('494', '购物设置', 'admin', 'config', 'shopset', '528', '3', 'config/shopset', '0', '0', '44', '购物设置', '', '', '1', '1496716845', '1496717062');
INSERT INTO `sys_module` VALUES ('495', '邮件设置', 'admin', 'config', 'messageconfig', '439', '3', 'config/messageconfig', '0', '0', '0', '', '', '', '1', '1496731597', null);
INSERT INTO `sys_module` VALUES ('496', '短信设置', 'admin', 'config', 'messageconfig', '439', '3', 'config/messageconfig', '0', '0', '0', '', '', '', '1', '1496731636', null);
INSERT INTO `sys_module` VALUES ('497', '会员积分明细', 'admin', 'member', 'pointdetail', '145', '3', 'member/pointdetail', '0', '0', '0', '', '', '', '1', '1496739472', null);
INSERT INTO `sys_module` VALUES ('498', '会员余额明细', 'admin', 'member', 'accountdetail', '145', '3', 'member/accountdetail', '0', '0', '0', '', '', '', '1', '1496744512', null);
INSERT INTO `sys_module` VALUES ('499', 'seo设置', 'admin', 'config', 'seoconfig', '528', '3', 'config/seoconfig', '0', '0', '2', 'seo设置', '', '', '1', '1496750885', '1496751054');
INSERT INTO `sys_module` VALUES ('501', '微信支付', 'admin', 'config', 'payconfig', '221', '3', 'config/payconfig', '1', '0', '1', '微信支付', '', '', '1', '1496821450', null);
INSERT INTO `sys_module` VALUES ('502', '支付宝支付', 'admin', 'config', 'payaliconfig', '221', '3', 'config/payaliconfig', '1', '0', '2', '支付宝支付', '', '', '1', '1496821780', null);
INSERT INTO `sys_module` VALUES ('503', '会员提现设置', 'admin', 'config', 'memberwithdrawsetting', '218', '2', 'config/memberwithdrawsetting', '1', '0', '45', '会员提现设置', '', '', '1', '1496821934', '1496822222');
INSERT INTO `sys_module` VALUES ('504', '会员提现', 'admin', 'member', 'usercommissionwithdrawlist', '137', '2', 'member/usercommissionwithdrawlist', '1', '0', '4', '会员提现', '', '', '1', '1496822171', '1496822242');
INSERT INTO `sys_module` VALUES ('506', '模板管理', 'admin', 'config', 'notifytemplate', '439', '3', 'config/notifytemplate', '0', '0', '0', '', '', '', '1', '1496886539', '1496974268');
INSERT INTO `sys_module` VALUES ('507', '积分设置', 'admin', 'promotion', 'integral', '446', '3', 'promotion/integral', '1', '0', '0', '积分奖励', '', '', '1', '1496896166', null);
INSERT INTO `sys_module` VALUES ('508', '积分奖励', 'admin', 'promotion', 'integral', '446', '3', 'promotion/integral', '1', '0', '0', '积分奖励', '', '', '1', '1496896201', null);
INSERT INTO `sys_module` VALUES ('509', '积分管理', 'admin', 'member', 'pointlist', '137', '2', 'member/pointlist', '1', '0', '5', '', '', '', '1', '1496906007', '1496906222');
INSERT INTO `sys_module` VALUES ('510', '余额管理', 'admin', 'member', 'accountlist', '137', '2', 'member/accountlist', '1', '0', '6', '', '', '', '1', '1496906142', '1496906242');
INSERT INTO `sys_module` VALUES ('512', '微信登录', 'admin', 'config', 'loginconfig', '456', '3', 'config/loginconfig', '1', '0', '2', '微信登录', '', '', '1', '1496907149', '1496907569');
INSERT INTO `sys_module` VALUES ('513', 'qq登录', 'admin', 'config', 'loginconfig', '456', '3', 'config/loginconfig', '1', '0', '1', 'qq登录', '', '', '1', '1496907238', '1496907552');
INSERT INTO `sys_module` VALUES ('517', '商品回收站', 'admin', 'goods', 'recycle', '149', '2', 'goods/recyclelist', '1', '0', '11', '', '', '', '1', '1497445996', '1497445996');
INSERT INTO `sys_module` VALUES ('518', '回收站列表', 'admin', 'goods', 'recyclelist', '517', '3', 'goods/recyclelist', '0', '0', '0', '', '', '', '1', '1497445996', '1497445996');
INSERT INTO `sys_module` VALUES ('519', '货到付款地区管理', 'admin', 'config', 'distributionareamanagement', '529', '3', 'config/distributionareamanagement', '0', '0', '24', '', '', '', '1', '1497706614', '1497706614');
INSERT INTO `sys_module` VALUES ('520', '自提点管理', 'admin', 'shop', 'pickuppointlist', '529', '3', 'shop/pickuppointlist', '0', '0', '80', '', '', '', '1', '1498135759', '1498135759');
INSERT INTO `sys_module` VALUES ('521', '添加自提点', 'admin', 'shop', 'addpickuppoint', '529', '3', 'shop/addpickuppoint', '0', '0', '0', '', '', '', '1', '1498135759', '1498135759');
INSERT INTO `sys_module` VALUES ('522', '修改自提点', 'admin', 'shop', 'updatepickuppoint', '529', '3', 'shop/updatepickuppoint', '0', '0', '0', '', '', '', '1', '1498135759', '1498135759');
INSERT INTO `sys_module` VALUES ('523', '物流跟踪设置', 'admin', 'config', 'expressmessage', '528', '3', 'config/expressmessage', '0', '0', '47', '', '', '', '1', '1498198990', '1498198990');
INSERT INTO `sys_module` VALUES ('524', '在线更新', 'admin', 'upgrade', 'onlineupdate', '10000', '2', 'upgrade/onlineupdate', '1', '0', '30', '', '', '', '1', '1498733102', '1498733102');
INSERT INTO `sys_module` VALUES ('525', '运费模板列表', 'admin', 'express', 'freighttemplatelist', '529', '3', 'express/freighttemplatelist', '0', '0', '0', '', '', '', '1', '1498733102', '1498733102');
INSERT INTO `sys_module` VALUES ('526', '编辑运费模板', 'admin', 'express', 'freighttemplateedit', '529', '3', 'express/freighttemplateedit', '0', '0', '2', '', '', '', '1', '1498733102', '1498733102');
INSERT INTO `sys_module` VALUES ('527', '注册与访问', 'admin', 'config', 'registerAndVisit', '218', '2', 'config/registerandvisit', '1', '0', '10', '', '', '', '1', '1498874511', '1498874511');
INSERT INTO `sys_module` VALUES ('528', '基础设置', 'admin', 'config', 'webconfig', '218', '2', 'config/webconfig', '1', '0', '0', '', '', '', '1', '1499343015', '1499343015');
INSERT INTO `sys_module` VALUES ('529', '物流配送', 'admin', 'express', 'expresscompany', '218', '2', 'express/expresscompany', '1', '0', '60', '', '', '', '1', '1499343015', '1499343015');
INSERT INTO `sys_module` VALUES ('530', '站点帮助', 'admin', 'config', 'helpclass', '477', '2', 'config/helpdocument', '1', '0', '17', '', '', '', '1', '1499343015', '1499343015');
INSERT INTO `sys_module` VALUES ('10000', 'X360云', 'admin', 'upgrade', 'onlineupdate', '0', '1', 'upgrade/onlineupdate', '0', '0', '100', '', '', '', '1', '1499343016', '1548323200');
INSERT INTO `sys_module` VALUES ('10001', '供货商', 'admin', 'member', 'supplierlist', '149', '2', 'member/supplierlist', '1', '0', '7', '', '', '', '1', '1499853120', '1499853120');
INSERT INTO `sys_module` VALUES ('10002', '添加供货商', 'admin', 'member', 'addsupplier', '10001', '3', 'member/addsupplier', '1', '0', '0', '', '', '', '1', '1499853120', '1499853120');
INSERT INTO `sys_module` VALUES ('10003', '修改供货商', 'admin', 'member', 'updatesupplier', '10001', '3', 'member/updatesupplier', '1', '0', '1', '', '', '', '1', '1499853120', '1499853120');
INSERT INTO `sys_module` VALUES ('10004', '电脑端', 'admin', 'config', 'shopnavigationlist', '477', '2', 'config/shopnavigationlist', '1', '0', '0', '', '', '', '1', '1500608761', '1500608761');
INSERT INTO `sys_module` VALUES ('10005', '手机端', 'admin', 'config', 'fixedtemplate', '477', '2', 'config/fixedtemplate', '1', '0', '1', '', '', '', '1', '1500608765', '1500608765');
INSERT INTO `sys_module` VALUES ('10006', '促销版块', 'admin', 'system', 'goodsrecommendclassmobile', '10005', '3', 'system/goodsrecommendclassmobile', '0', '0', '20', '', '', '', '1', '1500608766', '1500608766');
INSERT INTO `sys_module` VALUES ('10007', '授权信息', 'admin', 'upgrade', 'devolutioninfo', '10000', '2', 'upgrade/devolutioninfo', '1', '0', '40', '', '', '', '1', '1500608776', '1500608776');
INSERT INTO `sys_module` VALUES ('10008', '扩展', 'admin', 'extend', 'addonslist', '0', '1', 'extend/addonslist', '1', '0', '50', null, '', '', '1', '1500632812', '1500632818');
INSERT INTO `sys_module` VALUES ('10009', '插件管理', 'admin', 'extend', 'addonslist', '10008', '2', 'extend/addonslist', '1', '0', '0', '', '', '', '1', '1500633040', null);
INSERT INTO `sys_module` VALUES ('10010', '钩子管理', 'admin', 'extend', 'hookslist', '10008', '2', 'extend/hookslist', '1', '0', '1', '', '', '', '1', '1500633096', null);
INSERT INTO `sys_module` VALUES ('10011', '插件列表', 'admin', 'extend', 'pluginlist', '10008', '2', 'extend/pluginlist', '0', '0', '3', '', '', '', '1', '1500633141', null);
INSERT INTO `sys_module` VALUES ('10012', '添加钩子', 'admin', 'extend', 'addhooks', '10010', '3', 'extend/addhooks', '1', '0', '0', '', '', '', '1', '1500633268', null);
INSERT INTO `sys_module` VALUES ('10013', '修改钩子', 'admin', 'extend', 'updatehooks', '10010', '3', 'extend/updatehooks', '1', '0', '0', '', '', '', '1', '1500633326', null);
INSERT INTO `sys_module` VALUES ('10014', '插件配置', 'admin', 'extend', 'pluginconfig', '10008', '2', 'extend/pluginconfig', '0', '0', '4', '', '', '', '1', '1500633368', null);
INSERT INTO `sys_module` VALUES ('10015', '插件配置', 'admin', 'extend', 'addonsconfig', '10008', '2', 'extend/addonsconfig', '0', '0', '5', '', '', '', '1', '1500633398', null);
INSERT INTO `sys_module` VALUES ('10016', '自提点运费', 'admin', 'shop', 'pickuppointfreight', '529', '3', 'shop/pickuppointfreight', '1', '0', '4', '', '', '', '1', '1501809931', '1501809931');
INSERT INTO `sys_module` VALUES ('10017', '版权设置', 'admin', 'config', 'copyrightinfo', '528', '3', 'config/copyrightinfo', '0', '0', '8', '', '', '', '1', '1501810329', '1501810329');
INSERT INTO `sys_module` VALUES ('10018', '手机模板', 'admin', 'config', 'waptemplate', '10005', '3', 'config/waptemplate', '0', '0', '3', '', '', '', '1', '1501923272', '1501923272');
INSERT INTO `sys_module` VALUES ('10019', '客服设置', 'admin', 'config', 'customservice', '218', '2', 'config/customservice', '1', '0', '70', '', '', '', '1', '1502539867', '1502539867');
INSERT INTO `sys_module` VALUES ('10021', '固定模板', 'admin', 'config', 'fixedtemplate', '10005', '3', 'config/fixedtemplate', '1', '0', '1', '', '', '', '1', '1502539867', '1502539867');
INSERT INTO `sys_module` VALUES ('10022', '附件上传', 'admin', 'config', 'uploadtype', '218', '2', 'config/uploadtype', '1', '0', '10', null, '', '', '1', '0', '0');
INSERT INTO `sys_module` VALUES ('10023', '商品楼层', 'admin', 'system', 'goodscategoryblock', '477', '2', 'system/goodscategoryblock', '1', '0', '10', null, '', '', '1', '0', '0');
INSERT INTO `sys_module` VALUES ('10024', '模板', 'admin', 'config', 'pctemplate', '10004', '3', 'config/pctemplate', '1', '0', '1', '', '', '', '1', '1504697788', '1504697788');
INSERT INTO `sys_module` VALUES ('10075', '商家通知', 'admin', 'config', 'businessnotifytemplate', '439', '3', 'config/businessnotifytemplate', '0', '0', '0', '', '', '', '1', '1505870490', '0');
INSERT INTO `sys_module` VALUES ('10076', '原路退款配置', 'admin', 'config', 'originalroadrefundsetting', '218', '2', 'config/originalroadrefundsetting', '1', '0', '41', '', '', '', '1', '1507881605', '0');
INSERT INTO `sys_module` VALUES ('10077', '数据库管理', 'admin', 'dbdatabase', 'databaselist', '218', '2', 'dbdatabase/databaselist', '1', '0', '0', '', '', '', '1', '1506132536', '0');
INSERT INTO `sys_module` VALUES ('10078', '数据库恢复', 'admin', 'dbdatabase', 'importdatalist', '10077', '3', 'dbdatabase/importdatalist', '0', '0', '0', '', '', '', '1', '1506132758', '0');
INSERT INTO `sys_module` VALUES ('10079', 'SQL执行与导入', 'admin', 'dbdatabase', 'sqlfilequery', '10077', '3', 'dbdatabase/sqlfilequery', '0', '0', '0', '', '', '', '1', '1506132811', '0');
INSERT INTO `sys_module` VALUES ('10080', '添加首页公告', 'admin', 'config', 'addhomenotice', '10004', '3', 'config/addhomenotice', '0', '0', '0', '', '', '', '1', '1508152805', '0');
INSERT INTO `sys_module` VALUES ('10081', '公告编辑', 'admin', 'config', 'updatehomenotice', '10004', '3', 'config/updatehomenotice', '0', '0', '0', '', '', '', '1', '1508208576', '0');
INSERT INTO `sys_module` VALUES ('10082', '图片设置', 'admin', 'config', 'pictureuploadsetting', '218', '2', 'config/pictureuploadsetting', '1', '0', '4', '', '', '', '1', '1508152805', '0');
INSERT INTO `sys_module` VALUES ('10083', '系统更新', 'admin', 'upgrade', 'upgradePatch', '524', '3', 'upgrade/upgradepatch', '0', '0', '0', '', '', '', '1', '1508572839', '0');
INSERT INTO `sys_module` VALUES ('10084', '校360设置', 'admin', 'config', 'x360Config', '528', '3', 'config/x360Config', '0', '0', '6', null, '', '', '1', '1492755047', '0');
INSERT INTO `sys_module` VALUES ('10085', '界面设置', 'admin', 'config', 'uiConfig', '528', '3', 'config/uiConfig', '0', '0', '6', null, '', '', '1', '1492755047', '0');
INSERT INTO `sys_module` VALUES ('10086', '模板消息设置', 'admin', 'wchat', 'addonmenu', '335', '2', 'wchat/menu_wchat?addons=wxtemplatemsg', '1', '0', '7', '模板消息插件菜单', '', '', '1', '1544154259', '0');
INSERT INTO `sys_module` VALUES ('10088', '财务质检', 'admin', 'account', 'checkorder', '409', '2', 'account/checkorder&status=1&check_pay_status=0', '1', '0', '10', '', '', '', '1', '1547106780', '1547107652');
INSERT INTO `sys_module` VALUES ('10089', '退款审查', 'admin', 'account', 'checkrefund', '409', '2', 'account/checkrefund&status=-1', '1', '0', '11', '', '', '', '1', '1547107096', '1547274537');
INSERT INTO `sys_module` VALUES ('10090', '库存', 'admin', 'purchases', 'goodslist', '0', '1', 'purchases/goodslist', '1', '0', '2', '', '', '', '1', '1547114172', '1548317094');
INSERT INTO `sys_module` VALUES ('10091', '退货申请', 'admin', 'stocks', 'refundapplys', '10090', '2', 'stocks/refundapplys&status=-1', '1', '0', '4', '', '', '', '1', '1547114216', '1547458047');
INSERT INTO `sys_module` VALUES ('10092', '库存报表', 'admin', 'stocks', 'instocklist', '10090', '2', 'stocks/instocklist', '1', '0', '5', '', '', '', '1', '1547114373', '1547629895');
INSERT INTO `sys_module` VALUES ('10093', '出入库管理', 'admin', 'stocks', 'goodslist', '10090', '2', 'stocks/goodslist', '1', '0', '2', '', '', '', '1', '1547114529', '1547455224');
INSERT INTO `sys_module` VALUES ('10097', '已完成', 'admin', 'account', 'checkorderfinish', '10088', '3', 'account/checkorderfinish&check_pay_status=1', '1', '0', '0', '', '', '', '1', '1547274819', '0');
INSERT INTO `sys_module` VALUES ('10098', '财务报表', 'admin', 'account', 'income', '409', '2', 'account/income', '1', '0', '12', '', '', '', '1', '1547276984', '0');
INSERT INTO `sys_module` VALUES ('10101', '待发货订单', 'admin', 'stocks', 'orderlist', '10090', '2', 'stocks/orderlist&status=1', '1', '0', '3', '', '', '', '1', '1547547654', '0');
INSERT INTO `sys_module` VALUES ('10102', '出库统计', 'admin', 'stocks', 'outstocklist', '10092', '3', 'stocks/outstocklist', '1', '0', '0', '', '', '', '1', '1547696243', '0');
INSERT INTO `sys_module` VALUES ('10103', '退货统计', 'admin', 'stocks', 'refundlist', '10092', '3', 'stocks/refundlist', '1', '0', '1', '', '', '', '1', '1547697929', '0');
INSERT INTO `sys_module` VALUES ('10104', '商品采购', 'admin', 'purchases', 'goodslist', '10090', '2', 'purchases/goodslist', '1', '0', '0', '', '', '', '1', '1548125667', '1548146735');
INSERT INTO `sys_module` VALUES ('10105', '采购列表', 'admin', 'purchases', 'purchaselist', '10090', '2', 'purchases/purchaselist', '1', '0', '1', '', '', '', '1', '1548127489', '1548146750');
INSERT INTO `sys_module` VALUES ('10107', '退款统计', 'admin', 'account', 'payout', '10098', '3', 'account/payout', '1', '0', '0', '', '', '', '1', '1548316974', '0');
INSERT INTO `sys_module` VALUES ('10108', '采购统计', 'admin', 'account', 'purchase', '10098', '3', 'account/purchase', '1', '0', '1', '', '', '', '1', '1548317018', '0');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shopid` int(11) NOT NULL COMMENT '店铺ID（单店版为0）',
  `notice_message` varchar(255) DEFAULT '' COMMENT '公告内容',
  `is_enable` tinyint(1) DEFAULT '0' COMMENT '是否启用（0：隐藏，1：显示）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='网站公告';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('7', '0', '今天大促销，所有商品半价', '0');

-- ----------------------------
-- Table structure for sys_notice_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_template`;
CREATE TABLE `sys_notice_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模板id',
  `template_type` varchar(50) NOT NULL DEFAULT '' COMMENT '模板类型',
  `instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `template_code` varchar(50) NOT NULL DEFAULT '' COMMENT '模板编号',
  `template_title` varchar(50) NOT NULL DEFAULT '' COMMENT '模板编号',
  `template_content` text NOT NULL COMMENT '模板名称',
  `sign_name` varchar(50) NOT NULL DEFAULT '' COMMENT '签名',
  `is_enable` int(11) NOT NULL DEFAULT '0' COMMENT '是否开启',
  `modify_time` int(11) DEFAULT '0' COMMENT '更新时间',
  `notify_type` varchar(255) NOT NULL DEFAULT '' COMMENT '通知人类型',
  `notification_mode` text NOT NULL COMMENT '通知方式',
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1170 COMMENT='通知模版设置';

-- ----------------------------
-- Records of sys_notice_template
-- ----------------------------
INSERT INTO `sys_notice_template` VALUES ('1', 'email', '0', 'after_register', '', '', '', '0', '1544239842', 'user', '');
INSERT INTO `sys_notice_template` VALUES ('2', 'email', '0', 'register_validate', '', '', '', '0', '1544239842', 'user', '');
INSERT INTO `sys_notice_template` VALUES ('3', 'email', '0', 'recharge_success', '', '', '', '0', '1544239842', 'user', '');
INSERT INTO `sys_notice_template` VALUES ('4', 'email', '0', 'confirm_order', '', '', '', '0', '1544239842', 'user', '');
INSERT INTO `sys_notice_template` VALUES ('5', 'email', '0', 'pay_success', '', '', '', '0', '1544239842', 'user', '');
INSERT INTO `sys_notice_template` VALUES ('6', 'email', '0', 'create_order', '下单成功', '<p>{商场名称}</p><p>{用户名称}</p><p>{主订单号}</p><p>{订单金额}</p><p>{商品金额}</p>', '', '1', '1544239842', 'user', '');
INSERT INTO `sys_notice_template` VALUES ('7', 'email', '0', 'order_deliver', '', '', '', '0', '1544239842', 'user', '');
INSERT INTO `sys_notice_template` VALUES ('8', 'email', '0', 'forgot_password', '', '', '', '0', '1544239842', 'user', '');
INSERT INTO `sys_notice_template` VALUES ('9', 'email', '0', 'bind_email', '', '', '', '0', '1544239842', 'user', '');

-- ----------------------------
-- Table structure for sys_notice_template_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_template_item`;
CREATE TABLE `sys_notice_template_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(50) NOT NULL DEFAULT '' COMMENT '项名称',
  `show_name` varchar(50) NOT NULL DEFAULT '' COMMENT '显示名称',
  `replace_name` varchar(50) NOT NULL DEFAULT '' COMMENT '替换字段名字',
  `type_ids` varchar(255) NOT NULL COMMENT '关联type类型',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1820 COMMENT='通知模板项';

-- ----------------------------
-- Records of sys_notice_template_item
-- ----------------------------
INSERT INTO `sys_notice_template_item` VALUES ('1', '商场名称', '{商场名称}', 'shopname', 'after_register,recharge_success,create_order,pay_success,confirm_order,order_deliver,order_remind,refund_order', '0');
INSERT INTO `sys_notice_template_item` VALUES ('2', '用户名称', '{用户名称}', 'username', 'after_register,recharge_success,create_order,pay_success,confirm_order,order_deliver,bind_mobile,bind_email,order_remind,refund_order', '1');
INSERT INTO `sys_notice_template_item` VALUES ('5', '商品名称', '{商品名称}', 'goodsname', 'order_deliver', '4');
INSERT INTO `sys_notice_template_item` VALUES ('6', '商品规格', '{商品规格}', 'goodssku', 'order_deliver', '5');
INSERT INTO `sys_notice_template_item` VALUES ('7', '主订单号', '{主订单号}', 'orderno', 'create_order,pay_success,confirm_order,order_deliver,order_remind,refund_order', '6');
INSERT INTO `sys_notice_template_item` VALUES ('8', '订单金额', '{订单金额}', 'ordermoney', 'create_order,pay_success,confirm_order,order_deliver,order_remind,refund_order', '7');
INSERT INTO `sys_notice_template_item` VALUES ('9', '商品金额', '{商品金额}', 'goodsmoney', 'create_order,pay_success,order_deliver', '8');
INSERT INTO `sys_notice_template_item` VALUES ('10', '验证码', '{验证码}', 'number', 'register_validate,forgot_password,bind_mobile,bind_email', '9');
INSERT INTO `sys_notice_template_item` VALUES ('11', '充值金额', '{充值金额}', 'rechargemoney', 'recharge_success', '0');
INSERT INTO `sys_notice_template_item` VALUES ('12', '物流公司', '{物流公司}', 'expresscompany', 'order_deliver', '0');
INSERT INTO `sys_notice_template_item` VALUES ('13', '快递编号', '{快递编号}', 'expressno', 'order_deliver', '0');

-- ----------------------------
-- Table structure for sys_notice_template_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_template_type`;
CREATE TABLE `sys_notice_template_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(50) NOT NULL DEFAULT '' COMMENT '模板名称',
  `template_code` varchar(50) NOT NULL DEFAULT '' COMMENT '模板编号',
  `template_type` varchar(50) NOT NULL DEFAULT '' COMMENT '模板类型',
  `notify_type` varchar(255) NOT NULL DEFAULT '' COMMENT '通知人类型',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2340 COMMENT='通知模板类型';

-- ----------------------------
-- Records of sys_notice_template_type
-- ----------------------------
INSERT INTO `sys_notice_template_type` VALUES ('1', '注册成功', 'after_register', 'all', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('2', '注册验证', 'register_validate', 'all', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('3', '充值成功', 'recharge_success', 'all', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('4', '确认订单', 'confirm_order', 'all', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('5', '付款成功', 'pay_success', 'all', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('6', '下单成功', 'create_order', 'all', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('7', '订单发货', 'order_deliver', 'all', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('8', '找回密码', 'forgot_password', 'all', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('9', '手机绑定', 'bind_mobile', 'sms', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('10', '邮箱绑定', 'bind_email', 'email', 'user');
INSERT INTO `sys_notice_template_type` VALUES ('11', '退款订单', 'refund_order', 'all', 'business');
INSERT INTO `sys_notice_template_type` VALUES ('12', '订单提醒', 'order_remind', 'all', 'business');
INSERT INTO `sys_notice_template_type` VALUES ('13', '充值成功', 'recharge_success', 'all', 'business');

-- ----------------------------
-- Table structure for sys_province
-- ----------------------------
DROP TABLE IF EXISTS `sys_province`;
CREATE TABLE `sys_province` (
  `province_id` int(11) NOT NULL AUTO_INCREMENT,
  `area_id` tinyint(4) NOT NULL DEFAULT '0',
  `province_name` varchar(255) NOT NULL DEFAULT '',
  `sort` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`province_id`),
  KEY `IDX_g_province_ProvinceName` (`province_name`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=481;

-- ----------------------------
-- Records of sys_province
-- ----------------------------
INSERT INTO `sys_province` VALUES ('1', '2', '北京市', '1');
INSERT INTO `sys_province` VALUES ('2', '2', '天津市', '0');
INSERT INTO `sys_province` VALUES ('3', '2', '河北省', '0');
INSERT INTO `sys_province` VALUES ('4', '2', '山西省', '0');
INSERT INTO `sys_province` VALUES ('5', '2', '内蒙古自治区', '0');
INSERT INTO `sys_province` VALUES ('6', '5', '辽宁省', '0');
INSERT INTO `sys_province` VALUES ('7', '5', '吉林省', '0');
INSERT INTO `sys_province` VALUES ('8', '5', '黑龙江省', '0');
INSERT INTO `sys_province` VALUES ('9', '1', '上海市', '0');
INSERT INTO `sys_province` VALUES ('10', '1', '江苏省', '0');
INSERT INTO `sys_province` VALUES ('11', '1', '浙江省', '0');
INSERT INTO `sys_province` VALUES ('12', '1', '安徽省', '0');
INSERT INTO `sys_province` VALUES ('13', '3', '福建省', '0');
INSERT INTO `sys_province` VALUES ('14', '1', '江西省', '0');
INSERT INTO `sys_province` VALUES ('15', '2', '山东省', '0');
INSERT INTO `sys_province` VALUES ('16', '4', '河南省', '0');
INSERT INTO `sys_province` VALUES ('17', '4', '湖北省', '0');
INSERT INTO `sys_province` VALUES ('18', '4', '湖南省', '0');
INSERT INTO `sys_province` VALUES ('19', '3', '广东省', '0');
INSERT INTO `sys_province` VALUES ('20', '3', '广西壮族自治区', '0');
INSERT INTO `sys_province` VALUES ('21', '3', '海南省', '0');
INSERT INTO `sys_province` VALUES ('22', '7', '重庆市', '0');
INSERT INTO `sys_province` VALUES ('23', '7', '四川省', '0');
INSERT INTO `sys_province` VALUES ('24', '7', '贵州省', '0');
INSERT INTO `sys_province` VALUES ('25', '7', '云南省', '0');
INSERT INTO `sys_province` VALUES ('26', '7', '西藏自治区', '0');
INSERT INTO `sys_province` VALUES ('27', '6', '陕西省', '0');
INSERT INTO `sys_province` VALUES ('28', '6', '甘肃省', '0');
INSERT INTO `sys_province` VALUES ('29', '6', '青海省', '0');
INSERT INTO `sys_province` VALUES ('30', '6', '宁夏回族自治区', '0');
INSERT INTO `sys_province` VALUES ('31', '6', '新疆维吾尔自治区', '0');
INSERT INTO `sys_province` VALUES ('32', '8', '香港特别行政区', '0');
INSERT INTO `sys_province` VALUES ('33', '8', '澳门特别行政区', '0');
INSERT INTO `sys_province` VALUES ('34', '8', '台湾省', '0');

-- ----------------------------
-- Table structure for sys_url_route
-- ----------------------------
DROP TABLE IF EXISTS `sys_url_route`;
CREATE TABLE `sys_url_route` (
  `routeid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rule` varchar(255) NOT NULL DEFAULT '' COMMENT '伪静态路由规则',
  `route` varchar(255) NOT NULL DEFAULT '' COMMENT '路由地址',
  `is_open` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `is_system` int(1) NOT NULL DEFAULT '0' COMMENT '是否是系统默认',
  `route_model` tinyint(4) NOT NULL DEFAULT '1' COMMENT '配置伪静态使用的模块1.shop2.wap3.admin',
  `remark` text NOT NULL COMMENT '简介',
  PRIMARY KEY (`routeid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2340 COMMENT='系统伪静态路由';

-- ----------------------------
-- Records of sys_url_route
-- ----------------------------
INSERT INTO `sys_url_route` VALUES ('1', 'goods', 'shop/goods/goodsinfo', '1', '1', '1', '');
INSERT INTO `sys_url_route` VALUES ('2', 'list', 'shop/goods/goodslist', '1', '1', '1', '');
INSERT INTO `sys_url_route` VALUES ('3', 'brands', 'shop/goods/brandlist', '1', '1', '1', '');
INSERT INTO `sys_url_route` VALUES ('4', 'integralcenter', 'shop/goods/integralcenter', '1', '1', '1', '');
INSERT INTO `sys_url_route` VALUES ('5', 'discount', 'shop/index/discount', '1', '1', '1', '');
INSERT INTO `sys_url_route` VALUES ('7', 'membercenter', 'shop/member/index', '1', '0', '1', '');
INSERT INTO `sys_url_route` VALUES ('8', 'article', 'shop/cms/articleclassinfo', '1', '1', '1', '文章详情');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '实例信息',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限组id',
  `user_password` varchar(255) NOT NULL DEFAULT '' COMMENT '用户密码（MD5）',
  `user_status` int(11) NOT NULL DEFAULT '1' COMMENT '用户状态  用户状态默认为1',
  `user_headimg` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `is_system` int(1) NOT NULL DEFAULT '0' COMMENT '是否是系统后台用户 0 不是 1 是',
  `is_member` int(11) NOT NULL DEFAULT '0' COMMENT '是否是前台会员',
  `salt` varchar(16) NOT NULL,
  `user_tel` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `user_tel_bind` int(1) NOT NULL DEFAULT '0' COMMENT '手机号是否绑定 0 未绑定 1 绑定 ',
  `user_qq` varchar(255) DEFAULT '' COMMENT 'qq号',
  `qq_openid` varchar(255) NOT NULL DEFAULT '' COMMENT 'qq互联id',
  `qq_info` varchar(2000) NOT NULL DEFAULT '' COMMENT 'qq账号相关信息',
  `user_email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `user_email_bind` int(1) NOT NULL DEFAULT '0' COMMENT '是否邮箱绑定',
  `wx_openid` varchar(255) DEFAULT NULL COMMENT '微信用户openid',
  `wx_is_sub` int(1) NOT NULL DEFAULT '0' COMMENT '微信用户是否关注',
  `wx_info` varchar(2000) DEFAULT NULL COMMENT '微信用户信息',
  `other_info` varchar(255) DEFAULT NULL COMMENT '附加信息',
  `current_login_ip` varchar(255) DEFAULT NULL COMMENT '当前登录ip',
  `current_login_type` int(11) DEFAULT NULL COMMENT '当前登录的操作终端类型',
  `last_login_ip` varchar(255) DEFAULT NULL COMMENT '上次登录ip',
  `last_login_type` int(11) DEFAULT NULL COMMENT '上次登录的操作终端类型',
  `login_num` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `real_name` varchar(50) DEFAULT '' COMMENT '真实姓名',
  `sex` smallint(6) DEFAULT '0' COMMENT '性别 0保密 1男 2女',
  `location` varchar(255) DEFAULT '' COMMENT '所在地',
  `nick_name` varchar(50) DEFAULT '斯玛特加盟商' COMMENT '用户昵称',
  `wx_unionid` varchar(255) NOT NULL DEFAULT '' COMMENT '微信unionid',
  `qrcode_template_id` int(11) NOT NULL DEFAULT '0' COMMENT '模板id',
  `wx_sub_time` int(11) DEFAULT '0' COMMENT '微信用户关注时间',
  `wx_notsub_time` int(11) DEFAULT '0' COMMENT '微信用户取消关注时间',
  `reg_time` int(11) DEFAULT '0' COMMENT '注册时间',
  `current_login_time` int(11) DEFAULT '0' COMMENT '当前登录时间',
  `last_login_time` int(11) DEFAULT '0' COMMENT '上次登录时间',
  `birthday` int(11) DEFAULT '0',
  PRIMARY KEY (`uid`),
  KEY `IDX_sys_user_user_email` (`user_email`),
  KEY `IDX_sys_user_user_name` (`user_name`),
  KEY `IDX_sys_user_user_password` (`user_password`),
  KEY `IDX_sys_user_user_tel` (`user_tel`),
  KEY `IDX_sys_user_wx_openid` (`wx_openid`),
  KEY `IDX_sys_user_wx_unionid` (`wx_unionid`)
) ENGINE=InnoDB AUTO_INCREMENT=3492 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=372 COMMENT='系统用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '0', 'admin', '0', '06da0a7569ddc5f1eee248517620d2e0', '1', 'upload/avator/1546594855.jpg', '1', '1', 'gZtlb5', '17727750995', '0', '1014256196', '', '', '1014256196@qq.com', '0', null, '0', null, null, '113.102.167.243', '1', '113.102.167.243', '1', '195', '', '0', '', '360用户', '', '0', '0', '0', '0', '1550040636', '1550025582', '0');
INSERT INTO `sys_user` VALUES ('3073', '0', 'xushuqing', '0', '06da0a7569ddc5f1eee248517620d2e0', '1', 'upload/avator/1544079779.jpg', '0', '1', 'gZtlb5', '17727750995', '0', '1014256196', '', '', '1014256196@qq.com', '0', '', '0', '', '', '113.102.167.243', '1', '113.96.219.247', '1', '90', '徐舒青', '1', '广东深圳', '徐舒青', '', '1', '0', '0', '1544000816', '1550040827', '1550025137', '719337600');
INSERT INTO `sys_user` VALUES ('3215', '0', 'shizhi', '0', '06da0a7569ddc5f1eee248517620d2e0', '1', '', '1', '1', 'gZtlb5', '13911874167', '1', '', '', '', '', '0', null, '0', null, null, '183.11.39.165', '1', '183.11.39.165', '1', '38', '', '0', '', '斯玛特加盟商', '', '0', '0', '0', '0', '1546590349', '1546583526', '0');
INSERT INTO `sys_user` VALUES ('3348', '0', '15961616718', '0', '7352be552ef701b9c7c61df18d9b727f', '1', '', '0', '1', 'xtpaUq', '15961616718', '1', '', '', '', '', '0', null, '0', null, null, '122.70.179.90', '1', '122.70.179.90', '1', '33', '', '0', '', '任卉洁', '', '0', '0', '0', '0', '1548921002', '1548921001', '0');
INSERT INTO `sys_user` VALUES ('3349', '0', '14752701578', '0', '6ef522a5f941ec21c7bd0394c7113a4c', '1', '', '0', '1', 'z2YIWQ', '14752701578', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '斯玛特扬州广陵区中集文昌中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3350', '0', '15105179669', '0', '8ebc269f95c2157995bdf1ae1ddd9a2a', '1', '', '0', '1', '78Q68y', '15105179669', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '江苏南京建邺奥体中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3351', '0', '13502290169', '0', '1e3c089763976770c22a83319b9e1df9', '1', '', '0', '1', 'bPHiCM', '13502290169', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '广东惠州四季商业中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3352', '0', '13830488185', '0', '7742b6bdf32f3b2ddab7865263d5f255', '1', '', '0', '1', 'GROtLg', '13830488185', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '甘肃庆阳西峰中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3353', '0', '15770029666', '0', '0ab683a03b537c300860f5860aceae67', '1', '', '0', '1', 'hsI7J5', '15770029666', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '阿拉尔管理员', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3354', '0', '19955909979', '0', '0054b75ae3bf6d2748d0036e4c195ef0', '1', '', '0', '1', 'WBIuTe', '19955909979', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '吴文勤', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3355', '0', '18204101555', '0', '68d7611087bac4bfa78139f1691c093e', '1', '', '0', '1', 'XtuW1y', '18204101555', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '辽宁铁岭银州中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3356', '0', '18684225137', '0', 'cd5a21c31f3ccb046e78019383254a1b', '1', '', '0', '1', '9Hyvhm', '18684225137', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '吉林四平公主岭岭西紫金星城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3357', '0', '18766888388', '0', 'ae7093f9af5b9f6891c027ff03faa058', '1', '', '0', '1', 'pg8k8Z', '18766888388', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东曲阜星光天地中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3358', '0', '18553438619', '0', '6e67fee909aeb26c9ced438bec5f622b', '1', '', '0', '1', 'Mly0iq', '18553438619', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东菏泽曹县中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3359', '0', '18300571199', '0', '92c0d526571cc4106f74d302947d10f0', '1', '', '0', '1', 'gGj2XQ', '18300571199', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东菏泽定陶中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3360', '0', '15185170025', '0', 'beb515b04d631081ee30b61afd726645', '1', '', '0', '1', '9veKq6', '15185170025', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '贵州贵阳小河缤纷中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3361', '0', '13885196699', '0', '51fd8631dccab542816f17dfbe2250db', '1', '', '0', '1', 'TNKQkG', '13885196699', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '贵州贵阳云岩586中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3362', '0', '18198516557', '0', '191a5dcd7db4c0f83e2dd0c1a032ca4e', '1', '', '0', '1', 'YE651c', '18198516557', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '贵阳金融城恒大中央公园中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3363', '0', '13502179678', '0', 'c5564f0dafefc3bca638bef8805d8253', '1', '', '0', '1', 'Jsand0', '13502179678', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '天津南开天拖美坪园中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3364', '0', '13419575866', '0', '94f6da738735a904a7ad4582fde0be4f', '1', '', '0', '1', 'wiVTLS', '13419575866', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '张菁', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3365', '0', '18971637736', '0', 'a42721c421f5a899cc74eff1251927a0', '1', '', '0', '1', 'tPkUHO', '18971637736', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '湖北武汉洪山泛悦坊都会中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3366', '0', '13709719041', '0', '10c399e9b917b7f1f1fcbde183a2d08d', '1', '', '0', '1', 'SQ0wAy', '13709719041', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '青海西宁城西万达中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3367', '0', '15829349211', '0', '8084cb59e8175e54155dd18549a7c7ed', '1', '', '0', '1', 's0QDcX', '15829349211', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', 'Kitty', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3368', '0', '18603196858', '0', 'ba73dbed01f57dad9ea1d6c8f8722120', '1', '', '0', '1', 'THa4jR', '18603196858', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北邢台隆尧中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3369', '0', '18600404406', '0', 'ce54705272c2ac9cbd786fc3a8dd7913', '1', '', '0', '1', 'mN65vs', '18600404406', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北保定满城惠友中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3370', '0', '18975068908', '0', '36f55c433c2d5dc1c17327414d51767d', '1', '', '0', '1', '2SH5VV', '18975068908', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '湖南长沙雨花丰升德润中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3371', '0', '13666770333', '0', 'd336fb2cc6d9bc38bb97cf7b320ec37e', '1', '', '0', '1', 'xlNkL6', '13666770333', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '浙江嘉兴桐乡吾悦广场中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3372', '0', '18268485166', '0', '265319d0bd2ac813c2da99ed104bfb58', '1', '', '0', '1', 'jkUdwe', '18268485166', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '浙江嘉兴嘉善中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3373', '0', '13858998321', '0', '6dbc6025b68bc1cce854abd5618ad182', '1', '', '0', '1', 'HdCDAU', '13858998321', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '浙江金华兰溪溪西', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3374', '0', '13566616199', '0', 'af47b4600aeb45ae623ab6db0fb88277', '1', '', '0', '1', 'qcIMpk', '13566616199', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '浙江宁波慈溪中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3375', '0', '13567206171', '0', 'e6b78c0004f202e95b1285fafea68c59', '1', '', '0', '1', '6L3c3z', '13567206171', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '浙江绍兴柯桥中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3376', '0', '18782311777', '0', 'ceaafc11586efce0b218a514e3599b21', '1', '', '0', '1', '2ZRKAa', '18782311777', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '四川成都简阳万安山峰中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3377', '0', '13733811157', '0', '48cd9a8a32031b407f34e7ef496f01b3', '1', '', '0', '1', '24gfoI', '13733811157', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南郑州郑东新区中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3378', '0', '15160031121', '0', '73bcd3b95753987b7f6c24e3a10b5281', '1', '', '0', '1', 'WuwmtC', '15160031121', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南安阳景诗雅苑中心 ', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3379', '0', '13703746655', '0', 'c26c8181f0e2b99545ab35221c2fe5b7', '1', '', '0', '1', 'kPpbVN', '13703746655', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '马培军', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3380', '0', '15577717711', '0', '6420032563985dd46b4241300cfe2e58', '1', '', '0', '1', 'ydaU0w', '15577717711', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '韩老师', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3381', '0', '18679999299', '0', '6bea311c127adda14c599209d9ab2775', '1', '', '0', '1', 'VQ7H00', '18679999299', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '江西萍乡莲花富丽花苑中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3382', '0', '18645810908', '0', 'f1075684688682fdddbe14a6c5550ff5', '1', '', '0', '1', 'aMjnoD', '18645810908', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '重庆渝中中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3383', '0', '15778129400', '0', '2452f13c7f700672eff7403f7eb3ae30', '1', '', '0', '1', 'LEWcCG', '15778129400', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '广西南宁江南中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3384', '0', '13569451007', '0', '90f84db2539a4017886d960657e5dbf7', '1', '', '0', '1', 'KaUrrA', '13569451007', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南长葛中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3385', '0', '17307926666', '0', '4a304edd09918707478fde458a2c08f6', '1', '', '0', '1', 'aju7lG', '17307926666', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '桂仪锋', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3386', '0', '13776877666', '0', 'b8cff0d01a579a94624f02c650ec450a', '1', '', '0', '1', 'jF4UIs', '13776877666', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '江苏常州武进御城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3387', '0', '18643506776', '0', 'cf0dd12de8c35b83e8e8b8447abf8841', '1', '', '0', '1', 'kxL76K', '18643506776', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '冯丹丹', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3388', '0', '13762939727', '0', 'd7e4e75477a70f8ceb659b5d001d5313', '1', '', '0', '1', 'PQaMoA', '13762939727', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '湖南怀化鹤城锦绣五溪广场中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3389', '0', '13633148683', '0', '2bc72fc17acb910bd9a683b984ff3bea', '1', '', '0', '1', 'tVO9qf', '13633148683', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '郭新民', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3390', '0', '15132099828', '0', 'd8aefa0ed2a23b79cacca19ec1ff8d29', '1', '', '0', '1', 'MEyKD5', '15132099828', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北邯郸永年时代广场中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3391', '0', '13103143099', '0', 'b654eaffdf184d0b1d0da81b0d6db5a9', '1', '', '0', '1', 'N0BmY2', '13103143099', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北承德平泉中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3392', '0', '13131276200', '0', '5bfff22f99031b56ff0f701e764ddc58', '1', '', '0', '1', 'zUbSV2', '13131276200', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北保定定州实验高中中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3393', '0', '18857799662', '0', '2c8bc7bc1438a2253e62be03105a9025', '1', '', '0', '1', 'EldBly', '18857799662', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '浙江温州龙湾中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3394', '0', '18888782640', '0', '28fbf70fe98b8a91260ebd98b63fa6a8', '1', '', '0', '1', 'Qvil5T', '18888782640', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '浙江绍兴上虞大通购物广场', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3395', '0', '15957948782', '0', 'e95cca9e7898ad90bea4e89c1369c9f2', '1', '', '0', '1', 'zmMp9v', '15957948782', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '浙江金华东阳银泰城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3396', '0', '13587622991', '0', '5b7110499925400492cd0e772b601761', '1', '', '0', '1', 'uPFalY', '13587622991', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '浙江温州鹿城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3397', '0', '18531516776', '0', '386eacb4385533d8d3ed1e69acc00afc', '1', '', '0', '1', '5NHBnP', '18531516776', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北唐山曹妃甸中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3398', '0', '13701155732', '0', '50675d02a497568c56527087e3fe0772', '1', '', '0', '1', 'rmUah0', '13701155732', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '北京良乡北潞园中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3399', '0', '18942231062', '0', 'aa0d78aeaf9fb69a330a2338bc077a4f', '1', '', '0', '1', '63KA55', '18942231062', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '江西南昌象湖新城中心 ', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3400', '0', '15039685123', '0', '49a668240eaf85046e7b10571e1b853f', '1', '', '0', '1', 'vGSiZr', '15039685123', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南驻马店驿城CBD中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3401', '0', '15133000625', '0', 'f99d99c55f8a516816b990b06a927a3a', '1', '', '0', '1', '4Q8qb8', '15133000625', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '耿康', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3402', '0', '15995058558', '0', 'f0d4329f7beab22988755f88dfd7481a', '1', '', '0', '1', 'Jmj7rL', '15995058558', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '江苏常州溧阳万达广场中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3403', '0', '13795079099', '0', 'ad93c046c7c8a2c8c339d7dab7c66db6', '1', '', '0', '1', '9eKQww', '13795079099', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '辽宁阜新海州和平路中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3404', '0', '15326864444', '0', '2a1a574d1fa0427de8823fa138ef85b5', '1', '', '0', '1', '4KD7I6', '15326864444', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '内蒙古赤峰红山万达广场中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3405', '0', '13865095737', '0', '4667fbc8a39b15a8f3da54e9ba0cbca8', '1', '', '0', '1', '53iYGD', '13865095737', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', ' 安徽蚌埠固镇中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3406', '0', '15531976967', '0', '645bf26d144eecbef73b6b5dbf6795e9', '1', '', '0', '1', 'BiGRAz', '15531976967', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北邢台巨鹿中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3407', '0', '15324073652', '0', '4eac6c82b9c3d829eb6051aab8728e5c', '1', '', '0', '1', 'FfC7wM', '15324073652', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北张家口张北新世纪中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3408', '0', '18692007995', '0', 'd6d8ed04a94cb08a2868cc716278768a', '1', '', '0', '1', 'LoRO0y', '18692007995', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '湖南衡阳耒阳金阳路中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3409', '0', '15265371999', '0', 'bd924dcb4729f87b4e87bb57852e8de9', '1', '', '0', '1', 'slAuvg', '15265371999', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东济宁微山中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3410', '0', '15254976965', '0', 'ea6785ecb42af7e1288375b0c7f913be', '1', '', '0', '1', 'FHKEDb', '15254976965', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东临沂平邑中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3411', '0', '13717615977', '0', 'd05b80217adce6884f60b689e62506a4', '1', '', '0', '1', 'vCaxIn', '13717615977', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '北京海淀万柳中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3412', '0', '15137977799', '0', 'bf054b23c1dbf716ad691d66ecd72aa0', '1', '', '0', '1', 'lt5fRC', '15137977799', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南洛阳宜阳锦花中心 ', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3413', '0', '15617001100', '0', '2868507b34678c134848ad4d0f1f9f97', '1', '', '0', '1', '6O1Tz0', '15617001100', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南商丘睢阳中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3414', '0', '13069483737', '0', '4ad5b91eba61bcf0527f9782e831a8d1', '1', '', '0', '1', '9L9B8P', '13069483737', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南焦作王府井中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3415', '0', '18637888638', '0', '4546d10c3f45c1e3936f4e07ca289600', '1', '', '0', '1', 'biKMIQ', '18637888638', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南开封开元广场中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3416', '0', '13599228806', '0', '083fb1f32a8ea2285a3d994ef78878bf', '1', '', '0', '1', 'W4Fhlq', '13599228806', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '福建泉州石狮中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3417', '0', '13881385528', '0', '70753acf342539a8b46364ec95ca182f', '1', '', '0', '1', '23HOpD', '13881385528', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '万隽', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3418', '0', '15859160992', '0', 'c471ce0279ff87a17341e011a642ae16', '1', '', '0', '1', '1KMHPl', '15859160992', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '黄丽君', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3419', '0', '18369301859', '0', '56ad369779890af244fe20dca78069e5', '1', '', '0', '1', 'voMXo8', '18369301859', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '高礼燕', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3420', '0', '13731112345', '0', '6552bbed31a85cc701044a69d84ae15d', '1', '', '0', '1', 'CR1Rw4', '17331833659', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北石家庄长安阿尔卡迪亚中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3421', '0', '17331833659', '0', '75b8beb8989c6b2af16284d7726edd56', '1', '', '0', '1', 'COfF0e', '17331833659', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北衡水冀州都会城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3422', '0', '18830362003', '0', '7be8c197f5255fdf99ea0db19aa132e7', '1', '', '0', '1', 'b6TQvR', '18830362003', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', ' 尤晓玉', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3423', '0', '15263971111', '0', '7d96f4005872e5c0f11928c6798bd51f', '1', '', '0', '1', 'iP5UOE', '15263971111', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东临沂沂水中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3424', '0', '18063589350', '0', 'f76697bfb2993f3fe74050d7fa7cb35e', '1', '', '0', '1', 'mMpb1X', '18063589350', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东聊城东昌府鸿顺中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3425', '0', '15192626268', '0', 'dee8e12324a3e7922d1045b806a8546d', '1', '', '0', '1', '5gfkBY', '15192626268', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东青岛胶州香港花园中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3426', '0', '15020111966', '0', 'b4caadac7f5229901c7a1be977132071', '1', '', '0', '1', 'a3aVqn', '15020111966', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东菏泽单县中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3427', '0', '13325034831', '0', 'a1de570d93becfe7fe1cf79ba4b29a48', '1', '', '0', '1', '9InLzt', '13325034831', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东东营广饶中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3428', '0', '13589998537', '0', '19a4bb7d330143a77c7688cbdbf192a1', '1', '', '0', '1', 'pSWAAh', '18563626646', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '张伟', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3429', '0', '13682073969', '0', '2b81910af41206b7b6287d6aaa14a448', '1', '', '0', '1', 'DrH6pM', '13682073969', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '天津津南首创中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3430', '0', '15770295405', '0', '8913696fada91aa077b9138ba9dc743c', '1', '', '0', '1', 'xA58j2', '15770295405', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '云南保山腾冲腾越中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3431', '0', '15518210369', '0', '1e072280c9c4b62312b8f4b78f471fba', '1', '', '0', '1', 'aGEFVX', '15518210369', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', ' 河南漯河会展中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3432', '0', '18603535278', '0', '340ff076e0b565cef1569afe5fdde388', '1', '', '0', '1', 'qaS5XD', '18603535278', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山西阳泉盂县中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3433', '0', '13850390809', '0', 'bcf34ac6c2404357d244f557bec32b6a', '1', '', '0', '1', 'oD5qqr', '13850390809', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '福建厦门湖里301中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3434', '0', '15109611751', '0', '008c957a1978072497e467defc19ce89', '1', '', '0', '1', 'l1DEfD', '15109611751', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '宁夏银川贺兰中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3435', '0', '13865935365', '0', 'c12ca766513fc8697ec2dfd215fba6b4', '1', '', '0', '1', 'LCi855', '13865935365', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '安徽合肥蜀山天h中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3436', '0', '18714845473', '0', '421c39310c81007a13b96e18f12fff68', '1', '', '0', '1', 'HUPEyj', '18714845473', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '安徽芜湖鸠江公园大道中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3437', '0', '13052812730', '0', '78fdf688273fd923c5a124cf8a45a796', '1', '', '0', '1', 'dPYsVn', '13052812730', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '江苏镇江润州美的城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3438', '0', '13705251705', '0', 'a6e30b48d0e1526c8cd561c9c64d3f6c', '1', '', '0', '1', 'dsDIK2', '13705251705', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '江苏扬州邗江万达中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3439', '0', '18516413993', '0', 'da3f2eeb075dc65eb5ca9050ae1c006a', '1', '', '0', '1', 'xIejvu', '18516413993', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '上海闵行龙柏中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3440', '0', '17604320190', '0', '6fc5f954ca6739d932618742fdd1ac6f', '1', '', '0', '1', 'HWXl2n', '17604320190', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '吉林吉林丰满水韵名城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3441', '0', '18920926556', '0', 'd8ed178b2d84041ac304395cd14cc7ff', '1', '', '0', '1', 't0xrKr', '18920926556', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '内蒙古通辽科尔沁中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3442', '0', '15729597865', '0', '3a5ee0a4cab3126eb60a646fcdb4556f', '1', '', '0', '1', 'jsa5Ty', '15729597865', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '宁夏银川兴庆中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3443', '0', '13630030886', '0', '9d7a35c98a8197d21be50a7b4fe1dd47', '1', '', '0', '1', 'tZR0bu', '13630030886', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '广东佛山顺德乐从中心  ', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3444', '0', '13902464957', '0', 'fff38cc42522ce9b7ec63b63144f48b6', '1', '', '0', '1', 'my1RtA', '13902464957', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '广东深圳南山蛇口海上世界中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3445', '0', '13712677744', '0', 'b4c45db9d6b01f409c9a38ddd7cef0c6', '1', '', '0', '1', 'Q9ZClo', '13712677744', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '广东东莞厚街', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3446', '0', '13682073969', '0', 'd48387a00aa389da2b8265a9751a85ae', '1', '', '0', '1', 'JQMgaT', '13682073969', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '天津津南首创中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3447', '0', '18646091550', '0', '7e65f6dfee88926c13111abeee8d1966', '1', '', '0', '1', '8y3v9b', '18646091550', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '园长', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3448', '0', '17663023166', '0', 'bc3b272a0c1be3af97aadddad5047507', '1', '', '0', '1', '2c6CUr', '13663023166', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东淄博临淄凤凰城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3449', '0', '17615145146', '0', '59f02ce1ca2e1823341f814b6179255b', '1', '', '0', '1', 'Qn2eiS', '', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '辽宁朝阳双塔天盛嘉苑中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3450', '0', '123123', '0', '9af12de2c77fad6709362c3efd115ce3', '1', '', '0', '1', 'edre5K', '13834645634', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '123123', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3451', '0', '15959285957', '0', '1e8655e0c651d908df3067eb91ed66a9', '1', '', '0', '1', '6RjBmL', '15959285957', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '福建厦门翔安泰禾中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3452', '0', '13435074595', '0', '99bd11745e5f82ceebf0145e232c8c13', '1', '', '0', '1', 'cLNJTg', '13435074595', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '广东韶关武江太阳城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3453', '0', '17727778168', '0', 'd4f6b7c42b9ec86f728e85c76db7c867', '1', '', '0', '1', 'BPakJu', '17727778168', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '广东韶关浈江凤凰城中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3454', '0', '15610027899', '0', '6f0bc2a5cef407d7726dd497ac03452c', '1', '', '0', '1', 'd01cb2', '15610027899', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '山东青岛莱西香港路中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3455', '0', '13388018326', '0', '9c01c9629809812935f0169b5f651259', '1', '', '0', '1', 'SwgOfr', '13388018326', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '天津武清荔隆中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3456', '0', '13820654734', '0', '57b2353f64a4eb3cea37a2b2ea95a7f2', '1', '', '0', '1', 'K4UoC5', '13820654734', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '天津河西田园商业广场中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3457', '0', '15933160898', '0', 'e7bf449b7efc0989129723d971a423ed', '1', '', '0', '1', 'K5O4CP', '15933160898', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '天津武清创意米兰中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3458', '0', '18721499498', '0', '642ddeada87c3a64979efee259f15256', '1', '', '0', '1', '1Px8KA', '18721499498', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '张琴', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3459', '0', '13887326118', '0', 'f0a67b218963125c2bde9e8cc8074eb1', '1', '', '0', '1', 'gH9Td7', '13887326118', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '云南红河弥勒中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3460', '0', '15302176543', '0', '48f58abb3654a3a848dc3742a0a62b97', '1', '', '0', '1', '3TNDXv', '15302176543', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '天津塘沽金水畔广场中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3461', '0', '13905650330', '0', 'ed5aff9f2482e6303c50718a1db68309', '1', '', '0', '1', 'CbzSWV', '13905650330', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '安徽合肥巢湖华邦书香里中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3462', '0', '18790422669', '0', 'c934beb6c44d5d36c3cb1e237ca8a44c', '1', '', '0', '1', 'tgpVJX', '18790422669', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南信阳浉河中心  ', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3463', '0', '13564192692', '0', '2c121512e2f830b530a99ba87756f0c6', '1', '', '0', '1', 'UcdtL6', '17717362692', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '上海浦东新区惠南中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3464', '0', '15724451111', '0', 'c1736957368835ffafd8e2cdfbdd80a5', '1', '', '0', '1', 'ab0UJA', '13261313123', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '辽宁锦州太和万达中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3465', '0', '18637718772', '0', '4caa056ecc90661872de225ca6ac1807', '1', '', '0', '1', 'BxechL', '18637718772', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南南阳宛城华鑫商务中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3466', '0', '13152318468', '0', 'f88e478b8a539420f2edf8ccef3befd4', '1', '', '0', '1', 'kROxAV', '13609215324', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '陕西咸阳秦都玉景台中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3467', '0', '13832896258', '0', 'be0cee07435b58113110773847e70adc', '1', '', '0', '1', 'ktkCJy', '13832896258', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北唐山玉田县中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3468', '0', '13831762000', '0', '240d33d2184227448ebb08d1cbdf7406', '1', '', '0', '1', 'uHnJTT', '13831762000', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北沧州黄骅中捷友谊广场中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3469', '0', '15075891780', '0', '855a90c874400ce1cacf1c7b01baad6c', '1', '', '0', '1', 'dWM2vB', '15075891780', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北衡水安平中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3470', '0', '18931638960', '0', '902f3c8de8086f0ff85e7272b201d169', '1', '', '0', '1', 'IwxFPJ', '18931638960', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北衡水武邑县中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3471', '0', '13613216963', '0', '2b8ef1bc06a6227a5abd9deda9406617', '1', '', '0', '1', 'kOWQJ3', '13613216963', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北石家庄裕华中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3472', '0', '15732596260', '0', 'e28391f2e70ea949c95f0893a0b1f791', '1', '', '0', '1', '1LES6R', '15732596260', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河北唐山路北汇金中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3473', '0', '15639137177', '0', '23912052ccdd816e13c8f04b69c021c9', '1', '', '0', '1', 'r2UcJ1', '15639137177', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '河南济源济中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3474', '0', '13861529171', '0', '81c435bc73df3e01981004c3609bde81', '1', '', '0', '1', 'GxU6Tb', '13861529171', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '江苏宜兴官林尚岛豪庭中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3475', '0', '15029457788', '0', 'd20f433bd1f23bed4605acacbf34250b', '1', '', '0', '1', 'fRsbVE', '15029457788', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '陕西安康汉滨金坊国际中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3476', '0', '18917946833', '0', '69c15c51d58582e9320891046ab43283', '1', '', '0', '1', 'nQs60d', '18917946833', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '上海浦东新区博硕创意园中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3477', '0', '18946726766', '0', 'ae1ce700835a9e67019f50f6904512ff', '1', '', '0', '1', 'ZjvcqM', '18946726766', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '吉林长春高新富强天玺中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3478', '0', '18913919648', '0', '924849cc70398fb2dc5ad32e822a52a0', '1', '', '0', '1', 'HQIbQh', '18913919648', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '江苏南京栖霞万达中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3479', '0', '15951594083', '0', '2b7880f45c635ac43e4c6b5fe7efc611', '1', '', '0', '1', 'zbwJQ0', '15951594083', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '李实', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3480', '0', '18408441701', '0', '9a201f87812eb07cde9879733ed58a64', '1', '', '0', '1', '5T0Tcr', '18408441701', '1', '', '', '', '', '0', null, '0', null, null, null, null, null, null, '0', '', '0', '', '宁夏银川吉泰润园中心', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3481', '1', 'shizhi01', '0', '1573002dc40cdd16cdf7c0b03f7fca17', '1', '', '0', '0', '4NIiH8', '', '0', '', '1', '', '123456', '0', '', '0', '', '', null, null, null, null, '0', '', '0', '', '', '', '0', '0', '0', '1544235945', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3482', '1', 'shizhi02', '0', 'aee2ac5582928bd113286c3aabc209ca', '1', '', '0', '0', 'UWfEzj', '', '0', '', '1', '', '123456', '0', '', '0', '', '', null, null, null, null, '0', '', '0', '', '', '', '0', '0', '0', '1544236302', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3485', '0', 'shizhi06', '0', 'c028579991c55228d3f2bc427e45812d', '1', '', '0', '1', 'R5hnF4', '', '0', '', '', '', '', '0', '', '0', '', '', '14.155.89.203', '1', '14.155.89.203', '1', '3', '', '1', '', 'shizhi', '', '0', '0', '0', '1544237334', '1544237362', '1544237348', '0');
INSERT INTO `sys_user` VALUES ('3486', '0', 'miaohua', '0', 'ae6d401d0097a232fcbd50c372d40994', '1', '', '1', '1', 'FMR9e7', '', '0', '', '', '', '', '0', '', '0', '', '', null, null, null, null, '0', '', '0', '', 'miaohua', '', '0', '0', '0', '1544513701', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3487', '0', 'goods', '0', '751d6062ca3e9b0d3ead54b430e38d06', '0', '', '1', '1', 'bVxHDt', '', '0', '', '', '', '', '0', '', '0', '', '', '183.11.39.165', '1', '', '0', '1', '', '0', '', 'goods', '', '0', '0', '0', '1546590699', '1546590710', '0', '0');
INSERT INTO `sys_user` VALUES ('3488', '0', 'luyao', '0', 'eee86d0f6f2dbf3b23a65ca2afe51d23', '1', '', '1', '1', 'KImUcA', '', '0', '', '', '', '', '0', '', '0', '', '', '122.70.179.90', '1', '114.242.249.93', '1', '6', '', '0', '', 'luyao5461', '', '0', '0', '0', '1546662082', '1546999138', '1546945423', '0');
INSERT INTO `sys_user` VALUES ('3489', '0', 'yangxiuzhi', '0', '51e9322b776ee6cb4216d4322bf197cd', '1', '', '1', '1', 'GNk3AI', '', '0', '', '', '', '', '0', '', '0', '', '', null, null, null, null, '0', '', '0', '', 'yangxiuzhi', '', '0', '0', '0', '1546662368', '0', '0', '0');
INSERT INTO `sys_user` VALUES ('3490', '0', 'caiwu', '0', 'e041395f2e2ccfada6700441426d96e9', '1', '', '1', '1', 'FDzInD', '', '0', '', '', '', '', '0', '', '0', '', '', '183.11.36.28', '1', '', '0', '1', '', '0', '', 'caiwu', '', '0', '0', '0', '1547805778', '1547805804', '0', '0');
INSERT INTO `sys_user` VALUES ('3491', '0', 'cangku', '0', 'ea337e31a8333992b5a7e39c1092fd44', '1', '', '1', '1', 'NHejXx', '', '0', '', '', '', '', '0', '', '0', '', '', '183.11.36.28', '1', '183.11.36.28', '1', '2', '', '0', '', 'cangwu', '', '0', '0', '0', '1547805792', '1547859264', '1547805903', '0');

-- ----------------------------
-- Table structure for sys_user_admin
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_admin`;
CREATE TABLE `sys_user_admin` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'user用户ID',
  `admin_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户姓名',
  `group_id_array` int(11) NOT NULL DEFAULT '0' COMMENT '系统用户组',
  `is_admin` int(1) NOT NULL DEFAULT '0' COMMENT '是否是系统管理员组',
  `admin_status` int(11) DEFAULT '1' COMMENT '状态 默认为1',
  `desc` text COMMENT '附加信息',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=910 COMMENT='后台管理员表';

-- ----------------------------
-- Records of sys_user_admin
-- ----------------------------
INSERT INTO `sys_user_admin` VALUES ('1', 'admin', '1', '1', '1', '');
INSERT INTO `sys_user_admin` VALUES ('3481', 'shizhi01', '1', '0', '1', '111');
INSERT INTO `sys_user_admin` VALUES ('3482', 'shizhi02', '1', '0', '1', '');
INSERT INTO `sys_user_admin` VALUES ('3486', 'miaohua', '1', '0', '1', '');
INSERT INTO `sys_user_admin` VALUES ('3487', 'goods', '2', '0', '1', '');
INSERT INTO `sys_user_admin` VALUES ('3488', 'luyao', '2', '0', '1', '产品部总监');
INSERT INTO `sys_user_admin` VALUES ('3489', 'yangxiuzhi', '4', '0', '1', '财务总监');
INSERT INTO `sys_user_admin` VALUES ('3490', 'caiwu', '4', '0', '1', '');
INSERT INTO `sys_user_admin` VALUES ('3491', 'cangku', '5', '0', '1', '');

-- ----------------------------
-- Table structure for sys_user_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_group`;
CREATE TABLE `sys_user_group` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `instance_id` int(11) NOT NULL DEFAULT '1' COMMENT '实例ID',
  `group_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户组名称',
  `group_status` int(11) NOT NULL DEFAULT '1' COMMENT '用户组状态',
  `is_system` int(1) NOT NULL DEFAULT '0' COMMENT '是否是系统用户组',
  `module_id_array` text NOT NULL COMMENT '系统模块ID组，用，隔开',
  `desc` text COMMENT '描述',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=963 COMMENT='系统用户组表';

-- ----------------------------
-- Records of sys_user_group
-- ----------------------------
INSERT INTO `sys_user_group` VALUES ('1', '0', '管理员组', '1', '1', '120,121,122,123,126,127,128,129,133,137,139,144,145,149,151,169,170,171,172,176,179,180,184,185,186,187,189,190,191,192,194,195,196,197,198,199,200,201,202,203,210,218,221,334,335,336,339,340,341,342,343,358,359,360,361,381,382,383,387,388,389,390,392,394,395,403,405,409,418,419,420,421,422,423,424,425,427,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,450,451,452,454,455,456,457,459,460,461,462,463,469,471,472,474,477,478,479,480,481,482,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,501,502,503,504,506,507,508,509,510,512,513,517,518,519,520,521,522,523,524,525,526,527,528,529,530,10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013,10014,10015,10016,10017,10018,10019,10021,10022,10023,10024,10075,10076,10077,10078,10079,10080,10081,10082,10083', null, '2017', '0');
INSERT INTO `sys_user_group` VALUES ('2', '0', '产品部总管理', '1', '0', '137,145,497,498,447,488,489,490,504,509,510,149,139,169,151,171,172,210,334,419,420,421,422,423,424,425,478,479,480,481,482,484,485,517,518,10001,10002,10003,179,180,186,187,195,196,197,198,199,200,201,202,203,446,507,508,469,184,185,190,194,218,439,495,496,506,10075,529,189,191,192,471,472,486,487,519,520,521,522,525,526,10016,335,336,339,340,358,341,359,342,450,451,343,361,10086,409,403,405,454,457,459,461,462,463,460,477,381,382,383,387,388,389,431,432,433,434,452,455,491,492,493,530,440,441,442,443,444,10004,390,392,394,395,427,430,435,436,437,445,10024,10080,10081,10005,474,10006,10018,10021,10023', '', '1543999831', '1546662259');
INSERT INTO `sys_user_group` VALUES ('4', '0', '财务部总管理', '1', '0', '409,403,405,454,457,459,461,462,463,460,10088,10097,10089,10098,10099', '', '1546662327', '1547805737');
INSERT INTO `sys_user_group` VALUES ('5', '0', '仓库部总管理', '1', '0', '10090,10091,10092,10102,10103,10093,10101', '', '1547805758', '0');

-- ----------------------------
-- Table structure for sys_user_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_log`;
CREATE TABLE `sys_user_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '操作用户ID',
  `is_system` int(11) NOT NULL DEFAULT '1' COMMENT '是否是后台操作',
  `controller` varchar(255) NOT NULL DEFAULT '' COMMENT '操作控制器',
  `method` varchar(255) NOT NULL DEFAULT '' COMMENT '操作方案',
  `data` text COMMENT '传输数据',
  `ip` varchar(255) DEFAULT NULL COMMENT 'ip地址',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=82 COMMENT='用户操作日志';

-- ----------------------------
-- Records of sys_user_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_version_devolution
-- ----------------------------
DROP TABLE IF EXISTS `sys_version_devolution`;
CREATE TABLE `sys_version_devolution` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `devolution_username` varchar(255) NOT NULL DEFAULT '' COMMENT '授权账户',
  `devolution_password` varchar(255) NOT NULL DEFAULT '' COMMENT '授权密码',
  `create_date` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='用户授权信息';

-- ----------------------------
-- Records of sys_version_devolution
-- ----------------------------

-- ----------------------------
-- Table structure for sys_version_patch
-- ----------------------------
DROP TABLE IF EXISTS `sys_version_patch`;
CREATE TABLE `sys_version_patch` (
  `patch_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `patch_type` int(11) NOT NULL DEFAULT '1' COMMENT '补丁类型  1. B2C单用户商城 2.B2C 单用户分销商城 3 B2B2C多用户商城',
  `patch_type_name` varchar(50) NOT NULL DEFAULT '' COMMENT '补丁类型名称',
  `patch_release` varchar(50) NOT NULL DEFAULT '' COMMENT '补丁编号',
  `patch_name` varchar(255) NOT NULL DEFAULT '' COMMENT '补丁标题',
  `patch_no` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '版本号',
  `patch_file_name` varchar(50) NOT NULL DEFAULT '' COMMENT '补丁文件名称',
  `patch_log` text NOT NULL COMMENT '版本补丁更新日志',
  `patch_file_size` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '补丁文件大小',
  `is_up` int(11) NOT NULL DEFAULT '2' COMMENT '是否升级  1代表已升级  0未升级 2全部',
  `modify_date` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`patch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='版本补丁管理';

-- ----------------------------
-- Records of sys_version_patch
-- ----------------------------

-- ----------------------------
-- Table structure for sys_web_style
-- ----------------------------
DROP TABLE IF EXISTS `sys_web_style`;
CREATE TABLE `sys_web_style` (
  `style_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `style_name` varchar(50) NOT NULL DEFAULT '' COMMENT '样式名称',
  `style_path` varchar(255) NOT NULL DEFAULT '' COMMENT '样式路径',
  `stye_img` varchar(255) NOT NULL DEFAULT '' COMMENT '样式图片路径',
  `desc` text COMMENT '备注',
  `type` int(11) DEFAULT '1' COMMENT '1：前台样式，2：后台样式',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`style_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='网站前台样式表';

-- ----------------------------
-- Records of sys_web_style
-- ----------------------------
INSERT INTO `sys_web_style` VALUES ('1', '热情洋溢', 'default', '', null, '1', '0', '0');
INSERT INTO `sys_web_style` VALUES ('2', '蓝色清爽', 'blue', '', null, '1', '0', '0');
INSERT INTO `sys_web_style` VALUES ('3', '经典版', 'admin', '', '', '2', '1500608775', '1500608775');
INSERT INTO `sys_web_style` VALUES ('4', '简约版', 'adminblue', '', '', '2', '1500608775', '1500608775');

-- ----------------------------
-- Table structure for sys_website
-- ----------------------------
DROP TABLE IF EXISTS `sys_website`;
CREATE TABLE `sys_website` (
  `website_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '网站标题',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '网站logo',
  `web_desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '网站描述',
  `key_words` varchar(255) NOT NULL DEFAULT '' COMMENT '网站关键字',
  `web_icp` varchar(255) NOT NULL DEFAULT '' COMMENT '网站备案号',
  `style_id_pc` int(10) NOT NULL DEFAULT '2' COMMENT '前台网站风格（1：热情洋溢模板，2：蓝色清爽版）',
  `web_address` varchar(255) NOT NULL DEFAULT '' COMMENT '网站联系地址',
  `web_qrcode` varchar(255) NOT NULL DEFAULT '' COMMENT '网站公众号二维码',
  `web_url` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺网址',
  `web_email` varchar(255) NOT NULL DEFAULT '' COMMENT '网站邮箱',
  `web_phone` varchar(255) NOT NULL DEFAULT '' COMMENT '网站联系方式',
  `web_qq` varchar(255) NOT NULL DEFAULT '' COMMENT '网站qq号',
  `web_weixin` varchar(255) NOT NULL DEFAULT '' COMMENT '网站微信号',
  `web_status` int(10) NOT NULL DEFAULT '1' COMMENT '网站运营状态1.开启 2.关闭 ',
  `web_visit` int(11) NOT NULL DEFAULT '2',
  `web_reg` int(11) NOT NULL DEFAULT '1' COMMENT '是否开启注册 1 开启 2 关闭',
  `third_count` text NOT NULL COMMENT '第三方统计',
  `close_reason` varchar(255) NOT NULL DEFAULT '' COMMENT '站点关闭原因',
  `wap_status` int(10) NOT NULL DEFAULT '1' COMMENT '手机端运营状态 1.开启2.关闭',
  `style_id_admin` int(10) DEFAULT '4' COMMENT '后台网站风格（3：旧模板，4：新模板）',
  `create_time` int(11) DEFAULT '0' COMMENT '网站创建时间',
  `modify_time` int(11) DEFAULT '0' COMMENT '网站修改时间',
  `url_type` int(11) NOT NULL DEFAULT '0' COMMENT '网站访问模式',
  `web_popup_title` varchar(50) NOT NULL DEFAULT '' COMMENT '网站弹出框标题',
  `config` text NOT NULL COMMENT '网站配置(json格式)',
  PRIMARY KEY (`website_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='网站信息表';

-- ----------------------------
-- Records of sys_website
-- ----------------------------
INSERT INTO `sys_website` VALUES ('1', '斯玛特加盟商电商系统', 'upload/common/1544172200.png', '', '斯玛特商城', '123456789', '1', '深圳市罗湖区百汇大厦', 'upload/common/1543909435.png', 'www.smtjy.com', '1014256196@qq.com', '17727750995', '1014256196', '17727750995', '1', '2', '2', '', '系统维护中', '1', '0', '1477452112', '1546565744', '0', '斯玛特', '');

-- ----------------------------
-- Table structure for sys_weixin_auth
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_auth`;
CREATE TABLE `sys_weixin_auth` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `authorizer_appid` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺的appid  授权之后不用刷新',
  `authorizer_refresh_token` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺授权之后的刷新token，每月刷新',
  `authorizer_access_token` varchar(255) NOT NULL DEFAULT '' COMMENT '店铺的公众号token，只有2小时',
  `func_info` varchar(1000) NOT NULL DEFAULT '' COMMENT '授权项目',
  `nick_name` varchar(50) NOT NULL DEFAULT '' COMMENT '公众号昵称',
  `head_img` varchar(255) NOT NULL DEFAULT '' COMMENT '公众号头像url',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '公众号原始账号',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT '公众号原始名称',
  `qrcode_url` varchar(255) NOT NULL DEFAULT '' COMMENT '公众号二维码url',
  `auth_time` int(11) DEFAULT '0' COMMENT '授权时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='店铺(实例)微信公众账号授权';

-- ----------------------------
-- Records of sys_weixin_auth
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_default_replay
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_default_replay`;
CREATE TABLE `sys_weixin_default_replay` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance_id` int(11) NOT NULL COMMENT '店铺id',
  `reply_media_id` int(11) NOT NULL COMMENT '回复媒体内容id',
  `sort` int(11) NOT NULL,
  `create_time` int(11) DEFAULT '0',
  `modify_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='关注时回复';

-- ----------------------------
-- Records of sys_weixin_default_replay
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_fans
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_fans`;
CREATE TABLE `sys_weixin_fans` (
  `fans_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '粉丝ID',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '会员编号ID',
  `source_uid` int(11) NOT NULL DEFAULT '0' COMMENT '推广人uid',
  `instance_id` int(11) NOT NULL COMMENT '店铺ID',
  `nickname` varchar(255) NOT NULL COMMENT '昵称',
  `nickname_decode` varchar(255) DEFAULT '',
  `headimgurl` varchar(500) NOT NULL DEFAULT '' COMMENT '头像',
  `sex` smallint(6) NOT NULL DEFAULT '1' COMMENT '性别',
  `language` varchar(20) NOT NULL DEFAULT '' COMMENT '用户语言',
  `country` varchar(60) NOT NULL DEFAULT '' COMMENT '国家',
  `province` varchar(255) NOT NULL DEFAULT '' COMMENT '省',
  `city` varchar(255) NOT NULL DEFAULT '' COMMENT '城市',
  `district` varchar(255) NOT NULL DEFAULT '' COMMENT '行政区/县',
  `openid` varchar(255) NOT NULL DEFAULT '' COMMENT '用户的标识，对当前公众号唯一     用户的唯一身份ID',
  `unionid` varchar(255) NOT NULL DEFAULT '' COMMENT '粉丝unionid',
  `groupid` int(11) NOT NULL DEFAULT '0' COMMENT '粉丝所在组id',
  `is_subscribe` bigint(1) NOT NULL DEFAULT '1' COMMENT '是否订阅',
  `memo` varchar(255) NOT NULL COMMENT '备注',
  `subscribe_date` int(11) DEFAULT '0' COMMENT '订阅时间',
  `unsubscribe_date` int(11) DEFAULT '0' COMMENT '解订阅时间',
  `update_date` int(11) DEFAULT '0' COMMENT '粉丝信息最后更新时间',
  PRIMARY KEY (`fans_id`),
  KEY `IDX_sys_weixin_fans_openid` (`openid`),
  KEY `IDX_sys_weixin_fans_unionid` (`unionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1638 COMMENT='微信公众号获取粉丝列表';

-- ----------------------------
-- Records of sys_weixin_fans
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_follow_replay
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_follow_replay`;
CREATE TABLE `sys_weixin_follow_replay` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance_id` int(11) NOT NULL COMMENT '店铺id',
  `reply_media_id` int(11) NOT NULL COMMENT '回复媒体内容id',
  `sort` int(11) NOT NULL,
  `create_time` int(11) DEFAULT '0',
  `modify_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='关注时回复';

-- ----------------------------
-- Records of sys_weixin_follow_replay
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_functions_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_functions_button`;
CREATE TABLE `sys_weixin_functions_button` (
  `button_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `instance_id` int(11) NOT NULL COMMENT '实例',
  `button_name` varchar(50) NOT NULL DEFAULT '' COMMENT '模块名',
  `keyname` varchar(20) NOT NULL DEFAULT '' COMMENT '触发关键词',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '触发网址',
  `hits` int(11) NOT NULL DEFAULT '0' COMMENT '触发次数',
  `is_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `is_system` int(1) DEFAULT '0',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '排序号',
  `create_time` int(11) DEFAULT '0' COMMENT '创建日期',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改日期',
  PRIMARY KEY (`button_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1489 COMMENT='微信功能按钮';

-- ----------------------------
-- Records of sys_weixin_functions_button
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_instance_msg
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_instance_msg`;
CREATE TABLE `sys_weixin_instance_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `instance_id` int(11) NOT NULL COMMENT '店铺id（单店版为0）',
  `template_no` varchar(55) NOT NULL COMMENT '模版编号',
  `template_id` varbinary(55) DEFAULT NULL COMMENT '微信模板消息的ID',
  `title` varchar(100) NOT NULL COMMENT '模版标题',
  `is_enable` bit(1) DEFAULT b'0' COMMENT '是否启用',
  `headtext` varchar(255) NOT NULL COMMENT '头部文字',
  `bottomtext` varchar(255) NOT NULL COMMENT '底部文字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=4096 COMMENT='微信实例消息';

-- ----------------------------
-- Records of sys_weixin_instance_msg
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_key_replay
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_key_replay`;
CREATE TABLE `sys_weixin_key_replay` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance_id` int(11) NOT NULL COMMENT '店铺id',
  `key` varchar(255) NOT NULL COMMENT '关键词',
  `match_type` tinyint(4) NOT NULL COMMENT '匹配类型1模糊匹配2全部匹配',
  `reply_media_id` int(11) NOT NULL COMMENT '回复媒体内容id',
  `sort` int(11) NOT NULL,
  `create_time` int(11) DEFAULT '0',
  `modify_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='关键词回复';

-- ----------------------------
-- Records of sys_weixin_key_replay
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_media
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_media`;
CREATE TABLE `sys_weixin_media` (
  `media_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '图文消息id',
  `title` varchar(100) DEFAULT NULL,
  `instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '实例id店铺id',
  `type` varchar(255) NOT NULL DEFAULT '1' COMMENT '类型1文本(项表无内容) 2单图文 3多图文',
  `sort` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) DEFAULT '0' COMMENT '创建日期',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改日期',
  PRIMARY KEY (`media_id`),
  UNIQUE KEY `id` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1170;

-- ----------------------------
-- Records of sys_weixin_media
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_media_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_media_item`;
CREATE TABLE `sys_weixin_media_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `media_id` int(11) NOT NULL COMMENT '图文消息id',
  `title` varchar(100) DEFAULT NULL,
  `author` varchar(50) NOT NULL COMMENT '作者',
  `cover` varchar(200) NOT NULL COMMENT '图文消息封面',
  `show_cover_pic` tinyint(4) NOT NULL DEFAULT '1' COMMENT '封面图片显示在正文中',
  `summary` text,
  `content` text NOT NULL COMMENT '正文',
  `content_source_url` varchar(200) NOT NULL DEFAULT '' COMMENT '图文消息的原文地址，即点击“阅读原文”后的URL',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序号',
  `hits` int(11) NOT NULL DEFAULT '0' COMMENT '阅读次数',
  PRIMARY KEY (`id`),
  KEY `id` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=712;

-- ----------------------------
-- Records of sys_weixin_media_item
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_menu`;
CREATE TABLE `sys_weixin_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `menu_name` varchar(50) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `ico` varchar(32) NOT NULL DEFAULT '' COMMENT '菜图标单',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父菜单',
  `menu_event_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1普通url 2 图文素材 3 功能',
  `media_id` int(11) NOT NULL DEFAULT '0' COMMENT '图文消息ID',
  `menu_event_url` varchar(255) NOT NULL DEFAULT '' COMMENT '菜单url',
  `hits` int(11) NOT NULL DEFAULT '0' COMMENT '触发数',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_date` int(11) DEFAULT '0' COMMENT '创建日期',
  `modify_date` int(11) DEFAULT '0' COMMENT '修改日期',
  PRIMARY KEY (`menu_id`),
  KEY `IDX_biz_shop_menu_orders` (`sort`),
  KEY `IDX_biz_shop_menu_shopId` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1638 COMMENT='微设置->微店菜单';

-- ----------------------------
-- Records of sys_weixin_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_msg_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_msg_template`;
CREATE TABLE `sys_weixin_msg_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `template_no` varchar(55) NOT NULL COMMENT '编号',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `contents` varchar(255) NOT NULL DEFAULT '' COMMENT '内容示例',
  `template_id` varchar(55) DEFAULT '' COMMENT '模版id',
  `headtext` varchar(255) DEFAULT NULL COMMENT '头部文字',
  `bottomtext` varchar(255) DEFAULT NULL COMMENT '底部文字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信消息模版';

-- ----------------------------
-- Records of sys_weixin_msg_template
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_qrcode_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_qrcode_template`;
CREATE TABLE `sys_weixin_qrcode_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '实例ID',
  `instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `background` varchar(255) NOT NULL DEFAULT '' COMMENT '背景图片',
  `nick_font_color` varchar(255) NOT NULL DEFAULT '#000' COMMENT '昵称字体颜色',
  `nick_font_size` smallint(6) NOT NULL DEFAULT '12' COMMENT '昵称字体大小',
  `is_logo_show` smallint(6) NOT NULL DEFAULT '1' COMMENT 'logo是否显示',
  `header_left` varchar(6) NOT NULL DEFAULT '0px' COMMENT '头部左边距',
  `header_top` varchar(6) NOT NULL DEFAULT '0px' COMMENT '头部上边距',
  `name_left` varchar(6) NOT NULL DEFAULT '0px' COMMENT '昵称左边距',
  `name_top` varchar(6) NOT NULL DEFAULT '0px' COMMENT '昵称上边距',
  `logo_left` varchar(6) NOT NULL DEFAULT '0px' COMMENT 'logo左边距',
  `logo_top` varchar(6) NOT NULL DEFAULT '0px' COMMENT 'logo上边距',
  `code_left` varchar(6) NOT NULL DEFAULT '0px' COMMENT '二维码左边距',
  `code_top` varchar(6) NOT NULL DEFAULT '0px' COMMENT '二维码上边距',
  `is_check` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认',
  `is_remove` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除  0未删除 1删除',
  `template_url` varchar(255) NOT NULL DEFAULT '' COMMENT '模板样式路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=5461 COMMENT='微信推广二维码模板管理';

-- ----------------------------
-- Records of sys_weixin_qrcode_template
-- ----------------------------
INSERT INTO `sys_weixin_qrcode_template` VALUES ('1', '0', 'public/static/images/qrcode_bg/qrcode_bg.png', '#2b2b2b', '23', '1', '93px', '467px', '159px', '479px', '98px', '319px', '89px', '88px', '1', '0', 'public/static/images/qrcode_bg/template_bg_img.png');

-- ----------------------------
-- Table structure for sys_weixin_user_msg
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_user_msg`;
CREATE TABLE `sys_weixin_user_msg` (
  `msg_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `msg_type` varchar(255) NOT NULL,
  `content` text,
  `is_replay` int(11) NOT NULL DEFAULT '0' COMMENT '是否回复',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信用户消息表';

-- ----------------------------
-- Records of sys_weixin_user_msg
-- ----------------------------

-- ----------------------------
-- Table structure for sys_weixin_user_msg_replay
-- ----------------------------
DROP TABLE IF EXISTS `sys_weixin_user_msg_replay`;
CREATE TABLE `sys_weixin_user_msg_replay` (
  `replay_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` int(11) NOT NULL,
  `replay_uid` int(11) NOT NULL COMMENT '当前客服uid',
  `replay_type` varchar(255) NOT NULL,
  `content` text,
  `replay_time` int(11) DEFAULT '0',
  PRIMARY KEY (`replay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信用户消息回复表';

-- ----------------------------
-- Records of sys_weixin_user_msg_replay
-- ----------------------------

-- ----------------------------
-- Table structure for sys_wexin_onekeysubscribe
-- ----------------------------
DROP TABLE IF EXISTS `sys_wexin_onekeysubscribe`;
CREATE TABLE `sys_wexin_onekeysubscribe` (
  `instance_id` int(11) NOT NULL COMMENT '实例ID',
  `url` varchar(300) NOT NULL DEFAULT '' COMMENT '一键关注url',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2048 COMMENT='微信一键关注设置';

-- ----------------------------
-- Records of sys_wexin_onekeysubscribe
-- ----------------------------