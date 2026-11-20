-- O1. Todas las membresías con el nombre del socio, el nombre del plan,
-- las fechas y el valor pagado, de la más antigua a la más reciente.
SELECT m.id_membresia,
       s.nombre AS socio,
       p.nombre AS plan,
       m.fecha_inicio,
       m.fecha_fin,
       m.valor_pagado
FROM membresias m
JOIN socios s ON m.id_socio = s.id_socio
JOIN planes p ON m.id_plan = p.id_plan
ORDER BY m.fecha_inicio ASC, m.id_membresia ASC;

-- O2. Las clases activas con el nombre de su entrenador, ordenadas por día y hora.
SELECT c.nombre AS clase,
       c.dia_semana,
       c.hora,
       e.nombre AS entrenador
FROM clases_grupales c
JOIN entrenadores e ON c.id_entrenador = e.id_entrenador
WHERE c.estado = 'activa'
ORDER BY c.dia_semana ASC, c.hora ASC;