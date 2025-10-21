<<<<<<< HEAD
-- 01_schema.sql simplificado

\set ON_ERROR_STOP on
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Tipo enum de estado
=======
\set ON_ERROR_STOP on

-- Extensión UUID
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ===== Tipos =====
>>>>>>> feature/frontend
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'estado_cita') THEN
    CREATE TYPE estado_cita AS ENUM ('programada', 'cancelada', 'realizada');
  END IF;
END $$;

<<<<<<< HEAD
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
=======
-- ===== TABLAS =====

-- USUARIO
CREATE TABLE IF NOT EXISTS usuario (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  rol VARCHAR(50),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
  
);

-- CITA
CREATE TABLE IF NOT EXISTS cita (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  nombre_cita VARCHAR(255) NOT NULL,
  fecha_hora TIMESTAMPTZ NOT NULL,
  estado estado_cita NOT NULL DEFAULT 'programada',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- ===== ÍNDICES =====
CREATE INDEX IF NOT EXISTS ix_cita_usuario_fecha ON cita (usuario_id, fecha_hora);
CREATE INDEX IF NOT EXISTS ix_cita_estado ON cita (estado);

-- ===== TRIGGERS updated_at =====
>>>>>>> feature/frontend
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_usuario_updated_at') THEN
    CREATE TRIGGER trg_usuario_updated_at
    BEFORE UPDATE ON usuario
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_cita_updated_at') THEN
    CREATE TRIGGER trg_cita_updated_at
    BEFORE UPDATE ON cita
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
  END IF;
END $$;

<<<<<<< HEAD
-- Usuario appuser (si no existe)
=======
-- ===== USUARIO DE APLICACIÓN =====
>>>>>>> feature/frontend
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'appuser') THEN
    CREATE ROLE appuser LOGIN PASSWORD 'supersecret_dev';
  END IF;
END $$;

<<<<<<< HEAD
-- Permisos mínimos en public
=======
>>>>>>> feature/frontend
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO appuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO appuser;
