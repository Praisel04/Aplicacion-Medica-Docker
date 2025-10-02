-- 01_schema.sql simplificado

\set ON_ERROR_STOP on
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Tipo enum de estado
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'estado_cita') THEN
    CREATE TYPE estado_cita AS ENUM ('programada', 'cancelada', 'realizada');
  END IF;
END $$;

-- Tabla paciente
CREATE TABLE IF NOT EXISTS paciente (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(100) NOT NULL,
  apellidos VARCHAR(150) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Tabla cita
CREATE TABLE IF NOT EXISTS cita (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  paciente_id UUID NOT NULL REFERENCES paciente(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  fecha_hora TIMESTAMPTZ NOT NULL,
  estado estado_cita NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS ix_cita_fecha_hora ON cita (fecha_hora);
CREATE INDEX IF NOT EXISTS ix_cita_paciente_fecha ON cita (paciente_id, fecha_hora);

-- Trigger updated_at
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_paciente_updated_at') THEN
    CREATE TRIGGER trg_paciente_updated_at
    BEFORE UPDATE ON paciente
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_cita_updated_at') THEN
    CREATE TRIGGER trg_cita_updated_at
    BEFORE UPDATE ON cita
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END $$;

-- Usuario appuser (si no existe)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'appuser') THEN
    CREATE ROLE appuser LOGIN PASSWORD 'supersecret_dev';
  END IF;
END $$;

-- Permisos mínimos en public
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO appuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO appuser;
