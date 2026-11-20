-- P1. Los entrenadores que no tienen ninguna clase, con su especialidad.
SELECT e.id_entrenador,
       e.nombre,
       e.especialidad
FROM entrenadores e
LEFT JOIN clases_grupales c ON e.id_entrenador = c.id_entrenador
WHERE c.id_clase IS NULL;

-- P2. Los socios que nunca se han inscrito a una clase, con su teléfono.
SELECT s.id_socio,
       s.nombre,
       s.telefono
FROM socios s
LEFT JOIN inscripciones i ON s.id_socio = i.id_socio
WHERE i.id_socio IS NULL;

-- P3. Todos los socios con su peso y su estatura de la ficha médica.
-- Los que no tienen ficha tienen que salir igual, con los datos vacíos.
SELECT s.id_socio,
       s.nombre,
       f.peso,
       f.estatura
FROM socios s
LEFT JOIN fichas_medicas f ON s.id_socio = f.id_socio
ORDER BY s.id_socio ASC;