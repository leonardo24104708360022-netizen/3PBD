SELECT
    q.numero             AS quarto,
    q.capacidade,
    CASE q.tem_banheiro WHEN 1 THEN 'Sim' ELSE 'Não' END AS banheiro,
    COUNT(v.id_vaga)     AS total_vagas,
    SUM(CASE WHEN v.id_vaga IN (
        SELECT ir.id_vaga FROM ITEM_RESERVA ir
        JOIN RESERVA r ON r.id_reserva = ir.id_reserva
        WHERE r.status IN ('pendente','confirmada')
          AND r.data_checkin  < @data_out
          AND r.data_checkout > @data_in
    ) THEN 1 ELSE 0 END) AS vagas_ocupadas,
    COUNT(v.id_vaga) -
    SUM(CASE WHEN v.id_vaga IN (
        SELECT ir.id_vaga FROM ITEM_RESERVA ir
        JOIN RESERVA r ON r.id_reserva = ir.id_reserva
        WHERE r.status IN ('pendente','confirmada')
          AND r.data_checkin  < @data_out
          AND r.data_checkout > @data_in
    ) THEN 1 ELSE 0 END) AS vagas_livres
FROM QUARTO q
JOIN VAGA v ON v.id_quarto = q.id_quarto AND v.ativo = 1
GROUP BY q.id_quarto
ORDER BY q.numero;
