-- T1. La vista socios_vencidos, con la consulta de R1.
CREATE VIEW socios_vencidos AS
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
) ultimas ON s.id_socio = ultimas.id_socio;

-- Para comprobarla:
SELECT * FROM socios_vencidos;

-- T2. La vista ocupacion_clases, con la consulta de R3 más el día y la hora de cada clase.
CREATE VIEW ocupacion_clases AS
SELECT c.nombre AS clase,
       c.dia_semana,
       c.hora,
       c.cupo,
       COUNT(i.id_socio) AS inscritos
FROM clases_grupales c
LEFT JOIN inscripciones i ON c.id_clase = i.id_clase
WHERE c.estado = 'activa'
GROUP BY c.id_clase, c.nombre, c.dia_semana, c.hora, c.cupo;

-- Para comprobarla:
SELECT * FROM ocupacion_clases;

-- T3. Lo que escribiría recepción: los socios vencidos que aceptan WhatsApp, y las clases con sus
-- cupos disponibles (cupo menos inscritos), de la que menos cupos tiene a la que más.

-- Socios vencidos que aceptan WhatsApp
SELECT nombre,
       telefono,
       ultima_fecha_fin
FROM socios_vencidos
WHERE acepta_whatsapp = TRUE
ORDER BY nombre;

-- Clases ordenadas por cupos disponibles
SELECT clase,
       dia_semana,
       hora,
       cupo,
       inscritos,
       cupo - inscritos AS cupos_disponibles
FROM ocupacion_clases
WHERE cupo - inscritos > 0
ORDER BY cupos_disponibles ASC;

-- T4. Inscribe a un socio en Pilates y vuelve a consultar ocupacion_clases sin tocar la vista.
INSERT INTO inscripciones (id_socio, id_clase, fecha_inscripcion)
VALUES (
    6,
    (SELECT id_clase
     FROM clases_grupales
     WHERE nombre = 'Pilates'),
    CURRENT_DATE
);

-- Consultar nuevamente la ocupación de Pilates
SELECT *
FROM ocupacion_clases
WHERE clase = 'Pilates';