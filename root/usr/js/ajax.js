function search(search_values,del) {
    consolidate();
    var obj = JSON.parse(search_values.value);
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
    var queryString = "suburb="+obj.suburb+"&accom="+obj.accom+"&rooms="+obj.rooms+"&build="+obj.build+"&maxp="+obj.maxp+"&minp="+obj.minp;
    queryString += "&beds="+obj.bed+"&baths="+obj.bath+"&bedroom="+obj.bedroom+"&feat="+obj.feat+"&del="+del;
    xmlhttp.open("GET", "root/view/content/results-pane.php?" + queryString, true);
    xmlhttp.send();
    document.getElementById('results-pane').style.display = "block";
    $('html, body').animate({scrollTop: $("#results-pane").offset().top}, 1250);
}