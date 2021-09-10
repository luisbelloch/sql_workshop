create table if not exists tag (
  id varchar(64) not null primary key
);

create table if not exists matrix (
  id int not null primary key,
  name varchar(512) not null,
  currency_code varchar(3) not null
);

create table if not exists matrix_to_tag (
  id int not null,
  tag varchar(64) not null,
  constraint pk_matrix_to_tag primary key (id, tag),
  constraint fk_matrix_to_tag_matrix foreign key (id) references matrix (id),
  constraint fk_matrix_to_tag_tag foreign key (tag) references tag (id)
);

create table if not exists portal (
  id int not null primary key,
  name varchar(512) not null,
  matrix_id int not null,
  constraint fk_portal_to_matrix foreign key (matrix_id) references matrix (id)
);

create table if not exists currency (
  code varchar(3) not null primary key,
  name varchar(256) not null
);

show tables;
