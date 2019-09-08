<?php
namespace PhalApi\Usercheck\Domain;
use PhalApi\Usercheck\Model\User as ModelUser;

/**
 * 用户生成器
 *
 * - 可用于自动生成一个新用户
 *
 * @author Symo.Chan Aevit, dogstar
 */

class Generator {

    /**
     * 为微信用户生成新用户
     * @return int 用户id
     */
    public static function createUserForWeixin($openId, $nickname = '', $avatar = '') {
        return self::createUser('wx_' . md5($openId), $nickname, $avatar);
    }


    /**
     * 为QQ用户生成新用户
     * @return int 用户id
     */
    public static function createUserForQq($openId, $nickname = '', $avatar = '') {
        return self::createUser('qq_' . md5($openId), $nickname, $avatar);
    }

    /**
     * 生成新用户 - 通用入口
     *
     * @param string $username 用户名
     * @param string $nickname 昵称
     * @param string $avatar 头像链接
     * @return int 用户id
     */
    protected static function createUser($username, $nickname, $avatar) {
        $uuid = strtoupper(substr(sha1(uniqid(NULL, TRUE)) . sha1(uniqid(NULL, TRUE)), 0, 32));
        $tmpPassword = md5('******');
        $saltStr = \PhalApi\Tool::createRandStr(32);

        $newUserInfo = array();
        $newUserInfo['username'] = $username;
        $newUserInfo['nickname'] = $nickname;
        $newUserInfo['avatar'] = !empty($avatar) ? $avatar : '';

        //密码规则： md5(md5('原始密码') 拼接 '32位随机数'))  API接口入参： md5('原始密码') 
        $newUserInfo['salt'] = $saltStr;
        $newUserInfo['password'] = md5($tmpPassword.$saltStr);
        $newUserInfo['reg_time'] = $_SERVER['REQUEST_TIME'];

        $newUserInfo['uuid'] = $uuid;

        $userModel = new ModelUser();
        return $userModel->insert($newUserInfo);
    }
}
