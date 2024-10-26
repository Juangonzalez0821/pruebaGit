// 1e2e3afc42911974fd106fb4d810c29d


async function fetchGLIFData(){
    const output = document.getElementById("output");
    const errorMessage = document.getElementById("error-message");
    const userInput = document.getElementById("user-input").value;
    errorMessage.textContent = "";
    output.textContent="";

    const apiToken = '94ca6688b805eb1f7a6dee09ae59e5a6'
    const data = {
        id: "clgh1vxtu0011mo081dplq3xs",
        inputs: [userInput]
    };
    try {
        const response = await fetch('https://simple-api.glif.app',{
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${apiToken}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        if (!response.ok) {
            console.log("Error en la solicitud: "+ response.statusText)
        }
        else{
            const result = await response.json();
            displayResult(result);
        }
    } catch (error) {
        errorMessage.textContent = "No se pudieron cargar los datos"+ error.massage;
    }
}

function displayResult(result) {
    const output = document.getElementById("output");
    output.innerHTML=` 
        <h2>Resultado</h2>
        <p>${result.id}</p>
        <img src="${result.output}"/>
        <p>${JSON.stringify(result.inputs, null, 2)}</p>
    `;
}