--Desenvolver um trigger que deverá rastrear e armazenar na tabela LOG2017_2TDSR 
--todos os comandos de DML da tablea LOC_FUNCIONARIO.
--Este trigger deverá registrar um comando para desfazer todas as DMLs realizadas.

create or replace trigger trg_DML_func 
before insert or update or delete on LOC_FUNCIONARIO
for each row
begin
  if inserting then
    prc_log2017_2tdsr('USUARIO SO',SYSDATE, 
    'DELETE FROM LOC_FUNCIONARIO WHERE CD_FUNC='||:new.cd_func);
  elsif updating then
    prc_log2017_2tdsr('USUARIO SO', SYSDATE,
    'UPDATE FROM LOC_FUNCIONARIO SET NM_FUNC='||:old.nm_func||', DT_INICIO='||:old.dt_inicio||', CD_GERENTE='||:old.cd_gerente||', NR_CPF='||:old.nr_cpf||', VL_SALARIO='||:old.vl_salario||', VL_PERC_COMISSAO='||:old.vl_perc_comissao||', CD_DEPTO='||:old.cd_depto||', NR_ESTRELAS='||:old.nr_estrelas||', NM_CARGO='||:old.nm_cargo||
    ' WHERE CD_FUNC='||:old.cd_func);
  elsif deleting then
    prc_log2017_2tdsr('USUARIO SO',SYSDATE, 
    'INSERT INTO LOC_FUNCIONARIO (CD_FUNC, NM_FUNC, DT_INICIO, CD_GERENTE, NR_CPF, VL_SALARIO, VL_PERC_COMISSAO, CD_DEPTO, NR_ESTRELAS, NM_CARGO) VALUES ('||:old.cd_func||','||:old.nm_func||','||:old.dt_inicio||','||:old.cd_gerente||','||:old.nr_cpf||','||:old.vl_salario||','||:old.vl_perc_comissao||','||:old.cd_depto||','||:old.nr_estrelas||','||:old.nm_cargo);
  end if;
end;

SELECT * FROM LOC_FUNCIONARIO;

