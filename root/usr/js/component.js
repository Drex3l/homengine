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