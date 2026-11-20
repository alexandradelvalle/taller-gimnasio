--
-- PostgreSQL database dump
--

\restrict 4WbNPCVR87sf0LIYixpZe4CwfKVeuGALEiB15fiWRvUkTQNobRwVzibWA55crSU

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-19 23:47:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 16619)
-- Name: clases_grupales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clases_grupales (
    id_clase integer NOT NULL,
    nombre character varying(80) NOT NULL,
    dia_semana character varying(15) NOT NULL,
    hora time without time zone NOT NULL,
    cupo integer NOT NULL,
    id_entrenador integer NOT NULL,
    estado character varying(15) DEFAULT 'activa'::character varying NOT NULL,
    CONSTRAINT clases_grupales_cupo_check CHECK ((cupo > 0)),
    CONSTRAINT clases_grupales_estado_check CHECK (((estado)::text = ANY ((ARRAY['activa'::character varying, 'suspendida'::character varying])::text[])))
);


ALTER TABLE public.clases_grupales OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16618)
-- Name: clases_grupales_id_clase_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clases_grupales_id_clase_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clases_grupales_id_clase_seq OWNER TO postgres;

--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 229
-- Name: clases_grupales_id_clase_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clases_grupales_id_clase_seq OWNED BY public.clases_grupales.id_clase;


--
-- TOC entry 224 (class 1259 OID 16561)
-- Name: entrenadores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrenadores (
    id_entrenador integer NOT NULL,
    nombre character varying(100) NOT NULL,
    especialidad character varying(80) NOT NULL,
    correo character varying(100) NOT NULL
);


ALTER TABLE public.entrenadores OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16560)
-- Name: entrenadores_id_entrenador_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entrenadores_id_entrenador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entrenadores_id_entrenador_seq OWNER TO postgres;

--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 223
-- Name: entrenadores_id_entrenador_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entrenadores_id_entrenador_seq OWNED BY public.entrenadores.id_entrenador;


--
-- TOC entry 226 (class 1259 OID 16574)
-- Name: fichas_medicas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fichas_medicas (
    id_ficha_medica integer NOT NULL,
    peso numeric(5,2) NOT NULL,
    estatura numeric(3,2) NOT NULL,
    lesiones text,
    id_socio integer NOT NULL,
    CONSTRAINT fichas_medicas_estatura_check CHECK ((estatura > (0)::numeric)),
    CONSTRAINT fichas_medicas_peso_check CHECK ((peso > (0)::numeric))
);


ALTER TABLE public.fichas_medicas OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16573)
-- Name: fichas_medicas_id_ficha_medica_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fichas_medicas_id_ficha_medica_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fichas_medicas_id_ficha_medica_seq OWNER TO postgres;

--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 225
-- Name: fichas_medicas_id_ficha_medica_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fichas_medicas_id_ficha_medica_seq OWNED BY public.fichas_medicas.id_ficha_medica;


--
-- TOC entry 231 (class 1259 OID 16637)
-- Name: inscripciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscripciones (
    id_socio integer NOT NULL,
    id_clase integer NOT NULL,
    fecha_inscripcion date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.inscripciones OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16596)
-- Name: membresias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.membresias (
    id_membresia integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    id_socio integer NOT NULL,
    id_plan integer NOT NULL,
    valor_pagado numeric(10,2) NOT NULL,
    CONSTRAINT membresias_check CHECK ((fecha_fin >= fecha_inicio)),
    CONSTRAINT membresias_fecha_fin_check CHECK ((fecha_fin > fecha_inicio)),
    CONSTRAINT membresias_valor_pagado_check CHECK ((valor_pagado > (0)::numeric))
);


ALTER TABLE public.membresias OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16595)
-- Name: membresias_id_membresia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.membresias_id_membresia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.membresias_id_membresia_seq OWNER TO postgres;

--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 227
-- Name: membresias_id_membresia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.membresias_id_membresia_seq OWNED BY public.membresias.id_membresia;


--
-- TOC entry 233 (class 1259 OID 16814)
-- Name: ocupacion_clases; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ocupacion_clases AS
 SELECT c.nombre AS clase,
    c.dia_semana,
    c.hora,
    c.cupo,
    count(i.id_socio) AS inscritos
   FROM (public.clases_grupales c
     LEFT JOIN public.inscripciones i ON ((c.id_clase = i.id_clase)))
  WHERE ((c.estado)::text = 'activa'::text)
  GROUP BY c.id_clase, c.nombre, c.dia_semana, c.hora, c.cupo;


ALTER VIEW public.ocupacion_clases OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16548)
-- Name: planes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planes (
    id_plan integer NOT NULL,
    nombre character varying(50) NOT NULL,
    duracion_meses integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    CONSTRAINT planes_duracion_meses_check CHECK ((duracion_meses > 0)),
    CONSTRAINT planes_precio_check CHECK ((precio > (0)::numeric))
);


ALTER TABLE public.planes OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16547)
-- Name: planes_id_plan_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planes_id_plan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.planes_id_plan_seq OWNER TO postgres;

--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 221
-- Name: planes_id_plan_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.planes_id_plan_seq OWNED BY public.planes.id_plan;


--
-- TOC entry 220 (class 1259 OID 16533)
-- Name: socios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socios (
    id_socio integer NOT NULL,
    documento character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    telefono character varying(20) NOT NULL,
    correo character varying(100),
    acepta_whatsapp boolean DEFAULT false NOT NULL
);


ALTER TABLE public.socios OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16532)
-- Name: socios_id_socio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.socios_id_socio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.socios_id_socio_seq OWNER TO postgres;

--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 219
-- Name: socios_id_socio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.socios_id_socio_seq OWNED BY public.socios.id_socio;


--
-- TOC entry 232 (class 1259 OID 16809)
-- Name: socios_vencidos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.socios_vencidos AS
 SELECT s.nombre,
    s.telefono,
    s.acepta_whatsapp,
    ultimas.ultima_fecha_fin
   FROM (public.socios s
     JOIN ( SELECT membresias.id_socio,
            max(membresias.fecha_fin) AS ultima_fecha_fin
           FROM public.membresias
          GROUP BY membresias.id_socio
         HAVING (max(membresias.fecha_fin) < CURRENT_DATE)) ultimas ON ((s.id_socio = ultimas.id_socio)));


ALTER VIEW public.socios_vencidos OWNER TO postgres;

--
-- TOC entry 4899 (class 2604 OID 16622)
-- Name: clases_grupales id_clase; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clases_grupales ALTER COLUMN id_clase SET DEFAULT nextval('public.clases_grupales_id_clase_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 16564)
-- Name: entrenadores id_entrenador; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenadores ALTER COLUMN id_entrenador SET DEFAULT nextval('public.entrenadores_id_entrenador_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 16577)
-- Name: fichas_medicas id_ficha_medica; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fichas_medicas ALTER COLUMN id_ficha_medica SET DEFAULT nextval('public.fichas_medicas_id_ficha_medica_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 16599)
-- Name: membresias id_membresia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresias ALTER COLUMN id_membresia SET DEFAULT nextval('public.membresias_id_membresia_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 16551)
-- Name: planes id_plan; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes ALTER COLUMN id_plan SET DEFAULT nextval('public.planes_id_plan_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 16536)
-- Name: socios id_socio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socios ALTER COLUMN id_socio SET DEFAULT nextval('public.socios_id_socio_seq'::regclass);


--
-- TOC entry 5101 (class 0 OID 16619)
-- Dependencies: 230
-- Data for Name: clases_grupales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clases_grupales (id_clase, nombre, dia_semana, hora, cupo, id_entrenador, estado) FROM stdin;
1	Spinning Intenso	Lunes	07:00:00	10	1	activa
2	Yoga Restaurativo	Martes	18:00:00	3	2	activa
4	Pilates Mat	Jueves	17:30:00	8	2	activa
3	HIIT Cardio	Miércoles	08:00:00	12	1	suspendida
6	Pilates	viernes	18:00:00	12	2	activa
\.


--
-- TOC entry 5095 (class 0 OID 16561)
-- Dependencies: 224
-- Data for Name: entrenadores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrenadores (id_entrenador, nombre, especialidad, correo) FROM stdin;
1	Carlos Eduardo Gómez	Spinning y Cardio	carlos.gomez@cuerpoactivo.com
2	Diana Carolina Ruiz	Yoga y Pilates	diana.ruiz@cuerpoactivo.com
3	Javier Antonio Torres	Entrenamiento Funcional	javier.torres@cuerpoactivo.com
\.


--
-- TOC entry 5097 (class 0 OID 16574)
-- Dependencies: 226
-- Data for Name: fichas_medicas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fichas_medicas (id_ficha_medica, peso, estatura, lesiones, id_socio) FROM stdin;
1	58.50	1.65	Ninguna	1
2	78.20	1.78	Esguince antiguo en tobillo derecho	2
3	62.00	1.68	Ninguna	3
4	85.40	1.80	Molestia lumbar leve	4
\.


--
-- TOC entry 5102 (class 0 OID 16637)
-- Dependencies: 231
-- Data for Name: inscripciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscripciones (id_socio, id_clase, fecha_inscripcion) FROM stdin;
1	1	2026-11-02
1	2	2026-11-02
1	3	2026-11-03
2	1	2026-11-04
2	2	2026-11-04
3	2	2026-11-06
3	4	2026-11-06
4	1	2026-11-11
4	3	2026-11-11
5	4	2026-11-13
3	1	2026-11-18
5	1	2026-11-18
2	4	2026-11-19
1	4	2026-11-19
6	6	2026-11-19
\.


--
-- TOC entry 5099 (class 0 OID 16596)
-- Dependencies: 228
-- Data for Name: membresias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.membresias (id_membresia, fecha_inicio, fecha_fin, id_socio, id_plan, valor_pagado) FROM stdin;
1	2026-08-01	2026-08-31	1	1	90000.00
2	2026-11-01	2027-01-31	1	2	240000.00
3	2026-09-15	2026-10-15	2	1	90000.00
4	2026-11-05	2027-11-05	3	3	750000.00
5	2026-11-10	2026-12-10	4	1	90000.00
7	2026-11-12	2027-02-12	5	2	240000.00
8	2026-11-15	2026-12-15	6	1	90000.00
14	2026-09-01	2026-09-30	3	1	90000.00
15	2026-10-05	2026-11-04	5	1	85000.00
16	2026-11-03	2026-12-03	1	1	90000.00
17	2026-11-16	2027-02-16	4	2	240000.00
18	2026-11-18	2026-12-18	6	1	90000.00
19	2026-11-19	2027-11-19	3	3	850000.00
\.


--
-- TOC entry 5093 (class 0 OID 16548)
-- Dependencies: 222
-- Data for Name: planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planes (id_plan, nombre, duracion_meses, precio) FROM stdin;
1	Mensual	1	90000.00
2	Trimestral	3	240000.00
3	Anual	12	850000.00
\.


--
-- TOC entry 5091 (class 0 OID 16533)
-- Dependencies: 220
-- Data for Name: socios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socios (id_socio, documento, nombre, telefono, correo, acepta_whatsapp) FROM stdin;
2	1001234562	Mateo Alejandro Vargas	3012223344	mateo.vargas@correo.com	f
4	1001234564	Santiago José Rojas	3044445566	santiago.rojas@correo.com	f
6	1001234566	Andrés Felipe Morales	3106667788	\N	f
1	1001234561	Camila Andrea Mendoza	3209876543	camila.mendoza@correo.com	t
3	1001234563	Valentina Sofía Castro	3023334455	valentina.castro@correo.com	t
5	1001234565	Lucía Fernanda Ortiz	3055556677	lucia.ortiz@correo.com	t
9	1001234567	Daniela Patricia Ríos	3117778899	\N	t
10	1001234568	Sebastián Camilo Mejía	3128889900	sebastian.mejia@correo.com	f
\.


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 229
-- Name: clases_grupales_id_clase_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clases_grupales_id_clase_seq', 6, true);


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 223
-- Name: entrenadores_id_entrenador_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entrenadores_id_entrenador_seq', 3, true);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 225
-- Name: fichas_medicas_id_ficha_medica_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fichas_medicas_id_ficha_medica_seq', 6, true);


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 227
-- Name: membresias_id_membresia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.membresias_id_membresia_seq', 19, true);


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 221
-- Name: planes_id_plan_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planes_id_plan_seq', 3, true);


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 219
-- Name: socios_id_socio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socios_id_socio_seq', 10, true);


--
-- TOC entry 4930 (class 2606 OID 16735)
-- Name: clases_grupales clases_grupales_id_entrenador_dia_semana_hora_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clases_grupales
    ADD CONSTRAINT clases_grupales_id_entrenador_dia_semana_hora_key UNIQUE (id_entrenador, dia_semana, hora);


--
-- TOC entry 4932 (class 2606 OID 16631)
-- Name: clases_grupales clases_grupales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clases_grupales
    ADD CONSTRAINT clases_grupales_pkey PRIMARY KEY (id_clase);


--
-- TOC entry 4920 (class 2606 OID 16572)
-- Name: entrenadores entrenadores_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenadores
    ADD CONSTRAINT entrenadores_correo_key UNIQUE (correo);


--
-- TOC entry 4922 (class 2606 OID 16570)
-- Name: entrenadores entrenadores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrenadores
    ADD CONSTRAINT entrenadores_pkey PRIMARY KEY (id_entrenador);


--
-- TOC entry 4924 (class 2606 OID 16589)
-- Name: fichas_medicas fichas_medicas_id_socio_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fichas_medicas
    ADD CONSTRAINT fichas_medicas_id_socio_key UNIQUE (id_socio);


--
-- TOC entry 4926 (class 2606 OID 16587)
-- Name: fichas_medicas fichas_medicas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fichas_medicas
    ADD CONSTRAINT fichas_medicas_pkey PRIMARY KEY (id_ficha_medica);


--
-- TOC entry 4934 (class 2606 OID 16645)
-- Name: inscripciones inscripciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_pkey PRIMARY KEY (id_socio, id_clase);


--
-- TOC entry 4928 (class 2606 OID 16607)
-- Name: membresias membresias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresias
    ADD CONSTRAINT membresias_pkey PRIMARY KEY (id_membresia);


--
-- TOC entry 4918 (class 2606 OID 16559)
-- Name: planes planes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes
    ADD CONSTRAINT planes_pkey PRIMARY KEY (id_plan);


--
-- TOC entry 4912 (class 2606 OID 16546)
-- Name: socios socios_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socios
    ADD CONSTRAINT socios_correo_key UNIQUE (correo);


--
-- TOC entry 4914 (class 2606 OID 16544)
-- Name: socios socios_documento_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socios
    ADD CONSTRAINT socios_documento_key UNIQUE (documento);


--
-- TOC entry 4916 (class 2606 OID 16542)
-- Name: socios socios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socios
    ADD CONSTRAINT socios_pkey PRIMARY KEY (id_socio);


--
-- TOC entry 4938 (class 2606 OID 16632)
-- Name: clases_grupales clases_grupales_id_entrenador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clases_grupales
    ADD CONSTRAINT clases_grupales_id_entrenador_fkey FOREIGN KEY (id_entrenador) REFERENCES public.entrenadores(id_entrenador);


--
-- TOC entry 4935 (class 2606 OID 16736)
-- Name: fichas_medicas fichas_medicas_id_socio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fichas_medicas
    ADD CONSTRAINT fichas_medicas_id_socio_fkey FOREIGN KEY (id_socio) REFERENCES public.socios(id_socio) ON DELETE CASCADE;


--
-- TOC entry 4939 (class 2606 OID 16651)
-- Name: inscripciones inscripciones_id_clase_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_id_clase_fkey FOREIGN KEY (id_clase) REFERENCES public.clases_grupales(id_clase);


--
-- TOC entry 4940 (class 2606 OID 16646)
-- Name: inscripciones inscripciones_id_socio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_id_socio_fkey FOREIGN KEY (id_socio) REFERENCES public.socios(id_socio);


--
-- TOC entry 4936 (class 2606 OID 16613)
-- Name: membresias membresias_id_plan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresias
    ADD CONSTRAINT membresias_id_plan_fkey FOREIGN KEY (id_plan) REFERENCES public.planes(id_plan);


--
-- TOC entry 4937 (class 2606 OID 16608)
-- Name: membresias membresias_id_socio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresias
    ADD CONSTRAINT membresias_id_socio_fkey FOREIGN KEY (id_socio) REFERENCES public.socios(id_socio);


-- Completed on 2026-11-19 23:47:49

--
-- PostgreSQL database dump complete
--

\unrestrict 4WbNPCVR87sf0LIYixpZe4CwfKVeuGALEiB15fiWRvUkTQNobRwVzibWA55crSU

