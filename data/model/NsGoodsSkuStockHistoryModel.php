<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * File: NsGoodsSkuStockHistoryModel.php
 * Time: 17:50
 */
namespace data\model;
use data\model\BaseModel as BaseModel;

class NsGoodsSkuStockHistoryModel extends BaseModel
{
    protected $table = 'ns_goods_sku_stock_history';
    protected $rule = [
        'gsh_id'  =>  '',
    ];
    protected $msg = [
        'gsh_id'  =>  '',
    ];


    public function getPreNums($start_date,$goods_id,$sku_id)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $start_int_day = date('Ymd',strtotime($start_date));
        $where['int_day'] = ['lt',$start_int_day];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['sku_id'] = $sku_id;
        }
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            return $m_gsh['stock'];
        }
        return 0;
    }

    public function getPreMoney($start_date,$goods_id,$sku_id)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $start_int_day = date('Ymd',strtotime($start_date));
        $where['int_day'] = ['lt',$start_int_day];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['sku_id'] = $sku_id;
        }
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            return $m_gsh['money'];
        }
        return 0.00;
    }


    public function getBalanceNums($end_date,$goods_id,$sku_id)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $end_int_day = date('Ymd',strtotime($end_date));
        $where['int_day'] = ['elt',$end_int_day];
        $where['goods_id'] = $goods_id;
        if($sku_id){
            $where['sku_id'] = $sku_id;
        }
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            return $m_gsh['stock'];
        }
        return 0;
    }

    public function getBalanceMoney($end_date,$goods_id,$sku_id)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $end_int_day = date('Ymd',strtotime($end_date));
        $where['int_day'] = ['elt',$end_int_day];
        $where['goods_id'] = $goods_id;
        if($sku_id){
            $where['sku_id'] = $sku_id;
        }
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            return $m_gsh['money'];
        }
        return 0.00;
    }


    public function getTotalPreNums($start_date,$goods_id)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $start_int_day = date('Ymd',strtotime($start_date));
        $where['int_day'] = ['lt',$start_int_day];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            $where_gsh['int_day'] = $m_gsh['int_day'];
            if($goods_id) {
                $where_gsh['goods_id'] = $m_gsh['goods_id'];
            }
            $count = $mGsh->where($where_gsh)->sum('stock');
            return $count;
        }
        return 0;
    }

    public function TotalPreNums($start_date,$goods_ids)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $start_int_day = date('Ymd',strtotime($start_date));
        $where['int_day'] = ['lt',$start_int_day];
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            $where_gsh['int_day'] = $m_gsh['int_day'];
            if(!empty($goods_ids)) {
                $where_gsh['goods_id'] = ['in',$goods_ids];
            }
            $count = $mGsh->where($where_gsh)->sum('stock');
            return $count;
        }
        return 0;
    }

    public function getTotalPreMoney($start_date,$goods_id)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $start_int_day = date('Ymd',strtotime($start_date));
        $where['int_day'] = ['lt',$start_int_day];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            $where_gsh['int_day'] = $m_gsh['int_day'];
            if($goods_id) {
                $where_gsh['goods_id'] = $m_gsh['goods_id'];
            }
            $count = $mGsh->where($where_gsh)->sum('money');
            return $count;
        }
        return 0.00;
    }

    public function TotalPreMoney($start_date,$goods_ids)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $start_int_day = date('Ymd',strtotime($start_date));
        $where['int_day'] = ['lt',$start_int_day];
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            $where_gsh['int_day'] = $m_gsh['int_day'];
            if(!empty($goods_ids)) {
                $where_gsh['goods_id'] = ['in',$goods_ids];
            }
            $count = $mGsh->where($where_gsh)->sum('money');
            return $count;
        }
        return 0.00;
    }



    public function getTotalBalanceNums($end_date,$goods_id)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $end_int_day = date('Ymd',strtotime($end_date));
        $where['int_day'] = ['elt',$end_int_day];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            $where_gsh['int_day'] = $m_gsh['int_day'];
            if($goods_id) {
                $where_gsh['goods_id'] = $m_gsh['goods_id'];
            }
            $count = $mGsh->where($where_gsh)->sum('stock');
            return $count;
        }
        return 0;
    }


    public function TotalBalanceNums($end_date,$goods_ids)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $end_int_day = date('Ymd',strtotime($end_date));
        $where['int_day'] = ['elt',$end_int_day];
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            $where_gsh['int_day'] = $m_gsh['int_day'];
            if(!empty($goods_ids)) {
                $where_gsh['goods_id'] = ['in',$goods_ids];
            }
            $count = $mGsh->where($where_gsh)->sum('stock');
            return $count;
        }
        return 0;
    }

    public function getTotalBalanceMoney($end_date,$goods_id)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $end_int_day = date('Ymd',strtotime($end_date));
        $where['int_day'] = ['elt',$end_int_day];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            $where_gsh['int_day'] = $m_gsh['int_day'];
            if($goods_id) {
                $where_gsh['goods_id'] = $m_gsh['goods_id'];
            }
            $count = $mGsh->where($where_gsh)->sum('money');
            return $count;
        }
        return 0.00;
    }


    public function TotalBalanceMoney($end_date,$goods_ids)
    {
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $end_int_day = date('Ymd',strtotime($end_date));
        $where['int_day'] = ['elt',$end_int_day];
        $m_gsh = $mGsh->where($where)->order('int_day desc')->find();
        if(!empty($m_gsh)){
            $where_gsh['int_day'] = $m_gsh['int_day'];
            if(!empty($goods_ids)) {
                $where_gsh['goods_id'] = ['in',$goods_ids];
            }
            $count = $mGsh->where($where_gsh)->sum('money');
            return $count;
        }
        return 0.00;
    }


    public function getInstockNums($start_date,$end_date,$goods_id,$sku_id)
    {
        $mStock = new NsStockModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['time'] = ['between',[$start_ts,$end_ts]];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['sku_id'] = $sku_id;
        }
        $where['is_instock'] = 1;
        $count = $mStock->where($where)->sum('nums');
        return $count;
    }

    public function InstockNums($start_date,$end_date,$goods_ids)
    {
        $mStock = new NsStockModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['time'] = ['between',[$start_ts,$end_ts]];
        $where['is_instock'] = 1;
        if(!empty($goods_ids)){
            $where['goods_id'] = ['in',$goods_ids];
        }
        $count = $mStock->where($where)->sum('nums');
        return $count;
    }

    public function getInstockMoney($start_date,$end_date,$goods_id,$sku_id)
    {
        $mStock = new NsStockModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['time'] = ['between',[$start_ts,$end_ts]];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['sku_id'] = $sku_id;
        }
        $where['is_instock'] = 1;
        $count = $mStock->where($where)->sum('money');
        return $count;
    }

    public function InstockMoney($start_date,$end_date,$goods_ids)
    {
        $mStock = new NsStockModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['time'] = ['between',[$start_ts,$end_ts]];
        if(!empty($goods_ids)){
            $where['goods_id'] = ['in',$goods_ids];
        }
        $where['is_instock'] = 1;
        $count = $mStock->where($where)->sum('money');
        return $count;
    }

    public function getOutstockNums($start_date,$end_date,$goods_id,$sku_id,$type)
    {
        $mStock = new NsStockModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['time'] = ['between',[$start_ts,$end_ts]];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['sku_id'] = $sku_id;
        }
        if($type){
            $where['stock_type'] = $type;
        }
        $where['is_instock'] = 2;
        $count = $mStock->where($where)->sum('nums');
        return $count;
    }

    public function OutstockNums($start_date,$end_date,$goods_ids)
    {
        $mStock = new NsStockModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['time'] = ['between',[$start_ts,$end_ts]];
        if(!empty($goods_ids)){
            $where['goods_id'] = ['in',$goods_ids];
        }
        $where['is_instock'] = 2;
        $count = $mStock->where($where)->sum('nums');
        return $count;
    }

    public function getOutstockMoney($start_date,$end_date,$goods_id,$sku_id,$type)
    {
        $mStock = new NsStockModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['time'] = ['between',[$start_ts,$end_ts]];
        if($goods_id) {
            $where['goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['sku_id'] = $sku_id;
        }
        if($type){
            $where['stock_type'] = $type;
        }
        $where['is_instock'] = 2;
        $count = $mStock->where($where)->sum('money');
        return $count;
    }

    public function OutstockMoney($start_date,$end_date,$goods_ids)
    {
        $mStock = new NsStockModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['time'] = ['between',[$start_ts,$end_ts]];
        if(!empty($goods_ids)){
            $where['goods_id'] = ['in',$goods_ids];
        }
        $where['is_instock'] = 2;
        $count = $mStock->where($where)->sum('money');
        return $count;
    }


    public function getPurchaseNums($start_date,$end_date,$goods_id,$sku_id)
    {
        $mPurchase = new NsPurchaseModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['p.purchase_time'] = ['between',[$start_ts,$end_ts]];
        if($goods_id) {
            $where['pg.goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['pg.sku_id'] = $sku_id;
        }
        $count = $mPurchase->alias('p')->join('ns_purchase_goods pg','p.purchase_id = pg.purchase_id','left')->where($where)->sum('pg.num');
        return $count;
    }

    public function PurchaseNums($start_date,$end_date,$goods_ids)
    {
        $mPurchase = new NsPurchaseModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['p.purchase_time'] = ['between',[$start_ts,$end_ts]];
        if(!empty($goods_ids)) {
            $where['pg.goods_id'] = ['in',$goods_ids];
        }
        $count = $mPurchase->alias('p')->join('ns_purchase_goods pg','p.purchase_id = pg.purchase_id','left')->where($where)->sum('pg.num');
        return $count;
    }


    public function getPurchaseMoney($start_date,$end_date,$goods_id,$sku_id)
    {
        $mPurchase = new NsPurchaseModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['p.purchase_time'] = ['between',[$start_ts,$end_ts]];
        if($goods_id) {
            $where['pg.goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['pg.sku_id'] = $sku_id;
        }
        $count = $mPurchase->alias('p')->join('ns_purchase_goods pg','p.purchase_id = pg.purchase_id','left')->where($where)->sum('goods_money');
        return $count;
    }

    public function PurchaseMoney($start_date,$end_date,$goods_ids)
    {
        $mPurchase = new NsPurchaseModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['p.purchase_time'] = ['between',[$start_ts,$end_ts]];
        if(!empty($goods_ids)) {
            $where['pg.goods_id'] = ['in',$goods_ids];
        }
        $count = $mPurchase->alias('p')->join('ns_purchase_goods pg','p.purchase_id = pg.purchase_id','left')->where($where)->sum('goods_money');
        return $count;
    }


    public function getPurchaseTimes($start_date,$end_date,$goods_id,$sku_id)
    {
        $mPurchase = new NsPurchaseModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['p.purchase_time'] = ['between',[$start_ts,$end_ts]];
        $where['pg.goods_id'] = $goods_id;
        if($sku_id){
            $where['pg.sku_id'] = $sku_id;
        }
        $count = $mPurchase->alias('p')->join('ns_purchase_goods pg','p.purchase_id = pg.purchase_id','left')->where($where)->count();
        return $count;
    }


    public function getPurchaseDate($start_date,$end_date,$goods_id,$sku_id)
    {
        $mPurchase = new NsPurchaseModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['p.purchase_time'] = ['between',[$start_ts,$end_ts]];
        $where['pg.goods_id'] = $goods_id;
        if($sku_id){
            $where['pg.sku_id'] = $sku_id;
        }
        $dates_arr = $mPurchase->alias('p')->join('ns_purchase_goods pg','p.purchase_id = pg.purchase_id','left')->where($where)->column('p.purchase_time');
        $dates = [];
        foreach ($dates_arr as $k => $date){
            $dates[$k] = date('Y-m-d',$date);
        }
        $date_string = implode(',',$dates);
        return $date_string;
    }



    public function getSaleNums($start_date,$end_date,$goods_id,$sku_id)
    {
        $mOg = new NsOrderGoodsModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['o.create_time'] = ['between',[$start_ts,$end_ts]];
        $where['o.order_status'] = ['neq',5];
        if($goods_id) {
            $where['og.goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['og.sku_id'] = $sku_id;
        }
        $count = $mOg->alias('og')->join('ns_order o','og.order_id = o.order_id','left')->where($where)->sum('og.num');
        return $count;
    }

    public function SaleNums($start_date,$end_date,$goods_ids)
    {
        $mOg = new NsOrderGoodsModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['o.create_time'] = ['between',[$start_ts,$end_ts]];
        $where['o.order_status'] = ['neq',5];
        if(!empty($goods_ids)) {
            $where['og.goods_id'] = ['in',$goods_ids];
        }
        $count = $mOg->alias('og')->join('ns_order o','og.order_id = o.order_id','left')->where($where)->sum('og.num');
        return $count;
    }


    public function getSaleMoney($start_date,$end_date,$goods_id,$sku_id)
    {
        $mOg = new NsOrderGoodsModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['o.create_time'] = ['between',[$start_ts,$end_ts]];
        $where['o.order_status'] = ['neq',5];
        if($goods_id) {
            $where['og.goods_id'] = $goods_id;
        }
        if($sku_id){
            $where['og.sku_id'] = $sku_id;
        }
        $count = $mOg->alias('og')->join('ns_order o','og.order_id = o.order_id','left')->where($where)->sum('og.goods_money');
        return $count;
    }

    public function getMaoMoney($sale_nums,$sale_money,$sku_id)
    {
        $m_gk = NsGoodsSkuModel::get($sku_id);
        $cost_price = $m_gk['cost_price'];
        $mao_money = $sale_money - ($sale_nums * $cost_price);
        return $mao_money;
    }



    public function SaleMoney($start_date,$end_date,$goods_ids)
    {
        $mOg = new NsOrderGoodsModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['o.create_time'] = ['between',[$start_ts,$end_ts]];
        $where['o.order_status'] = ['neq',5];
        if(!empty($goods_ids)) {
            $where['og.goods_id'] = ['in',$goods_ids];
        }
        $count = $mOg->alias('og')->join('ns_order o','og.order_id = o.order_id','left')->where($where)->sum('og.goods_money');
        return $count;
    }


    public function CostMoney($start_date,$end_date,$goods_ids)
    {
        $mOg = new NsOrderGoodsModel();
        $start_ts = strtotime($start_date);
        $end_ts = strtotime($end_date);
        $where['o.create_time'] = ['between',[$start_ts,$end_ts]];
        $where['o.order_status'] = ['neq',5];
        if(!empty($goods_ids)) {
            $where['og.goods_id'] = ['in',$goods_ids];
        }
        $order_goods_list = $mOg->alias('og')->join('ns_order o','og.order_id = o.order_id','left')->where($where)->field('og.*')->select();
        $total_cost_money = 0;
        if(!empty($order_goods_list)){
            foreach ($order_goods_list as $order_goods) {
                $cost_money = $order_goods['cost_price'] * $order_goods['num'];
                $total_cost_money += $cost_money;
            }
        }
        return $total_cost_money;
    }



}