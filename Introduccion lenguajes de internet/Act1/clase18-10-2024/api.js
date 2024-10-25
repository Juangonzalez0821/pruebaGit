const resultados = document.getElementById("resultados");

function mostrarPlanetas(planetas){
    resultados.innerHTML='';


    planetas.forEach(planeta=>{
        const planetaElemento = document.createElement('div');
        planetaElemento.innerHTML=`
            <h2>${planeta.name}</h2>
            <p>${planeta.description}</p>
            <img src="${planeta.image}" style="width: 200px" />
        `;
        resultados.appendChild(planetaElemento)
    });
}

async function ObtenerPlanetas() {
    try {
        const respuesta = await fetch('https://dragonball-api.com/api/planets');
        if (!respuesta.ok) {
            console.log("hubo un error al cargar los planetas")
        }else{
            const data = await respuesta.json();
            const planetas = data.items;
            if (Array.isArray(planetas)) {
                mostrarPlanetas(planetas);
                               
            }else{
                console.log("no se encontraron planetas");
                resultados.textContent = "la api no tiene el formato correcto"
            }
        }
        
        } catch (error) {
            console.error("Error: ",error)
            resultados.textContent="hubo un error al obtener los planetas"
    }
}