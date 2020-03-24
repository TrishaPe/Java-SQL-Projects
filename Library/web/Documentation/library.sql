
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
    notes varchar2(50)
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
)
/*Fine should be calculated automatically when return date is surpassed. This date can be extended upon request,
for maximum one week for students and two weeks for faculty and staff (a week is 7 natural days).
Fine is 0.5$ per day for students, 0.3$ for staff and faculty.
Fines start on the 15th day from borrowdate for students and on the 20th day for staff and faculty.
If the indicated return date falls on a weekend, the book can be returned the following monday at the latest.
From Tuesday onward fines will start adding up.
Fine will be calculated by the java repository on the moment the data is requested, and will be saved into the
borrow-history table by the same repo at the moment the book is returned and the line in question erased from
the borrowed table. This means the originally planned trigger moving data from borrowed to borrowhist upon delete
is unnecessary.
Another option would be to have a 'fine' field in the borrowed table and a job to have the database automatically
calculate and save all fines every night (and have the aforementioned trigger in place), but this is easier and
less resource-heavy.*/

create table borrowhist(
    book_cod number,
    person_cod number,
    borrowdate date,
    returndate date,
    fine float
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
	start with 1000
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


#CONTENT

insert into person values (SQ_person.nextval, 'staff', 'Moreno Ramos Julia', 'Calle de Hortaleza 3');
insert into person values (SQ_person.nextval, 'faculty', 'Hernández Romero Diego', 'Calle de la Puebla 9');
insert into person values (SQ_person.nextval, 'student', 'Rodríguez Torres Blanca', 'Calle de la Beneficiencia 244');
insert into person values (SQ_person.nextval, 'student', 'Gómez Vaca Gonzalo', 'Calle Serrano 35');
insert into person values (SQ_person.nextval, 'faculty', 'Martín Jiménez Nerea', 'Calle de los Caños del Peral 73');
insert into person values (SQ_person.nextval, 'student', 'Ruiz Díaz Hugo', 'Calle San Gregorio 12');
insert into person values (SQ_person.nextval, 'student', 'Navarro Domínguez Cloe', 'Calle del Monte Esquinza 15');
insert into person values (SQ_person.nextval, 'faculty', 'García Martínez Pablo', 'Calle de Luchana 21');
insert into person values (SQ_person.nextval, 'student', 'Álvarez García Rocío', 'Calle de Breton de los Herreros 64');
insert into person values (SQ_person.nextval, 'staff', 'Alonso López Ángel', 'Calle Vitruvio 11');10
insert into person values (SQ_person.nextval, 'faculty', 'Vázquez Romero Alicia', 'Calle de Garcia de Paredes 104');
insert into person values (SQ_person.nextval, 'student', 'Rey Sánchez Antonio', 'Calle Lecumberri 44');
insert into person values (SQ_person.nextval, 'student', 'Pérez Pérez Marina', 'Calle Cuevas Bajas 5');
insert into person values (SQ_person.nextval, 'faculty', 'Gutiérrez Moreno Iván', 'Calle del Corindon 19');
insert into person values (SQ_person.nextval, 'student', 'Del Rio Merino Lara', 'Calle Popular Madrilena 33');
insert into person values (SQ_person.nextval, 'staff', 'Diaz Moreno Adrián', 'Calle Gral. Marva 8');
insert into person values (SQ_person.nextval, 'faculty', 'Carrasco Lopez Nora', 'Calle Julio Domingo 59');
insert into person values (SQ_person.nextval, 'student', 'Cano Gil José', 'Calle de Peñafiel 41');
insert into person values (SQ_person.nextval, 'student', 'Hernandez Leon Elena', 'Calle del Tercio 28');
insert into person values (SQ_person.nextval, 'faculty', 'Madridejos Romero Enzo', 'Calle de Rascon 3');20
insert into person values (SQ_person.nextval, 'student', 'Gonzalo Pintor Ariana', 'Calle de Alarico 12');
insert into person values (SQ_person.nextval, 'staff', 'Ramos Zapatero Juan', 'Calle Antonio Zamora 97');
insert into person values (SQ_person.nextval, 'faculty', 'Moales del Rey Candela', 'Calle de las Trompas 13');
insert into person values (SQ_person.nextval, 'student', 'Alonso Salvador Miguel', 'Carretera Barrio de la Fortuna 2');
insert into person values (SQ_person.nextval, 'student', 'Cantis Rubira Claudia', 'Calle Rompedizo 26');
insert into person values (SQ_person.nextval, 'faculty', 'Jover Alday Iñaki', 'Calle Garapalo 10');
insert into person values (SQ_person.nextval, 'student', 'Alaez Dolera Leire', 'Avenida de las Aguilas 255');
insert into person values (SQ_person.nextval, 'student', 'Espinar Aguilar Álvaro', 'Calle Gordolobo 23');
insert into person values (SQ_person.nextval, 'faculty', 'Díaz Martín Irene', 'Calle de Mataró 8');
insert into person values (SQ_person.nextval, 'student', 'Fernández Viguera Daniel', 'Calle de Badalona 116');30
insert into person values (SQ_person.nextval, 'student', 'Ferrer Ruiz Lola', 'Calle de Molins del Rey 8');
insert into person values (SQ_person.nextval, 'faculty', 'Fontecha Lopez Mateo', 'Calle Isla de Rodas 65');
insert into person values (SQ_person.nextval, 'student', 'Martínez Collado Valeria', 'Calle Cerrillo 15');
insert into person values (SQ_person.nextval, 'student', 'García Sánchez Alejandro', 'Plaza Tres Olivos 26');
insert into person values (SQ_person.nextval, 'faculty', 'Arnal Claro Marta', 'Calle de Tumaco 51');
insert into person values (SQ_person.nextval, 'student', 'Miranda Torres Ruben', 'Calle del Ferrocarril 16');
insert into person values (SQ_person.nextval, 'staff', 'Alvarez Jimeno Julieta', 'Avenida de Navidad 1');
insert into person values (SQ_person.nextval, 'faculty', 'Trujillo Ramos Romeo', 'Calle del Cuervo 340');
insert into person values (SQ_person.nextval, 'student', 'Cano De Ora Rosa', 'Calle Diagonal 211');
insert into person values (SQ_person.nextval, 'student', 'Gómez Torralbo Marcos', 'Calle de Gravina 12');40
insert into person values (SQ_person.nextval, 'faculty', 'Murillo de la Vega Elsa', 'Calle de la Libertad 30');
insert into person values (SQ_person.nextval, 'student', 'Nevado Mendez Lucas', 'Plaza de las Salesas 8');
insert into person values (SQ_person.nextval, 'student', 'Lago Correa Alba', 'Calle de Perez Galdos 36');
insert into person values (SQ_person.nextval, 'faculty', 'Diez Marzo Jorge', 'Calle de Hortaleza 3');
insert into person values (SQ_person.nextval, 'student', 'Pastor de Celis Paula', 'Calle de San Lucas 5');45

insert into books values (SQ_book.nextval, 9780141199078, 'Pride and Prejudice', 1, 1, 2, 'Depository');
insert into books values (SQ_book.nextval, 9781784752637, 'To Kill a Mockingbird', 2, 4, null, null);
insert into books values (SQ_book.nextval, 9780141182636, 'The Great Gatsby', 3, 5, null, null);
insert into books values (SQ_book.nextval, 9780241968581, 'One Hundred Years of Solitude', 4, 6, null, null);
insert into books values (SQ_book.nextval, 9780241281901, 'Wide Sargasso Sea', 5, 8, null, null);
insert into books values (SQ_book.nextval, 9780141441146, 'Jane Eyre', 6, 1, null, 'Depository');
insert into books values (SQ_book.nextval, 9781784870140, 'Brave New World', 7, 9, 10, null);
insert into books values (SQ_book.nextval, 9780140449136, 'Crime and Punishment', 8, 11, 12, 'Depository');
insert into books values (SQ_book.nextval, 9780141321059, 'The Call of the Wild', 9, 13, null, null);
insert into books values (SQ_book.nextval, 9780141199870, 'Mansfield Park', 1, 3, null, 'In restoration until 06/15');
insert into books values (SQ_book.nextval, 9780142437247, 'Moby-Dick', 10, 13, 14, null);
insert into books values (SQ_book.nextval, 9780060281373, 'The Complete Chronicles of Narnia', 11, 15, 14, null);
insert into books values (SQ_book.nextval, 9780241341681, 'To the Lighthouse', 12, 7, null, 'Depository');
insert into books values (SQ_book.nextval, 9780141973883, 'Frankenstein', 13, 17, 16, null);
insert into books values (SQ_book.nextval, 9780141187761, 'Nineteen Eighty-Four', 14, 9, null, null);
insert into books values (SQ_book.nextval, 9780099511656, 'Beloved', 15, 18, null, null);
insert into books values (SQ_book.nextval, 9780141439846, 'Dracula', 16, 17, 16, null);
insert into books values (SQ_book.nextval, 9780345339683, 'The Hobbit', 17, 15, 13, null);
insert into books values (SQ_book.nextval, 9780141198835, 'Persuasion', 1, 1, null, 'Depository');
insert into books values (SQ_book.nextval, 9780143107323, 'The Adventures of Huckleberry Finn', 18, 19, null, null);
insert into books values (SQ_book.nextval, 9780141439563, 'Great Expectations', 19, 4, null, null);
insert into books values (SQ_book.nextval, 9780140189704, 'The Age of Innocence', 20, 1, null, null);
insert into books values (SQ_book.nextval, 9780563528883, 'The Lord of the Rings Trilogy', 17, 15, 14, null);
insert into books values (SQ_book.nextval, 9780060281373, 'The Complete Chronicles of Narnia', 11, 14, 13, null);
insert into books values (SQ_book.nextval, 9780141023380, 'Things Fall Apart', 21, 18, null, null);
insert into books values (SQ_book.nextval, 9780099582076, 'Midnights Children', 22, 6, null, null);
insert into books values (SQ_book.nextval, 9780241950432, 'The Catcher in the Rye', 23, 4, null, null);
insert into books values (SQ_book.nextval, 9780141392462, 'The Count of Monte Cristo', 24, 13, null, 'Depository');
insert into books values (SQ_book.nextval, 9780141188935, 'Atlas Shrugged', 25, 9, 12, null);
insert into books values (SQ_book.nextval, 9781936594054, 'The War of the Worlds', 26, 10, null, 'Depository');

insert into authors values (SQ_author.nextval, 'Austen, Jane');1
insert into authors values (SQ_author.nextval, 'Lee, Harper');2
insert into authors values (SQ_author.nextval, 'Fitzgerald, F. Scott');3
insert into authors values (SQ_author.nextval, 'García Márquez, Gabriel');4
insert into authors values (SQ_author.nextval, 'Rhys, Jean');5
insert into authors values (SQ_author.nextval, 'Brontë, Charlotte');6
insert into authors values (SQ_author.nextval, 'Huxley, Aldous');7
insert into authors values (SQ_author.nextval, 'Dostoevsky, Fyodor');8
insert into authors values (SQ_author.nextval, 'London, Jack');9
insert into authors values (SQ_author.nextval, 'Melville, Herman');10
insert into authors values (SQ_author.nextval, 'Lewis, C.S.');11
insert into authors values (SQ_author.nextval, 'Woolf, Virginia');12
insert into authors values (SQ_author.nextval, 'Shelley, Mary');13
insert into authors values (SQ_author.nextval, 'Orwell, George');14
insert into authors values (SQ_author.nextval, 'Morrison, Toni');15
insert into authors values (SQ_author.nextval, 'Stoker, Bram');16
insert into authors values (SQ_author.nextval, 'Tolkien, J.R.R.');17
insert into authors values (SQ_author.nextval, 'Twain, Mark');18
insert into authors values (SQ_author.nextval, 'Dickens, Charles');19
insert into authors values (SQ_author.nextval, 'Warton, Edith');20
insert into authors values (SQ_author.nextval, 'Achebe, Chinua');21
insert into authors values (SQ_author.nextval, 'Rushdie, Salman');22
insert into authors values (SQ_author.nextval, 'Salinger, J.D.');23
insert into authors values (SQ_author.nextval, 'Dumas, Alexandre');24
insert into authors values (SQ_author.nextval, 'Rand, Ayn');25
insert into authors values (SQ_author.nextval, 'Wells, H.G.');26

insert into genres values (SQ_genre.nextval, 'Romance');1
insert into genres values (SQ_genre.nextval, 'Novel of manners');2
insert into genres values (SQ_genre.nextval, 'Realism');3
insert into genres values (SQ_genre.nextval, 'Bildungsroman');4
insert into genres values (SQ_genre.nextval, 'Tragedy');5
insert into genres values (SQ_genre.nextval, 'Magical Realism');6
insert into genres values (SQ_genre.nextval, 'Modernism');7
insert into genres values (SQ_genre.nextval, 'Postmodernism');8
insert into genres values (SQ_genre.nextval, 'Dystopia');9
insert into genres values (SQ_genre.nextval, 'Science Fiction');10
insert into genres values (SQ_genre.nextval, 'Crime');11
insert into genres values (SQ_genre.nextval, 'Psychological');12
insert into genres values (SQ_genre.nextval, 'Adventure');13
insert into genres values (SQ_genre.nextval, 'Epic');14
insert into genres values (SQ_genre.nextval, 'Fantasy');15
insert into genres values (SQ_genre.nextval, 'Horror');16
insert into genres values (SQ_genre.nextval, 'Gothic');17
insert into genres values (SQ_genre.nextval, 'Historical Fiction');18
insert into genres values (SQ_genre.nextval, 'Picaresque');19

insert into borrowed values (5, 32, '25-03-2020', '14-04-2020');
insert into borrowed values (24, 4, '02-03-2020', '23-03-2020');
insert into borrowed values (29, 16, '04-03-2020', '31-03-2020');
insert into borrowed values (11, 45, '04-06-2019', '25-06-2019');

insert into borrowhist values (27, 22, '21-02-2020', '25-03-2020', 9.9);
insert into borrowhist values (6, 30, '26-02-2020', '06-03-2020', 0);
insert into borrowhist values (2, 5, '05-03-2020', '19-03-2020', 0);
insert into borrowhist values (8, 19, '20-03-2020', '23-03-2020', 0);
insert into borrowhist values (29, 8, '02-03-2020', '25-03-2020', 0.9);

