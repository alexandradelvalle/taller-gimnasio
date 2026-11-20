-- F1. El nombre, el día y la hora de las clases que dicta el entrenador 1.
SELECT nombre, dia_semana, hora
FROM clases_grupales
WHERE id_entrenador = 1;

-- F2. Las membresías que ya vencieron (su fecha de fin es anterior a hoy):
-- el id de la membresía, el del socio y la fecha de fin.
SELECT id_membresia, id_socio, fecha_fin
FROM membresias
WHERE fecha_fin < CURRENT_DATE;

-- F3. El nombre y el precio de los planes que cuestan más de 100.000 pesos.
SELECT nombre, precio
FROM planes
WHERE precio > 100000;

-- F4. Las clases en las que está inscrito el socio 1, con la fecha de cada inscripción.
SELECT id_clase, fecha_inscripcion
FROM inscripciones
WHERE id_socio = 1;