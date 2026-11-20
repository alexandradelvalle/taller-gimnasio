-- Registrar la nueva clase de Pilates
INSERT INTO clases_grupales (nombre, dia_semana, hora, cupo, id_entrenador, estado)
VALUES ('Pilates', 'viernes', '18:00', 12, 2, 'activa');

-- R1. Los socios con la membresía vencida: nombre, teléfono, si acepta WhatsApp
-- y la fecha en que venció su última membresía.
SELECT s.nombre,
       s.telefono,
       s.acepta_whatsapp,
       ultimas.ultima_fecha_fin
FROM socios s
JOIN (
    SELECT id_socio,
           MAX(fecha_fin) AS ultima_fecha_fin
    FROM membresias
    GROUP BY id_socio
    HAVING MAX(fecha_fin) < CURRENT_DATE
) ultimas ON s.id_socio = ultimas.id_socio
ORDER BY ultimas.ultima_fecha_fin ASC;

-- R2. Cuántas membresías se vendieron de cada plan y cuánto dinero dejó cada uno, 
-- con el nombre del plan.
SELECT p.nombre AS plan,
       COUNT(*) AS total_membresias,
       SUM(m.valor_pagado) AS ingresos
FROM planes p
JOIN membresias m ON p.id_plan = m.id_plan
GROUP BY p.id_plan, p.nombre
ORDER BY total_membresias DESC;

-- R3. La ocupación de las clases activas: nombre, cupo e inscritos. Pilates tiene que salir con 0.
SELECT c.nombre AS clase,
       c.cupo,
       COUNT(i.id_socio) AS inscritos
FROM clases_grupales c
LEFT JOIN inscripciones i ON c.id_clase = i.id_clase
WHERE c.estado = 'activa'
GROUP BY c.id_clase, c.nombre, c.cupo
ORDER BY c.nombre;

-- R4. Solo las clases que ya llenaron el cupo. Con R3 completas la pregunta 4.
SELECT c.nombre AS clase,
       c.cupo,
       COUNT(i.id_socio) AS inscritos
FROM clases_grupales c
LEFT JOIN inscripciones i ON c.id_clase = i.id_clase
WHERE c.estado = 'activa'
GROUP BY c.id_clase, c.nombre, c.cupo
HAVING COUNT(i.id_socio) >= c.cupo
ORDER BY c.nombre;

-- R5. En R3, ¿qué cuentas: COUNT(*) o COUNT de una columna?
-- Prueba con COUNT(*)
SELECT c.nombre AS clase,
       c.cupo,
       COUNT(*) AS inscritos
FROM clases_grupales c
LEFT JOIN inscripciones i ON c.id_clase = i.id_clase
WHERE c.estado = 'activa'
GROUP BY c.id_clase, c.nombre, c.cupo
ORDER BY c.nombre;

-- Prueba con COUNT
SELECT c.nombre AS clase,
       c.cupo,
       COUNT(i.id_socio) AS inscritos
FROM clases_grupales c
LEFT JOIN inscripciones i ON c.id_clase = i.id_clase
WHERE c.estado = 'activa'
GROUP BY c.id_clase, c.nombre, c.cupo
ORDER BY c.nombre;

-- R6. En R3, la condición "solo las clases activas", ¿va en el WHERE o en el ON?
-- Prueba con la condición en ON
SELECT c.nombre AS clase,
       c.cupo,
       COUNT(i.id_socio) AS inscritos
FROM clases_grupales c
LEFT JOIN inscripciones i
    ON c.id_clase = i.id_clase
    AND c.estado = 'activa'
GROUP BY c.id_clase, c.nombre, c.cupo
ORDER BY c.nombre;