-- alter table matrix drop column active;

alter table matrix add column active tinyint(1) not null default 1;

explain select * from matrix where active = 1;

update matrix set active = 0 where id % 100 = 0;

alter table matrix add index idx_matrix_active (active);

explain select * from matrix where active = 1;
