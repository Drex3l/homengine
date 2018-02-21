<?php
require_once dirname(__FILE__,1).'/epiqworx/db/reuse.php';
abstract class Engine{
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
    public static function Find($n,$block,$del,$accom, $type, $suburb,$rooms,$featureList,$minp,$maxp,$bedroom,$gend,$beds,$baths,$btypes) {
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

abstract class Property{
    public static function getData($id,$list=null){
        $params = array(':id'=>$id);
        if(empty($list)){            return dbHandler::DQL('SELECT * FROM property WHERE PROPERTY_ID = :id',$params);}
        return dbHandler::DQL('SELECT * FROM property_list WHERE ID = :id',$params);
    }

    public static function getAdmin($id){
        return dbHandler::DQL('SELECT USERNAME FROM property p, user u WHERE u.USER_ID = p.USER_ID && PROPERTY_ID = :id', array(':id'=>$id))['USERNAME'];
    }
    public static function img_preview($id){
        return dbHandler::DQL('SELECT * FROM property_img WHERE PROPERTY_ID = :id && PREVIEW IS NOT \N', array(':id'=>$id));
    }
    public static function getImages($property){
        return dbHandler::DQL('SELECT * FROM property_img WHERE PROPERTY_ID = :property', array(':property'=>$property));
    }
    public static function getImage($id){
        return dbHandler::DQL('SELECT * FROM property_img WHERE PICTURE_ID = :id', array(':id'=>$id));
    }
    public static function getImageCount($id){
        return dbHandler::DQL('SELECT COUNT(*) FIELD FROM property_img WHERE PROPERTY_ID = :id', array(':id'=>$id))['FIELD'];
    }
    public static function getImageFile($imgid){
        return dbHandler::DQL('SELECT PICTURE FROM property_img WHERE PICTURE_ID = :id', array(':id'=>$imgid))['PICTURE'];
    }
}
abstract class Rental{
    public static function getRecords($property){
        return dbHandler::DQL('SELECT * FROM rental WHERE PROPERTY_ID = :property', array(':property'=>$property));
    }
    public static function getMonths($property,$period){
        return dbHandler::DQL('SELECT * FROM rental WHERE PROPERTY_ID = :property && MONTHS = :period', array(':property'=>$property,':period'=>$period));
    }
}

abstract class Room{
    public static function getName($id){
        return dbHandler::DQL('SELECT ROOM_TYPE, ROOM_ID FROM room WHERE ROOM_ID = :id', array(':id'=>$id));
    }
}
abstract class User{
    public static function getData($id,$type='user')
    {
        return dbHandler::DQL("SELECT * FROM $type WHERE USER_ID = :id", array(':id'=>$id));
    }
    
}