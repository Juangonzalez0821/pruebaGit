// Obtener los elementos del DOM
const agregarBtn = document.getElementById("agregarBtn");
const listaTareas = document.getElementById("listaTareas");
const nuevaTareaInput = document.getElementById("nuevaTarea");

// Función para agregar una nueva tarea
function agregarTarea() {
    const tareaTexto = nuevaTareaInput.value;

    if (tareaTexto === "") {
        alert("Por favor, escribe una tarea.");
        return;
    }

    // Crear un nuevo elemento <li> para la tarea
    const nuevaTarea = document.createElement("li");
    nuevaTarea.classList.add("list-group-item");
    nuevaTarea.textContent = tareaTexto;

    // Crear el botón de eliminar para cada tarea
    const eliminarBtn = document.createElement("button");
    eliminarBtn.textContent = "Eliminar";
    eliminarBtn.classList.add("delete-btn", "btn", "btn-sm");

    // Añadir evento al botón de eliminar
    eliminarBtn.onclick = function() {
        listaTareas.removeChild(nuevaTarea);
    };

    // Añadir el botón a la tarea
    nuevaTarea.appendChild(eliminarBtn);

    // Añadir la nueva tarea a la lista de tareas
    listaTareas.appendChild(nuevaTarea);

    // Limpiar el campo de entrada
    nuevaTareaInput.value = "";
}

// Añadir evento al botón de agregar tarea
agregarBtn.onclick = agregarTarea;
