# PhalApi 2.x扩展类库，第三方用户登陆检测 UserCheck 



## 安装和配置
修改项目下的composer.json文件，并添加：  
```
    "symochan/phalapi-usercheck":"dev-master"
```

然后执行
```php
composer update

```

或直接使用命令安装：
```php
composer require symochan/phalapi-usercheck
```


## 注册
在./config/di.php文件中，注册用户检测服务：  
```php
$di->usercheck = function() {
    return new \PhalApi\Usercheck\Lite(true);
};
```

## 使用
1. 测试函数 Say()
```php
 \PhalApi\DI()->usercheck->say(); // 测试专用函数
```
2. 基础方法
```php
 \PhalApi\DI()->usercheck->check(); // 登录检测
 \PhalApi\DI()->usercheck->logout(); // 退出登录
 \PhalApi\DI()->usercheck->heartbeat(); // 自动续期
 \PhalApi\DI()->usercheck->generateSession(); // 为用户生成一个会话


```


## 可用API 移植于 PhalApi 1.x
```php
1	App.Login.GetUserInfo	用户信息	

2	App.Login.Qq	        QQ登录	

3	App.Login.Weixin	    微信登录	
```

在API调用示例：

```php
<?php
namespace App\Api;
use PhalApi\Api;
use PhalApi\Usercheck\Domain\Generator;
use PhalApi\Usercheck\Domain\UserSession;
use PhalApi\Usercheck\Domain\Login\Weixin as LoginWeixin;
use PhalApi\Usercheck\Domain\Login\Qq as LoginQQ;
use PhalApi\Exception\InternalServerError;

use PhalApi\Usercheck\Domain\Info as DomainInfo;

/**
 * User扩展 － 登录服务
 * @author Symo.Chan
 */

class Login extends Api {

    public function getRules() {
        return array(
            'weixin' => array(
                'openId' => array('name' => 'wx_openid', 'require' => true, 'min' => 1, 'max' => 28),
                'token' => array('name' => 'wx_token', 'require' => true, 'min' => 1, 'max' => 150),
                'expiresIn' => array('name' => 'wx_expires_in', 'require' => true, 'min' => 1, 'max' => 10),
                'nickname' => array('name' => 'name', 'default' => '',),
                'avatar' => array('name' => 'avatar', 'default' => '',),
            ),
            'qq' => array(
                'openId' => array('name' => 'qq_openid', 'require' => true, 'min' => 1, 'max' => 28),
                'token' => array('name' => 'qq_token', 'require' => true, 'min' => 1, 'max' => 150),
                'expiresIn' => array('name' => 'qq_expires_in', 'require' => true, 'min' => 1, 'max' => 10),
                'nickname' => array('name' => 'name', 'default' => '',),
                'avatar' => array('name' => 'avatar', 'default' => '',),
            ),
            'getUserInfo' => array(
                'otherUserId' => array('name' => 'other_user_id', 'type' => 'int', 'min' => 1, 'require' => true),
            ),
        );
    }

    /**
     * 微信登录
     *
     * - 首次绑定时，会自动创建新用户
     * - 当逻辑有冲突，或者数据库写入失败时，以异常返回
     */
    public function weixin()
    {
        $rs = array('code' => 0, 'info' => array(), 'msg' => '');

        $domain = new LoginWeixin();
        $isFirstBind = $domain->isFirstBind($this->openId);

        $userId = 0;
        if ($isFirstBind) {
            $userId = Generator::createUserForWeixin($this->openId, $this->nickname, $this->avatar);
            if ($userId <= 0) {
                //异常1：用户创建失败
                \PhalApi\DI()->logger->error('failed to create weixin user', array('openId' => $this->openId));
                throw new InternalServerError(T('failed to create weixin user'));
            }

            $id = $domain->bindUser($userId, $this->openId, $this->token, $this->expiresIn);
            if ($id <= 0) {
                //异常2：绑定微信失败
                \PhalApi\DI()->logger->error('failed to bind user with weixin', 
                    array('userid' => $userId, 'openId' => $this->openId));
                throw new InternalServerError(T('failed to bind user with weixin'));
            }
        } else {
            $userId = $domain->getUserIdByWxOpenId($this->openId);
        }

        if ($userId <= 0) {
            //异常3：微信用户不存在
            \PhalApi\DI()->logger->error('weixin user not found', 
                array('userid' => $userId, 'openId' => $this->openId));
            throw new InternalServerError(T('weixin user not found'));
        }

        $token = UserSession::generate($userId);

        $rs['info']['user_id'] = $userId;
        $rs['info']['token'] = $token;
        $rs['info']['is_new'] = $isFirstBind ? 1 : 0;

        return $rs;
    }


    /**
     * QQ登录
     *
     * - 首次绑定时，会自动创建新用户
     * - 当逻辑有冲突，或者数据库写入失败时，以异常返回
     */
    public function qq()
    {
        $rs = array('code' => 0, 'info' => array(), 'msg' => '');

        $domain = new LoginQQ();
        $isFirstBind = $domain->isFirstBind($this->openId);

        $userId = 0;
        if ($isFirstBind) {
            $userId = Generator::createUserForQq($this->openId, $this->nickname, $this->avatar);
            if ($userId <= 0) {
                //异常1：用户创建失败
                \PhalApi\DI()->logger->error('failed to create qq user', array('openId' => $this->openId));
                throw new InternalServerError(T('failed to create qq user'));
            }

            $id = $domain->bindUser($userId, $this->openId, $this->token, $this->expiresIn);
            if ($id <= 0) {
                //异常2：绑定QQ失败
                \PhalApi\DI()->logger->error('failed to bind user with qq', 
                    array('userid' => $userId, 'openId' => $this->openId));
                throw new InternalServerError(T('failed to bind user with qq'));
            }
        } else {
            $userId = $domain->getUserIdByQqOpenId($this->openId);
        }

        if ($userId <= 0) {
            //异常3：QQ用户不存在
            \PhalApi\DI()->logger->error('qq user not found', 
                array('userid' => $userId, 'openId' => $this->openId));
            throw new InternalServerError(T('qq user not found'));
        }

        $token = UserSession::generate($userId);

        $rs['info']['user_id'] = $userId;
        $rs['info']['token'] = $token;
        $rs['info']['is_new'] = $isFirstBind ? 1 : 0;

        return $rs;
    }

    /**
     * 用户信息
     */
    public function getUserInfo() {
        $rs = array('code' => 0, 'info' => array(), 'msg' => '');

        // \PhalApi\DI()->usercheck->check(true);

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

```



