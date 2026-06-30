START TRANSACTION;

INSERT INTO PAGAMENTO
  (id_reserva, titular_cartao, ultimos_digitos, bandeira,
   status_pagamento, valor_pago)
VALUES (@id_reserva, 'Ana Paula Souza', '4321', 'Visa', 'aprovado', @valor_total);

UPDATE RESERVA
   SET status = 'confirmada'
 WHERE id_reserva = @id_reserva
   AND status = 'pendente';

COMMIT;
