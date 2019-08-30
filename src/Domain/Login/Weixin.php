<?php
namespace PhalApi\Usercheck\Domain\Login;
use PhalApi\Usercheck\Model\UserLoginWeixin;

class Weixin {

    public function isFirstBind($openId) {
        $model = new UserLoginWeixin();
        return $model->isFirstBind($openId);
    }

    public function getUserIdByWxOpenId($openId) {
        if (empty($openId)) {
            return array();
        }

        $model = new UserLoginWeixin();
        return $model->getUserIdByWxOpenId($openId);
    }

    public function bindUser($userId, $openId, $token, $expiresIn) {
        $data = array();
        $data['wx_openid'] = $openId;
        $data['wx_token'] = $token;
        $data['wx_expires_in'] = $expiresIn;
        $data['user_id'] = $userId;

        $model = new UserLoginWeixin();
        return $model->insert($data);
    }
}
