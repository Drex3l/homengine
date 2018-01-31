function search(del,page,records) {
    var search_values = consolidate();
    document.getElementById("sl-L").style.left = document.getElementById("sl-R").style.right ="-192px";
    var obj = JSON.parse(search_values);
    
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
    var queryString = "suburb="+obj.suburb+"&accom="+obj.accom+"&rooms="+obj.rooms+"&ptype="+obj.ptype+"&maxp="+obj.maxp+"&minp="+obj.minp+"&beds="+obj.bed+"&baths="+obj.bath;
    queryString += "&btype="+obj.btype+"&bedroom="+obj.bedroom+"&roomgender="+obj.roomgender+"&feat="+obj.feat+"&page="+page+"&records="+records+"&del="+del;
    xmlhttp.open("GET", "root/view/content/results-pane.php?" + queryString, true);
    xmlhttp.send();
    
    document.getElementById('results-pane').style.display = "block";
    if(obj.feat.length>0) document.getElementById("sl-L").style.left = "0";
    window.setTimeout(featureSelect(obj.feat,del,page,records), 3000);
    $('html, body').animate({scrollTop: $("#results-pane").offset().top}, 1250);
}
function featureSelect(selection,del,page,records){
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
            document.getElementById("feature-select").innerHTML = this.responseText;  // override content
        }
    };
    xmlhttp.open("GET", "root/view/content/feat_select.php?feat=" + selection+"&page="+page+"&records="+records+"&del="+del, true);
    xmlhttp.send();
//    getValues("feat[]",del);
}