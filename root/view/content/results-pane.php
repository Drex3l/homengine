<!DOCTYPE html>
<html>
    <body>
        <div>
        <?php
        require_once dirname(__FILE__, 3) . '/epiqworx/db/handler.php';
        require_once dirname(__FILE__, 3) . ('/model.php');
        
        $page = intval($_GET['page']);
        $block = intval($_GET['records']);
        $del = $_GET['del'];
        $suburb = intval($_GET['suburb']);
        $accom = $_GET['accom'];
        $rooms = $_GET['rooms'];
        $ptype = $_GET['ptype'];
        $maxprice = floatval($_GET['maxp']);
        $minprice = floatval($_GET['minp']);
        $beds = intval($_GET['beds']);
        $baths = intval($_GET['baths']);
        $kitch = intval($_GET['kitch']);
        $btype = $_GET['btype'];
        $bedroom = $_GET['bedroom'];
        $gender = $_GET['roomgender'];
        $features = $_GET['feat'];
        
        //---------------------------------------------------------Suburb Filter
        if(($suburb_name = Suburb::getName($suburb)) === "-- suburb --"){ $suburb_name = "--";}
        //-----------------------------------------------------------Price Range
        if(($maxp = "R$maxprice") === "R0"){ $maxp = "--";}
        if(($mip = "R$minprice") === "R0"){ $mip = "--";}
        //----------------------------------------------------Housing Unit Rooms
        if(($bedcount = "$beds") === "-1"){ $bedcount = "--";}
        if(($bathcount = "$baths") === "-1"){ $bathcount = "--";}
        if(($kitchcount = "$kitch") === "-1"){ $kitchcount = "--";}
        if(($building = "$btype") === ""){ $building = "--";}

        switch ($ptype) {
                    case 'Bedroom':
                        $BU = "";
                        $HU = "style='display:none'";
                        break;
                    case 'Building':
                        $BU = "style='display:none'";
                        $HU = "";
                        break;
                    default :
                        $BU = "style='display:none'";
                        $HU = "style='display:none'";
                        break;
                }

        echo "<table id='tblSelection' cellspacing='0'><tr><th class='killborder-L'>SUBURB</th><th>MARKET</th><th>PROPERTY</th><th>MAX PRICE</th><th>MIN PRICE</th><th $HU>BEDS</th><th $HU>BATHS</th><th $HU>KITCHENS</th><th $BU>GENDER</th><th $BU>BEDROOM</th><th class='killborder-R'>BUILDING</th></tr>";
        echo "<tr><td class='killborder-L'>".$suburb_name."</td><td>$accom</td><td>$ptype</td><td>$maxp</td><td>$mip</td><td $HU>$bedcount</td><td $HU>$bathcount</td><td $HU>$kitchcount</td><td $BU>$gender</td><td $BU>$bedroom</td><td class='killborder-R'>$building</td></tr>";
        echo '</table>';
        
        if ($accom === 'Any') {
            $accom = '';
        }
        if ($ptype === 'Any') {
            $ptype = '';
        }
        if ($bedroom === 'Any') {
            $bedroom = '';
        }
        if ($gender === 'Any') {
            $gender = '';
        }

        $records = 0;
        $imgInfo[2] = $img[2] = array();
        
        $view = Engine::Find(($page-1),$block,',',$accom, $ptype, $suburb,$rooms, $features,$minprice,$maxprice,$bedroom,$gender,$beds,$baths,$kitch,$btype);
        $pages = Engine::page_count($block);
        ?>
            <form action="." method="POST">
                <input type="hidden" name="action" value="view"/>
                <table class="fancy">
                    <?php
                    if (!empty($view)) {
                        if (is_array($view[0])) {
                            $records = count($view);
                            foreach ($view as $row) {
                                $preview = Property::img_preview($row['ID']);
                                for ($k=0;$k<3;$k++){   
                                    $img[$k] = "root/usr/img/sys/logo-lite.png"; $imgInfo[$k]['name'] = $imgInfo[$k]['desc'] = "";   }
                                
                                if(count($preview[0])>0){
                                    for ($k = 0; $k < count($preview); $k++) {
                                        $img[$k] = 'root/usr/img/property/' . Property::getAdmin($row['ID']) . "/" . $preview[$k]['PICTURE'];
                                        $imgInfo[$k]['name'] = $preview[$k]['TITLE'];
                                        $imgInfo[$k]['desc'] = $preview[$k]['DESCRIPTION'];
                                    }
                                }else{
                                    if (is_array($preview)) {
                    $img[0] = 'root/usr/img/property/' . Property::getAdmin($row['ID']) . "/" . $preview['PICTURE'];
                    $imgInfo[0]['name'] = $preview['TITLE'];
                    $imgInfo[0]['desc'] = $preview['DESCRIPTION'];
                }
            }
                                ?>
                                <tr>
                                    <td><button class="submit" name="smbBtn" value="<?= $row['ID']; ?>"></button><?= $row['ADDRESS LINE 1']; ?><span class="hero"><?= $row['SUBURB']; ?></span></td>
                    
                                    <td><button title="HE-<?= $row['ID']."P"; ?>" class="submit" name="smbBtn" value="<?= $row['ID']; ?>"></button><span class="coward"><?= $row['SUBURB']; ?></span><span class="hero-lite"><?= $row['SETTING']; ?></span><span class="hero"><?= $row['TARGET']; ?></span></td>
                    
                                    <td class="big preview"><button class="submit" name="smbBtn" value="<?= $row['ID']; ?>"><span class="coward">F</span></button><span class="coward"><?= $row['PROPERTY TYPE']; ?></span><span class="property-img">
                                            <img height="80" src="<?= $img[0];?>" alt="<?= $imgInfo[0]['desc'];?>" <?php if($img[0] !== "root/usr/img/sys/logo-lite.png"){ echo 'onclick="previewIMG(this)" title="'.$imgInfo[0]['name'].'" style="cursor: pointer"';} ?> />
                                        </span></td>
                    
                                    <td class="big preview"><button class="submit" name="smbBtn" value="<?= $row['ID']; ?>"><span class="coward"><?= $row['ID']; ?></span></button><span class="coward"><?= $row['TARGET']; ?></span><span class="property-img">
                                            <img height="80" src="<?= $img[1];?>" alt="<?= $imgInfo[1]['desc'];?>" <?php if($img[1] !== "root/usr/img/sys/logo-lite.png"){ echo 'onclick="previewIMG(this)" title="'.$imgInfo[1]['name'].'" style="cursor: pointer"';} ?> />
                                        </span></td>
                    
                                    <td style="width: 0" class="big preview"><button class="submit" name="smbBtn" value="<?= $view['ID']; ?>"></button><span class="property-img">
                                            <img height="80" src="<?= $img[2];?>" alt="<?= $imgInfo[2]['desc'];?>" <?php if($img[2] !== "root/usr/img/sys/logo-lite.png"){ echo 'onclick="previewIMG(this)" title="'.$imgInfo[2]['name'].'" style="cursor: pointer"';} ?> />
                                        </span></td>
                                </tr>
        <?php }
    } else {
        $records = 1; 
        $preview = Property::img_preview($view['ID']);
        for ($k=0;$k<3;$k++){   $img[$k] = "root/usr/img/sys/logo-lite.png";  $imgInfo[$k]['name'] = $imgInfo[$k]['desc'] = "";  }
        if(is_array($preview[0])){
            for($k=0;$k<count($preview[0]);$k++){   
                $img[$k] = 'root/usr/img/property/'.Property::getAdmin($view['ID'])."/".$preview[$k]['PICTURE'];
                $imgInfo[$k]['name'] = $preview[$k]['TITLE'];
                $imgInfo[$k]['desc'] = $preview[$k]['DESCRIPTION'];
            }
        }else{
            if(is_array($preview)){
                $img[0] = 'root/usr/img/property/'.Property::getAdmin($view['ID'])."/".$preview['PICTURE'];
                $imgInfo[0]['name'] = $preview['TITLE'];
                $imgInfo[0]['desc'] = $preview['DESCRIPTION'];
            }
        }
        ?>
                            <tr>
                                <td><button class="submit" name="smbBtn" value="<?= $view['ID']; ?>"></button><?= $view['ADDRESS LINE 1']; ?><span class="hero"><?= $view['SUBURB']; ?></span></td>
                    
                                <td><button class="submit" name="smbBtn" value="<?= $view['ID']; ?>"></button><span class="coward"><?= $view['SUBURB']; ?></span><span class="hero-lite"><?= $view['SETTING']; ?></span><span class="hero"><?= $view['TARGET']; ?></span></td>
                    
                                <td class="big preview"><button class="submit" name="smbBtn" value="<?= $view['ID']; ?>"><span class="coward"></span></button><span class="coward"><?= $view['PROPERTY TYPE']; ?></span><span class="property-img">
                                        <img height="80" src="<?= $img[0];?>" alt="<?= $imgInfo[0]['desc'];?>" <?php if($img[0] !== "root/usr/img/sys/logo-lite.png"){ echo 'onclick="previewIMG(this)" title="'.$imgInfo[0]['name'].'" style="cursor: pointer"';} ?> />
                                    </span></td>
                    
                                    <td class="big preview"><button class="submit" name="smbBtn" value="<?= $view['ID']; ?>"><span class="coward"><?= $view['ID']; ?></span></button><span class="coward"><?= $view['TARGET']; ?></span><span class="property-img">
                                            <img height="80" src="<?= $img[1];?>" alt="<?= $imgInfo[1]['desc'];?>" <?php if($img[1] !== "root/usr/img/sys/logo-lite.png"){ echo 'onclick="previewIMG(this)" title="'.$imgInfo[1]['name'].'" style="cursor: pointer"';} ?> />
                                        </span></td>
                    
                                    <td style="width: 0" class="big preview"><button class="submit" name="smbBtn" value="<?= $view['ID']; ?>"></button><span class="property-img">
                                            <img height="80" src="<?= $img[2];?>" alt="<?= $imgInfo[2]['desc'];?>" <?php if($img[2] !== "root/usr/img/sys/logo-lite.png"){ echo 'onclick="previewIMG(this)" title="'.$imgInfo[2]['name'].'" style="cursor: pointer"';} ?> />
                                        </span></td>
                            </tr>
    <?php }
} ?>
                </table>
            </form>
            <?php if(empty($view)){ ?>
        <span>No Results</span>
        <?php } ?>
            <span class="HUD"><?= $rooms;?>&nbsp;&nbsp;::&nbsp;&nbsp;<?= $features;?>&nbsp;&nbsp;
                <div class="pager">
                     <?php
                    if($page <= 1){
                        echo "<a class='pull-left text-muted' href='javascript:;' ><i class='fa fa-angle-left' title='Previous'></i>&LessLess;</a>";
                    }else{
                        echo "<a class='pull-left' href='javascript:pageNav(\"$del\",".($page-1).",$block)' ><i class='fa fa-angle-left' title='Previous'></i>&LessLess;</a>";
                    }
                    if($page < $pages){
                        echo "<a class='pull-right' href='javascript:pageNav(\"$del\",".($page+1).",$block)' title='Next'>&GreaterGreater;<i class='fa fa-angle-right'></i></a>";
                    }else{
                        echo "<a class='pull-right text-muted' href='javascript:;' title='Next'>&GreaterGreater;<i class='fa fa-angle-right'></i></a>";
                    }
                    ?>
                    <div class="text-center">
                        <ul class="pagination">
                            <li>
                                <div id="dpnPages" class="btn-group" title="All Pages" onblur="dpnPages.classList='btn-group'">
                                    <a href='javascript:popupTogle(dpnPages)'><?= "Page $page of $pages";?></a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <?php for($k=1;$k<=$pages;$k++){?>
                                            <a href='javascript:pageNav("<?= $del;?>",<?=$k;?>,<?=$block;?>)' <?php if(isset($_GET['page']) && $_GET['page']== $k){echo 'class="selected"';}else if(!isset($_GET['page']) && $k==1){echo 'class="selected"';}?>>
                                    <?= str_pad($k,2,'0', STR_PAD_LEFT);?></a>
                                    <?php
                                    if($k % 3 == 0){
                                        echo '</li><li>';
                                    } }?>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                        <style>
                        <?php if($page <= 1){
                            echo '.fa-angle-left::before {content: "--";}';
                        }else{?>
                        .fa-angle-left::before {content: "<?= $page-1;?>";}
                        <?php
                        }
                        if($page < $pages){?>
                        .fa-angle-right::before {content: "<?= $page+1;?>";}
                        <?php }else{
                            echo '.fa-angle-right::before {content: "--";}';
                        }?>
                    </style>
                    </div>
                </div>
                &nbsp;&nbsp;::&nbsp;<?= $records; ?>&nbsp;&nbsp;</span>
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
        </div>
    </body>
</html>
<style>
#tblSelection{margin: 0 auto 10px auto}
#tblSelection td{border: 0 dotted #444;text-align: center;border-bottom-width: 0;background-color: #dedcce;color: #484329}
#tblSelection th{font-size: 8pt;border: 1px dotted #c4bc96;font-family: Arial;padding: 5px;background-color: #efeddf;color: #484329}
#tblSelection .killborder-L{border-left-style: none}
#tblSelection .killborder-R{border-right-style: none}
span.HUD{color: rgba(0,0,0,.3);margin-left: auto;background-color: #eee;display: block;text-align: right}
table.fancy tr:nth-child(even){background-color: #f6f6f6;}
table.fancy tr:nth-child(odd){background-color: #fff;}

div.pager{max-width: 256px;padding: 0;font-size: 13px;line-height: 13px;background: #fff;border: 1px solid #c4bc96;border-radius: 2px;box-sizing: border-box;word-wrap: break-word;display: inline-block}
::before, ::after {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;}
div.pager a[class^="pull"] {display: inline-block;font-weight: 700;}
div.pager a.text-muted {color: #abb4c3;cursor: default;text-decoration: none;background-color: #fff}
div.pager .fa {margin: 0 10px;}
.fa {display: inline-block;font: normal normal normal 14px/1 FontAwesome;font-size: 14px;font-size: inherit;text-rendering: auto;-webkit-font-smoothing: antialiased;-moz-osx-font-smoothing: grayscale;}

.text-center {text-align: center;display: inline-block}

div.pager::after {clear: both;}
div.pager::before, div.pager::after {content: " ";display: table;}
div.pager::after {clear: both;}
div.pager::before, div.pager::after {content: " ";display: table;}

div.pager a {background-color: #fff;color: #6ca810;text-decoration: none;font-size: 16px}
.pagination { margin: 0;padding: 0;}
.pagination {display: inline-block;padding-left: 0;margin:0;border-radius: 2px;}
.pagination > li {display: inline;}
div.pager ul.pagination li a { margin: 0 12px;padding: 6px 4px;color: #515b6d;border: none;
        border-bottom-width: medium;
        border-bottom-style: none;
        border-bottom-color: currentcolor;
    background: transparent;
    border-bottom: 2px solid transparent;
    border-radius: 0;
}
.btn-group, .btn-group-vertical {position: relative;display: inline-block;vertical-align: middle;}
div.pager ul.pagination li a {margin: 0 12px;padding: 0 4px;color: #515b6d;border: 0 solid #dfdfdf;background: #fff;border-radius: 0;font-size: 13px}
.open > .dropdown-menu { display: block;}
.dropdown-menu {height: auto;max-height: 330px;margin: 1px 0 0 0;padding: 0;overflow-y: auto;background: #fff;border: 1px solid #d8dce3;-webkit-box-shadow: 0 2px 3px 0 #a2acbc;box-shadow: 0 2px 3px 0 #a2acbc;border-radius: 0 2px 2px 0;}
.dropdown-menu {position: absolute;top: 100%;left: -26px;z-index: 1000;display: none;float: left;min-width: 160px;padding: 5px 0;margin: 2px 0 0;list-style: none;font-size: 15px;text-align: left;background-color: #fff;
    border: 1px solid #ccc;border: 1px solid rgba(0,0,0,.15);border-radius: 2px;-webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);box-shadow: 0 6px 12px rgba(0,0,0,.175);background-clip: padding-box;}
.dropdown-menu a.selected{color: #008c8c;font-weight: 700;border-bottom: 1px dotted #a4a4a4}

</style>