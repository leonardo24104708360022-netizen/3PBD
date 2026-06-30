INSERT INTO PAGAMENTO
  (id_reserva, titular_cartao, ultimos_digitos, bandeira,
   status_pagamento, valor_pago)
VALUES (1, 'Ana Paula Souza', '4321', 'Visa', 'aprovado', 225.00);


UPDATE PAGAMENTO
   SET status_pagamento = 'estornado'
 WHERE id_reserva = 1;


DELETE FROM PAGAMENTO WHERE id_pagamento = 5;


SELECT p.id_pagamento, u.nome, r.data_checkin, r.data_checkout,
       p.titular_cartao, p.bandeira, p.ultimos_digitos,
       p.valor_pago, p.status_pagamento, p.data_pagamento
  FROM PAGAMENTO p
  JOIN RESERVA r ON r.id_reserva = p.id_reserva
  JOIN USUARIO u ON u.id_usuario = r.id_usuario
 WHERE p.id_reserva = 1;
