<?php
namespace data\model;

class NsCardModel extends BaseModel
{
    protected $table = 'ns_card';
    protected $rule = [
        'card_id' => '',
    ];
    protected $msg = [
        'card_id' => '',
    ];

    protected function getCardNo($num)
    {
        $smart_str = 'SMART';
        $year = date('Y',time());
        $year_str = substr($year, -2);
        $month = date('m',time());
        $date = date('d',time());
        $order_str = sprintf("%04d", $num);
        $rand_str = rand(1000,9999);
        $card_no = $year_str.$order_str.$month.$rand_str.$date;
        return $card_no;
    }


    public function addCard($post)
    {
        $count = $post['count'];
        $card_nums = $this->count();
        for ($i = 1; $i <= $count; $i++){
            $card_no = $this->getCardNo($card_nums+$i);
            $data['card_no'] = $card_no;
            $data['card_money'] = $post['card_money'];
            $data['expire_date'] = strtotime($post['expire_date']);
            $data['create_date'] = time();
            $data['update_date'] = time();

            $this->addOneCard($data);
        }
        return true;
    }


    public function addOneCard($data)
    {
        $mCard = new NsCardModel();
        $mCard->startTrans();
        try{

            $mCard->save($data);

        }catch (\Exception $e) {
            $mCard->rollback();
            return $e->getMessage();
        }
        $mCard->commit();

        return true;
    }


    public function issueCard($card_id)
    {
        $data['is_issue'] = 1;
        $where['card_id'] = $card_id;
        $mCard = new self();
        $ret = $mCard->save($data,$where);
        if(false === $ret){
            return false;
        }
        return true;
    }


    public function destroyCard($card_id)
    {
        $data['is_destroy'] = 1;
        $where['card_id'] = $card_id;
        $mCard = new self();
        $ret = $mCard->save($data,$where);
        if(false === $ret){
            return false;
        }
        return true;
    }




}