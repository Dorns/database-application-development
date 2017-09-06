create table teste_tab_trigger (id number primary key, valor varchar2(100));

create sequence seq_tab_trigger start with 1;

create or replace trigger trg_seq_tab
before insert on teste_tab_trigger
for each row
begin
  :new.id :=seq_tab_trigger.nextval;
  prc_log2017_2tdsr('USUARIO SO',SYSDATE, 
    'DELETE FROM TESTE_TAB_TRIGGER WHERE ID='||:new.id);
end;

insert into teste_tab_trigger (valor) values ('teste');

select * from teste_tab_trigger;

--trigger nao sofre rollback, ele vai utilizar o proximo valor da sequence
rollback;


