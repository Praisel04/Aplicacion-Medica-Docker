\set ON_ERROR_STOP on

INSERT INTO paciente (id, nombre, apellidos)
VALUES
  (gen_random_uuid(), 'Ana', 'García López'),
  (gen_random_uuid(), 'Luis', 'Pérez Martín'),
  (gen_random_uuid(), 'Marta', 'Santos Ruiz')
ON CONFLICT DO NOTHING;

WITH p AS (
  SELECT id FROM paciente ORDER BY created_at ASC LIMIT 3
)
INSERT INTO cita (id, paciente_id, fecha_hora, estado)
SELECT gen_random_uuid(), p.id, t.fecha_hora, t.estado
FROM p
JOIN (
  VALUES
    (now() - INTERVAL '10 days', 'realizada'::estado_cita),
    (now() + INTERVAL '1 day', 'programada'::estado_cita),
    (now() + INTERVAL '7 days', 'programada'::estado_cita),
    (now() - INTERVAL '2 days', 'cancelada'::estado_cita),
    (now() + INTERVAL '30 days', 'programada'::estado_cita)
) AS t(fecha_hora, estado) ON TRUE
ON CONFLICT DO NOTHING;
