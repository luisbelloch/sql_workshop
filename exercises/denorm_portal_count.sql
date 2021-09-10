alter table matrix add column portal_count integer;

update matrix m
inner join (
  select matrix_id as id, count(1) as portal_count
  from portal
  group by matrix_id
) c on m.id = c.id
set m.portal_count = c.portal_count;
