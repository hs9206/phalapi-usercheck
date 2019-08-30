<?php
namespace PhalApi\Usercheck\Domain\Login;
use PhalApi\Usercheck\Model\UserLoginQq;

class Qq {

    public function isFirstBind($openId) {
        $model = new UserLoginQq();
        return $model->isFirstBind($openId);
    }

    public function getUserIdByQqOpenId($openId) {
        if (empty($openId)) {
            return array();
        }

        $model = new UserLoginQq();
        return $model->getUserIdByQqOpenId($openId);
    }

    public function bindUser($userId, $openId, $token, $expiresIn) {
        $data = array();
        $data['qq_openid'] = $openId;
        $data['qq_token'] = $token;
        $data['qq_expires_in'] = $expiresIn;
        $data['user_id'] = $userId;

        $model = new UserLoginQq();
        return $model->insert($data);
    }
}
