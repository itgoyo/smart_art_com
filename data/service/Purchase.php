<?php

namespace data\service;
/**
 * 订单
 */
use data\api\IPurchase as IPurchase;
use data\service\BaseService;
use data\service\Purchase\Purchase as PurchaseBusiness;
use data\model\NsPurchaseModel;
use data\model\NsPurchaseGoodsModel;
use data\model\AlbumPictureModel;
use data\model\NsSupplierModel;
use data\model\NsGoodsModel;
use data\model\NsGoodsSkuModel;

use think\Log;
use phpDocumentor\Reflection\DocBlock\Tags\Var_;
class Purchase extends BaseService implements IPurchase
{
    private $purchase;
    function __construct()
    {
        parent::__construct();
        $this->purchase = new NsPurchaseModel();
    }

    /**
     * 添加一条采购订单
     * @param  [type] $goods_id      [description]
     * @param  [type] $num           [description]
     * @param  [type] $price         [description]
     * @param  [type] $supplier_id   [description]
     * @param  [type] $shipping_time [description]
     * @param  [type] $memo          [description]
     * @return [type]                [description]
     */
    public function purchaseCreate($goods_id,$sku_id,$num,$price,$supplier_id,$shipping_time,$memo,$uid,$user_name)
    {
        $mPurchase = new PurchaseBusiness();

        $ret = $mPurchase->purchaseCreate($goods_id,$sku_id,$num,$price,$supplier_id,$shipping_time,$memo,$uid,$user_name);

        return $ret;
    }


    public function deletePurchase($purchase_id)
    {
        $mPurchase = new NsPurchaseModel();
        $where_purchase['purchase_id'] = $purchase_id;
        $m_purchase = $mPurchase->where($where_purchase)->find();

        $this->purchase->startTrans();
        try {

            $ret = $m_purchase->delete();
            if(false === $ret){
                $this->purchase->rollback();
                return false;
            }

            $mPg = new NsPurchaseGoodsModel();
            $ret = $mPg->where($where_purchase)->delete();
            if(false === $ret){
                $this->purchase->rollback();
                return false;
            }


        }catch (\Exception $e){
            $this->purchase->rollback();
            return $e->getMessage();
        }
        $this->purchase->commit();

        return true;
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
        $mPurchase = new PurchaseBusiness();

        $ret = $mPurchase->batchPurchaseCreate($purchase_order_arr,$shipping_time,$memo,$uid,$user_name);

        return $ret;
    }

    /**
     * 获取采购订单列表
     * @param  integer $page_index [description]
     * @param  integer $page_size  [description]
     * @param  string  $condition  [description]
     * @param  string  $purchase   [description]
     * @return [type]              [description]
     */
    public function getPurchaseList($page_index = 1,$page_size = 0,$condition = '',$purchase = '')
    {
        $mPurchaseModel = new NsPurchaseModel();
        // 查询主表
        $purchase_list = $mPurchaseModel->pageQuery($page_index,$page_size,$condition,$purchase,'*');

        if(!empty($purchase_list['data'])){
            foreach ($purchase_list['data'] as $k => $v) {
               
                // 查询采购商品表
                $mPurchaseGoodsModel = new NsPurchaseGoodsModel();
                $purchase_goods_list = $mPurchaseGoodsModel->where('purchase_id',$v['purchase_id'])->select();
                foreach ($purchase_goods_list as $k_goods => $v_goods) {
                    $picture = new AlbumPictureModel();
                    $goods_picture = $picture->get($v_goods['goods_picture']);

                    $mGs = new NsGoodsSkuModel();
                    $goods_sku = $mGs->where('sku_id',$v_goods['sku_id'])->find();

                    $mSupplier = new NsSupplierModel();
                    $supplier = $mSupplier->where('supplier_id',$v_goods['supplier_id'])->find();
                    if (empty($goods_picture)) {
                        $goods_picture = array(
                            'pic_cover' => '',
                            'pic_cover_big' => '',
                            'pic_cover_mid' => '',
                            'pic_cover_small' => '',
                            'pic_cover_micro' => '',
                            "upload_type" => 1,
                            "domain" => ""
                        );
                    }
                    $purchase_goods_list[$k_goods]['sku_name'] = $goods_sku['sku_name'];
                    $purchase_goods_list[$k_goods]['picture'] = $goods_picture;
                    $purchase_goods_list[$k_goods]['supplier_name'] = $supplier['supplier_name'];
                }
                $purchase_list['data'][$k]['purchase_goods_list'] = $purchase_goods_list;
            }
        }

        return $purchase_list;

    }


    /**
     * 获取采购订单备注信息
     * @ERROR!!!
     * @see \data\api\IOrder::getOrderRemark()
     */
    public function getPurchaseMemo($purchase_id)
    {
        $mPurchaseModel = new NsPurchaseModel();
        $res = $mPurchaseModel->getQuery([
            'purchase_id' => $purchase_id
        ], "memo", '');
        $memo = "";
        if (! empty($res[0]['memo'])) {
            $memo = $res[0]['memo'];
        }
        return $memo;
    }


    /**
     * 添加卖家对订单的备注
     *
     * @param unknown $order_goods_id
     */
    public function addPurchaseMemo($purchase_id, $memo)
    {
        $mPurchase = new NsPurchaseModel();
        $data = array(
            'memo' => $memo
        );
        $retval = $mPurchase->save($data, [
            'purchase_id' => $purchase_id
        ]);
        return $retval;
    }

    /**
     * 采购订单审核
     * @param  [type] $purchase_id [description]
     * @return [type]              [description]
     */
    public function agreePurchaseGoods($purchase_id)
    {
        $mPurchase = new NsPurchaseModel();
        $data = array(
            'check_status' => 2
        );
        $condition['purchase_id'] = $purchase_id;
        $ret = $mPurchase->save($data,$condition);
        return $ret;
    }


    public function refusePurchaseGoods($purchase_id)
    {
        $mPurchase = new NsPurchaseModel();
        $data = array(
            'check_status' => 3
        );
        $condition['purchase_id'] = $purchase_id;
        $ret = $mPurchase->save($data,$condition);
        return $ret;
    }


    /**
     * 获取需要采购的商品
     * @param unknown $goods_ids
     */
    public function getPurchaseGoodsList($goods_ids){
        $mGoods = new NsGoodsModel();
        $goods_id_array = explode(',', $goods_ids);
        $goods_list = array();

        foreach($goods_id_array as $k => $goods_id){

            $goods_list_print = $mGoods->getQuery(["goods_id"=>$goods_id], "*", "");

            $goods_list[$k]['goods_name'] = $goods_list_print[0]['goods_name'];
            $goods_list[$k]['goods_id'] = $goods_list_print[0]['goods_id'];
        }
        return $goods_list;
    }




}