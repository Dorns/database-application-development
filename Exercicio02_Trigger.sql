-- 1) Desenvolva uma trigger chamada trg_sincro_tot_pedido que para cada item movimentado de um determinado pedido na 
-- tabela LOC_ITEM_LOCACAO, o valor total de loca��o da tabela LOC_PEDIDO_LOCACAO seja atualizado.

create or replace trigger trg_sincro_tot_pedido 
after insert on loc_item_locacao
for each row
begin
  update loc_pedido_locacao set vl_total = prc_soma_vl_total(:new.nr_pedido) where nr_pedido = :new.nr_pedido;
end;

create or replace procedure prc_soma_vl_total (p_nr_pedido loc_item_locacao.nr_pedido%type)
is 
  pragma autonomous_transaction; 
begin
  select sum(vl_total) from loc_item_locacao 
  where nr_pedido = p_nr_pedido;
end;

select * from loc_pedido_locacao where nr_pedido = 147

select * from loc_item_locacao 

select * from loc_item_locacao where nr_pedido = 147

select sum(vl_total) from loc_item_locacao where nr_pedido = 147

insert into loc_item_locacao (dt_retirada, nr_item, dt_entrega, qt_dias, vl_locacao, nr_placa, vl_total, nr_pedido)
values (sysdate, 8, sysdate, 2, 500, 'BZT2255', 1000, 147);

delete from loc_item_locacao where nr_item = 8 and nr_pedido = 147

-- 2) Crie uma trigger que garanta que o valor da coluna DT_RETIRADA n�o seja MAIOR que o valor da coluna DT_ENTREGA 
-- na tabela LOC_ITEM_LOCACAO ? Caso isso ocorra, emita uma mensagem de erro pertinente e pare o processamento


-- 3) Implemente uma regra de neg�cio que garanta que n�o se tenha nenhum valor negativo nas coluna VL_LOCACAO e 
-- VL_TOTAL da tabela LOC_ITEM_LOCACAO ? Caso isso ocorra, emita uma mensagem de erro pertinente e pare o processamento. 
-- (caso queira, tamb�m gere informa��o na tabela de log criada no seu �ltimo exerc�cio complexo)

-- 4) Crie uma trigger que fa�a o autoincremento do c�digo do departamento no momento da inclus�o. Isso quer dizer que n�o � necess�rio gerar o c�digo, 
-- pois esse valor ser� automaticamente atribu�do ap�s o comando insert. Siga os seguintes passos: - tabela LOC_DEPTO
-- Siga as seguintes regras :
-- Crie a sequence SEQ_DEPTO (defina um valor inicial apropriado)

-- Crie uma trigger for each row somente para o evento de insert que ir� utilizar essa sequence no momento da inser��o. 
-- Ex. SELECT SEQ_DEPTO.NEXTVAL INTO :new.cd_depto  from DUAL;

-- Realize o insert e utilize o conte�do acima para o c�digo do cliente 

-- Crie um exception para qualquer erro inesperado que possa ocorrer, interrompendo o processamento, emitindo a seguinte mensagem de erro. 
-- 'Erro cr�tico no INSERT do departamento|| SQLERRM (exiba a mensagem e o c�digo de erro fornecido pelo SGBDOR) 

