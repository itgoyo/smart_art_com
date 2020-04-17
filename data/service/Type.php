<?php
namespace data\service;

use data\api\IType;
use data\model\NsTypeModel;


class Type extends BaseService implements IType
{

    private $type;
    function __construct()
    {
        parent::__construct();
        $this->type = new NsTypeModel();
    }

    public function addType($data)
    {
        $this->type->startTrans();
        try {
            $mType = new NsTypeModel();
            $ret = $mType->data([])->allowField(true)->isUpdate(false)->save($data);
            if(false === $ret){
                $this->type->rollback();
                return false;
            }

        }catch (\Exception $e){
            $this->type->rollback();
            return $e->getMessage();
        }
        $this->type->commit();

        return true;

    }


    public function getList($page_index = 1, $page_size = 0, $condition = '', $stock = '')
    {
        $mType = new NsTypeModel();
        $inList = $mType->pageQuery($page_index,$page_size,$condition,$stock,'*');
        return $inList;
    }

    public function deleteType($type_id)
    {
        $mType = new NsTypeModel();
        $type = $mType->where('type_id',$type_id)->find();

        $this->type->startTrans();
        try{

            $type->delete();


        }catch(\Exception $e){
            $this->type->rollback();
            return $e->getMessage();
        }
        $this->type->commit();

        return true;
    }


    public function getTypeById($type_id)
    {
        $mType = new NsTypeModel();
        $res = $mType->getQuery([
            'type_id' => $type_id
        ], "type_name", '');
        $type_name = "";
        if (! empty($res[0]['type_name'])) {
            $type_name = $res[0]['type_name'];
        }
        return $type_name;
    }


    public function editType($type_id, $type_name)
    {
        $mType = new NsTypeModel();
        $data = array(
            'type_name' => $type_name
        );
        $retval = $mType->save($data, [
            'type_id' => $type_id
        ]);
        return $retval;
    }


}
