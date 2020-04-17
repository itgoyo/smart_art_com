<?php

namespace data\service\Purchase;

use think\Log;
use data\model\NsPurchaseGoodsModel;
use data\model\NsGoodsModel;
use data\service\BaseService;
/**
 * 采购单操作类
 */
class PurchaseGoods extends BaseService
{
    public $order;
    // 订单主表
    function __construct()
    {
        parent::__construct();
        $this->purchase_goods = new NsPurchaseGoodsModel();
    }

    
    public function createPurchaseGoods($purchase_id,$goods_id,$sku_id,$price,$num,$supplier_id)
    {
        $mGoods = new NsGoodsModel();
        $goods = $mGoods->where('goods_id',$goods_id)->find();
    	$this->purchase_goods->startTrans();
    	try{

    		// 采购主订单数据
    		$data_purchase_goods = array(
                'purchase_id' => $purchase_id,
                'goods_id' => $goods_id,
                'sku_id' => $sku_id,
                'goods_name' => $goods['goods_name'],
                'goods_picture' => $goods['picture'],
                'price' => $price,
                'num' => $num,
                'goods_money' => $price * $num,
                'supplier_id' => $supplier_id,
                'create_time' => time(),
    		);

    		$mPurchaseGoods = new NsPurchaseGoodsModel();
    		$mPurchaseGoods->allowField(true)->isUpdate(false)->save($data_purchase_goods);

            // 更新商品供应商数据
            $goods_data['supplier_id'] = $supplier_id;
            $condition['goods_id'] = $goods_id;
            $mGoods->isUpdate(true)->save($goods_data,$condition);

            
    	}catch (\Exception $e) {
            $this->purchase_goods->rollback();
            return $e->getMessage();
        }
        $this->purchase_goods->commit();
        return true;
    }

    protected function convert_status($value)
    {
        $map = [0=>'待入库',1=>'部分入库',2=>'全部入库'];
        if(key_exists($value,$map)){
            return $map[$value];
        }
        return '-';
    }

    /**
     * 采购统计
     * @param  integer $page_index     [description]
     * @param  integer $page_size      [description]
     * @param  string  $condition      [description]
     * @param  string  $purchase_goods [description]
     * @return [type]                  [description]
     */
    public function getPurchaseGoodsCount($page_index = 1, $page_size = 0, $condition = '',$purchase_goods = '')
    {
        $mPurchaseGoods = new NsPurchaseGoodsModel();

        $list = $mPurchaseGoods->pageQuery($page_index,$page_size,$condition,$purchase_goods,'*');
        foreach ($list['data'] as $item) {
            $item['status_name'] = $this->convert_status($item['status']);
        }

        $list['count_num'] = $mPurchaseGoods->getSum($condition,'num');
        $list['count_money'] = $mPurchaseGoods->getSum($condition,'goods_money');

        return $list;
    }

}