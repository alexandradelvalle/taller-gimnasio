-- 1. Toda membresía debe tener un valor pagado
ALTER TABLE membresias
ALTER COLUMN valor_pagado SET NOT NULL;

-- 2. El valor pagado debe ser mayor que cero
ALTER TABLE membresias
ADD CONSTRAINT membresias_valor_pagado_check
CHECK (valor_pagado > 0);

-- 3. Una membresía termina después de empezar
ALTER TABLE membresias
ADD CONSTRAINT membresias_fecha_fin_check
CHECK (fecha_fin > fecha_inicio);

-- 4. Un entrenador no puede dictar dos clases el mismo día a la misma hora
ALTER TABLE clases_grupales
ADD CONSTRAINT clases_grupales_id_entrenador_dia_semana_hora_key
UNIQUE (id_entrenador, dia_semana, hora);