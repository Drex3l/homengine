<!DOCTYPE html>
<html>
    <body>
        <?php
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
        ?>
        <div>
            <form action="." method="get">
                <?= "$suburb : $accom : $rooms : $build : $maxprice : $minprice : $beds : $baths : $bedroom : $features ";?>
            </form>
        </div>
    </body>
</html>