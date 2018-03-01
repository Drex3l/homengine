$(document).ready(function () {
    $(".back-head").click(function () {
        $('html, body').animate({scrollTop: $("#main-header").offset().top}, 500);
    });
});
//-------------------------------------------------------FIND HOME - SEARCH PANE
$(document).ready(function () {
    $(".find-home").click(function () {
        $('html, body').animate({scrollTop: $("#search-pane").offset().top}, 500);
    });
});
//-----------------------------------------------------SIGN IN/UP - ACCOUNT PANE
$(document).ready(function () {
    $(".account-section").click(function () {
        $('html, body').animate({scrollTop: $("#account-pane").offset().top}, 750);
    });
});
//----------------------------------------------------RESULTS PANE - SEARCH PANE
$(document).ready(function () {
    $("#up3").click(function () {
        $('html, body').animate({scrollTop: $("#search-pane").offset().top}, 750);
    });
});