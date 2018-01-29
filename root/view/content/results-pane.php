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

        echo "<table id='tblSelection' cellspacing='0'><tr><th class='killborder-L'>SUBURB</th><th>MARKET</th><th>PROPERTY</th><th>MAX PRICE</th><th>MIN PRICE</th><th $HU>BEDS</th><th $HU>BATHS</th><th $BU>GENDER</th><th $BU>BEDROOM</th><th class='killborder-R'>BUILDING</th></tr>";
        echo "<tr><td class='killborder-L'>".$suburb_name."</td><td>$accom</td><td>$ptype</td><td>$maxp</td><td>$mip</td><td $HU>$bedcount</td><td $HU>$bathcount</td><td $BU>$gender</td><td $BU>$bedroom</td><td class='killborder-R'>$building</td></tr>";
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
        $view = SearchDB::Engine(($page-1),$block,',',$accom, $ptype, $suburb,$rooms, $features,$minprice,$maxprice,$bedroom,$gender,$beds,$baths,$btype);
        $pages = SearchDB::page_count($block);
        ?>
            <form action="." method="POST">
                <table class="fancy">
                    <?php
                    if (!empty($view)) {
                        if (is_array($view[0])) {
                            $records = count($view);
                            foreach ($view as $row) {
                                ?>
                                <tr>
                                    <td><?= $row['ADDRESS LINE 1']; ?></td><td><?= $row['SUBURB']; ?></td><td><?= $row['TARGET']; ?></td><td><?= $row['LISTING']; ?></td>
                                </tr>
        <?php }
    } else {
        $records = 1; ?>
                            <tr>
                                <td><?= $view['ADDRESS LINE 1']; ?></td><td><?= $view['SUBURB']; ?></td><td><?= $view['TARGET']; ?></td><td><?= $view['LISTING']; ?></td>
                            </tr>
    <?php }
} ?>
                </table>
            </form>
            <span class="HUD"><?= $rooms;?>&nbsp;&nbsp;::&nbsp;&nbsp;<?= $features;?>&nbsp;&nbsp;::&nbsp;<?= $records; ?>&nbsp;&nbsp;</span>
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
</style>