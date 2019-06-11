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

-- 4.6 Listar a descri��o da categoria de problema que mais ocorreu nos �ltimos 2 meses.



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

-- 4.11 Explique para que serve a cla�sula having e d� 1 exemplo de sua utiliza��o.
-- A cl�usula having serve para especificar um crit�rio de pesquisa/filtro para um resultado agrupado.
-- Objetivo: Listar quais produtos possuem apenas 1 solicita��o.
SELECT idProduto, COUNT(*) AS "N� de Solicita��es"
FROM tbSolicitacao
GROUP BY idProduto
HAVING COUNT(*) = 1;

-- 4.12 D� exemplo de um comando utilizando subconsultas que utilize o operador in. 
-- Objetivo: Este comando serve para listar os produtos/descri��o que est�o com solicita��o em andamento.
SELECT idProduto, descricao
FROM tbProduto
WHERE idProduto IN (SELECT idProduto FROM tbSolicitacao WHERE situacao='Fechado');

-- 4.13 D� exemplo de um comando utilizando subconsultas que utilize o operador not in.
-- Objetivo: Este comando serve para listar todos os clientes que n�o abriram solicita��es.
SELECT idCliente 
FROM tbCliente 
WHERE idCliente NOT IN (SELECT idCliente FROM tbSolicitacao);

-- 4.14 D� exemplo de um comando utilizando subconsultas que utilize o operador exists
-- Objetivo: Listar os dados dos clientes com solicita��es.
SELECT *
FROM tbCliente A
WHERE EXISTS (SELECT * 
              FROM tbSolicitacao B
              WHERE A.idCliente = B.idCliente);

-- 4.15 D� exemplo de um comando utilizando subconsultas que utilize o operador not exists.
-- Objetivo: Listar os dados dos t�cnicos que n�o possuem ocorr�ncias.
SELECT *
FROM tbTecnico A
WHERE NOT EXISTS (SELECT *
                  FROM tbOcorrencia B
                  WHERE A.idTecnico = B.idTecnico);

-- 4.16 D� exemplo de uma subconsulta utilizada dentro de um comando Update.
-- Objetivo: Atualiza a situa��o da solicita��o do Cliente de ID = 2 para fechado.
UPDATE tbSolicitacao A
SET A.situacao = 'Fechado', A.horasGastas = 3, A.custoTotal = 150 
WHERE EXISTS (SELECT idCliente
              FROM tbCliente B
              WHERE A.idCliente = B.idCliente AND B.idCliente = 2);

-- 4.17 D� exemplo de uma subconsulta utilizada dentro de um comando Delete.
-- Objetivo: Exclui tipos de produtos n�o associados a produtos.
DELETE FROM tbTipoProduto A
WHERE NOT EXISTS (SELECT *
                  FROM tbProduto B
                  WHERE B.idTipo = A.idTipo);

-- 4.18 D� exemplo de uma consulta utilizando a cl�usula MINUS
-- Objetivo: Listar as categorias cadastradas sem solicita��es.
SELECT idCategoria FROM tbSolicitacao
MINUS
SELECT idCategoria FROM tbCategoria;

-- 4.19 D� exemplo de uma consulta utilizando a cl�usula INTERSECT.
-- Objetivo: Listar os t�cnicos que possuem ocorr�ncias.
SELECT idTecnico FROM tbTecnico
INTERSECT
SELECT idTecnico FROM tbOcorrencia;

-- Parte PL/SQL --

-- 5. Escreva uma fun��o que seja �til para a l�gica de neg�cios de seu sistema e indique o
-- contexto de sua utiliza��o.

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

-- 6. Escreva um trigger que ao incluir uma ocorr�ncia se j� houver mais de 3 ocorr�ncias da
-- mesma solicita��o gravar em uma tabela de log a mensagem.
-- �Situa��o Grave � grande n�mero de ocorr�ncias <codsolicita��o> <nomecliente&gt><qtde�.


-- 7. Escreva um trigger que ao excluir uma solicita��o exclua tamb�m as suas ocorr�ncias.

-- 8. Escreva uma procedure que calcule o custo de uma manuten��o. Esta procedure deve
-- receber como par�metro o c�digo da Solicita��o e somar as horas de todas as ocorr�ncias
-- realizadas para esta solicita��o. Considerar que a unidade � sempre horas
-- inteiras(desconsiderar minutos). O custo base �:
--          se tipoProd = �HW� custo = r$20,00 por hora
--          tipoProd = �SW� custo = r$30,00 por hora
-- O custo total n�o pode ser menor do que o pre�o m�nimo para a categoria.

-- 9. Escreva uma procedure que receba como par�metro o c�digo do produto e verifique,
-- quantas requisi��es existem (em qq situa��o) e classifique:
--          Se qtde de requisi��es >= 15 �Produto Ruim � n�o recomendar�
--          Se qtde de requisi��es >= 5 e < 15 �Produto a ser verificado�
--          Se qtde de requisi��es < 5 e > 0 �Produto Bom�
--          Se qtde de requisi��es = 0 �Produto Excelente � recomendar�
-- Gravar uma linha na tabela de Mensagem com: codproduto, nomeproduto e a classifica��o atribu�da acima.
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
