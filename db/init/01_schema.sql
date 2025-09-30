-- 01_schema.sql — Esquema mínimo + permisos
\set ON_ERROR_STOP on

-- Extensión para UUID v4
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Esquema lógico
CREATE SCHEMA IF NOT EXISTS clinic;
-- ALTER DATABASE CURRENT SET search_path = clinic, public;
-- SET search_path TO clinic, public;

-- ===== Tipos =====
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'estado_cita') THEN
    CREATE TYPE estado_cita AS ENUM ('programada', 'cancelada', 'realizada');
  END IF;
END $$;

-- ===== Tablas =====

-- PACIENTE: id, nombre, apellidos, created_at, updated_at
CREATE TABLE IF NOT EXISTS paciente (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre      VARCHAR(100) NOT NULL,
  apellidos   VARCHAR(150) NOT NULL,
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- CITA: id, paciente_id, fecha_hora, estado, created_at, updated_at
CREATE TABLE IF NOT EXISTS cita (
  id           UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  paciente_id  UUID         NOT NULL,
  fecha_hora   TIMESTAMPTZ  NOT NULL,     -- guarda en UTC
  estado       estado_cita  NOT NULL,
  created_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
  CONSTRAINT fk_cita_paciente
    FOREIGN KEY (paciente_id)
    REFERENCES paciente(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- ===== Índices =====
-- Búsqueda por fecha de citas (próximas/ordenadas)
CREATE INDEX IF NOT EXISTS ix_cita_fecha_hora ON cita (fecha_hora);
-- Citas por paciente ordenadas por fecha
CREATE INDEX IF NOT EXISTS ix_cita_paciente_fecha ON cita (paciente_id, fecha_hora);

-- ===== Trigger updated_at (para ambas tablas) =====
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

-- ===== Usuario de aplicación y permisos mínimos =====
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'appuser') THEN
    CREATE ROLE appuser LOGIN PASSWORD 'supersecret_dev';
  END IF;
END $$;

REVOKE ALL ON SCHEMA clinic FROM PUBLIC;
GRANT  USAGE ON SCHEMA clinic TO appuser;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA clinic TO appuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA clinic
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO appuser;

REVOKE CREATE ON SCHEMA clinic FROM appuser;

-- SELECT 'schema_ok' AS status;
