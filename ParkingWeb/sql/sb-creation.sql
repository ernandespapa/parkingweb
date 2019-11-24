DROP TABLE users;
CREATE TABLE users(
    id BIGINT not null primary key
    GENERATED ALWAYS AS IDENTITY
    (START WITH 1, INCREMENT BY 1)
    , role varchar (200) not null
    , name varchar (200) not null
    , login varchar (20) not null
    , passwordHash BIGINT not null
);

INSERT INTO users VALUES
(default, 'ADMIN', 'Administrador', 'admin', 1509442);
INSERT INTO users VALUES
(default, 'OPERADOR', 'Fulano da Silva', 'fulano', 1509442);

DROP TABLE prices;
CREATE TABLE prices(
    id BIGINT not null primary key
    GENERATED ALWAYS AS IDENTITY
    (START WITH 1, INCREMENT BY 1)
    , timestamp TIMESTAMP not null
    , new_price DOUBLE PRECISION not null
);

DROP TABLE parking_periods;
CREATE TABLE parking_periods(
    id BIGINT not null primary key
        GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1)
     , model varchar (50) not null
     , plate varchar (7) not null
     , begin_period TIMESTAMP not null
     , end_period TIMESTAMP 
     , price DOUBLE PRECISION
);
