CREATE DATABASE IF NOT EXISTS albergue_almeida
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE albergue_almeida;

CREATE TABLE USUARIO (
    id_usuario    INT            NOT NULL AUTO_INCREMENT,
    nome          VARCHAR(100)   NOT NULL,
    email         VARCHAR(150)   NOT NULL,
    senha_hash    VARCHAR(255)   NOT NULL,
    cpf           CHAR(11)       NOT NULL,
    telefone      VARCHAR(20)    NULL,
    tipo          ENUM('estudante','turista','admin') NOT NULL DEFAULT 'turista',
    data_cadastro DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_USUARIO    PRIMARY KEY (id_usuario),
    CONSTRAINT UQ_EMAIL      UNIQUE (email),
    CONSTRAINT UQ_CPF        UNIQUE (cpf)
);

CREATE TABLE QUARTO (
    id_quarto    INT           NOT NULL AUTO_INCREMENT,
    numero       VARCHAR(10)   NOT NULL,
    capacidade   ENUM('4','8','12') NOT NULL,
    tem_banheiro TINYINT(1)    NOT NULL,
    andar        INT           NULL,
    descricao    TEXT          NULL,
    CONSTRAINT PK_QUARTO     PRIMARY KEY (id_quarto),
    CONSTRAINT UQ_NUMERO_QTO UNIQUE (numero),
    CONSTRAINT CHK_BANHEIRO  CHECK (
        (capacidade IN ('4','12') AND tem_banheiro = 1) OR
        (capacidade = '8'         AND tem_banheiro = 0)
    )
);

CREATE TABLE VAGA (
    id_vaga      INT  NOT NULL AUTO_INCREMENT,
    id_quarto    INT  NOT NULL,
    numero_vaga  INT  NOT NULL,
    tipo_cama    ENUM('simples','beliche_superior','beliche_inferior') NOT NULL,
    posicao      ENUM('perto_porta','perto_janela','meio') NULL,
    sol          ENUM('manha','tarde','sem_sol') NULL,
    ativo        TINYINT(1) NOT NULL DEFAULT 1,
    observacoes  TEXT NULL,
    CONSTRAINT PK_VAGA         PRIMARY KEY (id_vaga),
    CONSTRAINT FK_VAGA_QUARTO  FOREIGN KEY (id_quarto)
        REFERENCES QUARTO(id_quarto) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT UQ_VAGA         UNIQUE (id_quarto, numero_vaga)
);

CREATE TABLE PRECO_VAGA (
    id_preco    INT           NOT NULL AUTO_INCREMENT,
    id_vaga     INT           NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,
    data_inicio DATE          NOT NULL,
    data_fim    DATE          NULL,
    CONSTRAINT PK_PRECO       PRIMARY KEY (id_preco),
    CONSTRAINT FK_PRECO_VAGA  FOREIGN KEY (id_vaga)
        REFERENCES VAGA(id_vaga) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE RESERVA (
    id_reserva       INT            NOT NULL AUTO_INCREMENT,
    id_usuario       INT            NOT NULL,
    data_checkin     DATE           NOT NULL,
    data_checkout    DATE           NOT NULL,
    status           ENUM('pendente','confirmada','cancelada','concluida')
                     NOT NULL DEFAULT 'pendente',
    valor_total      DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    data_reserva     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_cancelamento DATETIME      NULL,
    CONSTRAINT PK_RESERVA         PRIMARY KEY (id_reserva),
    CONSTRAINT FK_RESERVA_USUARIO FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT CHK_DATAS          CHECK (data_checkout > data_checkin)
);

CREATE TABLE ITEM_RESERVA (
    id_item      INT           NOT NULL AUTO_INCREMENT,
    id_reserva   INT           NOT NULL,
    id_vaga      INT           NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_ITEM          PRIMARY KEY (id_item),
    CONSTRAINT FK_ITEM_RESERVA  FOREIGN KEY (id_reserva)
        REFERENCES RESERVA(id_reserva) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_ITEM_VAGA     FOREIGN KEY (id_vaga)
        REFERENCES VAGA(id_vaga) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE PAGAMENTO (
    id_pagamento     INT           NOT NULL AUTO_INCREMENT,
    id_reserva       INT           NOT NULL,
    titular_cartao   VARCHAR(100)  NOT NULL,
    ultimos_digitos  CHAR(4)       NOT NULL,
    bandeira         VARCHAR(30)   NOT NULL,
    status_pagamento ENUM('aprovado','recusado','estornado') NOT NULL,
    data_pagamento   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_pago       DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_PAGAMENTO        PRIMARY KEY (id_pagamento),
    CONSTRAINT FK_PAGAMENTO_RESERVA FOREIGN KEY (id_reserva)
        REFERENCES RESERVA(id_reserva) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT UQ_PAG_RESERVA      UNIQUE (id_reserva)
);
