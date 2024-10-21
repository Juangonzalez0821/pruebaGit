// Genera un número aleatorio entre 1 y 100
const numeroAleatorio = Math.floor(Math.random() * 100) + 1;

function adivinarNumero() {
    const adivinanza = parseInt(document.getElementById('adivinanza').value);
    const mensaje = document.getElementById('mensaje');

    if (isNaN(adivinanza) || adivinanza < 1 || adivinanza > 100) {
        mensaje.innerText = 'Por favor, ingresa un número válido entre 1 y 100.';
        return;
    }

    if (adivinanza < numeroAleatorio) {
        mensaje.innerText = 'Demasiado bajo. Intenta de nuevo.';
    } else if (adivinanza > numeroAleatorio) {
        mensaje.innerText = 'Demasiado alto. Intenta de nuevo.';
    } else {
        mensaje.innerText = `¡Correcto! El número era ${numeroAleatorio}.`;
    }
}