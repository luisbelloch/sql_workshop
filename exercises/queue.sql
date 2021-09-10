drop table poor_man_queue;

create table if not exists poor_man_queue (
  id int not null primary key,
  status enum('waiting', 'running', 'done') not null default 'waiting'
);

insert into poor_man_queue (id)
values (0), (1), (2), (3);

select * from poor_man_queue;

# start transaction;
select count(1) from poor_man_queue where status = 'running' for update skip locked;
update poor_man_queue set status = 'running' order by id limit 1;
# commit;
