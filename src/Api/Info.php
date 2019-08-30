<?php
namespace PhalApi\Usercheck\Api;
use PhalApi\Api;
use PhalApi\Usercheck\Domain\Info as DomainInfo;

/**
 * User扩展－用户信息服务
 * @author Symo.Chan
 */

class Info extends Api {

    public function getRules()
    {
        return array(
            'getUserInfo' => array(
                'otherUserId' => array('name' => 'other_user_id', 'type' => 'int', 'min' => 1, 'require' => true),
            ),
        );
    }

    /**
     * 用户信息
     */
    public function getUserInfo() {
        $rs = array('code' => 0, 'info' => array(), 'msg' => '');

        \PhalApi\DI()->usercheck->check(true);

        $domain = new DomainInfo();
        $info = $domain->getUserInfo($this->otherUserId);

        if (empty($info)) {
            $rs['code'] = 1;
            $rs['msg'] = 'can not get user info';

            \PhalApi\DI()->logger->debug('can not get user info', $this->otherUserId);

            return $rs;
        }

        $rs['info'] = $info;

        return $rs;
    }
}
