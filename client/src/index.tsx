window.onload = async function () {
    console.log('Client running...');
    try {
        await showData();
    }
    catch (e) {
        console.error(e);
    }
}

async function showData() {
    const root = document.getElementById('root');
    if (root) {
        root.innerHTML = await getData();
    } else {
        throw 'No root element';
    }
}

async function getData() {
    const result = await fetch('/api');
    return result.text();
}