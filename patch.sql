DROP TABLE IF EXISTS `ns_goods_sku_stock_history`;
CREATE TABLE `ns_goods_sku_stock_history` (
  `gsh_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `sku_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格ID',
  `int_day` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '日期',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `create_date` int(11) unsigned DEFAULT '0' COMMENT '创建时间',
  `update_date` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`gsh_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='商品历史库存记录';


DROP TABLE IF EXISTS `ns_card`;
CREATE TABLE `ns_card`(
   `card_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
   `card_no` varchar(50) COMMENT '卡号',
   `card_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
   `is_issue` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否发行',
   `is_use` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用',
   `is_destroy` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否销毁',
   `expire_date` int(11) unsigned DEFAULT '0' COMMENT '过期时间',
   `create_date` int(11) unsigned DEFAULT '0' COMMENT '创建时间',
   `update_date` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
   PRIMARY KEY (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='阿特礼品卡';

ALTER TABLE `ns_order`
ADD COLUMN `card_money` decimal(10, 2) NOT NULL DEFAULT 0 COMMENT '阿特礼品卡抵扣金额' AFTER `coupon_id`,
ADD COLUMN `card_id` int(11) NOT NULL DEFAULT 0 COMMENT '阿特礼品卡ID' AFTER `card_money`;


DROP TABLE IF EXISTS `ns_report_goods_sku`;
CREATE TABLE `ns_report_goods_sku` (
  `rgs_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `sku_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规格ID',
  `start_int_day` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '开始日期',
  `end_int_day` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '结束日期',
  `pre_nums` int(11) NOT NULL DEFAULT '0' COMMENT '期初数量',
  `pre_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '期初金额',
  `instock_nums` int(11) NOT NULL DEFAULT '0' COMMENT '入库数量',
  `instock_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '入库金额',
  `outstock_nums` int(11) NOT NULL DEFAULT '0' COMMENT '出库数量',
  `outstock_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '出库金额',
  `inner_outstock_nums` int(11) NOT NULL DEFAULT '0' COMMENT '内部出库数量',
  `inner_outstock_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '内部出库金额',
  `purchase_nums` int(11) NOT NULL DEFAULT '0' COMMENT '采购数量',
  `purchase_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '采购金额',
  `purchase_times` int(11) NOT NULL DEFAULT '0' COMMENT '采购次数',
  `purchase_date` varchar(1024) DEFAULT '' COMMENT '采购时间',
  `sale_nums` int(11) NOT NULL DEFAULT '0' COMMENT '销售数量',
  `sale_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '销售金额',
  `balance_nums` int(11) NOT NULL DEFAULT '0' COMMENT '结存数量',
  `balance_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '结存金额',
  `mao_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '销售毛利',
  `create_date` int(11) unsigned DEFAULT '0' COMMENT '创建时间',
  `update_date` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`rgs_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='进销存报表';