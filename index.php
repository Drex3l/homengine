<?php

require_once('root/epiqworx/epiqrithm.php');
require_once('root/epiqworx/db/handler.php');
require_once('root/model.php');

//<editor-fold desc="GLOBAL" defaultstate="collapsed">
$currency = 'R';
//</editor-fold>

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
        $find_home = "#search-pane";
        $HE_AC = "#account-pane";
        $page_wrap = 'page-wrap';
        $error_message = null;
        $records = 20;  //------------------------------------------------------Limit of records returned by search result list
        $page = intval(filter_input(INPUT_POST, 'page', FILTER_SANITIZE_STRING));//Current page number in result list
        if ($page == NULL) {
            $page = intval(filter_input(INPUT_GET, 'pages'));
            if ($page == NULL) {
                $page = 1;
            }
        }
        $del = ','; //----------------------------------------------------------Selected Feature/Room delimiter
        $accom = Engine::getAccommodation();
        $rooms = Engine::getRoomTypes();
        $PropTypes = Engine::getPropertyTypes();
        $BedRTypes = Engine::getBedroomTypes();
        $BuildTypes = Engine::getBuildingTypes();
        $accessories = Engine::getFeatures('ACCESSORY');
        $furniture = Engine::getFeatures('FURNITURE');
        $conveniences = Engine::getFeatures('CONVENIENCE');
        $sundry = Engine::getFeatures('SUNDRY');
        $suburbs = Suburb::getRecords();
        require_once dirname(__FILE__, 1) . ('/root/view/welcome/home.php');
        break;
    case 'view':
        $title = "Property Info";
        $find_home = PATH."#search-pane";
        $HE_AC = PATH."#account-pane";
        $property_id = $_POST['smbBtn'];
        $admin = Property::getAdmin($property_id);
        $property = Property::getData($property_id);
        $property_list = Property::getData($property_id,'list');
        $image = Property::getImages($property_id);
        $image_count = Property::getImageCount($property_id);
        $rental = Rental::getMonths($property_id,1);
        $months = 'months';
        if($rental['LEASE'] < 2){ $months = 'month';}
        $main_img = PATH."/root/usr/img/property/$admin/".Property::getImageFile($property['IMG_ID']);
        if(empty($property['IMG_ID'])){$main_img = PATH.'/root/usr/img/sys/logo-lite.png';}
        require_once dirname(__FILE__, 1) . ('/root/view/content/property_view.php');
        break;
    case 'test':
        echo WebTools::getBrowser()['name'];
        break;
    default :
        $title = "Error";
        echo "case not handled for action '<strong>$action</strong>'";
        break;
}