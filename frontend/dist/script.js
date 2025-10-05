const API_URL = "http://localhost:8000/api/citas?limit=20";
const statusDiv = document.getElementById("status");
const table = document.getElementById("tabla-citas");
const tbody = document.getElementById("citas-body");

async function cargarCitas() {
  try {
    const resp = await fetch(API_URL);
    if (!resp.ok) throw new Error("Error HTTP " + resp.status);

    const citas = await resp.json();
    if (citas.length === 0) {
      statusDiv.textContent = "No hay citas disponibles.";
      return;
    }

    statusDiv.style.display = "none";
    table.classList.remove("hidden");

    citas.forEach(cita => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${cita.paciente_nombre} ${cita.paciente_apellidos}</td>
        <td>${new Date(cita.fecha_hora).toLocaleString()}</td>
        <td class="estado ${cita.estado}">${cita.estado}</td>
      `;
      tbody.appendChild(row);
    });
  } catch (err) {
    console.error(err);
    statusDiv.textContent = "❌ Error cargando citas. Revisa el backend.";
  }
}

cargarCitas();
