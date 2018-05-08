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
        $title = "Welcome Home";    //------------------------------------------Page Title
        //==============================*Page Anchors*==========================
        $find_home = "#search-pane";
        $HE_AC = "#account-pane";
        //======================================================================
        $page_wrap = 'page-wrap';   //------------------------------------------100% HEIGHT container
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
        //===========================*Search Pane Fields*=======================
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
        //======================================================================
        require_once dirname(__FILE__, 1) . ('/root/view/welcome/home.php');
        break;
    case 'view':
        $title = "Property Info";   //------------------------------------------Page Title
        //==============================*Page Anchors*==========================
        $find_home = PATH."#search-pane";
        $HE_AC = PATH."#account-pane";
        //======================================================================
	$page_wrap = null;   //------------------------------------------100% HEIGHT container
        $property_id = $_POST['smbBtn'];    //----------------------------------ID of selected Property from result list
        $admin = Property::getAdmin($property_id);  //--------------------------Admin managing property username
        $property = Property::getData($property_id);    //----------------------property table record
        $admin_data = User::getData($property['USER_ID'],'admin');  //----------property admin data
        $admin_data_super = User::getData($property['USER_ID']);  //------------property admin data
        $date_occupy = $property['DATE_OCCUPY'];
        if(empty($date_occupy)){$date_occupy = "01 ".date('M Y',strtotime('+1 month'));}
        $org = $admin_data['ORGANIZATION']; 
        if(empty($org)){    $org = $admin;  }
        
        if(empty($admin_data_super['DISPLAY_IMG'])){$avatar = PATH.'/root/usr/img/sys/logo-lite.png';}
        else {  $avatar = PATH.'/root/usr/img/avatar/'.$admin_data_super['DISPLAY_IMG'];    }
        $property_list = Property::getData($property_id,'list');    //----------property View record
        $image = Property::getImages($property_id); //--------------------------selected property images
        $image_count = Property::getImageCount($property_id);   //--------------total number of all images of selected property
        $rental = Rental::getMonths($property_id,1);    //----------------------one month rental details
        $months = 'months';
        if($rental['LEASE'] < 2){ $months = 'month';}
        //======================*Property Main Display Image*===================
        $main_img = PATH."/root/usr/img/property/$admin/".Property::getImageFile($property['IMG_ID']);
        if(empty($property['IMG_ID'])){$main_img = PATH.'/root/usr/img/sys/logo-lite.png';}
        //======================================================================
        require_once dirname(__FILE__, 1) . ('/root/view/content/property_view.php');
        break;
    case 'contact-admin':
        $title = "Contact Admin";   //------------------------------------------Page Title
        $property_id = intval($_POST['id']);    //------------------------------ID of selected Property from result list
        $name = filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRING);
        $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_STRING);
        $phone = filter_input(INPUT_POST, 'phone', FILTER_SANITIZE_STRING);
        $message = Filter::escape(filter_input(INPUT_POST, 'message', FILTER_SANITIZE_STRING));
        Property::update($message,$property_id);
//        echo $message;
        echo $property_id;
        break;
    case 'test':
        echo WebTools::getBrowser()['name'];
        break;
    default :
        $title = "Error";
        echo "case not handled for action '<strong>$action</strong>'";
        break;
}
