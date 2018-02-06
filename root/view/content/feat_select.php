<!DOCTYPE html>
<html>
    
    <body>
        <div>
        <?php
        require_once dirname(__FILE__, 3) . '/epiqworx/db/handler.php';
        require_once dirname(__FILE__, 3) . ('/model.php');
        $features = $_GET['feat'];
        $rooms = $_GET['rooms'];
        $page = intval($_GET['page']);
        $block = intval($_GET['records']);
        $del = $_GET['del'];
        
        ?>
            <div class="h1"><h1>Property Features</h1></div>
            <?php
        if($features !== ""){
            $selection = Feature::getSelection($features);
        ?>
            
            <?php if(!empty($selection['accessory'])){$item = explode(',',$selection['accessory']);?>
            <div class="section">
            <h2>Accessories</h2>
            <table>
                <?php foreach ($item as $value){$feat = Feature::getName($value);?>
                <tr><td><?= $feat['NAME'];?></td><td class="rm"><button onclick='rmFeature("<?= $feat['ITEM_CODE'];?>","<?= $del;?>",<?=$page;?>,<?=$block;?>)' title="Remove Feature">X</button></td></tr>
                <?php }?>
            </table>
            </div>
            <?php }?>
            <?php if(!empty($selection['furniture'])){$item = explode(',',$selection['furniture']);?>
            <div class="section">
            <h2>Furniture</h2><hr/>
            <table>
                <?php foreach ($item as $value){$feat = Feature::getName($value);?>
                <tr><td><?= $feat['NAME'];?></td><td class="rm"><button onclick='rmFeature("<?= $feat['ITEM_CODE'];?>","<?= $del;?>",<?=$page;?>,<?=$block;?>)' title="Remove Feature">X</button></td></tr>
                <?php }?>
            </table>
            </div>
            <?php }?>
            <?php if(!empty($selection['convinience'])){$item = explode(',',$selection['convinience']);?>
            <div class="section">
            <h2>Convinience</h2><hr/>
            <table>
                <?php foreach ($item as $value){$feat = Feature::getName($value);?>
                <tr><td><?= $feat['NAME'];?></td><td class="rm"><button onclick='rmFeature("<?= $feat['ITEM_CODE'];?>","<?= $del;?>",<?=$page;?>,<?=$block;?>)' title="Remove Feature">X</button></td></tr>
                <?php }?>
            </table>
            </div>
            <?php }?>
            <?php if(!empty($selection['sundry'])){$item = explode(',',$selection['sundry']);?>
            <div class="section">
            <h2>Sundry</h2>
            <table>
                <?php foreach ($item as $value){$feat = Feature::getName($value);?>
                <tr><td><?= $feat['NAME'];?></td><td class="rm"><button onclick='rmFeature("<?= $feat['ITEM_CODE'];?>","<?= $del;?>",<?=$page;?>,<?=$block;?>)' title="Remove Feature">X</button></td></tr>
                <?php }?>
            </table>
            </div>
            <?php }?>
        <?php }?>
            <?php if($rooms !== ""){ $item = explode(',',substr($rooms,0,strlen($rooms)-1));?>
            <div class="section">
                <h2>Rooms</h2>
                <table>
                <?php foreach ($item as $value){$feat = Room::getName($value);?>
                <tr><td><?= $feat['ROOM_TYPE'];?></td><td class="rm"><button onclick='rmRoom("<?= $feat['ROOM_ID'];?>","<?= $del;?>",<?=$page;?>,<?=$block;?>)' title="Remove Room">X</button></td></tr>
                <?php }?>
            </table>
            </div>
            <?php } ?>
        </div>
    </body>
</html>
<style>
</style>