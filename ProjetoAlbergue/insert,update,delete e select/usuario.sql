INSERT INTO USUARIO (nome, email, senha_hash, cpf, telefone, tipo)
VALUES ('Ana Paula Souza', 'ana@email.com',
        SHA2('senha123', 256), '12345678901', '(11) 91234-5678', 'estudante');

INSERT INTO USUARIO (nome, email, senha_hash, cpf, tipo)
VALUES ('Carlos Turista', 'carlos@email.com',
        SHA2('abc456', 256), '98765432100', 'turista');


UPDATE USUARIO
   SET telefone = '(21) 99876-5432',
       tipo     = 'turista'
 WHERE id_usuario = 1;


DELETE FROM USUARIO
 WHERE id_usuario = 2
   AND NOT EXISTS (
       SELECT 1 FROM RESERVA WHERE id_usuario = 2
   );


SELECT id_usuario, nome, email, cpf, tipo, data_cadastro
  FROM USUARIO
 ORDER BY nome;

SELECT id_usuario, nome, tipo
  FROM USUARIO
 WHERE email = 'ana@email.com';
