SELECT current_database();

-- 1. Tabla socios (no depende de ninguna otra)
CREATE TABLE socios (
    id_socio  SERIAL PRIMARY KEY,
    documento VARCHAR(20) NOT NULL UNIQUE,
    nombre    VARCHAR(100) NOT NULL,
    telefono  VARCHAR(20) NOT NULL,
    correo    VARCHAR(100) UNIQUE -- Permite NULL porque en la Parte E se pide al menos un socio sin correo
);

-- 2. Tabla planes (no depende de ninguna otra)
CREATE TABLE planes (
    id_plan        SERIAL PRIMARY KEY,
    nombre         VARCHAR(50) NOT NULL,
    duracion_meses INTEGER NOT NULL CHECK (duracion_meses > 0),
    precio         NUMERIC(10, 2) NOT NULL CHECK (precio > 0)
);

-- 3. Tabla entrenadores (no depende de ninguna otra)
CREATE TABLE entrenadores (
    id_entrenador SERIAL PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    especialidad  VARCHAR(80) NOT NULL,
    correo        VARCHAR(100) NOT NULL UNIQUE
);

-- 4. Tabla fichas_medicas (depende de socios - Relación 1:1)
CREATE TABLE fichas_medicas (
    id_ficha_medica SERIAL PRIMARY KEY,
    peso            NUMERIC(5, 2) NOT NULL CHECK (peso > 0),
    estatura        NUMERIC(3, 2) NOT NULL CHECK (estatura > 0),
    lesiones        TEXT,
    id_socio        INTEGER NOT NULL UNIQUE REFERENCES socios (id_socio)
);

-- 5. Tabla membresias (depende de socios y planes - Relaciones 1:N)
CREATE TABLE membresias (
    id_membresia SERIAL PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin    DATE NOT NULL CHECK (fecha_fin >= fecha_inicio),
    id_socio     INTEGER NOT NULL REFERENCES socios (id_socio),
    id_plan      INTEGER NOT NULL REFERENCES planes (id_plan)
);

-- 6. Tabla clases_grupales (depende de entrenadores - Relación 1:N)
CREATE TABLE clases_grupales (
    id_clase      SERIAL PRIMARY KEY,
    nombre        VARCHAR(80) NOT NULL,
    dia_semana    VARCHAR(15) NOT NULL,
    hora          TIME NOT NULL,
    cupo          INTEGER NOT NULL CHECK (cupo > 0),
    id_entrenador INTEGER NOT NULL REFERENCES entrenadores (id_entrenador)
);

-- 7. Tabla inscripciones (depende de socios y clases_grupales - Relación N:M)
CREATE TABLE inscripciones (
    id_socio          INTEGER NOT NULL REFERENCES socios (id_socio),
    id_clase          INTEGER NOT NULL REFERENCES clases_grupales (id_clase),
    fecha_inscripcion DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_socio, id_clase)
);

