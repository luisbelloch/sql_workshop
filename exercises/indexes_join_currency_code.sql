-- alter table matrix drop index idx_matrix_currency_active;

-- Swap active and currency_code to see results
alter table matrix
  add index idx_matrix_currency_active (currency_code, active);

-- filter in currency table
explain
select m.id, m.name, c.code, c.name
from matrix m
inner join currency c on m.currency_code = c.code
where m.active = 1
  and c.code in ('EUR', 'USD');

-- filter in matrix table
explain
select m.id, m.name, c.code, c.name
from matrix m
inner join currency c on m.currency_code = c.code
where m.active = 1
  and m.currency_code in ('EUR', 'USD');

-- subquery
explain
select m.id, m.name, c.code, c.name
from matrix m
inner join (select * from currency c where c.code in ('EUR', 'USD')) c on m.currency_code = c.code
where active = 1;

-- Now, most of the matrix table are inactive matrices, what would the index do? NOTHING
-- select active, count(*) from matrix group by active;

-- filter using active = 0
-- would it be better to have an index (currency_code, active)
explain
select m.id, m.name, c.code, c.name
from matrix m
inner join currency c on m.currency_code = c.code
where m.active = 0
  and m.currency_code in ('EUR', 'USD');