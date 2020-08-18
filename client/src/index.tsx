window.onload = async function () {
    console.log('test');
    const root = document.getElementById('root');
    if (root) {
        const data = await (await fetch('/api')).text();
        root.innerHTML = data;
    }
}