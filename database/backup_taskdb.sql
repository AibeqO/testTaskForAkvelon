PGDMP     5                    z            task_db    14.2    14.1 "               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    24576    task_db    DATABASE     d   CREATE DATABASE task_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE task_db;
                postgres    false            I           1247    24596    project_status    TYPE     _   CREATE TYPE public.project_status AS ENUM (
    'NotStarted',
    'Active',
    'Completed'
);
 !   DROP TYPE public.project_status;
       public          postgres    false            L           1247    24604    task_status    TYPE     U   CREATE TYPE public.task_status AS ENUM (
    'ToDo',
    'InProgress',
    'Done'
);
    DROP TYPE public.task_status;
       public          postgres    false            ?            1255    24643 /   create_project(text, text, text, integer, text) 	   PROCEDURE     ?  CREATE PROCEDURE public.create_project(IN _project_name text, IN _start_date text, IN _completion_date text, IN _priority integer, IN _project_status text)
    LANGUAGE plpgsql
    AS $$
DECLARE
	sd date;
	ed date;
BEGIN
	sd = TO_DATE(_start_date,'DD.MM.YYYY');
	ed = TO_DATE(_completion_date,'DD.MM.YYYY');
	INSERT INTO project (project_name, start_date, completion_date, priority, status)
		VALUES
		(_project_name, sd, ed, _priority, _project_status::project_status);
END;
$$;
 ?   DROP PROCEDURE public.create_project(IN _project_name text, IN _start_date text, IN _completion_date text, IN _priority integer, IN _project_status text);
       public          postgres    false            ?            1255    24646 /   create_task(integer, text, text, integer, text) 	   PROCEDURE     X  CREATE PROCEDURE public.create_task(IN _project_id integer, IN _task_name text, IN _task_desc text, IN _priority integer, IN _status text)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO Task (project_id, task_name, task_description, priority, status)
		VALUES (_project_id, _task_name, _task_desc, _priority, _status::task_status);
END;
$$;
 ?   DROP PROCEDURE public.create_task(IN _project_id integer, IN _task_name text, IN _task_desc text, IN _priority integer, IN _status text);
       public          postgres    false            ?            1255    24617    delete_project(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_project(IN _project_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM project
		WHERE project_id = _project_id;
END;
$$;
 >   DROP PROCEDURE public.delete_project(IN _project_id integer);
       public          postgres    false            ?            1255    24630    delete_task(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.delete_task(IN _task_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM task
		WHERE task_id = _task_id;
END;
$$;
 8   DROP PROCEDURE public.delete_task(IN _task_id integer);
       public          postgres    false            ?            1255    24632    read_project()    FUNCTION     U  CREATE FUNCTION public.read_project() RETURNS TABLE("Project name" text, "Project start date" date, "Project completion date" date, "Project priority" integer, "Project status" public.project_status)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY SELECT project_name, start_date, completion_date, priority, status FROM project;
END;
$$;
 %   DROP FUNCTION public.read_project();
       public          postgres    false    841            ?            1255    24644    read_task()    FUNCTION       CREATE FUNCTION public.read_task() RETURNS TABLE("Task name" text, "Task description" text, "Task priority" integer, "Task status" public.task_status)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY (SELECT task_name, task_description, priority, status FROM task);
END;
$$;
 "   DROP FUNCTION public.read_task();
       public          postgres    false    844            ?            1255    24616 ,   update_project_completiondate(integer, date) 	   PROCEDURE     ?   CREATE PROCEDURE public.update_project_completiondate(IN _project_id integer, IN _completion_date date)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE project
		SET 
			completion_date = _completion_date
WHERE project_id = _project_id;
END;
$$;
 g   DROP PROCEDURE public.update_project_completiondate(IN _project_id integer, IN _completion_date date);
       public          postgres    false            ?            1255    24614 "   update_project_name(integer, text) 	   PROCEDURE     ?   CREATE PROCEDURE public.update_project_name(IN _project_id integer, IN _project_name text)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE project
		SET 
			project_name = _project_name
WHERE project_id = _project_id;
END;
$$;
 Z   DROP PROCEDURE public.update_project_name(IN _project_id integer, IN _project_name text);
       public          postgres    false            ?            1255    24615 '   update_project_startdate(integer, date) 	   PROCEDURE     ?   CREATE PROCEDURE public.update_project_startdate(IN _project_id integer, IN _start_date date)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE project
		SET 
			start_date = _start_date
WHERE project_id = _project_id;
END;
$$;
 ]   DROP PROCEDURE public.update_project_startdate(IN _project_id integer, IN _start_date date);
       public          postgres    false            ?            1255    24627 &   update_task_description(integer, text) 	   PROCEDURE     ?   CREATE PROCEDURE public.update_task_description(IN _task_id integer, IN _task_description text)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE Task
		SET
			task_description = _task_description
	WHERE task_id = _task_id;
END;
$$;
 _   DROP PROCEDURE public.update_task_description(IN _task_id integer, IN _task_description text);
       public          postgres    false            ?            1255    24626    update_task_name(integer, text) 	   PROCEDURE     ?   CREATE PROCEDURE public.update_task_name(IN _task_id integer, IN _task_name text)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE Task
		SET
			task_name = _task_name
	WHERE task_id = _task_id;
END;
$$;
 Q   DROP PROCEDURE public.update_task_name(IN _task_id integer, IN _task_name text);
       public          postgres    false            ?            1255    24628 &   update_task_priority(integer, integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.update_task_priority(IN _task_id integer, IN _task_priority integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE Task
		SET
			priority = _task_priority
	WHERE task_id = _task_id;
END;
$$;
 \   DROP PROCEDURE public.update_task_priority(IN _task_id integer, IN _task_priority integer);
       public          postgres    false            ?            1255    24629 /   update_task_status(integer, public.task_status) 	   PROCEDURE     ?   CREATE PROCEDURE public.update_task_status(IN _task_id integer, IN _task_status public.task_status)
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE Task
		SET
			status = _task_status
	WHERE task_id = _task_id;
END;
$$;
 c   DROP PROCEDURE public.update_task_status(IN _task_id integer, IN _task_status public.task_status);
       public          postgres    false    844            ?            1259    24578    task    TABLE     ?   CREATE TABLE public.task (
    task_id integer NOT NULL,
    task_name text NOT NULL,
    task_description text NOT NULL,
    priority integer NOT NULL,
    status public.task_status NOT NULL,
    project_id integer NOT NULL
);
    DROP TABLE public.task;
       public         heap    postgres    false    844            ?            1259    24577    Task_task_id_seq    SEQUENCE     ?   CREATE SEQUENCE public."Task_task_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Task_task_id_seq";
       public          postgres    false    210                       0    0    Task_task_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Task_task_id_seq" OWNED BY public.task.task_id;
          public          postgres    false    209            ?            1259    24587    project    TABLE     ?   CREATE TABLE public.project (
    project_id integer NOT NULL,
    project_name text NOT NULL,
    start_date date NOT NULL,
    completion_date date,
    priority integer NOT NULL,
    status public.project_status NOT NULL
);
    DROP TABLE public.project;
       public         heap    postgres    false    841            ?            1259    24586    project_project_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.project_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.project_project_id_seq;
       public          postgres    false    212                       0    0    project_project_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.project_project_id_seq OWNED BY public.project.project_id;
          public          postgres    false    211            u           2604    24590    project project_id    DEFAULT     x   ALTER TABLE ONLY public.project ALTER COLUMN project_id SET DEFAULT nextval('public.project_project_id_seq'::regclass);
 A   ALTER TABLE public.project ALTER COLUMN project_id DROP DEFAULT;
       public          postgres    false    211    212    212            t           2604    24581    task task_id    DEFAULT     n   ALTER TABLE ONLY public.task ALTER COLUMN task_id SET DEFAULT nextval('public."Task_task_id_seq"'::regclass);
 ;   ALTER TABLE public.task ALTER COLUMN task_id DROP DEFAULT;
       public          postgres    false    209    210    210            	          0    24587    project 
   TABLE DATA           j   COPY public.project (project_id, project_name, start_date, completion_date, priority, status) FROM stdin;
    public          postgres    false    212   ?0                 0    24578    task 
   TABLE DATA           b   COPY public.task (task_id, task_name, task_description, priority, status, project_id) FROM stdin;
    public          postgres    false    210   \0                  0    0    Task_task_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Task_task_id_seq"', 2, true);
          public          postgres    false    209                       0    0    project_project_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.project_project_id_seq', 2, true);
          public          postgres    false    211            w           2606    24585    task Task_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.task
    ADD CONSTRAINT "Task_pkey" PRIMARY KEY (task_id);
 :   ALTER TABLE ONLY public.task DROP CONSTRAINT "Task_pkey";
       public            postgres    false    210            y           2606    24594    project project_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (project_id);
 >   ALTER TABLE ONLY public.project DROP CONSTRAINT project_pkey;
       public            postgres    false    212            z           2606    24618    task ProjectFKey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.task
    ADD CONSTRAINT "ProjectFKey" FOREIGN KEY (project_id) REFERENCES public.project(project_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 <   ALTER TABLE ONLY public.task DROP CONSTRAINT "ProjectFKey";
       public          postgres    false    210    3193    212            	      x?????? ? ?            x?????? ? ?     