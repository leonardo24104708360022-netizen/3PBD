INSERT INTO VAGA (id_quarto, numero_vaga, tipo_cama, posicao, sol, observacoes)
VALUES
  (1, 1, 'beliche_inferior', 'perto_janela', 'manha',   'Vista para o jardim'),
  (1, 2, 'beliche_superior', 'perto_janela', 'manha',   'Beliche superior, ventilado'),
  (1, 3, 'beliche_inferior', 'perto_porta',  'sem_sol', 'Próxima ao banheiro'),
  (1, 4, 'beliche_superior', 'perto_porta',  'sem_sol', 'Beliche superior, acesso fácil');

INSERT INTO VAGA (id_quarto, numero_vaga, tipo_cama, posicao, sol, observacoes)
VALUES
  (2, 1, 'beliche_inferior', 'perto_janela', 'manha',   'Sol da manhã'),
  (2, 2, 'beliche_superior', 'perto_janela', 'manha',   'Beliche superior com sol'),
  (2, 3, 'beliche_inferior', 'meio',         'sem_sol', 'Posição central'),
  (2, 4, 'beliche_superior', 'meio',         'sem_sol', 'Centro do quarto'),
  (2, 5, 'beliche_inferior', 'perto_porta',  'tarde',   'Sol da tarde'),
  (2, 6, 'beliche_superior', 'perto_porta',  'tarde',   'Beliche superior tarde'),
  (2, 7, 'simples',          'perto_janela', 'manha',   'Cama simples, janela'),
  (2, 8, 'simples',          'perto_porta',  'sem_sol', 'Cama simples, porta');


UPDATE VAGA SET ativo = 0, observacoes = 'Em manutenção'
 WHERE id_vaga = 3;

UPDATE VAGA SET ativo = 1, observacoes = 'Vista para o jardim'
 WHERE id_vaga = 3;


DELETE FROM VAGA
 WHERE id_vaga = 10
   AND NOT EXISTS (
       SELECT 1 FROM ITEM_RESERVA WHERE id_vaga = 10
   );


SELECT v.id_vaga, v.numero_vaga, v.tipo_cama, v.posicao, v.sol,
       q.numero AS quarto, q.tem_banheiro, v.observacoes
  FROM VAGA v
  JOIN QUARTO q ON q.id_quarto = v.id_quarto
 WHERE v.id_quarto = 1 AND v.ativo = 1
 ORDER BY v.numero_vaga;
