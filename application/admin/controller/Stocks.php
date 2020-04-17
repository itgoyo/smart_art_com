<?php
namespace app\admin\controller;
use data\model\NsGoodsModel;
use data\model\NsGoodsSkuModel;
use data\model\NsGoodsSkuStockHistoryModel;
use data\service\Address;
use data\service\Album;
use data\service\Express as ExpressService;
use data\service\Goods as GoodsService;
use data\service\GoodsBrand as GoodsBrand;
use data\service\GoodsCategory as GoodsCategory;
use data\service\GoodsGroup as GoodsGroup;
use data\service\Stock;
use data\service\Supplier;
use data\service\Order;
use data\service\Type;
use Qiniu\json_decode;
use data\model\NsTypeModel;
use think\Config;
/**
 * 商品控制器
 */
class Stocks extends BaseController
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
        $goodservice = new GoodsService();
        if (request()->isAjax()) {
            $page_index = request()->post("page_index", 1);
            $page_size = request()->post("page_size", PAGESIZE);
            $start_date = request()->post('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('start_date'));
            $end_date = request()->post('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('end_date'));
            $goods_name = request()->post('goods_name', '');
            $goods_code = request()->post('code', '');
            $state = request()->post('state', 1);
            $category_id_1 = request()->post('category_id_1', '');
            $category_id_2 = request()->post('category_id_2', '');
            $category_id_3 = request()->post('category_id_3', '');
            $selectGoodsLabelId = request()->post('selectGoodsLabelId', '');
            $supplier_id = request()->post('supplier_id', '');
            //$is_temporary = request()->post('is_temporary', 0);
            if (! empty($selectGoodsLabelId)) {
                $selectGoodsLabelIdArray = explode(',', $selectGoodsLabelId);
                $selectGoodsLabelIdArray = array_filter($selectGoodsLabelIdArray);
                $str = "FIND_IN_SET(" . $selectGoodsLabelIdArray[0] . ",ng.group_id_array)";
                for ($i = 1; $i < count($selectGoodsLabelIdArray); $i ++) {
                    $str .= "AND FIND_IN_SET(" . $selectGoodsLabelIdArray[$i] . ",ng.group_id_array)";
                }
                $condition[""] = [["EXP", $str]];
            }
            $condition["ng.is_temporary"] = 0;
            if ($start_date != 0 && $end_date != 0) {
                $condition["ng.create_time"] = ['between',[$start_date,$end_date]];
            } elseif ($start_date != 0 && $end_date == 0) {
                $condition["ng.create_time"] = ['gt',$start_date];
            } elseif ($start_date == 0 && $end_date != 0) {
                $condition["ng.create_time"] = ['lt',$end_date];
            }
            if ($state != "") {
                $condition["ng.state"] = $state;
            }
            if (! empty($goods_name)) {
                $condition["ng.goods_name"] = array(
                    "like",
                    "%" . $goods_name . "%"
                );
            }
            if (! empty($goods_code)) {
                $condition["ng.code"] = array(
                    "like",
                    "%" . $goods_code . "%"
                );
            }
            if ($category_id_3 != "") {
                $condition["ng.category_id_3"] = $category_id_3;
            } elseif ($category_id_2 != "") {
                $condition["ng.category_id_2"] = $category_id_2;
            } elseif ($category_id_1 != "") {
                $condition["ng.category_id_1"] = $category_id_1;
            }
            if ($supplier_id != '') {
                $condition['ng.supplier_id'] = $supplier_id;
            }
            $condition["ng.shop_id"] = $this->instance_id;
            //$condition['ng.is_temporary'] = $is_temporary;
            $result = $goodservice->getGoodsList($page_index, $page_size, $condition, [
                'ng.create_time' => 'desc'
            ]);
            // 根据商品分组id，查询标签名称
            foreach ($result['data'] as $k => $v) {
                if (! empty($v['group_id_array'])) {
                    $goods_group_id = explode(',', $v['group_id_array']);
                    $goods_group_name = '';
                    foreach ($goods_group_id as $key => $val) {
                        $goods_group = new GoodsGroup();
                        $goods_group_info = $goods_group->getGoodsGroupDetail($val);
                        if (! empty($goods_group_info)) {
                            $goods_group_name .= $goods_group_info['group_name'] . ',';
                        }
                    }
                    $goods_group_name = rtrim($goods_group_name, ',');
                    $result["data"][$k]['goods_group_name'] = $goods_group_name;
                }
            }
            return $result;
        } else {
            $goods_group = new GoodsGroup();
            $groupList = $goods_group->getGoodsGroupList(1, 0, [
                'shop_id' => $this->instance_id,
                'pid' => 0
            ]);
            if (! empty($groupList['data'])) {
                foreach ($groupList['data'] as $k => $v) {
                    $v['sub_list'] = $goods_group->getGoodsGroupList(1, 0, 'pid = ' . $v['group_id']);
                }
            }
            $this->assign("goods_group", $groupList['data']);
            $search_info = request()->get('search_info', '');
            $this->assign("search_info", $search_info);
            // 查找一级商品分类
            $goodsCategory = new GoodsCategory();
            $oneGoodsCategory = $goodsCategory->getGoodsCategoryListByParentId(0);
            $this->assign("oneGoodsCategory", $oneGoodsCategory);
            // 供货商列表
            $supplier = new Supplier();
            $supplier_list = $supplier->getSupplierList();
            $this->assign("supplier_list", $supplier_list['data']);

            // 入库类型列表
            $mType = new Type();
            $condition['stock_type'] = 1;
            $condition['type_id'] = ['neq',1];
            $in_list = $mType->getList(1,0,$condition,'type_id desc');
            $this->assign("in_list", $in_list['data']);

            $condition['stock_type'] = 2;
            $condition['type_id'] = ['neq',4];
            $out_list = $mType->getList(1,0,$condition,'type_id desc');
            $this->assign("out_list", $out_list['data']);

            return view($this->style . "Stock/goodsList");
        }
    }

    /**
     * 临时库存
     */
    public function temporary()
    {
        $goodservice = new GoodsService();
        if (request()->isAjax()) {
            $page_index = request()->post("page_index", 1);
            $page_size = request()->post("page_size", PAGESIZE);
            $start_date = request()->post('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('start_date'));
            $end_date = request()->post('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('end_date'));
            $goods_name = request()->post('goods_name', '');
            $goods_code = request()->post('code', '');
            $state = request()->post('state', '');
            $category_id_1 = request()->post('category_id_1', '');
            $category_id_2 = request()->post('category_id_2', '');
            $category_id_3 = request()->post('category_id_3', '');
            $selectGoodsLabelId = request()->post('selectGoodsLabelId', '');
            $supplier_id = request()->post('supplier_id', '');
            if (! empty($selectGoodsLabelId)) {
                $selectGoodsLabelIdArray = explode(',', $selectGoodsLabelId);
                $selectGoodsLabelIdArray = array_filter($selectGoodsLabelIdArray);
                $str = "FIND_IN_SET(" . $selectGoodsLabelIdArray[0] . ",ng.group_id_array)";
                for ($i = 1; $i < count($selectGoodsLabelIdArray); $i ++) {
                    $str .= "AND FIND_IN_SET(" . $selectGoodsLabelIdArray[$i] . ",ng.group_id_array)";
                }
                $condition[""] = [
                    [
                        "EXP",
                        $str
                    ]
                ];
            }
            $condition['ng.is_temporary'] = 1;
            if($start_date != 0 && $end_date != 0){
                $condition['ng.create_time'] = ['between',[$start_date,$end_date]];
            }elseif($start_date != 0 && $end_date == 0){
                $condition['ng.create_time'] = ['gt',$start_date];
            }elseif($start_date == 0 && $end_date != 0){
                $condition['ng.create_time'] = ['lt',$end_date];
            }
            if ($state != "") {
                $condition["ng.state"] = $state;
            }
            if (! empty($goods_name)) {
                $condition["ng.goods_name"] = array(
                    "like",
                    "%" . $goods_name . "%"
                );
            }
            if (! empty($goods_code)) {
                $condition["ng.code"] = array(
                    "like",
                    "%" . $goods_code . "%"
                );
            }
            if ($category_id_3 != "") {
                $condition["ng.category_id_3"] = $category_id_3;
            } elseif ($category_id_2 != "") {
                $condition["ng.category_id_2"] = $category_id_2;
            } elseif ($category_id_1 != "") {
                $condition["ng.category_id_1"] = $category_id_1;
            }
            if ($supplier_id != '') {
                $condition['ng.supplier_id'] = $supplier_id;
            }
            $condition["ng.shop_id"] = $this->instance_id;
            $result = $goodservice->getGoodsList($page_index, $page_size, $condition, [
                'ng.create_time' => 'desc'
            ]);
            // 根据商品分组id，查询标签名称
            foreach ($result['data'] as $k => $v) {
                if (! empty($v['group_id_array'])) {
                    $goods_group_id = explode(',', $v['group_id_array']);
                    $goods_group_name = '';
                    foreach ($goods_group_id as $key => $val) {
                        $goods_group = new GoodsGroup();
                        $goods_group_info = $goods_group->getGoodsGroupDetail($val);
                        if (! empty($goods_group_info)) {
                            $goods_group_name .= $goods_group_info['group_name'] . ',';
                        }
                    }
                    $goods_group_name = rtrim($goods_group_name, ',');
                    $result["data"][$k]['goods_group_name'] = $goods_group_name;
                }
            }
            return $result;
        } else {
            $goods_group = new GoodsGroup();
            $groupList = $goods_group->getGoodsGroupList(1, 0, [
                'shop_id' => $this->instance_id,
                'pid' => 0
            ]);
            if (! empty($groupList['data'])) {
                foreach ($groupList['data'] as $k => $v) {
                    $v['sub_list'] = $goods_group->getGoodsGroupList(1, 0, 'pid = ' . $v['group_id']);
                }
            }
            $this->assign("goods_group", $groupList['data']);
            $search_info = request()->get('search_info', '');
            $this->assign("search_info", $search_info);
            // 查找一级商品分类
            $goodsCategory = new GoodsCategory();
            $oneGoodsCategory = $goodsCategory->getGoodsCategoryListByParentId(0);
            $this->assign("oneGoodsCategory", $oneGoodsCategory);
            // 供货商列表
            $supplier = new Supplier();
            $supplier_list = $supplier->getSupplierList();
            $this->assign("supplier_list", $supplier_list['data']);

            // 入库类型列表
            $mType = new Type();
            $condition['stock_type'] = 1;
            $condition['type_id'] = ['neq',1];
            $in_list = $mType->getList(1,0,$condition,'type_id desc');
            $this->assign("in_list", $in_list['data']);

            $condition['stock_type'] = 2;
            $condition['type_id'] = ['neq',4];
            $out_list = $mType->getList(1,0,$condition,'type_id desc');
            $this->assign("out_list", $out_list['data']);


            return view($this->style . "Stock/temporary");
        }
    }

    public function refundApplys()
    {
        if (request()->isAjax()) {
            $page_index = request()->post('page_index', 1);
            $page_size = request()->post('page_size', PAGESIZE);
            $start_date = request()->post('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start_date'));
            $end_date = request()->post('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end_date'));
            $user_name = request()->post('user_name', '');
            $order_no = request()->post('order_no', '');
            $order_status = request()->post('order_status', '');
            $receiver_mobile = request()->post('receiver_mobile', '');
            $payment_type = request()->post('payment_type', 1);
            $condition['is_deleted'] = 0; // 未删除订单
            if ($start_date != 0 && $end_date != 0) {
                $condition["create_time"] = [
                    [
                        ">",
                        $start_date
                    ],
                    [
                        "<",
                        $end_date
                    ]
                ];
            } elseif ($start_date != 0 && $end_date == 0) {
                $condition["create_time"] = [
                    [
                        ">",
                        $start_date
                    ]
                ];
            } elseif ($start_date == 0 && $end_date != 0) {
                $condition["create_time"] = [
                    [
                        "<",
                        $end_date
                    ]
                ];
            }
            if ($order_status != '') {
                // $order_status 1 待发货
                if ($order_status == 1) {
                    // 订单状态为待发货实际为已经支付未完成还未发货的订单
                    $condition['shipping_status'] = 0; // 0 待发货
                    $condition['pay_status'] = 2; // 2 已支付
                    $condition['order_status'] = array(
                        'neq',
                        4
                    ); // 4 已完成
                    $condition['order_status'] = array(
                        'neq',
                        5
                    ); // 5 关闭订单
                } else
                    $condition['order_status'] = $order_status;
            }
            if (! empty($payment_type)) {
                $condition['payment_type'] = $payment_type;
            }
            if (! empty($user_name)) {
                $condition['receiver_name'] = $user_name;
            }
            if (! empty($order_no)) {
                $condition['order_no'] = $order_no;
            }
            if (! empty($receiver_mobile)) {
                $condition['receiver_mobile'] = $receiver_mobile;
            }
            $condition['shop_id'] = $this->instance_id;
            $order_service = new OrderService();
            $list = $order_service->getOrderList($page_index, $page_size, $condition, 'create_time desc');
            return $list;
        } else {
            $status = request()->get('status', '');
            $check_pay_status = request()->get('check_pay_status', '');
            $this->assign("status", $status);
            $this->assign('check_pay_status', $check_pay_status);
            return view($this->style . "Stock/refundApply");
        }
    }


    public function orderList()
    {
        if (request()->isAjax()) {
            $page_index = request()->post('page_index', 1);
            $page_size = request()->post('page_size', PAGESIZE);
            $start_date = request()->post('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start_date'));
            $end_date = request()->post('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end_date'));
            $user_name = request()->post('user_name', '');
            $order_no = request()->post('order_no', '');
            $order_status = request()->post('order_status', '');
            $check_pay_status = request()->post('check_pay_status', '');
            $receiver_mobile = request()->post('receiver_mobile', '');
            $payment_type = request()->post('payment_type', 1);
            $condition['is_deleted'] = 0; // 未删除订单
            if($check_pay_status != ''){
                $condition['check_pay_status'] = $check_pay_status;
                $condition['order_status'] = ['not in',[-1]];
            }
            if ($start_date != 0 && $end_date != 0) {
                $condition["create_time"] = [
                    [
                        ">",
                        $start_date
                    ],
                    [
                        "<",
                        $end_date
                    ]
                ];
            } elseif ($start_date != 0 && $end_date == 0) {
                $condition["create_time"] = [
                    [
                        ">",
                        $start_date
                    ]
                ];
            } elseif ($start_date == 0 && $end_date != 0) {
                $condition["create_time"] = [
                    [
                        "<",
                        $end_date
                    ]
                ];
            }
            if ($order_status != '') {
                // $order_status 1 待发货
                if ($order_status == 1) {
                    // 订单状态为待发货实际为已经支付未完成还未发货的订单
                    $condition['shipping_status'] = 0; // 0 待发货
                    $condition['pay_status'] = 2; // 2 已支付
                    $condition['order_status'] = array(
                        'neq',
                        4
                    ); // 4 已完成
                    $condition['order_status'] = array(
                        'neq',
                        5
                    ); // 5 关闭订单
                } else
                    $condition['order_status'] = $order_status;
            }
            if (! empty($payment_type)) {
                $condition['payment_type'] = $payment_type;
            }
            if (! empty($user_name)) {
                $condition['receiver_name'] = $user_name;
            }
            if (! empty($order_no)) {
                $condition['order_no'] = $order_no;
            }
            if (! empty($receiver_mobile)) {
                $condition['receiver_mobile'] = $receiver_mobile;
            }
            $condition['shop_id'] = $this->instance_id;
            $order_service = new OrderService();
            $list = $order_service->getOrderList($page_index, $page_size, $condition, 'create_time desc');
            return $list;
        } else {
            $status = request()->get('status', '');
            $this->assign("status", $status);

            // 获取物流公司
            $express = new ExpressService();
            $expressList = $express->expressCompanyQuery();
            $this->assign('expressList', $expressList);
            
            return view($this->style . "Stock/orderList");
        }
    }



    /**
     * 商品入库
     * @return [type] [description]
     */
    public function inStock()
    {
    	$mStock = new Stock();
    	$user_info = $this->user->getUserInfo();
    	$post = request()->post();

    	$shop_id = $this->instance_id;
        $uid = $this->uid;

        $purchase_goods_id = isset($post['purchase_goods_id']) ? $post['purchase_goods_id'] : 0;

        $goods_id = request()->post('goods_id','');
        $sku_id = request()->post('sku_id','');
        $nums = request()->post('nums',0);

        $where['goods_id'] = $goods_id;
        if(!empty($sku_id)) {
            $where['sku_id'] = $sku_id;
        }
        $mGk = new NsGoodsSkuModel();
        $m_gk = $mGk->where($where)->find();
        if(!empty($m_gk)) {
            $money = $m_gk['cost_price'] != 0 ? $m_gk['cost_price'] : $m_gk['price'];
            //$money = $m_gk['price'];
        }else{
            $money = 0;
        }

        if(isset($post['money'])){
            $money = $post['money'] / $nums;
        }

    	$post = array(
    		'goods_id' => $goods_id,
            'sku_id' => $sku_id,
            'purchase_goods_id' => $purchase_goods_id,
    		'nums' => $nums,
    		'money' => $money * $nums,
    		'time' => $post['time'],
    		'stock_type' => $post['stock_type'],
    		'remark' => $post['remark'],
            'shop_id' => $shop_id,
            'uid' => $uid,
            'user_name' => $user_info['user_name'],
            'create_time' => time(),
            'update_time' => time()
    	);
    	$ret = $mStock->inStock($post);
        return $ret;
    }

    /**
     * 临时仓库商品入库
     */
    public function inTemporaryStock()
    {
        $mStock = new Stock();
        $user_info = $this->user->getUserInfo();
        $post = request()->post();

        $shop_id = $this->instance_id;
        $uid = $this->uid;

        $goods_id = request()->post('goods_id','');
        $sku_id = request()->post('sku_id','');
        $nums = request()->post('nums',0);

        $where['goods_id'] = $goods_id;
        if(!empty($sku_id)) {
            $where['sku_id'] = $sku_id;
        }
        $mGk = new NsGoodsSkuModel();
        $m_gk = $mGk->where($where)->find();
        if(!empty($m_gk)) {
            $money = $m_gk['cost_price'] != 0 ? $m_gk['cost_price'] : $m_gk['price'];
            //$money = $m_gk['price'];
        }else{
            $money = 0;
        }

        $post = array(
            'goods_id' => $goods_id,
            'sku_id' => $sku_id,
            'nums' => $nums,
            'stock_type' => $post['stock_type'],
            'money' => $money * $nums,
            'time' => $post['time'],
            'remark' => $post['remark'],
            'shop_id' => $shop_id,
            'uid' => $uid,
            'user_name' => $user_info['user_name'],
            'create_time' => time(),
            'update_time' => time()
        );

        $ret = $mStock->inTemporaryStock($post);
        return $ret;
    }

    /**
     * 将商品移除临时仓库
     */
    public function removeTemporary()
    {
        $mStock = new Stock();
        $user_info = $this->user->getUserInfo();
        $shop_id = $this->instance_id;
        $uid = $this->uid;
        $post = request()->post();
        $goods_id = $post['goods_id'];
        $data = array(
            'goods_id' => $goods_id,
            'money' => 0,
            'time' => getTimeStampTurnTime(time()),
            'shop_id' => $shop_id,
            'uid' => $uid,
            'user_name' => $user_info['user_name'],
            'create_time' => time(),
            'update_time' => time()
        );
        $ret = $mStock->removeTemporary($data);
        return $ret;
    }


    public function deleteStock()
    {
        $mStock = new Stock();
        $post = request()->post();
        $stock_id = $post['stock_id'];
        $ret = $mStock->deleteStock($stock_id);
        return $ret;
    }


    /**
     * 商品出库
     * @return [type] [description]
     */
    public function outStock()
    {
    	$mStock = new Stock();
    	$user_info = $this->user->getUserInfo();
    	$post = request()->post();

    	$shop_id = $this->instance_id;
        $uid = $this->uid;

        $goods_id = request()->post('goods_id','');
        $sku_id = request()->post('sku_id','');
        $nums = request()->post('nums',0);

        $where['goods_id'] = $goods_id;
        if(!empty($sku_id)) {
            $where['sku_id'] = $sku_id;
        }
        $mGk = new NsGoodsSkuModel();
        $m_gk = $mGk->where($where)->find();
        if(!empty($m_gk)) {
            $money = $m_gk['cost_price'] != 0 ? $m_gk['cost_price'] : $m_gk['price'];
            $money = $m_gk['price'];
        }else{
            $money = 0;
        }

    	$post = array(
    		'goods_id' => $goods_id,
    		'sku_id' => $sku_id,
    		'nums' => $nums,
    		'is_instock' => 2,
    		'money' => $money * $nums,
    		'time' => $post['time'],
    		'stock_type' => $post['stock_type'],
    		'remark' => $post['remark'],
            'shop_id' => $shop_id,
            'uid' => $uid,
            'user_name' => $user_info['user_name'],
            'create_time' => time(),
            'update_time' => time()
    	);

    	$ret = $mStock->outStock($post);
        return $ret;
    }

    /**
     * 临时仓库商品出库
     */
    public function outTemporaryStock()
    {
        $mStock = new Stock();
        $user_info = $this->user->getUserInfo();
        $post = request()->post();
        $shop_id = $this->instance_id;
        $uid = $this->uid;

        $goods_id = request()->post('goods_id','');
        $sku_id = request()->post('sku_id','');
        $nums = request()->post('nums',0);

        $where['goods_id'] = $goods_id;
        if(!empty($sku_id)) {
            $where['sku_id'] = $sku_id;
        }
        $mGk = new NsGoodsSkuModel();
        $m_gk = $mGk->where($where)->find();
        if(!empty($m_gk)) {
            //$money = $m_gk['cost_price'] != 0 ? $m_gk['cost_price'] : $m_gk['price'];
            $money = $m_gk['price'];
        }else{
            $money = 0;
        }

        $post = array(
            'goods_id' => $goods_id,
            'sku_id' => $sku_id,
            'nums' => $nums,
            'is_instock' => 2,
            'money' => $money * $nums,
            'time' => $post['time'],
            'stock_type' => $post['stock_type'],
            'remark' => $post['remark'],
            'shop_id' => $shop_id,
            'uid' => $uid,
            'user_name' => $user_info['user_name'],
            'create_time' => time(),
            'update_time' => time()
        );

        $ret = $mStock->outTemporaryStock($post);
        return $ret;
    }


    /**
     * 入库报表
     * @return [type] [description]
     */
    public function inStockList()
    {
        if (request()->isAjax()) {
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
            $end_date = request()->post('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');
            $start = request()->post('start') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start').' 00:00:00');
            $end = request()->post('end') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end').' 23:59:59');
            $stock_type = request()->post('stock_type', '');
            $type = request()->post('type','');
            $goods_name = request()->post('goods_name','');
            $condition = [];
            if($start_date != 0 && $end_date != 0){
                $condition['time'] = ['between',[$start_date,$end_date]];
            }else if($start_date != 0 && $end_date == 0){
            	$condition['time'] = ['gt',$start_date];
            }else if($start_date == 0 && $end_date != 0){
            	$condition['time'] = ['lt',$end_date];
            }
            if($start != 0 && $end != 0){
                $condition['create_time'] = ['between',[$start,$end]];
            }else if($start != 0 && $end == 0){
                $condition['create_time'] = ['gt',$start];
            }else if($start == 0 && $end != 0){
                $condition['create_time'] = ['lt',$end];
            }
            $condition['is_instock'] = 1;
            if(!empty($type)){
                $condition['type'] = $type;
            }
            if(!empty($stock_type)){
            	$condition['stock_type'] = $stock_type;
            }
            if(!empty($goods_name)){
                $mGoods = new NsGoodsModel();
                $where_goods['goods_name'] = ['like','%'.$goods_name.'%'];
                $goods_ids = $mGoods->where($where_goods)->column('goods_id');
                $condition['goods_id'] = ['in',$goods_ids];
                //$condition['goods_name'] = ['like','%'.$goods_name.'%'];
            }

            $condition['shop_id'] = $this->instance_id;

            $mStock = new Stock();
            $list = $mStock->getInStockList($page_index,$page_size,$condition,'stock_id desc');
            foreach ($list['data'] as &$item) {
                $mType = new NsTypeModel();
                $type = $mType->where('type_id',$item['stock_type'])->find();
                if($type){
                    $item['stock_type'] = $type['type_name'];
                }else{
                    $item['stock_type'] = '其他入库';
                }

            }
            return $list;
        } else {
            $child_menu_list = array(
		        array(
		            'url' => "stocks/instocklist",
		            'menu_name' => "入库统计",
		            "active" => 1
		        ),
		        array(
		            'url' => "stocks/outstocklist",
		            'menu_name' => "出库统计",
		            "active" => 0
		        ),
		        array(
		            'url' => "stocks/refundlist",
		            'menu_name' => "退货统计",
		            "active" => 0
		        ),
                array(
                    'url' => "stocks/detaillist",
                    'menu_name' => "库存变动",
                    "active" => 0
                )
		    );

            $mType = new Type();
            $where['stock_type'] = 1;
            $in_list = $mType->getList(1,0,$where,'type_id desc');
            $this->assign("in_list", $in_list['data']);

		    $this->assign('child_menu_list', $child_menu_list);
		    return view($this->style . "Stock/inStockList");

        }

    }


    /**
     * 出库报表
     * @return [type] [description]
     */
    public function outStockList()
    {
        if (request()->isAjax()) {
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
            $end_date = request()->post('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');
            $start = request()->post('start') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start').' 00:00:00');
            $end = request()->post('end') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end').' 23:59:59');
            $stock_type = request()->post('stock_type', '');
            $type = request()->post('type','');
            $goods_name = request()->post('goods_name', '');
            $condition = [];
            if($start_date != 0 && $end_date != 0){
                $condition['time'] = ['between',[$start_date,$end_date]];
            }else if($start_date != 0 && $end_date == 0){
            	$condition['time'] = ['gt',$start_date];
            }else if($start_date == 0 && $end_date != 0){
            	$condition['time'] = ['lt',$end_date];
            }
            if($start != 0 && $end != 0){
                $condition['create_time'] = ['between',[$start,$end]];
            }else if($start != 0 && $end == 0){
                $condition['create_time'] = ['gt',$start];
            }else if($start == 0 && $end != 0){
                $condition['create_time'] = ['lt',$end];
            }
            $condition['is_instock'] = 2;
            if(!empty($stock_type)){
            	$condition['stock_type'] = $stock_type;
            }
            if(!empty($type)){
                $condition['type'] = $type;
            }
            if(!empty($goods_name)){
                $mGoods = new NsGoodsModel();
                $where_goods['goods_name'] = ['like','%'.$goods_name.'%'];
                $goods_ids = $mGoods->where($where_goods)->column('goods_id');
                $condition['goods_id'] = ['in',$goods_ids];
            }
            $condition['shop_id'] = $this->instance_id;
            $mStock = new Stock();
            $list = $mStock->getOutStockList($page_index,$page_size,$condition,'stock_id desc');
            foreach ($list['data'] as &$item) {
                $mType = new NsTypeModel();
                $type = $mType->where('type_id',$item['stock_type'])->find();
                if($type){
                    $item['stock_type'] = $type['type_name'];
                }else{
                    $item['stock_type'] = '其他出库';
                }
                $item['cost_money'] = $item['nums'] * $item['goods_sku']['cost_price'];
            }
            return $list;
        } else {
            $child_menu_list = array(
		        array(
		            'url' => "stocks/instocklist",
		            'menu_name' => "入库统计",
		            "active" => 0
		        ),
		        array(
		            'url' => "stocks/outstocklist",
		            'menu_name' => "出库统计",
		            "active" => 1
		        ),
		        array(
		            'url' => "stocks/refundlist",
		            'menu_name' => "退货统计",
		            "active" => 0
		        ),
                array(
                    'url' => "stocks/detaillist",
                    'menu_name' => "库存变动",
                    "active" => 0
                )
		    );

            $mType = new Type();
            $where['stock_type'] = 2;
            $out_list = $mType->getList(1,0,$where,'type_id desc');
            $this->assign("out_list", $out_list['data']);

		    $this->assign('child_menu_list', $child_menu_list);
		    return view($this->style . "Stock/outStockList");

        }

    }

    /**
     * 退货统计
     * @return [type] [description]
     */
    public function refundList()
    {
        if (request()->isAjax()) {
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
            $end_date = request()->post('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');

            $refund_company = request()->post('refund_company', '');
            $refund_code = request()->post('refund_code','');
            $goods_name = request()->post('goods_name', '');

            if($start_date != 0 && $end_date != 0){
                $condition['refund_time'] = ['between',[$start_date,$end_date]];
            }else if($start_date != 0 && $end_date == 0){
            	$condition['refund_time'] = ['gt',$start_date];
            }else if($start_date == 0 && $end_date != 0){
            	$condition['refund_time'] = ['lt',$end_date];
            }
            if(!empty($refund_company)){
            	$condition['refund_shipping_company'] = ['like','%'.$refund_company.'%'];
            }

            if(!empty($refund_code)){
            	$condition['refund_shipping_code'] = ['like','%'.$refund_code.'%'];
            }

            if(!empty($goods_name)){
                $condition['goods_name'] = ['like','%'.$goods_name.'%'];
            }

            $condition['shop_id'] = $this->instance_id;
            $condition['refund_type'] = 2;
            $condition['refund_status'] = 5;

            $mOrder = new Order();
            $list = $mOrder->getrefundList($page_index,$page_size,$condition,'refund_time desc');
            return $list;

        } else {
            $child_menu_list = array(
		        array(
		            'url' => "stocks/instocklist",
		            'menu_name' => "入库统计",
		            "active" => 0
		        ),
		        array(
		            'url' => "stocks/outstocklist",
		            'menu_name' => "出库统计",
		            "active" => 0
		        ),
		        array(
		            'url' => "stocks/refundlist",
		            'menu_name' => "退货统计",
		            "active" => 1
		        ),
                array(
                    'url' => "stocks/detaillist",
                    'menu_name' => "库存变动",
                    "active" => 0
                )
		    );
		    $this->assign('child_menu_list', $child_menu_list);
		    return view($this->style . "Stock/refundList");

        }

    }


    public function detailList()
    {
        if (request()->isAjax()) {
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date',0);
            $end_date = request()->post('end_date',0);
            $goods_name = request()->post('goods_name','');
            $condition = [];

            if(!empty($goods_name)){
                $mGoods = new NsGoodsModel();
                $where_goods['goods_name'] = ['like','%'.$goods_name.'%'];
                $goods_ids = $mGoods->where($where_goods)->column('goods_id');
                $condition['goods_id'] = ['in',$goods_ids];
            }

            $start_int_day = date('Ymd',strtotime($start_date));
            $end_int_day = date('Ymd',strtotime($end_date));

            if($start_date && $end_date){
                $condition['int_day'] = ['between',[$start_int_day,$end_int_day]];
            }
            if($start_date && !$end_date){
                $condition['int_day'] = ['egt',$start_int_day];
            }
            if(!$start_date && $end_date){
                $condition['int_day'] = ['elt',$end_int_day];
            }

            $modal = new NsGoodsSkuStockHistoryModel();
            $list = $modal->pageQuery($page_index,$page_size,$condition,'int_day desc,goods_id asc','*');

            foreach ($list['data'] as &$item) {
                $m_goods = NsGoodsModel::get($item['goods_id']);
                $item['goods_name'] = $m_goods['goods_name'];
                if($item['sku_id']){
                    $m_goods_sku = NsGoodsSkuModel::get($item['sku_id']);
                    $item['sku_name'] = $m_goods_sku['sku_name'];
                }
                $item['int_day'] = date('Y-m-d',strtotime($item['int_day']));
            }
            return $list;
        } else {
            $child_menu_list = array(
                array(
                    'url' => "stocks/instocklist",
                    'menu_name' => "入库统计",
                    "active" => 0
                ),
                array(
                    'url' => "stocks/outstocklist",
                    'menu_name' => "出库统计",
                    "active" => 0
                ),
                array(
                    'url' => "stocks/refundlist",
                    'menu_name' => "退货统计",
                    "active" => 0
                ),
                array(
                    'url' => "stocks/detaillist",
                    'menu_name' => "库存变动",
                    "active" => 1
                )
            );

            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Stock/detailList");

        }

    }


    /**
     * 入库数据导出
     * @return [type] [description]
     */
    public function instockDataExcel()
    {
        $xlsName = '入库统计';
        $xlsCell = [
            ['stock_id','编号'],
            ['goods_name','商品名称'],
            ['nums','入库数量'],
            ['money','入库金额'],
            ['time','入库时间'],
            ['stock_type','入库类型'],
            ['type','仓库类型'],
            ['remark','备注'],
            ['create_time','操作时间'],
            ['user_name','操作人']
        ];
        $start_date = request()->get('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->get('start_date').' 00:00:00');
        $end_date = request()->get('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->get('end_date').' 23:59:59');
        $start = request()->get('start') == "" ? 0 : getTimeTurnTimeStamp(request()->get('start').' 00:00:00');
        $end = request()->get('end') == "" ? 0 : getTimeTurnTimeStamp(request()->get('end').' 23:59:59');
        $stock_type = request()->get('stock_type', '');
        $type = request()->get('type','');
        $goods_name = request()->get('goods_name', '');
        $condition = [];
        if($start_date != 0 && $end_date != 0){
            $condition['time'] = ['between',[$start_date,$end_date]];
        }else if($start_date != 0 && $end_date == 0){
            $condition['time'] = ['gt',$start_date];
        }else if($start_date == 0 && $end_date != 0){
            $condition['time'] = ['lt',$end_date];
        }
        if($start != 0 && $end != 0){
            $condition['create_time'] = ['between',[$start,$end]];
        }else if($start != 0 && $end == 0){
            $condition['create_time'] = ['gt',$start];
        }else if($start == 0 && $end != 0){
            $condition['create_time'] = ['lt',$end];
        }
        $condition['is_instock'] = 1;
        if(!empty($type)){
            $condition['type'] = $type;
        }
        if(!empty($stock_type)){
            $condition['stock_type'] = $stock_type;
        }

        if(!empty($goods_name)){
            $mGoods = new NsGoodsModel();
            $where_goods['goods_name'] = ['like','%'.$goods_name.'%'];
            $goods_ids = $mGoods->where($where_goods)->column('goods_id');
            $condition['goods_id'] = ['in',$goods_ids];
            //$condition['goods_name'] = ['like','%'.$goods_name.'%'];
        }
        $condition['shop_id'] = $this->instance_id;

        $mStock = new Stock();
        $list = $mStock->getInStockList(1, 0, $condition, 'stock_id desc');
        foreach ($list['data'] as &$item) {
            if($item['sku_name']){
                $item['goods_name'] = $item['goods']['goods_name'].'('.$item['sku_name'].')';
            }
            $mType = new NsTypeModel();
            $type = $mType->where('type_id',$item['stock_type'])->find();
            if($type){
                $item['stock_type'] = $type['type_name'];
            }else{
                $item['stock_type'] = '其他入库';
            }
        }
        dataExcel($xlsName,$xlsCell,$list['data']);
    }


    /**
     * 出库数据导出
     * @return [type] [description]
     */
    public function outstockDataExcel()
    {
        $xlsName = '出库统计';
        $xlsCell = [
            ['stock_id','编号'],
            ['goods_name','商品名称'],
            ['sku_name','规格'],
            ['nums','出库数量'],
            ['money','出库金额'],
            ['cost_money','成本x数量'],
            ['time','出库时间'],
            ['stock_type','出库类型'],
            ['type','仓库类型'],
            ['remark','备注'],
            ['create_time','操作时间'],
            ['user_name','操作人']
        ];
        $start_date = request()->get('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->get('start_date').' 00:00:00');
        $end_date = request()->get('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->get('end_date').' 23:59:59');
        $start = request()->get('start') == "" ? 0 : getTimeTurnTimeStamp(request()->get('start').' 00:00:00');
        $end = request()->get('end') == "" ? 0 : getTimeTurnTimeStamp(request()->get('end').' 23:59:59');
        $stock_type = request()->get('stock_type', '');
        $type = request()->get('type','');
        $goods_name = request()->get('goods_name', '');
        $condition = [];
        if($start_date != 0 && $end_date != 0){
            $condition['time'] = ['between',[$start_date,$end_date]];
        }else if($start_date != 0 && $end_date == 0){
            $condition['time'] = ['gt',$start_date];
        }else if($start_date == 0 && $end_date != 0){
            $condition['time'] = ['lt',$end_date];
        }
        if($start != 0 && $end != 0){
            $condition['create_time'] = ['between',[$start,$end]];
        }else if($start != 0 && $end == 0){
            $condition['create_time'] = ['gt',$start];
        }else if($start == 0 && $end != 0){
            $condition['create_time'] = ['lt',$end];
        }


        $condition['is_instock'] = 2;
        if(!empty($type)){
            $condition['type'] = $type;
        }
        if(!empty($stock_type)){
            $condition['stock_type'] = $stock_type;
        }

        if(!empty($goods_name)){
            $mGoods = new NsGoodsModel();
            $where_goods['goods_name'] = ['like','%'.$goods_name.'%'];
            $goods_ids = $mGoods->where($where_goods)->column('goods_id');
            $condition['goods_id'] = ['in',$goods_ids];
        }
        $condition['shop_id'] = $this->instance_id;

        $mStock = new Stock();
        $list = $mStock->getOutStockList(1, 0, $condition, 'stock_id desc');
        foreach ($list['data'] as &$item) {
            /*if($item['sku_name']){
                $item['goods_name'] = $item['goods_name'].'('.$item['sku_name'].')';
            }*/
            $mType = new NsTypeModel();
            $type = $mType->where('type_id',$item['stock_type'])->find();
            if($type){
                $item['stock_type'] = $type['type_name'];
            }else{
                $item['stock_type'] = '其他出库';
            }
            $item['cost_money'] = $item['nums'] * $item['goods_sku']['cost_price'];
        }
        dataExcel($xlsName,$xlsCell,$list['data']);
    }

    /**
     * 导出退货数据
     * @return [type] [description]
     */
    public function refundDataExcel()
    {
        $xlsName = '退货统计';
        $xlsCell = [
            ['goods_name','商品名称'],
            ['num','商品数量'],
            ['goods_money','商品金额'],
            ['refund_real_money','退货金额'],
            ['refund_time','退货时间'],
            ['refund_shipping_company','快递名称'],
            ['refund_shipping_code','退货单号'],
            ['refund_reason','退货理由']
        ];
        $start_date = request()->get('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->get('start_date').' 00:00:00');
        $end_date = request()->get('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->get('end_date').' 23:59:59');
        $goods_name = request()->post('goods_name', '');
        $refund_company = request()->post('refund_shipping_company','');
        $refund_code = request()->post('refund_shipping_code','');
        $condition = [];
        if($start_date != 0 && $end_date != 0){
            $condition['time'] = ['between',[$start_date,$end_date]];
        }else if($start_date != 0 && $end_date == 0){
            $condition['time'] = ['gt',$start_date];
        }else if($start_date == 0 && $end_date != 0){
            $condition['time'] = ['lt',$end_date];
        }
        if(!empty($goods_name)){
            $condition['goods_name'] = ['like','%'.$goods_name.'%'];
        }

        if(!empty($refund_company)){
            $condition['refund_shipping_company'] = ['like','%'.$refund_company.'%'];
        }

        if(!empty($refund_code)){
            $condition['refund_shipping_code'] = ['like','%'.$refund_code.'%'];
        }

        $condition['shop_id'] = $this->instance_id;
        $condition['refund_type'] = 2;
        $condition['refund_status'] = 5;

        $mOrder = new Order();
        $list = $mOrder->getrefundList(1,0,$condition,'refund_time desc');
        foreach ($list['data'] as $item) {
            $item['refund_shipping_code'] .= ' ';
        }
        dataExcel($xlsName,$xlsCell,$list['data']);
    }




    





}