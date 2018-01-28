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
    public static function getSuburb() {
        return dbHandler::DQL('SELECT SUBURB_NAME, SUBURB_ID FROM suburb ORDER BY SUBURB_NAME');
    }

    public static function getFeatures($feature) {
        return dbHandler::DQL('SELECT NAME, ITEM_CODE FROM feature WHERE CATEGORY = :feat ORDER BY NAME', array(':feat'=>$feature));
    }

    public static function Engine($del,$accom, $type, $suburb,$rooms,$featureList,$minp,$maxp,$bedroom,$gend,$beds,$baths,$btypes) {
        $params = array(':del'=>$del,':accom'=>$accom,':type'=>$type,':suburb'=>$suburb,':rooms'=>$rooms,':items'=>$featureList,':minp'=>$minp,
            ':maxp'=>$maxp,':bedroom'=>$bedroom,':gend'=>$gend,':beds'=>$beds,':baths'=>$baths,':btypes'=>$btypes);
        return dbHandler::DQL("call  uspFind(:del,:accom,:type,:suburb,:rooms,:items,:minp,:maxp,:bedroom,:gend,:beds,:baths,:btypes)",$params);
    }
}