-- Agregar columna y restricción con nombre
ALTER TABLE clases_grupales
ADD COLUMN estado VARCHAR(15) NOT NULL DEFAULT 'activa',
ADD CONSTRAINT clases_grupales_estado_check 
CHECK (estado IN ('activa', 'suspendida'));