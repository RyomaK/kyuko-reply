create table users
(
	user_id text primary key,
	user_name text,
  	lesson_id text
);

create table lessons
(
	lesson_id text ,
	lesson_name text,
  	teacher text,
  	campus text
);