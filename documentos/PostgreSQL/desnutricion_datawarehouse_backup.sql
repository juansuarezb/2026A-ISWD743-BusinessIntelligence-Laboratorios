--
-- PostgreSQL database dump
--

\restrict dNEE38cfkgxPk9cXlYmfHe3EaSQ8AGw1evkc1HHpn5RZizvvpNiJaia5f7aYEX8

-- Dumped from database version 17.7
-- Dumped by pg_dump version 17.7

-- Started on 2026-05-14 15:37:25

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
-- TOC entry 217 (class 1259 OID 24916)
-- Name: desnutricion_infantil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.desnutricion_infantil (
    child_id character varying(10),
    gender character(1),
    age_months smallint,
    weight_kg numeric(5,2),
    height_cm numeric(5,1),
    nutritional_status character varying(20),
    region character varying(50),
    institution character varying(50),
    date_measured date
);


ALTER TABLE public.desnutricion_infantil OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24930)
-- Name: dim_child; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_child (
    child_id character varying(10) NOT NULL,
    gender character(1) NOT NULL,
    age_months smallint NOT NULL,
    age_group character varying(10) NOT NULL,
    CONSTRAINT dim_child_age_group_check CHECK (((age_group)::text = ANY ((ARRAY['0-11'::character varying, '12-23'::character varying, '24-35'::character varying, '36-47'::character varying, '48-59'::character varying])::text[]))),
    CONSTRAINT dim_child_age_months_check CHECK (((age_months >= 0) AND (age_months <= 59))),
    CONSTRAINT dim_child_gender_check CHECK ((gender = ANY (ARRAY['M'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.dim_child OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24920)
-- Name: dim_date; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_date (
    date_id integer NOT NULL,
    date_measured date NOT NULL,
    year smallint NOT NULL,
    month smallint NOT NULL,
    day smallint NOT NULL,
    CONSTRAINT dim_date_day_check CHECK (((day >= 1) AND (day <= 31))),
    CONSTRAINT dim_date_month_check CHECK (((month >= 1) AND (month <= 12)))
);


ALTER TABLE public.dim_date OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24919)
-- Name: dim_date_date_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_date_date_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_date_date_id_seq OWNER TO postgres;

--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 218
-- Name: dim_date_date_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_date_date_id_seq OWNED BY public.dim_date.date_id;


--
-- TOC entry 222 (class 1259 OID 24939)
-- Name: dim_institution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_institution (
    institution_id integer NOT NULL,
    institution character varying(100) NOT NULL
);


ALTER TABLE public.dim_institution OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24938)
-- Name: dim_institution_institution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_institution_institution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_institution_institution_id_seq OWNER TO postgres;

--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 221
-- Name: dim_institution_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_institution_institution_id_seq OWNED BY public.dim_institution.institution_id;


--
-- TOC entry 224 (class 1259 OID 24948)
-- Name: dim_region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_region (
    region_id integer NOT NULL,
    region character varying(50) NOT NULL
);


ALTER TABLE public.dim_region OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24947)
-- Name: dim_region_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_region_region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_region_region_id_seq OWNER TO postgres;

--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 223
-- Name: dim_region_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_region_region_id_seq OWNED BY public.dim_region.region_id;


--
-- TOC entry 226 (class 1259 OID 24957)
-- Name: fact_cases_desnutrition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_cases_desnutrition (
    id_case integer NOT NULL,
    date_id integer NOT NULL,
    child_id character varying(10) NOT NULL,
    region_id integer NOT NULL,
    institution_id integer NOT NULL,
    weight_kg numeric(5,2) NOT NULL,
    height_cm numeric(5,1) NOT NULL,
    nutritional_status character varying(20) NOT NULL,
    CONSTRAINT fact_cases_desnutrition_height_cm_check CHECK ((height_cm > (0)::numeric)),
    CONSTRAINT fact_cases_desnutrition_nutritional_status_check CHECK (((nutritional_status)::text = ANY ((ARRAY['Aguda'::character varying, 'Cronica'::character varying, 'Global'::character varying])::text[]))),
    CONSTRAINT fact_cases_desnutrition_weight_kg_check CHECK ((weight_kg > (0)::numeric))
);


ALTER TABLE public.fact_cases_desnutrition OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24956)
-- Name: fact_cases_desnutrition_id_case_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_cases_desnutrition_id_case_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fact_cases_desnutrition_id_case_seq OWNER TO postgres;

--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 225
-- Name: fact_cases_desnutrition_id_case_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_cases_desnutrition_id_case_seq OWNED BY public.fact_cases_desnutrition.id_case;


--
-- TOC entry 4765 (class 2604 OID 24923)
-- Name: dim_date date_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_date ALTER COLUMN date_id SET DEFAULT nextval('public.dim_date_date_id_seq'::regclass);


--
-- TOC entry 4766 (class 2604 OID 24942)
-- Name: dim_institution institution_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_institution ALTER COLUMN institution_id SET DEFAULT nextval('public.dim_institution_institution_id_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 24951)
-- Name: dim_region region_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_region ALTER COLUMN region_id SET DEFAULT nextval('public.dim_region_region_id_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 24960)
-- Name: fact_cases_desnutrition id_case; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_cases_desnutrition ALTER COLUMN id_case SET DEFAULT nextval('public.fact_cases_desnutrition_id_case_seq'::regclass);


--
-- TOC entry 4942 (class 0 OID 24916)
-- Dependencies: 217
-- Data for Name: desnutricion_infantil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.desnutricion_infantil (child_id, gender, age_months, weight_kg, height_cm, nutritional_status, region, institution, date_measured) FROM stdin;
C0001	M	7	14.50	68.5	Aguda	Amazonia	Hospital A	2024-10-14
C0002	M	43	10.20	56.6	Aguda	Costa	Clinica C	2025-04-09
C0003	M	41	7.20	90.7	Global	Sierra	Hospital A	2025-04-26
C0004	F	43	8.30	102.8	Aguda	Amazonia	Centro B	2024-10-29
C0005	F	23	6.60	107.6	Cronica	Costa	Hospital A	2024-09-22
C0006	F	12	9.30	73.9	Cronica	Costa	Clinica C	2024-06-09
C0007	F	40	6.20	105.7	Aguda	Amazonia	Centro B	2024-05-14
C0008	F	42	7.10	58.8	Global	Costa	Centro B	2024-12-11
C0009	M	20	16.20	75.9	Cronica	Amazonia	Centro B	2023-11-25
C0010	M	29	9.30	91.9	Global	Amazonia	Clinica C	2024-10-01
C0011	M	44	13.10	84.4	Aguda	Costa	Centro B	2025-01-21
C0012	F	23	17.90	90.2	Global	Costa	Clinica C	2024-10-25
C0013	F	59	14.90	58.1	Aguda	Sierra	Centro B	2024-06-01
C0014	F	10	7.30	106.9	Global	Sierra	Hospital A	2024-01-22
C0015	F	31	16.40	90.4	Aguda	Sierra	Hospital A	2023-10-10
C0016	M	53	12.10	69.5	Global	Sierra	Clinica C	2023-05-15
C0017	F	29	7.50	109.9	Global	Sierra	Hospital A	2024-02-24
C0018	M	13	6.60	63.8	Global	Sierra	Clinica C	2023-12-10
C0019	M	30	9.70	109.8	Global	Sierra	Clinica C	2025-01-13
C0020	M	49	14.20	92.5	Global	Sierra	Clinica C	2024-09-22
C0021	F	13	8.50	63.7	Aguda	Amazonia	Clinica C	2024-12-19
C0022	F	38	14.80	82.9	Aguda	Amazonia	Centro B	2024-02-26
C0023	M	15	9.50	63.9	Global	Costa	Clinica C	2024-04-02
C0024	F	37	4.80	106.1	Cronica	Costa	Hospital A	2025-02-28
C0025	M	42	17.30	59.7	Cronica	Costa	Clinica C	2023-07-11
C0026	M	14	13.40	107.1	Aguda	Sierra	Clinica C	2023-06-14
C0027	F	19	17.00	96.5	Global	Costa	Clinica C	2023-09-15
C0028	F	31	17.90	90.7	Cronica	Amazonia	Centro B	2024-08-22
C0029	M	21	7.50	73.6	Global	Amazonia	Hospital A	2023-08-03
C0030	M	6	5.50	89.7	Aguda	Costa	Hospital A	2024-05-31
C0031	F	10	11.40	70.3	Cronica	Costa	Clinica C	2024-11-15
C0032	M	52	17.10	86.4	Cronica	Costa	Centro B	2025-05-12
C0033	F	18	5.80	91.2	Cronica	Sierra	Centro B	2024-12-25
C0034	F	52	5.20	90.9	Global	Costa	Hospital A	2024-10-07
C0035	F	52	9.10	102.4	Aguda	Costa	Hospital A	2023-12-22
C0036	F	14	10.20	70.3	Aguda	Costa	Centro B	2024-07-04
C0037	M	9	13.30	84.7	Aguda	Costa	Hospital A	2024-09-13
C0038	M	32	11.10	66.8	Cronica	Costa	Hospital A	2025-02-12
C0039	F	6	17.80	69.6	Cronica	Sierra	Centro B	2024-11-12
C0040	F	15	7.10	67.0	Aguda	Amazonia	Clinica C	2023-08-30
C0041	M	53	8.70	57.8	Cronica	Amazonia	Clinica C	2023-08-04
C0042	M	9	17.50	59.4	Aguda	Costa	Clinica C	2024-01-18
C0043	M	49	16.10	77.2	Global	Costa	Clinica C	2025-01-02
C0044	M	45	5.60	91.2	Global	Amazonia	Centro B	2024-07-23
C0045	F	19	13.50	72.3	Cronica	Sierra	Hospital A	2024-10-31
C0046	F	35	8.80	96.4	Aguda	Costa	Centro B	2023-12-22
C0047	M	10	11.80	82.8	Aguda	Sierra	Hospital A	2024-04-28
C0048	M	29	8.30	79.1	Global	Amazonia	Centro B	2023-09-27
C0049	M	48	15.50	71.5	Global	Costa	Hospital A	2024-07-03
C0050	F	13	16.50	95.8	Aguda	Sierra	Centro B	2025-01-26
C0051	M	51	9.10	92.8	Cronica	Amazonia	Centro B	2023-10-10
C0052	F	9	5.70	78.3	Cronica	Costa	Hospital A	2024-12-06
C0053	F	55	6.30	108.9	Aguda	Amazonia	Centro B	2024-02-12
C0054	F	41	4.60	59.1	Global	Costa	Clinica C	2023-10-08
C0055	M	59	9.50	85.4	Cronica	Costa	Hospital A	2024-08-05
C0056	F	29	16.60	98.8	Aguda	Sierra	Hospital A	2024-11-04
C0057	M	48	5.90	97.9	Cronica	Amazonia	Clinica C	2024-08-13
C0058	M	21	16.20	108.7	Aguda	Sierra	Hospital A	2024-02-12
C0059	M	53	17.00	98.0	Cronica	Amazonia	Clinica C	2023-05-28
C0060	M	23	6.60	93.6	Cronica	Costa	Centro B	2025-01-12
C0061	M	18	15.50	80.3	Cronica	Costa	Hospital A	2023-05-15
C0062	M	48	7.10	73.1	Aguda	Sierra	Centro B	2024-10-01
C0063	F	49	17.70	84.5	Aguda	Costa	Centro B	2023-11-16
C0064	M	43	17.50	69.6	Aguda	Amazonia	Centro B	2024-05-29
C0065	F	52	15.10	79.0	Global	Costa	Centro B	2023-10-03
C0066	M	22	5.10	79.0	Global	Amazonia	Clinica C	2024-12-22
C0067	M	29	10.30	107.2	Cronica	Amazonia	Centro B	2023-08-28
C0068	M	52	16.70	82.9	Global	Sierra	Centro B	2025-04-04
C0069	F	50	8.50	62.0	Cronica	Amazonia	Centro B	2023-07-25
C0070	M	45	12.20	77.3	Aguda	Sierra	Centro B	2024-03-19
C0071	M	33	15.10	88.4	Cronica	Sierra	Centro B	2024-07-14
C0072	F	49	7.40	81.0	Global	Costa	Clinica C	2024-06-23
C0073	M	24	11.50	89.8	Cronica	Costa	Hospital A	2024-09-23
C0074	F	20	15.40	63.1	Aguda	Costa	Centro B	2025-02-12
C0075	M	35	10.10	89.6	Aguda	Amazonia	Clinica C	2025-01-21
C0076	F	37	9.90	63.1	Global	Costa	Hospital A	2024-06-10
C0077	F	20	6.90	107.7	Global	Sierra	Hospital A	2024-07-24
C0078	M	13	10.70	99.1	Global	Amazonia	Clinica C	2024-03-13
C0079	F	54	16.50	88.7	Global	Amazonia	Centro B	2023-10-24
C0080	F	16	14.50	81.1	Cronica	Costa	Clinica C	2024-02-17
C0081	F	55	15.00	81.7	Aguda	Sierra	Centro B	2024-02-25
C0082	M	51	8.40	69.9	Cronica	Amazonia	Hospital A	2023-09-17
C0083	M	15	7.60	93.2	Global	Costa	Hospital A	2024-11-12
C0084	F	32	9.00	80.6	Aguda	Costa	Centro B	2023-12-01
C0085	F	55	12.40	93.3	Global	Sierra	Centro B	2023-12-25
C0086	M	28	8.50	76.4	Cronica	Amazonia	Clinica C	2025-01-01
C0087	M	37	7.50	79.0	Aguda	Sierra	Centro B	2023-10-23
C0088	F	52	6.70	80.7	Aguda	Amazonia	Clinica C	2023-07-17
C0089	M	31	12.50	91.5	Aguda	Amazonia	Centro B	2024-08-29
C0090	M	35	7.00	69.3	Cronica	Costa	Centro B	2023-10-13
C0091	F	27	14.80	75.9	Cronica	Sierra	Hospital A	2023-06-25
C0092	F	7	14.60	57.9	Cronica	Costa	Clinica C	2023-11-09
C0093	M	55	17.40	57.2	Aguda	Costa	Hospital A	2023-09-15
C0094	M	45	6.60	61.9	Global	Costa	Clinica C	2025-01-19
C0095	M	35	13.90	97.2	Aguda	Amazonia	Clinica C	2025-01-30
C0096	M	55	15.60	108.1	Aguda	Amazonia	Hospital A	2024-06-24
C0097	F	42	13.60	107.7	Cronica	Amazonia	Hospital A	2023-06-13
C0098	M	43	13.80	89.5	Aguda	Amazonia	Centro B	2025-05-06
C0099	M	56	17.80	98.0	Cronica	Amazonia	Centro B	2024-05-26
C0100	F	10	11.30	73.8	Cronica	Sierra	Hospital A	2023-10-14
C0101	F	29	13.10	100.6	Global	Costa	Centro B	2025-02-13
C0102	M	52	11.50	90.8	Global	Amazonia	Centro B	2025-01-02
C0103	F	33	15.60	87.6	Cronica	Costa	Hospital A	2024-04-28
C0104	F	34	7.80	80.6	Global	Amazonia	Centro B	2023-07-31
C0105	F	7	11.20	72.9	Cronica	Costa	Centro B	2023-12-11
C0106	F	27	8.30	87.8	Cronica	Amazonia	Hospital A	2024-09-30
C0107	M	11	7.80	77.4	Global	Costa	Clinica C	2024-04-27
C0108	F	47	14.10	79.6	Aguda	Costa	Centro B	2024-05-29
C0109	M	31	13.80	71.8	Global	Sierra	Centro B	2024-01-21
C0110	F	33	18.00	85.3	Cronica	Amazonia	Centro B	2025-02-15
C0111	F	25	7.90	61.6	Aguda	Sierra	Hospital A	2025-02-06
C0112	M	18	7.40	81.6	Global	Amazonia	Clinica C	2023-08-29
C0113	F	12	15.70	71.3	Cronica	Costa	Centro B	2024-08-13
C0114	M	51	11.70	70.1	Aguda	Amazonia	Centro B	2024-08-22
C0115	M	46	16.20	82.0	Aguda	Amazonia	Centro B	2023-12-30
C0116	F	36	10.40	65.1	Aguda	Sierra	Centro B	2024-06-15
C0117	M	58	5.40	82.0	Global	Amazonia	Clinica C	2025-02-26
C0118	M	15	6.50	86.0	Cronica	Costa	Hospital A	2023-05-17
C0119	M	41	14.80	88.3	Global	Costa	Clinica C	2023-05-31
C0120	F	34	16.80	71.4	Global	Sierra	Centro B	2025-01-31
C0121	M	45	17.50	60.5	Aguda	Amazonia	Hospital A	2024-02-13
C0122	F	48	5.60	68.2	Global	Costa	Hospital A	2024-02-25
C0123	M	32	10.60	87.7	Cronica	Costa	Hospital A	2024-02-24
C0124	F	51	8.30	102.3	Aguda	Amazonia	Hospital A	2024-11-27
C0125	F	56	15.20	87.4	Aguda	Sierra	Hospital A	2023-09-11
C0126	M	47	6.50	69.6	Aguda	Costa	Hospital A	2024-11-05
C0127	M	56	8.70	96.2	Global	Sierra	Centro B	2023-08-03
C0128	M	35	13.80	93.5	Cronica	Amazonia	Clinica C	2023-07-29
C0129	F	34	5.60	57.2	Cronica	Amazonia	Centro B	2024-09-04
C0130	F	7	5.70	107.9	Global	Amazonia	Hospital A	2024-02-08
C0131	F	42	5.00	96.6	Cronica	Amazonia	Clinica C	2024-06-07
C0132	F	23	7.00	87.2	Global	Sierra	Hospital A	2025-02-04
C0133	F	28	10.00	72.7	Aguda	Costa	Centro B	2024-09-25
C0134	F	50	11.20	91.4	Cronica	Amazonia	Hospital A	2024-01-05
C0135	F	11	8.70	72.8	Cronica	Amazonia	Hospital A	2024-11-18
C0136	F	32	5.20	83.5	Global	Sierra	Clinica C	2024-07-03
C0137	F	54	5.20	69.7	Aguda	Sierra	Centro B	2024-11-07
C0138	F	13	4.90	89.7	Aguda	Amazonia	Hospital A	2024-06-22
C0139	F	41	4.70	77.4	Aguda	Costa	Centro B	2025-03-06
C0140	M	47	15.70	82.4	Global	Sierra	Clinica C	2024-12-31
C0141	F	32	15.80	108.9	Aguda	Sierra	Clinica C	2024-04-12
C0142	M	30	7.10	88.0	Global	Costa	Hospital A	2024-08-04
C0143	F	55	15.20	77.8	Global	Sierra	Hospital A	2023-10-07
C0144	F	52	8.50	87.3	Global	Sierra	Hospital A	2025-05-11
C0145	F	40	11.00	73.3	Global	Sierra	Centro B	2024-10-25
C0146	F	18	17.70	68.1	Cronica	Costa	Centro B	2025-03-26
C0147	M	26	14.60	93.8	Cronica	Sierra	Clinica C	2023-07-17
C0148	M	37	17.50	61.9	Global	Sierra	Hospital A	2024-12-18
C0149	F	12	11.60	80.1	Global	Costa	Centro B	2023-12-13
C0150	M	10	10.80	108.3	Cronica	Amazonia	Clinica C	2024-01-07
C0151	F	47	5.60	73.1	Global	Amazonia	Centro B	2024-12-26
C0152	F	46	14.20	96.8	Global	Costa	Clinica C	2024-03-08
C0153	M	21	13.00	105.7	Aguda	Amazonia	Hospital A	2025-01-15
C0154	F	12	14.80	93.7	Aguda	Sierra	Hospital A	2023-08-29
C0155	F	7	5.10	98.8	Cronica	Sierra	Centro B	2024-07-15
C0156	F	15	7.80	77.7	Global	Costa	Hospital A	2024-08-12
C0157	M	11	12.70	76.0	Global	Costa	Centro B	2023-12-15
C0158	M	20	10.70	69.0	Cronica	Amazonia	Hospital A	2024-05-20
C0159	F	24	13.60	63.7	Cronica	Sierra	Clinica C	2023-06-02
C0160	F	46	17.50	93.0	Cronica	Sierra	Hospital A	2025-05-04
C0161	F	36	5.90	76.0	Cronica	Amazonia	Centro B	2023-12-26
C0162	F	7	17.70	91.2	Cronica	Costa	Clinica C	2023-07-25
C0163	M	44	14.60	100.8	Cronica	Costa	Clinica C	2023-05-31
C0164	F	20	13.10	89.1	Global	Amazonia	Clinica C	2025-03-07
C0165	M	46	5.80	89.5	Aguda	Sierra	Centro B	2023-09-21
C0166	M	43	9.40	62.2	Cronica	Sierra	Clinica C	2024-07-19
C0167	F	17	7.20	98.3	Cronica	Amazonia	Clinica C	2024-07-01
C0168	F	59	6.70	105.3	Cronica	Sierra	Clinica C	2024-09-18
C0169	F	57	6.10	108.0	Aguda	Costa	Clinica C	2024-01-10
C0170	F	57	12.00	60.0	Cronica	Costa	Centro B	2023-06-24
C0171	M	35	9.50	96.2	Cronica	Amazonia	Centro B	2025-03-18
C0172	F	12	13.60	80.9	Global	Amazonia	Centro B	2025-01-30
C0173	M	47	5.40	100.3	Global	Sierra	Clinica C	2025-02-20
C0174	F	13	6.40	107.0	Cronica	Sierra	Hospital A	2024-04-12
C0175	M	21	16.50	62.5	Cronica	Sierra	Clinica C	2024-10-16
C0176	F	43	14.50	63.5	Cronica	Amazonia	Hospital A	2023-06-08
C0177	F	45	10.00	107.3	Aguda	Amazonia	Centro B	2024-11-16
C0178	M	34	10.50	68.0	Cronica	Costa	Clinica C	2024-09-23
C0179	F	40	16.70	90.5	Aguda	Sierra	Centro B	2024-11-08
C0180	M	13	17.30	100.3	Aguda	Amazonia	Hospital A	2023-06-28
C0181	M	9	15.10	68.4	Aguda	Amazonia	Hospital A	2023-12-04
C0182	M	59	14.80	66.4	Aguda	Costa	Centro B	2025-03-14
C0183	M	56	16.70	55.2	Aguda	Costa	Clinica C	2023-07-07
C0184	F	57	6.90	91.4	Aguda	Costa	Hospital A	2024-02-23
C0185	F	56	15.10	87.4	Aguda	Costa	Centro B	2025-03-23
C0186	M	14	14.50	83.9	Global	Costa	Centro B	2023-05-17
C0187	F	55	9.40	87.7	Cronica	Amazonia	Hospital A	2024-12-16
C0188	M	52	15.10	102.7	Global	Sierra	Centro B	2024-10-17
C0189	M	9	18.00	101.6	Cronica	Amazonia	Hospital A	2024-07-09
C0190	F	51	16.80	59.0	Aguda	Sierra	Clinica C	2024-06-29
C0191	M	10	6.20	89.3	Global	Amazonia	Clinica C	2025-01-13
C0192	F	30	17.90	84.2	Cronica	Amazonia	Clinica C	2025-04-03
C0193	F	12	15.20	61.3	Global	Amazonia	Clinica C	2024-04-01
C0194	M	33	10.60	67.6	Cronica	Sierra	Centro B	2024-03-30
C0195	F	52	5.80	78.5	Global	Sierra	Centro B	2023-11-03
C0196	M	49	17.00	58.7	Aguda	Costa	Centro B	2025-03-23
C0197	M	53	14.50	99.6	Global	Costa	Clinica C	2024-12-10
C0198	F	48	6.20	74.4	Global	Sierra	Clinica C	2023-08-10
C0199	M	24	12.60	74.3	Global	Amazonia	Hospital A	2024-10-07
C0200	M	48	11.00	101.6	Cronica	Amazonia	Centro B	2023-07-31
C0201	M	54	8.30	67.4	Cronica	Amazonia	Clinica C	2024-01-11
C0202	M	44	17.00	100.6	Cronica	Costa	Hospital A	2023-08-22
C0203	F	50	14.80	105.7	Cronica	Costa	Hospital A	2023-10-05
C0204	M	42	13.40	58.8	Global	Amazonia	Hospital A	2024-01-11
C0205	M	53	11.70	75.7	Cronica	Sierra	Hospital A	2025-01-31
C0206	F	25	14.20	97.7	Global	Amazonia	Hospital A	2025-02-12
C0207	M	15	6.60	89.0	Global	Costa	Centro B	2024-05-24
C0208	F	48	10.20	88.4	Cronica	Sierra	Hospital A	2024-11-18
C0209	M	28	10.30	70.6	Global	Amazonia	Centro B	2023-08-30
C0210	F	8	7.50	109.1	Aguda	Costa	Hospital A	2024-11-26
C0211	F	19	14.90	97.0	Cronica	Sierra	Hospital A	2025-01-01
C0212	M	37	14.60	64.7	Cronica	Amazonia	Clinica C	2024-09-05
C0213	M	38	12.00	91.7	Cronica	Costa	Centro B	2025-03-27
C0214	M	33	4.80	105.7	Cronica	Amazonia	Centro B	2024-06-03
C0215	F	51	13.10	70.9	Cronica	Costa	Centro B	2024-11-08
C0216	M	57	17.30	80.3	Global	Sierra	Hospital A	2024-12-24
C0217	F	12	7.80	87.4	Global	Costa	Centro B	2024-11-21
C0218	F	53	9.10	73.3	Aguda	Costa	Clinica C	2023-06-24
C0219	M	39	11.40	104.8	Cronica	Sierra	Clinica C	2024-10-08
C0220	M	21	5.90	69.1	Aguda	Amazonia	Hospital A	2024-01-18
C0221	M	17	17.30	89.5	Cronica	Amazonia	Clinica C	2024-12-05
C0222	F	49	17.00	86.0	Global	Amazonia	Centro B	2024-01-13
C0223	F	15	10.40	80.8	Global	Sierra	Centro B	2023-11-08
C0224	M	28	11.30	72.1	Cronica	Costa	Hospital A	2025-04-26
C0225	F	59	8.40	90.5	Aguda	Amazonia	Clinica C	2025-02-13
C0226	F	35	12.30	107.5	Global	Costa	Centro B	2025-05-11
C0227	M	26	12.70	82.6	Aguda	Sierra	Hospital A	2024-06-11
C0228	F	51	5.60	90.5	Aguda	Costa	Clinica C	2025-03-15
C0229	F	34	11.60	88.5	Cronica	Sierra	Centro B	2024-11-16
C0230	F	32	15.00	92.3	Aguda	Amazonia	Clinica C	2024-08-01
C0231	F	10	9.00	85.7	Cronica	Sierra	Centro B	2023-12-17
C0232	M	27	5.60	91.5	Cronica	Sierra	Clinica C	2024-03-26
C0233	F	14	12.50	106.6	Cronica	Amazonia	Centro B	2024-03-18
C0234	F	58	6.20	93.7	Global	Amazonia	Clinica C	2024-11-03
C0235	M	47	13.60	83.0	Aguda	Sierra	Centro B	2024-08-15
C0236	M	19	9.10	97.1	Aguda	Costa	Hospital A	2024-07-09
C0237	M	10	8.50	98.3	Global	Amazonia	Clinica C	2024-06-18
C0238	M	48	9.00	97.1	Aguda	Amazonia	Centro B	2024-05-07
C0239	M	16	6.90	93.1	Global	Costa	Clinica C	2024-11-05
C0240	F	8	10.00	92.2	Aguda	Sierra	Clinica C	2023-05-15
C0241	F	54	14.60	79.7	Global	Costa	Centro B	2024-05-14
C0242	F	59	7.10	92.3	Global	Sierra	Centro B	2025-01-05
C0243	F	55	9.70	84.0	Aguda	Costa	Clinica C	2024-09-13
C0244	M	22	5.20	81.4	Cronica	Amazonia	Hospital A	2024-10-06
C0245	M	24	5.60	63.8	Cronica	Amazonia	Hospital A	2025-01-23
C0246	F	11	17.30	67.2	Cronica	Sierra	Hospital A	2023-12-17
C0247	F	9	9.90	75.6	Cronica	Costa	Centro B	2024-06-28
C0248	M	7	8.80	60.4	Global	Amazonia	Centro B	2024-04-17
C0249	M	14	5.00	105.5	Cronica	Amazonia	Hospital A	2023-08-30
C0250	F	34	12.80	104.8	Aguda	Sierra	Hospital A	2024-03-07
C0251	M	41	17.20	88.5	Cronica	Costa	Centro B	2025-05-08
C0252	M	25	6.10	68.1	Global	Amazonia	Centro B	2024-02-06
C0253	M	13	15.80	82.5	Global	Costa	Clinica C	2024-11-23
C0254	M	51	6.40	78.6	Global	Sierra	Hospital A	2023-12-23
C0255	F	17	13.50	59.7	Cronica	Costa	Clinica C	2024-02-22
C0256	M	30	16.30	57.4	Cronica	Sierra	Centro B	2024-10-24
C0257	M	28	15.10	74.0	Global	Amazonia	Clinica C	2024-03-24
C0258	M	55	12.40	96.6	Aguda	Costa	Centro B	2024-04-10
C0259	F	58	13.20	100.7	Global	Sierra	Clinica C	2025-04-21
C0260	F	46	7.00	62.4	Global	Sierra	Hospital A	2025-03-26
C0261	F	18	5.10	66.0	Aguda	Sierra	Centro B	2024-05-08
C0262	F	58	11.80	68.9	Global	Costa	Centro B	2024-12-19
C0263	F	55	5.10	91.1	Cronica	Costa	Centro B	2023-09-08
C0264	F	31	14.50	104.2	Cronica	Sierra	Hospital A	2025-01-17
C0265	F	50	11.20	105.8	Global	Sierra	Hospital A	2025-04-18
C0266	F	11	10.30	109.7	Aguda	Amazonia	Centro B	2025-03-09
C0267	F	12	5.60	91.4	Cronica	Sierra	Clinica C	2023-05-21
C0268	F	16	13.80	74.3	Aguda	Amazonia	Centro B	2024-08-15
C0269	F	23	13.10	98.5	Aguda	Costa	Clinica C	2025-04-25
C0270	F	29	11.40	96.2	Aguda	Costa	Hospital A	2023-07-15
C0271	F	8	6.20	68.0	Global	Sierra	Centro B	2024-11-11
C0272	F	42	4.90	63.4	Cronica	Sierra	Centro B	2024-10-27
C0273	F	54	5.50	62.6	Cronica	Sierra	Centro B	2024-11-18
C0274	F	21	17.50	56.4	Aguda	Sierra	Clinica C	2024-12-31
C0275	F	41	6.10	97.6	Global	Sierra	Hospital A	2024-03-19
C0276	F	50	16.90	82.0	Aguda	Costa	Hospital A	2024-11-13
C0277	F	17	16.60	79.5	Aguda	Amazonia	Centro B	2024-06-18
C0278	F	51	5.40	84.8	Cronica	Costa	Clinica C	2024-03-03
C0279	M	56	9.40	67.3	Aguda	Costa	Hospital A	2023-07-07
C0280	F	7	9.40	86.5	Cronica	Amazonia	Hospital A	2024-10-09
C0281	M	10	8.70	110.0	Global	Sierra	Clinica C	2023-12-02
C0282	F	55	10.00	86.6	Aguda	Sierra	Clinica C	2025-03-02
C0283	M	34	10.80	83.5	Aguda	Amazonia	Clinica C	2023-09-22
C0284	M	55	17.50	78.8	Aguda	Costa	Clinica C	2024-07-06
C0285	M	25	6.70	72.7	Global	Costa	Centro B	2023-05-30
C0286	F	11	7.90	89.9	Global	Sierra	Hospital A	2024-10-28
C0287	F	45	11.70	82.6	Aguda	Amazonia	Clinica C	2023-11-08
C0288	M	16	13.40	94.6	Global	Sierra	Clinica C	2023-08-23
C0289	M	58	16.20	59.5	Global	Amazonia	Centro B	2024-05-07
C0290	M	55	12.20	89.0	Aguda	Sierra	Clinica C	2024-12-09
C0291	F	47	17.40	81.6	Global	Sierra	Centro B	2024-11-17
C0292	F	10	13.80	63.7	Cronica	Sierra	Centro B	2024-02-13
C0293	M	27	12.70	72.2	Global	Sierra	Clinica C	2024-05-04
C0294	F	31	6.30	75.4	Global	Costa	Centro B	2024-03-25
C0295	M	35	6.20	79.7	Aguda	Costa	Hospital A	2023-09-13
C0296	F	30	16.20	78.0	Aguda	Sierra	Clinica C	2024-10-28
C0297	F	18	14.80	82.4	Global	Sierra	Centro B	2023-11-28
C0298	F	37	4.80	107.0	Global	Sierra	Hospital A	2024-12-17
C0299	M	43	9.30	57.8	Cronica	Amazonia	Clinica C	2024-09-27
C0300	F	24	11.70	101.6	Cronica	Costa	Centro B	2023-09-20
C0301	F	54	9.90	57.5	Aguda	Amazonia	Clinica C	2024-05-19
C0302	M	29	12.00	59.0	Global	Sierra	Clinica C	2025-01-29
C0303	F	58	17.90	92.4	Aguda	Costa	Hospital A	2024-06-27
C0304	F	29	15.20	73.6	Cronica	Costa	Hospital A	2023-05-25
C0305	F	38	5.00	57.1	Global	Sierra	Centro B	2024-12-02
C0306	F	15	12.70	83.4	Cronica	Amazonia	Centro B	2024-08-03
C0307	M	31	17.90	95.7	Cronica	Amazonia	Centro B	2024-03-24
C0308	F	51	12.10	81.1	Aguda	Sierra	Centro B	2024-04-16
C0309	M	32	12.40	98.8	Global	Amazonia	Clinica C	2024-02-11
C0310	M	44	10.90	108.2	Global	Amazonia	Hospital A	2024-05-23
C0311	M	43	11.00	83.8	Global	Amazonia	Centro B	2023-11-17
C0312	M	58	13.70	56.7	Global	Costa	Hospital A	2024-07-10
C0313	M	34	8.70	63.3	Global	Costa	Centro B	2024-12-19
C0314	F	53	14.30	93.8	Global	Costa	Clinica C	2023-09-09
C0315	F	48	11.00	75.7	Aguda	Sierra	Clinica C	2024-12-09
C0316	F	40	9.30	97.5	Global	Amazonia	Clinica C	2024-04-11
C0317	F	45	11.00	107.7	Cronica	Amazonia	Centro B	2024-03-13
C0318	M	25	14.90	93.8	Global	Amazonia	Centro B	2024-05-14
C0319	F	36	9.20	106.4	Global	Sierra	Centro B	2024-06-28
C0320	M	42	13.60	75.9	Cronica	Sierra	Hospital A	2023-05-20
C0321	F	8	8.40	94.3	Cronica	Sierra	Clinica C	2025-04-28
C0322	F	53	11.00	66.1	Global	Sierra	Clinica C	2024-05-28
C0323	F	14	6.00	95.7	Aguda	Costa	Hospital A	2025-04-06
C0324	M	46	7.60	60.5	Cronica	Amazonia	Centro B	2024-01-01
C0325	M	49	14.90	55.3	Global	Costa	Centro B	2023-06-07
C0326	F	36	13.30	96.6	Cronica	Sierra	Centro B	2025-01-14
C0327	M	55	5.70	86.6	Global	Amazonia	Clinica C	2023-12-27
C0328	M	17	10.10	101.1	Aguda	Sierra	Centro B	2024-08-23
C0329	M	53	17.50	105.9	Aguda	Costa	Centro B	2024-03-11
C0330	M	27	8.30	109.4	Global	Amazonia	Centro B	2024-09-01
C0331	M	38	10.80	65.6	Aguda	Sierra	Hospital A	2025-01-25
C0332	F	47	8.00	65.2	Global	Sierra	Centro B	2023-10-28
C0333	M	17	12.70	90.1	Cronica	Sierra	Clinica C	2024-11-11
C0334	F	11	9.90	60.2	Aguda	Sierra	Centro B	2024-11-26
C0335	M	6	8.00	68.0	Cronica	Sierra	Centro B	2024-10-25
C0336	M	22	13.30	93.1	Aguda	Amazonia	Hospital A	2023-09-26
C0337	F	25	6.70	92.7	Global	Sierra	Clinica C	2024-06-07
C0338	M	46	16.90	71.2	Global	Costa	Hospital A	2024-01-11
C0339	M	36	6.60	96.1	Global	Sierra	Centro B	2023-09-19
C0340	F	54	11.80	91.5	Aguda	Costa	Clinica C	2023-12-13
C0341	M	39	10.50	93.7	Aguda	Amazonia	Hospital A	2024-09-29
C0342	M	59	11.90	82.8	Global	Amazonia	Hospital A	2023-09-23
C0343	M	26	16.00	79.3	Global	Costa	Clinica C	2023-06-19
C0344	F	11	16.60	79.5	Aguda	Sierra	Hospital A	2024-04-29
C0345	F	35	12.10	85.7	Global	Sierra	Clinica C	2023-06-24
C0346	M	31	7.90	55.2	Aguda	Amazonia	Hospital A	2024-07-04
C0347	M	33	9.20	58.5	Aguda	Costa	Centro B	2025-01-03
C0348	M	24	10.00	97.3	Global	Amazonia	Clinica C	2025-02-25
C0349	F	29	17.90	76.0	Cronica	Sierra	Hospital A	2025-01-24
C0350	M	47	16.10	61.5	Global	Sierra	Clinica C	2024-12-06
C0351	M	52	17.70	100.9	Aguda	Sierra	Centro B	2023-12-15
C0352	F	40	9.60	67.6	Cronica	Sierra	Hospital A	2023-07-21
C0353	F	18	17.20	94.9	Aguda	Costa	Clinica C	2024-06-01
C0354	F	45	14.80	103.6	Aguda	Costa	Hospital A	2025-03-24
C0355	M	12	12.50	79.6	Global	Amazonia	Hospital A	2023-10-18
C0356	M	53	5.10	79.1	Global	Costa	Hospital A	2023-08-26
C0357	M	38	17.90	67.9	Global	Amazonia	Centro B	2024-02-13
C0358	F	21	8.60	62.9	Global	Amazonia	Hospital A	2024-11-26
C0359	F	25	8.20	85.6	Global	Amazonia	Hospital A	2024-09-25
C0360	F	41	11.20	108.5	Global	Amazonia	Centro B	2023-10-25
C0361	F	50	10.10	63.2	Cronica	Costa	Clinica C	2024-06-28
C0362	F	21	16.00	71.5	Global	Costa	Centro B	2023-09-29
C0363	M	41	10.10	77.9	Global	Costa	Centro B	2024-06-20
C0364	M	22	7.20	90.6	Cronica	Sierra	Hospital A	2024-04-22
C0365	M	9	8.10	92.1	Global	Costa	Hospital A	2023-05-31
C0366	M	57	14.80	94.8	Global	Costa	Centro B	2024-11-14
C0367	M	27	8.60	105.0	Aguda	Costa	Clinica C	2024-02-25
C0368	M	53	18.00	81.3	Aguda	Amazonia	Clinica C	2024-02-08
C0369	M	31	16.90	85.4	Cronica	Sierra	Centro B	2024-02-11
C0370	F	25	8.00	83.2	Cronica	Sierra	Hospital A	2024-08-08
C0371	F	54	15.80	105.3	Cronica	Sierra	Centro B	2023-07-07
C0372	M	42	16.20	95.8	Aguda	Sierra	Clinica C	2024-04-05
C0373	F	24	6.60	73.1	Cronica	Amazonia	Hospital A	2025-01-28
C0374	F	41	13.30	92.7	Cronica	Sierra	Clinica C	2024-03-24
C0375	F	35	6.80	98.7	Aguda	Costa	Clinica C	2023-09-06
C0376	F	17	16.90	84.8	Global	Costa	Clinica C	2023-07-28
C0377	M	59	15.90	107.0	Global	Costa	Hospital A	2024-02-28
C0378	F	14	15.90	67.7	Global	Costa	Hospital A	2023-11-20
C0379	M	38	10.70	58.3	Global	Amazonia	Clinica C	2024-12-27
C0380	F	48	11.10	55.4	Global	Sierra	Hospital A	2023-07-09
C0381	M	39	14.20	84.5	Cronica	Costa	Clinica C	2024-09-30
C0382	F	57	17.20	64.9	Aguda	Amazonia	Hospital A	2024-09-28
C0383	M	18	12.90	68.9	Cronica	Sierra	Centro B	2023-09-16
C0384	M	29	17.50	80.2	Aguda	Amazonia	Hospital A	2024-03-28
C0385	F	49	15.70	59.4	Global	Costa	Hospital A	2025-04-01
C0386	F	30	9.60	81.2	Global	Costa	Clinica C	2024-07-03
C0387	M	11	11.20	78.9	Cronica	Amazonia	Hospital A	2023-07-24
C0388	M	20	7.40	102.7	Global	Sierra	Centro B	2024-01-04
C0389	M	10	13.70	70.4	Global	Amazonia	Clinica C	2025-02-17
C0390	M	17	17.00	72.3	Aguda	Amazonia	Hospital A	2023-05-18
C0391	F	10	8.50	86.0	Global	Sierra	Clinica C	2023-05-24
C0392	F	30	14.70	62.7	Global	Amazonia	Hospital A	2025-03-28
C0393	F	9	5.80	67.8	Aguda	Sierra	Clinica C	2024-04-12
C0394	F	55	8.90	89.9	Cronica	Sierra	Hospital A	2024-01-16
C0395	F	41	17.20	78.8	Global	Amazonia	Clinica C	2025-03-11
C0396	F	11	14.90	71.2	Aguda	Amazonia	Hospital A	2025-04-29
C0397	M	23	6.60	94.1	Global	Costa	Clinica C	2024-07-11
C0398	F	26	9.40	60.0	Cronica	Sierra	Centro B	2024-03-30
C0399	F	12	6.30	65.3	Cronica	Amazonia	Clinica C	2025-04-05
C0400	F	12	4.90	74.5	Aguda	Amazonia	Clinica C	2024-03-01
C0401	F	30	4.70	77.8	Aguda	Amazonia	Clinica C	2023-07-21
C0402	M	42	11.50	92.7	Aguda	Costa	Centro B	2024-04-11
C0403	F	23	11.20	58.5	Cronica	Sierra	Centro B	2024-12-10
C0404	F	36	15.10	74.9	Aguda	Amazonia	Clinica C	2023-12-17
C0405	F	44	12.80	80.2	Aguda	Sierra	Hospital A	2024-02-07
C0406	F	27	15.90	75.9	Cronica	Sierra	Centro B	2025-01-17
C0407	F	58	15.60	90.8	Global	Costa	Centro B	2023-05-26
C0408	F	44	17.30	66.0	Cronica	Costa	Centro B	2023-05-20
C0409	F	24	14.40	89.8	Global	Costa	Centro B	2024-10-16
C0410	F	23	15.50	76.6	Aguda	Amazonia	Hospital A	2024-05-31
C0411	M	49	14.90	56.5	Global	Sierra	Clinica C	2023-12-22
C0412	M	34	15.30	100.7	Aguda	Sierra	Clinica C	2023-09-03
C0413	F	14	13.10	68.3	Global	Costa	Clinica C	2023-11-30
C0414	F	56	9.60	79.7	Global	Sierra	Clinica C	2024-03-18
C0415	F	40	11.30	105.6	Global	Sierra	Clinica C	2024-02-04
C0416	M	56	17.60	93.6	Global	Amazonia	Clinica C	2024-10-19
C0417	M	12	14.90	91.2	Cronica	Costa	Clinica C	2023-11-29
C0418	M	42	17.80	92.3	Cronica	Sierra	Centro B	2023-06-08
C0419	M	6	5.80	67.2	Global	Amazonia	Clinica C	2024-05-05
C0420	M	34	9.60	80.5	Global	Amazonia	Clinica C	2024-05-28
C0421	M	28	18.00	81.6	Cronica	Sierra	Hospital A	2023-07-20
C0422	M	59	17.20	62.8	Cronica	Sierra	Centro B	2023-09-04
C0423	M	39	11.00	81.2	Cronica	Amazonia	Clinica C	2024-03-15
C0424	F	26	5.40	57.5	Global	Costa	Hospital A	2023-12-04
C0425	F	47	6.00	99.0	Global	Costa	Clinica C	2024-03-30
C0426	M	41	6.70	85.8	Cronica	Costa	Centro B	2024-01-20
C0427	M	17	13.10	78.8	Aguda	Amazonia	Clinica C	2024-05-03
C0428	M	34	12.50	76.4	Global	Costa	Hospital A	2024-08-08
C0429	F	54	14.00	98.8	Global	Costa	Clinica C	2024-07-16
C0430	M	29	8.90	80.2	Cronica	Amazonia	Centro B	2024-03-15
C0431	F	44	9.70	76.6	Aguda	Sierra	Centro B	2025-03-24
C0432	F	45	6.80	92.0	Cronica	Amazonia	Clinica C	2025-02-06
C0433	M	49	6.30	61.5	Cronica	Costa	Hospital A	2024-10-26
C0434	F	50	6.40	76.4	Global	Costa	Clinica C	2023-07-31
C0435	F	33	7.00	90.0	Global	Amazonia	Hospital A	2024-03-27
C0436	M	37	8.40	65.3	Cronica	Amazonia	Hospital A	2025-01-21
C0437	F	6	11.00	65.7	Cronica	Amazonia	Clinica C	2023-11-20
C0438	F	32	13.70	77.9	Cronica	Sierra	Hospital A	2024-10-08
C0439	M	42	4.90	96.9	Cronica	Costa	Centro B	2025-01-29
C0440	M	40	8.40	97.9	Global	Amazonia	Centro B	2023-11-07
C0441	M	42	6.00	97.6	Cronica	Amazonia	Hospital A	2023-07-31
C0442	F	40	7.50	78.4	Global	Amazonia	Hospital A	2024-01-23
C0443	F	8	10.60	74.2	Aguda	Sierra	Hospital A	2024-03-08
C0444	M	19	15.40	87.3	Cronica	Amazonia	Clinica C	2025-01-19
C0445	F	16	12.80	98.2	Aguda	Costa	Clinica C	2023-09-18
C0446	F	40	8.30	84.6	Cronica	Amazonia	Centro B	2024-09-08
C0447	F	42	8.10	102.2	Global	Costa	Hospital A	2024-07-14
C0448	F	9	17.90	102.7	Aguda	Amazonia	Hospital A	2023-09-12
C0449	M	15	14.10	100.6	Global	Sierra	Centro B	2024-08-10
C0450	M	42	13.00	89.5	Cronica	Sierra	Hospital A	2024-09-07
C0451	M	31	11.50	70.3	Cronica	Sierra	Centro B	2023-11-02
C0452	F	43	4.50	97.6	Global	Costa	Clinica C	2024-02-07
C0453	F	46	13.50	74.7	Aguda	Amazonia	Centro B	2025-05-05
C0454	M	33	15.60	82.2	Cronica	Sierra	Centro B	2024-07-01
C0455	M	42	16.00	98.4	Global	Costa	Hospital A	2023-08-25
C0456	M	46	15.10	80.3	Aguda	Costa	Centro B	2025-01-19
C0457	F	6	17.90	78.5	Global	Costa	Clinica C	2023-11-14
C0458	F	16	16.30	103.2	Aguda	Amazonia	Centro B	2023-09-23
C0459	F	11	9.50	104.7	Aguda	Costa	Centro B	2025-04-13
C0460	F	52	13.90	67.9	Global	Costa	Clinica C	2023-08-17
C0461	M	6	7.40	59.3	Global	Costa	Clinica C	2023-11-25
C0462	F	6	4.60	73.9	Aguda	Sierra	Clinica C	2024-04-21
C0463	M	36	5.50	76.1	Global	Costa	Hospital A	2024-05-29
C0464	F	29	16.40	62.5	Aguda	Amazonia	Clinica C	2023-09-25
C0465	M	10	11.70	55.5	Global	Costa	Centro B	2023-08-17
C0466	F	52	7.40	96.2	Cronica	Amazonia	Clinica C	2024-05-01
C0467	F	19	5.70	60.5	Aguda	Amazonia	Clinica C	2025-05-10
C0468	F	28	17.50	72.3	Aguda	Costa	Centro B	2023-09-13
C0469	M	21	12.00	88.0	Global	Sierra	Clinica C	2024-11-20
C0470	M	48	16.30	66.3	Global	Amazonia	Hospital A	2023-11-23
C0471	F	24	13.20	98.1	Aguda	Sierra	Centro B	2024-11-27
C0472	M	21	11.20	87.7	Global	Costa	Centro B	2023-10-06
C0473	F	14	9.70	101.1	Cronica	Sierra	Clinica C	2024-02-27
C0474	M	54	10.90	109.3	Aguda	Costa	Clinica C	2023-12-10
C0475	M	6	8.00	57.2	Aguda	Sierra	Clinica C	2025-02-09
C0476	F	46	14.10	97.2	Cronica	Amazonia	Centro B	2025-04-12
C0477	M	46	11.70	88.9	Cronica	Costa	Centro B	2024-01-25
C0478	M	38	16.90	108.6	Aguda	Amazonia	Centro B	2024-01-29
C0479	F	43	13.10	100.9	Global	Amazonia	Hospital A	2024-06-29
C0480	F	50	10.40	107.4	Aguda	Costa	Hospital A	2024-01-04
C0481	M	33	6.10	88.7	Aguda	Sierra	Clinica C	2024-09-04
C0482	M	13	4.70	62.5	Aguda	Costa	Centro B	2023-11-20
C0483	F	39	11.50	100.2	Cronica	Costa	Centro B	2025-03-06
C0484	M	53	15.00	69.8	Aguda	Costa	Centro B	2024-10-29
C0485	F	23	11.60	69.5	Global	Amazonia	Hospital A	2024-05-27
C0486	F	35	11.40	58.0	Global	Costa	Centro B	2024-07-21
C0487	M	22	14.90	104.2	Global	Amazonia	Hospital A	2025-03-28
C0488	M	53	11.40	57.4	Aguda	Costa	Hospital A	2025-02-26
C0489	F	29	9.70	63.3	Aguda	Amazonia	Clinica C	2024-02-07
C0490	F	20	8.80	77.9	Global	Sierra	Centro B	2023-11-03
C0491	M	42	9.50	82.6	Aguda	Costa	Hospital A	2024-08-07
C0492	M	31	5.40	80.6	Cronica	Sierra	Centro B	2023-09-20
C0493	M	41	10.70	75.3	Cronica	Amazonia	Centro B	2024-04-25
C0494	M	35	9.50	108.5	Aguda	Amazonia	Clinica C	2024-06-29
C0495	M	15	4.60	77.6	Aguda	Amazonia	Centro B	2023-06-17
C0496	M	27	4.50	91.2	Global	Amazonia	Centro B	2024-12-22
C0497	M	19	11.70	68.1	Cronica	Costa	Hospital A	2024-06-16
C0498	F	11	5.10	67.7	Global	Sierra	Clinica C	2025-04-26
C0499	F	35	17.70	59.7	Aguda	Amazonia	Hospital A	2023-11-03
C0500	F	10	12.50	58.4	Global	Costa	Hospital A	2023-07-30
\.


--
-- TOC entry 4945 (class 0 OID 24930)
-- Dependencies: 220
-- Data for Name: dim_child; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_child (child_id, gender, age_months, age_group) FROM stdin;
C0015	F	31	24-35
C0493	M	41	36-47
C0239	M	16	12-23
C0056	F	29	24-35
C0253	M	13	12-23
C0309	M	32	24-35
C0305	F	38	36-47
C0497	M	19	12-23
C0224	M	28	24-35
C0186	M	14	12-23
C0258	M	55	48-59
C0248	M	7	0-11
C0173	M	47	36-47
C0058	M	21	12-23
C0433	M	49	48-59
C0180	M	13	12-23
C0359	F	25	24-35
C0446	F	40	36-47
C0314	F	53	48-59
C0195	F	52	48-59
C0267	F	12	12-23
C0069	F	50	48-59
C0413	F	14	12-23
C0380	F	48	48-59
C0422	M	59	48-59
C0360	F	41	36-47
C0048	M	29	24-35
C0326	F	36	36-47
C0386	F	30	24-35
C0382	F	57	48-59
C0119	M	41	36-47
C0255	F	17	12-23
C0144	F	52	48-59
C0303	F	58	48-59
C0453	F	46	36-47
C0404	F	36	36-47
C0202	M	44	36-47
C0319	F	36	36-47
C0331	M	38	36-47
C0278	F	51	48-59
C0294	F	31	24-35
C0478	M	38	36-47
C0460	F	52	48-59
C0375	F	35	24-35
C0398	F	26	24-35
C0411	M	49	48-59
C0045	F	19	12-23
C0104	F	34	24-35
C0408	F	44	36-47
C0036	F	14	12-23
C0274	F	21	12-23
C0146	F	18	12-23
C0464	F	29	24-35
C0089	M	31	24-35
C0164	F	20	12-23
C0377	M	59	48-59
C0076	F	37	36-47
C0463	M	36	36-47
C0002	M	43	36-47
C0030	M	6	0-11
C0237	M	10	0-11
C0270	F	29	24-35
C0498	F	11	0-11
C0027	F	19	12-23
C0073	M	24	24-35
C0217	F	12	12-23
C0287	F	45	36-47
C0304	F	29	24-35
C0044	M	45	36-47
C0346	M	31	24-35
C0252	M	25	24-35
C0010	M	29	24-35
C0487	M	22	12-23
C0055	M	59	48-59
C0011	M	44	36-47
C0191	M	10	0-11
C0037	M	9	0-11
C0016	M	53	48-59
C0316	F	40	36-47
C0489	F	29	24-35
C0477	M	46	36-47
C0406	F	27	24-35
C0123	M	32	24-35
C0120	F	34	24-35
C0212	M	37	36-47
C0128	M	35	24-35
C0229	F	34	24-35
C0106	F	27	24-35
C0263	F	55	48-59
C0339	M	36	36-47
C0438	F	32	24-35
C0150	M	10	0-11
C0444	M	19	12-23
C0008	F	42	36-47
C0286	F	11	0-11
C0458	F	16	12-23
C0145	F	40	36-47
C0280	F	7	0-11
C0046	F	35	24-35
C0099	M	56	48-59
C0140	M	47	36-47
C0096	M	55	48-59
C0181	M	9	0-11
C0300	F	24	24-35
C0434	F	50	48-59
C0156	F	15	12-23
C0308	F	51	48-59
C0138	F	13	12-23
C0193	F	12	12-23
C0009	M	20	12-23
C0277	F	17	12-23
C0347	M	33	24-35
C0114	M	51	48-59
C0455	M	42	36-47
C0026	M	14	12-23
C0005	F	23	12-23
C0079	F	54	48-59
C0273	F	54	48-59
C0372	M	42	36-47
C0047	M	10	0-11
C0499	F	35	24-35
C0194	M	33	24-35
C0227	M	26	24-35
C0012	F	23	12-23
C0029	M	21	12-23
C0355	M	12	12-23
C0082	M	51	48-59
C0336	M	22	12-23
C0049	M	48	48-59
C0110	F	33	24-35
C0219	M	39	36-47
C0370	F	25	24-35
C0143	F	55	48-59
C0492	M	31	24-35
C0264	F	31	24-35
C0344	F	11	0-11
C0204	M	42	36-47
C0246	F	11	0-11
C0147	M	26	24-35
C0185	F	56	48-59
C0340	F	54	48-59
C0479	F	43	36-47
C0420	M	34	24-35
C0432	F	45	36-47
C0354	F	45	36-47
C0381	M	39	36-47
C0390	M	17	12-23
C0216	M	57	48-59
C0292	F	10	0-11
C0427	M	17	12-23
C0256	M	30	24-35
C0232	M	27	24-35
C0061	M	18	12-23
C0283	M	34	24-35
C0196	M	49	48-59
C0321	F	8	0-11
C0481	M	33	24-35
C0449	M	15	12-23
C0105	F	7	0-11
C0451	M	31	24-35
C0328	M	17	12-23
C0209	M	28	24-35
C0269	F	23	12-23
C0126	M	47	36-47
C0070	M	45	36-47
C0490	F	20	12-23
C0468	F	28	24-35
C0139	F	41	36-47
C0021	F	13	12-23
C0310	M	44	36-47
C0103	F	33	24-35
C0188	M	52	48-59
C0151	F	47	36-47
C0318	M	25	24-35
C0349	F	29	24-35
C0067	M	29	24-35
C0307	M	31	24-35
C0466	F	52	48-59
C0095	M	35	24-35
C0190	F	51	48-59
C0445	F	16	12-23
C0376	F	17	12-23
C0241	F	54	48-59
C0169	F	57	48-59
C0399	F	12	12-23
C0157	M	11	0-11
C0107	M	11	0-11
C0003	M	41	36-47
C0265	F	50	48-59
C0447	F	42	36-47
C0402	M	42	36-47
C0337	F	25	24-35
C0266	F	11	0-11
C0022	F	38	36-47
C0102	M	52	48-59
C0013	F	59	48-59
C0383	M	18	12-23
C0108	F	47	36-47
C0218	F	53	48-59
C0077	F	20	12-23
C0154	F	12	12-23
C0426	M	41	36-47
C0109	M	31	24-35
C0233	F	14	12-23
C0050	F	13	12-23
C0405	F	44	36-47
C0064	M	43	36-47
C0442	F	40	36-47
C0072	F	49	48-59
C0158	M	20	12-23
C0203	F	50	48-59
C0042	M	9	0-11
C0362	F	21	12-23
C0259	F	58	48-59
C0028	F	31	24-35
C0187	F	55	48-59
C0065	F	52	48-59
C0368	M	53	48-59
C0322	F	53	48-59
C0159	F	24	24-35
C0474	M	54	48-59
C0174	F	13	12-23
C0486	F	35	24-35
C0356	M	53	48-59
C0118	M	15	12-23
C0167	F	17	12-23
C0385	F	49	48-59
C0288	M	16	12-23
C0111	F	25	24-35
C0074	F	20	12-23
C0275	F	41	36-47
C0234	F	58	48-59
C0053	F	55	48-59
C0476	F	46	36-47
C0129	F	34	24-35
C0282	F	55	48-59
C0166	M	43	36-47
C0038	M	32	24-35
C0094	M	45	36-47
C0452	F	43	36-47
C0448	F	9	0-11
C0035	F	52	48-59
C0430	M	29	24-35
C0441	M	42	36-47
C0473	F	14	12-23
C0040	F	15	12-23
C0439	M	42	36-47
C0245	M	24	24-35
C0423	M	39	36-47
C0342	M	59	48-59
C0471	F	24	24-35
C0101	F	29	24-35
C0454	M	33	24-35
C0472	M	21	12-23
C0236	M	19	12-23
C0060	M	23	12-23
C0177	F	45	36-47
C0137	F	54	48-59
C0281	M	10	0-11
C0289	M	58	48-59
C0475	M	6	0-11
C0412	M	34	24-35
C0391	F	10	0-11
C0228	F	51	48-59
C0221	M	17	12-23
C0298	F	37	36-47
C0262	F	58	48-59
C0325	M	49	48-59
C0293	M	27	24-35
C0335	M	6	0-11
C0320	M	42	36-47
C0424	F	26	24-35
C0271	F	8	0-11
C0160	F	46	36-47
C0443	F	8	0-11
C0302	M	29	24-35
C0333	M	17	12-23
C0351	M	52	48-59
C0330	M	27	24-35
C0068	M	52	48-59
C0374	F	41	36-47
C0484	M	53	48-59
C0366	M	57	48-59
C0480	F	50	48-59
C0327	M	55	48-59
C0261	F	18	12-23
C0425	F	47	36-47
C0136	F	32	24-35
C0149	F	12	12-23
C0051	M	51	48-59
C0090	M	35	24-35
C0135	F	11	0-11
C0085	F	55	48-59
C0358	F	21	12-23
C0247	F	9	0-11
C0393	F	9	0-11
C0155	F	7	0-11
C0301	F	54	48-59
C0130	F	7	0-11
C0031	F	10	0-11
C0242	F	59	48-59
C0469	M	21	12-23
C0199	M	24	24-35
C0415	F	40	36-47
C0075	M	35	24-35
C0461	M	6	0-11
C0467	F	19	12-23
C0363	M	41	36-47
C0400	F	12	12-23
C0332	F	47	36-47
C0482	M	13	12-23
C0052	F	9	0-11
C0054	F	41	36-47
C0018	M	13	12-23
C0435	F	33	24-35
C0124	F	51	48-59
C0133	F	28	24-35
C0279	M	56	48-59
C0178	M	34	24-35
C0091	F	27	24-35
C0078	M	13	12-23
C0272	F	42	36-47
C0496	M	27	24-35
C0222	F	49	48-59
C0428	M	34	24-35
C0417	M	12	12-23
C0020	M	49	48-59
C0088	F	52	48-59
C0416	M	56	48-59
C0080	F	16	12-23
C0414	F	56	48-59
C0329	M	53	48-59
C0063	F	49	48-59
C0500	F	10	0-11
C0418	M	42	36-47
C0396	F	11	0-11
C0210	F	8	0-11
C0032	M	52	48-59
C0284	M	55	48-59
C0257	M	28	24-35
C0189	M	9	0-11
C0023	M	15	12-23
C0429	F	54	48-59
C0172	F	12	12-23
C0117	M	58	48-59
C0197	M	53	48-59
C0131	F	42	36-47
C0395	F	41	36-47
C0043	M	49	48-59
C0170	F	57	48-59
C0450	M	42	36-47
C0291	F	47	36-47
C0249	M	14	12-23
C0353	F	18	12-23
C0066	M	22	12-23
C0006	F	12	12-23
C0437	F	6	0-11
C0162	F	7	0-11
C0087	M	37	36-47
C0470	M	48	48-59
C0378	F	14	12-23
C0388	M	20	12-23
C0409	F	24	24-35
C0389	M	10	0-11
C0494	M	35	24-35
C0207	M	15	12-23
C0324	M	46	36-47
C0034	F	52	48-59
C0457	F	6	0-11
C0125	F	56	48-59
C0141	F	32	24-35
C0323	F	14	12-23
C0290	M	55	48-59
C0171	M	35	24-35
C0192	F	30	24-35
C0251	M	41	36-47
C0410	F	23	12-23
C0296	F	30	24-35
C0352	F	40	36-47
C0163	M	44	36-47
C0276	F	50	48-59
C0014	F	10	0-11
C0083	M	15	12-23
C0220	M	21	12-23
C0039	F	6	0-11
C0397	M	23	12-23
C0312	M	58	48-59
C0121	M	45	36-47
C0341	M	39	36-47
C0198	F	48	48-59
C0132	F	23	12-23
C0488	M	53	48-59
C0206	F	25	24-35
C0315	F	48	48-59
C0225	F	59	48-59
C0268	F	16	12-23
C0183	M	56	48-59
C0086	M	28	24-35
C0394	F	55	48-59
C0299	M	43	36-47
C0004	F	43	36-47
C0313	M	34	24-35
C0295	M	35	24-35
C0001	M	7	0-11
C0343	M	26	24-35
C0112	M	18	12-23
C0142	M	30	24-35
C0168	F	59	48-59
C0175	M	21	12-23
C0115	M	46	36-47
C0244	M	22	12-23
C0116	F	36	36-47
C0230	F	32	24-35
C0208	F	48	48-59
C0152	F	46	36-47
C0379	M	38	36-47
C0456	M	46	36-47
C0148	M	37	36-47
C0098	M	43	36-47
C0373	F	24	24-35
C0025	M	42	36-47
C0367	M	27	24-35
C0491	M	42	36-47
C0059	M	53	48-59
C0485	F	23	12-23
C0440	M	40	36-47
C0184	F	57	48-59
C0081	F	55	48-59
C0238	M	48	48-59
C0213	M	38	36-47
C0084	F	32	24-35
C0100	F	10	0-11
C0364	M	22	12-23
C0334	F	11	0-11
C0371	F	54	48-59
C0007	F	40	36-47
C0240	F	8	0-11
C0200	M	48	48-59
C0041	M	53	48-59
C0024	F	37	36-47
C0033	F	18	12-23
C0243	F	55	48-59
C0250	F	34	24-35
C0231	F	10	0-11
C0465	M	10	0-11
C0401	F	30	24-35
C0017	F	29	24-35
C0392	F	30	24-35
C0285	M	25	24-35
C0161	F	36	36-47
C0338	M	46	36-47
C0182	M	59	48-59
C0311	M	43	36-47
C0092	F	7	0-11
C0176	F	43	36-47
C0350	M	47	36-47
C0297	F	18	12-23
C0226	F	35	24-35
C0436	M	37	36-47
C0462	F	6	0-11
C0361	F	50	48-59
C0205	M	53	48-59
C0057	M	48	48-59
C0495	M	15	12-23
C0260	F	46	36-47
C0407	F	58	48-59
C0483	F	39	36-47
C0345	F	35	24-35
C0113	F	12	12-23
C0062	M	48	48-59
C0201	M	54	48-59
C0153	M	21	12-23
C0384	M	29	24-35
C0093	M	55	48-59
C0211	F	19	12-23
C0431	F	44	36-47
C0348	M	24	24-35
C0223	F	15	12-23
C0127	M	56	48-59
C0459	F	11	0-11
C0134	F	50	48-59
C0122	F	48	48-59
C0179	F	40	36-47
C0419	M	6	0-11
C0254	M	51	48-59
C0387	M	11	0-11
C0365	M	9	0-11
C0357	M	38	36-47
C0071	M	33	24-35
C0097	F	42	36-47
C0019	M	30	24-35
C0369	M	31	24-35
C0214	M	33	24-35
C0403	F	23	12-23
C0306	F	15	12-23
C0317	F	45	36-47
C0215	F	51	48-59
C0421	M	28	24-35
C0235	M	47	36-47
C0165	M	46	36-47
\.


--
-- TOC entry 4944 (class 0 OID 24920)
-- Dependencies: 219
-- Data for Name: dim_date; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_date (date_id, date_measured, year, month, day) FROM stdin;
1	2023-05-15	2023	5	15
2	2023-05-17	2023	5	17
3	2023-05-18	2023	5	18
4	2023-05-20	2023	5	20
5	2023-05-21	2023	5	21
6	2023-05-24	2023	5	24
7	2023-05-25	2023	5	25
8	2023-05-26	2023	5	26
9	2023-05-28	2023	5	28
10	2023-05-30	2023	5	30
11	2023-05-31	2023	5	31
12	2023-06-02	2023	6	2
13	2023-06-07	2023	6	7
14	2023-06-08	2023	6	8
15	2023-06-13	2023	6	13
16	2023-06-14	2023	6	14
17	2023-06-17	2023	6	17
18	2023-06-19	2023	6	19
19	2023-06-24	2023	6	24
20	2023-06-25	2023	6	25
21	2023-06-28	2023	6	28
22	2023-07-07	2023	7	7
23	2023-07-09	2023	7	9
24	2023-07-11	2023	7	11
25	2023-07-15	2023	7	15
26	2023-07-17	2023	7	17
27	2023-07-20	2023	7	20
28	2023-07-21	2023	7	21
29	2023-07-24	2023	7	24
30	2023-07-25	2023	7	25
31	2023-07-28	2023	7	28
32	2023-07-29	2023	7	29
33	2023-07-30	2023	7	30
34	2023-07-31	2023	7	31
35	2023-08-03	2023	8	3
36	2023-08-04	2023	8	4
37	2023-08-10	2023	8	10
38	2023-08-17	2023	8	17
39	2023-08-22	2023	8	22
40	2023-08-23	2023	8	23
41	2023-08-25	2023	8	25
42	2023-08-26	2023	8	26
43	2023-08-28	2023	8	28
44	2023-08-29	2023	8	29
45	2023-08-30	2023	8	30
46	2023-09-03	2023	9	3
47	2023-09-04	2023	9	4
48	2023-09-06	2023	9	6
49	2023-09-08	2023	9	8
50	2023-09-09	2023	9	9
51	2023-09-11	2023	9	11
52	2023-09-12	2023	9	12
53	2023-09-13	2023	9	13
54	2023-09-15	2023	9	15
55	2023-09-16	2023	9	16
56	2023-09-17	2023	9	17
57	2023-09-18	2023	9	18
58	2023-09-19	2023	9	19
59	2023-09-20	2023	9	20
60	2023-09-21	2023	9	21
61	2023-09-22	2023	9	22
62	2023-09-23	2023	9	23
63	2023-09-25	2023	9	25
64	2023-09-26	2023	9	26
65	2023-09-27	2023	9	27
66	2023-09-29	2023	9	29
67	2023-10-03	2023	10	3
68	2023-10-05	2023	10	5
69	2023-10-06	2023	10	6
70	2023-10-07	2023	10	7
71	2023-10-08	2023	10	8
72	2023-10-10	2023	10	10
73	2023-10-13	2023	10	13
74	2023-10-14	2023	10	14
75	2023-10-18	2023	10	18
76	2023-10-23	2023	10	23
77	2023-10-24	2023	10	24
78	2023-10-25	2023	10	25
79	2023-10-28	2023	10	28
80	2023-11-02	2023	11	2
81	2023-11-03	2023	11	3
82	2023-11-07	2023	11	7
83	2023-11-08	2023	11	8
84	2023-11-09	2023	11	9
85	2023-11-14	2023	11	14
86	2023-11-16	2023	11	16
87	2023-11-17	2023	11	17
88	2023-11-20	2023	11	20
89	2023-11-23	2023	11	23
90	2023-11-25	2023	11	25
91	2023-11-28	2023	11	28
92	2023-11-29	2023	11	29
93	2023-11-30	2023	11	30
94	2023-12-01	2023	12	1
95	2023-12-02	2023	12	2
96	2023-12-04	2023	12	4
97	2023-12-10	2023	12	10
98	2023-12-11	2023	12	11
99	2023-12-13	2023	12	13
100	2023-12-15	2023	12	15
101	2023-12-17	2023	12	17
102	2023-12-22	2023	12	22
103	2023-12-23	2023	12	23
104	2023-12-25	2023	12	25
105	2023-12-26	2023	12	26
106	2023-12-27	2023	12	27
107	2023-12-30	2023	12	30
108	2024-01-01	2024	1	1
109	2024-01-04	2024	1	4
110	2024-01-05	2024	1	5
111	2024-01-07	2024	1	7
112	2024-01-10	2024	1	10
113	2024-01-11	2024	1	11
114	2024-01-13	2024	1	13
115	2024-01-16	2024	1	16
116	2024-01-18	2024	1	18
117	2024-01-20	2024	1	20
118	2024-01-21	2024	1	21
119	2024-01-22	2024	1	22
120	2024-01-23	2024	1	23
121	2024-01-25	2024	1	25
122	2024-01-29	2024	1	29
123	2024-02-04	2024	2	4
124	2024-02-06	2024	2	6
125	2024-02-07	2024	2	7
126	2024-02-08	2024	2	8
127	2024-02-11	2024	2	11
128	2024-02-12	2024	2	12
129	2024-02-13	2024	2	13
130	2024-02-17	2024	2	17
131	2024-02-22	2024	2	22
132	2024-02-23	2024	2	23
133	2024-02-24	2024	2	24
134	2024-02-25	2024	2	25
135	2024-02-26	2024	2	26
136	2024-02-27	2024	2	27
137	2024-02-28	2024	2	28
138	2024-03-01	2024	3	1
139	2024-03-03	2024	3	3
140	2024-03-07	2024	3	7
141	2024-03-08	2024	3	8
142	2024-03-11	2024	3	11
143	2024-03-13	2024	3	13
144	2024-03-15	2024	3	15
145	2024-03-18	2024	3	18
146	2024-03-19	2024	3	19
147	2024-03-24	2024	3	24
148	2024-03-25	2024	3	25
149	2024-03-26	2024	3	26
150	2024-03-27	2024	3	27
151	2024-03-28	2024	3	28
152	2024-03-30	2024	3	30
153	2024-04-01	2024	4	1
154	2024-04-02	2024	4	2
155	2024-04-05	2024	4	5
156	2024-04-10	2024	4	10
157	2024-04-11	2024	4	11
158	2024-04-12	2024	4	12
159	2024-04-16	2024	4	16
160	2024-04-17	2024	4	17
161	2024-04-21	2024	4	21
162	2024-04-22	2024	4	22
163	2024-04-25	2024	4	25
164	2024-04-27	2024	4	27
165	2024-04-28	2024	4	28
166	2024-04-29	2024	4	29
167	2024-05-01	2024	5	1
168	2024-05-03	2024	5	3
169	2024-05-04	2024	5	4
170	2024-05-05	2024	5	5
171	2024-05-07	2024	5	7
172	2024-05-08	2024	5	8
173	2024-05-14	2024	5	14
174	2024-05-19	2024	5	19
175	2024-05-20	2024	5	20
176	2024-05-23	2024	5	23
177	2024-05-24	2024	5	24
178	2024-05-26	2024	5	26
179	2024-05-27	2024	5	27
180	2024-05-28	2024	5	28
181	2024-05-29	2024	5	29
182	2024-05-31	2024	5	31
183	2024-06-01	2024	6	1
184	2024-06-03	2024	6	3
185	2024-06-07	2024	6	7
186	2024-06-09	2024	6	9
187	2024-06-10	2024	6	10
188	2024-06-11	2024	6	11
189	2024-06-15	2024	6	15
190	2024-06-16	2024	6	16
191	2024-06-18	2024	6	18
192	2024-06-20	2024	6	20
193	2024-06-22	2024	6	22
194	2024-06-23	2024	6	23
195	2024-06-24	2024	6	24
196	2024-06-27	2024	6	27
197	2024-06-28	2024	6	28
198	2024-06-29	2024	6	29
199	2024-07-01	2024	7	1
200	2024-07-03	2024	7	3
201	2024-07-04	2024	7	4
202	2024-07-06	2024	7	6
203	2024-07-09	2024	7	9
204	2024-07-10	2024	7	10
205	2024-07-11	2024	7	11
206	2024-07-14	2024	7	14
207	2024-07-15	2024	7	15
208	2024-07-16	2024	7	16
209	2024-07-19	2024	7	19
210	2024-07-21	2024	7	21
211	2024-07-23	2024	7	23
212	2024-07-24	2024	7	24
213	2024-08-01	2024	8	1
214	2024-08-03	2024	8	3
215	2024-08-04	2024	8	4
216	2024-08-05	2024	8	5
217	2024-08-07	2024	8	7
218	2024-08-08	2024	8	8
219	2024-08-10	2024	8	10
220	2024-08-12	2024	8	12
221	2024-08-13	2024	8	13
222	2024-08-15	2024	8	15
223	2024-08-22	2024	8	22
224	2024-08-23	2024	8	23
225	2024-08-29	2024	8	29
226	2024-09-01	2024	9	1
227	2024-09-04	2024	9	4
228	2024-09-05	2024	9	5
229	2024-09-07	2024	9	7
230	2024-09-08	2024	9	8
231	2024-09-13	2024	9	13
232	2024-09-18	2024	9	18
233	2024-09-22	2024	9	22
234	2024-09-23	2024	9	23
235	2024-09-25	2024	9	25
236	2024-09-27	2024	9	27
237	2024-09-28	2024	9	28
238	2024-09-29	2024	9	29
239	2024-09-30	2024	9	30
240	2024-10-01	2024	10	1
241	2024-10-06	2024	10	6
242	2024-10-07	2024	10	7
243	2024-10-08	2024	10	8
244	2024-10-09	2024	10	9
245	2024-10-14	2024	10	14
246	2024-10-16	2024	10	16
247	2024-10-17	2024	10	17
248	2024-10-19	2024	10	19
249	2024-10-24	2024	10	24
250	2024-10-25	2024	10	25
251	2024-10-26	2024	10	26
252	2024-10-27	2024	10	27
253	2024-10-28	2024	10	28
254	2024-10-29	2024	10	29
255	2024-10-31	2024	10	31
256	2024-11-03	2024	11	3
257	2024-11-04	2024	11	4
258	2024-11-05	2024	11	5
259	2024-11-07	2024	11	7
260	2024-11-08	2024	11	8
261	2024-11-11	2024	11	11
262	2024-11-12	2024	11	12
263	2024-11-13	2024	11	13
264	2024-11-14	2024	11	14
265	2024-11-15	2024	11	15
266	2024-11-16	2024	11	16
267	2024-11-17	2024	11	17
268	2024-11-18	2024	11	18
269	2024-11-20	2024	11	20
270	2024-11-21	2024	11	21
271	2024-11-23	2024	11	23
272	2024-11-26	2024	11	26
273	2024-11-27	2024	11	27
274	2024-12-02	2024	12	2
275	2024-12-05	2024	12	5
276	2024-12-06	2024	12	6
277	2024-12-09	2024	12	9
278	2024-12-10	2024	12	10
279	2024-12-11	2024	12	11
280	2024-12-16	2024	12	16
281	2024-12-17	2024	12	17
282	2024-12-18	2024	12	18
283	2024-12-19	2024	12	19
284	2024-12-22	2024	12	22
285	2024-12-24	2024	12	24
286	2024-12-25	2024	12	25
287	2024-12-26	2024	12	26
288	2024-12-27	2024	12	27
289	2024-12-31	2024	12	31
290	2025-01-01	2025	1	1
291	2025-01-02	2025	1	2
292	2025-01-03	2025	1	3
293	2025-01-05	2025	1	5
294	2025-01-12	2025	1	12
295	2025-01-13	2025	1	13
296	2025-01-14	2025	1	14
297	2025-01-15	2025	1	15
298	2025-01-17	2025	1	17
299	2025-01-19	2025	1	19
300	2025-01-21	2025	1	21
301	2025-01-23	2025	1	23
302	2025-01-24	2025	1	24
303	2025-01-25	2025	1	25
304	2025-01-26	2025	1	26
305	2025-01-28	2025	1	28
306	2025-01-29	2025	1	29
307	2025-01-30	2025	1	30
308	2025-01-31	2025	1	31
309	2025-02-04	2025	2	4
310	2025-02-06	2025	2	6
311	2025-02-09	2025	2	9
312	2025-02-12	2025	2	12
313	2025-02-13	2025	2	13
314	2025-02-15	2025	2	15
315	2025-02-17	2025	2	17
316	2025-02-20	2025	2	20
317	2025-02-25	2025	2	25
318	2025-02-26	2025	2	26
319	2025-02-28	2025	2	28
320	2025-03-02	2025	3	2
321	2025-03-06	2025	3	6
322	2025-03-07	2025	3	7
323	2025-03-09	2025	3	9
324	2025-03-11	2025	3	11
325	2025-03-14	2025	3	14
326	2025-03-15	2025	3	15
327	2025-03-18	2025	3	18
328	2025-03-23	2025	3	23
329	2025-03-24	2025	3	24
330	2025-03-26	2025	3	26
331	2025-03-27	2025	3	27
332	2025-03-28	2025	3	28
333	2025-04-01	2025	4	1
334	2025-04-03	2025	4	3
335	2025-04-04	2025	4	4
336	2025-04-05	2025	4	5
337	2025-04-06	2025	4	6
338	2025-04-09	2025	4	9
339	2025-04-12	2025	4	12
340	2025-04-13	2025	4	13
341	2025-04-18	2025	4	18
342	2025-04-21	2025	4	21
343	2025-04-25	2025	4	25
344	2025-04-26	2025	4	26
345	2025-04-28	2025	4	28
346	2025-04-29	2025	4	29
347	2025-05-04	2025	5	4
348	2025-05-05	2025	5	5
349	2025-05-06	2025	5	6
350	2025-05-08	2025	5	8
351	2025-05-10	2025	5	10
352	2025-05-11	2025	5	11
353	2025-05-12	2025	5	12
\.


--
-- TOC entry 4947 (class 0 OID 24939)
-- Dependencies: 222
-- Data for Name: dim_institution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_institution (institution_id, institution) FROM stdin;
1	Centro B
2	Clinica C
3	Hospital A
\.


--
-- TOC entry 4949 (class 0 OID 24948)
-- Dependencies: 224
-- Data for Name: dim_region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_region (region_id, region) FROM stdin;
1	Sierra
2	Costa
3	Amazonia
\.


--
-- TOC entry 4951 (class 0 OID 24957)
-- Dependencies: 226
-- Data for Name: fact_cases_desnutrition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_cases_desnutrition (id_case, date_id, child_id, region_id, institution_id, weight_kg, height_cm, nutritional_status) FROM stdin;
1	245	C0001	3	3	14.50	68.5	Aguda
2	338	C0002	2	2	10.20	56.6	Aguda
3	344	C0003	1	3	7.20	90.7	Global
4	254	C0004	3	1	8.30	102.8	Aguda
5	233	C0005	2	3	6.60	107.6	Cronica
6	186	C0006	2	2	9.30	73.9	Cronica
7	173	C0007	3	1	6.20	105.7	Aguda
8	279	C0008	2	1	7.10	58.8	Global
9	90	C0009	3	1	16.20	75.9	Cronica
10	240	C0010	3	2	9.30	91.9	Global
11	300	C0011	2	1	13.10	84.4	Aguda
12	250	C0012	2	2	17.90	90.2	Global
13	183	C0013	1	1	14.90	58.1	Aguda
14	119	C0014	1	3	7.30	106.9	Global
15	72	C0015	1	3	16.40	90.4	Aguda
16	1	C0016	1	2	12.10	69.5	Global
17	133	C0017	1	3	7.50	109.9	Global
18	97	C0018	1	2	6.60	63.8	Global
19	295	C0019	1	2	9.70	109.8	Global
20	233	C0020	1	2	14.20	92.5	Global
21	283	C0021	3	2	8.50	63.7	Aguda
22	135	C0022	3	1	14.80	82.9	Aguda
23	154	C0023	2	2	9.50	63.9	Global
24	319	C0024	2	3	4.80	106.1	Cronica
25	24	C0025	2	2	17.30	59.7	Cronica
26	16	C0026	1	2	13.40	107.1	Aguda
27	54	C0027	2	2	17.00	96.5	Global
28	223	C0028	3	1	17.90	90.7	Cronica
29	35	C0029	3	3	7.50	73.6	Global
30	182	C0030	2	3	5.50	89.7	Aguda
31	265	C0031	2	2	11.40	70.3	Cronica
32	353	C0032	2	1	17.10	86.4	Cronica
33	286	C0033	1	1	5.80	91.2	Cronica
34	242	C0034	2	3	5.20	90.9	Global
35	102	C0035	2	3	9.10	102.4	Aguda
36	201	C0036	2	1	10.20	70.3	Aguda
37	231	C0037	2	3	13.30	84.7	Aguda
38	312	C0038	2	3	11.10	66.8	Cronica
39	262	C0039	1	1	17.80	69.6	Cronica
40	45	C0040	3	2	7.10	67.0	Aguda
41	36	C0041	3	2	8.70	57.8	Cronica
42	116	C0042	2	2	17.50	59.4	Aguda
43	291	C0043	2	2	16.10	77.2	Global
44	211	C0044	3	1	5.60	91.2	Global
45	255	C0045	1	3	13.50	72.3	Cronica
46	102	C0046	2	1	8.80	96.4	Aguda
47	165	C0047	1	3	11.80	82.8	Aguda
48	65	C0048	3	1	8.30	79.1	Global
49	200	C0049	2	3	15.50	71.5	Global
50	304	C0050	1	1	16.50	95.8	Aguda
51	72	C0051	3	1	9.10	92.8	Cronica
52	276	C0052	2	3	5.70	78.3	Cronica
53	128	C0053	3	1	6.30	108.9	Aguda
54	71	C0054	2	2	4.60	59.1	Global
55	216	C0055	2	3	9.50	85.4	Cronica
56	257	C0056	1	3	16.60	98.8	Aguda
57	221	C0057	3	2	5.90	97.9	Cronica
58	128	C0058	1	3	16.20	108.7	Aguda
59	9	C0059	3	2	17.00	98.0	Cronica
60	294	C0060	2	1	6.60	93.6	Cronica
61	1	C0061	2	3	15.50	80.3	Cronica
62	240	C0062	1	1	7.10	73.1	Aguda
63	86	C0063	2	1	17.70	84.5	Aguda
64	181	C0064	3	1	17.50	69.6	Aguda
65	67	C0065	2	1	15.10	79.0	Global
66	284	C0066	3	2	5.10	79.0	Global
67	43	C0067	3	1	10.30	107.2	Cronica
68	335	C0068	1	1	16.70	82.9	Global
69	30	C0069	3	1	8.50	62.0	Cronica
70	146	C0070	1	1	12.20	77.3	Aguda
71	206	C0071	1	1	15.10	88.4	Cronica
72	194	C0072	2	2	7.40	81.0	Global
73	234	C0073	2	3	11.50	89.8	Cronica
74	312	C0074	2	1	15.40	63.1	Aguda
75	300	C0075	3	2	10.10	89.6	Aguda
76	187	C0076	2	3	9.90	63.1	Global
77	212	C0077	1	3	6.90	107.7	Global
78	143	C0078	3	2	10.70	99.1	Global
79	77	C0079	3	1	16.50	88.7	Global
80	130	C0080	2	2	14.50	81.1	Cronica
81	134	C0081	1	1	15.00	81.7	Aguda
82	56	C0082	3	3	8.40	69.9	Cronica
83	262	C0083	2	3	7.60	93.2	Global
84	94	C0084	2	1	9.00	80.6	Aguda
85	104	C0085	1	1	12.40	93.3	Global
86	290	C0086	3	2	8.50	76.4	Cronica
87	76	C0087	1	1	7.50	79.0	Aguda
88	26	C0088	3	2	6.70	80.7	Aguda
89	225	C0089	3	1	12.50	91.5	Aguda
90	73	C0090	2	1	7.00	69.3	Cronica
91	20	C0091	1	3	14.80	75.9	Cronica
92	84	C0092	2	2	14.60	57.9	Cronica
93	54	C0093	2	3	17.40	57.2	Aguda
94	299	C0094	2	2	6.60	61.9	Global
95	307	C0095	3	2	13.90	97.2	Aguda
96	195	C0096	3	3	15.60	108.1	Aguda
97	15	C0097	3	3	13.60	107.7	Cronica
98	349	C0098	3	1	13.80	89.5	Aguda
99	178	C0099	3	1	17.80	98.0	Cronica
100	74	C0100	1	3	11.30	73.8	Cronica
101	313	C0101	2	1	13.10	100.6	Global
102	291	C0102	3	1	11.50	90.8	Global
103	165	C0103	2	3	15.60	87.6	Cronica
104	34	C0104	3	1	7.80	80.6	Global
105	98	C0105	2	1	11.20	72.9	Cronica
106	239	C0106	3	3	8.30	87.8	Cronica
107	164	C0107	2	2	7.80	77.4	Global
108	181	C0108	2	1	14.10	79.6	Aguda
109	118	C0109	1	1	13.80	71.8	Global
110	314	C0110	3	1	18.00	85.3	Cronica
111	310	C0111	1	3	7.90	61.6	Aguda
112	44	C0112	3	2	7.40	81.6	Global
113	221	C0113	2	1	15.70	71.3	Cronica
114	223	C0114	3	1	11.70	70.1	Aguda
115	107	C0115	3	1	16.20	82.0	Aguda
116	189	C0116	1	1	10.40	65.1	Aguda
117	318	C0117	3	2	5.40	82.0	Global
118	2	C0118	2	3	6.50	86.0	Cronica
119	11	C0119	2	2	14.80	88.3	Global
120	308	C0120	1	1	16.80	71.4	Global
121	129	C0121	3	3	17.50	60.5	Aguda
122	134	C0122	2	3	5.60	68.2	Global
123	133	C0123	2	3	10.60	87.7	Cronica
124	273	C0124	3	3	8.30	102.3	Aguda
125	51	C0125	1	3	15.20	87.4	Aguda
126	258	C0126	2	3	6.50	69.6	Aguda
127	35	C0127	1	1	8.70	96.2	Global
128	32	C0128	3	2	13.80	93.5	Cronica
129	227	C0129	3	1	5.60	57.2	Cronica
130	126	C0130	3	3	5.70	107.9	Global
131	185	C0131	3	2	5.00	96.6	Cronica
132	309	C0132	1	3	7.00	87.2	Global
133	235	C0133	2	1	10.00	72.7	Aguda
134	110	C0134	3	3	11.20	91.4	Cronica
135	268	C0135	3	3	8.70	72.8	Cronica
136	200	C0136	1	2	5.20	83.5	Global
137	259	C0137	1	1	5.20	69.7	Aguda
138	193	C0138	3	3	4.90	89.7	Aguda
139	321	C0139	2	1	4.70	77.4	Aguda
140	289	C0140	1	2	15.70	82.4	Global
141	158	C0141	1	2	15.80	108.9	Aguda
142	215	C0142	2	3	7.10	88.0	Global
143	70	C0143	1	3	15.20	77.8	Global
144	352	C0144	1	3	8.50	87.3	Global
145	250	C0145	1	1	11.00	73.3	Global
146	330	C0146	2	1	17.70	68.1	Cronica
147	26	C0147	1	2	14.60	93.8	Cronica
148	282	C0148	1	3	17.50	61.9	Global
149	99	C0149	2	1	11.60	80.1	Global
150	111	C0150	3	2	10.80	108.3	Cronica
151	287	C0151	3	1	5.60	73.1	Global
152	141	C0152	2	2	14.20	96.8	Global
153	297	C0153	3	3	13.00	105.7	Aguda
154	44	C0154	1	3	14.80	93.7	Aguda
155	207	C0155	1	1	5.10	98.8	Cronica
156	220	C0156	2	3	7.80	77.7	Global
157	100	C0157	2	1	12.70	76.0	Global
158	175	C0158	3	3	10.70	69.0	Cronica
159	12	C0159	1	2	13.60	63.7	Cronica
160	347	C0160	1	3	17.50	93.0	Cronica
161	105	C0161	3	1	5.90	76.0	Cronica
162	30	C0162	2	2	17.70	91.2	Cronica
163	11	C0163	2	2	14.60	100.8	Cronica
164	322	C0164	3	2	13.10	89.1	Global
165	60	C0165	1	1	5.80	89.5	Aguda
166	209	C0166	1	2	9.40	62.2	Cronica
167	199	C0167	3	2	7.20	98.3	Cronica
168	232	C0168	1	2	6.70	105.3	Cronica
169	112	C0169	2	2	6.10	108.0	Aguda
170	19	C0170	2	1	12.00	60.0	Cronica
171	327	C0171	3	1	9.50	96.2	Cronica
172	307	C0172	3	1	13.60	80.9	Global
173	316	C0173	1	2	5.40	100.3	Global
174	158	C0174	1	3	6.40	107.0	Cronica
175	246	C0175	1	2	16.50	62.5	Cronica
176	14	C0176	3	3	14.50	63.5	Cronica
177	266	C0177	3	1	10.00	107.3	Aguda
178	234	C0178	2	2	10.50	68.0	Cronica
179	260	C0179	1	1	16.70	90.5	Aguda
180	21	C0180	3	3	17.30	100.3	Aguda
181	96	C0181	3	3	15.10	68.4	Aguda
182	325	C0182	2	1	14.80	66.4	Aguda
183	22	C0183	2	2	16.70	55.2	Aguda
184	132	C0184	2	3	6.90	91.4	Aguda
185	328	C0185	2	1	15.10	87.4	Aguda
186	2	C0186	2	1	14.50	83.9	Global
187	280	C0187	3	3	9.40	87.7	Cronica
188	247	C0188	1	1	15.10	102.7	Global
189	203	C0189	3	3	18.00	101.6	Cronica
190	198	C0190	1	2	16.80	59.0	Aguda
191	295	C0191	3	2	6.20	89.3	Global
192	334	C0192	3	2	17.90	84.2	Cronica
193	153	C0193	3	2	15.20	61.3	Global
194	152	C0194	1	1	10.60	67.6	Cronica
195	81	C0195	1	1	5.80	78.5	Global
196	328	C0196	2	1	17.00	58.7	Aguda
197	278	C0197	2	2	14.50	99.6	Global
198	37	C0198	1	2	6.20	74.4	Global
199	242	C0199	3	3	12.60	74.3	Global
200	34	C0200	3	1	11.00	101.6	Cronica
201	113	C0201	3	2	8.30	67.4	Cronica
202	39	C0202	2	3	17.00	100.6	Cronica
203	68	C0203	2	3	14.80	105.7	Cronica
204	113	C0204	3	3	13.40	58.8	Global
205	308	C0205	1	3	11.70	75.7	Cronica
206	312	C0206	3	3	14.20	97.7	Global
207	177	C0207	2	1	6.60	89.0	Global
208	268	C0208	1	3	10.20	88.4	Cronica
209	45	C0209	3	1	10.30	70.6	Global
210	272	C0210	2	3	7.50	109.1	Aguda
211	290	C0211	1	3	14.90	97.0	Cronica
212	228	C0212	3	2	14.60	64.7	Cronica
213	331	C0213	2	1	12.00	91.7	Cronica
214	184	C0214	3	1	4.80	105.7	Cronica
215	260	C0215	2	1	13.10	70.9	Cronica
216	285	C0216	1	3	17.30	80.3	Global
217	270	C0217	2	1	7.80	87.4	Global
218	19	C0218	2	2	9.10	73.3	Aguda
219	243	C0219	1	2	11.40	104.8	Cronica
220	116	C0220	3	3	5.90	69.1	Aguda
221	275	C0221	3	2	17.30	89.5	Cronica
222	114	C0222	3	1	17.00	86.0	Global
223	83	C0223	1	1	10.40	80.8	Global
224	344	C0224	2	3	11.30	72.1	Cronica
225	313	C0225	3	2	8.40	90.5	Aguda
226	352	C0226	2	1	12.30	107.5	Global
227	188	C0227	1	3	12.70	82.6	Aguda
228	326	C0228	2	2	5.60	90.5	Aguda
229	266	C0229	1	1	11.60	88.5	Cronica
230	213	C0230	3	2	15.00	92.3	Aguda
231	101	C0231	1	1	9.00	85.7	Cronica
232	149	C0232	1	2	5.60	91.5	Cronica
233	145	C0233	3	1	12.50	106.6	Cronica
234	256	C0234	3	2	6.20	93.7	Global
235	222	C0235	1	1	13.60	83.0	Aguda
236	203	C0236	2	3	9.10	97.1	Aguda
237	191	C0237	3	2	8.50	98.3	Global
238	171	C0238	3	1	9.00	97.1	Aguda
239	258	C0239	2	2	6.90	93.1	Global
240	1	C0240	1	2	10.00	92.2	Aguda
241	173	C0241	2	1	14.60	79.7	Global
242	293	C0242	1	1	7.10	92.3	Global
243	231	C0243	2	2	9.70	84.0	Aguda
244	241	C0244	3	3	5.20	81.4	Cronica
245	301	C0245	3	3	5.60	63.8	Cronica
246	101	C0246	1	3	17.30	67.2	Cronica
247	197	C0247	2	1	9.90	75.6	Cronica
248	160	C0248	3	1	8.80	60.4	Global
249	45	C0249	3	3	5.00	105.5	Cronica
250	140	C0250	1	3	12.80	104.8	Aguda
251	350	C0251	2	1	17.20	88.5	Cronica
252	124	C0252	3	1	6.10	68.1	Global
253	271	C0253	2	2	15.80	82.5	Global
254	103	C0254	1	3	6.40	78.6	Global
255	131	C0255	2	2	13.50	59.7	Cronica
256	249	C0256	1	1	16.30	57.4	Cronica
257	147	C0257	3	2	15.10	74.0	Global
258	156	C0258	2	1	12.40	96.6	Aguda
259	342	C0259	1	2	13.20	100.7	Global
260	330	C0260	1	3	7.00	62.4	Global
261	172	C0261	1	1	5.10	66.0	Aguda
262	283	C0262	2	1	11.80	68.9	Global
263	49	C0263	2	1	5.10	91.1	Cronica
264	298	C0264	1	3	14.50	104.2	Cronica
265	341	C0265	1	3	11.20	105.8	Global
266	323	C0266	3	1	10.30	109.7	Aguda
267	5	C0267	1	2	5.60	91.4	Cronica
268	222	C0268	3	1	13.80	74.3	Aguda
269	343	C0269	2	2	13.10	98.5	Aguda
270	25	C0270	2	3	11.40	96.2	Aguda
271	261	C0271	1	1	6.20	68.0	Global
272	252	C0272	1	1	4.90	63.4	Cronica
273	268	C0273	1	1	5.50	62.6	Cronica
274	289	C0274	1	2	17.50	56.4	Aguda
275	146	C0275	1	3	6.10	97.6	Global
276	263	C0276	2	3	16.90	82.0	Aguda
277	191	C0277	3	1	16.60	79.5	Aguda
278	139	C0278	2	2	5.40	84.8	Cronica
279	22	C0279	2	3	9.40	67.3	Aguda
280	244	C0280	3	3	9.40	86.5	Cronica
281	95	C0281	1	2	8.70	110.0	Global
282	320	C0282	1	2	10.00	86.6	Aguda
283	61	C0283	3	2	10.80	83.5	Aguda
284	202	C0284	2	2	17.50	78.8	Aguda
285	10	C0285	2	1	6.70	72.7	Global
286	253	C0286	1	3	7.90	89.9	Global
287	83	C0287	3	2	11.70	82.6	Aguda
288	40	C0288	1	2	13.40	94.6	Global
289	171	C0289	3	1	16.20	59.5	Global
290	277	C0290	1	2	12.20	89.0	Aguda
291	267	C0291	1	1	17.40	81.6	Global
292	129	C0292	1	1	13.80	63.7	Cronica
293	169	C0293	1	2	12.70	72.2	Global
294	148	C0294	2	1	6.30	75.4	Global
295	53	C0295	2	3	6.20	79.7	Aguda
296	253	C0296	1	2	16.20	78.0	Aguda
297	91	C0297	1	1	14.80	82.4	Global
298	281	C0298	1	3	4.80	107.0	Global
299	236	C0299	3	2	9.30	57.8	Cronica
300	59	C0300	2	1	11.70	101.6	Cronica
301	174	C0301	3	2	9.90	57.5	Aguda
302	306	C0302	1	2	12.00	59.0	Global
303	196	C0303	2	3	17.90	92.4	Aguda
304	7	C0304	2	3	15.20	73.6	Cronica
305	274	C0305	1	1	5.00	57.1	Global
306	214	C0306	3	1	12.70	83.4	Cronica
307	147	C0307	3	1	17.90	95.7	Cronica
308	159	C0308	1	1	12.10	81.1	Aguda
309	127	C0309	3	2	12.40	98.8	Global
310	176	C0310	3	3	10.90	108.2	Global
311	87	C0311	3	1	11.00	83.8	Global
312	204	C0312	2	3	13.70	56.7	Global
313	283	C0313	2	1	8.70	63.3	Global
314	50	C0314	2	2	14.30	93.8	Global
315	277	C0315	1	2	11.00	75.7	Aguda
316	157	C0316	3	2	9.30	97.5	Global
317	143	C0317	3	1	11.00	107.7	Cronica
318	173	C0318	3	1	14.90	93.8	Global
319	197	C0319	1	1	9.20	106.4	Global
320	4	C0320	1	3	13.60	75.9	Cronica
321	345	C0321	1	2	8.40	94.3	Cronica
322	180	C0322	1	2	11.00	66.1	Global
323	337	C0323	2	3	6.00	95.7	Aguda
324	108	C0324	3	1	7.60	60.5	Cronica
325	13	C0325	2	1	14.90	55.3	Global
326	296	C0326	1	1	13.30	96.6	Cronica
327	106	C0327	3	2	5.70	86.6	Global
328	224	C0328	1	1	10.10	101.1	Aguda
329	142	C0329	2	1	17.50	105.9	Aguda
330	226	C0330	3	1	8.30	109.4	Global
331	303	C0331	1	3	10.80	65.6	Aguda
332	79	C0332	1	1	8.00	65.2	Global
333	261	C0333	1	2	12.70	90.1	Cronica
334	272	C0334	1	1	9.90	60.2	Aguda
335	250	C0335	1	1	8.00	68.0	Cronica
336	64	C0336	3	3	13.30	93.1	Aguda
337	185	C0337	1	2	6.70	92.7	Global
338	113	C0338	2	3	16.90	71.2	Global
339	58	C0339	1	1	6.60	96.1	Global
340	99	C0340	2	2	11.80	91.5	Aguda
341	238	C0341	3	3	10.50	93.7	Aguda
342	62	C0342	3	3	11.90	82.8	Global
343	18	C0343	2	2	16.00	79.3	Global
344	166	C0344	1	3	16.60	79.5	Aguda
345	19	C0345	1	2	12.10	85.7	Global
346	201	C0346	3	3	7.90	55.2	Aguda
347	292	C0347	2	1	9.20	58.5	Aguda
348	317	C0348	3	2	10.00	97.3	Global
349	302	C0349	1	3	17.90	76.0	Cronica
350	276	C0350	1	2	16.10	61.5	Global
351	100	C0351	1	1	17.70	100.9	Aguda
352	28	C0352	1	3	9.60	67.6	Cronica
353	183	C0353	2	2	17.20	94.9	Aguda
354	329	C0354	2	3	14.80	103.6	Aguda
355	75	C0355	3	3	12.50	79.6	Global
356	42	C0356	2	3	5.10	79.1	Global
357	129	C0357	3	1	17.90	67.9	Global
358	272	C0358	3	3	8.60	62.9	Global
359	235	C0359	3	3	8.20	85.6	Global
360	78	C0360	3	1	11.20	108.5	Global
361	197	C0361	2	2	10.10	63.2	Cronica
362	66	C0362	2	1	16.00	71.5	Global
363	192	C0363	2	1	10.10	77.9	Global
364	162	C0364	1	3	7.20	90.6	Cronica
365	11	C0365	2	3	8.10	92.1	Global
366	264	C0366	2	1	14.80	94.8	Global
367	134	C0367	2	2	8.60	105.0	Aguda
368	126	C0368	3	2	18.00	81.3	Aguda
369	127	C0369	1	1	16.90	85.4	Cronica
370	218	C0370	1	3	8.00	83.2	Cronica
371	22	C0371	1	1	15.80	105.3	Cronica
372	155	C0372	1	2	16.20	95.8	Aguda
373	305	C0373	3	3	6.60	73.1	Cronica
374	147	C0374	1	2	13.30	92.7	Cronica
375	48	C0375	2	2	6.80	98.7	Aguda
376	31	C0376	2	2	16.90	84.8	Global
377	137	C0377	2	3	15.90	107.0	Global
378	88	C0378	2	3	15.90	67.7	Global
379	288	C0379	3	2	10.70	58.3	Global
380	23	C0380	1	3	11.10	55.4	Global
381	239	C0381	2	2	14.20	84.5	Cronica
382	237	C0382	3	3	17.20	64.9	Aguda
383	55	C0383	1	1	12.90	68.9	Cronica
384	151	C0384	3	3	17.50	80.2	Aguda
385	333	C0385	2	3	15.70	59.4	Global
386	200	C0386	2	2	9.60	81.2	Global
387	29	C0387	3	3	11.20	78.9	Cronica
388	109	C0388	1	1	7.40	102.7	Global
389	315	C0389	3	2	13.70	70.4	Global
390	3	C0390	3	3	17.00	72.3	Aguda
391	6	C0391	1	2	8.50	86.0	Global
392	332	C0392	3	3	14.70	62.7	Global
393	158	C0393	1	2	5.80	67.8	Aguda
394	115	C0394	1	3	8.90	89.9	Cronica
395	324	C0395	3	2	17.20	78.8	Global
396	346	C0396	3	3	14.90	71.2	Aguda
397	205	C0397	2	2	6.60	94.1	Global
398	152	C0398	1	1	9.40	60.0	Cronica
399	336	C0399	3	2	6.30	65.3	Cronica
400	138	C0400	3	2	4.90	74.5	Aguda
401	28	C0401	3	2	4.70	77.8	Aguda
402	157	C0402	2	1	11.50	92.7	Aguda
403	278	C0403	1	1	11.20	58.5	Cronica
404	101	C0404	3	2	15.10	74.9	Aguda
405	125	C0405	1	3	12.80	80.2	Aguda
406	298	C0406	1	1	15.90	75.9	Cronica
407	8	C0407	2	1	15.60	90.8	Global
408	4	C0408	2	1	17.30	66.0	Cronica
409	246	C0409	2	1	14.40	89.8	Global
410	182	C0410	3	3	15.50	76.6	Aguda
411	102	C0411	1	2	14.90	56.5	Global
412	46	C0412	1	2	15.30	100.7	Aguda
413	93	C0413	2	2	13.10	68.3	Global
414	145	C0414	1	2	9.60	79.7	Global
415	123	C0415	1	2	11.30	105.6	Global
416	248	C0416	3	2	17.60	93.6	Global
417	92	C0417	2	2	14.90	91.2	Cronica
418	14	C0418	1	1	17.80	92.3	Cronica
419	170	C0419	3	2	5.80	67.2	Global
420	180	C0420	3	2	9.60	80.5	Global
421	27	C0421	1	3	18.00	81.6	Cronica
422	47	C0422	1	1	17.20	62.8	Cronica
423	144	C0423	3	2	11.00	81.2	Cronica
424	96	C0424	2	3	5.40	57.5	Global
425	152	C0425	2	2	6.00	99.0	Global
426	117	C0426	2	1	6.70	85.8	Cronica
427	168	C0427	3	2	13.10	78.8	Aguda
428	218	C0428	2	3	12.50	76.4	Global
429	208	C0429	2	2	14.00	98.8	Global
430	144	C0430	3	1	8.90	80.2	Cronica
431	329	C0431	1	1	9.70	76.6	Aguda
432	310	C0432	3	2	6.80	92.0	Cronica
433	251	C0433	2	3	6.30	61.5	Cronica
434	34	C0434	2	2	6.40	76.4	Global
435	150	C0435	3	3	7.00	90.0	Global
436	300	C0436	3	3	8.40	65.3	Cronica
437	88	C0437	3	2	11.00	65.7	Cronica
438	243	C0438	1	3	13.70	77.9	Cronica
439	306	C0439	2	1	4.90	96.9	Cronica
440	82	C0440	3	1	8.40	97.9	Global
441	34	C0441	3	3	6.00	97.6	Cronica
442	120	C0442	3	3	7.50	78.4	Global
443	141	C0443	1	3	10.60	74.2	Aguda
444	299	C0444	3	2	15.40	87.3	Cronica
445	57	C0445	2	2	12.80	98.2	Aguda
446	230	C0446	3	1	8.30	84.6	Cronica
447	206	C0447	2	3	8.10	102.2	Global
448	52	C0448	3	3	17.90	102.7	Aguda
449	219	C0449	1	1	14.10	100.6	Global
450	229	C0450	1	3	13.00	89.5	Cronica
451	80	C0451	1	1	11.50	70.3	Cronica
452	125	C0452	2	2	4.50	97.6	Global
453	348	C0453	3	1	13.50	74.7	Aguda
454	199	C0454	1	1	15.60	82.2	Cronica
455	41	C0455	2	3	16.00	98.4	Global
456	299	C0456	2	1	15.10	80.3	Aguda
457	85	C0457	2	2	17.90	78.5	Global
458	62	C0458	3	1	16.30	103.2	Aguda
459	340	C0459	2	1	9.50	104.7	Aguda
460	38	C0460	2	2	13.90	67.9	Global
461	90	C0461	2	2	7.40	59.3	Global
462	161	C0462	1	2	4.60	73.9	Aguda
463	181	C0463	2	3	5.50	76.1	Global
464	63	C0464	3	2	16.40	62.5	Aguda
465	38	C0465	2	1	11.70	55.5	Global
466	167	C0466	3	2	7.40	96.2	Cronica
467	351	C0467	3	2	5.70	60.5	Aguda
468	53	C0468	2	1	17.50	72.3	Aguda
469	269	C0469	1	2	12.00	88.0	Global
470	89	C0470	3	3	16.30	66.3	Global
471	273	C0471	1	1	13.20	98.1	Aguda
472	69	C0472	2	1	11.20	87.7	Global
473	136	C0473	1	2	9.70	101.1	Cronica
474	97	C0474	2	2	10.90	109.3	Aguda
475	311	C0475	1	2	8.00	57.2	Aguda
476	339	C0476	3	1	14.10	97.2	Cronica
477	121	C0477	2	1	11.70	88.9	Cronica
478	122	C0478	3	1	16.90	108.6	Aguda
479	198	C0479	3	3	13.10	100.9	Global
480	109	C0480	2	3	10.40	107.4	Aguda
481	227	C0481	1	2	6.10	88.7	Aguda
482	88	C0482	2	1	4.70	62.5	Aguda
483	321	C0483	2	1	11.50	100.2	Cronica
484	254	C0484	2	1	15.00	69.8	Aguda
485	179	C0485	3	3	11.60	69.5	Global
486	210	C0486	2	1	11.40	58.0	Global
487	332	C0487	3	3	14.90	104.2	Global
488	318	C0488	2	3	11.40	57.4	Aguda
489	125	C0489	3	2	9.70	63.3	Aguda
490	81	C0490	1	1	8.80	77.9	Global
491	217	C0491	2	3	9.50	82.6	Aguda
492	59	C0492	1	1	5.40	80.6	Cronica
493	163	C0493	3	1	10.70	75.3	Cronica
494	198	C0494	3	2	9.50	108.5	Aguda
495	17	C0495	3	1	4.60	77.6	Aguda
496	284	C0496	3	1	4.50	91.2	Global
497	190	C0497	2	3	11.70	68.1	Cronica
498	344	C0498	1	2	5.10	67.7	Global
499	81	C0499	3	3	17.70	59.7	Aguda
500	33	C0500	2	3	12.50	58.4	Global
\.


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 218
-- Name: dim_date_date_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_date_date_id_seq', 353, true);


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 221
-- Name: dim_institution_institution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_institution_institution_id_seq', 3, true);


--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 223
-- Name: dim_region_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_region_region_id_seq', 3, true);


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 225
-- Name: fact_cases_desnutrition_id_case_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_cases_desnutrition_id_case_seq', 500, true);


--
-- TOC entry 4782 (class 2606 OID 24937)
-- Name: dim_child dim_child_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_child
    ADD CONSTRAINT dim_child_pkey PRIMARY KEY (child_id);


--
-- TOC entry 4778 (class 2606 OID 24929)
-- Name: dim_date dim_date_date_measured_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_date
    ADD CONSTRAINT dim_date_date_measured_key UNIQUE (date_measured);


--
-- TOC entry 4780 (class 2606 OID 24927)
-- Name: dim_date dim_date_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_date
    ADD CONSTRAINT dim_date_pkey PRIMARY KEY (date_id);


--
-- TOC entry 4784 (class 2606 OID 24946)
-- Name: dim_institution dim_institution_institution_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_institution
    ADD CONSTRAINT dim_institution_institution_key UNIQUE (institution);


--
-- TOC entry 4786 (class 2606 OID 24944)
-- Name: dim_institution dim_institution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_institution
    ADD CONSTRAINT dim_institution_pkey PRIMARY KEY (institution_id);


--
-- TOC entry 4788 (class 2606 OID 24953)
-- Name: dim_region dim_region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_region
    ADD CONSTRAINT dim_region_pkey PRIMARY KEY (region_id);


--
-- TOC entry 4790 (class 2606 OID 24955)
-- Name: dim_region dim_region_region_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_region
    ADD CONSTRAINT dim_region_region_key UNIQUE (region);


--
-- TOC entry 4792 (class 2606 OID 24965)
-- Name: fact_cases_desnutrition fact_cases_desnutrition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_cases_desnutrition
    ADD CONSTRAINT fact_cases_desnutrition_pkey PRIMARY KEY (id_case);


--
-- TOC entry 4793 (class 2606 OID 24971)
-- Name: fact_cases_desnutrition fact_cases_desnutrition_child_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_cases_desnutrition
    ADD CONSTRAINT fact_cases_desnutrition_child_id_fkey FOREIGN KEY (child_id) REFERENCES public.dim_child(child_id);


--
-- TOC entry 4794 (class 2606 OID 24966)
-- Name: fact_cases_desnutrition fact_cases_desnutrition_date_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_cases_desnutrition
    ADD CONSTRAINT fact_cases_desnutrition_date_id_fkey FOREIGN KEY (date_id) REFERENCES public.dim_date(date_id);


--
-- TOC entry 4795 (class 2606 OID 24981)
-- Name: fact_cases_desnutrition fact_cases_desnutrition_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_cases_desnutrition
    ADD CONSTRAINT fact_cases_desnutrition_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.dim_institution(institution_id);


--
-- TOC entry 4796 (class 2606 OID 24976)
-- Name: fact_cases_desnutrition fact_cases_desnutrition_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_cases_desnutrition
    ADD CONSTRAINT fact_cases_desnutrition_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.dim_region(region_id);


-- Completed on 2026-05-14 15:37:26

--
-- PostgreSQL database dump complete
--

\unrestrict dNEE38cfkgxPk9cXlYmfHe3EaSQ8AGw1evkc1HHpn5RZizvvpNiJaia5f7aYEX8

