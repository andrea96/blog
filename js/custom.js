document.addEventListener('DOMContentLoaded', (event) => {
    manageDarkMode();
    manageHyphenator();
})

function manageDarkMode() {
    let toggle = document.getElementById('toggle-darkmode');
    let body = document.body;
    
    function changeStyle() {
	localStorage.darkmode = localStorage.darkmode == "true" ? false : true;
	toggle.innerHTML = localStorage.darkmode == "true" ? "Dark mode" : "Light mode";
	if (localStorage.darkmode == "true")
	    body.classList.add('darkmode');
	else
	    body.classList.remove('darkmode');
    };

    toggle.innerHTML = localStorage.darkmode == "true" ? "Dark mode" : "Light mode";
    if (localStorage.darkmode == "true")
	body.classList.add('darkmode');
    else
	body.classList.remove('darkmode');

    toggle.onclick = changeStyle;
}

function manageHyphenator() {
    document.getElementById('content').classList.add('hyphenate');
    document.getElementsByClassName('title').classList.add('donthyphenate');
    Hyphenator.config({
    });
    Hyphenator.run();
}
