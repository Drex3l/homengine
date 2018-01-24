function search(suburb,accom,rooms,build,maxP,minP,bed,bath,bedroom,feat) {
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
            document.getElementById("search-results").innerHTML = this.responseText;  // override content
        }
    };
    var queryString = "suburb="+suburb.value+"&accom="+accom.value+"&rooms="+rooms.value+"&build="+build.value+"&maxp="+maxP.value+"&minp="+minP.value;
    queryString += "&beds="+bed.value+"&baths="+bath.value+"&bedroom="+bedroom.value+"&feat="+feat.value;
    xmlhttp.open("GET", "root/view/content/results-pane.php?" + queryString, true);
    xmlhttp.send();
    document.getElementById('results-pane').style.display = "block";
    $('html, body').animate({scrollTop: $("#results-pane").offset().top}, 1250);
}