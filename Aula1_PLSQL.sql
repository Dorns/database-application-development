set serveroutput on; --Habilita retorno da console do server

DECLARE 
  mensagem VARCHAR2(100) := 'Hello World!';
BEGIN
  DBMS_OUTPUT.put_line(mensagem);
END;

--EXERCICIOS
--Soma, Multiplicação e Divisão de 2 numeros.

DECLARE
  v1 NUMBER := 5;
  v2 NUMBER := 7;
  soma NUMBER;
  multiplicacao NUMBER;
  divisao NUMBER;
BEGIN
  soma := (v1+v2);
  multiplicacao := (v1*v2);
  divisao := (v1/v2);
  DBMS_OUTPUT.put_line('Entrada v1:' || v1 || ' e v2:' || v2 || ' Soma: ' || 
  soma || '; Multiplicação: ' || multiplicacao || '; Divisão: ' || divisao);
END;
 
--Mostrar apenas o primeiro nome com uma variavel de nome completo 
DECLARE 
  nome_completo VARCHAR2(100) := 'Felipe Dornelas Viel';
BEGIN
  DBMS_OUTPUT.put_line(SUBSTR(nome_completo, 0, INSTR(nome_completo, ' ') -1));
END;

--receba uma data no formato DD/MM/YYYY e mostre só o mes por extenso

DECLARE 
  data DATE := '10/01/1995';
BEGIN
  DBMS_OUTPUT.put_line(data, 'MM');
END;
