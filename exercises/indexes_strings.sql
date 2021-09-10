alter table matrix
  drop index idx_matrix_name;

create fulltext index idx_matrix_name
  on matrix (name);

explain
select *
from matrix
where name like '%wed%'
order by id desc
limit 15;

explain
select *
from matrix m
where match(m.name) against('*inhum*' in boolean mode)
order by id desc
limit 15;

-- TODO Add currency_name to the lookup
-- TODO Denormalize currency_name column
