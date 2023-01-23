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