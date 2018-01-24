<?php require_once dirname(__FILE__, 2) . '/welcome/header.php'; ?>
<section class="page-wrap" style="text-align: center">
    <span class="error-msg-inline honeycomb"><br/><br/><br/>
        <?php if (isset($error_message)) { ?><p><?= $error_message; ?></p><?php } ?>
        <table cellpadding="2" style="margin: 0 auto;text-align: left;border: 1px dashed #999">
            <?php
            if (isset($error)) {
                for ($k = 0; $k < count($error); $k++) {
                    ?>
            <tr><td style="color: #000">&nbsp;&nbsp;E<?= str_pad(($k+1), 2, '0', STR_PAD_LEFT); ?>&nbsp;&nbsp;</td><td style="background-color: #c4bc96;font-weight: 700">&nbsp;&nbsp;<?= $error[$k]; ?>&nbsp;&nbsp;</td></tr>
                <?php
                }
            }
            ?>
        </table><br/>
        <p style="color: #000;height: 80px">we apologize for this <b style="background-color: #484329;color: #c4bc96;height: 100%">&nbsp;&nbsp;inconvenience&nbsp;&nbsp;</b></p>
    </span>
    <div style="height: 10px;margin-top: 2em;box-shadow: 0 -10px 10px 5px #dedcce;background-color: #fff" class="flash"></div>
</section>
<?php require_once dirname(__FILE__, 2) . '/welcome/footer.php'; ?>