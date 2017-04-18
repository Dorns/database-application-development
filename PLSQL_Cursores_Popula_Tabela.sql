select * from pf0064.loc_veiculo v join pf0064.loc_proprietario pr on
v.cd_proprietario = pr.cd_proprietario;


DECLARE
  CURSOR CSR_VEICULO IS
    SELECT * FROM pf0064.loc_veiculo;
  CURSOR CSR_PROPRIETARIO IS
    SELECT * FROM pf0064.loc_proprietario;
  v_veiculo CSR_VEICULO%rowtype; 
  v_proprietario CSR_PROPRIETARIO%rowtype;
BEGIN 
  OPEN CSR_PROPRIETARIO;
    LOOP
      FETCH CSR_PROPRIETARIO INTO v_proprietario;
    EXIT WHEN CSR_PROPRIETARIO%notfound;
      INSERT INTO loc_proprietario (cd_proprietario, nome_proprietario, tp_proprietario, telefone, nr_cpf, nr_cgc, ds_email)
        VALUES (v_proprietario.cd_proprietario, v_proprietario.nome_proprietario, v_proprietario.tp_proprietario, v_proprietario.telefone, v_proprietario.nr_cpf, v_proprietario.nr_cgc, v_proprietario.ds_email);
    END LOOP;
  CLOSE CSR_PROPRIETARIO;
  OPEN CSR_VEICULO;
    LOOP
      FETCH CSR_VEICULO INTO v_veiculo;
    EXIT WHEN CSR_VEICULO%notfound;
      INSERT INTO loc_veiculo (nr_placa, cd_proprietario, nr_chassis, status, tipo_automovel, km_atual, combustivel, modelo, cor, cd_grupo)
        VALUES (v_veiculo.nr_placa, v_veiculo.cd_proprietario, v_veiculo.nr_chassis, v_veiculo.status, v_veiculo.tipo_automovel, v_veiculo.km_atual, v_veiculo.combustivel, v_veiculo.modelo, v_veiculo.cor, v_veiculo.cd_grupo);
    END LOOP;
  CLOSE CSR_VEICULO;
  COMMIT;
END;
