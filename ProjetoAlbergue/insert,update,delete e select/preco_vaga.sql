INSERT INTO PRECO_VAGA (id_vaga, valor_diaria, data_inicio)
VALUES
  (1, 45.00, '2024-01-01'),
  (2, 40.00, '2024-01-01'),
  (3, 42.00, '2024-01-01'),
  (4, 40.00, '2024-01-01');


UPDATE PRECO_VAGA
   SET data_fim = CURDATE()
 WHERE id_vaga = 1 AND data_fim IS NULL;

INSERT INTO PRECO_VAGA (id_vaga, valor_diaria, data_inicio)
VALUES (1, 55.00, DATE_ADD(CURDATE(), INTERVAL 1 DAY));


DELETE FROM PRECO_VAGA WHERE id_preco = 5;


SELECT v.id_vaga, q.numero AS quarto, v.numero_vaga, pv.valor_diaria
  FROM PRECO_VAGA pv
  JOIN VAGA   v ON v.id_vaga   = pv.id_vaga
  JOIN QUARTO q ON q.id_quarto = v.id_quarto
 WHERE pv.data_fim IS NULL
 ORDER BY q.numero, v.numero_vaga;
