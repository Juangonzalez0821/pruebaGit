function convertToCelsius() {
    const temperature = parseFloat(document.getElementById('temperatureInput').value);
    if (isNaN(temperature)) {
        document.getElementById('result').innerText = "Por favor, ingresa un número válido.";
        return;
    }
    const celsius = (temperature - 32) * (5 / 9);
    document.getElementById('result').innerText = `${temperature} °F es igual a ${celsius.toFixed(2)} °C`;
}

function convertToFahrenheit() {
    const temperature = parseFloat(document.getElementById('temperatureInput').value);
    if (isNaN(temperature)) {
        document.getElementById('result').innerText = "Por favor, ingresa un número válido.";
        return;
    }
    const fahrenheit = (temperature * (9 / 5)) + 32;
    document.getElementById('result').innerText = `${temperature} °C es igual a ${fahrenheit.toFixed(2)} °F`;
}
