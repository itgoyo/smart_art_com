<?php
namespace app\admin\controller;

use data\service\Type as TypeModel;

class Type extends BaseController
{

    public function __construct()
    {
        parent::__construct();
    }


    public function inType()
    {
        $post = request()->post();
        $mType = new TypeModel();
        $shop_id = $this->instance_id;

        $post = array(
            'is_system' => 0,
            'stock_type' => 1,
            'type_name' => $post['type_name'],
            'shop_id' => $shop_id,
            'create_time' => time(),
            'update_time' => time()
        );

        $ret = $mType->addType($post);
        return $ret;
    }

    public function outType()
    {
        $post = request()->post();
        $mType = new TypeModel();
        $shop_id = $this->instance_id;

        $post = array(
            'is_system' => 0,
            'stock_type' => 2,
            'type_name' => $post['type_name'],
            'shop_id' => $shop_id,
            'create_time' => time(),
            'update_time' => time()
        );

        $ret = $mType->addType($post);
        return $ret;
    }

    public function deleteType()
    {
        $mType = new TypeModel();
        $post = request()->post();
        $type_id = $post['type_id'];
        $ret = $mType->deleteType($type_id);
        return $ret;
    }

    public function getTypeById()
    {
        $mType = new TypeModel();
        $type_id = request()->post('type_id');
        $res = $mType->getTypeById($type_id);
        return $res;
    }


    public function editType()
    {
        $mType = new TypeModel();
        $type_id = request()->post('type_id');
        $type_name = request()->post('type_name');
        $result = $mType->editType($type_id, $type_name);
        return AjaxReturn($result);
    }


    public function inlist()
    {
        if(request()->isAjax()){
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);

            $condition['stock_type'] = 1;

            $mType = new TypeModel();
            $list = $mType->getList($page_index,$page_size,$condition,'type_id desc');
            return $list;
        }else{
            $child_menu_list = array(
                array(
                    'url' => "type/inlist",
                    'menu_name' => "入库类型",
                    "active" => 1
                ),
                array(
                    'url' => "type/outlist",
                    'menu_name' => "出库类型",
                    "active" => 0
                ),
            );
            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Type/inlist");
        }

    }


    public function outlist()
    {
        if(request()->isAjax()){
            $page_index = request()->post('page_index',1);
            $page_size = request()->post('page_size',PAGESIZE);

            $condition['stock_type'] = 2;

            $mType = new TypeModel();
            $list = $mType->getList($page_index,$page_size,$condition,'type_id desc');
            return $list;
        }else{
            $child_menu_list = array(
                array(
                    'url' => "type/inlist",
                    'menu_name' => "入库类型",
                    "active" => 0
                ),
                array(
                    'url' => "type/outlist",
                    'menu_name' => "出库类型",
                    "active" => 1
                ),
            );
            $this->assign('child_menu_list', $child_menu_list);
            return view($this->style . "Type/outlist");
        }

    }



}