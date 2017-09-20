-- 1) Desenvolva uma trigger chamada trg_sincro_tot_pedido que para cada item movimentado de um determinado pedido na 
-- tabela LOC_ITEM_LOCACAO, o valor total de locação da tabela LOC_PEDIDO_LOCACAO seja atualizado.

--FALHA NA APLICAÇÃO, NAO TEM SOLUÇÃO DIRETA, PROBLEMA DE MODELAGEM DE BANCO, NÃO SE DEVE UTILIZAR CAMPOS DE VALOR DE SOMA TOTAL.

-- 2) Crie uma trigger que garanta que o valor da coluna DT_RETIRADA não seja MAIOR que o valor da coluna DT_ENTREGA 
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

-- 3) Implemente uma regra de negócio que garanta que não se tenha nenhum valor negativo nas coluna VL_LOCACAO e 
-- VL_TOTAL da tabela LOC_ITEM_LOCACAO ? Caso isso ocorra, emita uma mensagem de erro pertinente e pare o processamento. 
-- (caso queira, também gere informação na tabela de log criada no seu último exercício complexo)

create or replace trigger trc_item_negativo_biu
before insert or update on loc_item_locacao
for each row
begin
  if (:new.vl_locacao < 0) or (:new.vl_total < 0) then
    prc_log2017_2tdsr('USUARIO SO', SYSDATE, 'Não é permitido registrar valores negativos para vl_total e vl_locacao');
    RAISE_APPLICATION_ERROR (-20001, 'Não é permitido registrar valores negativos para vl_total e vl_locacao');
  end if;
end;

insert into loc_item_locacao (dt_retirada, nr_item, dt_entrega, qt_dias, vl_locacao, nr_placa, vl_total, nr_pedido)
values (sysdate, 8, sysdate, 2, -500, 'BZT2255', -1000, 147);

-- 4) Crie uma trigger que faça o autoincremento do código do departamento no momento da inclusão. Isso quer dizer que não é necessário gerar o código, 
-- pois esse valor será automaticamente atribuído após o comando insert. Siga os seguintes passos: - tabela LOC_DEPTO
-- Siga as seguintes regras :
-- Crie a sequence SEQ_DEPTO (defina um valor inicial apropriado)

create sequence SEQ_DEPTO start with 52;

-- Crie uma trigger for each row somente para o evento de insert que irá utilizar essa sequence no momento da inserção. 
-- Ex. SELECT SEQ_DEPTO.NEXTVAL INTO :new.cd_depto  from DUAL;

create or replace trigger trc_seq_depto
before insert on loc_depto
for each row 
begin
  select seq_depto.nextval into :new.cd_depto from dual;
exception
when others then
  RAISE_APPLICATION_ERROR (-20001,'Erro crítico no INSERT do departamento'|| SQLERRM);
end;

insert into loc_depto(nm_depto) values ('Teste')
-- Realize o insert e utilize o conteúdo acima para o código do cliente 

-- Crie um exception para qualquer erro inesperado que possa ocorrer, interrompendo o processamento, emitindo a seguinte mensagem de erro. 
-- 'Erro crítico no INSERT do departamento|| SQLERRM (exiba a mensagem e o código de erro fornecido pelo SGBDOR) 

