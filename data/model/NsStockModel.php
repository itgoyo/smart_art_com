<?php

namespace data\model;
use data\model\BaseModel as BaseModel;

class NsStockModel extends BaseModel {
    protected $table = 'ns_stock';
    protected $rule = [
        'stock_id'  =>  '',
    ];
    protected $msg = [
        'stock_id'  =>  '',
    ];

    protected function setTimeAttr($value)
    {
    	return strtotime($value);
    }

    protected function getTimeAttr($value)
    {
        return $value ? date('Y-m-d',$value) : '-';
    }

    protected function getCreateTimeAttr($value)
    {
        return $value ? date('Y-m-d  H:i:s',$value) : '-';
    }

    protected function getTypeAttr($value)
    {
        $map = [1=>'出售仓库',2=>'临时仓库'];
        if(key_exists($value,$map)){
            return $map[$value];
        }
        return '-';
    }


}