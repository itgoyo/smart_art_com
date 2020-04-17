<?php
/**
 * Events.php
 *
 * Niushop商城系统 - 团队十年电商经验汇集巨献!
 * =========================================================
 * Copy right 2015-2025 山西牛酷信息科技有限公司, 保留所有权利。
 * ----------------------------------------------
 * 官方网址: http://www.niushop.com.cn
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用。
 * 任何企业和个人不允许对程序代码以任何形式任何目的再发布。
 * =========================================================
 * @author : niuteam
 * @date : 2015.1.17
 * @version : v1.0.0.0
 */
namespace data\service;
use data\api\IEvents;
use data\model\NsGoodsSkuStockHistoryModel;
use data\model\NsMemberLevelModel;
use data\model\NsMemberModel;
use data\model\NsMemberRechargeModel;
use data\model\NsPromotionMansongModel;
use data\service\Order;
use data\model\NsOrderModel;
use data\model\NsPromotionMansongGoodsModel;
use data\model\NsPromotionDiscountModel;
use data\model\NsPromotionDiscountGoodsModel;
use data\model\NsGoodsSkuModel;
use data\model\NsGoodsModel;
use data\model\NsCouponModel;
use data\model\NsCouponGoodsModel;
use think\Log;
/**
 * 计划任务
 */
class Events implements IEvents{
    /**
     * (non-PHPdoc)
     * @see \data\api\IEvents::giftClose()
     */
    public function giftClose(){
        
    }
    /**
     * (non-PHPdoc)
     * @see \data\api\IEvents::mansongClose()
     */
    public function mansongOperation(){
        $mansong = new NsPromotionMansongModel();
        $mansong->startTrans();
        try{
            $time = time();
            $condition_close = array(
                'end_time' => array('LT', $time),
                'status'   => array('NEQ', 3)
            );
            $condition_start = array(
                'start_time' => array('ELT', $time),
                'status'   => 0
            );
            $mansong->save(['status' => 4], $condition_close);
            $mansong->save(['status' => 1], $condition_start);
            $mansong_goods = new NsPromotionMansongGoodsModel();
            $mansong_goods->save(['status' => 4], $condition_close);
            $mansong_goods->save(['status' => 1], $condition_start);
            $mansong->commit();
            return 1;
        }catch (\Exception $e)
        {
            $mansong->rollback();
            return $e->getMessage();
        }
       
    }
    /**
     * (non-PHPdoc)
     * @see \data\api\IEvents::ordersClose()
     */
    public function ordersClose(){
        $order_model = new NsOrderModel();
       
        try{
            $config = new Config();
            $config_info = $config->getConfig(0, 'ORDER_BUY_CLOSE_TIME');
            if(!empty($config_info['value']))
            {
                $close_time = $config_info['value'];
            }else{
                $close_time = 60;//默认1小时
            }
            $time = time()-$close_time*60;//订单自动关闭
            $condition = array(
                'order_status' => 0,
                'create_time'  => array('LT', $time),
                'payment_type' => array('neq', 6)
            );
            $order_list = $order_model->getQuery($condition, 'order_id', '');
            if(!empty($order_list))
            {
                $order = new Order();
                foreach ($order_list as $k => $v)
                {
                    if(!empty($v['order_id']))
                    {
                        $order->orderClose($v['order_id']);
                    }
                   
                }
                    
            }
            return 1;
        }catch (\Exception $e)
        {
            return $e->getMessage();
        }
        
    }
    /**
     * (non-PHPdoc)
     * @see \data\api\IEvents::ordersComplete()
     */
    public function ordersComplete(){
        $order_model = new NsOrderModel();
        try{
            
            $config = new Config();
            $config_info = $config->getConfig(0, 'ORDER_DELIVERY_COMPLETE_TIME');
            if($config_info['value'] != '')
            {
                $complete_time = $config_info['value'];
            }else{
                $complete_time = 7;//7天
            }
            $time = time()-3600*24*$complete_time;//订单自动完成

            $condition = array(
                'order_status' => 3,
                'sign_time'  => array('LT', $time)
            );
            $order_list = $order_model->getQuery($condition, 'order_id', '');
            if(!empty($order_list))
            {
                $order = new Order();
                foreach ($order_list as $k => $v)
                {
                    if(!empty($v['order_id']))
                    {
                        $order->orderComplete($v['order_id']);
                    }
                    
                }
        
            }
     
            return 1;
        }catch (\Exception $e)
        {
            return $e->getMessage();
        }
    }
    /**
     * (non-PHPdoc)
     * @see \data\api\IEvents::discountOperation()
     */
    public function discountOperation(){
        $discount = new NsPromotionDiscountModel();
        $discount->startTrans();
        try{
            $time = time();
            $discount_goods = new NsPromotionDiscountGoodsModel();
            /************************************************************结束活动**************************************************************/
            $condition_close = array(
                'end_time' => array('LT', $time),
                'status'   => array('NEQ', 3)
            );
             $discount->save(['status' => 4], $condition_close);
             $discount_close_goods_list = $discount_goods->getQuery($condition_close, '*', '');
             if(!empty($discount_close_goods_list))
             {
                 foreach ( $discount_close_goods_list as $k => $discount_goods_item)
                 {
                     $goods = new NsGoodsModel();
             
                     $data_goods = array(
                         'promotion_type' => 2,
                         'promote_id'     => $discount_goods_item['discount_id']
                     );
                     $goods_id_list = $goods->getQuery($data_goods, 'goods_id', '');
                     if(!empty($goods_id_list))
                     {
                         foreach($goods_id_list as $k => $goods_id)
                         {
                             $goods_info = $goods->getInfo(['goods_id' => $goods_id['goods_id']], 'promotion_type,price');
                             $goods->save(['promotion_price' => $goods_info['price']], ['goods_id'=> $goods_id['goods_id'] ]);
                             $goods_sku = new NsGoodsSkuModel();
                             $goods_sku_list = $goods_sku->getQuery(['goods_id'=> $goods_id['goods_id'] ], 'price,sku_id', '');
                             foreach ($goods_sku_list as $k_sku => $sku)
                             {
                                 $goods_sku = new NsGoodsSkuModel();
                                 $data_goods_sku = array(
                                     'promote_price' => $sku['price']
                                 );
                                 $goods_sku->save($data_goods_sku, ['sku_id' => $sku['sku_id']]);
                             }
                             
                         }
                        
                     }
                     $goods->save(['promotion_type' => 0, 'promote_id' => 0], $data_goods);
                    
                 }
             }
             $discount_goods->save(['status' => 4], $condition_close);
             /************************************************************结束活动**************************************************************/
             /************************************************************开始活动**************************************************************/
            $condition_start = array(
                'start_time' => array('ELT', $time),
                'status'   => 0
            );
            //查询待开始活动列表
            $discount_goods_list = $discount_goods->getQuery($condition_start, '*', '');
            if(!empty($discount_goods_list))
            {
                foreach ( $discount_goods_list as $k => $discount_goods_item)
                {
                    $goods = new NsGoodsModel();
                    $goods_info = $goods->getInfo(['goods_id' => $discount_goods_item['goods_id']],'promotion_type,price');
                    $data_goods = array(
                        'promotion_type' => 2,
                        'promote_id'     => $discount_goods_item['discount_id'],
                        'promotion_price'  => $goods_info['price'] *$discount_goods_item['discount']/10 
                    );
                    $goods->save($data_goods,['goods_id' => $discount_goods_item['goods_id']]);
                    $goods_sku = new NsGoodsSkuModel();
                    $goods_sku_list = $goods_sku->getQuery(['goods_id'=> $discount_goods_item['goods_id'] ], 'price,sku_id', '');
                    foreach ($goods_sku_list as $k_sku => $sku)
                    {
                        $goods_sku = new NsGoodsSkuModel();
                        $data_goods_sku = array(
                            'promote_price' => $sku['price']*$discount_goods_item['discount']/10
                        );
                        $goods_sku->save($data_goods_sku, ['sku_id' => $sku['sku_id']]);
                    }
                }
            }
            $discount_goods->save(['status' => 1], $condition_start);
            $discount->save(['status' => 1], $condition_start);
            /************************************************************开始活动**************************************************************/
            $discount->commit();
            return 1;
        }catch (\Exception $e)
        {
            $discount->rollback();
            return $e;
        }
    }


    public function autoWriteGoodsStock()
    {
        $mGk = new NsGoodsSkuModel();
        $mGsh = new NsGoodsSkuStockHistoryModel();
        $time = time();
        $goods_skus = $mGk->select();
        foreach ($goods_skus as $goods_sku) {
            $data['goods_id'] = $goods_sku['goods_id'];
            $data['sku_id'] = $goods_sku['sku_id'];
            $data['int_day'] = date('Ymd',$time);
            $data['create_date'] = time();
            $data['update_date'] = time();
            $data['stock'] = $goods_sku['stock'];
            $data['money'] = $goods_sku['cost_price'] != 0 ? $goods_sku['cost_price'] * $goods_sku['stock'] : $goods_sku['promote_price'] * $goods_sku['stock'];

            $where['sku_id'] = $goods_sku['sku_id'];
            $where['int_day'] = date('Ymd',$time);
            $exist = $mGsh->where($where)->find();
            if(empty($exist)){
                $ret = $mGsh->data([])->isUpdate(false)->save($data);
            }else{
                $where_gsh['gsh_id'] = $exist['gsh_id'];
                $ret = $mGsh->data([])->isUpdate(true)->save($data,$where_gsh);
            }
        }
        return true;
    }


    public function changeMemberLevel()
    {
        $mMember = new NsMemberModel();
        $where['u.is_system'] = 0;
        $where['u.instance_id'] = 0;
        $member_list = $mMember->alias('m')->join('sys_user u','m.uid = u.uid','left')->where($where)->select();
        foreach ($member_list as $member) {
            $uid = $member['uid'];
             $this->updateMemberLevel($uid);
        }
        return true;
    }


    public function updateMemberLevel($uid)
    {
        $mMr = new NsMemberRechargeModel();
        $where_mr['uid'] = $uid;
        $where_mr['is_pay'] = 1;
        $where_mr['status'] = 1;
        $recharge_money = $mMr->where($where_mr)->sum('recharge_money');  // 累计充值
        $mOrder = new NsOrderModel();
        $where_order['pay_status'] = 2;
        $where_order['buyer_id'] = $uid;
        $order_money = $mOrder->where($where_order)->sum('order_money');
        $refund_money = $mOrder->where($where_order)->sum('refund_money');
        $consume_money = $order_money - $refund_money;    // 累计消费

        $mMl = new NsMemberLevelModel();
        // 仅满足充值
        $where_int['upgrade'] = 1;
        $where_int['min_integral'] = ['elt',$recharge_money];
        $int_level = $mMl->where($where_int)->order('level_id desc')->find();
        $int_level_id = 0;
        if(!empty($int_level)){
            $int_level_id = $int_level['level_id'];
        }
        // 仅满足消费
        $where_quo['upgrade'] = 2;
        $where_quo['quota'] = ['elt',$consume_money];
        $quo_level_id = 0;
        $quo_level = $mMl->where($where_quo)->order('level_id desc')->find();
        if(!empty($quo_level)){
            $quo_level_id = $quo_level['level_id'];
        }
        // 满足其中一个
        $where_or = "(upgrade = 3 and relation = 1 and min_integral <= {$recharge_money} ) or";
        $where_or .= " (upgrade = 3 and relation = 1 and min_integral <= {$consume_money} )";
        $or_level = $mMl->where($where_or)->order('level_id desc')->find();
        $or_level_id = 0;
        if(!empty($or_level)){
            $or_level_id = $or_level['level_id'];
        }
        // 两个都要满足
        $where_and['upgrade'] = 3;
        $where_and['relation'] = 2;
        $where_and['min_integral'] = ['elt',$recharge_money];
        $where_and['quota'] = ['elt',$consume_money];
        $and_level = $mMl->where($where_or)->order('level_id desc')->find();
        $and_level_id = 0;
        if(!empty($and_level)){
            $and_level_id = $and_level['level_id'];
        }

        $level_ids = [$int_level_id,$quo_level_id,$or_level_id,$and_level_id];
        $max_level_id = max($level_ids);
        if($max_level_id){
            $m_member = NsMemberModel::get($uid);
            $m_member['member_level'] = $max_level_id;
            $m_member->save();
        }
        return true;
    }




    /**
     * (non-PHPdoc)
     * @see \data\api\IEvents::autoDeilvery()
     */
    public function autoDeilvery(){
        $order_model = new NsOrderModel();

        try{
        
            $config = new Config();
            $config_info = $config->getConfig(0, 'ORDER_AUTO_DELIVERY');
            if(!empty($config_info['value']))
            {
                $delivery_time = $config_info['value'];
            }else{
                $delivery_time = 7;//默认7天自动收货
            }
            $time = time()-3600*24*$delivery_time;//订单自动完成
        
            $condition = array(
                'order_status' => 2,
                'consign_time'  => array('LT', $time)
            );
            $order_list = $order_model->getQuery($condition, 'order_id', '');
             if(!empty($order_list))
            {
                $order = new \data\service\Order\Order();
                foreach ($order_list as $k => $v)
                {
                    if(!empty($v['order_id']))
                    {
                        $order->orderAutoDelivery($v['order_id']);
                    }
                    
                }
        
            } 

            return 1;
        }catch (\Exception $e)
        {
            return $e->getMessage();
        }
    }
    
    /**
     * 优惠券自动过期
     * {@inheritDoc}
     * @see \data\api\IEvents::autoCoupon()
     */
    public function autoCouponClose(){
        $ns_coupon_model = new NsCouponModel();
        $ns_coupon_model->startTrans();
        try{
            $condition['end_time'] = array('LT',time());
            $condition['state'] = array('NEQ',2);//排成已使用的优惠券
            $count = $ns_coupon_model->getCount($condition);
            $res = -1;
            if($count){
                $res = $ns_coupon_model->save(['state'=>3],$condition);
            }
            $ns_coupon_model->commit();
            return $res;
        }catch (\Exception $e)
        {
            $ns_coupon_model->rollback();
            return $e->getMessage();
        }
    }
    
}
