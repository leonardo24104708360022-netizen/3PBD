SET @data_in  = '2024-07-10';
SET @data_out = '2024-07-15';
SET @com_banheiro = 1;  

SELECT v.id_vaga, q.numero AS quarto, v.numero_vaga,
       v.tipo_cama, v.posicao, v.sol, pv.valor_diaria
  FROM VAGA v
  JOIN QUARTO     q  ON q.id_quarto = v.id_quarto
  JOIN PRECO_VAGA pv ON pv.id_vaga  = v.id_vaga AND pv.data_fim IS NULL
 WHERE q.tem_banheiro = @com_banheiro
   AND v.ativo = 1
   AND v.id_vaga NOT IN (
       SELECT ir.id_vaga FROM ITEM_RESERVA ir
       JOIN RESERVA r ON r.id_reserva = ir.id_reserva
       WHERE r.status IN ('pendente','confirmada')
         AND r.data_checkin  < @data_out
         AND r.data_checkout > @data_in
   )
 ORDER BY pv.valor_diaria, v.numero_vaga;
