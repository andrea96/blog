document.addEventListener('DOMContentLoaded', (event) => {
    manageDarkMode();
})

function manageDarkMode() {
    const darkmode = new Darkmode({
	time: '0s',
    });
    let toggle = document.getElementById('toggle-darkmode');
    console.log(darkmode);
    toggle.innerHTML = darkmode.isActivated() ? "Disable" : "Enable";
    toggle.onclick = function () {
	darkmode.toggle();
	toggle.innerHTML = darkmode.isActivated() ? "Disable" : "Enable";
    };
}
