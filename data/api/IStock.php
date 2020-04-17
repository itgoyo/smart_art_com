<?php

namespace data\api;
/**
 * 订单接口
 */
interface IStock
{
	/**
	 * 商品入库
	 * @param  [type] $data [description]
	 * @return [type]       [description]
	 */
	function inStock($data);


}