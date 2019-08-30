<?php
namespace PhalApi\Usercheck\Model;
use PhalApi\Model\NotORMModel;

/**
 * 使用QQ登陆
 */
class UserLoginQq extends NotORMModel {

     protected function getTableName($id) {
        return 'user_login_qq';
    }

    public function getBindInfo($openId) {
        $rs = $this->getORM()->where('qq_openid', $openId)->fetch();
        return !empty($rs) ? $rs : array();
    }

    public function isFirstBind($openId) {
        $num = $this->getORM()->where('qq_openid', $openId)->count('id');
        return $num == 0 ? true : false;
    }

    public function getUserIdByQqOpenId($openId) {
        $rs = $this->getORM()->select('user_id')->where('qq_openid', $openId)->fetch();
        return !empty($rs) ? intval($rs['user_id']) : 0;
    }
}
