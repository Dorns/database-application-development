declare
  cursor cGrupo is
    select * from pf0064.loc_grupo where cd_grupo between 1 and 5;
    
  v_grupo   cGrupo%rowtype;
begin
  open cGrupo;
  loop
    fetch cGrupo into v_grupo;
    exit when cGrupo%notfound;
    insert into loc_grupo (cd_grupo, ds_grupo, vl_locacao_diaria)
      values(v_grupo.cd_grupo, v_grupo.ds_grupo, v_grupo.vl_locacao_diaria);
  end loop;
  close cGrupo;
  commit;  
end;