-- 1. Para cada clave en la que tu decisión no sea proteger: ON DELETE
ALTER TABLE fichas_medicas
DROP CONSTRAINT fichas_medicas_id_socio_fkey,
ADD CONSTRAINT fichas_medicas_id_socio_fkey
FOREIGN KEY (id_socio)
REFERENCES socios (id_socio) 
ON DELETE CASCADE;

-- 2. Consulta para verificar
SELECT constraint_name, delete_rule
FROM information_schema.referential_constraints
ORDER BY constraint_name;