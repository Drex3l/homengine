<?php
require_once dirname(__FILE__,1).'/epiqworx/db/reuse.php';
abstract class SearchDB{
    public static function getAccommodation(){
        return dbAccess::getEnumDropDown('property','TARGET');
    }
    public static function getPropertyTypes() {
        return dbHandler::DQL('SELECT * FROM property_type');
    }
    public static function getBedroomTypes() {
        return dbHandler::DQL('SELECT * FROM bedroom_type order by BEDROOM_TYPE DESC');
    }
    public static function getBuildingTypes() {
        return dbHandler::DQL('SELECT * FROM building_type');
    }
    public static function getRoomTypes() {
        return dbHandler::DQL('SELECT ROOM_TYPE, ROOM_ID FROM room');
    }
    public static function getFeatures($feature) {
        return dbHandler::DQL('SELECT NAME, ITEM_CODE FROM feature WHERE CATEGORY = :feat ORDER BY NAME', array(':feat'=>$feature));
    }

    public static function Engine($n,$block,$del,$accom, $type, $suburb,$rooms,$featureList,$minp,$maxp,$bedroom,$gend,$beds,$baths,$btypes) {
        $params = array(':n'=>$n,':block'=>$block,':del'=>$del,':accom'=>$accom,':type'=>$type,':suburb'=>$suburb,':rooms'=>$rooms,':items'=>$featureList,':minp'=>$minp,
            ':maxp'=>$maxp,':bedroom'=>$bedroom,':gend'=>$gend,':beds'=>$beds,':baths'=>$baths,':btypes'=>$btypes);
        return dbHandler::DQL("call uspFind(:n,:block,:del,:accom,:type,:suburb,:rooms,:items,:minp,:maxp,:bedroom,:gend,:beds,:baths,:btypes)",$params);
    }
    public static function page_count($block){
        $pages = dbHandler::DQL("SELECT sf_engine_page_count(:block) PAGES", array(':block'=>$block));
        dbHandler::Execute('DROP TABLE RECORDS');
        return $pages['PAGES'];
    }
}
abstract class Suburb{
    public static function getRecords() {
        return dbHandler::DQL('SELECT SUBURB_NAME, SUBURB_ID FROM suburb ORDER BY SUBURB_NAME');
    }
    public static function getName($id){
        return dbHandler::DQL('SELECT SUBURB_NAME FROM suburb WHERE SUBURB_ID = :id', array(':id'=>$id))['SUBURB_NAME'];
    }
}
abstract class Feature{
    public static function getSelection($string){
        $string = substr($string,0,strlen($string)-1);
        $accessory = self::getAcceSelect($string);
        $furniture = self::getFurnSelect($string);
        $convinience = self::getConSelect($string);
        $sundry = self::getSunSelect($string);
        return array('accessory'=>$accessory,'furniture'=>$furniture,'convinience'=>$convinience,'sundry'=>$sundry);
    }
    public static function getName($id){
        return dbHandler::DQL('SELECT NAME, ITEM_CODE FROM feature WHERE ITEM_CODE = :id', array(':id'=>$id));
    }

    private static function getAcceSelect($string)
    {
        $item = explode(',',$string);
        $string = "";
        foreach ($item as $value){
            if($value[1] === "A"){  $string .= "$value,";   }
        }
        return substr($string,0,strlen($string)-1);
    }
    private static function getFurnSelect($string)
    {
        $item = explode(',',$string);
        $string = "";
        foreach ($item as $value){
            if($value[1] === "F"){  $string .= "$value,";   }
        }
        return substr($string,0,strlen($string)-1);
    }
    private static function getConSelect($string)
    {
        $item = explode(',',$string);
        $string = "";
        foreach ($item as $value){
            if($value[1] === "C"){  $string .= "$value,";   }
        }
        return substr($string,0,strlen($string)-1);
    }
    private static function getSunSelect($string)
    {
        $item = explode(',',$string);
        $string = "";
        foreach ($item as $value){
            if($value[1] === "S"){  $string .= "$value,";   }
        }
        return substr($string,0,strlen($string)-1);
    }
}