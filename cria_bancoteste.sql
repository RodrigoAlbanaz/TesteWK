CREATE DATABASE bancoteste;

USE bancoteste;

CREATE TABLE `clientes` (
  `codigo` int AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `cidade` varchar(60),
  `uf` varchar(2),
  PRIMARY KEY (`codigo`)
);

INSERT INTO `clientes`
VALUES (1,'José da Silva','Curitiba','PR'),
       (2,'Maria Pereira','Florianópolis','SC'),
	   (3,'Alberto Magalhães','São Paulo','SP'),
	   (4,'Orlando Silveira','Porto Alegre','RS'),
	   (5,'Joaquim Silvestre','Rio de Janeiro','RJ'),
	   (6,'Arnaldo da Silva','Recife','PE'),
	   (7,'Joaquina Pereira','Salvador','BA'),
	   (8,'Manoel da Silva','Belém','PA'),
	   (9,'José  da Costa','Belo Horizonte','MG'),
	   (10,'Manoel Silveira','Brasília','DF'),
	   (11,'Rodrigo Pereira','Cuiabá','MT'),
	   (12,'Rafael Azul','Campo Grande','MS'),
	   (13,'Gerson da Silva','Manaus','AM'),
	   (14,'Maria José','Boa Vista','RR'),
	   (15,'Silvia Silveira','Porto Velho','RO'),
	   (16,'Caio Silvestre','Rio Branco','AC'),
	   (17,'Raimundo Nonato','Natal','RN'),
	   (18,'Fausto Silva','Maceió','AL'),
	   (19,'Arnaldo Jabor','Teresina','PI'),
	   (20,'Glória Maria','Goiânia','GO');

CREATE TABLE `produtos` (
  `codigo` int AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `preco` double NOT NULL,
  PRIMARY KEY (`codigo`)
);

INSERT INTO `produtos` 
VALUES (1,'Produto 1',10),
       (2,'Produto 2',20),
       (3,'Produto 3',30),
	   (4,'Produto 4',40),
	   (5,'Produto 5',50),
	   (6,'Produto 6',60),
	   (7,'Produto 7',70),
	   (8,'Produto 8',80),
	   (9,'Produto 9',90),
	   (10,'Produto 10',100),
	   (11,'Produto 11',10.5),
	   (12,'Produto 12',20.5),
	   (13,'Produto 13',30.5),
	   (14,'Produto 14',40.5),
	   (15,'Produto 15',50.5),
	   (16,'Produto 16',60.5),
	   (17,'Produto 17',70.5),
	   (18,'Produto 18',80.5),
	   (19,'Produto 19',90.5),
	   (20,'Produto 20',100.5);

CREATE TABLE `pedidos` (
  `numero_pedido` int AUTO_INCREMENT,
  `data_emissao` date NOT NULL,
  `codigo_cliente` int NOT NULL,
  `valor_total` double NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`codigo`)
);

CREATE TABLE `pedidos_produtos` (
  `autoincrem` int AUTO_INCREMENT,
  `numero_pedido` int NOT NULL,
  `codigo_produto` int NOT NULL,
  `quantidade` double NOT NULL,
  `vlr_unitario` double NOT NULL,
  `vlr_total` double NOT NULL,
  PRIMARY KEY (`autoincrem`),
  FOREIGN KEY (`numero_pedido`) REFERENCES `pedidos` (`numero_pedido`),
  FOREIGN KEY (`codigo_produto`) REFERENCES `produtos` (`codigo`)
);
