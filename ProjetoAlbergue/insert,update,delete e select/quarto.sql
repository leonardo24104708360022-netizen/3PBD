INSERT INTO QUARTO (numero, capacidade, tem_banheiro, andar, descricao)
VALUES ('Q01', '4',  1, 1, 'Quarto premium com banheiro privativo'),
       ('Q02', '8',  0, 1, 'Quarto compartilhado sem banheiro'),
       ('Q03', '12', 1, 2, 'Quarto amplo com banheiro coletivo'),
       ('Q04', '4',  1, 2, 'Quarto menor com banheiro'),
       ('Q05', '8',  0, 3, 'Quarto sem banheiro, vista para jardim');


UPDATE QUARTO
   SET descricao = 'Quarto reformado com banheiro renovado',
       andar     = 1
 WHERE id_quarto = 1;


DELETE FROM QUARTO
 WHERE id_quarto = 5
   AND NOT EXISTS (SELECT 1 FROM VAGA WHERE id_quarto = 5);


SELECT id_quarto, numero, capacidade, tem_banheiro, andar
  FROM QUARTO
 ORDER BY numero;

SELECT * FROM QUARTO WHERE tem_banheiro = 1;

SELECT * FROM QUARTO WHERE tem_banheiro = 0;
