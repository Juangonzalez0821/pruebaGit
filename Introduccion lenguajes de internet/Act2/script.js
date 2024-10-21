// 1. Array de estudiantes
const estudiantes = [
    { nombre: "Juan", edad: 20, notaFinal: 85, estado: true },
    { nombre: "María", edad: 22, notaFinal: 55, estado: false },
    { nombre: "Pedro", edad: 21, notaFinal: 70, estado: true },
    { nombre: "Lucía", edad: 19, notaFinal: 90, estado: true },
    { nombre: "Carlos", edad: 23, notaFinal: 45, estado: false }
];

// 2. Función para filtrar estudiantes aprobados
function mostrarAprobados() {
    const aprobados = estudiantes.filter(est => est.notaFinal >= 60);
    const aprobadosDiv = document.getElementById('aprobados');
    aprobadosDiv.innerHTML = "<h2 class='neon-text'>Estudiantes Aprobados:</h2>";
    aprobados.forEach(est => {
        aprobadosDiv.innerHTML += `<p>${est.nombre} (Nota: ${est.notaFinal})</p>`;
    });
}

// 3. Función para mostrar nombres en mayúsculas
function mostrarNombres() {
    const nombres = estudiantes.map(est => est.nombre.toUpperCase());
    const nombresDiv = document.getElementById('nombres');
    nombresDiv.innerHTML = "<h2 class='neon-text'>Nombres de Estudiantes:</h2>";
    nombres.forEach(nombre => {
        nombresDiv.innerHTML += `<p>${nombre}</p>`;
    });
}

// 4. Función para calcular el promedio de notas
function mostrarPromedio() {
    const totalNotas = estudiantes.reduce((acc, est) => acc + est.notaFinal, 0);
    const promedio = totalNotas / estudiantes.length;
    const promedioDiv = document.getElementById('promedio');
    promedioDiv.innerHTML = `<h2 class='neon-text'>Promedio de Notas: ${promedio.toFixed(2)}</h2>`;
}

// 5. Función para contar aprobados y reprobados
function contarAprobadosYReprobados() {
    const contador = estudiantes.reduce((acc, est) => {
        if (est.estado) {
            acc.aprobados++;
        } else {
            acc.reprobados++;
        }
        return acc;
    }, { aprobados: 0, reprobados: 0 });

    const contadorDiv = document.getElementById('contador');
    contadorDiv.innerHTML = `<h2 class='neon-text'>Aprobados: ${contador.aprobados}, Reprobados: ${contador.reprobados}</h2>`;
}

// Llamar a las funciones
mostrarAprobados();
mostrarNombres();
mostrarPromedio();
contarAprobadosYReprobados();
