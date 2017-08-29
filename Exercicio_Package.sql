--Desenvolver um package que contenha os seguintes objetos:
--  1)Function que receba como parâmetro uma data no formato 'dd/mm/yyyy' e retorne o dia da semana por extenso.
--  2)Function que receba como parâmetro o código do departamento e retorne o nome do departamento. 
--    Caso o departamento informado nao exista, retornar um erro para a aplicação. 
--    Tabela base: LOC_DEPTO
--  3)Procedure de LOG de erros, que implemente autonomous_transaction.

create or replace package pkg_exercicio01 is
  function fnc_retorna_dia_semana(p_data date) return varchar2;
  function fnc_retorna_nome_depto(p_cd_depto number) return varchar2;
  procedure prc_log_erro;
end;
/

create or replace package body pkg_exercicio01 is
  function fnc_retorna_dia_semana(p_data date) return varchar2
  is 
  
  begin
  
  end;
  function fnc_retorna_nome_depto(p_cd_depto number) return varchar2;
  procedure prc_log_erro;
end;
