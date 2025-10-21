# Modelo de datos (MVP)

## Paciente
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
