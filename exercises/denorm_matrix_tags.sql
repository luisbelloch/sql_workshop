-- TODO modify seed.rb to include array with tags
-- tags JSON not null default '[]';

insert into matrix_to_tag (tag, matrix_id)
select t.name as tag, m.id as matrix_id
from matrix m
join json_table(m.tags, '$[*]' columns (name varchar(50) path '$')) t
order by t.name;
