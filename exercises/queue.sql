-- drop table job_queue;

create table if not exists job_queue (
  id int not null primary key,
  status enum('waiting', 'running', 'done') not null default 'waiting',
  consumer varchar(64) null
);

insert into job_queue (id) values (0), (1), (2), (3);

select * from job_queue;

-- traditional approach, get all jobs waiting, pick the first
-- notice second update will wait for another transaction to finish
start transaction;
select id from job_queue where status = 'waiting' and consumer is null order by id limit 1 for update skip locked;
update job_queue set status = 'running', consumer = 'worker1' where id = 0;
commit;

-- Better solution:
-- Assumes workers are single threaded
-- If a job is stuck, we'll loop forever in status == 'running'
start transaction;
update job_queue set status = 'running', consumer = 'worker2'
where status = 'waiting' and consumer is null
order by id limit 1;

select id from job_queue where status = 'running' and consumer = 'worker2' limit 1;
commit;

-- Even better one:
-- Do NOT use MySQL for this


