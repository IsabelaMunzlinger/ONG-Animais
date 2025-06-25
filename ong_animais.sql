-- //PROJETO EM CONJUNTO - CRIAÇÃO DE UM BANCO DE DADOS PARA ARMAZENAMENTO DE INFORMAÇÕES DE UMA ONG DE ADOÇÃO DE ANIMAIS.
-- //AVALIAÇÃO A1.3.
-- //ALUNOS: ISABELA F., ISABELA M., MARCOS R., VITOR C.
-- --------------------------------------------------------
-- //CONFIGURAÇÕES INICIAIS - SCHEMA.
-- --------------------------------------------------------
DROP SCHEMA IF EXISTS ong_animais;
CREATE SCHEMA IF NOT EXISTS ong_animais;
USE ong_animais;
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //TABELAS.
-- --------------------------------------------------------
-- --------------------------------------------------------

-- --------------------------------------------------------
-- //TABELA USUÁRIOS.
-- --------------------------------------------------------
CREATE TABLE Usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    genero ENUM('Homem', 'Mulher', 'Não informar', 'Não binário'),
    tipo CHAR(1) NOT NULL,
    data_cadastro DATETIME NOT NULL,
    foto VARCHAR(1024) DEFAULT '-',
    senha VARCHAR(128) NOT NULL
);
-- --------------------------------------------------------
-- //TABELA ENDEREÇOS.
-- --------------------------------------------------------
CREATE TABLE Enderecos (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT NOT NULL,
    cep CHAR(8) NOT NULL,
    rua VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    bairro VARCHAR(255) NOT NULL,
    estado VARCHAR(255) NOT NULL,
    numero VARCHAR(255) NOT NULL,
    pais VARCHAR(255) NOT NULL,
    tipo ENUM('fixo', 'temporário', 'empresarial'),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA CONTATOS.
-- --------------------------------------------------------
CREATE TABLE Contatos (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT NOT NULL,
    email VARCHAR(255) NOT NULL,
    celular CHAR(11) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id) ON DELETE CASCADE
);
-- --------------------------------------------------------

-- //TABELA ANIMAIS.
-- --------------------------------------------------------
CREATE TABLE Animais (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL DEFAULT '-',
    descricao VARCHAR(255) NOT NULL DEFAULT '-',
    raca VARCHAR(255) NOT NULL DEFAULT '-',
    idade INT DEFAULT 0,
    especie VARCHAR(255) NOT NULL,
    foto VARCHAR(1024) NOT NULL DEFAULT '-',
    peso DOUBLE NOT NULL DEFAULT 0.0,
    sexo CHAR(1) NOT NULL DEFAULT 'F',
    situacao CHAR(1) NOT NULL DEFAULT 'D',
    porte ENUM('grande', 'medio', 'pequeno') NOT NULL DEFAULT 'pequeno',
    data_chegada DATETIME NOT NULL DEFAULT NOW(),
    data_nascimento DATETIME DEFAULT NOW(),
    cor VARCHAR(255) NOT NULL DEFAULT '-',
    historia VARCHAR(512)
);
-- --------------------------------------------------------
-- //TABELA PRONTUÁRIOS.
-- --------------------------------------------------------
CREATE TABLE Prontuarios (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    animal_id INT,
    observacoes_gerais VARCHAR(255),
    alergias VARCHAR(255),
    deficiencia VARCHAR(255),
    castrado CHAR(1) NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES Animais(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA ADOÇÕES.
-- --------------------------------------------------------
CREATE TABLE Adocoes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT,
    animal_id INT,
    data_adocao DATETIME NOT NULL,
    situacao ENUM('em analise', 'aprovado', 'concluido', 'cancelado') NOT NULL,
    observacoes VARCHAR(255),
    motivo_reprovacao VARCHAR(255) DEFAULT '-',
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (animal_id) REFERENCES Animais(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA FORNECEDORES.
-- --------------------------------------------------------
CREATE TABLE Fornecedores (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    representante_id INT,
    nome VARCHAR(255) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    ramo VARCHAR(255),
    FOREIGN KEY (representante_id) REFERENCES Usuarios(id) ON DELETE SET NULL
);
-- --------------------------------------------------------
-- //TABELA ESTOQUES.
-- --------------------------------------------------------
CREATE TABLE Estoques (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    quantidade INT,
    valor DECIMAL(10, 2),
    data_validade DATETIME
);
-- --------------------------------------------------------
-- //TABELA FUNCIONÁRIOS.
-- --------------------------------------------------------
CREATE TABLE Funcionarios (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT,
    salario DECIMAL(10, 2),
    funcao VARCHAR(255) NOT NULL,
    data_ingresso DATETIME NOT NULL,
    data_saida DATETIME,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA SOLICITAÇÕES.
-- --------------------------------------------------------
CREATE TABLE Solicitacoes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    funcionario_id INT,
    tipo ENUM('adoção', 'doação', 'consulta') NOT NULL,
    data_solicitacao DATETIME NOT NULL,
    descricao VARCHAR(255),
    situacao ENUM('pendente', 'aprovado', 'recusado') NOT NULL,
    prioridade CHAR(1) NOT NULL,
    FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA CAMPANHAS.
-- --------------------------------------------------------
CREATE TABLE Campanhas (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    organizador_id INT,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255),
    data_inicio DATETIME NOT NULL,
    data_termino DATETIME NOT NULL,
    meta VARCHAR(255),
    situacao ENUM('realizada', 'cancelada', 'em ocorrência', 'aguardando'),
    tipo VARCHAR(255) NOT NULL,
    localizacao VARCHAR(255) NOT NULL,
    custo DECIMAL(10, 2),
    lucro DECIMAL(10, 2),
    FOREIGN KEY (organizador_id) REFERENCES Usuarios(id) ON DELETE SET NULL
);
-- --------------------------------------------------------
-- //TABELA DOAÇÕES.
-- --------------------------------------------------------
CREATE TABLE Doacoes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    doador_id INT,
    valor DECIMAL(10, 2),
    quantidade INT,
    tipo VARCHAR(255) NOT NULL,
    descricao VARCHAR(255),
    situacao ENUM('confirmada', 'pendente', 'cancelada') NOT NULL,
    FOREIGN KEY (doador_id) REFERENCES Usuarios(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA VOLUNTÁRIOS.
-- --------------------------------------------------------
CREATE TABLE Voluntarios (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT,
    situacao VARCHAR(255),
    disponibilidade VARCHAR(512),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA TRATAMENTOS.
-- ----------------------------------------------------------
CREATE TABLE Tratamentos (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    animal_id INT,
    clinica VARCHAR(255),
    tipo VARCHAR(255) NOT NULL,
    descricao VARCHAR(255),
    data_realizacao DATETIME NOT NULL,
    custo DECIMAL(10, 2),
    observacoes VARCHAR(255),
    FOREIGN KEY (animal_id) REFERENCES Animais(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA AGENDAMENTOS.
-- --------------------------------------------------------
CREATE TABLE Agendamentos (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    funcionario_id INT,
    animal_id INT,
    tipo VARCHAR(255) NOT NULL,
    data_agendamento DATETIME NOT NULL,
    observacoes VARCHAR(255),
    FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(id),
    FOREIGN KEY (animal_id) REFERENCES Animais(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA DOENÇAS.
-- --------------------------------------------------------
CREATE TABLE Doencas(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    cid VARCHAR(255) NOT NULL,
	nome VARCHAR(255) NOT NULL
);
-- --------------------------------------------------------
-- //TABELA INTERMEDIÁRIA DOENÇAS X PRONTUÁRIOS.
-- --------------------------------------------------------
CREATE TABLE Doenca_Prontuario(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	doenca_id INT,
    prontuario_id INT,
	FOREIGN KEY (doenca_id) REFERENCES Doencas(id) ON DELETE CASCADE,
	FOREIGN KEY (prontuario_id) REFERENCES Prontuarios(id) ON DELETE CASCADE
);
-- --------------------------------------------------------
-- //TABELA VACINAS.
-- --------------------------------------------------------
CREATE TABLE Vacinas(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nome VARCHAR(255) NOT NULL,
    codigo VARCHAR(255) NOT NULL
);
-- --------------------------------------------------------
-- //TABELA INTERMEDIÁRIA VACINAS X ANIMAIS.
-- --------------------------------------------------------
CREATE TABLE Animal_Vacina(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	animal_id INT,
    vacina_id INT,
	FOREIGN KEY (vacina_id) REFERENCES Vacinas(id) ON DELETE CASCADE,
	FOREIGN KEY (animal_id) REFERENCES Animais(id) ON DELETE CASCADE
);
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //INSERTS.
-- --------------------------------------------------------
-- --------------------------------------------------------


-- --------------------------------------------------------
-- //INSERTS TABELA USUÁRIOS.
-- --------------------------------------------------------
INSERT INTO Usuarios (nome, cpf, data_nascimento, genero, tipo, data_cadastro, foto, senha) VALUES
('Ana Silva', '11122233301', '1990-05-15', 'Mulher', 'F', '2023-01-15', 'https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'), -- FUNCIONÁRIO.
('Bruno Costa', '44455566602', '1985-11-22', 'Homem', 'D', '2023-02-28', 'https://media.istockphoto.com/id/1418476287/pt/foto/businessman-analyzing-companys-financial-balance-sheet-working-with-digital-augmented-reality.jpg?s=612x612&w=0&k=20&c=WFQ_J9gP8BBWQrsFrgBikbn15d5JzSeAS_8_kVlcQGY=', '6cf615d5bcaac778352a8f1f3360d23f02f34ec182e259897fd6ce485d7870d4'), -- DOADOR FORNECEDOR.
('Carla Dias', '77788899903', '1992-03-10', 'Mulher', 'F', '2023-03-10', 'https://media.istockphoto.com/id/1482199015/pt/foto/happy-puppy-welsh-corgi-14-weeks-old-dog-winking-panting-and-sitting-isolated-on-white.jpg?s=612x612&w=0&k=20&c=XI-fFXTXEU4UbQtGwM_vWzBB4F17W4dlPtXL4wr2dmE=', 'f6a0cb513d7d6b01e0d6b0a1a7b0e8e3e0d6b0a1a7b0e8e3e0d6b0a1a7b0e8e'), -- FUNCIONÁRIO.
('Daniel Rocha', '00011122204', '1978-08-01', 'Homem', 'D', '2023-04-05', 'https://st2.depositphotos.com/3889193/8014/i/450/depositphotos_80147336-stock-photo-business-teamwork.jpg', 'a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e'), -- DOADOR FORNECEDOR.
('Eduarda Lima', '33344455505', '2000-01-20', 'Não informar', 'F', '2023-05-20', 'https://static.vecteezy.com/ti/fotos-gratis/p1/25796700-feliz-sorridente-cachorro-branco-fundo-foto.jpeg', '2ef7bde608ce5404e97d5f042f95f89f1c232871d4b600d7a9a1a3c5a8e0e1d2'), -- FUNCIONÁRIO.
('Fernanda Souza', '66677788806', '1995-07-07', 'Mulher', 'V', '2023-06-12', 'https://static7.depositphotos.com/1003131/700/i/450/depositphotos_7001700-stock-photo-2-month-old-labrador-retriever.jpg', '3a7bd3e2360a3d29eea436fcfb7e44c735d117c7d4b6d5e6a7b8c9d0e1f2g3h4'), -- VOLUNTÁRIO.
('Gustavo Pereira', '99900011107', '1988-04-30', 'Homem', 'F', '2023-07-03', 'https://media.istockphoto.com/id/1439709160/pt/foto/welsh-corgi-cardigan-cute-fluffy-dog-puppy-funny-happy-animals-on-white-background-with-copy.jpg?s=612x612&w=0&k=20&c=oAeaRKcaTQS98ucKq-shLDtmpqU0MQ3f3MeX08ewF1o=', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08'), -- FUNCIONÁRIO.
('Mariana Gomes', '12345678908', '1993-02-28', 'Mulher', 'F', '2023-08-25', 'https://media.istockphoto.com/id/611308904/pt/foto/cute-sitting-havanese-puppy-dog.jpg?s=612x612&w=0&k=20&c=GoEKw67iNll65XHsn8UHp6f--X7WPcXGAfHkZTeE0_s=', '5d41402abc4b2a76b9719d911017c5923c2b3d4e5f6g7h8i9j0k1l2m3n4o5p6'), -- FUNCIONÁRIO.
('Pedro Almeida', '98765432109', '1980-12-05', 'Homem', 'D', '2023-09-14', 'https://www.pontotel.com.br/local/wp-content/uploads/2022/09/stock-options-vantagens-das-stock-options-para-sua-empresa.webp', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'), -- DOADOR FORNECEDOR.
('Juliana Santos', '10293847560', '1998-09-19', 'Mulher', 'F', '2023-10-30', 'https://thumbs.dreamstime.com/b/gato-blanco-y-negro-lindo-mirando-cámara-sobre-fondo-recortado-preiocos-fijamente-150565280.jpg', '7c4a8d09ca3762af61e59520943dc26494f8941b244857f3a7f3b3f5f6a7b8c9'), -- FUNCIONÁRIO.
('Roberto Silva', '21232344401', '1975-01-25', 'Homem', 'A', '2023-11-08', 'https://thumbs.dreamstime.com/b/retrato-de-um-jovem-sorridente-e-bonito-com-braços-rebatidos-homens-alegres-sorridentes-mãos-cruzadas-fotos-isoladas-estúdio-172869765.jpg', 'd8578edf8458ce06fbc5bb76a58c5ca4d4a5b4e5f6g7h8i9j0k1l2m3n4o5p6q7'), -- ADOTANTE.
('Patrícia Oliveira', '54565677702', '1991-08-12', 'Mulher', 'D', '2023-12-22', 'https://static.vecteezy.com/ti/fotos-gratis/t2/27056260-o-negocio-mulher-enviando-renuncia-carta-e-embalagem-coisa-demitir-se-deprimir-ou-carregando-o-negocio-cartao-caixa-de-escrivaninha-dentro-escritorio-mudanca-do-trabalho-ou-disparamos-a-partir-de-companhia-foto.jpg', 'e6c3da5b206634d7f3f3586d5ff611f5a5f5a5f5a5f5a5f5a5f5a5f5a5f5a5f'), -- DOADOR FORNECEDOR.
('Ricardo Mendes', '87898900003', '1983-04-03', 'Homem', 'F', '2024-01-07', 'https://thumbs.dreamstime.com/b/gato-pequeno-listrado-31398453.jpg', 'b3eacd33433b31b525d6a5f5e5f5a5f5a5f5a5f5a5f5a5f5a5f5a5f5a5f5a5f'), -- FUNCIONÁRIO.
('Amanda Souza', '10121233304', '1996-06-20', 'Mulher', 'A', '2024-02-18', 'https://t4.ftcdn.net/jpg/02/82/72/09/360_F_282720917_7ZtAfEqEfA6CRT66imV9avGWXEg9w6Jt.jpg', 'c4ca4238a0b923820dcc509a6f75849b8a8a7a6a5a4a3a2a1a0a9a8a7a6a5a4a'), -- ADOTANTE.
('Felipe Castro', '34353566605', '1970-11-01', 'Homem', 'D', '2024-03-29', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM2lv5dlvmHxbX5e1bbgea4VaT1jpSg2MHmQ&s', 'd3e9f8e7d6c5b4a3a2a1a0a9a8a7a6a5a4a3a2a1a0a9a8a7a6a5a4a3a2a1a0a'), -- DOADOR FORNECEDOR.
('Larissa Alves', '67686899906', '1989-02-14', 'Mulher', 'F', '2024-04-01', 'https://img.freepik.com/fotos-premium/gato-e-cachorro-juntos-olhando-para-a-camera-em-fundo-colorido_191971-28721.jpg?semt=ais_hybrid&w=740', 'e2d1e0dfcfcebdacab9a8a7a6a5a4a3a2a1a0a9a8a7a6a5a4a3a2a1a0a9a8a7'), -- FUNCIONÁRIO.
('Marcelo Rocha', '90919122207', '1994-09-05', 'Homem', 'F', '2025-05-11', 'https://st2.depositphotos.com/1570716/8433/i/450/depositphotos_84330370-stock-photo-portrait-of-a-smart-young.jpg', 'f1e2d3c4b5a6a7a8a9a0a1a2a3a4a5a6a7a8a9a0a1a2a3a4a5a6a7a8a9a0a1a'), -- FUNCIONÁRIO.
('Marcela Fernandes', '01020233308', '1987-07-28', 'Mulher', 'D', '2025-06-19', 'https://media.istockphoto.com/id/1441823040/photo/business-people-in-finance-meeting-with-laptop-document-report-and-notebook-for-company.jpg?s=612x612&w=0&k=20&c=FxnZ4d1fHi0WnGOssxwXPFqJJSIIpaQaWXvlQrfOyXw=', '0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b'), -- DOADOR FORNECEDOR.
('Thiago Lima', '34354562609', '1999-03-17', 'Homem', 'V', '2025-07-23', 'https://img3.stockfresh.com/files/f/feedough/m/89/1768446_stock-photo-siamese-cat-standing.jpg', '1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b'), -- VOLUNTÁRIO.
('Gisele Costa', '67686899910', '1982-10-09', 'Mulher', 'F', '2025-08-09', 'https://st4.depositphotos.com/5260901/31593/i/450/depositphotos_315935436-stock-photo-beautiful-female-african-american-business.jpg', '2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b'); -- FUNCIONÁRIO.
-- --------------------------------------------------------
-- //INSERTS TABELA ENDEREÇOS.
-- --------------------------------------------------------
INSERT INTO Enderecos (usuario_id, cep, rua, cidade, bairro, estado, numero, pais, tipo) VALUES
(1, '88330000', 'Rua Principal', 'Balneário Camboriú', 'Centro', 'SC', '123', 'Brasil', 'fixo'),
(2, '88015500', 'Avenida Central', 'Florianópolis', 'Trindade', 'SC', '456', 'Brasil', 'empresarial'),
(3, '89010000', 'Rua das Flores', 'Blumenau', 'Jardim', 'SC', '789', 'Brasil', 'fixo'),
(4, '88701000', 'Rua dos Pinheiros', 'Tubarao', 'Vila Nova', 'SC', '101', 'Brasil', 'empresarial'),
(5, '88301000', 'Rua do Mar', 'Itajaí', 'Praia', 'SC', '202', 'Brasil', 'temporário'),
(6, '89201000', 'Rua da Montanha', 'Joinville', 'Glória', 'SC', '303', 'Brasil', 'fixo'),
(7, '88080000', 'Rua da Paz', 'Florianópolis', 'Coqueiros', 'SC', '404', 'Brasil', 'fixo'),
(8, '88034000', 'Rua dos Ipês', 'Florianópolis', 'Santa Mônica', 'SC', '505', 'Brasil', 'fixo'),
(9, '89050000', 'Avenida do Vale', 'Blumenau', 'Itoupava Norte', 'SC', '606', 'Brasil', 'empresarial'),
(10, '88303000', 'Rua dos Gaivotas', 'Itajaí', 'Centro', 'SC', '707', 'Brasil', 'fixo'),
(11, '88010000', 'Rua dos Navegantes', 'Florianópolis', 'Centro', 'SC', '1001', 'Brasil', 'fixo'),
(12, '88304000', 'Avenida Brasil', 'Balneário Camboriú', 'Nações', 'SC', '2002', 'Brasil', 'empresarial'),
(13, '89052000', 'Rua Quinze de Novembro', 'Blumenau', 'Velha', 'SC', '3003', 'Brasil', 'fixo'),
(14, '88702000', 'Rua Osvaldo Cruz', 'Tubarao', 'Oficinas', 'SC', '4004', 'Brasil', 'fixo'),
(15, '88305000', 'Avenida Atlântica', 'Itajaí', 'Cabeçudas', 'SC', '5005', 'Brasil', 'temporário'),
(16, '89202000', 'Rua XV de Novembro', 'Joinville', 'Centro', 'SC', '6006', 'Brasil', 'fixo'),
(17, '88085000', 'Rua das Palmeiras', 'Florianópolis', 'Estreito', 'SC', '7007', 'Brasil', 'fixo'),
(18, '88036000', 'Rua Felipe Schmidt', 'Florianópolis', 'Agronômica', 'SC', '8008', 'Brasil', 'fixo'),
(19, '89053000', 'Rua Dr. Pedro Zimmermann', 'Blumenau', 'Salto Norte', 'SC', '9009', 'Brasil', 'empresarial'),
(20, '88306000', 'Rua Brusque', 'Itajaí', 'São Vicente', 'SC', '1010', 'Brasil', 'fixo');
-- --------------------------------------------------------
-- //INSERTS TABELA CONTATOS.
-- --------------------------------------------------------
INSERT INTO Contatos (usuario_id, email, celular) VALUES
(1, 'ana.silva@hotmail.com', '48991234567'),
(2, 'bruno.costa@gmail.com', '48992345678'),
(3, 'carla.dias@outlook.com', '47993456789'),
(4, 'daniel.rocha@outlook.com', '48994567890'),
(5, 'eduarda.lima@gmail.com', '47995678901'),
(6, 'fernanda.souza@hotmail.com', '47996789012'),
(7, 'gustavo.pereira@gmail.com', '48997890123'),
(8, 'mariana.gomes@hotmail.com', '48998765432'),
(9, 'pedro.almeida@outlook.com', '47990123456'),
(10, 'juliana.santos@gmail.com', '48991029384'),
(11, 'roberto.silva@gmail.com', '48991112233'),
(12, 'patricia.oliveira@outlook.com', '47992223344'),
(13, 'ricardo.mendes@gmail.com', '48993334455'),
(14, 'amanda.souza@hotmail.com', '47994445566'),
(15, 'felipe.castro@gmail.com', '48995556677'),
(16, 'larissa.alves@outlook.com', '47996667788'),
(17, 'marcelo.rocha@outlook.com', '48997778899'),
(18, 'marcela.fernandes@gmail.com', '47998889900'),
(19, 'thiago.lima@hotmail.com', '48990001111'),
(20, 'gisele.costa@hotmail.com', '47991112222');
-- --------------------------------------------------------
-- //INSERTS TABELA ANIMAIS.
-- --------------------------------------------------------
INSERT INTO Animais (nome, descricao, raca, idade, especie, foto, peso, sexo, situacao, porte, data_chegada, data_nascimento, cor, historia) VALUES
('Rex', 'Cachorro brincalhão e enérgico', 'Golden Retriever', 3, 'Cachorro', 'https://images.unsplash.com/photo-1633722715463-d30f4f325e24?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z29sZGVuJTIwcmV0cmlldmVyfGVufDB8fDB8fHww', 25.5, 'M', 'D', 'grande', '2023-02-15', '2022-01-01 00:00:00', 'Dourado', 'Resgatado de uma situação de abandono, adora correr e brincar com bolas.'), -- TODOS DISPONÍVEIS - D.
('Mia', 'Gata carinhosa e tranquila', 'Siamês', 2, 'Gato', 'https://www.whiskas.com.br/sites/g/files/fnmzdf2156/files/2024-10/gato-siames.jpg', 4.2, 'F', 'D', 'pequeno', '2023-05-22', '2023-03-10 00:00:00', 'Creme', 'Encontrada na rua, é muito dócil e adora um colo.'),
('Toby', 'Cachorro pequeno e agitado', 'Poodle', 5, 'Cachorro', 'https://petshopdamadre.com.br/wp-content/uploads/2022/11/123.jpg', 7.0, 'M', 'D', 'pequeno', '2023-07-10', '2020-06-01 00:00:00', 'Branco', 'Entregue por uma família que não podia mais cuidar dele, é super ativo.'),
('Frajola', 'Gato preto e branco, um pouco tímido', 'SRD', 1, 'Gato', 'https://s2-oglobo.glbimg.com/b2tcTm96n2hyJb1skX770W1VUNk=/360x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2024/I/0/ghA0AKQFCJe16f41qwxg/cleiton2-480x480.webp', 3.5, 'M', 'D', 'pequeno', '2023-09-03', '2024-02-15 00:00:00', 'Preto e Branco', 'Resgatado de um telhado, está se adaptando e se tornando mais sociável.'),
('Nina', 'Cachorra de porte médio, muito leal', 'Vira-lata', 4, 'Cachorro', 'https://www.petz.com.br/blog/wp-content/uploads/2020/01/vira-lata-caramelo-cao.jpg', 18.0, 'F', 'D', 'medio', '2023-11-28', '2021-09-20 00:00:00', 'Caramelo', 'Abandonada em uma rodovia, é muito protetora e companheira.'),
('Bart', 'Cachorro amigável, gosta de crianças', 'Beagle', 2, 'Cachorro', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxKzoAG31UFABHtIynL3rMdts-OWKrIOUfYw&s', 12.0, 'M', 'D', 'medio', '2023-12-19', '2023-05-01 00:00:00', 'Tricolor', 'Abandonado no parque, é muito sociável e adora brincar.'),
('Luna', 'Gata curiosa e independente', 'Persa', 3, 'Gato', 'https://media.istockphoto.com/id/633114008/pt/foto/persa-branco-gatos.jpg?s=612x612&w=0&k=20&c=EM4Z4azdjvrKQnonAel5aQOjIHhg5t36QulmpHMSWWQ=', 5.0, 'F', 'D', 'pequeno', '2024-01-05', '2022-08-20 00:00:00', 'Branco', 'Entregue por tutor que se mudou, é muito limpa e tranquila.'),
('Thor', 'Cachorro grande e protetor', 'Pastor Alemão', 6, 'Cachorro', 'https://diariodonordeste.verdesmares.com.br/image/contentid/policy:7.4575274:1636731203/Pastor-filhote.jpg?f=default&$p$f=3a3654e', 35.0, 'M', 'D', 'grande', '2024-03-14', '2019-03-01 00:00:00', 'Preto e Marrom', 'Resgatado de maus-tratos, precisa de um lar com espaço.'),
('Pingo', 'Cachorro pequeno e calmo', 'Pinscher', 1, 'Cachorro', 'https://media.gettyimages.com/id/1853123043/pt/foto/teenage-girl-walking-and-having-fun-with-her-dog-in-the-city.jpg?s=612x612&w=gi&k=20&c=HfbIvarLZ1ZyGYsNTr8yRrhSRv_nAReDAEpWI25lHps=', 3.0, 'M', 'D', 'pequeno', '2024-04-30', '2024-01-10 00:00:00', 'Preto', 'Encontrado na rua, é muito adaptável e gosta de companhia.'),
('Amora', 'Gata charmosa e brincalhona', 'Mestiça', 2, 'Gato', 'https://i.pinimg.com/474x/a7/05/9f/a7059f12aa902b3bf3878fa793eca7c2.jpg', 3.8, 'F', 'D', 'pequeno', '2024-06-08', '2023-06-01 00:00:00', 'Malhada', 'Vivia em uma colônia de gatos, é sociável com outros animais.'),
('Max', 'Cachorro enérgico e brincalhão', 'Labrador', 4, 'Cachorro', 'https://i.pinimg.com/474x/14/83/63/14836300237a8ea46708e9055a41e162.jpg', 30.0, 'M', 'D', 'grande', '2024-08-17', '2021-02-15 00:00:00', 'Chocolate', 'Perdido pelo tutor, adora nadar.'),
('Pandora', 'Gata de temperamento forte, mas carinhosa', 'Persa', 5, 'Gato', 'https://media.istockphoto.com/id/181861505/pt/foto/azul-gato-persa.jpg?s=612x612&w=0&k=20&c=AFiyZEhjWpfy5JfXdwcGIrhFrYJ5yowkPszA5n2Drmk=', 4.5, 'F', 'D', 'pequeno', '2024-10-21', '2020-07-22 00:00:00', 'Cinza', 'Abandonada em caixa na porta da ONG.'),
('Mel', 'Cachorra calma e muito dócil', 'Basset Hound', 7, 'Cachorro', 'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2024/12/06/1198089928-basset-hound-sentado.jpg', 15.0, 'F', 'D', 'medio', '2024-12-25', '2018-09-01 00:00:00', 'Marrom', 'Resgatada de um canil superlotado.'),
('Simba', 'Gato aventureiro e caçador', 'Maine Coon', 2, 'Gato', 'https://www.patasdacasa.com.br/sites/default/files/styles/article_detail_1200/public/noticias/2022/03/maine-coon-como-e-a-personalidade-do-gato-de-raca-gigante_1.jpg.webp?itok=B9BtyhV9', 6.0, 'M', 'D', 'grande', '2025-01-01', '2023-04-05 00:00:00', 'Laranja', 'Encontrado na floresta próximo à cidade.'),
('Bela', 'Cachorra obediente e fácil de treinar', 'Border Collie', 3, 'Cachorro', 'https://www.petz.com.br/blog/wp-content/uploads/2022/01/cruzamento-de-border-collie-com-vira-lata-topo.jpg', 20.0, 'F', 'D', 'grande', '2025-02-18', '2022-03-20 00:00:00', 'Preto e Branco', 'Doada por família que não tinha tempo para ela.'),
('Lucky', 'Cachorro sorridente, adora passear', 'SRD', 1, 'Cachorro', 'https://upload.wikimedia.org/wikipedia/commons/7/70/Serena_REFON.jpg', 10.0, 'M', 'D', 'medio', '2025-03-30', '2024-01-01 00:00:00', 'Bege', 'Resgatado de situação de rua.'),
('Safira', 'Gata elegante e observadora', 'Azul Russo', 4, 'Gato', 'https://static1.odiariodemogi.net.br/wp-content/uploads/2024/04/azul-russo-1024x683-1.jpg', 4.0, 'F', 'D', 'pequeno', '2025-05-12', '2021-11-11 00:00:00', 'Azul-cinzento', 'Achada em um condomínio.'),
('Cacau', 'Cachorro brincalhão e comilão', 'Pug', 6, 'Cachorro', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3sSRsXup43mmDBdVxGfI6nvDB64fRY92_0A&s', 8.0, 'M', 'D', 'pequeno', '2025-06-09', '2019-05-05 00:00:00', 'Marrom', 'Entregue por tutor idoso que não podia mais cuidar.'),
('Estrela', 'Gata meiga e afetuosa', 'Ragdoll', 2, 'Gato', 'https://panoramapetvet.com.br/wp-content/uploads/2023/11/Design-sem-nome-2023-11-22T141724.572.jpg', 5.5, 'F', 'D', 'medio', '2025-07-20', '2023-01-30 00:00:00', 'Branco e Creme', 'Resgatada de uma casa vazia.'),
('Zeus', 'Cachorro imponente, mas gentil', 'Doberman', 5, 'Cachorro', 'https://media.gettyimages.com/id/1443040185/pt/foto/portrait-of-a-few-months-old-pinscher.jpg?s=612x612&w=gi&k=20&c=kzSGtJFtb2MS1YCZWW0tfWOUhNzXxk_DR-qIyZV9KJc=', 40.0, 'M', 'D', 'grande', '2025-08-15', '2020-04-10 00:00:00', 'Preto', 'Recolhido pela zoonose.'),
('Holly', 'Cachorra agitada e cheia de energia', 'Jack Russell Terrier', 2, 'Cachorro', 'https://www.patasdacasa.com.br/sites/default/files/styles/article_detail_1200/public/noticias/2021/10/jack-russell-terrier-um-guia-completo-sobre-a-raca-de-cachorro-pequeno.jpg.webp?itok=IoyvCH_W', 6.5, 'F', 'D', 'pequeno', '2025-09-22', '2023-07-01 00:00:00', 'Branco e Marrom', 'Abandonada em uma caixa de papelão.'),
('Chico', 'Gato gordinho e preguiçoso', 'SRD', 8, 'Gato', 'https://i0.statig.com.br/bancodeimagens/43/la/ov/43laov5ziaybt1bia83fuziss.jpg', 7.0, 'M', 'D', 'medio', '2025-10-31', '2017-10-10 00:00:00', 'Laranja', 'Encontrado no lixo, muito assustado.'),
('Floquinho', 'Cachorro peludo e amigável', 'Lhasa Apso', 3, 'Cachorro', 'https://www.azpetshop.com.br/img/news/98/000.webp', 7.5, 'M', 'D', 'pequeno', '2025-11-11', '2022-02-28 00:00:00', 'Branco', 'Doado por mudança de cidade.'),
('Pantera', 'Gata preta misteriosa', 'SRD', 1, 'Gato', 'https://cdn.shopify.com/s/files/1/0500/8965/6473/files/cat-g4aa970acc_1920_480x480.jpg?v=1663249197', 3.0, 'F', 'D', 'pequeno', '2025-12-03', '2024-03-01 00:00:00', 'Preto', 'Resgatada de uma situação de rua grave.'),
('Duke', 'Cachorro robusto e protetor', 'Rottweiler', 4, 'Cachorro', 'https://images.pexels.com/photos/1307630/pexels-photo-1307630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 45.0, 'M', 'D', 'grande', '2025-12-31', '2021-08-01 00:00:00', 'Preto e Canela', 'Requer tutor experiente.');
-- --------------------------------------------------------
-- //INSERTS TABELA PRONTUÁRIOS.
-- --------------------------------------------------------
INSERT INTO Prontuarios (animal_id, observacoes_gerais, alergias, deficiencia, castrado) VALUES
(1, 'Saúde excelente, vacinação em dia.', NULL, NULL, 'S'),
(2, 'Leve sensibilidade gastrointestinal, dieta especial.', 'Frango', NULL, 'S'),
(3, 'Histórico de problemas de pele, sob medicação.', NULL, NULL, 'S'),
(4, 'Sem histórico de doenças, saudável.', NULL, NULL, 'N'),
(5, 'Recuperação de atropelamento, mancar leve na pata traseira.', NULL, 'Manqueira pata traseira', 'S'),
(6, 'Saudável, com todas as vacinas em dia.', NULL, NULL, 'S'),
(7, 'Pelagem exige cuidados diários.', NULL, NULL, 'S'),
(8, 'Necessita de socialização, um pouco arredio com estranhos.', NULL, NULL, 'N'),
(9, 'Saudável, mas com tendência a engordar. Controlar alimentação.', NULL, NULL, 'S'),
(10, 'Alergia a certos tipos de ração. Usar dieta especial.', NULL, 'Alergia alimentar', 'S'),
(11, 'Prontuário completo, check-up anual realizado.', NULL, NULL, 'S'),
(12, 'Exames de rotina OK. Dieta para controle de peso.', NULL, NULL, 'S'),
(13, 'Medicação para dor nas articulações.', NULL, 'Artrite', 'S'),
(14, 'Vacinação em dia. Necessita de escovação diária.', NULL, NULL, 'N'),
(15, 'Histórico de excelente saúde.', NULL, NULL, 'S'),
(16, 'Vacinação atrasada, iniciar protocolo.', NULL, NULL, 'N'),
(17, 'Alergia a certos tipos de areia. Dieta especial.', 'Areia de sílica', NULL, 'S'),
(18, 'Problemas respiratórios leves, sob controle com medicação.', NULL, 'Bracicéfalo', 'S'),
(19, 'Saudável, exames em dia.', NULL, NULL, 'S'),
(20, 'Precisou de cirurgia em pata dianteira.', NULL, 'Pata dianteira', 'S'),
(21, 'Muito ativo, precisa de bastante exercício.', NULL, NULL, 'S'),
(22, 'Histórico de obesidade, dieta e exercícios.', NULL, NULL, 'S'),
(23, 'Saudável, pelagem requer escovação regular.', NULL, NULL, 'S'),
(24, 'Um pouco traumatizada, precisa de paciência.', NULL, NULL, 'N'),
(25, 'Cão de guarda, precisa de adestramento positivo.', NULL, NULL, 'S');
-- --------------------------------------------------------
-- //INSERTS TABELA ADOÇÕES.
-- --------------------------------------------------------
INSERT INTO Adocoes (usuario_id, animal_id, data_adocao, situacao, observacoes, motivo_reprovacao) VALUES
(1, 1, '2023-06-23', 'em analise', 'Interesse em cachorro grande para família.', NULL),
(5, 2, '2023-11-26', 'aprovado', 'Casa com quintal seguro para a gata.', NULL),
(7, 3, '2024-02-10', 'concluido', 'Família com crianças e experiência com poodles.', NULL),
(1, 4, '2024-01-15', 'cancelado', 'Não atendeu aos requisitos de espaço.', 'Espaço inadequado'),
(5, 5, '2024-03-05', 'em analise', 'Interesse em cachorro de porte médio para apartamento.', NULL),
(8, 6, '2024-02-20', 'em analise', 'Família com outro cão pequeno.', NULL),
(10, 7, '2024-04-12', 'aprovado', 'Apartamento com tela de proteção.', NULL),
(8, 9, '2024-06-01', 'em analise', 'Interesse em cachorro pequeno para idoso.', NULL),
(11, 11, '2024-09-10', 'aprovado', 'Casa com grande quintal.', NULL),
(12, 13, '2025-01-15', 'concluido', 'Tutor com experiência em cães idosos.', NULL),
(14, 15, '2025-03-22', 'em analise', 'Interesse em cão para companhia.', NULL),
(15, 10, '2024-08-18', 'cancelado', 'Não pode ter gatos em casa.', 'Restrição de pets'),
(17, 16, '2025-04-05', 'aprovado', 'Jardim telado e seguro.', NULL),
(18, 18, '2025-05-30', 'em analise', 'Família com crianças pequenas.', NULL),
(20, 20, '2025-09-01', 'aprovado', 'Experiência com cães de grande porte.', NULL);
-- --------------------------------------------------------
-- //INSERTS TABELA FORNECEDORES.
-- --------------------------------------------------------
INSERT INTO Fornecedores (representante_id, nome, cnpj, ramo) VALUES
(2, 'Pet Shop Animal Feliz', '00011122233344', 'Alimentos e acessórios para pets'),
(4, 'Clínica Veterinária Vida Animal', '55566677788899', 'Serviços veterinários'),
(2, 'Dog & Cat Suprimentos', '11122233344455', 'Brinquedos e produtos de higiene'),
(12, 'FarmaVet Distribuidora', '22233344455566', 'Medicamentos veterinários'),
(15, 'ONG Amigos da Natureza', '77788899900011', 'Produtos de limpeza ecológicos'),
(18, 'Distribuidora de Ração Premium', '33344455566677', 'Rações e petiscos'),
(4, 'Consultoria de Bem-Estar Animal', '88899900011122', 'Treinamento e comportamento animal'),
(9, 'Equipamentos Veterinários Alfa', '44455566677788', 'Equipamentos cirúrgicos'),
(12, 'Petiscos Deliciosos', '99900011122233', 'Petiscos e snacks saudáveis'),
(9, 'Serviços de Tosa e Banho TopDog', '55566677788890', 'Serviços de estética animal');
-- --------------------------------------------------------
-- //INSERTS TABELA ESTOQUES.
-- --------------------------------------------------------
INSERT INTO Estoques (tipo, descricao, quantidade, valor, data_validade) VALUES
('Alimento', 'Ração para cães adultos', 100, NULL, '2025-12-31 00:00:00'),
('Medicamento', 'Vermífugo para gatos', 50, NULL, '2026-06-30 00:00:00'),
('Acessório', 'Coleiras de diversos tamanhos', 75, NULL, NULL),
('Alimento', 'Ração para gatos filhotes', 80, NULL, '2025-10-31 00:00:00'),
('Medicamento', 'Anti-inflamatório para cães', 30, NULL, '2026-03-31 00:00:00'),
('Higiene', 'Shampoo para cães', 40, NULL, '2026-11-30 00:00:00'),
('Brinquedo', 'Bolinha de borracha', 120, NULL, NULL),
('Alimento', 'Ração úmida para gatos', 90, NULL, '2025-09-15 00:00:00'),
('Medicamento', 'Antibiótico para pets', 35, NULL, '2026-01-20 00:00:00'),
('Acessório', 'Guias de passeio retráteis', 60, NULL, NULL),
('Alimento', 'Ração para cães idosos', 70, NULL, '2025-08-01 00:00:00'),
('Medicamento', 'Antipulgas para cães', 45, NULL, '2026-04-10 00:00:00'),
('Higiene', 'Condicionador para pets', 50, NULL, '2026-12-01 00:00:00'),
('Brinquedo', 'Arranhador para gatos', 25, NULL, NULL),
('Dinheiro', 'Doação para compra de ração', NULL, 100000.00, '2025-07-25 00:00:00');
-- --------------------------------------------------------
-- //INSERTS TABELA FUNCIONÁRIOS.
-- --------------------------------------------------------
INSERT INTO Funcionarios (usuario_id, salario, funcao, data_ingresso, data_saida) VALUES
(1, 3500.00, 'Gerente de Adoção', '2023-01-10 00:00:00', NULL),
(3, 2800.00, 'Veterinário', '2023-03-15 00:00:00', NULL),
(5, 2500.00, 'Auxiliar Administrativo', '2024-01-20 00:00:00', NULL),
(7, 3000.00, 'Enfermeiro Veterinário', '2023-05-01 00:00:00', NULL),
(8, 3200.00, 'Gerente de Campanhas', '2024-02-10 00:00:00', NULL),
(10, 2600.00, 'Atendente de Doações', '2023-07-22 00:00:00', NULL),
(13, 2900.00, 'Adestrador de Animais', '2024-03-01 00:00:00', NULL),
(16, 2700.00, 'Cuidador de Animais', '2023-09-10 00:00:00', NULL),
(17, 3100.00, 'Coordenador de Voluntários', '2024-04-15 00:00:00', NULL),
(20, 2750.00, 'Analista Financeiro', '2023-11-01 00:00:00', NULL);
-- --------------------------------------------------------
-- //INSERTS TABELA SOLICITAÇÕES.
-- --------------------------------------------------------
INSERT INTO Solicitacoes (funcionario_id, tipo, data_solicitacao, descricao, situacao, prioridade) VALUES
(1, 'adoção', '2023-06-15 09:30:00', 'Solicitação de adoção do animal Rex.', 'pendente', 'A'),
(7, 'consulta', '2023-08-20 14:15:00', 'Consulta de rotina para o animal Mia.', 'aprovado', 'U'),
(10, 'doação', '2023-09-05 11:00:00', 'Solicitação de ração para filhotes.', 'recusado', 'A'),
(7, 'consulta', '2023-10-12 16:45:00', 'Agendamento de vacinação para Nina.', 'pendente', 'U'),
(10, 'doação', '2023-11-18 10:20:00', 'Doação de cobertores e toalhas.', 'aprovado', 'A'),
(1, 'adoção', '2024-01-22 13:10:00', 'Solicitação de adoção do animal Bart.', 'pendente', 'A'),
(7, 'consulta', '2024-02-08 15:30:00', 'Exame de sangue para Max.', 'aprovado', 'U'),
(10, 'doação', '2024-03-14 09:45:00', 'Recebimento de doação em dinheiro.', 'recusado', 'A'),
(1, 'adoção', '2024-04-05 11:20:00', 'Documentação para adoção de Pandora.', 'pendente', 'A'),
(7, 'consulta', '2024-05-19 14:00:00', 'Sessão de adestramento para Mel.', 'aprovado', 'U');
-- --------------------------------------------------------
-- //INSERTS TABELA CAMPANHAS.
-- --------------------------------------------------------
INSERT INTO Campanhas (organizador_id, nome, descricao, data_inicio, data_termino, meta, situacao, tipo, localizacao, custo, lucro) VALUES
(1, 'Feira de Adoção de Verão', 'Evento para promover a adoção de animais.', '2025-07-20 10:00:00', '2025-07-20 17:00:00', '15 adoções', 'aguardando', 'Adoção', 'Praça Central', 500.00, 4000.00),
(10, 'Arrecadação de Ração', 'Campanha para coletar ração para animais resgatados.', '2025-06-01 09:00:00', '2025-06-30 18:00:00', '500 kg de ração', 'em ocorrência', 'Doação', 'Sede da ONG', 100.00, 0.00),
(8, 'Mutirão de Castração', 'Campanha de castração gratuita para a comunidade.', '2025-05-10 08:00:00', '2025-05-10 16:00:00', '50 animais castrados', 'realizada', 'Saúde Animal', 'Clínica Veterinária', 2000.00, 1500.00),
(8, 'Dia da Limpeza do Abrigo', 'Voluntariado para limpeza e organização do abrigo.', '2025-07-05 09:00:00', '2025-07-05 13:00:00', 'Abrigo limpo', 'aguardando', 'Voluntariado', 'Sede da ONG', 50.00, 0.00),
(1, 'Feira de Adoção de Inverno', 'Adoção de animais em ambiente coberto.', '2025-08-10 10:00:00', '2025-08-10 17:00:00', '10 adoções', 'aguardando', 'Adoção', 'Centro de Eventos', 600.00, 0.00),
(8, 'Campanha de Vacinação Gratuita', 'Oferecimento de vacinas essenciais.', '2025-09-01 09:00:00', '2025-09-05 17:00:00', '200 animais vacinados', 'aguardando', 'Saúde Animal', 'Praça da Matriz', 1500.00, 3000.00),
(8, 'Mutirão de Banho e Tosa', 'Serviço gratuito para animais adotados.', '2025-10-12 09:00:00', '2025-10-12 16:00:00', '30 animais banhados', 'aguardando', 'Bem-Estar Animal', 'Sede da ONG', 300.00, 0.00),
(8, 'Caminhada Solidária', 'Evento para arrecadar fundos para a ONG.', '2025-11-15 08:00:00', '2025-11-15 12:00:00', 'R$ 5.000', 'aguardando', 'Arrecadação de Fundos', 'Parque Municipal', 200.00, 0.00),
(8, 'Palestras de Conscientização', 'Série de palestras sobre posse responsável.', '2025-12-01 19:00:00', '2025-12-05 21:00:00', '100 participantes', 'aguardando', 'Educação', 'Centro Comunitário', 100.00, 0.00),
(10, 'Campanha de Doação de Sangue Animal', 'Coleta de sangue para emergências veterinárias.', '2026-01-20 09:00:00', '2026-01-20 17:00:00', '20 doações', 'aguardando', 'Saúde Animal', 'Clínica Veterinária', 400.00, 800.00);
-- --------------------------------------------------------
-- //INSERTS TABELA DOAÇÕES.
-- --------------------------------------------------------
INSERT INTO Doacoes (doador_id, valor, quantidade, tipo, descricao, situacao) VALUES
(2, 100.00, NULL, 'Financeira', 'Doação para despesas gerais da ONG.', 'confirmada'),
(4, NULL, 5, 'Material', 'Sacos de ração para cães.', 'confirmada'),
(9, 50.00, NULL, 'Financeira', 'Contribuição mensal.', 'pendente'),
(12, NULL, 2, 'Material', 'Caixas de areia para gatos.', 'confirmada'),
(15, 200.00, NULL, 'Financeira', 'Doação para tratamento de animais.', 'confirmada'),
(18, NULL, 10, 'Material', 'Brinquedos para filhotes.', 'pendente'),
(2, 75.00, NULL, 'Financeira', 'Doação avulsa.', 'confirmada'),
(9, NULL, 3, 'Material', 'Coleiras e guias.', 'confirmada'),
(12, 120.00, NULL, 'Financeira', 'Doação para campanha de castração.', 'confirmada'),
(18, NULL, 1, 'Material', 'Cama para cães de grande porte.', 'pendente');
-- --------------------------------------------------------
-- //INSERTS TABELA VOLUNTÁRIOS.
-- --------------------------------------------------------
INSERT INTO Voluntarios (usuario_id, situacao, disponibilidade) VALUES
(3, 'Ativo', 'Segundas e quartas-feiras à tarde'),
(6, 'Ativo', 'Finais de semana'),
(10, 'Pendente', 'Terças e quintas-feiras de manhã'),
(13, 'Ativo', 'Sábados de manhã'),
(16, 'Inativo', 'Sem disponibilidade'),
(19, 'Ativo', 'Quintas-feiras à noite'),
(15, 'Ativo', 'Domingos o dia todo'),
(1, 'Pendente', 'Aguardando treinamento'),
(2, 'Ativo', 'Segundas e sextas-feiras de manhã'),
(4, 'Ativo', 'Terças e quintas-feiras à tarde'),
(9, 'Ativo', 'Finais de semana alternados'),
(5, 'Ativo', 'Quartas-feiras à noite'),
(7, 'Pendente', 'Aguardando confirmação'),
(8, 'Ativo', 'Sextas-feiras à tarde'),
(11, 'Ativo', 'Segundas e quintas-feiras de manhã');
-- --------------------------------------------------------
-- //INSERTS TABELA TRATAMENTOS.
-- ----------------------------------------------------------
INSERT INTO Tratamentos (animal_id, clinica, tipo, descricao, data_realizacao, custo, observacoes) VALUES
(1, 'Clínica Veterinária Vida Animal', 'Vacinação', 'Primeira dose da vacina V8.', '2025-06-05 10:00:00', 80.00, 'Sem reações adversas.'),
(2, 'Pet Saúde', 'Consulta', 'Revisão de dieta e peso.', '2025-06-08 14:30:00', 120.00, 'Peso ideal, manter dieta.'),
(5, 'Clínica Veterinária Vida Animal', 'Fisioterapia', 'Sessões de fisioterapia para recuperação da pata.', '2025-06-10 11:00:00', 150.00, 'Primeira sessão, animal cooperativo.'),
(6, 'Clínica Veterinária Vida Animal', 'Castração', 'Procedimento de castração.', '2025-05-20 09:00:00', 300.00, 'Recuperação pós-cirúrgica excelente.'),
(7, 'Pet Saúde', 'Vacinação', 'Vacina anual.', '2025-06-01 11:00:00', 90.00, 'Animal tranquilo durante o procedimento.'),
(11, 'Clínica Veterinária Vida Animal', 'Consulta', 'Check-up geral.', '2025-07-01 10:00:00', 100.00, 'Tudo ok.'),
(12, 'Pet Saúde', 'Tratamento', 'Controle de diabetes.', '2025-07-05 15:00:00', 250.00, 'Iniciar insulina.'),
(13, 'Clínica Veterinária Vida Animal', 'Fisioterapia', 'Sessões para artrite.', '2025-07-08 09:30:00', 180.00, 'Melhora progressiva.'),
(14, 'Pet Saúde', 'Vacinação', 'Reforço de vacina.', '2025-07-10 14:00:00', 70.00, 'Sem intercorrências.'),
(15, 'Clínica Veterinária Vida Animal', 'Castração', 'Procedimento de castração.', '2025-07-12 08:00:00', 300.00, 'Pós-operatório normal.');
-- --------------------------------------------------------
-- //INSERTS TABELA AGENDAMENTOS.
-- --------------------------------------------------------
INSERT INTO Agendamentos (funcionario_id, animal_id, tipo, data_agendamento, observacoes) VALUES
(2, 1, 'Consulta Veterinária', '2025-06-15 10:00:00', 'Consulta de rotina para Rex.'),
(2, 2, 'Vacinação', '2025-06-20 14:00:00', 'Reforço de vacina para Mia.'),
(1, 3, 'Visita de Adoção', '2025-06-12 16:00:00', 'Visita da família interessada em Toby.'),
(2, 8, 'Consulta Veterinária', '2025-06-18 10:30:00', 'Avaliação inicial para Thor.'),
(1, 10, 'Visita de Adoção', '2025-06-14 15:00:00', 'Visita da família interessada em Amora.'),
(4, 11, 'Exame de Rotina', '2025-07-02 09:00:00', 'Exame de sangue e urina para Max.'),
(5, NULL, 'Reunião de Campanha', '2025-07-03 11:00:00', 'Planejamento da Feira de Adoção de Inverno.'),
(6, NULL, 'Coleta de Doação', '2025-07-04 14:00:00', 'Recolher ração na casa de Ana Silva.'),
(7, 13, 'Sessão de Adestramento', '2025-07-06 10:00:00', 'Primeira sessão com Mel.'),
(8, 14, 'Banho e Tosa', '2025-07-07 09:00:00', 'Banho de Simba antes da adoção.');
-- --------------------------------------------------------
-- //INSERTS TABELA DOENÇAS.
-- --------------------------------------------------------
INSERT INTO Doencas(cid, nome) VALUES
('A01.0', 'Salmonelose'),
('B02.9', 'Cinomose'),
('J10.0', 'Gripe Canina'),
('K29.7', 'Gastrite Crônica'),
('L03.1', 'Dermatite Alérgica'),
('H10.1', 'Conjuntivite'),
('E10.9', 'Diabetes Mellitus'),
('M15.0', 'Artrite'),
('L20.8', 'Dermatite Atópica'),
('I42.0', 'Cardiomiopatia Dilatada'),
('J45.9', 'Asma Felina'),
('K70.0', 'Hepatite Canina'),
('B08.4', 'Micose'),
('N17.9', 'Insuficiência Renal Aguda'),
('G80.9', 'Epilepsia');
-- --------------------------------------------------------
-- //INSERTS INTERMEDIÁRIA DOENÇAS X PRONTUÁRIOS.
-- --------------------------------------------------------
INSERT INTO Doenca_Prontuario (doenca_id, prontuario_id) VALUES
(4, 2),
(5, 3),
(6, 8), 
(7, 10),
(8, 11),
(9, 15), 
(10, 18), 
(13, 11), 
(15, 21),
(1, 22);
-- --------------------------------------------------------
-- //INSERTS TABELA VACINAS.
-- --------------------------------------------------------
INSERT INTO Vacinas(nome, codigo) VALUES
('V8 Polivalente', 'VAC-V8'),
('Anti-rábica', 'VAC-AR'),
('Felina Quadrupla', 'VAC-FQ'),
('V10 Polivalente', 'VAC-V10'),
('Gripe Canina', 'VAC-GRIPE-C'),
('Giardíase', 'VAC-GIARD'),
('Leishmaniose', 'VAC-LEISH'),
('Cinomose', 'VAC-CINO'),
('Parvovirose', 'VAC-PARVO'),
('Coronavirose', 'VAC-CORONA'),
('Herpesvírus Canino', 'VAC-HERPES'),
('Leucemia Felina', 'VAC-LEU-F');
-- --------------------------------------------------------
-- //INTERMEDIARIA VACINAS ANIMAL.
-- --------------------------------------------------------
INSERT INTO Animal_Vacina(animal_id, vacina_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1),
(5, 1),
(5, 2),
(6, 1),
(7, 3),
(8, 4),
(9, 1); 
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //SELECTS.
-- --------------------------------------------------------
-- --------------------------------------------------------


-- --------------------------------------------------------
-- //SELECT 1: UTILIZADO PARA LISTAR TODOS ENDEREÇOS, CONTATOS E INFORMAÇÕES BÁSICAS RELACIONADAS A UM USUÁRIO.
-- --------------------------------------------------------
SELECT Usuarios.id, Usuarios.nome, Usuarios.cpf, Usuarios.genero, Usuarios.tipo, Enderecos.cep, Enderecos.rua, 
Enderecos.cidade, Enderecos.bairro, Enderecos.estado, Enderecos.numero, Enderecos.tipo, Contatos.email, Contatos.celular 
FROM
    Usuarios
LEFT JOIN
	Enderecos
    ON Usuarios.id = Enderecos.usuario_id
LEFT JOIN
	Contatos
	ON Usuarios.id = Contatos.usuario_id;
-- --------------------------------------------------------
-- //SELECT 2: UTILIZADO PARA LISTAR TODOS OS ANIMAIS EM SITUÇÃO DISPONÍVEL PARA ADOÇÃO (COM ALGUMAS INFOS).
-- --------------------------------------------------------
SELECT
	Animais.id, Animais.nome, Animais.raca, Animais.sexo, Animais.especie, Animais.situacao, Prontuarios.observacoes_gerais, 
COUNT(DISTINCT Animal_Vacina.vacina_id) AS n_vacinas, IFNULL(GROUP_CONCAT(DISTINCT Doencas.nome SEPARATOR ', '), 'Não Possui') AS Doencas, 
IFNULL(Prontuarios.deficiencia, 'Não Possui') AS deficiencia, IFNULL(Prontuarios.alergias, 'Não Possui') AS alergias, 
	CASE 
    WHEN Prontuarios.castrado = 'S' THEN 'Sim' 
    WHEN Prontuarios.castrado = 'N' THEN 'Não'
    ELSE 'Não Informado'
    END AS Castrado
FROM
    Animais
LEFT JOIN
	Prontuarios
    ON Animais.id = Prontuarios.animal_id
LEFT JOIN
	Animal_Vacina
	ON Animais.id = Animal_Vacina.animal_id
LEFT JOIN
    Doenca_Prontuario
    ON Prontuarios.id = Doenca_Prontuario.prontuario_id
LEFT JOIN
    Doencas
    ON Doenca_Prontuario.doenca_id = Doencas.id
WHERE
    Animais.situacao = 'D'
GROUP BY
	Animais.id, Animais.nome, Animais.raca, Animais.sexo, Animais.especie, Animais.situacao, Prontuarios.observacoes_gerais, 
Prontuarios.deficiencia, Prontuarios.alergias, Prontuarios.castrado
ORDER BY
	Animais.id;
-- --------------------------------------------------------
-- //SELECT 3: UTILIZADO PARA LISTAR TODOS OS ANIMAIS FILTRADOS POR ESPÉCIE, PORTE E COR.
-- --------------------------------------------------------
-- //ESPÉCIE.
-- --------------------------------------------------------
SELECT
	especie, COUNT(*) AS quantidade
FROM 
	Animais
GROUP BY 
	especie
ORDER BY 
	quantidade DESC;
-- --------------------------------------------------------
-- //PORTE.
-- --------------------------------------------------------
SELECT 
	porte, COUNT(*) AS quantidade
FROM 
	Animais
GROUP BY 
	porte
ORDER BY 
    CASE porte
        WHEN 'pequeno' THEN 1
        WHEN 'medio' THEN 2
        WHEN 'grande' THEN 3
    END;
-- --------------------------------------------------------
-- //COR.
-- --------------------------------------------------------
SELECT 
	cor, COUNT(*) AS quantidade
FROM 
	Animais
GROUP BY 
	cor
ORDER BY 
	quantidade DESC;
-- --------------------------------------------------------
-- Usando OVER(PARTITION BY).
-- --------------------------------------------------------
SELECT 
    distinct
	cor, COUNT(*) over(partition by cor) AS quantidade
FROM 
	Animais
ORDER BY 
	quantidade DESC;
-- --------------------------------------------------------
-- //SELECT 4: UTILIZADO PARA CONSULTAR HISTÓRICO DE ADOÇÕES.
-- --------------------------------------------------------
SELECT 
Adocoes.id AS id_adocao, Usuarios.nome AS adotante, Animais.nome AS nome_animal, 
Adocoes.data_adocao, Adocoes.situacao AS situacao_adocao, Adocoes.observacoes, Adocoes.motivo_reprovacao, Animais.raca AS raca_animal, 
Animais.idade AS idade_animal, Animais.especie AS especie_animal
FROM  
    Adocoes
JOIN 
    Usuarios ON Adocoes.usuario_id = Usuarios.id
JOIN 
    Animais ON Adocoes.animal_id = Animais.id
ORDER BY 
    Adocoes.data_adocao ASC;
-- --------------------------------------------------------
-- //SELECT 5: UTILIZADO PARA CONSULTAR INFORMAÇÕES REFERENTES A UMA CAMPANHA.
-- --------------------------------------------------------
SELECT 
    Campanhas.id, Campanhas.nome, Usuarios.id AS id_organizador, Usuarios.nome AS nome_organizador, Campanhas.tipo, Campanhas.custo,
    IF(Campanhas.tipo IN ('Arrecadação de Fundos', 'Doação'), Campanhas.lucro, NULL) AS total_arrecadado,
    IF(Campanhas.tipo IN ('Arrecadação de Fundos', 'Doação'), Campanhas.lucro - Campanhas.custo, NULL) AS lucro_liquido,
    IF(Campanhas.tipo IN ('Adoção', 'Saúde Animal', 'Voluntariado', 'Bem-Estar Animal', 'Educação'),
       'Objetivo Não Financeiro',
       CONCAT((Campanhas.lucro / NULLIF(Campanhas.custo, 0)) * 100, '%')) AS percentual
FROM 
    Campanhas
LEFT JOIN 
    Usuarios 
    ON Campanhas.organizador_id = Usuarios.id
ORDER BY 
    Campanhas.id;
-- --------------------------------------------------------
-- //SELECT 6: UTILIZADO PARA CONSULTAR NÚMERO DE ADOÇÕES POR MÊS/ANO.
-- --------------------------------------------------------
SELECT 
	COUNT(*) AS total_adocoes, YEAR(Adocoes.data_adocao) AS ano, MONTH(Adocoes.data_adocao) AS mes, 
GROUP_CONCAT(DISTINCT Animais.nome SEPARATOR ', ') AS nome_animal, GROUP_CONCAT(DISTINCT Animais.especie SEPARATOR ', ') AS especie, 
GROUP_CONCAT(DISTINCT Animais.porte SEPARATOR ', ') AS porte
FROM 
    Adocoes
JOIN 
    Animais
    ON Adocoes.animal_id = Animais.id
WHERE 
    Adocoes.situacao = 'concluido'
GROUP BY 
    ano, mes
ORDER BY 
    ano DESC;
-- --------------------------------------------------------
-- //SELECT 7: UTILIZADO PARA CONSULTAR ANIMAIS QUE PERMANECEM MAIS TEMPO EM ADOÇÃO.
-- --------------------------------------------------------
SELECT 
    id, nome, especie, raca, data_chegada,
    DATEDIFF(NOW(), data_chegada) AS dias_esperando_adocao
FROM 
    Animais
WHERE 
    situacao = 'D'
    AND data_chegada <= NOW()
ORDER BY 
    dias_esperando_adocao DESC;
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //PROCEDURES.
-- --------------------------------------------------------
-- --------------------------------------------------------


-- --------------------------------------------------------
-- //PROCEDURE 1: INSERIR PARÂMETRO DEFAULT NA TABELA ANIMAIS.
-- --------------------------------------------------------
DELIMITER $$
-- Insere inicialmente só a espécie, pensando na interface do banco
CREATE PROCEDURE insertDefaultAnimal(IN vEspecie VARCHAR(255), OUT novo_id INT)
BEGIN
    INSERT INTO Animais(especie) VALUES (vEspecie);
    SET novo_id = LAST_INSERT_ID();
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 2: INSERIR PARÂMETROS OBRIGATÓRIOS NA TABELA ANIMAIS.
-- --------------------------------------------------------
DELIMITER $$ 
-- nome, raca, idade, peso, sexo, porte, data_chegada, cor
CREATE PROCEDURE atualizarObrigatoriosAnimal
(
	IN vId INT,
	IN vNome VARCHAR(255),
    IN vRaca VARCHAR(255),
    IN vIdade INT,
    IN vPeso DOUBLE,
    IN vSexo CHAR(1),
    IN vPorte ENUM ('grande', 'medio', 'pequeno'),
    IN vData_chegada DATETIME,
    IN vCor VARCHAR(255)
)
BEGIN
		UPDATE Animais SET 
        nome = vNome,
        raca = vRaca,
        idade = vIdade,
        peso = vPeso,
        sexo = vSexo,
        porte = vPorte,
        data_chegada = vData_chegada,
        cor = vCor 
        WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 3: INSERIR PARÂMETROS OPCIONAIS NA TABELA ANIMAIS.
-- --------------------------------------------------------
DELIMITER $$ 
-- descricao, foto, data_nascimento, historia
CREATE PROCEDURE atualizarOpcionaisAnimal
(
	IN vFoto VARCHAR(1024),
	IN vDescricao VARCHAR(255),
    IN vData_nascimento DATETIME,
    IN vHistoria VARCHAR(512)
)
BEGIN
	IF vFoto IS NOT NULL THEN
		UPDATE Animal SET foto = vFoto;
    END IF;
    
    IF vDescricao IS NOT NULL THEN
		UPDATE Animal SET descricao = vDescricao;
    END IF;
    
    IF vData_nascimento IS NOT NULL THEN
		UPDATE Animal SET data_nascimento = vData_nascimento;
    END IF;
    
    IF vHistoria IS NOT NULL THEN
		UPDATE Animal SET historia = vHistoria;
    END IF;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 4: CANCELAR INSERÇÃO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE cancelarInsercao(IN vId INT)
BEGIN
	DELETE FROM Animais WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //TESTES INSERT ANIMAL.
-- --------------------------------------------------------
CALL insertDefaultAnimal('Cachorro', @id);
CALL atualizarObrigatoriosAnimal(@id, 'morango', 'viralata', 5, 5.4, 'F', 'medio', NOW(), 'vermelho');
SELECT * FROM Animais;
DELETE FROM Animais WHERE id = @id;
-- --------------------------------------------------------
-- //PROCEDURE 5: ATUALIZAR FOTO DE UM ANIMAL.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE atualizarFotoAnimal(IN vId INT, IN vFoto VARCHAR(1024))
BEGIN
	UPDATE Animais SET foto = vFoto WHERE id = vId;
END $$
DELIMITER ;
CALL atualizarFotoAnimal(2, 'foto');
SELECT id, foto FROM Animais WHERE id = 2;
-- --------------------------------------------------------
-- //PROCEDURE 6: ATUALIZAR DESCRIÇÃO DE UM ANIMAL.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE atualizarDescricaoAnimal(IN vId INT, IN vDescricao VARCHAR(255))
BEGIN
	UPDATE Animais SET descricao = vDescricao WHERE id = vId;
END $$
DELIMITER ;
CALL atualizarDescricaoAnimal(2, 'Teste call');
-- --------------------------------------------------------
-- //PROCEDURE 7: ATUALIZAR DATA DE NASCIMENTO DE UM ANIMAL.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE atualizarDataNascimentoAnimal(IN vId INT, IN vData_nascimento DATETIME)
BEGIN
	UPDATE Animais SET data_nascimento = vData_nascimento WHERE id = vId;
END $$
DELIMITER ;
CALL atualizarDataNascimentoAnimal(2, NOW());
-- --------------------------------------------------------
-- //PROCEDURE 8: ATUALIZAR HISTORIA DE UM ANIMAL.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE atualizarHistoriaAnimal(IN vId INT, IN vHistoria VARCHAR(512))
BEGIN
	UPDATE Animais SET historia = vHistoria WHERE id = vId;
END $$
DELIMITER ;
CALL atualizarHistoriaAnimal(2, 'Teste call');
-- --------------------------------------------------------
-- //PROCEDURE 9: INSERIR USUARIO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insertUsuario
(
	IN vNome VARCHAR(255), 
    IN vCPF CHAR(11), 
    IN vData_nascimento DATE, 
    IN vGenero ENUM('Homem', 'Mulher', 'Não informar', 'Não binário'),
	IN vTipo CHAR(1),
    IN vSenha VARCHAR(128)
)
BEGIN
    INSERT INTO Usuarios(nome, cpf, data_nascimento, genero, tipo, data_cadastro, senha) VALUES
		(vNome, vCPF, vData_nascimento, vGenero, vTipo, NOW(), vSenha);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 10: ATRIBUIR ENDEREÇO USUARIO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE atribuirEndereco
(
		IN vId INT,
		IN vCEP CHAR(8),
        IN vRua VARCHAR(255),
        IN vCidade VARCHAR(255),
        IN vBairro VARCHAR(255),
        IN vEstado VARCHAR(255),
        IN vNumero VARCHAR(255),
        IN vPais VARCHAR(255),
        IN vTipo ENUM('fixo', 'temporário', 'empresarial') 
)
BEGIN
    INSERT INTO Enderecos(usuario_id, cep, rua, cidade, bairro, estado, numero, pais, tipo) 
    VALUES (vId, vCEP, vRua, vCidade, vBairro, vEstado, vNumero, vPais, vTipo);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 11: ATUALIZAR ENDERECO DE UM USUARIO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE atualizarEndereco
(
		IN vId INT,
		IN vCEP CHAR(8),
        IN vRua VARCHAR(255),
        IN vCidade VARCHAR(255),
        IN vBairro VARCHAR(255),
        IN vEstado VARCHAR(255),
        IN vNumero VARCHAR(255),
        IN vPais VARCHAR(255),
        IN vTipo ENUM('fixo', 'temporário', 'empresarial') 
)
BEGIN
	UPDATE Enderecos 
    SET 
		cep = vCEP, 
		rua = vRua, 
        cidade = vCidade, 
        bairro = vBairro, 
        estado = vEstado, 
        numero = vNumero, 
        pais = vPais, 
        tipo = vTipo 
    WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 12: ATRIBUIR CONTATO USUARIO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE atribuirContato
(
		IN vId INT,
        IN vEmail VARCHAR(255),
        IN vCelular CHAR(11)
)
BEGIN
    INSERT INTO Contatos(usuario_id, email, celular) 
	VALUES (vId, vEmail, vCelular);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 13: ATUALIZAR CONTATO DE UM USUARIO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE atualizarContato
(
		IN vId INT,
		IN vEmail VARCHAR(255),
        IN vCelular VARCHAR(255)
)
BEGIN
	IF vEmail IS NOT NULL THEN
		UPDATE Contatos SET email = vEmail WHERE id = vId;
	END IF;
    
	IF vCelular IS NOT NULL THEN
		UPDATE Contatos SET celular = vCelular WHERE id = vId;
	END IF;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 14: INSERIR VACINA.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insertVacina
(
		IN vNome VARCHAR(255),
        IN vCodigo VARCHAR(255)
)
BEGIN
    INSERT INTO Vacinas(nome, codigo) VALUES (vNome, vCodigo);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 15: INSERIR PRONTUARIO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insertProntuario
(
		IN vId INT,
        IN vObservacoes_gerais VARCHAR(255),
        IN vAlergias VARCHAR(255),
        IN vDeficiencia VARCHAR(255),
        IN vCastrado CHAR(1),
        IN vDoenca INT
)
BEGIN
    INSERT INTO Prontuarios(animal_id, observacoes_gerais, alergias, deficiencia, castrado) 
    VALUES (vId, vObservacoes_gerais, vAlergias, vDeficiencia, vCastrado);
    
    SET @idProntuarioNovo = LAST_INSERT_ID();
    
    INSERT INTO Doenca_Prontuario (prontuario_id, doenca_id)
    VALUES (@idProntuarioNovo, vDoencas);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 16: INSERIR DOENCAS.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insertDoencas
(
        IN vCid VARCHAR(255),
        IN vNome VARCHAR(255)
)
BEGIN
    INSERT INTO Doencas(cid, nome) 
    VALUES (vCid, vNome);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 17: INSERIR CAMPANHAS.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insertCampanhas
(
        IN vId INT,
        IN vNome VARCHAR(255),
        IN vDescricao VARCHAR(255),
        IN vData_inicio DATETIME,
        IN vData_termino DATETIME,
        IN vMeta VARCHAR(255),
        IN vSituacao ENUM('realizada', 'cancelada', 'em ocorrência', 'aguardando'),
        IN vTipo VARCHAR(255),
        IN vLocalizacao VARCHAR(255),
        IN vCusto DECIMAL(10,2),
        IN vLucro DECIMAL(10,2)
)
BEGIN
    INSERT INTO Campanhas
	(
		organizador_id, 
		nome, 
        descricao, 
        data_inicio, 
        data_termino,
        meta,
        situacao,
        tipo,
        localizacao,
        custo,
        lucro
	) 
    VALUES 
    (
		vId, 
        vNome,
        vDescricao,
        vData_inicio,
        vData_termino,
        vMeta,
        vSituacao,
        vTipo,
        vLocalizacao,
        vCusto,
        vLucro
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 18: INSERIR ADOCOES.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insertAdocao
(
        IN vIdUsuario INT,
        IN vIdAnimal INT,
        IN vData_adocao DATETIME,
        IN vObservacoes VARCHAR(255)
)
BEGIN
    INSERT INTO Campanhas
	(
		usuario_id, 
		animal_id, 
        data_adocao, 
        situacao, 
        observacoes
	) 
    VALUES 
    (
		vIdUsuario,
        vIdAnimal,
        vData_adocao,
        'em analise',
        vObservacoes
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 19: REPROVAR ADOCAO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE reprovarAdocao
(
        IN vIdUsuario INT,
        IN vIdAnimal INT,
        IN vMotivo VARCHAR(255)
)
BEGIN
	UPDATE Adocoes
    SET motivo_reprovacao = vMotivo,
		situacao = 'cancelado' 
	WHERE usuario_id = vIdUsuario AND animal_id = vIdAnimal;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 20: APROVAR ADOCAO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE aprovarAdocao
(
        IN vIdUsuario INT,
        IN vIdAnimal INT
)
BEGIN
	UPDATE Adocoes
    SET situacao = 'aprovado' 
	WHERE usuario_id = vIdUsuario AND animal_id = vIdAnimal;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 21: CONCLUIR ADOCAO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE concluirAdocao
(
        IN vIdUsuario INT,
        IN vIdAnimal INT
)
BEGIN
	UPDATE Adocoes
    SET situacao = 'concluido' 
	WHERE usuario_id = vIdUsuario AND animal_id = vIdAnimal;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 22: INSERIR AGENDAMENTO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insertAgendamento
(
        IN vIdFuncionario INT,
        IN vIdAnimal INT,
        IN vTipo VARCHAR(255),
        IN vData_agendamento DATETIME,
        IN vObservacoes VARCHAR(255)
)
BEGIN
    INSERT INTO Agendamentos
	(
		funcionario_id, 
		animal_id, 
        tipo, 
        data_agendamento, 
        observacoes
	) 
    VALUES 
    (
		vIdFuncionario,
        vIdAnimal,
        vTipo,
        vData_agendamento,
        vObservacoes
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 23: INSERIR FUNCIONARIOS.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE insertFuncionario
(
        IN vIdUsuario INT,
        IN vSalario DECIMAL(10, 2),
        IN vFuncao VARCHAR(255),
        IN vData_ingresso DATETIME,
        IN vData_saida DATETIME
)
BEGIN
    INSERT INTO Funcionarios
	(
		usuario_id, 
		salario, 
        funcao, 
        data_ingresso, 
        data_saida
	) 
    VALUES 
    (
		vIdUsuario,
        vSalario,
        vFuncao,
        vData_ingresso,
        vData_saida
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 24: INSERIR FORNECEDORES.
-- --------------------------------------------------------  
DELIMITER $$
CREATE PROCEDURE insertFornecedor
(
        IN vIdRepresentante INT,
        IN vNome VARCHAR(255),
        IN vCNPJ CHAR(14),
        IN vRamo VARCHAR(255)
)
BEGIN
    INSERT INTO Fornecedores
	(
		representante_id, 
		nome, 
        cnpj, 
        ramo
	) 
    VALUES 
    (
		vIdRepresentante,
        vNome,
        vCNPJ,
        vRamo
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 25: ADICIONAR ESTOQUE.
-- --------------------------------------------------------  
DELIMITER $$
CREATE PROCEDURE adicionarEstoque
(
        IN vTipo VARCHAR(255),
        IN vDescricao VARCHAR(255),
        IN vQuantidade INT,
        IN vValor DECIMAL(10, 2),
        IN vData_validade DATETIME
)
BEGIN
    INSERT INTO Estoques
	(
		tipo, 
		descricao, 
        quantidade, 
        valor,
        data_validade
	) 
    VALUES 
    (
		vTipo,
        vDescricao,
        vQuantidade,
        vValor,
        vData_validade
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 26: INSERIR SOLICITACOES.
-- --------------------------------------------------------  
DELIMITER $$
CREATE PROCEDURE inserirSolicitacao
(
        IN vIdFuncionario INT,
        IN vTipo ENUM('adoção', 'doação', 'consulta'),
        IN VDescricao VARCHAR(255),
        IN vPrioridade CHAR(1)
)
BEGIN
    INSERT INTO Solicitacoes
	(
		funcionario_id, 
		tipo, 
        data_solicitacao,
        descricao, 
        situacao,
        prioridade
	) 
    VALUES 
    (
		vIdFuncionario,
        vTipo,
        NOW(),
        VDescricao,
        'pendente',
        vPrioridade
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 27: APROVAR SOLICITACOES.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE aprovarSolicitacao
(
        IN vId INT
)
BEGIN
	UPDATE Solicitacoes
    SET situacao = 'aprovado' 
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 28: REPROVAR SOLICITACOES.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE reprovarSolicitacao
(
        IN vId INT
)
BEGIN
	UPDATE Solicitacoes
    SET situacao = 'recusado' 
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 29: INSERT TRATAMENTOS.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE inserirTratamento
(
        IN vIdAnimal INT,
        IN vClinica VARCHAR(255),
        IN VTipo VARCHAR(255),
        IN vDescricao VARCHAR(255),
        IN vData_realizacao DATETIME,
        IN vCusto DECIMAL(10, 2),
        IN vObservacoes VARCHAR(255)
)
BEGIN
    INSERT INTO Tratamentos
	(
		animal_id, 
		clinica, 
        tipo,
        descricao, 
        data_realizacao,
        custo,
        observacoes
	) 
    VALUES 
    (
		vIdAnimal,
        vClinica,
        VTipo,
        VDescricao,
        vData_realizacao,
        vCusto,
        vObservacoes
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 30: ATRIBUIR VACINAS.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE atribuirVacina
(
        IN vIdAnimal INT,
        IN vIdVacina INT
)
BEGIN
    INSERT INTO Animal_vacina
	(
		animal_id, 
		vacina_id
	) 
    VALUES 
    (
		vIdAnimal,
        vIdVacina
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 31: PROMOVER USUÁRIO PARA FUNCIONÁRIO.
-- --------------------------------------------------------
DELIMITER $
CREATE PROCEDURE sp_PromoverParaFuncionario(
    IN p_usuario_id INT,
    IN p_salario DECIMAL(10, 2),
    IN p_funcao VARCHAR(255)
)
BEGIN
    -- Verifica se o usuário já não é um funcionário
    IF NOT EXISTS (SELECT 1 FROM Funcionarios WHERE usuario_id = p_usuario_id) THEN
        INSERT INTO Funcionarios (usuario_id, salario, funcao, data_ingresso)
        VALUES (p_usuario_id, p_salario, p_funcao, NOW());

        -- Atualiza o tipo do usuário para 'F' (Funcionário)
        UPDATE Usuarios SET tipo = 'F' WHERE id = p_usuario_id;
    END IF;
END$
DELIMITER ;
-- --------------------------------------------------------
-- //TESTE.
-- --------------------------------------------------------
call sp_PromoverParaFuncionario(2, 1000.00, "Auxiliar noturno");
-- --------------------------------------------------------
-- //PROCEDURE 32: INSERIR VOLUNTÁRIOS.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE inserirVoluntario
(
        IN vId INT,
        IN vSituacao VARCHAR(255),
        IN vDisponibilidade VARCHAR(512)
)
BEGIN
    INSERT INTO Voluntarios
	(
		usuario_id, 
		situacao,
        disponibilidade
	) 
    VALUES 
    (
		vId,
        vSituacao,
        vDisponibilidade
	);
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 33: APAGAR USUARIO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE deletarUsuario
(
        IN vId INT
)
BEGIN
    DELETE FROM Usuarios
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 34: APAGAR VOLUNTARIO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE deletarVoluntario
(
        IN vId INT
)
BEGIN
    DELETE FROM Voluntarios
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 35: APAGAR FORNECEDOR.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE deletarFornecedor
(
        IN vId INT
)
BEGIN
    DELETE FROM Fornecedores
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 36: APAGAR ANIMAL.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE deletarAnimal
(
        IN vId INT
)
BEGIN
    DELETE FROM Animais
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 37: APAGAR CAMPANHA.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE deletarCampanha
(
        IN vId INT
)
BEGIN
    DELETE FROM Campanhas
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 38: APAGAR ESTOQUE.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE deletarEstoque
(
        IN vId INT
)
BEGIN
    DELETE FROM Estoques
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 39: APAGAR AGENDAMENTO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE deletarAgendamento
(
        IN vId INT
)
BEGIN
    DELETE FROM Agendamentos
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------
-- //PROCEDURE 40: APAGAR SOLICITACAO.
-- --------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE deletarSolicitacao
(
        IN vId INT
)
BEGIN
    DELETE FROM Solicitacoes
	WHERE id = vId;
END $$
DELIMITER ;
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //FUNCTIONS.
-- --------------------------------------------------------
-- --------------------------------------------------------


-- --------------------------------------------------------
-- //FUNCTION 1: CALCULAR OS CUSTOS QUE UMA EMPRESA TEVE COM OS FUNCIONÁRIOS A PARTIR DE DETERMINADO MÊS E ANO.
-- --------------------------------------------------------
-- Calcular os custos que uma empresa teve com os funcionários a partir de determinado mês
-- Possibilita escolher o percentual de encargo (curso além do salário), a partir de um ano e mês
DELIMITER $
CREATE FUNCTION f_CustoMensalFolhaPagamento(
    p_ano INT,
    p_mes INT,
    p_percentual_encargos DECIMAL(5, 2)
)
    RETURNS DECIMAL(15, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE v_custo_total DECIMAL(15, 2);
    DECLARE v_data_inicio_mes DATE;
    DECLARE v_data_fim_mes DATE;

    -- A partir de X mes e Y ano
    SET v_data_inicio_mes = STR_TO_DATE(CONCAT(p_ano, '-', p_mes, '-01'), '%Y-%m-%d');
    SET v_data_fim_mes = LAST_DAY(v_data_inicio_mes);

    SELECT SUM(salario)
    INTO v_custo_total
    FROM Funcionarios
    WHERE
        data_ingresso <= v_data_fim_mes
        AND (data_saida IS NULL OR data_saida >= v_data_inicio_mes);

    SET v_custo_total = IFNULL(v_custo_total, 0.00);

    -- Pega o custo total e calcula o percentual
    SET v_custo_total = v_custo_total * (1 + (p_percentual_encargos / 100));

    RETURN v_custo_total;
END$$
DELIMITER ;
-- Exemplo: Calcular o custo da folha de pagamento para
-- Junho de 2024, com 35% de encargos.
SELECT f_CustoMensalFolhaPagamento(2024, 6, 35.0);
-- --------------------------------------------------------
-- //FUNCTION 2: RETORNAR LUCRO DE CAMPANHA LEVANTADA.
-- --------------------------------------------------------
CREATE FUNCTION f_LucroTotalCampanha(
	p_Custo DECIMAL(15,2), 
    p_Ganho DECIMAL(15,2)
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
RETURN p_Ganho - p_Custo;
SELECT f_LucroTotalCampanha(1000.0, 1500.0);
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //TRIGGERS.
-- --------------------------------------------------------
-- --------------------------------------------------------


-- --------------------------------------------------------
-- //TRIGGER 1: QUE ATUALIZA A SITUAÇÃO DE UM ANIMAL PERANTE ADOÇÃO.
-- --------------------------------------------------------
DELIMITER $$
CREATE TRIGGER tg_atualiza_status_animal_adocao
AFTER UPDATE ON Adocoes
FOR EACH ROW
BEGIN
    IF (NEW.situacao = 'aprovado' OR NEW.situacao = 'concluido') AND NEW.situacao != OLD.situacao THEN
        UPDATE Animais
        SET situacao = 'A' 
        WHERE id = NEW.animal_id;
    ELSEIF NEW.situacao = 'cancelado' AND (OLD.situacao = 'aprovado' OR OLD.situacao = 'concluido') THEN
        UPDATE Animais
        SET situacao = 'D' 
        WHERE id = NEW.animal_id;
    END IF;
END$$
DELIMITER ;
-- --------------------------------------------------------
-- //TRIGGER 2: QUE DETERMINA SE A DATA DE UMA CAMPANHA É VALIDA.
-- --------------------------------------------------------
DELIMITER $$
CREATE TRIGGER tg_valida_data_campanha_insert
BEFORE INSERT ON Campanhas
FOR EACH ROW
BEGIN
    IF NEW.data_termino <= NEW.data_inicio THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erro de Validação: A data de término não pode ser anterior à data de início da campanha.';
    END IF;
END$$
DELIMITER ;
-- --------------------------------------------------------
-- //TESTE DATA INVÁLIDA.
-- --------------------------------------------------------
-- INSERT INTO Campanhas 
-- (organizador_id, nome, descricao, data_inicio, data_termino, meta, situacao, tipo, localizacao) 
-- VALUES 
-- (NULL, 'teste', 'teste', '2025-07-01 09:00:00', '2025-06-15 18:00:00', 'teste', 'aguardando', 'Arrecadação', 'Lua');
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //CURSOR.
-- --------------------------------------------------------
-- --------------------------------------------------------

-- --------------------------------------------------------
-- DROP PROCEDURE listar_voluntarios_cursor;

DELIMITER $
CREATE PROCEDURE listar_voluntarios_cursor()
BEGIN
	DECLARE v_id INT;
    DECLARE v_nome VARCHAR(255);
    DECLARE v_disponibilidade VARCHAR(512);
    DECLARE v_fim BOOLEAN DEFAULT FALSE;
    
    DECLARE cur_voluntarios CURSOR FOR
        SELECT 
			Voluntarios.id, Usuarios.nome, Voluntarios.disponibilidade
        FROM 
			Voluntarios
        JOIN 
			Usuarios 
			ON Voluntarios.usuario_id = Usuarios.id
        WHERE 
			Voluntarios.situacao = 'ativo';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fim = TRUE;

CREATE TEMPORARY TABLE IF NOT EXISTS temp_voluntarios (
	id INT,
	nome VARCHAR(255),
	disponibilidade TEXT,
	prioridade VARCHAR(20)
);

    OPEN cur_voluntarios;

	laço : LOOP
        FETCH cur_voluntarios INTO v_id, v_nome, v_disponibilidade;
        IF v_fim THEN
            LEAVE laço;
        END IF;
        
        INSERT INTO temp_voluntarios VALUES (
            v_id,
            v_nome,
            v_disponibilidade,
            CASE 
                WHEN v_disponibilidade LIKE '%de semana%' THEN 'Alta'
                WHEN v_disponibilidade LIKE '%Sábado%' THEN 'Alta'
                WHEN v_disponibilidade LIKE '%Domingo%' THEN 'Alta'
                WHEN v_disponibilidade LIKE '%tarde%' THEN 'Média'
                ELSE 'Normal'
            END
        );
    END LOOP;

    CLOSE cur_voluntarios;

    SELECT * FROM temp_voluntarios ORDER BY prioridade, nome;
    
    -- Limpa tabela temporária
    DROP TEMPORARY TABLE IF EXISTS temp_voluntarios;
END $
DELIMITER ;

CALL listar_voluntarios_cursor();
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //VIEWS.
-- --------------------------------------------------------
-- --------------------------------------------------------


-- --------------------------------------------------------
-- //VIEW 1: PARA FICHA COMPLETA DO ANIMAL.
-- --------------------------------------------------------
CREATE OR REPLACE VIEW vw_Ficha_Completa_Animal_Disponivel AS
SELECT
    -- Usando o apelido 'a' para todas as colunas da tabela 'animais'
    a.id AS animal_id,
    a.nome,
    a.especie,
    a.raca,
    a.idade,
    a.sexo,
    a.porte,
    a.cor,
    a.historia,
    a.foto,
    a.data_chegada,
    -- Usando o apelido 'p' para todas as colunas da tabela 'prontuarios'
    p.castrado,
    p.alergias,
    p.deficiencia,
    p.observacoes_gerais
FROM
    Animais AS a
LEFT JOIN
    Prontuarios AS p
    -- Usando o apelido 'a' aqui também
    ON a.id = p.animal_id
WHERE
    -- E aqui
    a.situacao = 'D';

SELECT * FROM vw_Ficha_Completa_Animal_Disponivel;
-- --------------------------------------------------------
-- //VIEW 2: PARA PAINEL DE ADOÇÕES.
-- --------------------------------------------------------
CREATE OR REPLACE VIEW vw_Painel_Adocoes AS
SELECT
    ad.id AS adocao_id,
    ad.situacao AS status_adocao,
    ad.data_adocao,
    an.id AS animal_id,
    an.nome AS nome_animal,
    u.id AS usuario_id,
    u.nome AS nome_adotante,
    c.email AS email_adotante,
    c.celular AS celular_adotante,
    ad.observacoes
FROM
    Adocoes AS ad
JOIN
    Usuarios AS u ON ad.usuario_id = u.id
JOIN
    Animais AS an ON ad.animal_id = an.id
-- Usando LEFT JOIN para o caso de um usuário não ter um contato registrado.
-- A adoção ainda aparecerá no painel.
LEFT JOIN
    Contatos AS c ON u.id = c.usuario_id;
    
SELECT * FROM vw_Painel_Adocoes;
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //INDEXES.
-- --------------------------------------------------------
-- --------------------------------------------------------


-- --------------------------------------------------------
-- //INDEX 1: AUXILIAR NA ORDENAÇÃO DE CAMPANHAS MAIS RECENTES.
-- --------------------------------------------------------
CREATE INDEX buscaCampanha
ON Campanhas (data_inicio);
-- --------------------------------------------------------
-- //INDEX 2: BUSCAR USUÁRIOS VIA NOME.
-- --------------------------------------------------------
CREATE INDEX buscaUsuarios
ON Usuarios (nome);
-- --------------------------------------------------------
-- //INDEX 3: ENCONTRAR ANIMAIS DE FORMA MAIS RÁPIDA NO MENU DE ADOÇÃO.
-- -------------------------------------------------------- 
CREATE INDEX listarAnimaisMenu
ON Animais(nome, especie, situacao);
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //LOCK TABLE.
-- --------------------------------------------------------
-- --------------------------------------------------------

-- --------------------------------------------------------
-- Define os IDs para o teste.
SET @animal_id_para_adotar = 1; -- Mudar para um ID de animal que exista e esteja disponível.
SET @usuario_id_adotante = 5; -- Mudar para um ID de usuário que exista.

-- INÍCIO DA OPERAÇÃO CRÍTICA: Bloqueia as tabelas.
LOCK TABLES Animais WRITE, Adocoes WRITE;

-- Dentro do LOCK, verificamos a situação do animal.
SELECT situacao INTO @situacao_atual FROM Animais WHERE id = @animal_id_para_adotar;

-- Verifica-se o valor da variável para decidir o próximo passo.
SELECT @situacao_atual;

-- Atualiza a situação do animal para 'Adotado'.
UPDATE Animais SET situacao = 'A' WHERE id = @animal_id_para_adotar;

-- Cria o registro de adoção.
INSERT INTO Adocoes (usuario_id, animal_id, data_adocao, situacao)
VALUES (@usuario_id_adotante, @animal_id_para_adotar, NOW(), 'concluido');

SELECT 'SUCESSO: Adoção realizada e registrada.' as resultado_da_operacao;

-- Informa-se o motivo.
SELECT 'FALHA: O animal não está disponível para adoção.' as resultado_da_operacao;

-- FIM DA OPERAÇÃO CRÍTICA: Libera as tabelas.
UNLOCK TABLES;
-- --------------------------------------------------------


-- --------------------------------------------------------
-- --------------------------------------------------------
-- //TRANSACTIONS.
-- --------------------------------------------------------
-- --------------------------------------------------------


-- --------------------------------------------------------
-- //TRANSACTION 1: COMMIT PARA AUMENTAR 200 REAIS NO SALÁRIO DE UM FUNCIONÁRIO.
-- --------------------------------------------------------
START TRANSACTION;

UPDATE Funcionarios
SET salario = salario + 200.00
WHERE id = 1;

COMMIT;

-- SELECT * FROM Funcionarios;
-- --------------------------------------------------------
-- //TRANSACTION 2: ROLLBACK PARA VOLTAR A EXCLUSÃO DE UM ANIMAL.
-- --------------------------------------------------------
START TRANSACTION;

DELETE FROM Animais WHERE id = 9;

Select * from Animais;

ROLLBACK;
-- --------------------------------------------------------
