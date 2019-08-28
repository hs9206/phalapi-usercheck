# UserCheck
## 注册
在./config/di.php文件中，注册用户检测服务：  
```php
$di->usercheck = function() {
    return new \PhalApi\Usercheck\Lite(true);
};
```