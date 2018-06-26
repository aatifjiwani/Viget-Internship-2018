function appearLeft(evt, name) {
    //console.log("hello");
    containers = document.getElementsByClassName("container");
    for (i = 0; i < containers.length; i++) {
        containers[i].style.display = "none";
    }
    
    tabs = document.getElementsByClassName("tab");
    for (i = 0; i < tabs.length; i++) {
        tabs[i].className = tabs[i].className.replace(" current", "");
    }
    document.getElementById(name).style.display = "block";
    evt.currentTarget.className += " current";
}