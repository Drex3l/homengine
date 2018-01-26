<?php

require_once('root/epiqworx/epiqrithm.php');
require_once('root/epiqworx/db/handler.php');
require_once('root/model.php');

$action = filter_input(INPUT_POST, 'action');
if ($action == NULL) {
    $action = filter_input(INPUT_GET, 'action');
    if ($action == NULL) {
        $action = 'home';
    }
}
switch ($action) {
    case 'home':
        $title = "Welcome Home";
        $error_message = $searchString = null;
        $accom = SearchDB::getAccommodation();
        $rooms = SearchDB::getRoomTypes();
        $PropTypes = SearchDB::getPropertyTypes();
        $BedRTypes = SearchDB::getBedroomTypes();
        $BuildTypes = SearchDB::getBuildingTypes();
        $accessories = SearchDB::getFeatures('ACCESSORY');
        $furniture = SearchDB::getFeatures('FURNITURE');
        $conveniences = SearchDB::getFeatures('CONVENIENCE');
        $sundry = SearchDB::getFeatures('SUNDRY');
        $suburbs = SearchDB::getSuburb();
        require_once dirname(__FILE__, 1) . ('/root/view/welcome/home.php');
        break;
    default :
        $title = "Error";
        echo "case not handled for action '<strong>$action</strong>'";
        break;
}