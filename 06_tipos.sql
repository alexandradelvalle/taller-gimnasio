-- 1. Agregar las dos columnas nuevas pedidas por Marcela
ALTER TABLE membresias
ADD COLUMN valor_pagado NUMERIC(10, 2);

ALTER TABLE socios
ADD COLUMN acepta_whatsapp BOOLEAN NOT NULL DEFAULT FALSE;

-- 2. Llenar valor_pagado una por una en todas las membresías existentes
-- (La membresía 4 tiene descuento: el plan Anual cuesta 850.000 y pagó 750.000)
UPDATE membresias SET valor_pagado = 90000.00  WHERE id_membresia = 1; -- Plan 1 (Mensual)
UPDATE membresias SET valor_pagado = 240000.00 WHERE id_membresia = 2; -- Plan 2 (Trimestral)
UPDATE membresias SET valor_pagado = 90000.00  WHERE id_membresia = 3; -- Plan 1 (Mensual)
UPDATE membresias SET valor_pagado = 750000.00 WHERE id_membresia = 4; -- Plan 3 (Anual CON DESCUENTO)
UPDATE membresias SET valor_pagado = 90000.00  WHERE id_membresia = 5; -- Plan 1 (Mensual)
UPDATE membresias SET valor_pagado = 240000.00 WHERE id_membresia = 7; -- Plan 2 (Trimestral)
UPDATE membresias SET valor_pagado = 90000.00  WHERE id_membresia = 8; -- Plan 1 (Mensual)

-- 3. Marcar con un solo UPDATE los socios que sí aceptan WhatsApp
UPDATE socios
SET acepta_whatsapp = TRUE
WHERE id_socio IN (1, 3, 5);

-- 4. Consulta para verificar los tipos de datos de las columnas de membresias
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'membresias'
ORDER BY ordinal_position;