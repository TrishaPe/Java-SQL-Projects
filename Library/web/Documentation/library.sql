
#TABLES

create table person(
	person_cod number,
	type varchar2(8),
	name varchar2(25),
	address varchar2(25)
)

alter table person
add constraint PK_person
primary key (person_cod);

create table books(
	book_cod number,
	isbn number,
	title varchar2(50),
	author_cod number,
	genre1 number,
	genre2 number,
	notes varchar2(80)
)

alter table books
add constraint PK_books
primary key (book_cod);

create table authors(
	author_cod number,
	name varchar2(25)
)

alter table authors
add constraint PK_author
primary key (author_cod);

create table genres(
	genre_cod number,
	genre varchar2(15)
)

alter table genres
add constraint PK_genre
primary key (genre_cod);

create table borrowed(
	book_cod number,
	person_cod number,
	borrowdate date,
	returndate date,
	fine number
)
#fine should be calculated automatically when return date is surpassed

create table borrowhist(
	book_cod number,
	person_cod number,
	borrowdate date,
	returndate date,
	fine number
)

#FOREIGN KEYS

alter table books
add constraint FK_author_book
foreign key (author_cod)
references authors (author_cod);

alter table books
add constraint FK_genre1_book
foreign key (genre1)
references genres (genre_cod);

alter table books
add constraint FK_genre2_book
foreign key (genre2)
references genres (genre_cod);

alter table borrowed
add constraint FK_book_borrowed
foreign key (book_cod)
references books (book_cod);

alter table borrowed
add constraint FK_person_borrowed
foreign key (person_cod)
references person (person_cod);

alter table borrowhist
add constraint FK_book_borrowhist
foreign key (book_cod)
references books (book_cod);

alter table borrowhist
add constraint FK_person_borrowhist
foreign key (person_cod)
references person (person_cod);

#SEQUENCES

create sequence SQ_person
	start with 1
	increment by 1;

create sequence SQ_book
	start with 1
	increment by 1;

create sequence SQ_author
	start with 1
	increment by 1;

create sequence SQ_genre
	start with 1
	increment by 1;

#TRIGGERS

create or replace trigger returnedbook
	before delete on borrowed
	for each row
	begin
	insert into borrowhist values (:old.book_cod, :old.person_cod, :old.borrowdate, sysdate, :old.fine);
end;

