--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: comet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.comet (
    comet_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    star_id integer NOT NULL,
    radius_in_km numeric(10,2),
    CONSTRAINT radius_check CHECK ((radius_in_km >= (0)::numeric))
);


ALTER TABLE public.comet OWNER TO freecodecamp;

--
-- Name: comet_comet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.comet ALTER COLUMN comet_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.comet_comet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(50) NOT NULL,
    type character varying(50) NOT NULL,
    description text,
    number_of_stars bigint,
    number_of_planets bigint,
    number_of_satellite_galaxies integer,
    number_of_known_supernovae integer,
    age_in_millions_of_years numeric(20,2),
    has_active_galactic_nucleus boolean DEFAULT false NOT NULL,
    is_star_forming boolean DEFAULT true NOT NULL,
    CONSTRAINT galaxy_age_check CHECK ((age_in_millions_of_years >= (0)::numeric)),
    CONSTRAINT galaxy_type_check CHECK (((type)::text = ANY ((ARRAY['Spiral'::character varying, 'Elliptical'::character varying, 'Irregular'::character varying, 'Lenticular'::character varying])::text[]))),
    CONSTRAINT satellite_galaxies_check CHECK ((number_of_satellite_galaxies >= 0)),
    CONSTRAINT supernovae_check CHECK ((number_of_known_supernovae >= 0))
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.galaxy ALTER COLUMN galaxy_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.galaxy_galaxy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    planet_id integer NOT NULL,
    radius_in_km numeric(10,2),
    CONSTRAINT radius_check CHECK ((radius_in_km >= (0)::numeric))
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.moon ALTER COLUMN moon_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.moon_moon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(50) NOT NULL,
    type character varying(50) NOT NULL,
    description text,
    star_id integer NOT NULL,
    CONSTRAINT planet_type_check CHECK (((type)::text = ANY ((ARRAY['Terrestrial'::character varying, 'Gas Giant'::character varying, 'Ice Giant'::character varying, 'Dwarf Planet'::character varying])::text[])))
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.planet ALTER COLUMN planet_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.planet_planet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    galaxy_id integer NOT NULL,
    mass_in_solar_masses numeric(10,3) NOT NULL,
    CONSTRAINT mass_check CHECK ((mass_in_solar_masses >= (0)::numeric))
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

ALTER TABLE public.star ALTER COLUMN star_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.star_star_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: comet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.comet OVERRIDING SYSTEM VALUE VALUES (1, 'Halley', 'A famous periodic comet that returns to the inner Solar System approximately every 76 years.', 1, 5.50);
INSERT INTO public.comet OVERRIDING SYSTEM VALUE VALUES (2, 'Hale-Bopp', 'A long-period comet that became one of the most widely observed comets of the twentieth century.', 1, 30.00);
INSERT INTO public.comet OVERRIDING SYSTEM VALUE VALUES (3, 'Swift-Tuttle', 'A large periodic comet responsible for the Perseid meteor shower.', 1, 13.00);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (1, 'Milky Way', 'Spiral', 'The galaxy containing the Solar System.', 200000000000, 100000000000, 2, 5, 13610.00, false, true);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (2, 'Andromeda', 'Spiral', 'The nearest major galaxy to the Milky Way.', 1000000000000, 200000000000, 3, 8, 10010.00, false, true);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (3, 'Messier 87', 'Elliptical', 'A massive elliptical galaxy located in the Virgo Cluster.', 1000000000000, 500000000000, 0, 12, 13000.00, true, false);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (4, 'Large Magellanic Cloud', 'Irregular', 'An irregular satellite galaxy of the Milky Way.', 30000000000, 5000000000, 0, 4, 13000.00, false, true);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (5, 'Small Magellanic Cloud', 'Irregular', 'A small irregular galaxy orbiting the Milky Way.', 30000000000, 3000000000, 0, 3, 7000.00, false, true);
INSERT INTO public.galaxy OVERRIDING SYSTEM VALUE VALUES (6, 'NGC 278', 'Lenticular', 'A lenticular galaxy with an old stellar population.', 50000000000, 10000000000, 0, 2, 9000.00, false, false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (1, 'Moon', 'Earths natural satellite.', 3, 1737.40);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (2, 'Phobos', 'The larger and closer moon of Mars.', 1, 11.27);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (3, 'Deimos', 'The smaller and more distant moon of Mars.', 1, 6.20);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (4, 'Io', 'A volcanically active moon of Jupiter.', 4, 1821.60);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (5, 'Europa', 'An icy moon of Jupiter with a subsurface ocean.', 4, 1560.80);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (6, 'Ganymede', 'The largest moon in the Solar System.', 4, 2634.10);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (7, 'Callisto', 'A heavily cratered outer moon of Jupiter.', 4, 2410.30);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (8, 'Amalthea', 'A small irregular moon of Jupiter.', 4, 83.50);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (9, 'Titan', 'The largest moon of Saturn with a dense atmosphere.', 5, 2574.70);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (10, 'Rhea', 'An icy moon of Saturn with a heavily cratered surface.', 5, 763.80);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (11, 'Iapetus', 'A moon of Saturn known for its dramatic light and dark hemispheres.', 5, 734.50);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (12, 'Dione', 'An icy moon of Saturn with bright surface fractures.', 5, 561.40);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (13, 'Enceladus', 'An icy moon of Saturn known for its water-rich geysers.', 5, 252.10);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (14, 'Mimas', 'A small icy moon of Saturn with a large impact crater.', 5, 198.20);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (15, 'Triton', 'The largest moon of Neptune and a geologically active icy world.', 6, 1353.40);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (16, 'Nereid', 'An irregular moon with a highly eccentric orbit.', 6, 170.00);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (17, 'Larissa', 'A small inner moon of Neptune.', 6, 97.00);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (18, 'Aurelia I', 'A small natural satellite orbiting Aurelia.', 7, 420.50);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (19, 'Aurelia II', 'A smaller outer moon orbiting Aurelia.', 7, 185.30);
INSERT INTO public.moon OVERRIDING SYSTEM VALUE VALUES (20, 'Valora I', 'A large icy moon orbiting the gas giant Valora.', 9, 1120.70);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (1, 'Mercury', 'Terrestrial', 'The smallest planet and the closest planet to the Sun.', 1);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (2, 'Venus', 'Terrestrial', 'A hot terrestrial planet with a dense carbon dioxide atmosphere.', 1);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (3, 'Earth', 'Terrestrial', 'A terrestrial planet with abundant liquid water and known life.', 1);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (4, 'Jupiter', 'Gas Giant', 'The largest planet in the Solar System.', 1);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (5, 'Saturn', 'Gas Giant', 'A gas giant famous for its prominent ring system.', 1);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (6, 'Neptune', 'Ice Giant', 'A distant ice giant known for its powerful winds.', 1);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (7, 'Aurelia', 'Terrestrial', 'A rocky planet orbiting Sirius A.', 2);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (8, 'Elysia', 'Terrestrial', 'A rocky planet with a dense atmosphere orbiting Sirius A.', 2);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (9, 'Valora', 'Gas Giant', 'A massive gas giant orbiting Betelgeuse.', 3);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (10, 'Nyx', 'Ice Giant', 'A cold ice giant orbiting Vega.', 4);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (11, 'Orion', 'Terrestrial', 'A rocky planet orbiting Rigel.', 5);
INSERT INTO public.planet OVERRIDING SYSTEM VALUE VALUES (12, 'Vesper', 'Dwarf Planet', 'A small planetary body orbiting VFTS 352.', 6);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (1, 'Sun', 'The star at the center of the Solar System.', 1, 1.000);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (2, 'Sirius A', 'The brightest star in the night sky as seen from Earth.', 1, 2.063);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (3, 'Betelgeuse', 'A red supergiant located in the constellation Orion.', 1, 16.500);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (4, 'Vega', 'A bright blue-white star located in the constellation Lyra.', 2, 2.135);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (5, 'Rigel', 'A blue supergiant and one of the brightest stars in Orion.', 3, 21.000);
INSERT INTO public.star OVERRIDING SYSTEM VALUE VALUES (6, 'VFTS 352', 'A massive binary star system located in the Large Magellanic Cloud.', 4, 28.000);


--
-- Name: comet_comet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.comet_comet_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: comet comet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.comet
    ADD CONSTRAINT comet_name_key UNIQUE (name);


--
-- Name: comet comet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.comet
    ADD CONSTRAINT comet_pkey PRIMARY KEY (comet_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star fk_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon fk_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: comet fk_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.comet
    ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

