<?php
namespace app\admin\controller;
use data\model\NsGoodsModel;
use data\model\NsPurchaseGoodsModel;
use data\service\Address;
use data\service\Album;
use data\service\Express as Express;
use data\service\Goods as GoodsService;
use data\service\GoodsBrand as GoodsBrand;
use data\service\GoodsCategory as GoodsCategory;
use data\service\GoodsGroup as GoodsGroup;
use data\service\Stock;
use data\service\Supplier;
use data\service\Order;
use data\service\Purchase;
use Qiniu\json_decode;
use think\Config;
/**
 * 商品控制器
 */
class Purchases extends BaseController
{
    public function __construct()
    {
        parent::__construct();
    }

    
    /**
     * 商品列表
     */
    public function goodsList()
    {
        if (request()->isAjax()) {
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
            $end_date = request()->post('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');
            $purchase_no = request()->post('purchase_no','');
            $status = request()->post('status','');
            $goods_name = request()->post('goods_name','');
            $condition = [];
            // $condition['check_status'] = 2;
            if($start_date != 0 && $end_date != 0){
                $condition['purchase_time'] = ['between',[$start_date,$end_date]];
            }elseif($start_date != 0 && $end_date == 0){
                $condition['purchase_time'] = ['gt',$start_date];
            }elseif($start_date == 0 && $end_date != 0){
                $condition['purchase_time'] = ['lt',$end_date];
            }
            if(!empty($purchase_no)){
                $condition['purchase_no'] = ['like','%'.$purchase_no.'%'];
            }

            if((!empty($status) || $status == 0) && $status != ''){
                $condition['status'] = $status;
            }
            if(!empty($goods_name)){
                $where['goods_name'] = ['like','%'.$goods_name.'%'];
                $mPg = new NsPurchaseGoodsModel();
                $purchase_ids = $mPg->where($where)->column('purchase_id');
                $condition['purchase_id'] = ['in',$purchase_ids];
            }
            
            $mPurchase = new Purchase();

            $list = $mPurchase->getPurchaseList($page_index,$page_size,$condition,'purchase_time desc');

            return $list;

        }else{
            return view($this->style . "Purchase/goodsList");
        }
    }

    /**
     * 采购列表
     * @return [type] [description]
     */
    public function purchaseList()
    {
    	if (request()->isAjax()) {
    		$page_index = request()->post('page_index',1);
    		$page_size = request()->post('page_size',PAGESIZE);
    		$start_date = request()->post('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
    		$end_date = request()->post('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');
    		$purchase_no = request()->post('purchase_no','');
    		$goods_name = request()->post('goods_name','');
    		$status = request()->post('status','');
    		// $condition = [];
            $condition['check_status'] = 2;
    		if($start_date != 0 && $end_date != 0){
    			$condition['purchase_time'] = ['between',[$start_date,$end_date]];
    		}elseif($start_date != 0 && $end_date == 0){
    			$condition['purchase_time'] = ['gt',$start_date];
    		}elseif($start_date == 0 && $end_date != 0){
    			$condition['purchase_time'] = ['lt',$end_date];
    		}
    		if(!empty($purchase_no)){
    			$condition['purchase_no'] = ['like','%'.$purchase_no.'%'];
    		}
    		if(!empty($goods_name)){
    		    $mGoods = new NsGoodsModel();
    		    $where['goods_name'] = ['like','%'.$goods_name.'%'];
    		    $goods_ids = $mGoods->where($where)->column('goods_id');
    		    $mPg = new NsPurchaseGoodsModel();
    		    $purchase_ids = $mPg->where('goods_id','in',$goods_ids)->column('purchase_id');
    		    $condition['purchase_id'] = ['in',$purchase_ids];
            }

            if((!empty($status) || $status == 0) && $status != ''){
                $condition['status'] = $status;
            }

    		
    		$mPurchase = new Purchase();

    		$list = $mPurchase->getPurchaseList($page_index,$page_size,$condition,'purchase_time desc');

    		return $list;

    	}else{
    		$status = request()->get('status','');
    		$this->assign('status',$status);
    		$child_menu_list = array(
                array(
                    'url' => 'Purchases/purchaseList',
                    'menu_name' => '全部',
                    "active" => $status == '' ? 1 : 0
                ),
                array(
                    'url' => 'Purchases/purchaseList?status=0',
                    'menu_name' => '待入库',
                    "active" => ($status == 0 && $status != '') ? 1 : 0
                ),
                array(
                    'url' => 'Purchases/purchaseList?status=1',
                    'menu_name' => '部分入库',
                    "active" => $status == 1 ? 1 : 0
                ),
                array(
                    'url' => 'Purchases/purchaseList?status=2',
                    'menu_name' => '全部入库',
                    "active" => $status == 2 ? 1 : 0
                ),
    		);
    		$this->assign('child_menu_list', $child_menu_list);
    		return view($this->style . "Purchase/purchaseList");
    	}
    }


    public function deletePurchase()
    {
        $purchase_id = request()->post('purchase_id');
        $mPurcse = new Purchase();
        $retval = $mPurcse->deletePurchase($purchase_id);
        return $retval;
    }


    /**
     * 采购审核
     * @return [type] [description]
     */
    public function checkout()
    {
        if (request()->isAjax()) {
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
            $end_date = request()->post('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');
            $purchase_no = request()->post('purchase_no','');
            $status = request()->post('status','');
            // $condition = [];
            $condition['check_status'] = 2;
            if($start_date != 0 && $end_date != 0){
                $condition['purchase_time'] = ['between',[$start_date,$end_date]];
            }elseif($start_date != 0 && $end_date == 0){
                $condition['purchase_time'] = ['gt',$start_date];
            }elseif($start_date == 0 && $end_date != 0){
                $condition['purchase_time'] = ['lt',$end_date];
            }
            if(!empty($purchase_no)){
                $condition['purchase_no'] = ['like','%'.$purchase_no.'%'];
            }

            if((!empty($status) || $status == 0) && $status != ''){
                $condition['status'] = $status;
            }


            $mPurchase = new Purchase();

            $list = $mPurchase->getPurchaseList($page_index,$page_size,$condition,'purchase_time desc');

            return $list;

        }else{
            $status = request()->get('status','');
            $this->assign('status',$status);
            $child_menu_list = array(
                array(
                    'url' => 'Purchases/checkout',
                    'menu_name' => '全部',
                    "active" => $status == '' ? 1 : 0
                ),
                array(
                    'url' => 'Purchases/checkout?status=0',
                    'menu_name' => '待入库',
                    "active" => ($status == 0 && $status != '') ? 1 : 0
                ),
                array(
                    'url' => 'Purchases/checkout?status=1',
                    'menu_name' => '部分入库',
                    "active" => $status == 1 ? 1 : 0
                ),
                array(
                    'url' => 'Purchases/checkout?status=2',
                    'menu_name' => '全部入库',
                    "active" => $status == 2 ? 1 : 0
                ),
            );
            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Purchase/checkout");
        }
    }


    /**
     * 采购商品
     * @return [type] [description]
     */
    public function purchaseGoods()
    {
    	$mPurchase = new Purchase();

    	$goods_id = request()->post('goods_id','');
    	$sku_id = request()->post('sku_id','');
    	$num = request()->post('num','');
    	$price = request()->post('price','');
    	$supplier_id = request()->post('supplier_id','');
    	$shipping_time = getTimeTurnTimeStamp(request()->post('shipping_time'));
    	$memo = request()->post('memo','');

    	$user_info = $this->user->getUserInfo();
    	$uid = $user_info['uid'];
    	$user_name = $user_info['user_name'];

    	$purchase_id = $mPurchase->purchaseCreate($goods_id,$sku_id,$num,$price,$supplier_id,$shipping_time,$memo,$uid,$user_name);

        return $purchase_id;
    }

    /**
     * 修改备注
     */
    public function addMemo()
    {
        $mPurchase = new Purchase();
        $purchase_id = request()->post('purchase_id');
        $memo = request()->post('memo');
        $result = $mPurchase->addPurchaseMemo($purchase_id, $memo);
        return AjaxReturn($result);
    }

    /**
     * 采购订单审核
     * @return [type] [description]
     */
    public function agreePurchaseGoods()
    {
        $mPurchase = new Purchase();
        $purchase_id = request()->post('purchase_id');
        $res = $mPurchase->agreePurchaseGoods($purchase_id);
        return AjaxReturn($res);
    }

    public function refusePurchaseGoods()
    {
        $mPurchase = new Purchase();
        $purchase_id = request()->post('purchase_id');
        $res = $mPurchase->refusePurchaseGoods($purchase_id);
        return AjaxReturn($res);
    }

    /**
     * 获取采购订单备注信息
     * @return unknown
     */
    public function getPurchaseMemo()
    {
        $mPurchase = new Purchase();
        $purchase_id = request()->post('purchase_id');
        $res = $mPurchase->getPurchaseMemo($purchase_id);
        return $res;
    }


    /**
     * 获取需要采购的商品
     */
    public function getPurchaseGoodsList(){
        $goods_ids = request()->post("goods_ids","");
        $mPurchase = new Purchase();
        $list = $mPurchase->getPurchaseGoodsList($goods_ids);
        return $list;
    }

    /**
     * 批量采购
     * @return [type] [description]
     */
    public function batchPurchaseGoods()
    {
    	$purchase_order_arr = request()->post('purchase_order_arr','');
    	$purchase_order_arr = json_decode($purchase_order_arr,true);
    	$shipping_time = request()->post('shipping_time') == '' ? 0 : getTimeTurnTimeStamp(request()->post('shipping_time'));
    	$memo = request()->post('memo','');
        
    	$user_info = $this->user->getUserInfo();
    	$uid = $user_info['uid'];
    	$user_name = $user_info['user_name'];

    	$mPurchase = new Purchase();

    	$purchase_id = $mPurchase->batchPurchaseCreate($purchase_order_arr,$shipping_time,$memo,$uid,$user_name);

        return $purchase_id;
    }

    /**
     * 采购订单导出
     * @return [type] [description]
     */
    public function purchaseDataExcel()
    {
    	$xlsName = "采购单";
    	$xlsCell = [
            ['purchase_no','采购单号'],
            ['purchase_time','采购时间'],
            ['shipping_time','预计到货时间'], 
            ['status','订单状态'],
            //['amount','订单金额'],
            ['user_name','采购人'],
            ['goods_info','商品信息']
    	];

    	$start_date = request()->get('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('start_date').' 00:00:00');
    	$end_date = request()->get('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('end_date'). '23:59:59');
    	$purchase_no = request()->get('purchase_no','');
    	$status = request()->get('status','');
    	$goods_name = request()->get('goods_name','');
        $condition = [];
        $condition['check_status'] = 2;
    	if($start_date != 0 && $end_date != 0){
    		$condition['purchase_time'] = ['between',[$start_date,$end_date]];
    	}elseif($start_date != 0 && $end_date == 0){
    		$condition['purchase_time'] = ['gt',$start_date];
    	}elseif($start_date == 0 && $end_date != 0){
    		$condition['purchase_time'] = ['lt',$end_date];
    	}
    	if(!empty($purchase_no)){
    		$condition['purchase_no'] = ['like','%'.$purchase_no.'%'];
    	}
    	if(in_array($status,[0,1,2]) && $status != ''){
			$condition['status'] = $status;
		}
        if(!empty($goods_name)){
            $where['goods_name'] = ['like','%'.$goods_name.'%'];
            $mPg = new NsPurchaseGoodsModel();
            $purchase_ids = $mPg->where($where)->column('purchase_id');
            $condition['purchase_id'] = ['in',$purchase_ids];
        }

		$mPurchase = new Purchase();
		$list = $mPurchase->getPurchaseList(1,0,$condition,'purchase_time desc');

		foreach ($list['data'] as $item) {
			$item['purchase_no'] = $item['purchase_no'].' ';
			$item['purchase_time'] = getTimeStampTurnTime($item['purchase_time']);
			$item['shipping_time'] = getTimeStampTurnTime($item['shipping_time']);
			if($item['status'] == 0){
				$item['status'] = '待入库';
			}elseif($item['status'] == 1){
				$item['status'] = '部分入库';
			}elseif($item['status'] == 2){
				$item['status'] = '全部入库';
			}
			$goods_info = '';
			foreach ($item['purchase_goods_list'] as $k => $v) {
				if($v['status'] == 0){
					$v['status'] = '待入库';
				}elseif($v['status'] == 1){
					$v['status'] = '部分入库';
				}elseif($v['status'] == 2){
					$v['status'] = '全部入库';
				}
				$goods_info .= '商品名称：'.$v['goods_name'].' 数量：'.$v['num'].' 供应商：'.$v['supplier_name'].' 入库状态：'.$v['status'].';';
			}
			$item['goods_info'] = $goods_info;
		}

		dataExcel($xlsName, $xlsCell, $list['data']);

    }

    /**
     * 采购订单导出
     * @return [type] [description]
     */
    public function purchaseCheckDataExcel()
    {
        $xlsName = "采购单";
        $xlsCell = [
            ['purchase_no','采购单号'],
            ['purchase_time','采购时间'],
            ['shipping_time','预计到货时间'],
            ['status','订单状态'],
            ['amount','订单金额'],
            ['user_name','采购人'],
            ['goods_info','商品信息']
        ];

        $start_date = request()->get('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('start_date').' 00:00:00');
        $end_date = request()->get('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('end_date'). '23:59:59');
        $purchase_no = request()->get('purchase_no','');
        $status = request()->get('status','');
        $condition = [];
        $condition['check_status'] = 2;
        if($start_date != 0 && $end_date != 0){
            $condition['purchase_time'] = ['between',[$start_date,$end_date]];
        }elseif($start_date != 0 && $end_date == 0){
            $condition['purchase_time'] = ['gt',$start_date];
        }elseif($start_date == 0 && $end_date != 0){
            $condition['purchase_time'] = ['lt',$end_date];
        }
        if(!empty($purchase_no)){
            $condition['purchase_no'] = ['like','%'.$purchase_no.'%'];
        }
        if(in_array($status,[0,1,2]) && $status != ''){
            $condition['status'] = $status;
        }

        $mPurchase = new Purchase();
        $list = $mPurchase->getPurchaseList(1,0,$condition,'purchase_time desc');

        foreach ($list['data'] as $item) {
            $item['purchase_no'] = $item['purchase_no'].' ';
            $item['purchase_time'] = getTimeStampTurnTime($item['purchase_time']);
            $item['shipping_time'] = getTimeStampTurnTime($item['shipping_time']);
            if($item['status'] == 0){
                $item['status'] = '待入库';
            }elseif($item['status'] == 1){
                $item['status'] = '部分入库';
            }elseif($item['status'] == 2){
                $item['status'] = '全部入库';
            }
            $goods_info = '';
            foreach ($item['purchase_goods_list'] as $k => $v) {
                if($v['status'] == 0){
                    $v['status'] = '待入库';
                }elseif($v['status'] == 1){
                    $v['status'] = '部分入库';
                }elseif($v['status'] == 2){
                    $v['status'] = '全部入库';
                }
                $goods_info .= '商品名称：'.$v['goods_name'].' 数量：'.$v['num'].'单价：'.$v['price'].' 供应商：'.$v['supplier_name'].' 入库状态：'.$v['status'].';';
            }
            $item['goods_info'] = $goods_info;
        }

        dataExcel($xlsName, $xlsCell, $list['data']);

    }




    





}