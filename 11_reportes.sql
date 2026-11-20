-- L1. Cuántos socios hay y cuántos tienen correo, en la misma consulta.
SELECT COUNT(*) AS total_socios,
       COUNT(correo) AS socios_con_correo
FROM socios;

-- L2. Cuánto dinero entró por las membresías que empezaron en noviembre de 2026.
SELECT SUM(valor_pagado) AS dinero_noviembre_2026
FROM membresias
WHERE fecha_inicio BETWEEN '2026-11-01' AND '2026-11-30';

-- L3. El menor valor pagado, el mayor y el promedio, sin decimales.
SELECT ROUND(MIN(valor_pagado)) AS menor_valor,
       ROUND(MAX(valor_pagado)) AS mayor_valor,
       ROUND(AVG(valor_pagado)) AS promedio_valor
FROM membresias;

-- L4. Cuántas membresías hay y cuántos socios distintos las compraron.
SELECT COUNT(*) AS total_membresias,
       COUNT(DISTINCT id_socio) AS socios_distintos
FROM membresias;