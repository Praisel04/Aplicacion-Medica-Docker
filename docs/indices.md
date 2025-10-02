# Índices planificados

- Paciente(id) PK → Identificación única
- Paciente(email) UNIQUE → Búsqueda por email
- Paciente(dni) UNIQUE [si se usa]

- Cita(id) PK
- Cita(fecha_hora) INDEX → Próximas citas ordenadas por fecha
- Cita(paciente_id, fecha_hora) INDEX → Citas de un paciente por fecha

# Consultas objetivo
1) Próximas 10 citas ordenadas por fecha
2) Citas de un paciente por id
3) Conteo de citas por estado en último mes
4) Búsqueda paciente por DNI o email
5) Evitar duplicados de DNI
