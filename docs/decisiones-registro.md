# 🧩 Sistema de Registro e Inicio de Sesión – Diseño y Justificación

## 🎯 Objetivo general

El objetivo es implementar un sistema de **autenticación de usuarios** para la aplicación de citas médicas.  
Este sistema permitirá que cada usuario se **registre**, **inicie sesión** y posteriormente **gestione sus citas médicas** de forma segura.

---

## ⚙️ Endpoints principales

| Endpoint | Método | Descripción | Razón técnica |
|-----------|---------|--------------|----------------|
| `/register` | `POST` | Crea un nuevo usuario con nombre, email y contraseña cifrada | Se usa `POST` porque estamos creando un recurso nuevo (el usuario) |
| `/login` | `POST` | Verifica las credenciales del usuario | El login requiere enviar datos sensibles, por lo que también se usa `POST` |
| `/logout` *(opcional)* | `POST` | Finaliza la sesión o invalida el token | Se implementará más adelante si se usa autenticación basada en sesiones o JWT |

---

## 🧱 Diseño de los endpoints

### 🧩 `/register` (Registro)

**Objetivo:**  
Permitir que un nuevo usuario se registre en la base de datos.

**Entrada (JSON):**
```json
{
  "nombre": "Iván",
  "email": "ivan@example.com",
  "password": "micontraseña123"
}
Proceso interno:

Verificar si ya existe un usuario con el mismo correo.

Si no existe, cifrar la contraseña usando generate_password_hash().

Insertar los datos en la tabla usuario.

Devolver un mensaje de éxito junto con el id generado.

Salida esperada:

{
  "message": "Usuario registrado correctamente",
  "user_id": "uuid-generado"
}

🧩 /login (Inicio de sesión)

Objetivo:
Permitir que un usuario existente acceda mediante su correo y contraseña.

Entrada (JSON):

{
  "email": "ivan@example.com",
  "password": "micontraseña123"
}


Proceso interno:

Buscar al usuario por su correo electrónico.

Validar la contraseña mediante check_password_hash().

Si es correcta, devolver confirmación (más adelante un token o sesión).

En caso contrario, devolver error 401.

Salida esperada (si es correcto):

{
  "message": "Inicio de sesión correcto",
  "user_id": "uuid-del-usuario"
}

🛠️ Tecnologías utilizadas
Tecnología	Descripción
Flask	Framework web principal del backend
psycopg2 / SQLAlchemy	Conexión con PostgreSQL
Werkzeug.security	Cifrado y verificación segura de contraseñas
JSON (REST API)	Formato estándar de comunicación entre frontend y backend
🔒 Buenas prácticas de seguridad

Nunca guardar contraseñas en texto plano, solo hashes seguros.

Verificar duplicados de email antes de registrar nuevos usuarios.

Usar códigos HTTP adecuados:

201 Created → usuario creado

400 Bad Request → datos incompletos o inválidos

401 Unauthorized → credenciales incorrectas

Respuestas siempre en formato JSON, claras y coherentes.

Sanear la entrada del usuario antes de insertarla en la base de datos.

🚀 Flujo de implementación

Implementar y probar el endpoint /register.

Verificar inserción de usuarios en la tabla usuario.

Implementar /login para comprobar credenciales.

Conectar el frontend (script.js) con ambos endpoints.

Añadir validaciones y mensajes visuales en la interfaz.

📄 Estado actual del proyecto:
✔️ Base de datos configurada
✔️ Tabla usuario creada
🚧 Siguiente paso: Implementar el endpoint /register en Flask