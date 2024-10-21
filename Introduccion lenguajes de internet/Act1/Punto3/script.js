function cambiarImagen() {
    const imagen = document.getElementById('imagen');
    
    // Verificamos la imagen actual y cambiamos a otra imagen
    if (imagen.src.includes("imagen1.jpg")) {
        imagen.src = "imagen2.jpg"; // Cambia a la segunda imagen
    } else {
        imagen.src = "imagen1.jpg"; // Vuelve a la primera imagen
    }
}
