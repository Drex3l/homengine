<?php require_once dirname(__FILE__, 3) . '/view/welcome/header.php'; ?>
<section class="honeycomb" id="property-view">
    <?php require_once dirname(__FILE__,3).'/view/welcome/noscript.php';?>
    <div class="container HE_content js">
        <div class="row view-head clearfix">
            <div class="col-xs-12">
                <div class="pull-left pager" id="month_rental">
                    <div><?= Text::currency($rental['AMOUNT'],$currency);?></div>
                    <a href="javascript:popupTogle(month_rental);">Rental Method<i class="fa fa-lg fa-angle-down"></i></a>
                        <ul class="pager-menu ">
                            <table>
                                <tr><td>Period</td><td>:&nbsp;<?= $rental['MONTHS'].' month rental';?></td></tr>
                                <tr><td>Deposit&nbsp;&nbsp;&nbsp;</td><td>:&nbsp;<?= Text::currency($rental['DEPOSIT'],$currency);?></td></tr>
                                <tr><td>Lease</td><td>:&nbsp;<?= $rental['LEASE']." $months";?></td></tr>
                                <tr><td>Available</td><td>:&nbsp;<?= $date_occupy;?></td></tr>
                            </table>
                        </ul>
                </div>
                <div class="pull-left">
                    <h1 class="page-title"><?= $property_list['SETTING'];?></h1>
                    <span class="big"><?= $property_list['ADDRESS LINE 1'].', '.$property_list['SUBURB'];?></span>
                    <span class="small">
                        <?php if(strlen($property_list['ADDRESS LINE 1'].', '.$property_list['SUBURB'])<23){echo $property_list['ADDRESS LINE 1'].', '.$property_list['SUBURB'];}
                              else {    echo substr($property_list['ADDRESS LINE 1'],0,6).'... , '.substr($property_list['SUBURB'],0,5).'...';}?>
                    </span>

                </div>
                <div class="pull-right big">
                    <a href="javascript:;"><i class="fa fa-star-o fa-2x"></i></a>
                </div>
                <div class="pull-right big">
                    <a href="javascript:returnResults('<?= WebTools::getBrowser()['name'];?>')" title="search results (firefox)"><i class="fa fa-arrow-left fa-2x"></i></a>
                </div>
            </div>
        </div>
        <article id="main-col" class="clearfix">
            <div class="col-xs-9">
                <div id="MainGalleryTab">
                    <input type="hidden" id="property-profile-image" value="<?=Property::getImageFile($property['IMG_ID']);?>"/>
                    <div id="MainGalleryImageList" class="image-wrapper">
                        <div class="HE_info"><span id="image_info"></span></div>
                        <div class="HE_count"><span id="imageCounter"></span>/<span><?= $image_count;?></span></div>
                        <img src="<?= $main_img; ?>" id="img_screen" <?php if(!empty($property['IMG_ID'])){ echo 'onclick="previewIMG(this)"';}?> />
                        <a href="javascript:previewImageNavigate(img_screen.textContent,img_nav_prev,<?= $image_count;?>)" id="img_nav_prev" class="img_nav_key img_prev"><i class="fa fa-4x fa-angle-left"></i></a>
                        <a href="javascript:previewImageNavigate(img_screen.textContent,img_nav_next,<?= $image_count;?>)" id="img_nav_next" class="img_nav_key img_next"><i class="fa fa-4x fa-angle-right"></i></a>
                    </div>
                </div>
                <div class="carouselMini">
                    <div class="jcarousel-clip jcarousel-clip-horizontal" style="position: relative">
                        <ul style="overflow: hidden;position: relative;top: 0px;margin: 0px;padding: 0px;left: 0px;display: inline-flex;">
                            <?php 
                            $count = 1;
                            foreach ($image as $pic){
                               if(is_array($pic))  {   ?>
                            <li class="jcarousel-item" style="float: left;list-style: outside none none;" id="<?= "li-img$count";?>">
                                        <a href="javascript:previewImage(<?= "prvimg$count";?>)">
                                            <img id="<?= "prvimg$count";?>" src="root/usr/img/property/<?= $admin; ?>/<?= $pic['PICTURE']; ?>" width="93" height="62" alt="<?= $pic['DESCRIPTION']; ?>" title="<?= $pic['TITLE'];?>" class="select-img"/>
                                        </a>
                                    </li>
                            <?php 
                            $count++;
                               }else{?>
                            <li class="jcarousel-item" style="float: left;list-style: outside none none;" id="<?= "li-img$count";?>">
                                        <a href="javascript:previewImage(<?= "prvimg$count";?>);">
                                            <img id="<?= "prvimg$count";?>" src="root/usr/img/property/<?= $admin; ?>/<?= $image['PICTURE']; ?>" width="93" height="62" alt="<?= $image['DESCRIPTION']; ?>" title="<?= $image['TITLE']?>" class="select-img"/>
                                        </a>
                                    </li>
                            <?php break;}}?>
                        </ul>
                    </div>
                    <div class="jcarousel-horizontal" style="display:block;left: 0">
                        <a href="javascript:;">
                            <i class="fa fa-arrow-left" style="right:30%"></i>
                        </a>
                    </div>
                    <div class="jcarousel-horizontal" style="display:block;right: 0;">
                        <a href="javascript:;">
                            <i class="fa fa-arrow-right" style="left:30%"></i>
                        </a>
                    </div>
                </div>
                <div class="HE_details clearfix">
                    <div class="row">
                        <div class="col-xs-12">
                            <span class="HE_dPL"><?= str_replace('\xd\xa',"\r\n",htmlspecialchars( $property['DESCRIPTION']));?></span>
                            
                        </div>
                    </div>
                    <div class="row"><div class="col-xs-12"><hr/></div></div>
                    <div class="row"><div class="col-xs-12"><h5>Property Details</h5></div></div>
                    <div class="HE_features boundary360">
                        <div class="row clearfix"><div class="col-xs-4 field">Property Type</div><div class="col-xs-8 value"><div><?= htmlspecialchars( Property::getType($property['PROP_TYPE_ID']));?></div></div></div>
                        <div class="row clearfix"><div class="col-xs-4 field">Market</div><div class="col-xs-8 value"><?= htmlspecialchars($property['TARGET']);?><div></div></div></div>
                        <div class="row clearfix"><div class="col-xs-4 field">Listing Date</div><div class="col-xs-8 value"><?= htmlspecialchars(substr($property['LISTING'],0,10));?><div></div></div></div>
                    </div>
                    
                </div>
            </div>
        </article>
        
        <div id="property-preview-modal" class="modal" onclick="this.style.display='none'">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 id="modal-img-title"></h2>
                </div>
                <div class="modal-body">
                    <img id="modal-img-screen"/>
                </div>
                <div class="modal-footer clearfix">
                    <h3 id="modal-img-desc"></h3>
                </div>
            </div>
        </div>
        
        <aside id="sidebar">
            <div class="dark">
                <div class="boundary360">
                    <h3>Contact Admin</h3>
                    <form class="feedback" action="." method="post">
                        <input type="hidden" name="action" value="contact-admin"/>
                        <input type="hidden" name="id" value=<?= $property_id; ?>/>
                        <div><input type="text" placeholder="Your Name" name="name" /></div>
                        <div><input type="text" placeholder="Your Email Address" name="email" /></div>
                        <div><input type="number" placeholder="Your Phone Number" maxlength="10" minlength="10" name="phone" /></div>
                        <div><textarea placeholder="Message Body" style="min-height:120px" name="message" ></textarea></div>
                        <button class="submit" type="submit">Send Message</button>
                    </form>
                </div>
            </div>
            <div class="dark-less">
                <div class="boundary360">
                <a href="" title="view all properties managed by <?= $org;?>">
                <img src="<?= $avatar;?>"  class="img-responsive" alt="Property by "/>
                <div class="hyper-title"><?= $org;?></div>
                </a>
                
                <div class="">
                    <h3>Head Office</h3>
                    <p><?= $admin_data['ADDRESS_LINE1'];?></p>
                    <p><?= $admin_data['ADDRESS_LINE2'];?></p>
                    <p><?= Suburb::getName($admin_data['SUBURB_ID']);?></p>
                    <p>Port Elizabeth</p>
                    <p>6000</p>
                </div>
                <div class="">
                    <h3>Contact Info</h3>
                    <p><?php echo $admin_data_super['PHONE']; if(!empty($admin_data_super['PHONE'])){     echo ' (Phone)';}?></p>
                    <p><?php echo $admin_data['FAX']; if(!empty($admin_data['FAX'])){     echo ' (Fax)';}?></p>
                    <p><a href="http://<?= $admin_data['WEBSITE'];?>" target="_blank"><?= $admin_data['WEBSITE'];?></a></p>
                </div>
                </div>
            </div>
        </aside>
    </div>
</section>
</section>
<style>
 /*<editor-fold desc="Property View" defaultstate="collapsed">*/
/*<editor-fold desc="Acme" defaultstate="collapsed">*/

h5 {font-size: 17px;line-height: 22px;}
hr {margin-top: 330px;margin-bottom: 330px;border: 0;border-top: 1px solid #c4bc96;}
hr {box-sizing: content-box;height: 0;}
div.container {width: 80%;margin: auto;overflow: hidden;border: 2px solid #484329;background-color:#f4f4f4}
article#main-col {float: left;width: 65%;}
aside#sidebar {float: right;width: 30% }
 div.boundary360{max-width: 360px}
aside#sidebar .feedback input, aside#sidebar textarea{width:100%;padding:5px;background-color:#f4f4f4}
aside#sidebar .feedback input::placeholder, aside#sidebar textarea::placeholder{color: #484329}
aside#sidebar .feedback div{padding: .2em 0}
aside#sidebar .dark h3{color: #f4f4f4}
div.dark {padding: 15px;background: #484329;color: #fff;margin: 0 auto;}
div.dark-less {padding: 15px;background: #686351;color: #fff;margin: 0 auto;}
div.dark-less a{text-decoration: none;color: #fff}
div.dark-less div{padding: 10px 0}
div.dark-less a div{padding: .2em;background-color: #484329;color:  #c4bc96;font-size: 19px;font-weight: 700}
button.submit {height: 38px;background-color: #686351;border: 0;padding: 0 10px;color: #fff;}
button.submit:hover{background-color: #c4bc96;color:#484329 }
/*</editor-fold>*/

.HE_info,.HE_count{position: absolute;z-index: 1;padding: 2px 5px;color: #fff;background: rgba(0,0,0,.6);border-radius: 2px;}
.HE_count {bottom: 15px;right: 15px;}
.HE_info{top: 0;left: 0;width: 100%}
.HE_count span {padding: 0 2px;color: #fff}
.HE_dPL {white-space: pre-line;}
.HE_content .HE_details {word-break: break-word;word-wrap: break-word;margin: 20px 0 0 0;}
.img-responsive, .thumbnail > img, .thumbnail a > img, .carousel-inner > .item > img, .carousel-inner > .item > a > img {display: block;max-width: 100%;height: auto;}

.HE_content .HE_details  hr { margin: 15px 0;}
.HE_content .HE_details h5 {margin-bottom: 20px;font-weight: 700;}
.HE_content .HE_details .HE_features .row .col-xs-8 div {white-space: normal;}

.HE_content .HE_details .p24_poi .row, .HE_content .HE_details .HE_features .row, .HE_content .HE_details .p24_recentSales .row {margin-bottom: 5px;}

#property-view{padding: 1em 0}
#property-view * {box-sizing: border-box;}
#property-view .view-head  .fa {display: inline-block;font: normal normal normal 14px/1 FontAwesome;text-rendering: auto;}
#property-view .view-head  .fa-lg {font-size: 1.33333333em;line-height: .75em; vertical-align: -15%;}

#property-view .view-head .pull-right .fa {margin: 0 5px;}
.text-warning {color: #ff9e1d;}
#property-view .view-head  .pull-right .fa-2x {color: #ae9e1d;font-size: 1.8em;border: 1px solid #ae9e1d;border-radius: 50%;padding: 5px}
#property-view .view-head  .pull-right .fa-2x:hover{color: #fff;background-color: #ae9e1d}
#property-view .view-head  .fa {display: inline-block; font-size: 14px;;font: normal normal normal 14px/1 FontAwesome; font-size: inherit;text-rendering: auto;-webkit-font-smoothing: antialiased;-moz-osx-font-smoothing: grayscale;}

#month_rental{border-right-style:solid;border-width: 1px;border-right-color: #686351}
#month_rental > div {font-size: 22px;font-weight: 700;line-height: 24px;color: #ae9e1d;}
#property-view div.open > a {outline: 0;}
#property-view div.open > ul.pager-menu {display: block;}

#property-view div.pager{position: relative}
#property-view div.pager table{margin: 0 auto}
#property-view div.pager a {background-color: transparent;color: #686351;text-decoration: none;}
#property-view div.pager .pager-menu{max-height: 330px;margin: 1px 0 0 0;padding: 0;overflow-y: auto;background: #fff;border: 1px solid #d8dce3;
-webkit-box-shadow: 0 2px 3px 0 #a2acbc;box-shadow: 0 2px 3px 0 #a2acbc;border-radius: 0 2px 2px 0;}
#property-view div.pager .pager-menu{position: absolute;display: none;left: 10px;z-index: 1000;font-size: 15px;text-align: left;min-width: 185px;padding: .1em}
#property-view div.view-head{padding: .4em 0}
#property-view div.view-head .pull-left{padding: 0 .4em}
#property-view div.view-head h1 {font-size: 22px;font-weight: 700;line-height: 24px;color: #515b6d;overflow: hidden;
                text-overflow: ellipsis;white-space: nowrap;}
#MainGalleryTab{position: relative;width: 676px;height: 507px;margin: /*15px*/ 0;}
.carouselMini {position: relative;width: 676px;height: 75px;overflow: hidden;display: block;background-color: #dedcce;}
#MainGalleryImageList{text-align: center;position: relative}
#property-view  #MainGalleryImageList img {max-width: 100%;max-height: 507px;}
img {vertical-align: middle;}
.img_nav_key {position: absolute;top: 50%;left: 0;z-index: 10;margin-top: -40px;padding: 10px 15px 10px 10px;display: inline-block;background: rgba(0,0,0,.4);border-radius: 0 2px 2px 0;}
a.img_next {left: auto;right: 0;padding: 10px 10px 10px 15px;border-radius: 2px 0 0 2px;}
a.img_nav_key .fa {color: #d9d9d9;}

a.img_nav_key .fa:hover {color: #fff}
a.img_nav_key .fa:active {color: #ff9e1d;}
a.img_nav_key:hover{background-color: rgba(0,0,0,.6)}
.jcarousel-clip-horizontal{height: 85px;margin: 0 35px;}
.carouselMini .jcarousel-clip {overflow: auto;}
.carouselMini .jcarousel-item {padding: 2px;border: 2px solid transparent;width: 101px;}
li.jcarousel-item img { width: 100%;height: 62px}
li.jcarousel-item.carouselMiniActive {border: 2px solid #ae9e1d;}
.jcarousel-horizontal {position: absolute;top: 0;width: 30px;height: 70px;background: #5a523a;border: 2px solid #fff;}
.jcarousel-horizontal i{font-size: 1.3em;position: absolute;top: 50%;margin: -8px 0 0 -5px;color: #fff;}
/*</editor-fold>*/
@media screen and (min-width: 1366px){
    div.container {
    max-width: none !important;
    width: 1024px;
}
}
@media screen and (max-width: 1236px){
    #MainGalleryTab,.carouselMini{width: 100%;height: auto}
}
@media screen and (max-width: 768px){
    /*<editor-fold desc="Acme" defaultstate="collapsed">*/
div.container,#MainGalleryTab,.carouselMini{width: 100%}
article#main-col, aside#sidebar {float:none;width:100%}
 button, .feedback button{display:block;width:100%}
 form input[type="email"],form input[type="text"],form input[type="number"], .feedback textarea{width:100%;margin-bottom:20px}
 .row{padding-bottom: 15px}
 .field{text-align: left;border-bottom: 1px dotted #686351;text-transform: uppercase;font-style: italic;opacity: .6}
 .row .field,.row .value{width: 100%;display: block}
 div.boundary360{margin: 0 auto}
/*</editor-fold>*/
}
@media screen and (max-width: 360px) 
{
    #property-view div.view-head h1,#month_rental > div {font-size: 16px;}
    #property-view div.pager a{font-size: 14px}
    .jcarousel-clip-horizontal{display: none;display: -moz-groupbox;}
}
/*</editor-fold>*/
</style>
<?php require_once dirname(__FILE__, 3) . '/view/welcome/footer.php'; ?>

