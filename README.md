<h1 align="center">🏥 Gestión de Citas Médicas – TechSolutions S.A.</h1>

<p align="center">
  <em>Prototipo funcional de una aplicación web para la gestión de citas médicas en clínicas privadas.</em><br>
  Desarrollada y desplegada con <strong>Docker</strong> para garantizar portabilidad, escalabilidad y fácil mantenimiento.
</p>

---

## 🧱 Descripción General

La aplicación está compuesta por tres componentes principales:

- 🗄️ **Base de datos (PostgreSQL)**  
  Gestiona la información de usuarios y citas médicas de forma persistente y segura.

- ⚙️ **Backend (Flask + Python)**  
  Expone una API RESTful que permite registrar usuarios, autenticar sesiones y gestionar las citas de cada paciente de manera aislada y segura.

- 💻 **Frontend (Nginx + HTML + JavaScript)**  
  Proporciona una interfaz web moderna y ligera que permite a los usuarios interactuar con la API, visualizar sus citas, crear nuevas y eliminarlas.

---

## 🚀 Funcionalidades Actuales

### 👤 **Gestión de Usuarios**
- **Registro de usuario:** permite crear una cuenta mediante nombre, correo y contraseña.  
- **Cifrado de contraseñas:** las contraseñas se almacenan usando hashes seguros con `Werkzeug.security`.  
- **Prevención de duplicados:** el sistema impide registrar dos usuarios con el mismo correo electrónico.  
- **Inicio de sesión:** valida credenciales y devuelve el `user_id` y el nombre del usuario.  
- **Sesión persistente:** los datos del usuario (nombre y `user_id`) se almacenan en `localStorage`, lo que permite mantener la sesión activa en el navegador.  

### 📅 **Gestión de Citas**
- **Creación de citas:** los usuarios pueden registrar una cita médica indicando fecha y hora.  
- **Visualización personal:** cada usuario solo ve las citas que él mismo ha creado.  
- **Eliminación de citas:** se pueden cancelar o eliminar las citas desde la interfaz web.  
- **Validación de acceso:** las operaciones están protegidas y requieren que el usuario haya iniciado sesión.  

### 🔐 **Autenticación y Seguridad**
- Contraseñas cifradas mediante `generate_password_hash()` y `check_password_hash()`.
- Validaciones robustas en el backend para evitar inserciones inválidas o no autorizadas.
- Comunicación cliente-servidor en formato JSON para una API limpia y escalable.
- Preparado para incluir autenticación por roles (por ejemplo, **médico** o **administrador**), permitiendo editar o consultar todas las citas.

---

## ⚙️ Despliegue con Docker

El sistema está completamente **contenedorizado**.  
Todo el entorno (base de datos, backend y frontend) se levanta mediante **Docker Compose** con un único comando:

```bash
docker compose up -d
```

## 🌐 Accesos por defecto:
	•	Frontend: http://localhost:8080
	•	Backend (API): http://localhost:8000
	•	Base de datos: contenedor interno (PostgreSQL)

📂 Estructura del Proyecto
```
.
├── backend/
│   ├── app.py                # API REST principal
│   ├── requirements.txt      # Dependencias de Python
│   └── sql/
│       └── 01_schema.sql     # Esquema de la base de datos
│
├── frontend/
│   ├── Dockerfile            # Imagen de Nginx personalizada
│   ├── templates/            # Archivos HTML
│   │   ├── index.html
│   │   ├── login.html
│   │   └── register.html
│   └── static/               # Archivos estáticos
│       ├── css/style.css
│       └── js/
│           ├── main.js
│           ├── login.js
│           └── register.js
│
└── docker-compose.yml        # Orquestación de servicios
```

## 🧩 Endpoints Principales de la API

## 📊 Estado del Proyecto
<table align="center">
<tr><th>Componente</th><th>Estado</th><th>Descripción</th></tr>
<tr><td>Base de datos</td><td>✅ Operativo</td><td>Esquema actualizado (usuario + cita). Índices y triggers configurados.</td></tr>
<tr><td>Backend</td><td>✅ Funcional</td><td>Endpoints activos, gestión de usuarios y citas completamente funcional.</td></tr>
<tr><td>Frontend</td><td>✅ Integrado</td><td>Comunicación con API estable. Interfaz con almacenamiento local de sesión.</td></tr>
</table>
<h4 align="center">🚀 La infraestructura completa se despliega correctamente con un solo comando.</h4>

## 🧠 Próximas Mejoras Planificadas
	•	👨‍⚕️ Rol Médico: añadir permisos especiales para visualizar y editar todas las citas.
  • 🖥️ Auditorias: Añadir tablas de auditoria para mantener una seguridad avanzada en la APP.

## 👨‍💻 Autores
<table align="center">
<tr>
  <td align="center">
    <img src="https://cdn-icons-png.flaticon.com/512/2922/2922510.png" width="80" alt="TechSolutions logo"/><br>
    <strong>Equipo Técnico – Praisel</strong><br>
    <em>Proyecto universitario: Laboratorio de Despliegue de Aplicaciones con Docker</em>
  </td>
</tr>
</table>

<details>
<summary>📜 Mostrar licencia completa</summary>
Copyright (c) 2025 Praisel04

Se concede permiso, de forma gratuita, a cualquier persona que obtenga una copia de este software
y de los archivos de documentación asociados (el “Software”), para utilizar el Software sin restricción,
incluyendo, sin limitación, los derechos a usar, copiar, modificar, fusionar, publicar, distribuir,
sublicenciar y/o vender copias del Software, siempre que se mantenga este aviso de licencia
y se reconozca la autoría original.

EL SOFTWARE SE PROPORCIONA “TAL CUAL”, SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA,
INCLUYENDO PERO NO LIMITADA A GARANTÍAS DE COMERCIALIZACIÓN, APTITUD PARA UN PROPÓSITO PARTICULAR
Y NO INFRACCIÓN. EN NINGÚN CASO LOS AUTORES SERÁN RESPONSABLES DE NINGUNA RECLAMACIÓN,
DAÑO U OTRA RESPONSABILIDAD, YA SEA EN UNA ACCIÓN CONTRACTUAL, AGRAVIO O DE OTRO MODO,
DERIVADA DE, FUERA DE O EN CONEXIÓN CON EL SOFTWARE O SU USO.
</details>
```






