-- S1. Las membresías que pagaron más que el promedio, con el nombre del socio.
SELECT m.id_membresia,
       s.nombre AS socio,
       m.valor_pagado
FROM membresias m
JOIN socios s ON m.id_socio = s.id_socio
WHERE m.valor_pagado > (
    SELECT AVG(valor_pagado)
    FROM membresias
)
ORDER BY m.valor_pagado DESC;

-- S2. Los socios inscritos en alguna clase de un entrenador que tú elijas, con IN y una subconsulta.
SELECT s.id_socio,
       s.nombre
FROM socios s
WHERE s.id_socio IN (
    SELECT i.id_socio
    FROM inscripciones i
    JOIN clases_grupales c ON i.id_clase = c.id_clase
    WHERE c.id_entrenador = 2
)
ORDER BY s.nombre;

-- S3. La pregunta 6 otra vez, ahora con NOT IN.
SELECT s.id_socio,
       s.nombre,
       s.telefono
FROM socios s
WHERE s.id_socio NOT IN (
    SELECT i.id_socio
    FROM inscripciones i
)
ORDER BY s.nombre;

-- S4. ¿Puede la subconsulta de S3 traer un vacío (NULL)? 
SELECT column_name,
       is_nullable,
       data_type
FROM information_schema.columns
WHERE table_name = 'inscripciones'
  AND column_name = 'id_socio';