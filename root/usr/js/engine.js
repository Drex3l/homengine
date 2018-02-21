function property(type){
    /**
     * Users can interested in just rent Rooms, or the whole Property
     * If user selects the whole Property, controls to specify quantity of Bathrooms and Bedrooms become visible
     * If user selects just only a Room, controls to specify room type (single/sharing) become avaible
     * All these controls are given class name "subset"
     */
    var item = document.getElementsByClassName("subset");
    for(k=0;k<item.length;k++) item[k].style.display = "none";
    /**
     * The above hid everything
     * The follwing displays only the relevant controls
     */
    switch(type.value)
    {
        case 'Building':
            document.getElementById('beds').style.display = "block";
            document.getElementById('baths').style.display = "block";
            document.getElementById('HUnit').style.display = "block";
            break;
        case 'Bedroom':
            document.getElementById('room-setting').style.display = "inline-block";
            document.getElementById('gend-restr').style.display = "inline-block";
            break;
    }
    getValue(type);
}
function getValue(item){
    document.getElementById(item.name).value = item.value;  //------------------Take value from control and assign to its respective hidden field for AJAX
}
function getValues(name,del){
    /**
     * This function performs an identical job to [getValue], it works with checkbox values, where the latter deals with radio buttons"
     */
    var item = document.getElementsByName(name);
    var string = "";
    for(k=0;k<item.length;k++) if(item[k].checked) string += item[k].value +del;
    
    var id = name.substr(0,name.length-2);
    document.getElementById(id).value = string;
}
function prepareStrings(del){
    /**
     * Function synchronizes search vaules to actually selected checkboxes
     */
    getValues("feat[]",del);
    getValues("rooms[]",del);
}
function minZero(item) {
    document.getElementById(item.name).value = -1;
    if (item.value.length > 0) getValue(item);
}
function consolidate() {
    var suburb = document.getElementById('cmbSuburb').value;
    var accom = document.getElementById('accom').value;
    var rooms = document.getElementById('rooms').value;
    var ptype = document.getElementById('ptype').value;
    var minp = document.getElementById('minP').value;
    var maxp = document.getElementById('maxP').value;
    var bed = document.getElementById('bed').value;
    var bath = document.getElementById('bath').value;
    var btype = document.getElementById('btype').value;
    var bedroom = document.getElementById('bedroom').value;
    var roomgender = document.getElementById('roomgender').value;
    var feat = document.getElementById('feat').value;
    
    var obj = {"suburb":suburb,"accom":accom,"rooms":rooms,"ptype":ptype,"minp":minp,"maxp":maxp,"bed":bed,"bath":bath,"btype":btype,"bedroom":bedroom,"roomgender":roomgender,"feat":feat};
    var json = JSON.stringify(obj);
    document.getElementById('search_values').value = json;
    return json;
}
function pageNav(del,page,records){
   search(del,page,records);
}
function rmFeature(feature,del,page,records){
    var string = document.getElementById('feat').value;
    var newstring = string.replace(feature+",","");
    document.getElementById('feat').value = newstring;
    search(del,page,records);
}
function rmRoom(room,del,page,records){
    var string = document.getElementById('rooms').value;
    var newstring = string.replace(room+",","");
    document.getElementById('rooms').value = newstring;
    search(del,page,records);
}
function returnResults(browser)
{
    if(browser!=="Mozilla Firefox") window.alert("The following page is intended to return search results.\nIf it doesn't, consider switching to Mozilla Firefox.");
    history.back();
}
function previewImage(selection)
{
    var item = selection.id.substr(selection.id.length-1,1);    //--------------currently select item number
    
    document.getElementById("img_screen").src = selection.src;
    document.getElementById("image_info").innerHTML = document.getElementById("img_screen").alt = selection.alt;
    document.getElementById("img_screen").title = selection.title;
    document.getElementById("imageCounter").innerHTML = document.getElementById("img_screen").textContent = item;   //--------------store value on markup
    
    var li = document.getElementsByClassName("jcarousel-item");
    for(k=0;k<li.length;k++) li[k].classList = "jcarousel-item";
    
    document.getElementById("li-img"+item).classList.toggle('carouselMiniActive');
}
function previewImageNavigate(current,key,count){
    if(current === "") previewImage(document.getElementById("prvimg1"));
    else
    {
        current = parseInt(current);
        
        switch (key.id)
        {
            case 'img_nav_prev':
                if(current === 1)   current = count;
                else    current--;
                break;
            case 'img_nav_next':
                if(current === count)   current = 1;
                else    current++;
                break;
        }
        previewImage(document.getElementById("prvimg"+current));
    }
}