function search(suburb,accom) {
    if (window.XMLHttpRequest)
    {
        xmlhttp = new XMLHttpRequest();
    } else
    {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function ()
    {
        if (this.readyState == 4 && this.status == 200)
        {
//            document.getElementById("search-results").innerHTML = this.responseText;  // override content
        }
    };
//    xmlhttp.open("GET", "root/view/content/results-pane.php?suburb=" + suburb.value, true);
//    xmlhttp.send();
//    document.getElementById('results-pane').style.display = "block";
    window.alert(accom.value);
    $('html, body').animate({scrollTop: $("#results-pane").offset().top}, 1250);
}