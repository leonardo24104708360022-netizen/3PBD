SET @id_usuario  = 1;
SET @data_in     = '2024-07-10';
SET @data_out    = '2024-07-15';
SET @id_vaga     = 1;

START TRANSACTION;

SELECT v.id_vaga
  FROM VAGA v
 WHERE v.id_vaga = @id_vaga
   AND v.ativo   = 1
   AND v.id_vaga NOT IN (
       SELECT ir.id_vaga FROM ITEM_RESERVA ir
       JOIN RESERVA r ON r.id_reserva = ir.id_reserva
       WHERE r.status IN ('pendente','confirmada')
         AND r.data_checkin  < @data_out
         AND r.data_checkout > @data_in
   )
FOR UPDATE;


SET @valor_diaria = (
    SELECT valor_diaria FROM PRECO_VAGA
     WHERE id_vaga = @id_vaga AND data_fim IS NULL
);
SET @num_dias   = DATEDIFF(@data_out, @data_in);
SET @valor_total = @valor_diaria * @num_dias;

INSERT INTO RESERVA (id_usuario, data_checkin, data_checkout, status, valor_total)
VALUES (@id_usuario, @data_in, @data_out, 'pendente', @valor_total);

SET @id_reserva = LAST_INSERT_ID();

INSERT INTO ITEM_RESERVA (id_reserva, id_vaga, valor_diaria)
VALUES (@id_reserva, @id_vaga, @valor_diaria);

COMMIT;
