SET @data_in  = '2024-07-10';
SET @data_out = '2024-07-15';

SELECT
    v.id_vaga,
    q.numero           AS quarto,
    q.capacidade       AS vagas_no_quarto,
    CASE q.tem_banheiro
         WHEN 1 THEN 'Com banheiro'
         ELSE 'Sem banheiro'
    END                AS banheiro,
    v.numero_vaga,
    v.tipo_cama,
    v.posicao,
    v.sol,
    v.observacoes,
    pv.valor_diaria,
    pv.valor_diaria * DATEDIFF(@data_out, @data_in) AS valor_estadia
FROM VAGA v
JOIN QUARTO    q  ON q.id_quarto = v.id_quarto
JOIN PRECO_VAGA pv ON pv.id_vaga = v.id_vaga
               AND pv.data_fim IS NULL
WHERE v.ativo = 1
  AND v.id_vaga NOT IN (
      SELECT ir.id_vaga
        FROM ITEM_RESERVA ir
        JOIN RESERVA r ON r.id_reserva = ir.id_reserva
       WHERE r.status IN ('pendente','confirmada')
         AND r.data_checkin  < @data_out
         AND r.data_checkout > @data_in
  )
ORDER BY q.tem_banheiro DESC, pv.valor_diaria, q.numero, v.numero_vaga;
