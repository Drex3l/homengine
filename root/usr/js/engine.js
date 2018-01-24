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
        case 'Apartment':
        case 'House':
            document.getElementById('beds').style.display = "block";
            document.getElementById('baths').style.display = "block";
            break;
        case 'Room':
            document.getElementById('room-setting').style.display = "block";
            break;
    }
    getValue(type);
}
function getValue(item){
    document.getElementById(item.name).value = item.value;  //------------------Take value from control and assign to its respective hidden field for AJAX
}
function getValues(name){
    var item = document.getElementsByName(name);
    var string = "";
    for(k=0;k<item.length;k++) if(item[k].checked) string += item[k].value +", ";
    
    var id = name.substr(0,name.length-2);
    document.getElementById(id).value = string;
}