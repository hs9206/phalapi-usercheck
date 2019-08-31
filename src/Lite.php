<?php
namespace PhalApi\Usercheck;
use PhalApi\Exception\BadRequestException;
use PhalApi\Usercheck\Model\UserSession as ModelSession;
use PhalApi\Usercheck\Domain\UserSession as DomainSession;

/**
 * 第三方用户检测工具类
 *

 *
 * @author Symo.Chan <symo@tudiai.net> 2019-09-09
 */

class Lite
{
    protected $debug;

    protected $config;

    public function __construct($debug = FALSE) {
        $this->debug = $debug;
    }

    /**
     * checkuser
     */

     public function say(){
         return '检测用户完成';
     }

    /**
     * 登录检测
     * @param boolean $isExitIfNotLogin 是否抛出异常以便让接口错误返回
     * @return boolean
     * @throws PhalApi_Exception_BadRequest
     */
    public function check($isExitIfNotLogin = false) {
        $userId = \PhalApi\DI()->request->get('user_id');
        $token = \PhalApi\DI()->request->get('token');

        //是否缺少必要参数
        if (empty($userId) || empty($token)) {
            \PhalApi\DI()->logger->debug('user not login', array('userId' => $userId, 'token' => $token));

            if ($isExitIfNotLogin) {
                throw new BadRequestException('user not login', 1);
            }
            return false;
        }

        $model = new ModelSession();
        $expiresTime = $model->getExpiresTime($userId, $token);

        //是否已过期
        if ($expiresTime <= $_SERVER['REQUEST_TIME']) {
            \PhalApi\DI()->logger->debug('user need to login again', 
                array('expiresTime' => $expiresTime, 'userId' => $userId, 'token' => $token));

            if ($isExitIfNotLogin) {
                throw new BadRequestException('user need to login again', 1);
            }
            return false;
        }

        return true;
    }

    /**
     * 退出登录
     */
    public function logout() {
        $this->_renewalTo($_SERVER['REQUEST_TIME']);
    }

    /**
     * 心跳
     *
     * - 自动续期
     */
    public function heartbeat() {
        $domainSession = new DomainSession();
        $this->_renewalTo($_SERVER['REQUEST_TIME'] + $domainSession::getMaxExpireTime());
    }

    /**
     * 为用户生成一个会话
	 * @param int $userId 用户ID
	 * @param string $client 客户端设备标识，默认为空
	 * @return string 会话token，返回给客户保存，以便后续请求传递此token作登录态验证
     */
    public function generateSession($userId, $client = '') {
        $domainSession = new DomainSession();
        return $domainSession::generate($userId, $client);
    }

    /**
     * 续期
     *
     * - 当有效期为当前时间时，即退出
     */
    protected function _renewalTo($newExpiresTime) {
        $userId = \PhalApi\DI()->request->get('user_id');
        $token = \PhalApi\DI()->request->get('token');

        if (empty($userId) || empty($token)) {
            return;
        }
        
        $model = new ModelSession();
        $model->updateExpiresTime($userId, $token, $newExpiresTime);
    }
}

