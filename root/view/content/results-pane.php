<!DOCTYPE html>
<html>
    <body>
        <div>
        <?php
        require_once dirname(__FILE__, 3) . '/epiqworx/db/handler.php';
        require_once dirname(__FILE__, 3) . ('/model.php');
        
        $suburb = intval($_GET['suburb']);
        $accom = $_GET['accom'];
        $rooms = $_GET['rooms'];
        $build = $_GET['build'];
        $maxprice = floatval($_GET['maxp']);
        $minprice = floatval($_GET['minp']);
        $beds = intval($_GET['beds']);
        $baths = intval($_GET['baths']);
        $bedroom = $_GET['bedroom'];
        $features = $_GET['feat'];

        echo '<table id="tblSelection" cellspacing="0"><tr><th class="killborder-L">SUBURB</th><th>ACCOMMODATION</th><th>PROPERTY</th><th>MAX PRICE</th><th>MIN PRICE</th><th>BEDS</th><th>BATHS</th><th class="killborder-R">BEDROOM</th></tr>';
        echo "<tr><td class='killborder-L'>$suburb</td><td>$accom</td><td>$build</td><td>$maxprice</td><td>$minprice</td><td>$beds</td><td>$baths</td><td class='killborder-R'>$bedroom</td></tr>";
        echo '</table>';
        
        if ($accom === 'Any') {
            $accom = '';
        }
        if ($build === 'Any') {
            $build = '';
        }

        $records = 0;
        $view = SearchDB::Engine($accom, $build, $suburb,$rooms, $features);
        ?>
            <input type="hidden" id="incomming" value="<?= $x;?>"/>
            <form action="." method="POST">
                <table>
                    <?php
                    if (!empty($view)) {
                        if (is_array($view[0])) {
                            $records = count($view);
                            foreach ($view as $row) {
                                ?>
                                <tr>
                                    <td><?= $row['ADDRESS LINE 1']; ?></td><td><?= $row['SUBURB']; ?></td><td><?= $row['ACCOMMODATION']; ?></td><td><?= $row['PROPERTY TYPE']; ?></td>
                                </tr>
        <?php }
    } else {
        $records = 1; ?>
                            <tr>
                                <td><?= $view['ADDRESS LINE 1']; ?></td><td><?= $view['SUBURB']; ?></td><td><?= $view['ACCOMMODATION']; ?></td><td><?= $view['PROPERTY TYPE']; ?></td>
                            </tr>
    <?php }
} ?>
                </table>
            </form>
            <span style="color: rgba(0,0,0,.3);margin-left: auto;background-color: #eee;display: block;text-align: right"><?= $rooms;?>&nbsp;&nbsp;::&nbsp;&nbsp;<?= $features;?>&nbsp;&nbsp;::&nbsp;<?= $records; ?>&nbsp;&nbsp;</span>
        </div>
    </body>
</html>
<style>
#tblSelection{margin: 0 auto}
#tblSelection td{border: 0 dotted #444;text-align: center;border-bottom-width: 1px}
#tblSelection th{font-size: 8pt;border: 1px dotted #444;font-family: Arial;padding: 5px}
#tblSelection .killborder-L{border-left-style: none}
#tblSelection .killborder-R{border-right-style: none}
</style>