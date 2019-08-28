<?php
namespace PhalApi\Usercheck;


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

        // $this->config = \PhalApi\DI()->config->get('app.PHPMailer.email');
    }

    /**
     * checkuser
     */

     public function checkuser(){
         return '检测用户完成';
     }
}

