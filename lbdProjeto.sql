CREATE TABLE tbCliente (
idCliente number (8) NOT NULL,
nomeCli varchar2 (40) NOT NULL,
tel varchar2 (15) NOT NULL,
endereco varchar2 (50) NOT NULL,
CONSTRAINT PK_IDCLIENTE PRIMARY KEY (idCliente));

CREATE TABLE tbCategoria (
idCategoria number (8) NOT NULL,
descricao varchar2 (40) NOT NULL,
precoHora number (8,2) NOT NULL,
CONSTRAINT PK_IDCATEGORIA PRIMARY KEY (idCategoria));

CREATE TABLE tbTecnico (
idTecnico number (8) NOT NULL,
nomeTec varchar2 (40) NOT NULL,
ramal number (8) NOT NULL,
CONSTRAINT PK_IDTECNICO PRIMARY KEY (idTecnico));

CREATE TABLE tbTipoProduto (
idTipo number (8) NOT NULL,
descricao varchar2 (40) NOT NULL,
CONSTRAINT PK_IDTIPOPRODUTO PRIMARY KEY (idTipo));

CREATE TABLE tbProduto (
idProduto number (8) NOT NULL,
idTipo number (8) NOT NULL,
descricao varchar2 (30) NOT NULL,
CONSTRAINT PK_IDPRODUTO PRIMARY KEY (idProduto));

ALTER TABLE tbProduto
ADD CONSTRAINT FK_TIPOPRODUTO_IDTIPO
FOREIGN KEY (idTipo) REFERENCES tbTipoProduto;

create table tbSolicitacao (
idSolicitacao number (8) NOT NULL,
idProduto number (8) NOT NULL,
idCategoria number (8) NOT NULL,
idCliente number (8) NOT NULL,
dataSoli date NOT NULL,
horasGastas number (5) NOT NULL,
custoTotal number (8,2) NOT NULL,
situacao  varchar2 (30) NOT NULL,
CONSTRAINT PK_IDSOLICITACAO PRIMARY KEY (idSolicitacao)
);
ALTER TABLE tbSolicitacao
ADD CONSTRAINT FK_PRODUTO_IDPRODUTO
FOREIGN KEY (idProduto) REFERENCES tbProduto;

ALTER TABLE tbSolicitacao
ADD CONSTRAINT FK_CATEGORIA_IDCATEGORIA
FOREIGN KEY (idCategoria) REFERENCES tbCategoria;

ALTER TABLE tbSolicitacao
ADD CONSTRAINT FK_CLIENTE_IDCLIENTE
FOREIGN KEY (idCliente) REFERENCES tbCliente;

create table tbOcorrencia (
idSolicitacao number (8) NOT NULL,
idOcorrencia number (8) NOT NULL,
idTecnico number (8) NOT NULL,
dataOcorrencia date NOT NULL,
descricao varchar2 (40) NOT NULL,
horasGastas number (5) NOT NULL,
CONSTRAINT PK_IDOCORRENCIA_IDSOLICITACAO PRIMARY KEY (idOcorrencia, idSolicitacao)
);
ALTER TABLE tbOcorrencia
ADD CONSTRAINT FK_SOLICITACAO_IDSOLICITACAO
FOREIGN KEY (idSolicitacao) REFERENCES tbSolicitacao;

ALTER TABLE tbOcorrencia
ADD CONSTRAINT FK_TECNICO_IDTECNICO
FOREIGN KEY (idTecnico) REFERENCES tbTecnico;


/*Inserção de Dados*/

INSERT INTO tbCliente VALUES (001, 'Celso Portiolli', '95684-4857', 'Rua Biridin');
INSERT INTO tbCliente VALUES (002, 'Augusto Liberato', '95684-4857', 'Rua Haroldo Bauer');
INSERT INTO tbCliente VALUES (003, 'Carlos Massa', '95684-4857', 'Rua Fandangos');
INSERT INTO tbCliente VALUES (004, 'João Kleber', '95684-4857', 'Rua Amapá');
INSERT INTO tbCliente VALUES (005, 'José Luiz Datena', '95684-4857', 'Rua Ponta Grossa');

INSERT INTO tbTecnico VALUES (001, 'Fher Cassini', '4548');
INSERT INTO tbTecnico VALUES (002, 'Roberto de Souza', '8747');
INSERT INTO tbTecnico VALUES (003, 'Ailton Sampaio', '8745');
INSERT INTO tbTecnico VALUES (004, 'Eduardo Mascarenhas', '0457');
INSERT INTO tbTecnico VALUES (005, 'Tom Veiga', '5548');

INSERT INTO tbTipoProduto VALUES (001, 'Impressora');
INSERT INTO tbTipoProduto VALUES (002, 'Computador');
INSERT INTO tbTipoProduto VALUES (003, 'Roteador');
INSERT INTO tbTipoProduto VALUES (004, 'SO');
INSERT INTO tbTipoProduto VALUES (005, 'ERP');
INSERT INTO tbTipoProduto VALUES (006, 'Pacote Office');


INSERT INTO tbProduto VALUES (001, 001, 'Impressora Epson');
INSERT INTO tbProduto VALUES (002, 003, 'Cisco');
INSERT INTO tbProduto VALUES (003, 002, 'Positivo');
INSERT INTO tbProduto VALUES (004, 005, 'SAP');
INSERT INTO tbProduto VALUES (005, 006, 'Word');
INSERT INTO tbProduto VALUES (006, 004, 'Windows XP');

INSERT INTO tbCategoria VALUES (001, 'HW', 30.00);
INSERT INTO tbCategoria VALUES (002, 'SW', 40.00);
INSERT INTO tbCategoria VALUES (003, 'HW+SW', 50.00);
INSERT INTO tbCategoria VALUES (004, 'Visita', 20.00);

INSERT INTO tbSolicitacao VALUES (001, 003, 001, 003, '05/05/2019', 0, 0, 'Aberto');
INSERT INTO tbSolicitacao VALUES (002, 004, 002, 001, '10/05/2019', 0, 0, 'Aberto');
INSERT INTO tbSolicitacao VALUES (003, 005, 002, 002, '11/05/2019', 0, 0, 'Aberto');
INSERT INTO tbSolicitacao VALUES (004, 001, 003, 005, '15/05/2019', 3, 150.00, 'Fechado');
INSERT INTO tbSolicitacao VALUES (005, 002, 004, 004, '21/05/2019', 2, 40.00, 'Fechado');
INSERT INTO tbSolicitacao VALUES (006, 002, 004, 004, '29/05/2019', 2, 40.00, 'Fechado');


INSERT INTO tbOcorrencia VALUES (004, 001, 002, '16/05/2019', 'Solicitação de peças', 1);
INSERT INTO tbOcorrencia VALUES (004, 002, 001, '17/05/2019', 'Peça errada, outra solicitação', 1);
INSERT INTO tbOcorrencia VALUES (004, 003, 005, '18/05/2019', 'Troca da peça', 1);
INSERT INTO tbOcorrencia VALUES (005, 004, 005, '25/05/2019', 'Reparo concluído na visita', 2);

/* Exercicio 4 */

-- 4.1 Listar o codigo do cliente, o nome do cliente e todas as solicitacoes efetuados por ele no mes de junho/2019.

SELECT C.idCliente, C.nomeCli, S.idSolicitacao, S.idProduto, S.idCategoria, S.dataSoli, S.horasGastas, S.custoTotal, S.situacao 
FROM tbCliente C, tbSolicitacao S 
WHERE C.idCliente = S.idCliente AND dataSoli BETWEEN to_date('01/06/2019','DD/MM/YYYY') AND to_date('30/06/2019','DD/MM/YYYY');

-- 4.2 Listar o produto que possui o maior numero de solicitacoes cadastradas ja atendidas.

SELECT idProduto 
FROM tbSolicitacao
GROUP BY idProduto
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM tbSolicitacao 
                    GROUP BY idProduto);

-- 4.3 Listar o numero de solicitacoes existentes para cada tipo de produto e a descricao do tipo.

SELECT COUNT(*) AS "No SOLICITACOES", TP.descricao
FROM tbSolicitacao S, tbProduto P, tbTipoProduto TP
WHERE S.idProduto = P.idProduto AND P.idTipo = TP.idTipo
GROUP BY TP.descricao;

-- 4.4 Criar uma visao com o custo total das manutencoes realizadas para cada cliente.
-- Considere apenas as solicitacoes atendidas. Esta visao é atualizavel? Porque?


-- 4.5 Listar todas as ocorrencias das solicitacoes nao atendidas.

SELECT *
FROM tbOcorrencia
WHERE idSolicitacao NOT IN (SELECT idSolicitacao FROM tbSolicitacao);

-- 4.7 Liste o codigo do produto que nunca teve uma solicitacao de manutencao.

SELECT codProduto 
FROM tbProduto 
WHERE codProduto NOT IN (SELECT codProduto FROM tbSolicitacao);

-- 4.8 Listar o nome dos tecnicos que tenham solicitacoes parcialmente atendidas e que ja 
-- existam mais de 2 ocorrencias para a solicitacao.



-- 4.9 Acrescente uma coluna nova “data de inclusao” no formato date, na primeira tabela criada. 
-- Altere o valor desta coluna colocando a data do sistema.

ALTER TABLE tbTecnico 
ADD dataInclusao DATE DEFAULT SYSDATE;

-- 4.10 Explique para que serve a clausula group by e de 1 exemplo de sua utilizacao.

-- A cláusula group by serve para agrupar o resultado de uma consulta de acordo com um campo ou campos.
-- Objetivo: Listar as solicitações que estão "Aberto" e as que estão "Fechado".
SELECT situacao, COUNT(idSolicitacao)
FROM tbSolicitacao
GROUP BY situacao;

