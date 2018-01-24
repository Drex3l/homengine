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
//            document.getElementById("search-results").innerHTML = this.responseText;  // override content
        }
    };
//    xmlhttp.open("GET", "root/view/content/results-pane.php?suburb=" + suburb.value, true);
//    xmlhttp.send();
//    document.getElementById('results-pane').style.display = "block";
var items = "ACCOMMODATION\t:"+accom.value+"\nSUBURB\t\t\t:"+suburb.value+"\nROOMS\t\t\t:"+rooms.value+"\nBUILDING\t\t\t:"+build.value+"\nMAXIMUM PRICE\t:"+maxP.value;
items += "\nMINIMUM PRICE\t\t:"+minP.value+"\nBED ROOMS\t\t:"+bed.value+"\nBATH ROOMS\t\t:"+bath.value+"\nBEDROOM TYPE\t\t:"+bedroom.value+"\n";
items += +"\n"+feat.value;
    window.alert(items);
//    $('html, body').animate({scrollTop: $("#results-pane").offset().top}, 1250);
}