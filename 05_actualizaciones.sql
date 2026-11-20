-- 1. Un socio cambió de teléfono: corrígelo.
SELECT id_socio, nombre, telefono
FROM socios
WHERE id_socio = 1;

UPDATE socios
SET telefono = '3209876543'
WHERE id_socio = 1;

-- 2. Una clase se suspende: márcala como suspendida.
SELECT id_clase, nombre, estado
FROM clases_grupales
WHERE id_clase = 3;

UPDATE clases_grupales
SET estado = 'suspendida'
WHERE id_clase = 3;

-- 3. La membresía que registraste dos veces por error: borra el duplicado.
SELECT id_membresia, fecha_inicio, fecha_fin, id_socio, id_plan
FROM membresias
WHERE id_membresia = 6;

DELETE FROM membresias
WHERE id_membresia = 6;