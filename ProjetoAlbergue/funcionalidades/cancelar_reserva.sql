START TRANSACTION;

SELECT id_reserva, data_checkin, status
  FROM RESERVA
 WHERE id_reserva = @id_reserva
   AND status IN ('pendente', 'confirmada')
   AND data_checkin > DATE_ADD(CURDATE(), INTERVAL 3 DAY);


UPDATE RESERVA
   SET status            = 'cancelada',
       data_cancelamento = NOW()
 WHERE id_reserva = @id_reserva;

UPDATE PAGAMENTO
   SET status_pagamento = 'estornado'
 WHERE id_reserva = @id_reserva
   AND status_pagamento = 'aprovado';

COMMIT;
