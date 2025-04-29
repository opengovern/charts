--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Homebrew)
-- Dumped by pg_dump version 17.4 (Homebrew)

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

DROP INDEX IF EXISTS public.idx_users_deleted_at;
DROP INDEX IF EXISTS public.idx_connectors_deleted_at;
DROP INDEX IF EXISTS public.idx_configurations_deleted_at;
DROP INDEX IF EXISTS public.idx_api_keys_deleted_at;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.connectors DROP CONSTRAINT IF EXISTS connectors_pkey;
ALTER TABLE IF EXISTS ONLY public.configurations DROP CONSTRAINT IF EXISTS configurations_pkey;
ALTER TABLE IF EXISTS ONLY public.api_keys DROP CONSTRAINT IF EXISTS api_keys_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.connectors ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.configurations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.api_keys ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.connectors_id_seq;
DROP TABLE IF EXISTS public.connectors;
DROP SEQUENCE IF EXISTS public.configurations_id_seq;
DROP TABLE IF EXISTS public.configurations;
DROP SEQUENCE IF EXISTS public.api_keys_id_seq;
DROP TABLE IF EXISTS public.api_keys;
DROP EXTENSION IF EXISTS "uuid-ossp";
DROP EXTENSION IF EXISTS citext;
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_keys (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    name text,
    role text,
    creator_user_id text,
    is_active boolean,
    key_hash text,
    masked_key text
);


--
-- Name: api_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.api_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.api_keys_id_seq OWNED BY public.api_keys.id;


--
-- Name: configurations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.configurations (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    key text,
    value text
);


--
-- Name: configurations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.configurations_id_seq OWNED BY public.configurations.id;


--
-- Name: connectors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.connectors (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    user_count bigint DEFAULT 0,
    connector_id text,
    connector_type text,
    connector_sub_type text,
    last_update timestamp with time zone
);


--
-- Name: connectors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.connectors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: connectors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.connectors_id_seq OWNED BY public.connectors.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    email text,
    email_verified boolean,
    full_name text,
    role text,
    connector_id text,
    external_id text,
    last_login timestamp with time zone,
    username text,
    require_password_change boolean DEFAULT true,
    is_active boolean DEFAULT true
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: api_keys id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_keys ALTER COLUMN id SET DEFAULT nextval('public.api_keys_id_seq'::regclass);


--
-- Name: configurations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.configurations ALTER COLUMN id SET DEFAULT nextval('public.configurations_id_seq'::regclass);


--
-- Name: connectors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connectors ALTER COLUMN id SET DEFAULT nextval('public.connectors_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: api_keys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.api_keys (id, created_at, updated_at, deleted_at, name, role, creator_user_id, is_active, key_hash, masked_key) FROM stdin;
1	2025-03-28 12:42:05.976278-07	2025-03-28 12:42:05.976278-07	\N	Install	admin	local|admin@opensecurity.sh	t	54630d853fb5620b834b4c1af9a11f293346462763a73292fa1d0cb1ca1116538abd00e1925c70a2ef06ce799558466f46357ad5b0a336752efd49cb2b8d0e4a	eyJhbGciOi...ELnvO4WF4Q
\.


--
-- Data for Name: configurations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.configurations (id, created_at, updated_at, deleted_at, key, value) FROM stdin;
1	2025-03-03 08:23:41.188922-08	2025-03-03 08:23:41.188922-08	\N	public_key	LS0tLS1CRUdJTiBSU0EgUFVCTElDIEtFWS0tLS0tCk1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBdzJCQU5sTDM2aEk1RFcvUWhpMGwKaDBkYkY5dWN3VktCZTdoQUZXTDJuc1ZaSUh5cTdDWjcwazVxM3pxcXNHR011NVI2ZnNOTnNCNjRNeE4xQjhQUQo4MTBYd1dORG9nQ2tVTFEwQ3FyUjBrQW9KZ1hweGdFMnhtV0lNaU81T3NyQ1BQc2pXZzFvOTc3REtoS0hDWlRTCkVOVzhTMlQvNWcxUHYwcDJRVkc2RnFQdXZaazJyU2lOM3M0bG8yOTZLaG9scWxRM1VYaDJESmRLN3lOcHF5NWkKMm9Lam12YmZkMjIrQkw1ejBpekROOHBEbHZaakgwNDdNZ3kvL2xwRVl3WlhUenJ3ZUw4bTRUVTNoTmlNaU83RAp0SDQ4V1JjLzVSaXNsN0NTTHJ6K2g0TUtSYnZSUEJ3dTVVckRxQVNSekZlaDl5K0w3SkV5dENSTGFkRUlkYU45CnNRSURBUUFCCi0tLS0tRU5EIFJTQSBQVUJMSUMgS0VZLS0tLS0K
2	2025-03-03 08:23:41.194795-08	2025-03-03 08:23:41.194795-08	\N	private_key	LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFdlFJQkFEQU5CZ2txaGtpRzl3MEJBUUVGQUFTQ0JLY3dnZ1NqQWdFQUFvSUJBUUREWUVBMlV2ZnFFamtOCmI5Q0dMU1dIUjFzWDI1ekJVb0Y3dUVBVll2YWV4VmtnZktyc0pudlNUbXJmT3Fxd1lZeTdsSHArdzAyd0hyZ3oKRTNVSHc5RHpYUmZCWTBPaUFLUlF0RFFLcXRIU1FDZ21CZW5HQVRiR1pZZ3lJN2s2eXNJOCt5TmFEV2ozdnNNcQpFb2NKbE5JUTFieExaUC9tRFUrL1NuWkJVYm9Xbys2OW1UYXRLSTNlemlXamIzb3FHaVdxVkRkUmVIWU1sMHJ2CkkybXJMbUxhZ3FPYTl0OTNiYjRFdm5QU0xNTTN5a09XOW1NZlRqc3lETC8rV2tSakJsZFBPdkI0dnliaE5UZUUKMkl5STdzTzBmanhaRnovbEdLeVhzSkl1dlA2SGd3cEZ1OUU4SEM3bFNzT29CSkhNVjZIM0w0dnNrVEswSkV0cAowUWgxbzMyeEFnTUJBQUVDZ2dFQU91cWtrbjAwbTVhQk0rY2JGOHMzZlBMc3FtWWtnRHZVSmkzcXpVZzVuS2xnCmRpYUNHSktHVm1ZbFhrbS92VTY5ZExlU3RQVktVU2tDWFF5cUJ2eHEzMmljU0VvWjFCbWpjMTdVTHI5U1pMZksKSTZVMjJPbjJ6WjlDa2ZRcDRHdlNaVGRLY3RhR1orZFR6VFVuR2FHU00xZHczNytHVjZaOS9PNkVlTEFma01HNAoyamJBeFlPbFhNaFhnR091UThlTnlqUXJxZldPUHliY0xmQ0Nma0xKb0cvUVR1NGN2WEtwQ25vWFRuNGpQTkFhCm1EK2xtNmkrYXArcy81NFF5NFNkcHpONTVzQnBhQVpLa0ZyMjBRdmwrRHhuWFRvVWpVTnU2SFRvRE5DTWtkZW0KMklnWmdtenpyUnY0K1o1bTlZQzNvK1M0aWJIcmFOdmUwcUk5MXJRUjBRS0JnUURHVTF4VFdrdUZwYkZiU1BkNQp6WE1rd0dZQU9mSzlodHFRM0FIazRDUFR5Rmd2NzdOUDF6TXB5TGNIMkowNWZlRDlzbUtQMUNKaUg1VXUrQzk1Ck5rSnI5dE5TZUZVNFg4VjVqNmpFL0lmbnV1U3U5bitVV0h2dzFJbWsvdldtSEsvWGRTN3dlWGZBQ3dyVmsyQWoKME1FVUFkdWFTVmoxU2k1a1ZhTEFoTDVlaFFLQmdRRDhNVXlqdnBSTXdTZG9uQm9OM2RCbFJJY2V1WVFXQXZoaQo2Y21TWW1MajVvaGhoa05sbkVYWG5lZG5UZFNWYVRHTVd2Z2puVVFZalc3MUVyZmd1TkF2SHRNa2twTzN0T2VYCjF4YTg5eDNOSkRtVndnUGZvWDVVVVMwM0lQcGdqMW5hcWVrbExJU3JjcjRzZUZDSkIrazhINGFXSkVHckwwcGcKWlEvRStBaVlQUUtCZ0FkWnZabEZSbmxNbTljelRDRFNrWXJ5S3BXbGtDNmdHZWUyajhkbzIwc1ZLTmVWL2NKZQp5b0dvODhleHFwb2Y1VC9oNWE5SkFJRThoRzM2T3VBMk41NEN4dkJPajNJSWNxdy91OVNaTzN4R1BBV1VFMFJ2ClJ5QzA3K2tTbmc0ckVBVmZUWDhTTVhNSHRiNFd1VUI2a3oxbm1Ea09zT0plZm51dmhObTMwY3AxQW9HQkFQWHUKaFpSdzkySGFRcm9LOElWeE9CWnBPM05FNm9Ba3FXQ2NLQXZ1a2cwNDlPcFY2a2VlbTZWbXdSREduM2FNdk5ybwpvMjdub0U1cExqa2o1ZGpwb1dzeUhpbGVIMXRZdVRnamNuTVljU0ZxSUJYZ3U3SkxaRXlKVlJTYnZrNkh2TkkyCk83d2FxODRkK1VLWW1jRG56QlRya1cyOU1hVGtXeDJoc0QwZXZCTHBBb0dBTjZPZ3Eza1ZrYnh3U1lud202VWQKaUFTZGwvNnZ4bThKbitGSmpZSWhNcXpKSE5Yblp0YnI0UXJ6MmVQREt3ZFZNVU5mRVJ2aEY2UGlSRzRubUVCaApEZS9DVW5ZOWhPY1VERUVGeVYycFhmSUFTQW9Namd5bVc3RE96MXdPWVVFUkZVTkcvcTFEUmN1VVNoRmpKRHZyCklyQU5XVnkrMGVQdUtVbVpwM1c0NGJNPQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=
\.


--
-- Data for Name: connectors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.connectors (id, created_at, updated_at, deleted_at, user_count, connector_id, connector_type, connector_sub_type, last_update) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, created_at, updated_at, deleted_at, email, email_verified, full_name, role, connector_id, external_id, last_login, username, require_password_change, is_active) FROM stdin;
1	2025-03-03 14:46:58.458363-08	2025-03-28 12:41:40.57907-07	\N	admin@opensecurity.sh	f	admin@opensecurity.sh	admin	local	local|admin@opensecurity.sh	2025-03-28 12:41:40.578451-07	admin@opensecurity.sh	t	t
\.


--
-- Name: api_keys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.api_keys_id_seq', 1, true);


--
-- Name: configurations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.configurations_id_seq', 2, true);


--
-- Name: connectors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.connectors_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: api_keys api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


--
-- Name: configurations configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.configurations
    ADD CONSTRAINT configurations_pkey PRIMARY KEY (id);


--
-- Name: connectors connectors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connectors
    ADD CONSTRAINT connectors_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_api_keys_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_api_keys_deleted_at ON public.api_keys USING btree (deleted_at);


--
-- Name: idx_configurations_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_configurations_deleted_at ON public.configurations USING btree (deleted_at);


--
-- Name: idx_connectors_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_connectors_deleted_at ON public.connectors USING btree (deleted_at);


--
-- Name: idx_users_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_deleted_at ON public.users USING btree (deleted_at);


--
-- PostgreSQL database dump complete
--

