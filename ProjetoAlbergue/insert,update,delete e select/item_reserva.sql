INSERT INTO ITEM_RESERVA (id_reserva, id_vaga, valor_diaria)
VALUES (1, 1, 45.00),
       (1, 2, 40.00);


UPDATE ITEM_RESERVA
   SET valor_diaria = 50.00
 WHERE id_item = 1;


DELETE FROM ITEM_RESERVA WHERE id_item = 2;


SELECT ir.id_item, q.numero AS quarto, v.numero_vaga,
       v.tipo_cama, v.posicao, v.sol, ir.valor_diaria
  FROM ITEM_RESERVA ir
  JOIN VAGA   v ON v.id_vaga   = ir.id_vaga
  JOIN QUARTO q ON q.id_quarto = v.id_quarto
 WHERE ir.id_reserva = 1;
