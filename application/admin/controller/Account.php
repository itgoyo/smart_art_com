<?php

namespace app\admin\controller;
use data\model\NsGoodsModel;
use data\model\NsGoodsSkuModel;
use data\model\NsGoodsSkuStockHistoryModel;
use data\model\NsOrderModel;
use data\model\NsOrderRefundAccountRecordsModel;
use data\model\NsOrderRefundModel;
use data\model\NsReportGoodsSkuModel;
use data\model\NsTypeModel;
use data\service\Goods;
use data\service\GoodsCategory;
use data\service\Purchase\PurchaseGoods;
use data\service\Order\OrderStatus;
use data\service\Express as ExpressService;
use data\service\Order;
use data\service\Stock;
use data\service\Shop;
use data\service\Type;
use think\helper\Time;
/**
 * 账户控制器
 */
class Account extends BaseController
{
    /**
     * 商品销售排行
     */
    public function shopGoodsSalesRank()
    {
        $goods = new Goods();
        $goods_list = $goods->getGoodsRank(array(
            "shop_id" => $this->instance_id
        ));
        $this->assign("goods_list", $goods_list);
        return view($this->style . "Account/shopGoodsSalesRank");
    }
    /**
     * 商品销售统计
     */
    public function shopGoodsAccountList()
    {
        if (request()->isAjax()) {
            $page_index = request()->post('page_index', 1);
            $page_size = request()->post('page_size', 0);
            $goods_id = request()->post('goods_id', 0);
            $start_date = request()->post('start_date', 0);
            $end_date = request()->post('end_date', 0);
            $condition = array();
            $condition = array(
                "no.order_status" => [
                    'NEQ',
                    0
                ],
                "no.order_status" => [
                    'NEQ',
                    5
                ]
            );
            if($start_date != 0 && $end_date != 0){
                $condition["no.pay_time"] = [
                    [
                        ">",
                        getTimeTurnTimeStamp($start_date)
                    ],
                    [
                        "<",
                        getTimeTurnTimeStamp($end_date)
                    ]
                ];
            }elseif($start_date != 0 && $end_date == 0){
                $condition["no.pay_time"] = [
                    [
                        ">",
                        getTimeTurnTimeStamp($start_date)
                    ]
                ];
            }elseif($start_date == 0 && $end_date != 0){
                $condition["no.pay_time"] = [
                    [
                        "<",
                        getTimeTurnTimeStamp($end_date)
                    ]
                ];
            }
            if ($goods_id > 0) {
                $condition["nog.goods_id"] = $goods_id;
            }
            $shop = new Shop();
            $list = $shop->getshopOrderAccountRecordsList($page_index, $page_size, $condition, 'nog.order_goods_id desc');
            return $list;
        } else {
            $goods_id = request()->get('goods_id',0);
            $this->assign("goods_id", $goods_id);
            return view($this->style . "Account/shopGoodsAccountList");
        }
    }
    /**
     * 店铺销售明细
     *
     * @return unknown|Ambigous <\think\response\View, \think\response\$this, \think\response\View>
     */
    public function orderRecordsList()
    {
        if (request()->isAjax()) {
            $page_index = request()->post("page_index", 1);
            $page_size = request()->post("page_size", PAGESIZE);
            $condition = array();
            $start_date = request()->post('start_date', '');
            $end_date = request()->post('end_date', '');
            if ($start_date != "" && $end_date != "") {
                $condition["create_time"] = [
                    [
                        ">",
                        getTimeTurnTimeStamp($start_date)
                    ],
                    [
                        "<",
                        getTimeTurnTimeStamp($end_date)
                    ]
                ];
            } else
                if ($start_date != "" && $end_date == "") {
                    $condition["create_time"] = [
                        [
                            ">",
                            getTimeTurnTimeStamp($start_date)
                        ]
                    ];
                } else
                    if ($start_date == "" && $end_date != "") {
                        $condition["create_time"] = [
                            [
                                "<",
                                getTimeTurnTimeStamp($end_date)
                            ]
                        ];
                    }
            $order = new Order();
            $list = $order->getOrderList($page_index, $page_size, $condition, " create_time desc ");
            return $list;
        } else {
            $child_menu_list = array(
                array(
                    'url' => "account/orderaccountcount",
                    'menu_name' => "订单统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/orderrecordslist",
                    'menu_name' => "销售明细",
                    "active" => 1
                )
            );
            $this->assign('child_menu_list', $child_menu_list);
            $time = request()->get('time','');
            $type = request()->get('type',0);
            $start_time = "";
            $end_time = "";
            if ($time == "day") {
                $start_time = date("Y-m-d", time());
                $end_time = date("Y-m-d H:i:s", time());
            } elseif ($time == "week") {
                $start_time = date('Y-m-d', strtotime('-7 days'));
                $end_time = date("Y-m-d H:i:s", time());
            } elseif ($time == "month") {
                $start_time = date('Y-m-d', strtotime('-30 days'));
                $end_time = date("Y-m-d H:i:s", time());
            }
            $this->assign("start_time", $start_time);
            $this->assign("end_time", $end_time);
            return view($this->style . "Account/orderRecordsList");
        }
    }
    /**
     * 订单销售统计
     */
    public function orderAccountCount()
    {
        $child_menu_list = array(
            array(
                'url' => "account/orderaccountcount",
                'menu_name' => "订单统计",
                "active" => 1
            ),
            array(
                'url' => "account/orderrecordsList",
                'menu_name' => "销售明细",
                "active" => 0
            )
        );
        $this->assign('child_menu_list', $child_menu_list);
        $order_service = new Order();
        // 获取日销售统计
        $account = $order_service->getShopOrderAccountDetail($this->instance_id);
        $this->assign("account", $account);
        return view($this->style . "Account/orderAccountCount");
    }
    /**
     * 店铺销售概况
     *
     * @return Ambigous <\think\response\View, \think\response\$this, \think\response\View>
     */
    public function shopSalesAccount()
    {
        $order_service = new Order();
        // 获取所需销售统计
        $account = $order_service->getShopAccountCountInfo($this->instance_id);
        $this->assign("account", $account);
        return view($this->style . "Account/shopSalesAccount");

    }
    /**
     * 前30日销售统计
     *
     * @return Ambigous <multitype:, unknown>
     */
    public function getShopSaleNumCount()
    {
        $order = new Order();
        $data = array();
        $post = request()->post();
        $start_ts = $post['start_date'] ? getTimeTurnTimeStamp($post['start_date'].' 00:00:00') : 0;
        $end_ts = $post['end_date'] ? getTimeTurnTimeStamp($post['end_date'].' 00:00:00') : 0;
        if($start_ts && $end_ts){
            $start_date = date('Y-m-01',$start_ts);
            $end_date = date('Y-m-d',strtotime($start_date .'+1 month') - 86400);
            $start = getTimeTurnTimeStamp($start_date.' 00:00:00');
            $end = getTimeTurnTimeStamp(($end_date).' 23:59:59');
        }else{
            list ($start, $end) = Time::month();
        }

        for ($j = 0; $j < ($end + 1 - $start) / 86400; $j ++) {
            $date_start = date("Y-m-d H:i:s", $start + 86400 * $j);
            $date_end = date("Y-m-d H:i:s", $start + 86400 * ($j + 1));
            $count = $order->getOrderCount([
                'shop_id' => $this->instance_id,
                'create_time' => [
                    'between',
                    [
                        getTimeTurnTimeStamp($date_start),
                        getTimeTurnTimeStamp($date_end)
                    ]
                ],
                "order_status" => [
                    'NEQ',
                    0
                ],
                "order_status" => [
                    'NEQ',
                    5
                ]
            ]);
            $data[0][$j] = (1 + $j) . '日';
            $data[1][$j] = $count;
        }
        $order_service = new Order();
        $data['account'] = $order_service->getShopAccountCount($this->instance_id,$start,$end);

        return $data;
    }
    /**
     * 商品销售详情
     *
     * @return Ambigous <multitype:number , multitype:number unknown >
     */
    public function shopGoodsSalesList()
    {
        if (request()->isAjax()) {
            $order = new Order();
            $page_index = request()->post('page_index', 1);
            $page_size = request()->post('page_size', PAGESIZE);
            $goods_name = request()->post("goods_name", '');
            $post = request()->post();
            $start_date = !empty($post['start_date']) ? strtotime($post['start_date'].' 00:00:00') : 0;
            $end_date = !empty($post['end_date']) ? strtotime($post['end_date'].' 23:59:59') : 0;
            $condition = array();
            if($start_date != 0 && $end_date != 0){
                $condition['create_time'] = ['between',[$start_date,$end_date]];
            }else if($start_date != 0 && $end_date == 0){
                $condition['create_time'] = ['gt',$start_date];
            }else if($start_date == 0 && $end_date != 0){
                $condition['create_time'] = ['lt',$end_date];
            }
            $condition['order_status'] = ['neq',5];
            if ($goods_name != '') {
                $where["goods_name"] = ['like','%'.$goods_name.'%'];
                $mGoods = new NsGoodsModel();
                $goods_ids = $mGoods->where($where)->column('goods_id');
                if(!empty($goods_ids)){
                    $condition['goods_id'] = ['in',$goods_ids];
                }
            }


            //$condition["shop_id"] = $this->instance_id;
            $list = $order->getShopGoodsSalesList($page_index, $page_size, $condition, 'goods_id desc');

            return $list;
        } else {
            $child_menu_list = array(
                array(
                    'url' => "account/shopGoodsSalesList",
                    'menu_name' => "商品分析",
                    "active" => 1
                ),
                array(
                    'url' => "account/bestSellerGoods",
                    'menu_name' => "热卖商品",
                    "active" => 0
                ),
                array(
                    'url' => "account/purchaseSellStock",
                    'menu_name' => "进销存",
                    "active" => 0
                )
            );
            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Account/shopGoodsSalesList");
        }
    }


    public function goodsDataExcel()
    {
        $xlsName = '商品分析表';
        $xlsCell = [
            ['goods_name','商品名称'],
            ['sku_name','规格'],
            ['stock','库存数'],
            ['nums','下单商品数'],
            ['money','下单金额'],
        ];
        $goods_name = request()->get('goods_name', '');
        $condition['order_status'] = ['neq',5];
        $get = request()->get();
        $start_date = !empty($get['start_date']) ? strtotime($get['start_date'].' 00:00:00') : 0;
        $end_date = !empty($get['end_date']) ? strtotime($get['end_date'].' 23:59:59') : 0;
        if($start_date != 0 && $end_date != 0){
            $condition['create_time'] = ['between',[$start_date,$end_date]];
        }else if($start_date != 0 && $end_date == 0){
            $condition['create_time'] = ['gt',$start_date];
        }else if($start_date == 0 && $end_date != 0){
            $condition['create_time'] = ['lt',$end_date];
        }
        if ($goods_name != '') {
            $where["goods_name"] = ['like','%'.$goods_name.'%'];
            $mGoods = new NsGoodsModel();
            $goods_ids = $mGoods->where($where)->column('goods_id');
            if(!empty($goods_ids)){
                $condition['goods_id'] = ['in',$goods_ids];
            }
        }
        //$condition["shop_id"] = $this->instance_id;
        $order = new Order();
        $list = $order->getShopGoodsSalesList(1, 0, $condition, 'goods_id desc');
        foreach ($list['data'] as &$item) {
            $item['nums'] = $item['sales_info']['sales_num'];
            $item['money'] = $item['sales_info']['sales_money'];
        }

        dataExcel($xlsName,$xlsCell,$list['data']);
    }

    /**
     * 热卖商品
     *
     * @return Ambigous <\think\response\View, \think\response\$this, \think\response\View>
     */
    public function bestSellerGoods()
    {
        $child_menu_list = array(
            array(
                'url' => "account/shopGoodsSalesList",
                'menu_name' => "商品分析",
                "active" => 0
            ),
            array(
                'url' => "account/bestSellerGoods",
                'menu_name' => "热卖商品",
                "active" => 1
            ),
            array(
                'url' => "account/purchaseSellStock",
                'menu_name' => '进销存',
                'active' => 0
            )
        );
        $this->assign('child_menu_list', $child_menu_list);
        return view($this->style . "Account/bestSellerGoods");
    }



    public function purchaseSellStock()
    {
        if (request()->isAjax()) {
            $post = request()->post();
            $page_index = request()->post('page_index', 1);
            $page_size = request()->post('page_size', PAGESIZE);
            $goods_name = request()->post("goods_name", '');
            $start_date = request()->post('start_date','');
            $end_date = request()->post('end_date','');
            if(empty($start_date) || empty($end_date)){
                $start_date = date('Y-m-01',time());
                $end_date = date('Y-m-d', strtotime("$start_date +1 month -1 day"));
            }

            $condition = [];
            $condition['start_int_day'] = date('Ymd',strtotime($start_date));
            $condition['end_int_day'] = date('Ymd',strtotime($end_date));
            $mGoods = new NsGoodsModel();
            $goods_ids = [];
            if(!empty($goods_name)){
                $where_goods['goods_name'] = ['like','%'.$goods_name.'%'];
                $goods_ids = $mGoods->where($where_goods)->column('goods_id');
                $condition['goods_id'] = ['in',$goods_ids];
            }
            $mGsh = new NsGoodsSkuStockHistoryModel();

            if(isset($post['refresh']) && $post['refresh'] == 1) {
                $mRgs = new NsReportGoodsSkuModel();
                $mRgs->buildTimeSectionReport(1,0,$start_date,$end_date);
            }

            $mGs = new NsReportGoodsSkuModel();
            $list = $mGs->pageQuery($page_index,$page_size,$condition,'goods_id asc','*');
            foreach ($list['data'] as &$item) {
                $m_goods = $mGoods->where('goods_id',$item['goods_id'])->find();
                $m_goods_sku = NsGoodsSkuModel::get($item['sku_id']);
                $item['goods_name'] = $m_goods_sku['sku_name'] ? $m_goods['goods_name'].'( '.$m_goods_sku['sku_name'].')' : $m_goods['goods_name'];
            }

            $list['total_pre_nums'] = $mGsh->TotalPreNums($start_date,$goods_ids);
            $list['total_pre_money'] = $mGsh->TotalPreMoney($start_date,$goods_ids);
            $list['total_instock_nums'] = $mGsh->InstockNums($start_date,$end_date,$goods_ids);
            $list['total_instock_money'] = $mGsh->InstockMoney($start_date,$end_date,$goods_ids);
            $list['total_outstock_nums'] = $mGsh->OutstockNums($start_date,$end_date,$goods_ids);
            $list['total_outstock_money'] = $mGsh->OutstockMoney($start_date,$end_date,$goods_ids);
            $list['total_purchase_nums'] = $mGsh->PurchaseNums($start_date,$end_date,$goods_ids);
            $list['total_purchase_money'] = $mGsh->PurchaseMoney($start_date,$end_date,$goods_ids);
            $list['total_sale_nums'] = $mGsh->SaleNums($start_date,$end_date,$goods_ids);
            $list['total_sale_money'] = $mGsh->SaleMoney($start_date,$end_date,$goods_ids);
            $list['total_cost_money'] = $mGsh->CostMoney($start_date,$end_date,$goods_ids);
            $list['total_mao_money'] = $list['total_sale_money'] - $list['total_cost_money'];
            $list['total_balance_nums'] = $mGsh->TotalBalanceNums($end_date,$goods_ids);
            $list['total_balance_money'] = $mGsh->TotalBalanceMoney($end_date,$goods_ids);
            return $list;
        } else {
            $child_menu_list = array(
                array(
                    'url' => "account/shopGoodsSalesList",
                    'menu_name' => "商品分析",
                    "active" => 0
                ),
                array(
                    'url' => "account/bestSellerGoods",
                    'menu_name' => "热卖商品",
                    "active" => 0
                ),
                array(
                    'url' => "account/purchaseSellStock",
                    'menu_name' => "进销存",
                    "active" => 1
                )
            );
            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Account/purchaseSellStock");
        }
    }

    public function purDataExcel()
    {
        $xlsName = '商品进销存';
        $xlsCell = [
            ['goods_id','商品ID'],
            ['goods_name','商品名称(规格)'],
            ['pre_nums','期初数量'],
            ['pre_money','期初金额'],
            ['instock_nums','入库数量'],
            ['instock_money','入库金额'],
            ['outstock_nums','出库数量'],
            ['outstock_money','出库金额'],
            ['inner_outstock_nums','内部出库数量'],
            ['inner_outstock_money','内部出库金额'],
            ['purchase_times','采购次数'],
            ['purchase_date','采购时间'],
            ['purchase_nums','采购数量'],
            ['purchase_money','采购金额'],
            ['sale_nums','销售数量'],
            ['sale_money','销售金额'],
            ['mao_money','销售毛利'],
            ['balance_nums','结存数量'],
            ['balance_money','结存金额'],
        ];

        $goods_name = request()->get("goods_name", '');
        $start_date = request()->get('start_date','');
        $end_date = request()->get('end_date','');
        if(empty($start_date) || empty($end_date)){
            $start_date = date('Y-m-01',time());
            $end_date = date('Y-m-d', strtotime("$start_date +1 month -1 day"));
        }

        $condition['pre_nums'] = ['gt',0];
        $condition['start_int_day'] = date('Ymd',strtotime($start_date));
        $condition['end_int_day'] = date('Ymd',strtotime($end_date));
        $mGoods = new NsGoodsModel();
        if(!empty($goods_name)){
            $where_goods['goods_name'] = ['like','%'.$goods_name.'%'];
            $goods_ids = $mGoods->where($where_goods)->column('goods_id');
            $condition['goods_id'] = ['in',$goods_ids];
        }

        $mGs = new NsReportGoodsSkuModel();
        $list = $mGs->pageQuery(1,0,$condition,'goods_id asc','*');
        foreach ($list['data'] as &$item) {
            $m_goods = $mGoods->where('goods_id',$item['goods_id'])->find();
            $m_goods_sku = NsGoodsSkuModel::get($item['sku_id']);
            $item['goods_name'] = $m_goods_sku['sku_name'] ? $m_goods['goods_name'].'( '.$m_goods_sku['sku_name'].')' : $m_goods['goods_name'];
        }

        dataExcel($xlsName,$xlsCell,$list['data']);
    }



    public function purTotalDataExcel()
    {
        $xlsName = '商品进销存';
        $xlsCell = [
            ['goods_id','商品ID'],
            ['goods_name','商品名称(规格)'],
            ['pre_nums','期初数量'],
            ['pre_money','期初金额'],
            ['instock_nums','入库数量'],
            ['instock_money','入库金额'],
            ['outstock_nums','出库数量'],
            ['outstock_money','出库金额'],
            ['purchase_nums','采购数量'],
            ['purchase_money','采购金额'],
            ['sale_nums','销售数量'],
            ['sale_money','销售金额'],
            ['mao_money','销售毛利'],
            ['balance_nums','结存数量'],
            ['balance_money','结存金额'],
        ];

        $goods_name = request()->get("goods_name", '');
        $start_date = request()->get('start_date','');
        $end_date = request()->get('end_date','');
        if(empty($start_date) || empty($end_date)){
            $start_date = date('Y-m-01',time());
            $end_date = date('Y-m-d', strtotime("$start_date +1 month -1 day"));
        }

        $condition['stock'] = ['gt',0];
        $mGoods = new NsGoodsModel();
        if(!empty($goods_name)){
            $condition['goods_name'] = ['like','%'.$goods_name.'%'];
        }

        $list = $mGoods->pageQuery(1,0,$condition,'goods_id asc','*');
        foreach ($list['data'] as &$item) {
            $mRgs = new NsReportGoodsSkuModel();
            $where['start_int_day'] = date('Ymd',strtotime($start_date));
            $where['end_int_day'] = date('Ymd',strtotime($end_date));
            $where['goods_id'] = $item['goods_id'];
            $item['pre_nums'] = $mRgs->where($where)->sum('pre_nums');
            $item['pre_money'] = $mRgs->where($where)->sum('pre_money');
            $item['instock_nums'] = $mRgs->where($where)->sum('instock_nums');
            $item['instock_money'] = $mRgs->where($where)->sum('instock_money');
            $item['outstock_nums'] = $mRgs->where($where)->sum('outstock_nums');
            $item['outstock_money'] = $mRgs->where($where)->sum('outstock_money');
            $item['inner_outstock_nums'] = $mRgs->where($where)->sum('inner_outstock_nums');
            $item['inner_outstock_money'] = $mRgs->where($where)->sum('inner_outstock_money');
            $item['purchase_nums'] = $mRgs->where($where)->sum('purchase_nums');
            $item['purchase_money'] = $mRgs->where($where)->sum('purchase_money');
            $item['sale_nums'] = $mRgs->where($where)->sum('sale_nums');
            $item['sale_money'] = $mRgs->where($where)->sum('sale_money');
            $item['mao_money'] = $mRgs->where($where)->sum('mao_money');
            $item['balance_nums'] = $mRgs->where($where)->sum('balance_nums');
            $item['balance_money'] = $mRgs->where($where)->sum('balance_money');
        }

        dataExcel($xlsName,$xlsCell,$list['data']);
    }


    public function purchaseSellStock1()
    {
        if (request()->isAjax()) {
            $goods = new Goods();
            $page_index = request()->post('page_index', 1);
            $page_size = request()->post('page_size', PAGESIZE);
            $goods_name = request()->post("goods_name", '');
            $condition = array();

            if ($goods_name != '') {
                $condition["ng.goods_name"] = array(
                    'like',
                    '%' . $goods_name . '%'
                );
            }
            $condition["ng.shop_id"] = $this->instance_id;
            $list = $goods->getGoodsList($page_index, $page_size, $condition, 'create_time desc');
            $params = [];

            $start_date = request()->post('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('start_date'));
            $end_date = request()->post('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('end_date'));
            if ($start_date != 0 && $end_date != 0) {
                $params["time"] = ['between',[$start_date,$end_date]];
            } elseif ($start_date != 0 && $end_date == 0) {
                $params["time"] = ['gt',$start_date];
            } elseif ($start_date == 0 && $end_date != 0) {
                $params["time"] = ['lt',$start_date];
            }
            foreach ($list['data'] as &$item) {
                $params['goods_id'] = $item['goods_id'];
                $mStock = new Stock();
                $item['instock_nums'] = $mStock->getInstockNums($params);
                $item['instock_money'] = $mStock->getInstockMoney($params);
                $item['outstock_nums'] = $mStock->getOutstockNums($params);
                $item['outstock_money'] = $mStock->getOutStockMoney($params);
                $cost_money = $mStock->getCostMoney($params);
                $temporary_cost_money = $item['temporary_stock'] * $item['cost_price'];
                $item['cost_money'] = $cost_money + $temporary_cost_money;
            }
            return $list;
        } else {
            $child_menu_list = array(
                array(
                    'url' => "account/shopGoodsSalesList",
                    'menu_name' => "商品分析",
                    "active" => 0
                ),
                array(
                    'url' => "account/bestSellerGoods",
                    'menu_name' => "热卖商品",
                    "active" => 0
                ),
                array(
                    'url' => "account/purchaseSellStock1",
                    'menu_name' => "进销存",
                    "active" => 1
                )
            );
            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Account/purchaseSellStock1");
        }
    }


    public function purDataExcel1()
    {
        $xlsName = '商品进销存';
        $xlsCell = [
            ['goods_name','商品名称'],
            ['instock_nums','入库数量'],
            ['instock_money','入库金额'],
            ['outstock_nums','出库数量'],
            ['outstock_money','出库金额'],
            ['total_stock','库存总数'],
            ['cost_money','库存成本'],
        ];

        $goods_name = request()->get("goods_name", '');
        $condition = array();
        if ($goods_name != '') {
            $condition["ng.goods_name"] = array(
                'like',
                '%' . $goods_name . '%'
            );
        }

        $goods = new Goods();
        $condition["ng.shop_id"] = $this->instance_id;
        $list = $goods->getGoodsList(1, 0, $condition, 'create_time desc');
        //print_r($list);exit;
        $params = [];

        $start_date = request()->post('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('start_date'));
        $end_date = request()->post('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('end_date'));
        if ($start_date != 0 && $end_date != 0) {
            $params["time"] = ['between',[$start_date,$end_date]];
        } elseif ($start_date != 0 && $end_date == 0) {
            $params["time"] = ['gt',$start_date];
        } elseif ($start_date == 0 && $end_date != 0) {
            $params["time"] = ['lt',$start_date];
        }
        foreach ($list['data'] as &$item) {
            $params['goods_id'] = $item['goods_id'];
            $mStock = new Stock();
            $item['instock_nums'] = $mStock->getInstockNums($params);
            $item['instock_money'] = $mStock->getInstockMoney($params);
            $item['outstock_nums'] = $mStock->getOutstockNums($params);
            $item['outstock_money'] = $mStock->getOutStockMoney($params);
            $item['total_stock'] = $item['stock'] + $item['temporary_stock'];
            $cost_money = $mStock->getCostMoney($params);
            $temporary_cost_money = $item['temporary_stock'] * $item['cost_price'];
            $item['cost_money'] = $cost_money.'/'.$temporary_cost_money;
        }

        dataExcel($xlsName,$xlsCell,$list['data']);
    }


    /**
     * 商品销售chart数据
     *
     * @return multitype:multitype:unknown
     */
    public function getGoodsSalesChartCount()
    {
        $date = request()->post('date',1);
        $type = request()->post('type',1);
        $category_id_1 = request()->post('category_id_1','');
        $category_id_2 = request()->post('category_id_2','');
        $category_id_3 = request()->post('category_id_3','');
        if ($date == 1) {
            list ($start, $end) = Time::today();
            $start_date = getTimeTurnTimeStamp(date("Y-m-d H:i:s", $start));
            $end_date = getTimeTurnTimeStamp(date("Y-m-d H:i:s", $end));
        } else
            if ($date == 3) {
                $start_date = getTimeTurnTimeStamp(date('Y-m-d 00:00:00', strtotime('last day this week + 1 day')));
                $end_date = getTimeTurnTimeStamp(date('Y-m-d 00:00:00', strtotime('last day this week +8 day')));
            } else
                if ($date == 4) {
                    list ($start, $end) = Time::month();
                    $start_date = getTimeTurnTimeStamp(date("Y-m-d H:i:s", $start));
                    $end_date = getTimeTurnTimeStamp(date("Y-m-d H:i:s", $end));
                }
        $condition = array();
        $condition["shop_id"] = $this->instance_id;
        if ($category_id_1 != '') {
            $condition["category_id_1"] = $category_id_1;
            if ($category_id_2 != '') {
                $condition["category_id_2"] = $category_id_2;
                if ($category_id_3 != '') {
                    $condition["category_id_3"] = $category_id_3;
                }
            }
        }
        $order = new Order();
        $goods_list = $order->getShopGoodsSalesQuery($this->instance_id, $start_date, $end_date, $condition);
        if ($type == 1) {
            $sort_array = array();
            foreach ($goods_list as $k => $v) {
                $sort_array[$v["goods_name"]] = $v["sales_money"];
            }
            arsort($sort_array);
            $sort = array();
            $num = array();
            $i = 0;
            foreach ($sort_array as $t => $b) {
                if ($i < 30) {
                    $sort[] = $t;
                    $num[] = $b;
                    $i ++;
                } else {
                    break;
                }
            }
            return array(
                $sort,
                $num
            );
        } else
            if ($type == 2) {
                $sort_array = array();
                foreach ($goods_list as $k => $v) {
                    $sort_array[$v["goods_name"]] = $v["sales_num"];
                }
                arsort($sort_array);
                $sort = array();
                $money = array();
                $i = 0;
                foreach ($sort_array as $t => $b) {
                    if ($i < 30) {
                        $sort[] = $t;
                        $money[] = $b;
                        $i ++;
                    } else {
                        break;
                    }
                }
                return array(
                    $sort,
                    $money
                );
            }
    }
    /**
     * 运营报告
     */
    public function shopReport()
    {
        return view($this->style . "Account/shopReport");
    }

    /**
     * 店铺下单量/下单金额图标数据
     *
     * @return Ambigous <multitype:, unknown>
     */
    public function getShopOrderChartCount()
    {
        $date = request()->post('date',1);
        $type = request()->post('type',1);
        $order = new Order();
        $data = array();
        if ($date == 1) {
            list ($start, $end) = Time::today();
            for ($i = 0; $i < 24; $i ++) {
                $date_start = date("Y-m-d H:i:s", $start + 3600 * $i);
                $date_end = date("Y-m-d H:i:s", $start + 3600 * ($i + 1));
                $condition = [
                    'shop_id' => $this->instance_id,
                    'create_time' => [
                        'between',
                        [
                            getTimeTurnTimeStamp($date_start),
                            getTimeTurnTimeStamp($date_end)
                        ]
                    ],
                    "order_status" => [
                        'NEQ',
                        0
                    ],
                    "order_status" => [
                        'NEQ',
                        5
                    ]
                ];
                $count = $this->getShopSaleData($condition, $type);
                $data[0][$i] = $i . ':00';
                $data[1][$i] = $count;
            }
        } else
            if ($date == 2) {
                list ($start, $end) = Time::yesterday();
                for ($j = 0; $j < 24; $j ++) {
                    $date_start = date("Y-m-d H:i:s", $start + 3600 * $j);
                    $date_end = date("Y-m-d H:i:s", $start + 3600 * ($j + 1));
                    $condition = [
                        'shop_id' => $this->instance_id,
                        'create_time' => [
                            'between',
                            [
                                getTimeTurnTimeStamp($date_start),
                                getTimeTurnTimeStamp($date_end)
                            ]
                        ],
                        "order_status" => [
                            'NEQ',
                            0
                        ],
                        "order_status" => [
                            'NEQ',
                            5
                        ]
                    ];
                    $count = $this->getShopSaleData($condition, $type);
                    $data[0][$j] = $j . ':00';
                    $data[1][$j] = $count;
                }
            } else
                if ($date == 3) {
                    $start = strtotime(date('Y-m-d 00:00:00', strtotime('last day this week + 1 day')));
                    for ($j = 0; $j < 7; $j ++) {
                        $date_start = date("Y-m-d H:i:s", $start + 86400 * $j);
                        $date_end = date("Y-m-d H:i:s", $start + 86400 * ($j + 1));
                        $condition = [
                            'shop_id' => $this->instance_id,
                            'create_time' => [
                                'between',
                                [
                                    getTimeTurnTimeStamp($date_start),
                                    getTimeTurnTimeStamp($date_end)
                                ]
                            ],
                            "order_status" => [
                                'NEQ',
                                0
                            ],
                            "order_status" => [
                                'NEQ',
                                5
                            ]
                        ];
                        $count = $this->getShopSaleData($condition, $type);
                        $data[0][$j] = '星期' . ($j + 1);
                        $data[1][$j] = $count;
                    }
                } else
                    if ($date == 4) {
                        list ($start, $end) = Time::month();
                        for ($j = 0; $j < ($end + 1 - $start) / 86400; $j ++) {
                            $date_start = date("Y-m-d H:i:s", $start + 86400 * $j);
                            $date_end = date("Y-m-d H:i:s", $start + 86400 * ($j + 1));
                            $condition = [
                                'shop_id' => $this->instance_id,
                                'create_time' => [
                                    'between',
                                    [
                                        getTimeTurnTimeStamp($date_start),
                                        getTimeTurnTimeStamp($date_end)
                                    ]
                                ],
                                "order_status" => [
                                    'NEQ',
                                    0
                                ],
                                "order_status" => [
                                    'NEQ',
                                    5
                                ]
                            ];
                            $count = $this->getShopSaleData($condition, $type);
                            $data[0][$j] = (1 + $j) . '日';
                            $data[1][$j] = $count;
                        }
                    }
        return $data;
    }
    /**
     * 查询一段时间内的总下单量及下单金额
     *
     * @return multitype:\app\admin\controller\Ambigous Ambigous <\app\admin\controller\Ambigous, number, \data\service\niushop\unknown, \data\service\niushop\Order\unknown, unknown>
     */
    public function getOrderShopSaleCount()
    {
        $date = request()->post('date',1);
        // 查询一段时间内的下单量及下单金额
        if ($date == 1) {
            list ($start, $end) = Time::today();
            $start_date = date("Y-m-d H:i:s", $start);
            $end_date = date("Y-m-d H:i:s", $end);
        } else if ($date == 3) {
            $start_date = date('Y-m-d 00:00:00', strtotime('last day this week + 1 day'));
            $end_date = date('Y-m-d 00:00:00', strtotime('last day this week +8 day'));
        } else if ($date == 4) {
            list ($start, $end) = Time::month();
            $start_date = date("Y-m-d H:i:s", $start);
            $end_date = date("Y-m-d H:i:s", $end);
        }
        $condition = array();
        $condition["shop_id"] = $this->instance_id;
        $condition["shop_id"];
        $condition["create_time"] = [
            'between',
            [
                getTimeTurnTimeStamp($start_date),
                getTimeTurnTimeStamp($end_date)
            ]
        ];
        $count_money = $this->getShopSaleData($condition, 1);
        $count_num = $this->getShopSaleData($condition, 2);
        return array(
            "count_money" => $count_money,
            "count_num" => $count_num
        );
    }
    /**
     * 收款统计 确收
     * @return [type] [description]
     */
    public function income()
    {
        if(request()->isAjax()){
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
            $end_date = request()->post('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');
            $payment = request()->post('payment',0);
            $condition['refund_status'] = 0;

            $mOrderModel = new NsOrderModel();
            $where_order = [];
            if ($start_date != 0 && $end_date != 0) {
                $where_order["create_time"] = ['between',[$start_date,$end_date]];
            }elseif ($start_date != 0 && $end_date == 0) {
                $where_order["create_time"] = ["gt",$start_date];
            }elseif ($start_date == 0 && $end_date != 0) {
                $where_order["create_time"] = ["lt",$end_date];
            }
            if($payment){
                $where_order['payment_type'] = $payment;
            }
            $order_ids = $mOrderModel->where($where_order)->column('order_id');
            if(!empty($order_ids)){
                $condition['order_id'] = ['in',$order_ids];
            }

            $mOrder = new Order();
            $list = $mOrder->getConfirmOrderGoodsList($page_index,$page_size,$condition,'order_goods_id desc');
            foreach ($list['data'] as &$item){
                $order_info = $mOrderModel->where('order_id',$item['order_id'])->find();
                $item['order_no'] = $order_info['order_no'];
                $item['account'] = $order_info['user_name'];
                $item['receiver_name'] = $order_info['receiver_name'];
                $item['receiver_mobile'] = $order_info['receiver_mobile'];
                if($item['sku_name']){
                    $item['goods_info'] = $item['goods_name'].'('.$item['sku_name'].') X '.$item['num'];
                }else{
                    $item['goods_info'] = $item['goods_name'].' X '.$item['num'];
                }
                $item['order_money'] = $item['goods_money'];
                $item['create_time'] = $order_info['create_time'];
                $item['payment_type'] = $order_info['payment_type'];
            }

            $list['count_num'] = $mOrderModel->where($where_order)->count();
            $refund_money = $mOrderModel->where($where_order)->sum('refund_money');
            $pay_money = $mOrderModel->where($where_order)->sum('pay_money');
            $promotion_money = $mOrderModel->where($where_order)->sum('promotion_money');
            $point_money = $mOrderModel->where($where_order)->sum('point_money');
            $shipping_money = $mOrderModel->where($where_order)->sum('shipping_money');
            $list['count_money'] = $pay_money - $refund_money - $promotion_money - $point_money - $shipping_money;
            $list['shipping_money'] = $shipping_money;

            return $list;

        }else{
            $child_menu_list = array(
                array(
                    'url' => "account/income",
                    'menu_name' => "收款统计",
                    "active" => 1
                ),
                array(
                    'url' => "account/payout",
                    'menu_name' => "退款统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/purchase",
                    'menu_name' => "采购统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/sell",
                    'menu_name' => "进销存",
                    "active" => 0
                )
            );
            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Account/income");
        }

    }


    public function orderMoneyDataExcel()
    {
        $xlsName = '收款统计';
        $xlsCell = [
            ['order_no','订单编号'],
            ['receiver_name','姓名'],
            ['receiver_mobile','联系方式'],
            ['goods_info','商品信息'],
            ['order_money','订单金额'],
            ['create_time','订单时间'],
            ['payment_type','支付方式'],
        ];
        $start_date = request()->get('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('start_date').' 00:00:00');
        $end_date = request()->get('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('end_date').' 23:59:59');
        $payment_type = request()->get('payment_type',0);
        $condition['shop_id'] = $this->instance_id;

        $condition['refund_status'] = 0;
        $mOrderModel = new NsOrderModel();
        $where_order = [];
        if ($start_date != 0 && $end_date != 0) {
            $where_order["create_time"] = ['between',[$start_date,$end_date]];
        }elseif ($start_date != 0 && $end_date == 0) {
            $where_order["create_time"] = ["gt",$start_date];
        }elseif ($start_date == 0 && $end_date != 0) {
            $where_order["create_time"] = ["lt",$end_date];
        }
        if($payment_type){
            $where_order['payment_type'] = $payment_type;
        }
        $order_ids = $mOrderModel->where($where_order)->column('order_id');
        if(!empty($order_ids)){
            $condition['order_id'] = ['in',$order_ids];
        }

        $mOrder = new Order();
        $list = $mOrder->getConfirmOrderGoodsList(1,0,$condition,'order_goods_id desc');
        foreach ($list['data'] as &$item){
            $order_info = $mOrderModel->where('order_id',$item['order_id'])->find();
            $item['order_no'] = $order_info['order_no'];
            $item['account'] = $order_info['user_name'];
            $item['receiver_name'] = $order_info['receiver_name'];
            $item['receiver_mobile'] = $order_info['receiver_mobile'];
            if($item['sku_name']){
                $item['goods_info'] = $item['goods_name'].'('.$item['sku_name'].') X '.$item['num'];
            }else{
                $item['goods_info'] = $item['goods_name'].' X '.$item['num'];
            }
            $item['order_money'] = $item['goods_money'];
            $item['create_time'] = date('Y-m-d H:i:s',$order_info['create_time']);
            //$item['payment_type'] = $order_info['payment_type'];
            if($order_info['payment_type'] == 1){
                $item['payment_type'] = '微信支付';
            }elseif($order_info['payment_type'] == 2){
                $item['payment_type'] = '支付宝支付';
            }else{
                $item['payment_type'] = '线下支付';
            }
        }

        dataExcel($xlsName,$xlsCell,$list['data']);
    }



    /**
     * 退款统计
     * @return [type] [description]
     */
    public function payout()
    {
        if(request()->isAjax()){
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
            $end_date = request()->post('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');

            $condition['refund_status'] = ['gt',0];
            if ($start_date != 0 && $end_date != 0) {
                $condition["refund_time"] = [
                    ["gt",$start_date],
                    ["lt",$end_date]
                ];
            }elseif ($start_date != 0 && $end_date == 0) {
                $condition["refund_time"] = [
                    ["gt",$start_date]
                ];
            }elseif ($start_date == 0 && $end_date != 0) {
                $condition["refund_time"] = [
                    ["lt",$end_date]
                ];
            }

            $mOrder = new Order();
            $list = $mOrder->getConfirmOrderGoodsList($page_index,$page_size,$condition,'refund_time desc');
            $mOrderRefundAccountRecords = new NsOrderRefundAccountRecordsModel();
            foreach ($list['data'] as &$item){
                $order_refund_account_records_info = $mOrderRefundAccountRecords->where('order_goods_id',$item['order_goods_id'])->find();
                if(!empty($order_refund_account_records_info)) {
                    $item['refund_trade_no'] = $order_refund_account_records_info['refund_trade_no'];
                }else{
                    $item['refund_trade_no'] = '-';
                }
                $item['refund_money'] = $item['refund_real_money'];
                $item['goods_info'] = $item['goods_name'];
                $item['refund_time'] = strtotime($item['refund_time']);
                $item['remark'] = $item['refund_reason'];
                $order_info = (new NsOrderModel)->where('order_id',$item['order_id'])->find();
                if(!empty($order_info)){
                    $item['user_name'] = $order_info['user_name'];
                }else{
                    $item['user_name'] = '-';
                }
            }
            $list['refund_num'] = count($list['data']);
            $list['refund_money'] = array_sum(array_column($list['data'],'refund_real_money'));
            return $list;
        }else{
            $child_menu_list = array(
                array(
                    'url' => "account/income",
                    'menu_name' => "收款统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/payout",
                    'menu_name' => "退款统计",
                    "active" => 1
                ),
                array(
                    'url' => "account/purchase",
                    'menu_name' => "采购统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/sell",
                    'menu_name' => "进销存",
                    "active" => 0
                )
            );
            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Account/payout");
        }
        
    }

    /**
     * 导出退款数据
     * @return [type] [description]
     */
    public function refundMoneyDataExcel()
    {
        $xlsName = '退款统计';
        $xlsCell = [
            ['refund_trade_no','退款交易号'],
            ['user_name','客户名称'],
            ['goods_info','商品信息'],
            ['refund_money','退款金额'],
            ['refund_time','退款时间'],
            ['remark','备注']
        ];

        $start_date = request()->get('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('start_date').' 00:00:00');
        $end_date = request()->get('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->get('end_date').' 23:59:59');
        $condition = [];
        if($start_date != 0 && $end_date != 0){
            $condition['refund_time'] = ['between',[$start_date,$end_date]];
        }else if($start_date ==0 && $end_date != 0){
            $condition['refund_time'] = ['lt',$end_date];
        }else if($start_date != 0 && $end_date == 0){
            $condition['refund_time'] = ['gt',$start_date];
        }
        // $condition['shop_id'] = $this->instance_id;
        $condition['refund_status'] = ['gt',0];

        $mOrder = new Order();
        $list = $mOrder->getConfirmOrderGoodsList(1,0,$condition,'refund_time desc');
        $mOrderRefundAccountRecords = new NsOrderRefundAccountRecordsModel();
        foreach ($list['data'] as &$item){
            $order_refund_account_records_info = $mOrderRefundAccountRecords->where('order_goods_id',$item['order_goods_id'])->find();
            if(!empty($order_refund_account_records_info)) {
                $item['refund_trade_no'] = $order_refund_account_records_info['refund_trade_no'];
            }else{
                $item['refund_trade_no'] = '-';
            }
            $item['refund_money'] = $item['refund_real_money'];
            $item['goods_info'] = $item['goods_name'];
            $item['refund_time'] = strtotime($item['refund_time']);
            $item['remark'] = $item['refund_reason'];
            $order_info = (new NsOrderModel)->where('order_id',$item['order_id'])->find();
            if(!empty($order_info)){
                $item['user_name'] = $order_info['user_name'];
            }else{
                $item['user_name'] = '-';
            }
        }

        dataExcel($xlsName,$xlsCell,$list['data']);
    }

    /**
     * 采购统计
     * @return [type] [description]
     */
    public function purchase()
    {
        if(request()->isAjax()){
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
            $end_date = request()->post('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');
            $goods_name = request()->post('goods_name','');
            $status = request()->post('status','');
            $condition = [];
            if($start_date != 0 && $end_date != 0){
                $condition['create_time'] = ['between',[$start_date,$end_date]];
            }elseif($start_date != 0 && $end_date ==0){
                $condition['create_time'] = ['gt',$start_date];
            }elseif($start_date == 0 && $end_date != 0){
                $condition['create_time'] = ['lt',$end_date];
            }
            if(!empty($goods_name)){
                $condition['goods_name'] = ['like','%'.$goods_name.'%'];
            }
            if(in_array($status,[0,1,2]) && $status != ''){
                $condition['status'] = $status;
            }

            $mPurchaseGoods = new PurchaseGoods();
            $list = $mPurchaseGoods->getPurchaseGoodsCount($page_index,$page_size,$condition,'create_time desc');

            return $list;
        }else{
            $child_menu_list = array(
                array(
                    'url' => "account/income",
                    'menu_name' => "收款统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/payout",
                    'menu_name' => "退款统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/purchase",
                    'menu_name' => "采购统计",
                    "active" => 1
                ),
                array(
                    'url' => "account/sell",
                    'menu_name' => "进销存",
                    "active" => 0
                )
            );
            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Account/purchase");
        }
    }


    public function purchaseDataExcel()
    {
        $xlsName = '采购统计';
        $xlsCell = [
            ['goods_name','商品名称'],
            ['status_name','入库状态'],
            ['price','采购单价'],
            ['num','采购数量'],
            ['goods_money','采购金额'],
            ['in_num','已入库数量'],
            ['create_time','采购时间']
        ];

        $start_date = request()->post('start_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
        $end_date = request()->post('end_date') == '' ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');
        $goods_name = request()->post('goods_name','');
        $status = request()->post('status','');
        $condition = [];
        if($start_date != 0 && $end_date != 0){
            $condition['create_time'] = ['between',[$start_date,$end_date]];
        }elseif($start_date != 0 && $end_date ==0){
            $condition['create_time'] = ['gt',$start_date];
        }elseif($start_date == 0 && $end_date != 0){
            $condition['create_time'] = ['lt',$end_date];
        }
        if(!empty($goods_name)){
            $condition['goods_name'] = ['like','%'.$goods_name.'%'];
        }
        if(in_array($status,[0,1,2]) && $status != ''){
            $condition['status'] = $status;
        }

        $mPurchaseGoods = new PurchaseGoods();
        $list = $mPurchaseGoods->getPurchaseGoodsCount(1,0,$condition,'create_time desc');
        foreach ($list['data'] as $item) {
            $item['create_time'] = getTimeStampTurnTime($item['create_time']);
        }

        dataExcel($xlsName,$xlsCell,$list['data']);
    }


    /**
     * 退款统计
     * @return [type] [description]
     */
    public function sell()
    {
        if(request()->isAjax()){
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);
            $start_date = request()->post('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('start_date').' 00:00:00');
            $end_date = request()->post('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->post('end_date').' 23:59:59');
            $stock = request()->post('stock', '');
            $type = request()->post('type', '');
            $goods_name = request()->post('goods_name','');
            $condition = [];
            if($start_date != 0 && $end_date != 0){
                $condition['time'] = ['between',[$start_date,$end_date]];
            }else if($start_date != 0 && $end_date == 0){
                $condition['time'] = ['gt',$start_date];
            }else if($start_date == 0 && $end_date != 0){
                $condition['time'] = ['lt',$end_date];
            }

            if($stock == 1){
                $condition['is_instock'] = 1;
            }elseif($stock == 2){
                $condition['is_instock'] = 2;
            }

            if(!empty($type)){
                $condition['stock_type'] = $type;
            }

            if(!empty($goods_name)){
                $condition['goods_name'] = ['like','%'.$goods_name.'%'];
            }
            $condition['shop_id'] = $this->instance_id;

            $mStock = new Stock();
            $list = $mStock->getStockList($page_index,$page_size,$condition,'stock_id desc');
            foreach ($list['data'] as &$item) {
                $mType = new NsTypeModel();
                $type = $mType->where('type_id',$item['stock_type'])->find();
                if($type){
                    $item['stock_type'] = $type['type_name'];
                }else{
                    $item['stock_type'] = '其他';
                }

            }
            return $list;
        }else{
            $child_menu_list = array(
                array(
                    'url' => "account/income",
                    'menu_name' => "收款统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/payout",
                    'menu_name' => "退款统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/purchase",
                    'menu_name' => "采购统计",
                    "active" => 0
                ),
                array(
                    'url' => "account/sell",
                    'menu_name' => "进销存",
                    "active" => 1
                )
            );

            $mType = new Type();
            $stock_list = $mType->getList(1,0,'','type_id desc');
            $this->assign("stock_list", $stock_list['data']);

            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Account/sell");
        }

    }

    public function sellDataExcel()
    {
        $xlsName = '进销存';
        $xlsCell = [
            ['goods_name','商品名称'],
            ['cost_price','成本价'],
            ['price','销售价'],
            ['is_instock','入/出库'],
            ['nums','数量'],
            ['money','金额'],
            ['stock_type','类型'],
            ['time','时间']
        ];

        $start_date = request()->get('start_date') == "" ? 0 : getTimeTurnTimeStamp(request()->get('start_date').' 00:00:00');
        $end_date = request()->get('end_date') == "" ? 0 : getTimeTurnTimeStamp(request()->get('end_date').' 23:59:59');
        $stock = request()->get('stock', '');
        $type = request()->get('type', '');
        $goods_name = request()->get('goods_name','');
        $condition = [];
        if($start_date != 0 && $end_date != 0){
            $condition['time'] = ['between',[$start_date,$end_date]];
        }else if($start_date != 0 && $end_date == 0){
            $condition['time'] = ['gt',$start_date];
        }else if($start_date == 0 && $end_date != 0){
            $condition['time'] = ['lt',$end_date];
        }

        if($stock == 1){
            $condition['is_instock'] = 1;
        }elseif($stock == 2){
            $condition['is_instock'] = 2;
        }

        if(!empty($type)){
            $condition['stock_type'] = $type;
        }

        if(!empty($goods_name)){
            $condition['goods_name'] = ['like','%'.$goods_name.'%'];
        }
        $condition['shop_id'] = $this->instance_id;

        $mStock = new Stock();
        $list = $mStock->getStockList(1,0,$condition,'stock_id desc');
        foreach ($list['data'] as &$item) {
            //$item['time'] = getTimeStampTurnTime($item['time']);
            $item['is_instock'] = ($item['is_instock'] == 1) ? '入库' : '出库';
            $mType = new NsTypeModel();
            $stock_type = $mType->where('type_id',$item['stock_type'])->find();
            if($stock_type){
                $item['stock_type'] = $stock_type['type_name'];
            }else{
                $item['stock_type'] = '其他';
            }
            if(isset($item['goods_sku']) && $item['goods_sku']['sku_name']){
                $item['cost_price'] = $item['goods_sku']['cost_price'];
                $item['price'] = $item['goods_sku']['price'];
            }else{
                $item['cost_price'] = $item['goods']['cost_price'];
                $item['price'] = $item['goods']['price'];
            }
        }

        dataExcel($xlsName,$xlsCell,$list['data']);
    }





    /**
     * [getShopRefundData description]
     * @param  [type] $condition [description]
     * @param  [type] $type      [description]
     * @return [type]            [description]
     */
    public function getShopRefundData($condition, $type)
    {
        $order = new Order();
        if($type == 1){
            $count = $order->getShopRefundSum($condition);
            $count = (float) sprintf('%.2f', $count);
        }else{
            $count = $order->getShopRefundNumSum($condition);
        }
        return $count;
    }
    /**
     * 下单量/下单金额 数据
     * @param unknown $condition
     * @param unknown $type
     * @return Ambigous <\data\service\niushop\Ambigous, \data\service\niushop\Order\unknown, number, unknown>
     */
    public function getShopSaleData($condition, $type)
    {
        $order = new Order();
        if ($type == 1) {
            $count = $order->getShopSaleSum($condition);
            $count = (float) sprintf('%.2f', $count);
        } else {
            $count = $order->getShopSaleNumSum($condition);
        }
        return $count;
    }
    /**
     * 同行商品买卖
     */
    public function shopGoodsGroupSaleCount()
    {
        $goods_category = new GoodsCategory();
        $list = $goods_category->getGoodsCategoryListByParentId(0);
        $this->assign("cateGoryList", $list);
        return view($this->style . "Account/shopGoodsGroupSaleCount");
    }
    public function checkOrder()
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
            if($start_date != 0 && $end_date != 0){
                $condition['create_time'] = ['between',[$start_date,$end_date]];
            }elseif($start_date != 0 && $end_date == 0){
                $condition['create_time'] = ['gt',$start_date];
            }elseif($start_date == 0 && $end_date != 0){
                $condition['create_time'] = ['lt',$end_date];
            }

            $condition['order_status'] = $order_status;
            
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
            $child_menu_list = array(
                array(
                    'url' => "account/checkorder&status=2&check_pay_status=0",
                    'menu_name' => "待审核",
                    "active" => 1
                ),
                array(
                    'url' => "account/checkorderfinish&check_pay_status=1",
                    'menu_name' => "已完成",
                    "active" => 0
                )
            );
            $this->assign('child_menu_list', $child_menu_list);
            $this->assign("status", $status);
            $this->assign('check_pay_status', $check_pay_status);
            return view($this->style . "Account/checkOrder");
        }
    }
    public function checkOrderFinish()
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
                $condition['create_time'] = ['between',[$start_date,$end_date]];
            } elseif ($start_date != 0 && $end_date == 0) {
                $condition['create_time'] = ['gt',$start_date];
            } elseif ($start_date == 0 && $end_date != 0) {
                $condition['create_time'] = ['lt',$end_date];
            }
     
            $condition['order_status'] = $order_status;
          
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
            $child_menu_list = array(
                array(
                    'url' => "account/checkorder&status=2&check_pay_status=0",
                    'menu_name' => "待审核",
                    "active" => 0
                ),
                array(
                    'url' => "account/checkorderfinish&check_pay_status=1",
                    'menu_name' => "已完成",
                    "active" => 1
                )
            );
            $this->assign('child_menu_list', $child_menu_list);
            $this->assign("status", $status);
            $this->assign('check_pay_status', $check_pay_status);
            return view($this->style . "Account/checkOrderFinish");
        }
    }
    /**
     * 审核订单详情
     * @return [type] [description]
     */
    public function checkOrderDetail()
    {
        $order_id = request()->get('order_id', 0);
        if ($order_id == 0) {
            $this->error("没有获取到订单信息");
        }
        $order_service = new Order();
        $detail = $order_service->getOrderDetail($order_id);
        if (empty($detail)) {
            $this->error("没有获取到订单信息");
        }
        if (! empty($detail['operation'])) {
            $operation_array = $detail['operation'];
            foreach ($operation_array as $k => $v) {
                if ($v["no"] == 'logistics') {
                    unset($operation_array[$k]);
                }
            }
            $detail['operation'] = $operation_array;
        }
        $this->assign("order", $detail);
        return view($this->style . "Account/checkOrderDetail");
    }

    
    public function checkRefund()
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
            $this->assign("status", $status);
            return view($this->style . "Account/checkRefund");
        }
    }



}