drop table if exists user_info;

create table user_info (
	id integer primary key autoincrement,
	name text not null,
	email text not null,
	created_at text not null
);

drop table if exists user_auth;

create table user_auth (
	id integer primary key autoincrement,
	username text not null,
	password text not null,
	user_id integer not null,
	foreign key(user_id) references user_info(id)
);