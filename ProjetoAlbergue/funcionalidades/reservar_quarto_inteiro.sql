SET @id_quarto = 1;
SET @data_in   = '2024-08-01';
SET @data_out  = '2024-08-05';
SET @id_usuario = 1;

START TRANSACTION;

SELECT COUNT(*) INTO @total_vagas
  FROM VAGA WHERE id_quarto = @id_quarto AND ativo = 1;

SELECT COUNT(*) INTO @vagas_ocupadas
  FROM VAGA v
  JOIN ITEM_RESERVA ir ON ir.id_vaga = v.id_vaga
  JOIN RESERVA r       ON r.id_reserva = ir.id_reserva
 WHERE v.id_quarto = @id_quarto
   AND r.status IN ('pendente','confirmada')
   AND r.data_checkin  < @data_out
   AND r.data_checkout > @data_in;


SELECT SUM(pv.valor_diaria) * DATEDIFF(@data_out, @data_in) INTO @valor_total
  FROM VAGA v
  JOIN PRECO_VAGA pv ON pv.id_vaga = v.id_vaga AND pv.data_fim IS NULL
 WHERE v.id_quarto = @id_quarto AND v.ativo = 1;

INSERT INTO RESERVA (id_usuario, data_checkin, data_checkout, status, valor_total)
VALUES (@id_usuario, @data_in, @data_out, 'pendente', @valor_total);

SET @id_reserva = LAST_INSERT_ID();

INSERT INTO ITEM_RESERVA (id_reserva, id_vaga, valor_diaria)
SELECT @id_reserva, v.id_vaga, pv.valor_diaria
  FROM VAGA v
  JOIN PRECO_VAGA pv ON pv.id_vaga = v.id_vaga AND pv.data_fim IS NULL
 WHERE v.id_quarto = @id_quarto AND v.ativo = 1;

COMMIT;
