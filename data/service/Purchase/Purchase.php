<?php

namespace data\service\Purchase;

use think\Log;
use data\model\NsPurchaseModel;
use data\service\Purchase\PurchaseGoods;
use data\service\BaseService;
use data\model\WebSiteModel;
/**
 * 采购单操作类
 */
class Purchase extends BaseService
{
    public $order;
    // 订单主表
    function __construct()
    {
        parent::__construct();
        $this->purchase = new NsPurchaseModel();
    }

    
    public function purchaseCreate($goods_id,$sku_id,$num,$price,$supplier_id,$shipping_time,$memo,$uid,$user_name)
    {
    	// print_r($supplier_id);exit;
    	$this->purchase->startTrans();
    	try{
    		$purchase_no = date('YmdHis').rand('10000','99999');
    		// print_r($purchase_no);exit;
    		$amount = $price * $num;

    		// 采购主订单数据
    		$data_purchase = array(
                'purchase_no' => $purchase_no,
                'amount' => $amount,
                'purchase_time' => time(),
                'shipping_time' => $shipping_time,
                'create_time' => time(),
                'memo' => $memo,
                'uid' => $uid,
                'user_name' => $user_name
    		);

    		$mWs = new WebSiteModel();
    		$web_site = $mWs->find();
    		if($web_site['web_check'] == 2){
    		    $data_purchase['check_status'] = 2;
            }

    		// print_r($data_purchase);exit;

    		$mPurchase = new NsPurchaseModel();
    		$mPurchase->allowField(true)->isUpdate(false)->save($data_purchase);

    		$purchase_id = $mPurchase->purchase_id;

    		// 添加采购 订单项
    		$mPurchaseGoods = new PurchaseGoods();
    		$mPurchaseGoods->createPurchaseGoods($purchase_id,$goods_id,$sku_id,$price,$num,$supplier_id);

            
    	}catch (\Exception $e) {
            $this->purchase->rollback();
            return $e->getMessage();
        }
        $this->purchase->commit();
        return $purchase_id;

    }

    /**
     * 批量采购
     * @param  [type] $purchase_order_arr [description]
     * @param  [type] $shipping_time      [description]
     * @param  [type] $memo               [description]
     * @param  [type] $uid                [description]
     * @param  [type] $user_name          [description]
     * @return [type]                     [description]
     */
    public function batchPurchaseCreate($purchase_order_arr,$shipping_time,$memo,$uid,$user_name)
    {
    	$this->purchase->startTrans();
    	try{
    		$purchase_no = date('YmdHis').rand('10000','99999');
    		$amount = 0;
    		foreach ($purchase_order_arr as $item) {
    			$money = $item['num'] * $item['price'];
    			$amount += $money;
    		}

    		// 采购主订单数据
    		$data_purchase = array(
                'purchase_no' => $purchase_no,
                'amount' => $amount,
                'purchase_time' => time(),
                'shipping_time' => $shipping_time,
                'create_time' => time(),
                'memo' => $memo,
                'uid' => $uid,
                'user_name' => $user_name
    		);

    		$mPurchase = new NsPurchaseModel();
    		$mPurchase->allowField(true)->isUpdate(false)->save($data_purchase);
    		$purchase_id = $mPurchase->purchase_id;

    		foreach ($purchase_order_arr as $k => $v) {
    			// 添加采购 订单项
    		    $mPurchaseGoods = new PurchaseGoods();
    		    $mPurchaseGoods->createPurchaseGoods($purchase_id,$v['goods_id'],$v['price'],$v['num'],$v['supplier_id']);
    		}


    	}catch (\Exception $e) {
            $this->purchase->rollback();
            return $e->getMessage();
        }
        $this->purchase->commit();
        return $purchase_id;

    }


}