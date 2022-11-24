CREATE TABLE person (
 id SERIAL NOT NULL,
 first_name VARCHAR(20) NOT NULL,
 last_name VARCHAR(20) NOT NULL,
 email VARCHAR(50) NOT NULL,
 address VARCHAR(500) NOT NULL,
 person_number VARCHAR(12) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE phone_number (
 id SERIAL NOT NULL,
 number VARCHAR(10)
);

ALTER TABLE phone_number ADD CONSTRAINT PK_phone_number PRIMARY KEY (id);


CREATE TABLE student (
 id SERIAL NOT NULL,
 contact_person VARCHAR(200) NOT NULL,
 present_skill VARCHAR(50) NOT NULL,
 number_of_lessons_taken VARCHAR(10) NOT NULL,
 instrument_to_learn VARCHAR(50) NOT NULL,
 rented_instrument VARCHAR(50),
 person_id SERIAL NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE instructor (
 id SERIAL NOT NULL,
 assigned_lesson VARCHAR(10) NOT NULL,
 instruments_tought VARCHAR(100) NOT NULL,
 person_id SERIAL NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instrument (
 id SERIAL NOT NULL,
 instrument_ID VARCHAR(50) NOT NULL,
 quantity_available VARCHAR(10) NOT NULL,
 rent_fee VARCHAR(10),
 rent_period TIMESTAMP(12),
 student_id SERIAL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE lesson (
 id SERIAL NOT NULL,
 place VARCHAR(50) NOT NULL,
 instrument VARCHAR(50),
 student_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE payment (
 id SERIAL NOT NULL,
 student_payment VARCHAR(10) NOT NULL,
 instructor_salary VARCHAR(10) NOT NULL,
 student_id SERIAL,
 instructor_id SERIAL
);

ALTER TABLE payment ADD CONSTRAINT PK_payment PRIMARY KEY (id);


CREATE TABLE person_phone (
 person_id SERIAL NOT NULL,
 phone_id SERIAL NOT NULL
);

ALTER TABLE person_phone ADD CONSTRAINT PK_person_phone PRIMARY KEY (person_id,phone_id);


CREATE TABLE pricing (
 id VARCHAR(10) NOT NULL,
 skill_level VARCHAR(50) NOT NULL,
 lesson_type VARCHAR(50) NOT NULL,
 price VARCHAR(10) NOT NULL,
 lesson_id SERIAL NOT NULL
);

ALTER TABLE pricing ADD CONSTRAINT PK_pricing PRIMARY KEY (id);


CREATE TABLE sibilings (
 student_id SERIAL NOT NULL,
 id SERIAL NOT NULL,
 sibiling_list CHAR(500)
);

ALTER TABLE sibilings ADD CONSTRAINT PK_sibilings PRIMARY KEY (student_id,id);


CREATE TABLE timeslot (
 id SERIAL NOT NULL,
 date DATE NOT NULL,
 time TIME NOT NULL,
 lesson_id SERIAL NOT NULL
);

ALTER TABLE timeslot ADD CONSTRAINT PK_timeslot PRIMARY KEY (id);


CREATE TABLE ensembles (
 lesson_id SERIAL NOT NULL,
 genre VARCHAR(100) NOT NULL,
 max_amount_of_students VARCHAR(10) NOT NULL,
 min_amount_of_students VARCHAR(10) NOT NULL,
 cost VARCHAR(10) NOT NULL
);

ALTER TABLE ensembles ADD CONSTRAINT PK_ensembles PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id SERIAL NOT NULL,
 mini_number_of_students VARCHAR(10) NOT NULL,
 groups VARCHAR(100) NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE payment ADD CONSTRAINT FK_payment_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE payment ADD CONSTRAINT FK_payment_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_0 FOREIGN KEY (person_id) REFERENCES person (id);
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_1 FOREIGN KEY (phone_id) REFERENCES phone_number (id);


ALTER TABLE pricing ADD CONSTRAINT FK_pricing_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE sibilings ADD CONSTRAINT FK_sibilings_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE timeslot ADD CONSTRAINT FK_timeslot_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE ensembles ADD CONSTRAINT FK_ensembles_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


