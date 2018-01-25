<?php require_once dirname(__FILE__, 3) . '/view/welcome/header.php'; ?>
<section class="banner honeycomb">
    <div class="banner-inner">
        <img src="<?= PATH; ?>/root/usr/img/sys/logo.gif" alt="banner"/>
        <p>Finding a <b>home</b> of your liking and preference has never been this easy.</p>
        <p>The same can be said for <strong>marketing</strong> one, reaching an audience as wide as the internet.</p>
    </div>
    <div style="height: 10px;margin-top: 2em;box-shadow: 0 -10px 10px 5px #dedcce;background-color: #fff" class="flash"></div>
</section>
</section>
<?php require_once dirname(__FILE__, 3) . '/view/content/search-pane.php'; ?>
<section id="results-pane" class="page-wrap js">
    <p class="bounceUp">
        <a href="#search-pane" id="up3" title="Search Pane">
            <svg class="gridicon gridicons-chevron-down" height="32" width="32" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><g><path d="M20 9l-8 8-8-8 1.414-1.414L12 14.172l6.586-6.586"></path></g></svg>
        </a>
    </p>
    <div id="search-results" class="feature">
        
    </div>
    <div class="side-lines" id="sl-L"></div>
    <div class="side-lines" id="sl-R"></div>
</section>
<?php 
// if user is not logged in, they cannot access this
if (empty($_SESSION['username'])) {
    require_once dirname(__FILE__, 3) . '/view/content/account-pane.php';
}
require_once dirname(__FILE__, 3) . '/view/welcome/footer.php'; ?>