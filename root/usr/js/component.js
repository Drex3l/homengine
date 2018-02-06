function load(){
    /**
     * Containers related to javascript code is hidden by default in css
     * The following displays such containers 
     * @container NodeList
     */
    var container = document.getElementsByClassName('js');
    for(k=0;k<container.length;k++){
        container[k].style.display = "block";
    }
    document.getElementById("results-pane").style.display = "none";//-----------No search results can be displayed when page loads
    
}
function currentRes(){
    document.getElementById("debugTool").innerHTML = null;
    debugResult(window.innerWidth + " x " + window.innerHeight);
}
function debugResult(text) {
    var tool = document.getElementById("debugTool");

    if (tool.innerHTML.length < 1) {
        tool.innerHTML = text;
        tool.style.padding = "0 1em";
        window.setTimeout(function () {
            tool.innerHTML = null;
            tool.style.padding = "0";
        }, 3000);
    }
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
function previewIMG(img,pane){
var modal = document.getElementById('property-preview-modal');
modal.style.display = "block";
document.getElementById("modal-img-title").innerHTML = img.title;
document.getElementById("modal-img-screen").src = img.src;
document.getElementById("modal-img-desc").innerHTML = img.alt;
//    window.alert(pane);
}