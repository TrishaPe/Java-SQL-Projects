
#TABLAS

create table empleados(
	emp_cod number,
	apellidos varchar2(25),
	enombre varchar2(15),
	direccion varchar2(40),
	telefono number,
	funcion varchar2(15),
	salario number,
	dept_cod number,
	usuario varchar2(8),
	contraseña varchar2(8)
);

alter table empleados
add constraint PK_empleado
primary key (emp_cod);


create table departamentos(
	dept_cod number,
	dnombre varchar2(15)
);

alter table departamentos
add constraint PK_departamento
primary key (dept_cod);


create table animales(
	animal_cod number,
	dept_cod number,
	anombre varchar2(10),
	sexo varchar2(1),
	especie varchar2(20),
	emp_cod number,
	foto varchar2(25),
	dieta varchar2(50),
	notas varchar2(50),
	fecha date
);

alter table animales
add constraint PK_animal
primary key (animal_cod);

create table histnotas(
	animal_cod number,
	fecha date,
	notas varchar2(50),
);


create table citaveterinario(
	animal_cod number,
	fecha date default null,
	notas varchar2(50) default null
);
#hay que pedir cita antes de poder meter fecha en la tabla - en la app, peticion al gestor para pedir cita


create table histveterinario(
	animal_cod number,
	fecha date,
	notas varchar2(50) default null
);

create table peticiones(
	peticion_cod number,
	especie varchar2(15),
	dept_cod number,
	contenido varchar2(50),
	fecha_meta date,
	listo varchar2(2)
);
#la idea es de entrar el pedido_cod cuando el pedido es enviado al proveedor, para señalarle a los empleados que está de camino.
#no puedo convertir pedido_cod en Foreign Key porque en el momento de someter la peticion, todavía no habrá pedido asociado.
#Por esto también, en el formulario, hay que poner el campo de pedido_cod como opcional.

alter table peticiones
add constraint PK_peticion
primary key (dept_cod, fecha_meta);

create table proveedores(
	proveedor_cod number,
	pnombre varchar2(20)
)

alter table proveedores
add constraint PK_proveedor
primary key (proveedor_cod);


create table pedidos(
	pedido_cod number,
	contenido varchar2(50),
	precio number,
	proveedor_cod number,
	fecha date,
	llegado varchar2(2)
);

alter table pedidos
add constraint PK_pedido
primary key (pedido_cod);

create table pet_ped(
	peticion_cod number,
	pedido_cod number
);

create table histpedidos(
	pedido_cod number,
	contenido varchar2(50),
	proveedor_cod number,
	precio number,
	fecha date
);

create table vacaciones(
	emp_cod number,
	tipo varchar2(15),
	fecha_in date,
	fecha_fin date,
	aprobado varchar2(4)
);

create table histvacaciones(
	emp_cod number,
	tipo varchar2(15),
	fecha_in date,
	fecha_fin date
);

create table clientes(
	cliente_cod number,
	apellidos varchar2(25),
	cnombre varchar2(15),
	correo varchar2(30),
	usuario varchar2(20),
	contraseña varchar2(15),
	entrada_cod number,
	fecha_in date,
	fecha_cad date,
	news varchar2(1)
);

alter table clientes
add constraint PK_cliente
primary key (cliente_cod);


create table entradas(
	entrada_cod number,
	enombre varchar2(17),
	tipo varchar2(75),
	precio number,
	duracion number
);
#duracion en numero de meses

alter table entradas
add constraint PK_entrada
primary key (entrada_cod);


create table ventas(
	entrada_cod number,
	cliente_cod number,
	cantidad number,
	fecha_in date
);
#no puedo hacer cliente_cod un foreign key porque los clientes que compren en taquilla no dejan sus datos - solo los que compren por internet
#funcionamiento de tabla ventas: en taquilla, el cliente no deja datos, así que con cada compra, registramos tipos de entradas y cantidades y añadimos
#esa cantidad al numero total de entradas de ese tipo vendido en esa fecha. Por internet, los clientes dejan sus datos, así que podemos aparear clientes
#con compras. En ese caso, en la tabla registramos codigo de cliente con cada tipo de entrada (compra dos adultos y dos niños, la tabla dice que 2 niños
#fueron comprado por cliente 84, y debajo que dos adultos fueron comprado por cliente 84, ambos en fecha de 1/1/19). Esto es factible con un login de cliente
#donde él pueda comprar, y el login de empleado de taquilla donde el/ella tiene su pagina de seleccionar tipos y cantidades. El empleado tiene que tener un
#boton que lleve a un formulario por si el cliente quiere pedir las entradas de largo plazo en taquilla.

#FOREIGN KEYS

alter table animales
add constraint FK_departamento_animal
foreign key (dept_cod)
references departamentos (dept_cod);

alter table histnotas
add constraint FK_animal_histnotas
foreign key (animal_cod)
references animales (animal_cod);


alter table empleados
add constraint FK_departamento_empleado
foreign key (dept_cod)
references departamentos (dept_cod);

alter table citaveterinario
add constraint FK_animal_cita
foreign key (animal_cod)
references animales (animal_cod);

alter table histveterinario
add constraint FK_animal_hist
foreign key (animal_cod)
references animales (animal_cod);

alter table peticiones
add constraint FK_departamento_peticion
foreign key (dept_cod)
references departamentos (dept_cod);

alter table animales
add constraint FK_empleado_animal
foreign key (emp_cod)
references empleados (emp_cod);

alter table clientes_l
add constraint FK_entrada_cliente_l
foreign key (entrada_cod)
references entradas (entrada_cod);

alter table ventas
add constraint FK_entrada_venta
foreign key (entrada_cod)
references entradas (entrada_cod);



#TRIGGERS
create or replace trigger histcita
  before delete on citaveterinario
  for each row
  begin
  insert into histveterinario values (:OLD.animal_cod, :OLD.fecha, :OLD.notas);
end;


create or replace trigger histpedido
  before delete on pedidos
  for each row
  begin
  insert into histpedidos values (:OLD.pedido_cod, :OLD.contenido, :OLD.precio, :OLD.fecha);
end;

create or replace trigger histnota
  before update on animales
  for each row
  begin
  insert into histnotas values (:OLD.animal_cod, :OLD.fecha, :OLD.notas);
end;

create or replace trigger citanota
after insert on citaveterinario
for each row
  begin
    insert into animales (animal_cod, fecha, notas) values (:new.animal_cod, :new.fecha, :new.notas);
end;

#SECUENCIAS

create sequence SQ_departamento
start with 1
increment by 1;

create sequence SQ_animal
start with 1
increment by 1;

create sequence SQ_peticion
start with 1
increment by 1;

create sequence SQ_pedido
start with 19001
increment by 1;

create sequence SQ_cliente
start with 1
increment by 1;

create sequence SQ_entrada
start with 1
increment by 1;


#CONTENIDO

insert into departamentos values (SQ_departamento.nextval, 'administracion'); 1
insert into departamentos values (SQ_departamento.nextval, 'reptiles'); 2
insert into departamentos values (SQ_departamento.nextval, 'africa'); 2
insert into departamentos values (SQ_departamento.nextval, 'asia'); 2
insert into departamentos values (SQ_departamento.nextval, 'australia'); 2
insert into departamentos values (SQ_departamento.nextval, 'sudamerica'); 2
insert into departamentos values (SQ_departamento.nextval, 'norteamerica'); 2
insert into departamentos values (SQ_departamento.nextval, 'taquilla'); 3
insert into departamentos values (SQ_departamento.nextval, 'otros'); 4


insert into empleados values (1054, 'Moreno Ramos', 'Julia', 'Calle de Hortaleza 3', 694623456, 'administrador', 1);
insert into empleados values (1073, 'Hernández Romero', 'Diego', 'Calle de la Puebla 9', 693458329, 'administrador', 1);
insert into empleados values (1056, 'Rodríguez Torres', 'Blanca', 'Calle de la Beneficiencia 244', 675948243, 'CEO', 1);
insert into empleados values (1100, 'Gómez Vaca', 'Gonzalo', 'Calle Serrano 35', 65600358, 'contable', 1);
insert into empleados values (1078, 'Martín Jiménez', 'Nerea', 'Calle de los Caños del Peral 73', 694574539, 'gestor', 1);
insert into empleados values (1023, 'Ruiz Díaz', 'Hugo', 'Calle San Gregorio 12', 642583584, 'gestor', 1);

insert into empleados values (2106, 'Navarro Domínguez', 'Cloe', 'Calle del Monte Esquinza 15', 679352705, 'gestor', 2);
insert into empleados values (2051, 'García Martínez', 'Pablo', 'Calle de Luchana 21', 626725922, 'cuidador', 2);
insert into empleados values (2011, 'Álvarez García', 'Rocío', 'Calle de Breton de los Herreros 64', 663452589, 'cuidador', 2);
insert into empleados values (2065, 'Alonso López', 'Ángel', 'Calle Vitruvio 11', 634735790, 'limpieza', 2);

insert into empleados values (3107, 'Vázquez Romero', 'Alicia', 'Calle de Garcia de Paredes 104', 694673352, 'gestor', 3);
insert into empleados values (3233, 'Rey Sánchez', 'Antonio', 'Calle Lecumberri 44', 646765579, 'becario', 3);
insert into empleados values (3010, 'Pérez Pérez', 'Marina', 'Calle Cuevas Bajas 5', 646956966, 'cuidador', 3);
insert into empleados values (3082, 'Gutiérrez Moreno', 'Iván', 'Calle del Corindon 19', 623568422, 'cuidador', 3);
insert into empleados values (3073, 'Del Rio Merino', 'Lara', 'Calle Popular Madrilena 33', 634688442, 'limpieza', 3);

insert into empleados values (4110, 'Diaz Moreno', 'Adrián', 'Calle Gral. Marva 8', 656635905, 'gestor', 4);
insert into empleados values (4043, 'Carrasco Lopez', 'Nora', 'Calle Julio Domingo 59', 644895446, 'cuidador', 4);
insert into empleados values (4031, 'Cano Gil', 'José', 'Calle de Peñafiel 41', 695675322, 'cuidador', 4);
insert into empleados values (4074, 'Hernandez Leon', 'Elena', 'Calle del Tercio 28', 694687533, 'limpieza', 4);

insert into empleados values (5102, 'Madridejos Romero', 'Enzo', 'Calle de Rascon 3', 694687575, 'gestor', 5);
insert into empleados values (5042, 'Gonzalo Pintor', 'Ariana', 'Calle de Alarico 12', 694790644, 'cuidador', 5);
insert into empleados values (5066, 'Ramos Zapatero', 'Juan', 'Calle Antonio Zamora 97', 693685753, 'cuidador', 5);
insert into empleados values (5019, 'Moales del Rey', 'Candela', 'Calle de las Trompas 13', 694895796, 'limpieza', 5);
insert into empleados values (5068, 'Alonso Salvador', 'Miguel', 'Carretera Barrio de la Fortuna 2', 699869543, 'limpieza', 5);
insert into empleados values (5051, 'Cantis Rubira', 'Claudia', 'Calle Rompedizo 26', 693579966, 'cuidador', 5);

insert into empleados values (6107, 'Jover Alday', 'Iñaki', 'Calle Garapalo 10', 694685325, 'gestor', 6);
insert into empleados values (6239, 'Alaez Dolera', 'Leire', 'Avenida de las Aguilas 255', 696786544, 'becario', 6);
insert into empleados values (6083, 'Espinar Aguilar', 'Álvaro', 'Calle Gordolobo 23', 696853568, 'cuidador', 6);
insert into empleados values (6017, 'Díaz Martín', 'Irene', 'Calle de Mataró 8', 694686654, 'limpieza', 6);

insert into empleados values (7112, 'Fernández Viguera', 'Daniel', 'Calle de Badalona 116', 695785545, 'gestor', 7);
insert into empleados values (7022, 'Ferrer Ruiz', 'Lola', 'Calle de Molins del Rey 8', 6965445688, 'cuidador', 7);
insert into empleados values (7254, 'Fontecha Lopez', 'Mateo', 'Calle Isla de Rodas 65', 697905387, 'becario', 7);
insert into empleados values (7045, 'Martínez Collado', 'Valeria', 'Calle Cerrillo 15', 697942367, 'limpieza', 7);
insert into empleados values (7071, 'García Sánchez', 'Alejandro', 'Plaza Tres Olivos 26', 698688578, 'cuidador' , 7);
insert into empleados values (7042, 'Arnal Claro', 'Marta', 'Calle de Tumaco 51', 694696864, 'cuidador', 7);

insert into empleados values (8043, 'Miranda Torres', 'Ruben', 'Calle del Ferrocarril 16', 696755732, 'taquillero' , 8);
insert into empleados values (8107, 'Alvarez Jimeno', 'Julieta', 'Avenida de Navidad 1', 696588733, 'gestor' , 8);
insert into empleados values (8091, 'Trujillo Ramos', 'Romeo', 'Calle del Cuervo 340', 697521332, 'taquillero' , 8);
insert into empleados values (8063, 'Cano De Ora', 'Rosa', 'Calle Diagonal 211', 697599953, 'taquillero' , 8);

insert into empleados values (9101, 'Gómez Torralbo', 'Marcos', 'Calle de Gravina 12', 694562123, 'gestor' , 9);
insert into empleados values (9065, 'Murillo de la Vega', 'Elsa', 'Calle de la Libertad 30', 6947843212, 'jardinero', 9);
insert into empleados values (9067, 'Nevado Mendez', 'Lucas', 'Plaza de las Salesas 8', 695753139, 'jardinero', 9);
insert into empleados values (9078, 'Lago Correa', 'Alba', 'Calle de Perez Galdos 36', 693578534, 'tecnico', 9);
insert into empleados values (9031, 'Diez Marzo', 'Jorge', 'Calle de Hortaleza 3', 693464323, 'tecnico', 9);
insert into empleados values (9041, 'Pastor de Celis', 'Paula', 'Calle de San Lucas 5', 695797536, 'tecnico', 9);


insert into animales values (SQ_animal.nextval, 2, 'Lin', 'F', 'gecko tokay', 'insectos', 'N/A', 2051);
insert into animales values (SQ_animal.nextval, 2, 'Prisca', 'F', 'camaleon pantera', 'insectos', 'N/A', 2051);
insert into animales values (SQ_animal.nextval, 2, 'Pjotr', 'M', 'tortuga rusa', 'hojas', 'N/A', 2011);
insert into animales values (SQ_animal.nextval, 2, 'Saray', 'M', 'tortuga mora', 'hojas', 'N/A', 2011);
insert into animales values (SQ_animal.nextval, 2, 'Hernanda', 'F', 'boa constrictor', 'ratones', 'infeccion ojo, crema 3/dia', 2051);
insert into animales values (SQ_animal.nextval, 2, 'Mali', 'F', 'piton real', 'ratones', 'N/A', 2011);
insert into animales values (SQ_animal.nextval, 2, 'George', 'M', 'tortuga galapagos', 'hojas', 'N/A', 2011);

insert into animales values (SQ_animal.nextval, 3, 'Mufasa', 'M', 'leon', 'carne', 'N/A', 3010);
insert into animales values (SQ_animal.nextval, 3, 'Sarabi', 'F', 'leon', 'carne', 'N/A', 3010);
insert into animales values (SQ_animal.nextval, 3, 'Nala', 'F', 'leon', 'carne', 'N/A', 3010);
insert into animales values (SQ_animal.nextval, 3, 'Mabuti', 'M', 'girafa', 'hojas', 'N/A', 3082);
insert into animales values (SQ_animal.nextval, 3, 'Rafiki', 'M', 'Mandril', 'hojas', 'N/A', 3082);
insert into animales values (SQ_animal.nextval, 3, 'Jeff', 'M', 'Elefante', 'hojas', 'N/A', 3082);

insert into animales values (SQ_animal.nextval, 4, 'Yen', 'F', 'panda gigante', 'bambú', 'N/A', 4043);
insert into animales values (SQ_animal.nextval, 4, 'Yin Lao', 'M', 'panda rojo', 'hojas', 'N/A', 4043);
insert into animales values (SQ_animal.nextval, 4, 'Noor', 'F', 'tapir', 'hojas y hierba', 'N/A', 4031);
insert into animales values (SQ_animal.nextval, 4, 'Irfan', 'M', 'manturón', 'omnivoro', 'N/A', 4031);
insert into animales values (SQ_animal.nextval, 4, 'Diwata', 'F', 'pangolin', 'termitas', 'N/A', 4031);
insert into animales values (SQ_animal.nextval, 4, 'Shiva', 'M', 'gato pescador', 'pescado', 'N/A', 4043);

insert into animales values (SQ_animal.nextval, 5, 'Billy', 'M', 'koala', 'eucalipto', 'N/A', 5042);
insert into animales values (SQ_animal.nextval, 5, 'Joey', 'M', 'kanguro', 'hojas y hierba', 'N/A', 5066);
insert into animales values (SQ_animal.nextval, 5, 'Sasha', 'F', 'bilbie', 'omnivoro', 'N/A', 5051);
insert into animales values (SQ_animal.nextval, 5, 'Perry', 'M', 'ornitorrinco', 'gusanos, insectos, cangrejos de rio', 'N/A', 5066);
insert into animales values (SQ_animal.nextval, 5, 'Walter', 'M', 'wombat', 'hojas y raices', 'N/A', 5051);
insert into animales values (SQ_animal.nextval, 5, 'Joan', 'F', 'emu', 'hojas', 'N/A', 5042);

insert into animales values (SQ_animal.nextval, 6, 'Romina', 'F', 'capybara', 'hierba', 'embarazada, cita 15/12', 6083);
insert into animales values (SQ_animal.nextval, 6, 'Damián', 'M', 'capybara', 'hierba', 'N/A', 6083);
insert into animales values (SQ_animal.nextval, 6, 'Tica', 'F', 'llama', 'hierba', 'N/A', 6083);
insert into animales values (SQ_animal.nextval, 6, 'Enrique', 'M', 'pichiciego menor', 'termitas', 'N/A', 6239);
insert into animales values (SQ_animal.nextval, 6, 'Lola', 'F', 'perezoso', 'hojas', 'N/A', 6239);
insert into animales values (SQ_animal.nextval, 6, 'Fabio', 'M', 'oso hormiguero', 'termitas', 'N/A', 6239);

insert into animales values (SQ_animal.nextval, 7, 'Eleonore', 'F', 'águila calva', 'carne', 'N/A', 7022);
insert into animales values (SQ_animal.nextval, 7, 'Jennifer', 'F', 'castor americano', 'hojas', 'N/A', 7254);
insert into animales values (SQ_animal.nextval, 7, 'Miko', 'M', 'mapache boreal', 'omnivoro', 'N/A', 7071);
insert into animales values (SQ_animal.nextval, 7, 'Jackie', 'F', 'liebre de cola bl.', 'hierba', 'nariz mojada, le cuesta respirar - pedir cita', 7254);
insert into animales values (SQ_animal.nextval, 7, 'Nocturne', 'F', 'lince rojo', 'carne', 'N/A', 7022);
insert into animales values (SQ_animal.nextval, 7, 'Edward', 'M', 'coyote', 'carne', 'N/A', 7022);
insert into animales values (SQ_animal.nextval, 7, 'Emmett', 'M', 'borrego cimarrón', 'hierba', 'N/A', 7071);


insert into citaveterinario values (26, '15/12/2019', 'control embarazo');
insert into citaveterinario values (5, '09/11/2019', 'infeccion ojo - control');
insert into citaveterinario values (35, null, 'infeccion respiratoria?');
insert into citaveterinario values (26, '28/09/2019', 'control embarazo');
insert into citaveterinario values (5, '02/10/2019', 'infeccion ojo, crema 3/dia');


insert into peticiones values (SQ_peticion.nextval, 'carnívoros', 7, 'carcasas buey 20', '12/11/1029', '1');
insert into peticiones values (SQ_peticion.nextval, 'reptiles', 2, 'grillos 15 kg, ratones 50', '12/11/1029', '1, 3');
insert into peticiones values (SQ_peticion.nextval, 'leones', 2, 'carcasas buey 30', '09/11/1029', '1');
insert into peticiones values (SQ_peticion.nextval, 'herbívoros', 5, 'heno 25 alpacas, eucalipto 30 ramas', '02/12/2019', '2, 3');
insert into peticiones values (SQ_peticion.nextval, 'panda gigante', 4, 'bambú 100 kg', '22/11/2019', null);

insert into proveedores values (1, 'Matadero Valdepeñas');
insert into proveedores values (2, 'Rubio')
insert into proveedores values (3, 'Australia Import');


insert into pedidos values (SQ_pedido.nextval, 'carcasas buey 50, ratones 50', 15000, 'Matadero Valdepeñas', '12/11/2019', 'si');
insert into pedidos values (SQ_pedido.nextval, 'heno 60 alpacas', 1800, 'Rubio', '30/11/2019', 'no');
insert into pedidos values (SQ_pedido.nextval, 'eucalipto 30 ramas, grillos 15 kg', 38900, 'Australia import', '28/11/2019', 'no');

insert into pet_ped values (2, 19001);
insert into pet_ped values (3, 19001);
insert into pet_ped values (3, 19003);
insert into pet_ped values (4, 19001);
insert into pet_ped values (5, 19002);
insert into pet_ped values (5, 19003);


insert into entradas values (SQ_entrada.nextval, 'adulto', '1 persona mayor a 12 años por un día', 21.45, null)
insert into entradas values (SQ_entrada.nextval, 'niño', '1 persona menor a 12 años por un día', 18.25, null)
insert into entradas values (SQ_entrada.nextval, 'ositos 1/2', 'acceso para 2 adultos y 2 niños menores de 12 años por 6 meses', 139.49, 6)
insert into entradas values (SQ_entrada.nextval, 'ositos completo', 'acceso para 2 adultos y 2 niños menores de 12 años por 12 meses', 275.75, 12)
insert into entradas values (SQ_entrada.nextval, 'buhitos 1/2', 'acceso para 2 adultos y hasta 6 niños menores de 12 años por 6 meses', 219.45, 6)
insert into entradas values (SQ_entrada.nextval, 'buhitos completo', 'acceso para 2 adultos y hasta 6 niños menores de 12 años por 12 meses', 445.75, 12)


insert into clientes values (SQ_cliente.nextval, 'Arnedo Soriano', 'Javier', 'jsoriano45@gmail.com', null, null, 3, '01/10/2019', '01/03/2020');
insert into clientes values (SQ_cliente.nextval, 'Gonzalez Santana', 'Carmen', 'carmencita2009@yahoo.com', 'CSantana', '123ABC', 6, '15/12/2018', '15/12/2019');
insert into clientes values (SQ_cliente.nextval, 'Murillo Correa', 'Daniel', 'campeondelmundo@gmail.com', 'Panda21', '0sop4nda!' null, null, null);
insert into clientes values (SQ_cliente.nextval, 'Gonzalo Martín', 'Valeria', 'valeriamartin@gmail.com', null, null, 5, '21/04/2019', '21/10/2019');
insert into clientes values (SQ_cliente.nextval, 'Díaz López', 'Jorge', 'dondiaz2014@gmail.com', null, null, null, null, null);
insert into clientes values (SQ_cliente.nextval, 'Muñoz Torrento', 'Emanuel', 'info@labicicleteria.es', 'Muñoz18', 'ElMejorBici1*', null, null, null);
#portal de cliente añadirá automáticamente el cliente_cod, en el portal del empleado de taquilla será opcional.


insert into ventas values (6, 2, 1, '15/12/2018', 445.75);
insert into ventas values (1, null, 2, '17/12/2018', 22.90);
insert into ventas values (2, null, 2, '17/12/2018', 36.50);
insert into ventas values (1, null, 1, '20/12/2018', 21.45);
insert into ventas values (5, 4, 1, '21/04/2019', 275.75);
insert into ventas values (1, 2, '05/07/2019', 22.90);
insert into ventas values (3, 1, 1, '01/10/2019', 22.90);




