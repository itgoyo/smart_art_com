<?php
namespace data\model;
use think\Db;
use data\model\BaseModel as BaseModel;
/**
 * 用户表
 */
class UserModel extends BaseModel {
    protected $table = 'sys_user';
    protected $rule = [
        'uid'  =>  '',
    ];
    protected $msg = [
        'uid'  =>  '',
    ];


    public function batchImportUser($data){
        $rs = $this->insert($data);
        return $rs;
    }


    public function UserList($page_index, $page_size, $condition,$order=''){
        $queryList = $this->getUserViewQuery($page_index, $page_size, $condition, $order);
        $queryCount = $this->getUserViewCount($condition);
        $list = $this->setReturnList($queryList, $queryCount, $page_size);
        return $list;
    }

    /**
     * 获取列表
     * @param unknown $page_index
     * @param unknown $page_size
     * @param unknown $condition
     * @param unknown $order
     * @return \data\model\multitype:number
     */
    public function getUserViewQuery($page_index, $page_size, $condition, $order)
    {
        $viewObj = $this->where('is_system',1)->field('uid,user_name,sex,user_status,user_headimg,user_email,user_tel');
        $list = $this->viewPageQuery($viewObj, $page_index, $page_size, $condition, $order);
        return $list;
    }
    /**
     * 获取列表数量
     * @param unknown $condition
     * @return \data\model\unknown
     */
    public function getUserViewCount($condition)
    {
        $viewObj = $this->where('is_system',1)->field('uid');
        $count = $this->viewCount($viewObj,$condition);
        return $count;
    }

 
}
