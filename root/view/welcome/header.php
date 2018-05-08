<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>
<!DOCTYPE html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=.67">
    <title><?= $title; ?></title>
    <link rel="stylesheet" type="text/css"   href="<?= PATH; ?>/root/usr/css/main.css" />
    <link rel="stylesheet" type="text/css"   href="<?= PATH; ?>/root/usr/css/engine.css" />
    <link rel="stylesheet" type="text/css"   href="<?= PATH; ?>/root/usr/css/response.css" />
    <link rel="stylesheet" type="text/css"   href="<?= PATH; ?>/root/epiqworx/css/style.css" />
    <link rel="stylesheet" type="text/css"   href="<?= PATH; ?>/root/epiqworx/css/responsive.css" />
    <link rel="stylesheet" type="text/css"   href="<?= PATH; ?>/root/usr/css/font-awesome.min.css" />
    <link rel="shortcut icon" type="image/png" href="<?= PATH; ?>/root/usr/img/sys/logo-lite.png"/>
    <SCRIPT LANGUAGE=JavaScript> function now() { window.location.reload(true); }</SCRIPT>

    <meta name="description" content="Property Listing and Powerfull Search Engine"/>
    <meta name="keywords" content="Homengine, Home, Property, Properties, Property Features"/>
    <meta name="author" conent="SWIFT"/>
</head>
<body onload="load('<?= $action;?>')" onresize="currentRes()"  onscroll="scroll('<?= $action;?>')">
    <section id="pageWrap" class="page-wrap main flash">
        <header  id="main-header">
            <div class="header-inner">
                <a href="<?= PATH; ?>" class="home-key" title="Home Page"><img alt="Logo" class="logo" src="<?= PATH; ?>/root/usr/img/sys/logo-lite.gif" /></a>
                <a id="1navbar-Find-link-0" href="<?= $find_home; ?>" class="pull-left big find-home" title="Property Search Engine">Find Home</a>
                <nav>
                    <div id="mkey1" class="menu-key">
                        <div class="bar1 bar"></div>
                        <div class="bar2 bar"></div>
                        <div class="bar3 bar"></div>
                    </div>
                    <ul class="no-display">
                        <li><a id="1navbar-Find-link-1" href="<?= $find_home; ?>" class="find-home">Find Home</a></li>
                        <li><a href="#">List Home</a></li>
                        <li><a id="1navbar-Account-link-0" href="<?= $HE_AC; ?>" class="account-section">Sign In/Up</a></li>
                    </ul>
                    <span class="big">
                        <a id="1navbar-Account-link-1" href="<?= $HE_AC; ?>" class="pull-right account-section"  title="HomeEngine Account">Sign Up/In</a>
                        <a href="#" class="pull-right" title="Lease Out Yiur Own">List Home</a>

                    </span>
                </nav>
            </div>
        </header>
        <style>
            .honeycomb{background: url(<?= PATH; ?>/root/usr/img/sys/honeycomb-1.png) fixed}
        </style>
        <!---End header-->
