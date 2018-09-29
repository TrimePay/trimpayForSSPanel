<?php
/**
 * Created by PhpStorm.
 * User: tonyzou
 * Date: 2018/9/24
 * Time: 下午7:07
 */

namespace App\Services;

use App\Services\Config;
use App\Services\Gateway\TrimePay;

class Payment
{
    public static function getClient(){
        $method = Config::get("payment_system");
        switch($method){
            case("trimepay"):
                return new TrimePay(Config::get('trimepay_secret'));
            default:
                return 0;
        }
    }

    public static function notify($request, $response, $args){
        self::getClient()->notify($request, $response, $args);
    }

    public static function returnHTML($request, $response, $args){
        return self::getClient()->getReturnHTML($request, $response, $args);
    }

    public static function purchaseHTML(){
        return self::getClient()->getPurchaseHTML();
    }

    public static function getStatus($request, $response, $args){
        return self::getClient()->getStatus($request, $response, $args);
    }

    public static function purchase($request, $response, $args){
        return self::getClient()->purchase($request, $response, $args);
    }
}