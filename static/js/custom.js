document.addEventListener('DOMContentLoaded', (event) => {
    manageDarkMode();
    manageHyphenator();
    manageLightBox();
    manageKatex();
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
    Array.from(document.getElementsByClassName('title')).forEach(e => e.classList.add("donthyphenate"));
    Hyphenator.config({
    });
    Hyphenator.run();
}

function manageLightBox() {
    modal = document.createElement('div');
    modal.id = 'lightbox';
    modal.onclick = function () {
	modal.style.display = 'none';
	modal.innerHTML = '';
	document.body.classList.toggle('noscroll');
    };
    document.body.appendChild(modal);
    
    for (let img of document.getElementsByTagName('img'))
	img.onclick = function () {
	    modal.style.display = 'block';
	    modal.appendChild(img.cloneNode());
	    document.body.classList.toggle('noscroll');
	};
}

function manageKatex() {
    renderMathInElement(document.body);
}
