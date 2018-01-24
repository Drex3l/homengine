function building(type){
    var item = document.getElementsByClassName("subset");
    for(k=0;k<item.length;k++) item[k].style.display = "none";
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
}