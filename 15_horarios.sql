-- Q1. El horario de un socio que esté inscrito en dos clases o más: 
-- cada clase activa con su día, su hora y el nombre del entrenador.
SELECT c.nombre AS clase,
       c.dia_semana,
       c.hora,
       e.nombre AS entrenador
FROM socios s
JOIN inscripciones i ON i.id_socio = s.id_socio
JOIN clases_grupales c ON i.id_clase = c.id_clase
JOIN entrenadores e ON c.id_entrenador = e.id_entrenador
WHERE s.id_socio = 1
  AND c.estado = 'activa'
ORDER BY c.dia_semana, c.hora;

-- Q2. La lista para avisar que se suspendió una clase: los socios inscritos 
-- en tu clase suspendida (Parte G), con su teléfono y si aceptan WhatsApp.
SELECT s.nombre,
       s.telefono,
       s.acepta_whatsapp
FROM clases_grupales c
JOIN inscripciones i ON i.id_clase = c.id_clase
JOIN socios s ON i.id_socio = s.id_socio
WHERE c.id_clase = 3
  AND c.estado = 'suspendida'
ORDER BY s.nombre;