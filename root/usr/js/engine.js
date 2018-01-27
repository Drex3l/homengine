function building(type){
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
            document.getElementById('room-setting').style.display = "block";
            break;
    }
    getValue(type);
}
function getValue(item){
    document.getElementById(item.name).value = item.value;  //------------------Take value from control and assign to its respective hidden field for AJAX
}
function getValues(name,del){
    var item = document.getElementsByName(name);
    var string = "";
    for(k=0;k<item.length;k++) if(item[k].checked) string += item[k].value +del;
    
    var id = name.substr(0,name.length-2);
    document.getElementById(id).value = string;
}
function consolidate(){
    var suburb = document.getElementById('cmbSuburb').value;
    var accom = document.getElementById('accom').value;
    var rooms = document.getElementById('rooms').value;
    var build = document.getElementById('build').value;
    var minp = document.getElementById('minP').value;
    var maxp = document.getElementById('maxP').value;
    var bed = document.getElementById('bed').value;
    var bath = document.getElementById('bath').value;
    var bedroom = document.getElementById('bedroom').value;
    var feat = document.getElementById('feat').value;
    
    var obj = {"suburb":suburb,"accom":accom,"rooms":rooms,"build":build,"minp":minp,"maxp":maxp,"bed":bed,"bath":bath,"bedroom":bedroom,"feat":feat};
    var json = JSON.stringify(obj);
    document.getElementById('search_values').value = json;
}