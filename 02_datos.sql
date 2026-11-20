-- 1. Socios (Mínimo 6. El socio 6 no tiene correo)
INSERT INTO socios (documento, nombre, telefono, correo)
VALUES ('1001234561', 'Camila Andrea Mendoza', '3001112233', 'camila.mendoza@correo.com'),
('1001234562', 'Mateo Alejandro Vargas', '3012223344', 'mateo.vargas@correo.com'),
('1001234563', 'Valentina Sofía Castro', '3023334455', 'valentina.castro@correo.com'),
('1001234564', 'Santiago José Rojas', '3044445566', 'santiago.rojas@correo.com'),
('1001234565', 'Lucía Fernanda Ortiz', '3055556677', 'lucia.ortiz@correo.com'),
('1001234566', 'Andrés Felipe Morales', '3106667788', NULL);

-- 2. Planes (Mínimo 3)
INSERT INTO planes (nombre, duracion_meses, precio)
VALUES ('Mensual', 1, 90000.00),
('Trimestral', 3, 240000.00),
('Anual', 12, 850000.00);

-- 3. Entrenadores (Mínimo 3. El entrenador 3 sin clases)
INSERT INTO entrenadores (nombre, especialidad, correo) 
VALUES ('Carlos Eduardo Gómez', 'Spinning y Cardio', 'carlos.gomez@cuerpoactivo.com'),
('Diana Carolina Ruiz', 'Yoga y Pilates', 'diana.ruiz@cuerpoactivo.com'),
('Javier Antonio Torres', 'Entrenamiento Funcional', 'javier.torres@cuerpoactivo.com');

-- 4. Fichas médicas (Mínimo 4. Socios 5 y 6 no tienen ficha)
INSERT INTO fichas_medicas (peso, estatura, lesiones, id_socio)
VALUES (58.50, 1.65, 'Ninguna', 1),
(78.20, 1.78, 'Esguince antiguo en tobillo derecho', 2),
(62.00, 1.68, 'Ninguna', 3),
(85.40, 1.80, 'Molestia lumbar leve', 4);

-- 5. Membresías (Mínimo 8)
-- Socio 1 renovó: tiene una vencida y una vigente
-- Socio 2 tiene una vencida
-- Socio 4 tiene una registrada dos veces por error)
INSERT INTO membresias (fecha_inicio, fecha_fin, id_socio, id_plan) 
VALUES ('2026-08-01', '2026-08-31', 1, 1), -- Vencida (Socio 1 - primera)
('2026-11-01', '2027-01-31', 1, 2), -- Vigente (Socio 1 - renovación)
('2026-09-15', '2026-10-15', 2, 1), -- Vencida (Socio 2)
('2026-11-05', '2027-11-05', 3, 3), -- Vigente (Socio 3)
('2026-11-10', '2026-12-10', 4, 1), -- Vigente (Socio 4)
('2026-11-10', '2026-12-10', 4, 1), -- DUPLICADA POR ERROR (Socio 4)
('2026-11-12', '2027-02-12', 5, 2), -- Vigente (Socio 5)
('2026-11-15', '2026-12-15', 6, 1); -- Vigente (Socio 6)

-- 6. Clases grupales (Mínimo 4. La clase 2 tiene cupo lleno)
INSERT INTO clases_grupales (nombre, dia_semana, hora, cupo, id_entrenador) 
VALUES ('Spinning Intenso', 'Lunes', '07:00:00', 10, 1),
('Yoga Restaurativo', 'Martes', '18:00:00', 3, 2),
('HIIT Cardio', 'Miércoles', '08:00:00', 12, 1),
('Pilates Mat', 'Jueves', '17:30:00', 8, 2);

-- 7. Inscripciones (Mínimo 10)
-- Clase 2 tiene 3 inscritos → cupo lleno
-- Socio 6 nunca se inscribió en ninguna clase)
INSERT INTO inscripciones (id_socio, id_clase, fecha_inscripcion) 
VALUES (1, 1, '2026-11-02'),
(1, 2, '2026-11-02'),
(1, 3, '2026-11-03'),
(2, 1, '2026-11-04'),
(2, 2, '2026-11-04'),
(3, 2, '2026-11-06'), -- Con este se llena el cupo (3/3) de la clase 2
(3, 4, '2026-11-06'),
(4, 1, '2026-11-11'),
(4, 3, '2026-11-11'),
(5, 4, '2026-11-13');

