SELECT
    r.id_reserva,
    r.data_checkin,
    r.data_checkout,
    DATEDIFF(r.data_checkout, r.data_checkin) AS dias,
    r.status,
    r.valor_total,
    p.bandeira,
    p.ultimos_digitos,
    p.status_pagamento,
    GROUP_CONCAT(
        CONCAT('Q', q.numero, '-V', v.numero_vaga) ORDER BY q.numero
    ) AS vagas_reservadas
FROM RESERVA r
LEFT JOIN PAGAMENTO  p  ON p.id_reserva = r.id_reserva
LEFT JOIN ITEM_RESERVA ir ON ir.id_reserva = r.id_reserva
LEFT JOIN VAGA v ON v.id_vaga = ir.id_vaga
LEFT JOIN QUARTO q ON q.id_quarto = v.id_quarto
WHERE r.id_usuario = @id_usuario
GROUP BY r.id_reserva
ORDER BY r.data_reserva DESC;
