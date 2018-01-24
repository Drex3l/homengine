<?php include_once dirname(__FILE__, 2) . '/welcome/header.php'; ?>
<section class="page-wrap" style="text-align: center">
    <span class="error-msg-inline honeycomb"><br/><br/><br/>
    <h1>Database Error</h1>

    <?php
    switch ($case) {
        case 'connect':
            ?>
            <p>There was an error connecting to the database.</p>
            <table style="margin: 0 auto;text-align: left">
                <tr><td style="color: #000">Code</td><td style="background-color: #ddd;font-weight: 700">&nbsp;<?php echo substr($error_message, 0, 22); ?></td></tr>
                <tr><td style="color: #000">Description</td><td style="background-color: #ddd">&nbsp;&nbsp;<?php echo substr($error_message, 23, (strlen($error_message)) - 23); ?>&nbsp;&nbsp;</td></tr>
            </table>
            <?php
            global $cs_file;
            if (file_exists(dirname(__FILE__, 4) . "/".self::$cs_file)) { echo '<br/> <p style="text-align:center">please check your <b>'.self::$cs_file.'</b> file</p>'; }
            break;
        case 'DML':
            $piece = explode(';', $error_message);
            ?>
            <p>Execution Error @<?= $piece[0]; ?></p>
            <p>Error Code : <?= $piece[1]; ?></p>
            <p>Description : <?= $piece[2]; ?></p>
        <?php break;
    default:
        ?>
            <p>Generic Error</p>
            <table style="margin: 0 auto;text-align: left">
                <tr><td style="color: #000">Code</td><td style="background-color: #ddd;font-weight: 700">&nbsp;<?php echo substr($error_message, 0, 15); ?></td></tr>
                <tr><td style="color: #000">Description</td><td style="background-color: #ddd">&nbsp;&nbsp;<?php echo substr($error_message, 17, (strlen($error_message))); ?>&nbsp;&nbsp;</td></tr>
            </table>
        <?php
        break;
}
?>
            </span>
    <div style="height: 10px;margin-top: 2em;box-shadow: 0 -10px 10px 5px #dedcce;background-color: #fff" class="flash"></div>
</section>
<?php include_once dirname(__FILE__, 2) . '/welcome/footer.php'; ?>