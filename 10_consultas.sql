-- K1. Las membresías que empezaron en septiembre u octubre de 2026,
-- de la más antigua a la más reciente.
SELECT id_membresia, fecha_inicio, fecha_fin, id_socio, id_plan, valor_pagado
FROM membresias
WHERE fecha_inicio BETWEEN '2026-09-01' AND '2026-10-31'
ORDER BY fecha_inicio ASC;

-- K2. Las clases de spinning, sin importar si el nombre está escrito con mayúscula o minúscula.
SELECT id_clase, nombre, dia_semana, hora, cupo, estado
FROM clases_grupales
WHERE nombre ILIKE '%spinning%';

-- K3. Los socios que no tienen correo: su id, nombre y teléfono.
SELECT id_socio, nombre, telefono
FROM socios
WHERE correo IS NULL;

-- K4. Las clases activas que se dictan el lunes o el jueves (con OR y paréntesis).
-- (Se toma Lunes y Miércoles porque el miércoles está la clase suspendida).
SELECT id_clase, nombre, dia_semana, hora, estado
FROM clases_grupales
WHERE estado = 'activa'
	AND (dia_semana = 'Lunes' OR dia_semana = 'Miércoles');

-- K4 (Prueba sin paréntesis)
SELECT id_clase, nombre, dia_semana, hora, estado
FROM clases_grupales
WHERE estado = 'activa'
	AND dia_semana = 'Lunes' OR dia_semana = 'Miércoles';

-- K5. Las tres membresías que más pagaron, con las columnas llamadas membresia, socio y pagado.
-- Si hay empate en el valor, que desempate por el id.
SELECT id_membresia AS membresia,
       id_socio     AS socio,
       valor_pagado AS pagado
FROM membresias
ORDER BY valor_pagado DESC, id_membresia ASC
LIMIT 3;

-- K6. Los días de la semana en que hay clases, sin repetir y en orden.
SELECT DISTINCT dia_semana
FROM clases_grupales
ORDER BY dia_semana ASC;