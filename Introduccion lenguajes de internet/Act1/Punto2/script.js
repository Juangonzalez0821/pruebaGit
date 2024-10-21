document.getElementById('enviarBtn').addEventListener('click', function() {
    const nombre = document.getElementById('nombre').value;
    const email = document.getElementById('email').value;
    
    if (nombre && email) {
        document.getElementById('mensaje').innerText = `¡Gracias ${nombre}! Tu email ${email} ha sido enviado.`;
    } else {
        document.getElementById('mensaje').innerText = 'Por favor, completa todos los campos.';
    }
});
