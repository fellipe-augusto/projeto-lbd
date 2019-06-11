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


/*InserÃ§Ã£o de Dados*/

INSERT INTO tbCliente VALUES (001, 'Celso Portiolli', '95684-4857', 'Rua Biridin');
INSERT INTO tbCliente VALUES (002, 'Augusto Liberato', '95684-4857', 'Rua Haroldo Bauer');
INSERT INTO tbCliente VALUES (003, 'Carlos Massa', '95684-4857', 'Rua Fandangos');
INSERT INTO tbCliente VALUES (004, 'JoÃ£o Kleber', '95684-4857', 'Rua AmapÃ¡');
INSERT INTO tbCliente VALUES (005, 'JosÃ© Luiz Datena', '95684-4857', 'Rua Ponta Grossa');

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


INSERT INTO tbOcorrencia VALUES (004, 001, 002, '16/05/2019', 'SolicitaÃ§Ã£o de peÃ§as', 1);
INSERT INTO tbOcorrencia VALUES (004, 002, 001, '17/05/2019', 'PeÃ§a errada, outra solicitaÃ§Ã£o', 1);
INSERT INTO tbOcorrencia VALUES (004, 003, 005, '18/05/2019', 'Troca da peÃ§a', 1);
INSERT INTO tbOcorrencia VALUES (005, 004, 005, '25/05/2019', 'Reparo concluÃ­do na visita', 2);

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
-- Considere apenas as solicitacoes atendidas. Esta visao Ã© atualizavel? Porque?


-- 4.5 Listar todas as ocorrencias das solicitacoes nao atendidas.

SELECT *
FROM tbOcorrencia
WHERE idSolicitacao NOT IN (SELECT idSolicitacao FROM tbSolicitacao);

-- 4.6 Listar a descrição da categoria de problema que mais ocorreu nos últimos 2 meses.



-- 4.7 Liste o codigo do produto que nunca teve uma solicitacao de manutencao.

SELECT codProduto 
FROM tbProduto 
WHERE codProduto NOT IN (SELECT codProduto FROM tbSolicitacao);

-- 4.8 Listar o nome dos tecnicos que tenham solicitacoes parcialmente atendidas e que ja 
-- existam mais de 2 ocorrencias para a solicitacao.


-- 4.9 Acrescente uma coluna nova (data de inclusao) no formato date, na primeira tabela criada. 
-- Altere o valor desta coluna colocando a data do sistema.

ALTER TABLE tbTecnico 
ADD dataInclusao DATE DEFAULT SYSDATE;

-- 4.10 Explique para que serve a clausula group by e de 1 exemplo de sua utilizacao.
-- A clausula group by serve para agrupar o resultado de uma consulta de acordo com um campo ou campos.
-- Objetivo: Listar as solicitacoes que estao "Aberto" e as que estao "Fechado".
SELECT situacao, COUNT(idSolicitacao)
FROM tbSolicitacao
GROUP BY situacao;

-- 4.11 Explique para que serve a claúsula having e dê 1 exemplo de sua utilização.
-- A cláusula having serve para especificar um critério de pesquisa/filtro para um resultado agrupado.
-- Objetivo: Listar quais produtos possuem apenas 1 solicitação.
SELECT idProduto, COUNT(*) AS "Nº de Solicitações"
FROM tbSolicitacao
GROUP BY idProduto
HAVING COUNT(*) = 1;

-- 4.12 Dê exemplo de um comando utilizando subconsultas que utilize o operador in. 
-- Objetivo: Este comando serve para listar os produtos/descrição que estão com solicitação em andamento.
SELECT idProduto, descricao
FROM tbProduto
WHERE idProduto IN (SELECT idProduto FROM tbSolicitacao WHERE situacao='Fechado');

-- 4.13 Dê exemplo de um comando utilizando subconsultas que utilize o operador not in.
-- Objetivo: Este comando serve para listar todos os clientes que não abriram solicitações.
SELECT idCliente 
FROM tbCliente 
WHERE idCliente NOT IN (SELECT idCliente FROM tbSolicitacao);

-- 4.14 Dê exemplo de um comando utilizando subconsultas que utilize o operador exists
-- Objetivo: Listar os dados dos clientes com solicitações.
SELECT *
FROM tbCliente A
WHERE EXISTS (SELECT * 
              FROM tbSolicitacao B
              WHERE A.idCliente = B.idCliente);

-- 4.15 Dê exemplo de um comando utilizando subconsultas que utilize o operador not exists.
-- Objetivo: Listar os dados dos técnicos que não possuem ocorrências.
SELECT *
FROM tbTecnico A
WHERE NOT EXISTS (SELECT *
                  FROM tbOcorrencia B
                  WHERE A.idTecnico = B.idTecnico);

-- 4.16 Dê exemplo de uma subconsulta utilizada dentro de um comando Update.
-- Objetivo: Atualiza a situação da solicitação do Cliente de ID = 2 para fechado.
UPDATE tbSolicitacao A
SET A.situacao = 'Fechado', A.horasGastas = 3, A.custoTotal = 150 
WHERE EXISTS (SELECT idCliente
              FROM tbCliente B
              WHERE A.idCliente = B.idCliente AND B.idCliente = 2);

-- 4.17 Dê exemplo de uma subconsulta utilizada dentro de um comando Delete.
-- Objetivo: Exclui tipos de produtos não associados a produtos.
DELETE FROM tbTipoProduto A
WHERE NOT EXISTS (SELECT *
                  FROM tbProduto B
                  WHERE B.idTipo = A.idTipo);

-- 4.18 Dê exemplo de uma consulta utilizando a cláusula MINUS
-- Objetivo: Listar as categorias cadastradas sem solicitações.
SELECT idCategoria FROM tbSolicitacao
MINUS
SELECT idCategoria FROM tbCategoria;

-- 4.19 Dê exemplo de uma consulta utilizando a cláusula INTERSECT.
-- Objetivo: Listar os técnicos que possuem ocorrências.
SELECT idTecnico FROM tbTecnico
INTERSECT
SELECT idTecnico FROM tbOcorrencia;

-- Parte PL/SQL --

-- 5. Escreva uma função que seja útil para a lógica de negócios de seu sistema e indique o
-- contexto de sua utilização.

create or replace function FN_CalcTotal (idSolicit tbSolicitacao.idSolicitacao%type)
Return number
as
VTotal tbSolicitacao.custoTotal%type;
VPreco tbCategoria.precoHora%type;
VHorasGasta tbSolicitacao.horasGastas%type;

Begin
    Select S.horasGastas,C.precoHora into VHorasGasta,VPreco
    from tbSolicitacao S,tbCategoria C
    where  S.idSolicitacao = idSolicit and
           S.idCategoria = c.idcategoria;
    
   VTotal := VHorasGasta * VPreco;

    return (VTotal);    
end FN_CalcTotal;

Select S.idSolicitacao,S.horasGastas as "Horas gastas", c.precohora, FN_CalcTotal(idSolicitacao)as "Valor Total"
From tbSolicitacao S, tbCategoria C
where s.idcategoria = c.idcategoria;

-- 6. Escreva um trigger que ao incluir uma ocorrência se já houver mais de 3 ocorrências da
-- mesma solicitação gravar em uma tabela de log a mensagem.
-- “Situação Grave – grande número de ocorrências <codsolicitação> <nomecliente&gt><qtde”.


-- 7. Escreva um trigger que ao excluir uma solicitação exclua também as suas ocorrências.

-- 8. Escreva uma procedure que calcule o custo de uma manutenção. Esta procedure deve
-- receber como parâmetro o código da Solicitação e somar as horas de todas as ocorrências
-- realizadas para esta solicitação. Considerar que a unidade é sempre horas
-- inteiras(desconsiderar minutos). O custo base é:
--          se tipoProd = ´HW´ custo = r$20,00 por hora
--          tipoProd = ´SW´ custo = r$30,00 por hora
-- O custo total não pode ser menor do que o preço mínimo para a categoria.

-- 9. Escreva uma procedure que receba como parâmetro o código do produto e verifique,
-- quantas requisições existem (em qq situação) e classifique:
--          Se qtde de requisições >= 15 “Produto Ruim – não recomendar”
--          Se qtde de requisições >= 5 e < 15 “Produto a ser verificado”
--          Se qtde de requisições < 5 e > 0 “Produto Bom”
--          Se qtde de requisições = 0 “Produto Excelente – recomendar”
-- Gravar uma linha na tabela de Mensagem com: codproduto, nomeproduto e a classificação atribuída acima.
create table tbMensagem
( codProduto number(5) not null,
  nomeProduto varchar2(30) not null,
  classific varchar2(30) not null
);

Create or replace procedure ClassificacaoProduto(p_idProduto number)
as
  v_quant number(10);
  v_classific varchar2 (30);
  v_nomeProduto varchar2 (50);

begin
    select count(*) into v_quant 
    from tbSolicitacao 
    where idProduto = p_idProduto;
    
    select descricao into v_nomeProduto
    from tbProduto
    where idProduto = p_idProduto;
    
    if v_quant = 0 then
    v_classific := 'Produto Excelente - Recomendar';
    end if;

    if v_quant > 0 AND v_quant < 5 then
    v_classific := 'Produto Bom';
    end if;

    if v_quant >= 5 AND v_quant < 15 then
    v_classific := 'Produto a ser Verificado';
    end if;

    if v_quant >= 15 then
    v_classific := 'Produto Excelente - Recomendar';
    end if;

    insert into tbMensagem values(p_idProduto,v_nomeProduto,v_classific);
commit;
end;

exec ClassificacaoProduto(006);
