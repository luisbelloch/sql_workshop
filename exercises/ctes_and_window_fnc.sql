-- Using CTEs
with cte1 as (
  select
    id,
    row_number() over (partition by name) as seq
  from matrix
)
select * from cte1 where seq > 1;

-- Using json_arrayagg (this connects with JSON chapter)
select
  name,
  json_arrayagg(id) as ids
from matrix
group by name
having count(*) > 1;

