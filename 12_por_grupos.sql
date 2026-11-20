-- M1. Cuántas membresías se vendieron de cada plan, de la más vendida a la menos.
SELECT id_plan, COUNT(*) AS total_vendidas
FROM membresias
GROUP BY id_plan
ORDER BY total_vendidas DESC;

-- M2. Cuántos inscritos tiene cada clase.
SELECT id_clase, COUNT(*) AS total_inscritos
FROM inscripciones
GROUP BY id_clase
ORDER BY id_clase ASC;

-- M3. Solo las clases que tienen 4 inscritos o más.
SELECT id_clase, COUNT(*) AS total_inscritos
FROM inscripciones
GROUP BY id_clase
HAVING COUNT(*) >= 4
ORDER BY total_inscritos DESC;

-- M4. Los socios que renovaron: los que tienen 2 membresías o más.
SELECT id_socio, COUNT(*) AS total_membresias
FROM membresias
GROUP BY id_socio
HAVING COUNT(*) >= 2
ORDER BY total_membresias DESC;

-- M5. Reto. Los socios cuya membresía está vencida.
SELECT id_socio, MAX(fecha_fin) AS ultima_fecha_fin
FROM membresias
GROUP BY id_socio
HAVING MAX(fecha_fin) < CURRENT_DATE
ORDER BY ultima_fecha_fin ASC;

-- M6. Cuánto dinero dejó cada plan.
SELECT id_plan, SUM(valor_pagado) AS total_ingresos
FROM membresias
GROUP BY id_plan
ORDER BY total_ingresos DESC;