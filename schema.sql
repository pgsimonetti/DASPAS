CREATE TABLE IF NOT EXISTS usuarios (
 id SERIAL PRIMARY KEY,
 nombre VARCHAR(120) NOT NULL,
 email VARCHAR(160) UNIQUE NOT NULL,
 password_hash TEXT NOT NULL,
 rol VARCHAR(30) NOT NULL DEFAULT 'operador',
 activo BOOLEAN NOT NULL DEFAULT TRUE,
 creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS clientes (
 id SERIAL PRIMARY KEY,
 nro_afiliado VARCHAR(60) UNIQUE NOT NULL,
 sindicato VARCHAR(120) NOT NULL,
 categoria VARCHAR(20) NOT NULL CHECK (categoria IN ('Activo','Jubilado','Individual')),
 apellido VARCHAR(100) NOT NULL,
 nombre VARCHAR(100) NOT NULL,
 documento VARCHAR(50), direccion VARCHAR(255), localidad VARCHAR(100), cod_postal VARCHAR(20), provincia VARCHAR(100), telefono VARCHAR(50), correo_electronico VARCHAR(160), notas TEXT,
 creado_por INT REFERENCES usuarios(id), creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(), actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_clientes_apellido ON clientes(apellido);
CREATE INDEX IF NOT EXISTS idx_clientes_documento ON clientes(documento);
CREATE TABLE IF NOT EXISTS documentos (
 id SERIAL PRIMARY KEY, cliente_id INT NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
 nombre VARCHAR(255) NOT NULL, ruta TEXT NOT NULL, tipo VARCHAR(100), tamano BIGINT, usuario_id INT REFERENCES usuarios(id), creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS historial (
 id SERIAL PRIMARY KEY, cliente_id INT REFERENCES clientes(id) ON DELETE CASCADE,
 usuario_id INT REFERENCES usuarios(id), accion VARCHAR(80) NOT NULL, detalle TEXT, creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS importaciones (
 id SERIAL PRIMARY KEY, usuario_id INT REFERENCES usuarios(id), archivo VARCHAR(255), total INT DEFAULT 0, nuevos INT DEFAULT 0, actualizados INT DEFAULT 0, errores INT DEFAULT 0, creado_en TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
