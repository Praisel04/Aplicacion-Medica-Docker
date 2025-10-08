# Modelo de datos (MVP)

## Paciente (Eliminada 08/10/2025. Motivo: Fallo en la conexion de user_id en el backend. Se elimina ya que realmente no es util.)
- id: UUID
- nombre: string (<= 100)
- apellidos: string (<= 150)
- created_at: datetime (UTC)
- updated_at: datetime (UTC)

## Cita
- id: UUID
- paciente_id: UUID (FK → Paciente.id)
- fecha_hora: datetime (UTC)
- estado: enum/check {programada, cancelada, realizada}
- notas: text (opcional)
- created_at: datetime (UTC)
- updated_at: datetime (UTC)

## Reglas
- dni único (si se usa)
- email único (o índice)
- paciente_id obligatorio
- estado limitado a los valores válidos

## Usuario
| Campo           | Tipo                | Descripción                                 |
| --------------- | ------------------- | ------------------------------------------- |
| `id`            | UUID (PK)           | Identificador único del usuario             |
| `nombre`        | VARCHAR(100)        | Nombre completo                             |
| `email`         | VARCHAR(255) UNIQUE | Correo electrónico (identificador de login) |
| `password_hash` | TEXT                | Contraseña cifrada                          |
| `created_at`    | TIMESTAMP           | Fecha de registro                           |
| `updated_at`    | TIMESTAMP           | Última modificación                         |

