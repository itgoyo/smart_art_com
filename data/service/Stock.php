<?php

namespace data\service;

use data\api\IStock;
use data\model\NsStockModel;
use data\model\NsGoodsSkuModel;
use data\model\NsOrderGoodsModel;
use data\model\NsGoodsModel;
use data\model\NsOrderModel;
use data\model\NsPurchaseGoodsModel;
use data\model\NsPurchaseModel;
use think\Log;

class Stock extends BaseService implements IStock
{
    private $stock;
    function __construct()
    {
        parent::__construct();
        $this->stock = new NsStockModel();
    }

    public function getCostMoney($params)
    {
        $mGk = new NsGoodsSkuModel();
        $goods_skus = $mGk->where('goods_id',$params['goods_id'])->select();
        if(count($goods_skus) > 1){
            $arr = [];
            foreach ($goods_skus as &$goods_sku) {
                $arr[] = $goods_sku['stock']*$goods_sku['cost_price'];
            }
            $result = array_sum($arr);
        }else{
            $result = $goods_skus[0]['stock']*$goods_skus[0]['cost_price'];
        }
        return $result;
    }


    public function getInstockNums($params)
    {
        $mStock = new NsStockModel();
        $where['goods_id'] = $params['goods_id'];
        $mGk = new NsGoodsSkuModel();
        $goods_skus = $mGk->where('goods_id',$params['goods_id'])->select();
        if(isset($params['time'])){
            $where['time'] = $params['time'];
        }
        $where['is_instock'] = 1;
        if(count($goods_skus) > 1){
            $arr = [];
            $total = $mStock->where($where)->sum('nums');
            foreach ($goods_skus as &$goods_sku) {
                $where['sku_id'] = $goods_sku['sku_id'];
                $nums = $mStock->where($where)->sum('nums');
                $arr[] = '【'.$goods_sku['sku_name'].':'.$nums.'】';
            }
            $result = implode(',',$arr).'总计：'.$total;
        }else{
            $where['is_instock'] = 1;
            $result = $mStock->where($where)->sum('nums');

        }
        return $result;
    }

    public function getInstockMoney($params)
    {
        $mStock = new NsStockModel();
        if(isset($params['time'])){
            $where['time'] = $params['time'];
        }
        $where['goods_id'] = $params['goods_id'];
        $where['is_instock'] = 1;
        $money = $mStock->where($where)->sum('money');
        return $money;
    }

    public function getOutstockNums($params)
    {
        $mStock = new NsStockModel();
        $where['goods_id'] = $params['goods_id'];
        $mGk = new NsGoodsSkuModel();
        $goods_skus = $mGk->where('goods_id',$params['goods_id'])->select();
        if(isset($params['time'])){
            $where['time'] = $params['time'];
        }
        $where['is_instock'] = 2;
        if(count($goods_skus) > 1){
            $arr = [];
            $total = $mStock->where($where)->sum('nums');
            foreach ($goods_skus as &$goods_sku) {
                $where['sku_id'] = $goods_sku['sku_id'];
                $nums = $mStock->where($where)->sum('nums');
                $arr[] = '【'.$goods_sku['sku_name'].':'.$nums.'】';
            }
            $result = implode(',',$arr).'总计：'.$total;
        }else{
            $where['is_instock'] = 1;
            $result = $mStock->where($where)->sum('nums');

        }
        return $result;
    }

    public function getOutstockMoney($params)
    {
        $mStock = new NsStockModel();
        if(isset($params['time'])){
            $where['time'] = $params['time'];
        }
        $where['goods_id'] = $params['goods_id'];
        $where['is_instock'] = 2;
        $money = $mStock->where($where)->sum('money');
        return $money;
    }

    /**
     * 商品入库
     * @param  [type] $data [description]
     * @return [type]       [description]
     */
    public function inStock($data)
    {
        $mGoods = new NsGoodsModel();
        $where_goods['goods_id'] = $data['goods_id'];
        $goods = $mGoods->where($where_goods)->find();
        $data['goods_name'] = $goods['goods_name'];

        $this->stock->startTrans();
        try {

            $mPurchaseGoods = new NsPurchaseGoodsModel();
            if($data['purchase_goods_id']) {
                $where_pg['purchase_goods_id'] = $data['purchase_goods_id'];
                $purchase_goods = $mPurchaseGoods->where('purchase_goods_id', $data['purchase_goods_id'])->find();
                $instock_nums = $purchase_goods['num'] - $purchase_goods['in_num'];
                $data['nums'] = ($data['nums'] > $instock_nums) ? $instock_nums : $data['nums'];
            }
            $data_pg['in_num'] = $purchase_goods['in_num'] + $data['nums'];
            if ($data_pg['in_num'] >= $purchase_goods['num']) {
                $data_pg['status'] = 2;
            } else {
                $data_pg['status'] = 1;
            }
            $where['purchase_goods_id'] = $data['purchase_goods_id'];
            $mPurchaseGoods->save($data_pg, $where);

            $sum = $mPurchaseGoods->where('purchase_id', $purchase_goods['purchase_id'])->sum('status');
            $count = $mPurchaseGoods->where('purchase_id', $purchase_goods['purchase_id'])->count();
            if (2 * $count == $sum) {
                $purchase_data['status'] = 2;
                $purchase_data['finish_time'] = getTimeTurnTimeStamp($data['time']);
            } else {
                $purchase_data['status'] = 1;
            }
            $w['purchase_id'] = $purchase_goods['purchase_id'];
            $mPurchase = new NsPurchaseModel();
            $mPurchase->save($purchase_data, $w);


            $mStock = new NsStockModel();
            $ret = $mStock->allowField(true)->isUpdate(false)->save($data);
            if(false === $ret){
                $this->stock->rollback();
                return false;
            }

            $mGoodsSku = new NsGoodsSkuModel();
            if($data['sku_id']){  //商品有规格
                $where_gs['goods_id'] = $data['goods_id'];
                $where_gs['sku_id'] = $data['sku_id'];
                $goods_sku = $mGoodsSku->where($where_gs)->find();
                $data_goods_sku['stock'] = $goods_sku['stock'] + $data['nums'];
                $ret = $goods_sku->save($data_goods_sku,$where_gs);
                if(false === $ret){
                    $this->stock->rollback();
                    return false;
                }
            }else{  // 商品没有规格
                $where_gs['goods_id'] = $data['goods_id'];
                $goods_sku = $mGoodsSku->where($where_gs)->find();
                if(!empty($goods_sku)) {
                    $data_goods_sku['stock'] = $goods_sku['stock'] + $data['nums'];
                    $ret = $goods_sku->save($data_goods_sku, $where_gs);
                    if (false === $ret) {
                        $this->stock->rollback();
                        return false;
                    }
                }
            }

            $data_goods['stock'] = $goods['stock'] + $data['nums'];
            $ret = $mGoods->save($data_goods,$where_goods);
            if(false === $ret){
                $this->stock->rollback();
                return false;
            }

        }catch (\Exception $e){
            $this->stock->rollback();
            return $e->getMessage();
        }
        $this->stock->commit();

        return true;
    }

    /**
     * @param $data
     * 临时仓库商品入库
     */
    public function inTemporaryStock($data)
    {
        $mGoods = new NsGoodsModel();
        $goods = $mGoods->where('goods_id',$data['goods_id'])->find();
        $stock = $goods['stock'];

        /*if($data['nums'] > $stock){
            $data['nums'] = $stock;
        }*/
        $data['goods_name'] = $goods['goods_name'];


        $this->stock->startTrans();
        try{
            $mStock = new NsStockModel();

            // 添加一条出售仓库出库记录
            /*$data['stock_type'] = 5;
            $mStock->data([])->allowField(true)->isUpdate(false)->save($data);*/

            // 添加一条临时入库记录
            $data['type'] = 2;
            $mStock->data([])->allowField(true)->isUpdate(false)->save($data);

            // 临时仓库入库 出售仓库出库
            //$goods_data['stock'] = $goods['stock'] - $data['nums'];
            $goods_data['temporary_stock'] = $goods['temporary_stock'] + $data['nums'];
            $condition['goods_id'] = $data['goods_id'];
            $mGoods->isUpdate(true)->save($goods_data,$condition);

        }catch(\Exception $e){
            $this->stock->rollback();
            return $e->getMessage();
        }
        $this->stock->commit();

        return true;
    }

    public function deleteStock($stock_id)
    {
        $mStock = new NsStockModel();
        $stock = $mStock->where('stock_id',$stock_id)->find();

        $this->stock->startTrans();
        try{

            $stock->delete();


        }catch(\Exception $e){
            $this->stock->rollback();
            return $e->getMessage();
        }
        $this->stock->commit();

        return true;
    }

    /**
     * @param $goods_id
     * 将商品移除临时仓库
     */
    public function removeTemporary($data)
    {
        $mGoods = new NsGoodsModel();
        $goods_id = $data['goods_id'];
        $goods = $mGoods->where('goods_id',$goods_id)->find();
        $temporary_stock = $goods['temporary_stock'];
        $data['nums'] = $temporary_stock;

        $this->stock->startTrans();
        try{
            $mStock = new NsStockModel();
            // 出售仓库进行入库操作
            $data['goods_name'] = $goods['goods_name'];
            $data['stock_type'] = 3;
            $data['type'] = 1;
            $data['remark'] = '出售仓库入库，临时仓库出库';
            $mStock->data([])->allowField(true)->isUpdate(false)->save($data);

            // 临时仓库进行出库操作
            $data['stock_type'] = 5;
            $data['type'] = 2;
            $mStock->data([])->allowField(true)->isUpdate(false)->save($data);

            // 更新商品表
            $goods_data['is_temporary'] = 0;
            $goods_data['stock'] = $goods['stock'] + $temporary_stock;
            $goods_data['temporary_stock'] = 0;
            $condition['goods_id'] = $goods_id;
            $mGoods->isUpdate(true)->save($goods_data,$condition);

        }catch(\Exception $e){
            $this->stock->rollback();
            return $e->getMessage();
        }
        $this->stock->commit();

        return true;
    }


    /**
     * 商品出库
     * @param  [type] $data [description]
     * @return [type]       [description]
     */
    public function outStock($data)
    {
        $mGoods = new NsGoodsModel();
        $where_goods['goods_id'] = $data['goods_id'];
        $goods = $mGoods->where($where_goods)->find();
        $data['goods_name'] = $goods['goods_name'];
        $mGoodsSku = new NsGoodsSkuModel();
        if(!isset($data['sku_id'])){
            $m_sku = $mGoodsSku->where('goods_id',$data['goods_id'])->find();
            if(!empty($m_sku)){
                $data['sku_id'] = $m_sku['sku_id'];
            }
        }

        $this->stock->startTrans();
        try {
            $mStock = new NsStockModel();
            $ret = $mStock->allowField(true)->isUpdate(false)->save($data);
            if(false === $ret){
                $this->stock->rollback();
                return false;
            }


            if($data['sku_id']){  // 有规格商品
                $where_gs['sku_id'] = $data['sku_id'];
            }
            $where_gs['goods_id'] = $data['goods_id'];
            $goods_sku = $mGoodsSku->where($where_gs)->find();
            if($data['stock_type'] == 4) {
                $data_goods['stock'] = $goods['stock'];
                $data_goods_sku['stock'] = $goods_sku['stock'];
            }else{
                /*if ($data['nums'] >= $goods_sku['stock']) {
                    $data_goods['stock'] = $goods['stock'] - $goods_sku['stock'];
                    $data_goods_sku['stock'] = 0;
                } else {
                    $data_goods_sku['stock'] = $goods_sku['stock'] - $data['nums'];
                    $data_goods['stock'] = $goods['stock'] - $data['nums'];
                }*/
                $data_goods_sku['stock'] = $goods_sku['stock'] - $data['nums'];
                $data_goods['stock'] = $goods['stock'] - $data['nums'];
            }

            $ret = $mGoodsSku->save($data_goods_sku,$where_gs);
            if(false === $ret){
                $this->stock->rollback();
                return false;
            }

            $ret = $mGoods->save($data_goods,$where_goods);
            if(false === $ret){
                $this->stock->rollback();
                return false;
            }

        }catch (\Exception $e){
            $this->stock->rollback();
            return $e->getMessage();
        }
        $this->stock->commit();

        return true;
    }

    /**
     * @param $data
     * 临时仓库商品出库
     */
    public function outTemporaryStock($data)
    {
        $mGoods = new NsGoodsModel();
        $goods = $mGoods->where('goods_id',$data['goods_id'])->find();
        $temporary_stock = $goods['temporary_stock'];
        $data['goods_name'] = $goods['goods_name'];
        if($data['nums'] > $temporary_stock){
            $data['nums'] = $temporary_stock;
        }

        $this->stock->startTrans();
        try{
            // 添加一条商品出库记录 临时仓库出库
            $mStock = new NsStockModel();
            $data['type'] = 2;
            $mStock->data([])->allowField(true)->isUpdate(false)->save($data);

            // 临时仓库 减少临时库存
            $condition['goods_id'] = $data['goods_id'];
            $goods_data['temporary_stock'] = $temporary_stock - $data['nums'];
            $mGoods->data([])->isUpdate(true)->save($goods_data,$condition);
        }catch(\Exception $e){
            $this->stock->rollback();
            return $e->getMessage();
        }
        $this->stock->commit();
        return true;
    }

    /**
     * 商品入库列表
     * @param  integer $page_index [description]
     * @param  integer $page_size  [description]
     * @param  string  $condition  [description]
     * @param  string  $stock      [description]
     * @return [type]              [description]
     */
    public function getInStockList($page_index = 1, $page_size = 0, $condition = '', $stock = '')
    {
        $mStock = new NsStockModel();

        $inStockList = $mStock->pageQuery($page_index,$page_size,$condition,$stock,'*');

        if(!empty($inStockList['data'])){
            foreach ($inStockList['data'] as $item) {
                $mGoods = new NsGoodsModel();
                $item['goods'] = $mGoods->where('goods_id',$item['goods_id'])->find();
                if(!empty($item['goods'])) {
                    $mGs = new NsGoodsSkuModel();
                    $item['goods_sku'] = $mGs->where('sku_id', $item['sku_id'])->find();
                    $item['sku_name'] = $item['goods_sku']['sku_name'];
                    $item['goods_name'] = $item['goods']['goods_name'];
                }else{
                    $item['goods_sku'] = '已删除';
                    $item['sku_name'] = '已删除';
                    //$item['goods_name'] = '已删除';
                }
            }
        }

        $inStockList['total_nums'] = $mStock->getSum($condition,'nums');
        $inStockList['total_money'] = $mStock->getSum($condition,'money');

        return $inStockList;
    }

    /**
     * @param int $page_index
     * @param int $page_size
     * @param string $condition
     * @param string $stock
     * @return array
     * @author xusq
     * @date 2019/5/16 14:41
     * 进销存
     */
    public function getStockList($page_index = 1, $page_size = 0, $condition = '', $stock = '')
    {
        $mStock = new NsStockModel();

        $inStockList = $mStock->pageQuery($page_index,$page_size,$condition,$stock,'*');

        if(!empty($inStockList['data'])){
            foreach ($inStockList['data'] as $item) {
                $mGoods = new NsGoodsModel();
                $item['goods'] = $mGoods->where('goods_id',$item['goods_id'])->find();
                $mGs = new NsGoodsSkuModel();
                $item['goods_sku'] = $mGs->where('sku_id',$item['sku_id'])->find();
                $item['sku_name'] = $item['goods_sku']['sku_name'];
            }
        }

        $where_instock = $condition;
        $where_instock['stock_type'] = ['in',[1,2,3,18,19]];
        $inStockList['total_instock_nums'] = $mStock->getSum($where_instock,'nums');
        $inStockList['total_instock_money'] = $mStock->getSum($where_instock,'money');

        $where_outstock = $condition;
        $where_outstock['stock_type'] = ['in',[4,5,15,16,17]];
        $inStockList['total_outstock_nums'] = $mStock->getSum($where_outstock,'nums');
        $inStockList['total_outstock_money'] = $mStock->getSum($where_outstock,'money');

        $where_inorder = $condition;
        $where_inorder['stock_type'] = 1;
        $inStockList['total_inorder_nums'] = $mStock->getSum($where_inorder,'nums');
        $inStockList['total_inorder_money'] = $mStock->getSum($where_inorder,'money');

        $where_outorder = $condition;
        $where_outorder['stock_type'] = 4;
        $inStockList['total_outorder_nums'] = $mStock->getSum($where_outorder,'nums');
        $inStockList['total_outorder_money'] = $mStock->getSum($where_outorder,'money');

        return $inStockList;
    }


    /**
     * 商品出库列表
     * @param  integer $page_index [description]
     * @param  integer $page_size  [description]
     * @param  string  $condition  [description]
     * @param  string  $stock      [description]
     * @return [type]              [description]
     */
    public function getOutStockList($page_index = 1, $page_size = 0, $condition = '', $stock = '')
    {
        $mStock = new NsStockModel();

        $outStockList = $mStock->pageQuery($page_index,$page_size,$condition,$stock,'*');

        if(!empty($outStockList['data'])){
            foreach ($outStockList['data'] as $item) {
                $mGoods = new NsGoodsModel();
                $item['goods'] = $mGoods->where('goods_id',$item['goods_id'])->find();
                $mGs = new NsGoodsSkuModel();
                if($item['sku_id']) {
                    $item['goods_sku'] = $mGs->where('sku_id', $item['sku_id'])->find();
                }else{
                    $item['goods_sku'] = $mGs->where('goods_id',$item['goods_id'])->find();
                }
                $item['sku_name'] = $item['goods_sku']['sku_name'];
                $item['goods_name'] = $item['goods']['goods_name'];
            }
        }

        $outStockList['total_nums'] = $mStock->getSum($condition,'nums');
        $outStockList['total_money'] = $mStock->getSum($condition,'money');

        return $outStockList;
    }

    /**
     * 退库入库 添加一条 入库记录
     * @param [type] $order_id    [description]
     * @param [type] $storage_num [description]
     * @param [type] $isStorage   [description]
     * @param [type] $goods_id    [description]
     */
    public function addStockLog($storage_num,$goods_id,$sku_id,$order_goods_id,$uid,$user_name)
    {
        $mOrderGoods = new NsOrderGoodsModel();
        $order_goods = $mOrderGoods->where('order_goods_id', $order_goods_id)->find();

        $this->stock->startTrans();
        try {

            $mGoods = new NsGoodsModel();
            $where_goods['goods_id'] = $goods_id;
            $goods = $mGoods->where($where_goods)->find();
            $data_goods['stock'] = $goods['stock'] + $storage_num;
            $ret = $mGoods->save($data_goods,$where_goods);
            if(false === $ret){
                $this->stock->rollback();
                return false;
            }

            /*$mGoodsSku = new NsGoodsSkuModel();
            $where_gs['goods_id'] = $goods_id;
            $where_gs['sku_id'] = $sku_id;
            $goods_sku = $mGoodsSku->where($where_gs)->find();
            $data_goods_sku['stock'] = $goods_sku['stock'] + $storage_num;
            $ret = $mGoodsSku->save($data_goods_sku,$where_gs);
            if(false === $ret){
                $this->stock->rollback();
                return false;
            }*/

            $data = array(
                'goods_id' => $goods_id,
                'sku_id' => $sku_id,
                'goods_name' => $goods['goods_name'],
                'nums' => $storage_num,
                'money' => $order_goods['goods_money'],
                'time' => date('Y-m-d', time()),
                'stock_type' => 2,
                'remark' => '退货入库',
                'create_time' => time(),
                'update_time' => time(),
                'uid' => $uid,
                'user_name' => $user_name
            );

            $mStock = new NsStockModel();
            $ret = $mStock->allowField(true)->isUpdate(false)->save($data);
            if(false === $ret){
                $this->stock->rollback();
                return false;
            }

        }catch (\Exception $e){
            $this->stock->rollback();
            return $e->getMessage();
        }
        $this->stock->commit();

        return true;
    }


    /**
     * 添加订单 发货 出库记录
     * @param [type] $order_goods_id_array [description]
     */
    public function addOutStockLog($order_goods_id_array,$uid,$user_name)
    {
        $order_goods_ids = explode(',',$order_goods_id_array);
        foreach ($order_goods_ids as $order_goods_id) {
            $ret = $this->addOneOutStockLog($order_goods_id,$uid,$user_name);
        }

        return true;
    }


    protected function addOneOutStockLog($order_goods_id,$uid,$user_name)
    {
        $mStock = new NsStockModel();
        $mOrderGoods = new NsOrderGoodsModel();
        $order_goods = $mOrderGoods->where('order_goods_id',$order_goods_id)->find();
        $order_id = $order_goods['order_id'];
        $mOrder = new NsOrderModel();
        $order = $mOrder->where('order_id',$order_id)->find();

        $data = array(
            'goods_id'    => $order_goods['goods_id'],
            'is_instock'  => 2,
            'sku_id'      => $order_goods['sku_id'],
            'goods_name'  => $order_goods['goods_name'],
            'nums'        => $order_goods['num'],
            'money'       => $order_goods['goods_money'],
            'time'        => date('Y-m-d',time()),
            'stock_type'  => 4,
            'remark'      => $order['order_no'],
            'create_time' => time(),
            'update_time' => time(),
            'uid'         => $uid,
            'user_name'   => $user_name
        );

        $ret = $mStock->allowField(true)->isUpdate(false)->save($data);

        return $ret;
    }


    


}