import os
import psycopg
from flask import Flask, jsonify, request
from flask_cors import CORS

# === Config desde variables de entorno ===
DB_HOST = os.getenv("DB_HOST", "db")
DB_PORT = int(os.getenv("DB_PORT", "5432"))
DB_NAME = os.getenv("DB_NAME", "appdb")
DB_USER = os.getenv("DB_USER", "appuser")
DB_PASSWORD = os.getenv("DB_PASSWORD", "supersecret_dev")

def get_conn():
    # Conexión simple por petición (suficiente para MVP)
    """
    Devuelve una conexión a la base de datos.
    
    La conexión se establece con los valores de configuración
    establecidos en las variables de entorno DB_HOST, DB_PORT,
    DB_NAME, DB_USER y DB_PASSWORD.
    
    La conexión se establece con autocommit=True, lo que significa
    que los cambios se confirmarán automáticamente.
    
    :return: Una conexión a la base de datos.
    :rtype: psycopg2.extensions.connection
    """
    return psycopg.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        autocommit=True,
    )

app = Flask(__name__)
CORS(app)  # permite consumir desde tu frontend

@app.get("/api/health")
def health():
    """
    Indica el estado de la aplicación y la conexión a la base de datos.
    
    El estado de la aplicación se indica con el campo "status" y puede tener
    los valores "ok" o "degraded".
    
    La conexión a la base de datos se indica con el campo "db" y puede tener
    los valores "up" o "down". En caso de que el estado sea "degraded", se
    incluye adicionalmente el campo "error" con la descripción del error.
    
    :return: Un objeto JSON con el estado de la aplicación y la conexión a la base de datos.
    :rtype: flask.Response
    """
    try:
        with get_conn() as conn, conn.cursor() as cur:
            cur.execute("SELECT 1;")
            cur.fetchone()
        return jsonify({"status": "ok", "db": "up"}), 200
    except Exception as e:
        return jsonify({"status": "degraded", "db": "down", "error": str(e)}), 503

@app.get("/api/citas")
def listar_citas():
    # opcional: ?limit=50
    """
    Devuelve una lista de citas con sus respectivos pacientes.
    
    La lista se devuelve en formato JSON y contiene los siguientes campos:
    
    - id: El identificador de la cita.
    - paciente_id: El identificador del paciente.
    - fecha_hora: La fecha y hora de la cita.
    - estado: El estado de la cita.
    - created_at: La fecha y hora en la que se creó la cita.
    - updated_at: La fecha y hora en la que se actualizó la cita.
    - paciente_nombre: El nombre del paciente.
    - paciente_apellidos: Los apellidos del paciente.
    
    Se puede especificar el límite de cantidad de resultados a devolver
    mediante el parámetro "limit". Este parámetro debe ser un entero
    entre 1 y 500. Si no se especifica, se devuelve un límite de 100.
    
    :return: Un objeto JSON con la lista de citas.
    :rtype: flask.Response
    """
    try:
        limit = int(request.args.get("limit", 100))
        limit = max(1, min(limit, 500))
    except ValueError:
        limit = 100

    sql = """
    SELECT
      c.id, c.paciente_id, c.fecha_hora, c.estado, c.created_at, c.updated_at,
      p.nombre, p.apellidos
    FROM clinic.cita c
    JOIN clinic.paciente p ON p.id = c.paciente_id
    ORDER BY c.fecha_hora ASC
    LIMIT %s;
    """
    data = []
    with get_conn() as conn, conn.cursor() as cur:
        cur.execute(sql, (limit,))
        for (cid, pid, fh, estado, c_at, u_at, nombre, apellidos) in cur.fetchall():
            data.append({
                "id": str(cid),
                "paciente_id": str(pid),
                "fecha_hora": fh.isoformat(),
                "estado": estado,
                "created_at": c_at.isoformat(),
                "updated_at": u_at.isoformat(),
                "paciente_nombre": nombre,
                "paciente_apellidos": apellidos,
            })
    return jsonify(data), 200

if __name__ == "__main__":
    # para ejecutar sin Gunicorn (desarrollo local opcional)
    app.run(host="0.0.0.0", port=8000)