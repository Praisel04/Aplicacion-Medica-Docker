const user_id = localStorage.getItem("user_id");
const API_URL = `http://localhost:8000/citas?user_id=${user_id}`;
const statusDiv = document.getElementById("status");
const table = document.getElementById("tabla-citas");
const tbody = document.getElementById("citas-body");
const formDiv = document.getElementById("formulario-cita");
const btnNuevaCita = document.getElementById("btn-nueva-cita");
const formCita = document.getElementById("form-nueva-cita");
const nombreUsuarioSpan = document.getElementById("nombre-usuario");

// Verificar si el usuario está logueado
if (!user_id) {
  alert("❌ Debes iniciar sesión para ver tus citas.");
  window.location.href = "./login.html";
}
// Mostrar nombre de usuario
nombreUsuarioSpan.textContent = localStorage.getItem("nombre");

// Mostrar formulario
btnNuevaCita.addEventListener("click", () => {
  formDiv.classList.toggle("d-none");
});

// Cargar citas del usuario
async function cargarCitas() {
  tbody.innerHTML = "";
  statusDiv.textContent = "Cargando citas...";
  table.classList.add("d-none");

  try {
    const resp = await fetch(API_URL);
    if (!resp.ok) throw new Error("Error HTTP " + resp.status);
    const citas = await resp.json();

    if (citas.length === 0) {
      statusDiv.textContent = "No hay citas registradas.";
      return;
    }

    statusDiv.classList.add("d-none");
    table.classList.remove("d-none");

    citas.forEach(cita => {
      const row = document.createElement("tr");
      row.innerHTML = `
          <td>${new Date(cita.fecha_hora).toLocaleString()}</td>
          <td class="estado ${cita.estado}">${cita.estado}</td>
          <td><button class="btn btn-sm btn-danger" onclick="eliminarCita('${cita.id}')">🗑️ Eliminar</button></td>
        `;
      tbody.appendChild(row);
    });
  } catch (err) {
    console.error(err);
    statusDiv.textContent = "❌ Error cargando citas. Revisa el backend.";
  }
}

// Crear nueva cita
formCita.addEventListener("submit", async (e) => {
  e.preventDefault();
  const fecha_hora = document.getElementById("fecha_hora").value;
  if (!fecha_hora) return alert("Debes seleccionar una fecha y hora.");

  try {
    const resp = await fetch("http://localhost:8000/citas", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ user_id, fecha_hora, estado: "programada" })
    });

    const data = await resp.json();
    if (resp.ok) {
      alert("✅ Cita creada correctamente");
      formDiv.classList.add("d-none");
      formCita.reset();
      cargarCitas();
    } else {
      alert("❌ " + (data.error || "Error al crear la cita"));
    }
  } catch (err) {
    console.error(err);
    alert("❌ Error de conexión con el servidor");
  }
});

// Eliminar cita
async function eliminarCita(id) {
  if (!confirm("¿Seguro que deseas eliminar esta cita?")) return;

  try {
    const resp = await fetch(`http://localhost:8000/citas/${id}?user_id=${user_id}`, {
      method: "DELETE"
    });
    const data = await resp.json();

    if (resp.ok) {
      alert("🗑️ Cita eliminada correctamente");
      cargarCitas();
    } else {
      alert("❌ " + (data.error || "No se pudo eliminar la cita"));
    }
  } catch (err) {
    console.error(err);
    alert("❌ Error eliminando la cita");
  }
}

// Cerrar sesión
document.getElementById("btn-salir").addEventListener("click", () => {
  localStorage.clear();
  window.location.href = "./login.html";
});


cargarCitas();