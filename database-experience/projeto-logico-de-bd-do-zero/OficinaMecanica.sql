
PROJETO OFICINA MECANICA

-- criando banco de dados para o cenário Oficina Mecanica

create database oficina_mecanica;
use oficina_mecanica;

-- criando tabela clientes

create table clientes (
        Id_cliente int primary key auto_increment,
        Nome_Cliente varchar (30),
        CPF char(11) unique,
        Modelo_Veiculo varchar (30),
        Placa_Veiculo char(7) unique,
        Telefone_cliente int 
);

insert into clientes (Nome_Cliente, CPF, Modelo_Veiculo, Placa_Veiculo,Telefone_cliente) values
                        ('Maria Ribeiro', '15470181430','Renault Kwid','OIO5986','19967272023'),
                        ('Salete Jacobi', '42745173227','Chevrolet Onix','BEX9418','19985256115'),
                        ('Claudiane Cruz', '88058377333','Cherry QQ','FZL4530','19982559390');

-- criando tabela equipe_de_mecanicos

create table equipe_de_mecanicos (
        Id_mecanico int primary key auto_increment,
        Nome_Mecanico varchar (30),
        Endereço varchar (30),
        Servico_mecanico enum('Embreagem','Troca de Oleo','Arrefecimento','Geometria e Balanceamento')
);

insert into equipe_de_mecanicos (Nome_Mecanico,Endereço,Servico_mecanico) values
                                ('Maria Ribeiro', 'R José Escura 14','Embreagem'),
                                ('Salete Jacobi', 'R Vilas Lobo 147', 'Geometria e Balanceamento'),
                                ('Claudiane Cruz','Av. XV Novembro 102', 'Troca de Oleo);
                                
-- criando tabela ordem_de_servico 

create table ordem_de_servico (
        Id_OS int primary key auto_increment,
        Data_OS date,
        Status_Servicos enum('analisando','aguardando aprovação','aguardando peça','concluido'),
        Data_Conclusao date,
        Valor float,
        tipo_os enum ('concerto','revisão'),
        Descricao_Serviço varchar (255),
        idCliente_os int,
        idMecanico_os int,
        constraint fk_ordem_de_servico_cliente foreign key (idCliente_os) references clientes (Id_cliente),
        constraint fk_ordem_de_servico_mecanico foreign key (idMecanico_os) references equipe_de_mecanicos (  Id_mecanico)        
);

insert into ordem_de_servico (data_os, Status_Servicos ,data_conclusao,valor,tipo_os,Descricao_serviço,idCliente_os,idMecanico_os) values
                             ('2022-08-17', 'analisando','2022-08-25','200','concerto','Troca da lampada','2','1'),
                             ('2022-08-30', 'aguardando peça','2022-09-08','500','revisão','motor com falhas','3','2'),
                             ('2022-07-31', 'concluido','2022-08-02','350','ajuste','farol ','4','3');

-- criando tabela mao_de_obra         
                    
create table mao_de_obra(
        id_mao_de_obra int primary key auto_increment,
        valor_mao_de_obra float,
        IdMecanico_responsavel int,
        IdOrcamento_mao_de_obra int,

        constraint fk_mao_de_obra foreign key (IdMecanico_responsavel) references equipe_de_mecanicos(Id_mecanico),
        constraint fk_mao_de_obra_orcamento foreign key (IdOrcamento_mao_de_obra) references orcamento(Id_orcamento)
);

insert into mao_de_obra (valor_mao_de_obra,idMecanico_responsavel,idOrcamento_mao_de_obra) values
                        ('285','3','7'),
                        ('587','3','8'),
                        ('650','3','9');

-- criando tabela orcamento 
create table orcamento(
        Id_orcamento int primary key auto_increment,
        Numero_os int,
        valor_orcamento float,
        id_cliente_orcamento int,
        constraint fk_orcamento_Numero_os foreign key (Numero_os) references ordem_de_servico( Id_OS),
        constraint fk_orcamento_id_cliente foreign key (id_cliente_orcamento) references clientes(Id_cliente)
);

insert into orcamento (Numero_os ,valor_orcamento, id_cliente_orcamento)values
                        ('2','254',1),
                        ('5','741',3),
                        ('1','365',2);

-- criando tabela peca

create table peca(
        Id_peca int primary key auto_increment,
        descricao_peca varchar (255),
        valor_peca float,
        idOrcamento_peca int,
        constraint fk_peca_idOrcamento_peca foreign key (idOrcamento_peca) references orcamento(Id_orcamento)
);

insert into peca (descricao_peca,valor_peca,idOrcamento_peca) values
                    (    ('Kit lampada de farol','150','7'),
                    ('Oleo Motor - mobil','23','9'),
                    ('Lanterna traseira','48','8');
 
-- ordenando o conteúdo da tabela clientes pelo nome

select * from clientes
order by nome_cliente;

-- Verificando o status da ordem de serviço do cliente combinado com o valor do serviço

select clientes.nome_cliente, orcamento.valor_orcamento, ordem_de_servico. Status_Servicos from clientes
INNER JOIN orcamento
on clientes.id_cliente = orcamento.id_cliente_orcamento
JOIN ordem_de_servico
on ordem_de_servico.id_os = orcamento.id_cliente_orcamento;

-- Verificando o tipo de serviço solicitado pelo cliente combinado com o nome do mecanico resposavel

select clientes.nome_cliente, ordem_de_servico.Descricao_serviço, equipe_de_mecanicos.nome_mecanico from clientes
INNER JOIN ordem_de_servico
on clientes.id_cliente = ordem_de_servico.IdCliente_os
JOIN equipe_de_mecanicos
on equipe_de_mecanicos.id_mecaninco = ordem_de_servico.IdMecanico_os;

-- Verificando a especialidadade de cada mecanico 

select equipe_de_mecanicos.nome_mecanico, equipe_de_mecanicos.Servico_mecanico _mecanica from  equipe_de_mecanicos;

-- Verificando o valor de cada peça para cada solicitação do cliente 
select peca.descricao_peca, peca.valor_peca, orcamento.id_cliente_orcamento from orcamento
INNER JOIN peca
on orcamento.Id_orcamento = peca.idOrcamento_peca;