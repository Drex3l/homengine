//-------------------------------------------------------FIND HOME - SEARCH PANE
$(document).ready(function () {
    $("#navbar-Find-link-0").click(function () {
        $('html, body').animate({scrollTop: $("#search-pane").offset().top}, 500);
    });
});
$(document).ready(function () {
    $("#navbar-Find-link-1").click(function () {
        $('html, body').animate({scrollTop: $("#search-pane").offset().top}, 500);
    });
});
$(document).ready(function () {
    $("#up1").click(function () {
        $('html, body').animate({scrollTop: $("#header-inner").offset().top}, 500);
    });
});
//-----------------------------------------------------SIGN IN/UP - ACCOUNT PANE
$(document).ready(function () {
    $("#navbar-Market-link-0").click(function () {
        $('html, body').animate({scrollTop: $("#account-pane").offset().top}, 750);
    });
});
$(document).ready(function () {
    $("#navbar-Market-link-1").click(function () {
        $('html, body').animate({scrollTop: $("#account-pane").offset().top}, 750);
    });
});
$(document).ready(function () {
    $("#up2").click(function () {
        $('html, body').animate({scrollTop: $("#header-inner").offset().top}, 750);
    });
});
//----------------------------------------------------RESULTS PANE - SEARCH PANE
$(document).ready(function () {
    $("#up3").click(function () {
        $('html, body').animate({scrollTop: $("#search-pane").offset().top}, 750);
    });
});