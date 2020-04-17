<?php
namespace app\admin\controller;

use data\model\NsCardModel;
use think\Request;

class Card extends BaseController
{

    public function cardList(Request $request)
    {
        if (request()->isAjax()) {
            $page_index = $request->post("page_index", 1);
            $page_size = $request->post("page_size", PAGESIZE);
            $card_no = $request->post('card_no', '');
            $is_issue = $request->post('is_issue','');
            $mCard = new NsCardModel();
            $condition = [];
            if(!empty($card_no)){
                $condition['card_no'] = $card_no;
            }
            if(!empty($is_issue)){
                $condition['is_issue'] = $is_issue;
            }
            $list = $mCard->pageQuery($page_index, $page_size, $condition, 'card_id desc','*');
            return $list;
        }else{
            return view($this->style . "Card/cardList");
        }
    }


    public function addCard()
    {
        if (request()->isAjax()) {
            $post = request()->post();
            $mCard = new NsCardModel();
            $ret = $mCard->addCard($post);
        } else {
            return view($this->style . "Card/addCard");
        }
        return $ret;
    }


    public function issueCard(Request $request)
    {
        $card_id = $request->post('card_id',0);
        $mCard = new NsCardModel();
        $ret = $mCard->issueCard($card_id);
        return $ret;
    }


    public function destroyCard(Request $request)
    {
        $card_id = $request->post('card_id',0);
        $mCard = new NsCardModel();
        $ret = $mCard->destroyCard($card_id);
        return $ret;
    }





}