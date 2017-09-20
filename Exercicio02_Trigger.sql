-- 1) Desenvolva uma trigger chamada trg_sincro_tot_pedido que para cada item movimentado de um determinado pedido na 
-- tabela LOC_ITEM_LOCACAO, o valor total de loca��o da tabela LOC_PEDIDO_LOCACAO seja atualizado.

--FALHA NA APLICA��O, NAO TEM SOLU��O DIRETA, PROBLEMA DE MODELAGEM DE BANCO, N�O SE DEVE UTILIZAR CAMPOS DE VALOR DE SOMA TOTAL.

-- 2) Crie uma trigger que garanta que o valor da coluna DT_RETIRADA n�o seja MAIOR que o valor da coluna DT_ENTREGA 
-- na tabela LOC_ITEM_LOCACAO ? Caso isso ocorra, emita uma mensagem de erro pertinente e pare o processamento

create or replace trigger trc_dt_retirada_bui
before update or insert on loc_item_locacao
for each row
declare 
  err_data_invalida exception;
begin
  if (:new.dt_retirada > :new.dt_entrega) then
      raise err_data_invalida;
  end if;
  exception 
    when err_data_invalida then
        RAISE_APPLICATION_ERROR (-20001, 'Data de Retirada nao pode ser maior que a Data de Entrega');
end;

insert into loc_item_locacao (dt_retirada, nr_item, dt_entrega, qt_dias, vl_locacao, nr_placa, vl_total, nr_pedido)
values (sysdate+2, 8, sysdate, 2, 500, 'BZT2255', 1000, 147);

-- 3) Implemente uma regra de neg�cio que garanta que n�o se tenha nenhum valor negativo nas coluna VL_LOCACAO e 
-- VL_TOTAL da tabela LOC_ITEM_LOCACAO ? Caso isso ocorra, emita uma mensagem de erro pertinente e pare o processamento. 
-- (caso queira, tamb�m gere informa��o na tabela de log criada no seu �ltimo exerc�cio complexo)

create or replace trigger trc_item_negativo_biu
before insert or update on loc_item_locacao
for each row
begin
  if (:new.vl_locacao < 0) or (:new.vl_total < 0) then
    prc_log2017_2tdsr('USUARIO SO', SYSDATE, 'N�o � permitido registrar valores negativos para vl_total e vl_locacao');
    RAISE_APPLICATION_ERROR (-20001, 'N�o � permitido registrar valores negativos para vl_total e vl_locacao');
  end if;
end;

insert into loc_item_locacao (dt_retirada, nr_item, dt_entrega, qt_dias, vl_locacao, nr_placa, vl_total, nr_pedido)
values (sysdate, 8, sysdate, 2, -500, 'BZT2255', -1000, 147);

-- 4) Crie uma trigger que fa�a o autoincremento do c�digo do departamento no momento da inclus�o. Isso quer dizer que n�o � necess�rio gerar o c�digo, 
-- pois esse valor ser� automaticamente atribu�do ap�s o comando insert. Siga os seguintes passos: - tabela LOC_DEPTO
-- Siga as seguintes regras :
-- Crie a sequence SEQ_DEPTO (defina um valor inicial apropriado)

create sequence SEQ_DEPTO start with 52;

-- Crie uma trigger for each row somente para o evento de insert que ir� utilizar essa sequence no momento da inser��o. 
-- Ex. SELECT SEQ_DEPTO.NEXTVAL INTO :new.cd_depto  from DUAL;

create or replace trigger trc_seq_depto
before insert on loc_depto
for each row 
begin
  select seq_depto.nextval into :new.cd_depto from dual;
exception
when others then
  RAISE_APPLICATION_ERROR (-20001,'Erro cr�tico no INSERT do departamento'|| SQLERRM);
end;

insert into loc_depto(nm_depto) values ('Teste')
-- Realize o insert e utilize o conte�do acima para o c�digo do cliente 

-- Crie um exception para qualquer erro inesperado que possa ocorrer, interrompendo o processamento, emitindo a seguinte mensagem de erro. 
-- 'Erro cr�tico no INSERT do departamento|| SQLERRM (exiba a mensagem e o c�digo de erro fornecido pelo SGBDOR) 

