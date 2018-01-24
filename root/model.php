<?php
require_once dirname(__FILE__,1).'/epiqworx/db/reuse.php';
abstract class SearchDB{
    public static function getAccommodation(){
        return dbAccess::getEnumDropDown('Property','ACCOMMODATION');
    }
    public static function getBuidingTypes() {
        return dbHandler::DQL('SELECT TYPE_DESC, TYPE_ID FROM PropertyType');
    }
    public static function getRoomTypes($beds,$baths) {
        return dbHandler::DQL('SELECT ROOM_TYPE, ROOM_ID FROM Room WHERE ROOM_TYPE <> :beds && ROOM_TYPE  <> :baths ORDER BY ROOM_TYPE', array(':beds'=>$beds,':baths'=>$baths));
    }
    public static function getSuburb() {
        return dbHandler::DQL('SELECT SUBURB_NAME, SUBURB_ID FROM Suburb ORDER BY SUBURB_NAME');
    }

    public static function getFeatures($feature) {
        return dbHandler::DQL('SELECT NAME, ITEM_CODE FROM Facility WHERE CATEGORY = :feat ORDER BY NAME', array(':feat'=>$feature));
    }

    public static function searchEngine($keywords, $accom, $type, $suburb,$featureList) {
        $params = array(':keywords'=>"$keywords",':accom'=>"$accom",':type'=>"$type",':suburb'=>"$suburb",':items'=>"$featureList");
        return dbHandler::DQL("call uspFind(:keywords,:acomm,:type,:suburb,:items)", $params);
    }
}