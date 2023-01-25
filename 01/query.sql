create table categorias(
 	id serial primary key,
	nome varchar(50)
);

create table produtos(
	id serial primary key,
	nome varchar(100),
	descricao text,
	preco int,
	quantidade_em_estoque int,
	categoria_id int
);

create table itens_do_pedido(
	id serial primary key,
	pedido_id int,
	quantidade int,
	produto_id int
);

create table pedidos(
	id serial primary key,
	valor int,
	cliente_cpf char(11),
	vendedor_cpf char(11)
);


create table clientes(
	cpf char(11) unique,
	nome varchar(150)
);

create table vendedores(
	cpf char(11) unique,
	nome varchar(150)
);


alter table produtos add constraint FK_CATEGORIA_PRODUTO
foreign key(categoria_id) references categorias(id);

alter table itens_do_pedido add constraint FK_PRODUTOS_ITENS_DO_PEDIDO
foreign key(produto_id) references produtos(id);

alter table itens_do_pedido add constraint FK_PEDIDO_ITENS_DO_PEDIDO
foreign key(pedido_id) references pedidos(id);


alter table pedidos add constraint FK_CLIENTE_PEDIDO
foreign key(cliente_cpf) references clientes(cpf);

alter table pedidos add constraint FK_VENDEDOR_PEDIDO
foreign key(vendedor_cpf) references vendedores(cpf);

--01
insert into categorias(nome) values 
('Frutas'),
('Verduras'),
('Massas'),
('Bebidas'),
('Utilidades');

--02
insert into produtos (nome, descricao, preco, quantidade_em_estoque, categoria_id) 
values
('Mamão',	'Rico em vitamina A, potássio e vitamina C',	300,	123,	1),
('Maça',	    'Fonte de potássio e fibras',	90,	34,	1),
('Cebola',	'Rico em quercetina, antocianinas, vitaminas do complexo B, C',	50,	76,	2),
('Abacate',	'NÃO CONTÉM GLÚTEN',	150,	64,	1),
('Tomate',	'Rico em vitaminas A, B e C',	125,	88,	1),
('Acelga',	'NÃO CONTÉM GLÚTEN',	235,	13,	2),
('Macarrão', 'parafuso Sêmola de trigo enriquecida com ferro e ácido fólico, ovos e corantes naturais',	690,	5, 3),
('Massa paralasanha',	'Uma reunião de família precisa ter comida boa e muita alegria',	875,	19,	3),
('Refrigerante coca cola lata',	'Sabor original',	350,	189,	4),
('Refrigerante Pepsi 2l',	'NÃO CONTÉM GLÚTEN. NÃO ALCOÓLICO',	700,	12,	4),
('Cerveja Heineken 600ml',	'Heineken é uma cerveja lager Puro Malte, refrescante e de cor amarelo-dourado',	1200,	500,	4),
('Agua mineral sem gás',	'Smartwater é água adicionado de sais mineirais (cálcio, potássio e magnésio) livre de sódio e com pH neutro',	130,	478,	4),
('Vassoura',	'Pigmento, matéria sintética e metal',	2350,	30,	5),
('Saco para lixo',	'Reforçado para garantir mais segurança',	1340,	90,	5),
('Escova dental',	'Faça uma limpeza profunda com a tecnologia inovadora',	1000,	44,	5),
('Balde para lixo 50l',	'Possui tampa e fabricado com material reciclado',	2290,	55,	5),
('Manga',	'Rico em Vitamina A, potássio e vitamina C',	198,	176,	1),
('Uva',	'NÃO CONTÉM GLÚTEN',	420,	90,	1);

--03
insert into clientes (cpf, nome)  values
('80371350042',	'José Augusto Silva'),
('67642869061',	'Antonio Oliveira'),
('63193310034',	'Ana Rodrigues'),
('75670505018',	'Maria da Conceição');

--04
insert into vendedores (cpf, nome) values 
('82539841031',	'Rodrigo Sampaio'),
('23262546003',	'Beatriz Souza Santos'),
('28007155023',	'Carlos Eduardo');

--05
--A

--aqui crio o pedido
insert into pedidos (valor, cliente_cpf, vendedor_cpf) values 
(null, '80371350042', '28007155023');

--aqui insiro os itens do pedido
insert into itens_do_pedido (pedido_id, quantidade, produto_id) values
(1, 1, 1),
(1, 1, 10),
(1, 6, 11),
(1, 1, 15),
(1, 5, 2);

--aqui confiro se os itens estão inseridos corretamente
select idp.pedido_id,  p.id, p.nome, idp.quantidade, p.preco,  p.preco * idp.quantidade as valor_total from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id; 
where idp.pedido_id = 1;

--aqui atualizo o estoque
update produtos
set quantidade_em_estoque = quantidade_em_estoque - 1
where produtos.id = 1;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 1
where produtos.id = 10;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 6
where produtos.id = 11;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 1
where produtos.id = 15;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 5
where produtos.id = 2;

--aqui pego o valor do pedido
select idp.pedido_id as numero_pedido,  sum(p.preco * idp.quantidade) as valor_do_pedido from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id 
group by idp.pedido_id;

--aqui atualizo o valor do pedido
update pedidos 
set valor  = 9650
where pedidos.id = 1;

--b
--aqui crio o pedido
insert into pedidos (valor, cliente_cpf, vendedor_cpf) values 
(null, '63193310034', '23262546003');

--aqui insiro os itens do pedido
insert into itens_do_pedido (pedido_id, quantidade, produto_id) values
(2,10, 17),
(2, 3, 18),
(2, 5, 1),
(2, 10, 5),
(2, 2, 6);

--aqui confiro se os itens estão inseridos corretamente
select idp.pedido_id,  p.id, p.nome, idp.quantidade, p.preco,  p.preco * idp.quantidade as valor_total from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id
where idp.pedido_id = 2;

--aqui atualizo o estoque
update produtos
set quantidade_em_estoque = quantidade_em_estoque - 10
where produtos.id = 17;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 3
where produtos.id = 18;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 5
where produtos.id = 1;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 10
where produtos.id = 5;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 2
where produtos.id = 6;

--aqui pego o valor do pedido
select idp.pedido_id as numero_pedido,  sum(p.preco * idp.quantidade) as valor_do_pedido from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id 
group by idp.pedido_id;


--aqui atualizo o valor do pedido
update pedidos 
set valor  = 6460
where pedidos.id = 2;

--c
--aqui crio o pedido
insert into pedidos (valor, cliente_cpf, vendedor_cpf) values 
(null, '75670505018', '23262546003');

--aqui insiro os itens do pedido
insert into itens_do_pedido (pedido_id, quantidade, produto_id) values
(3, 1, 13),
(3, 6, 12),
(3, 5, 17);

--aqui confiro se os itens estão inseridos corretamente
select idp.pedido_id,  p.id, p.nome, idp.quantidade, p.preco,  p.preco * idp.quantidade as valor_total from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id
where idp.pedido_id = 3;

--aqui atualizo o estoque
update produtos
set quantidade_em_estoque = quantidade_em_estoque - 1
where produtos.id = 13;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 6
where produtos.id = 12;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 5
where produtos.id = 17;

--aqui pego o valor do pedido
select idp.pedido_id as numero_pedido,  sum(p.preco * idp.quantidade) as valor_do_pedido from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id 
group by idp.pedido_id;


--aqui atualizo o valor do pedido
update pedidos 
set valor  = 4120
where pedidos.id = 3;

--d
--aqui crio o pedido
insert into pedidos (valor, cliente_cpf, vendedor_cpf) values 
(null, '63193310034', '82539841031');

--aqui insiro os itens do pedido
insert into itens_do_pedido (pedido_id, quantidade, produto_id) values
(4, 1, 16),
(4, 6, 18),
(4, 1, 1),
(4, 3, 1),
(4, 20, 5),
(4, 2, 6);

--aqui confiro se os itens estão inseridos corretamente
select idp.pedido_id,  p.id, p.nome, idp.quantidade, p.preco,  p.preco * idp.quantidade as valor_total from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id
where idp.pedido_id = 4;

--aqui atualizo o estoque
update produtos
set quantidade_em_estoque = quantidade_em_estoque - 1
where produtos.id = 16;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 6
where produtos.id = 18;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 7
where produtos.id = 1;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 1
where produtos.id = 1;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 20
where produtos.id = 5;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 2
where produtos.id = 6;

--aqui pego o valor do pedido
select idp.pedido_id as numero_pedido,  sum(p.preco * idp.quantidade) as valor_do_pedido from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id 
group by idp.pedido_id;


--aqui atualizo o valor do pedido
update pedidos 
set valor  = 9370
where pedidos.id = 4;

--e
--aqui crio o pedido
insert into pedidos (valor, cliente_cpf, vendedor_cpf) values 
(null, '67642869061', '82539841031');

--aqui insiro os itens do pedido
insert into itens_do_pedido (pedido_id, quantidade, produto_id) values
(5, 8, 18),
(5, 1, 8),
(5, 3, 17),
(5, 8, 5),
(5, 2, 11);


--aqui confiro se os itens estão inseridos corretamente
select idp.pedido_id,  p.id, p.nome, idp.quantidade, p.preco,  p.preco * idp.quantidade as valor_total from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id
where idp.pedido_id = 5;

--aqui atualizo o estoque
update produtos
set quantidade_em_estoque = quantidade_em_estoque - 8
where produtos.id = 18;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 1
where produtos.id = 8;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 3
where produtos.id = 17;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 8
where produtos.id = 5;

update produtos
set quantidade_em_estoque = quantidade_em_estoque - 2
where produtos.id = 11;

--aqui pego o valor do pedido
select idp.pedido_id as numero_pedido,  sum(p.preco * idp.quantidade) as valor_do_pedido from produtos p 
inner join itens_do_pedido idp
on p.id = idp.produto_id 
group by idp.pedido_id;


--aqui atualizo o valor do pedido
update pedidos 
set valor  = 8229
where pedidos.id = 5;


--listagem de pedidos
select p.id as numero_pedido, p2.nome, p2.descricao,
idp.quantidade, p2.preco, p2.quantidade_em_estoque, c.nome as cliente, v.nome  as vendedor
from itens_do_pedido idp 
join pedidos p on idp.pedido_id = p.id
join clientes c on c.cpf = p.cliente_cpf
join vendedores v on v.cpf = p.vendedor_cpf
join produtos p2 on p2.id = idp.produto_id 
where p.id = 5; --aqui vc troca pelo id do seu pedido