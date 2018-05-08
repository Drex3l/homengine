function load(webpage){
    /**
     * Containers related to javascript code is hidden by default in css
     * The following displays such containers 
     * @container NodeList
     */
    var container = document.getElementsByClassName('js');
    for(k=0;k<container.length;k++){
        container[k].style.display = "block";
    }
    var hidden = document.getElementsByClassName("js-no-display");//-----------No search results can be displayed when page loads
    for(k=0;k<hidden.length;k++) hidden[k].style.display = "none";
    //-----------------------------------------------Page Specific Configuration
    switch(webpage)
    {
	case 'home':
		
	break;
        case 'view':
            //=========================*Load Property Main*=====================
            var dp = document.getElementById("property-profile-image");
            if(dp.value.length>0)
            {
                var sIMG = document.getElementsByClassName('select-img');
                for( k=0; k < sIMG.length; k++) if(dp.value === sIMG[k].src.split('/')[sIMG[k].src.split('/').length-1])    previewImage(document.getElementById("prvimg"+(k+1)));
            }
	    document.getElementById('pageWrap').classList.toggle('page-wrap');
            //==================================================================
            break;
    }
    currentRes();
}
function scroll(webpage)
{
    //-----------------------------------------------Page Specific Configuration
    switch(webpage)
    {
        case 'view':
            var head = document.getElementById("property-view-head");
            var p = document.documentElement.scrollTop;
            if(p>147) {
                head.style.transition = ".6s";
                head.style.top = "0";
            }
            if(p<32) {
                head.style.transition = "none";
                window.setTimeout(function () { head.style.top = "-58px"; }, 100);
                
            }
            break;
    }
//    document.getElementById("debugTool").innerHTML = null;
//    debugResult(document.documentElement.scrollTop.toString());
}
function toggleFeature(x)
{
    if(window.innerWidth <= 515)
    {
        if(x.style.display === "block")
        {
            x.style.display = "none"
        }
        else
        {
            x.style.display = "block"
        }
    }
}
function popupTogle(control)
{
    control.classList.toggle('open');
}
function previewIMG(img){
var modal = document.getElementById('property-preview-modal');
modal.style.display = "block";
document.getElementById("modal-img-title").innerHTML = img.title;
document.getElementById("modal-img-screen").src = img.src;
document.getElementById("modal-img-desc").innerHTML = img.alt;
}
