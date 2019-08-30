<?php
namespace PhalApi\Usercheck\Domain;
use PhalApi\Usercheck\Model\UserSession as ModelSession;

/**
 * 生成用户会话信息
 * Symo.chan
 */

class UserSession {

    const MAX_EXPIRE_TIME_FOR_SESSION = 2592000;    //一个月

    /**
     * 创建新的会话
     * @param int $userId 用户ID
     * @return string 会话token
     */
    public static function generate($userId, $client = '')
    {
        if ($userId <= 0) {
            return '';
        }

        $token = strtoupper(substr(sha1(uniqid(NULL, TRUE)) . sha1(uniqid(NULL, TRUE)), 0, 64));

        $newSession = array();
        $newSession['user_id'] = $userId;
        $newSession['token'] = $token;
        $newSession['client'] = $client;
        $newSession['times'] = 1;
        $newSession['login_time'] = $_SERVER['REQUEST_TIME'];
        $newSession['expires_time'] = $_SERVER['REQUEST_TIME'] + self::getMaxExpireTime();

        $sessionModel = new ModelSession();
        $sessionModel->insert($newSession, $userId);

        return $token;
    }

    public static function getMaxExpireTime() {
        return self::MAX_EXPIRE_TIME_FOR_SESSION;
    }
}
