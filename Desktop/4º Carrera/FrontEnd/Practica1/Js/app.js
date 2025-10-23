// ====== Declaración de variables ======
const form = document.querySelector("form");
const passwordInput = document.querySelector("#password"); 

// Creamos dinámicamente un mensaje de ayuda debajo del campo contraseña
const msg = document.createElement("div");
msg.classList.add("form-text");
msg.id = "passwordHelp";
passwordInput.after(msg);

// ====== Función de validación ======
const validarPassword = (password) => {
  // Expresión regular: 8+ caracteres, 1 mayúscula, 1 número y 1 carácter especial
  const regex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&.-:;_¨`+?¿/%]).{8,}$/;
  return regex.test(password);
};

// ====== Evento: input (cada vez que el usuario escribe) ======
passwordInput.addEventListener("input", (event) => {
  const valor = event.target.value;

  if (validarPassword(valor)) {
    msg.textContent = "✅ Contraseña segura";
    msg.style.color = "green";
  } else {
    msg.textContent =
      "⚠️ La contraseña debe tener al menos 8 caracteres, una mayúscula, un número y un símbolo.";
    msg.style.color = "red";
  }
});

// ====== Evento: submit ======
form.addEventListener("submit", (event) => {
  const password = passwordInput.value;

  if (!validarPassword(password)) {
    event.preventDefault(); // Evita el envío del formulario
    msg.textContent = "❌ Corrige la contraseña antes de continuar.";
    msg.style.color = "red";
  } else {
    alert("Registro completado correctamente ✅");
  }
});

// ====== Toggle Mostrar/Ocultar Contraseña ======
const toggleBtn = document.querySelector("#togglePass");
const passwordField = document.querySelector("#password");

toggleBtn.addEventListener("click", () => {
  const isHidden = passwordField.type === "password";
  passwordField.type = isHidden ? "text" : "password";

  // Cambiamos icono mediante classList.toggle()
  toggleBtn.classList.toggle("eye-open", isHidden);
  toggleBtn.classList.toggle("eye-closed", !isHidden);

  // Actualizamos accesibilidad
  toggleBtn.setAttribute(
    "aria-label",
    isHidden ? "Ocultar contraseña" : "Mostrar contraseña"
  );
});

