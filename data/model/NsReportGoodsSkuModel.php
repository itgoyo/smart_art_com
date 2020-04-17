<?php
namespace data\model;

use data\model\BaseModel as BaseModel;

class NsReportGoodsSkuModel extends BaseModel
{
    protected $table = 'ns_report_goods_sku';
    protected $rule = [
        'rgs_id' => '',
    ];
    protected $msg = [
        'rgs_id' => '',
    ];


    public function buildTimeSectionReport($page_index,$page_size,$start_date,$end_date)
    {
        $condition = [];
        $mGs = new NsGoodsSkuModel();
        $list = $mGs->pageQuery($page_index,$page_size,$condition,'goods_id asc','*');

        $data = [];
        $mGsh = new NsGoodsSkuStockHistoryModel();
        if(!empty($list['data'])){
            foreach ($list['data'] as $item) {
                $data['goods_id'] = $item['goods_id'];
                $data['sku_id'] = $item['sku_id'];
                $data['start_int_day'] = date('Ymd',strtotime($start_date));
                $data['end_int_day'] = date('Ymd',strtotime($end_date));

                $data['pre_nums'] = $mGsh->getPreNums($start_date,$item['goods_id'],$item['sku_id']);
                $data['pre_money'] = $mGsh->getPreMoney($start_date,$item['goods_id'],$item['sku_id']);
                $data['instock_nums'] = $mGsh->getInstockNums($start_date,$end_date,$item['goods_id'],$item['sku_id']);
                $data['instock_money'] = $mGsh->getInstockMoney($start_date,$end_date,$item['goods_id'],$item['sku_id']);
                $data['outstock_nums'] = $mGsh->getOutstockNums($start_date,$end_date,$item['goods_id'],$item['sku_id'],0);
                $data['outstock_money'] = $mGsh->getOutstockMoney($start_date,$end_date,$item['goods_id'],$item['sku_id'],0);
                $data['inner_outstock_nums'] = $mGsh->getOutstockNums($start_date,$end_date,$item['goods_id'],$item['sku_id'],15);
                $data['inner_outstock_money'] = $mGsh->getOutstockMoney($start_date,$end_date,$item['goods_id'],$item['sku_id'],15);
                $data['purchase_nums'] = $mGsh->getPurchaseNums($start_date,$end_date,$item['goods_id'],$item['sku_id']);
                $data['purchase_money'] = $mGsh->getPurchaseMoney($start_date,$end_date,$item['goods_id'],$item['sku_id']);
                $data['purchase_times'] = $mGsh->getPurchaseTimes($start_date,$end_date,$item['goods_id'],$item['sku_id']);
                $data['purchase_date'] = $mGsh->getPurchaseDate($start_date,$end_date,$item['goods_id'],$item['sku_id']);
                $data['sale_nums'] = $mGsh->getSaleNums($start_date,$end_date,$item['goods_id'],$item['sku_id']);
                $data['sale_money'] = $mGsh->getSaleMoney($start_date,$end_date,$item['goods_id'],$item['sku_id']);
                $data['mao_money'] = $mGsh->getMaoMoney($data['sale_nums'],$data['sale_money'],$item['sku_id']);
                $data['balance_nums'] = $mGsh->getBalanceNums($end_date,$item['goods_id'],$item['sku_id']);
                $data['balance_money'] = $mGsh->getBalanceMoney($end_date,$item['goods_id'],$item['sku_id']);

                $where['goods_id'] = $item['goods_id'];
                $where['sku_id'] = $item['sku_id'];
                $where['start_int_day'] = date('Ymd',strtotime($start_date));
                $where['end_int_day'] = date('Ymd',strtotime($end_date));
                $m_rgs = $this->where($where)->find();
                if(!empty($m_rgs)){
                    $ret = $m_rgs->data([])->allowField(true)->isUpDate(true)->save($data);
                }else{
                    $ret = $this->data([])->allowField(true)->isUpDate(false)->save($data);
                }
            }
        }
        return true;
    }



}