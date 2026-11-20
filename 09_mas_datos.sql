-- 1. Socios nuevos
INSERT INTO socios (documento, nombre, telefono, correo, acepta_whatsapp) VALUES
('1001234567', 'Daniela Patricia Ríos', '3117778899', NULL, TRUE), -- Sin correo y acepta WhatsApp
('1001234568', 'Sebastián Camilo Mejía', '3128889900', 'sebastian.mejia@correo.com', FALSE);

-- 2. Membresías nuevas (6 en total)
INSERT INTO membresias (fecha_inicio, fecha_fin, id_socio, id_plan, valor_pagado) VALUES
('2026-09-01', '2026-09-30', 3, 1, 90000.00), -- Septiembre 2026
('2026-10-05', '2026-11-04', 5, 1, 85000.00), -- Octubre 2026
('2026-11-03', '2026-12-03', 1, 1, 90000.00), -- Tercera membresía del socio 1
('2026-11-16', '2027-02-16', 4, 2, 240000.00), -- Noviembre 2026
('2026-11-18', '2026-12-18', 6, 1, 90000.00), -- Noviembre 2026
('2026-11-19', '2027-11-19', 3, 3, 850000.00); -- Pago alto

-- 3. Inscripciones nuevas (4 en total)
INSERT INTO inscripciones (id_socio, id_clase, fecha_inscripcion) VALUES
(3, 1, '2026-11-18'), -- Spinning: pasa de 3 a 4 inscritos
(5, 1, '2026-11-18'), -- Spinning: pasa de 4 a 5 inscritos
(2, 4, '2026-11-19'), -- Pilates: pasa de 2 a 3 inscritos
(1, 4, '2026-11-19'); -- Pilates: pasa de 3 a 4 inscritos