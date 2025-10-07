<h1 align="center">🏥 Gestión de Citas Médicas – TechSolutions S.A.</h1>

<p align="center">
  <em>Prototipo funcional de una aplicación web para la gestión de citas médicas en clínicas privadas.</em><br>
  Desarrollada y desplegada con <strong>Docker</strong> para garantizar portabilidad, escalabilidad y fácil mantenimiento.
</p>

---

## 🧱 Descripción General

La aplicación está compuesta por tres componentes principales:

- 🗄️ **Base de datos (PostgreSQL)**  
  Gestiona la información de pacientes y citas médicas de forma persistente y segura.

- ⚙️ **Backend (Flask + Python)**  
  Expone una API REST que permite consultar y procesar los datos de la aplicación.

- 💻 **Frontend (Nginx + HTML + JavaScript)**  
  Proporciona una interfaz web ligera y funcional para visualizar las citas médicas.

---

## ⚙️ Despliegue con Docker

El sistema está completamente **contenedorizado**.  
Todo el entorno (base de datos, backend y frontend) se levanta mediante **Docker Compose** con un único comando:

```bash
docker compose up -d
```
🌐 Accesos por defecto:

Frontend: http://localhost:8080

Backend (API): http://localhost:8000

Base de datos: Contenedor interno (PostgreSQL)

📊 Estado del Proyecto
<table align="center"> <tr><th>Componente</th><th>Estado</th><th>Descripción</th></tr> <tr><td>Base de datos</td><td>✅ Operativo</td><td>Esquema creado y datos iniciales cargados.</td></tr> <tr><td>Backend</td><td>✅ Funcionando</td><td>Comunica correctamente con la base de datos y expone endpoints API REST.</td></tr> <tr><td>Frontend</td><td>✅ Disponible</td><td>Consume la API y muestra las citas médicas en la interfaz web.</td></tr> </table> <h4 align="center">🚀 La infraestructura completa se despliega correctamente con un solo comando.</h4>
👨‍💻 Autores
<table align="center"> <tr> <td align="center"> <img src="https://cdn-icons-png.flaticon.com/512/2922/2922510.png" width="80" alt="TechSolutions logo"/><br> <strong>Equipo Técnico – Praisel.</strong><br> <em>Proyecto universitario: Laboratorio de Despliegue de Aplicaciones con Docker</em> </td> </tr> </table>

<details> <summary>📜 Mostrar licencia completa</summary>
Copyright (c) 2025 Praisel04.

Se concede permiso, de forma gratuita, a cualquier persona que obtenga una copia de este software 
y de los archivos de documentación asociados (el "Software"), para utilizar el Software sin restricción, 
incluyendo, sin limitación, los derechos a usar, copiar, modificar, fusionar, publicar, distribuir, 
sublicenciar y/o vender copias del Software, siempre que se mantenga este aviso de licencia 
y se reconozca la autoría original.

EL SOFTWARE SE PROPORCIONA “TAL CUAL”, SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA, 
INCLUYENDO PERO NO LIMITADA A GARANTÍAS DE COMERCIALIZACIÓN, APTITUD PARA UN PROPÓSITO PARTICULAR 
Y NO INFRACCIÓN. EN NINGÚN CASO LOS AUTORES SERÁN RESPONSABLES DE NINGUNA RECLAMACIÓN, 
DAÑO U OTRA RESPONSABILIDAD, YA SEA EN UNA ACCIÓN CONTRACTUAL, AGRAVIO O DE OTRO MODO, 
DERIVADA DE, FUERA DE O EN CONEXIÓN CON EL SOFTWARE O SU USO.

</details>


