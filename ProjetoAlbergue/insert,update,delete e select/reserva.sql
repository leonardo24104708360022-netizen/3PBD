INSERT INTO RESERVA (id_usuario, data_checkin, data_checkout, status, valor_total)
VALUES (1, '2024-07-10', '2024-07-15', 'pendente', 225.00);


UPDATE RESERVA
   SET status = 'confirmada'
 WHERE id_reserva = 1;

UPDATE RESERVA
   SET status = 'cancelada',
       data_cancelamento = NOW()
 WHERE id_reserva = 1
   AND data_checkin > DATE_ADD(CURDATE(), INTERVAL 3 DAY)
   AND status IN ('pendente', 'confirmada');


DELETE FROM RESERVA
 WHERE id_reserva = 3
   AND status = 'pendente'
   AND NOT EXISTS (SELECT 1 FROM PAGAMENTO WHERE id_reserva = 3);


SELECT r.id_reserva, r.data_checkin, r.data_checkout,
       r.status, r.valor_total, r.data_reserva
  FROM RESERVA r
 WHERE r.id_usuario = 1
 ORDER BY r.data_reserva DESC;
