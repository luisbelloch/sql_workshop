%title: SQL Workshop / Flywire
%author: luisbelloch
%date: 2021-11-13

-> SQL Workshop <-
==================

-> Luis Belloch <-
-> Flywire <-
-> September 2021 <-

---

# Quiz

How is SQL pronounced?

---

# Ergonomics

Read the Makefile.

---

# Transaction Isolation Levels

## Read uncommitted
Transactions can view the results of uncommitted transactions.

## Read committed
A transaction will see only those changes made by transactions
that were already committed when it began, and its changes won't
be visible to others until it has committed.

## Repeatable read <- MySQL default mode
It guarantees that any rows a transaction reads will look the
same in subsequent reads. Warning: _Phantom reads_ can occur.

## Serializable
Removes _Phantom reads_ by ensuring transaction order. In
practice, uses locks everywhere.

---

Practically, start a transaction with `BEGIN` and commit with `COMMIT`:

~~~
 SET TRANSACTION ISOLATION LEVEL [level];
 BEGIN
 ...

 COMMIT / ROLLBACK;
~~~

Notice that isolation level affects only how current transaction
sees data, the rest of the transactions have their own view.

---

-> *LOCKS* <-

---

# Exercise

Create a table to emulate a job queue, where only
a single job can be run concurrently.

*queue.sql*

---

-> SELECT ... *FOR UPDATE* [NOWAIT | SKIP LOCKED] <-

---

# Show locks in Performance Schema

~~~
use performance_schema;

select object_name, lock_type, lock_status, lock_mode, lock_data
from data_locks;
~~~

---

-> *INDEXES* <-

---

# Exercise

Add column `active?` to table matrix, default to `true`.
Disable all matrices divisible by 100.
`select` and `explain` _all matrices being active_.

Quiz: does `default` add values to existing rows?

*indexes_matrix_active.sql*

---

# Exercise

Get a list of active matrices, from `EUR` and `USD` currencies,
displaying also the currency `name`. Optimize indexes.

*indexes_join_currency_code.sql*

---

# Exercise

Implement quick _look-up_ of matrices by _name_, where
the user will type few words and get _15 possible results_.

Those 15 are selected from last recently created ones.

Add _currency name_ to the look-up.

*indexes_strings.sql*

---

# Is it possible to force an index?

Yes. *But do not force them*.

That's all.

---

# Partial indexes

MySQL does not support them.

Move on, nothing to see here.

---

# BRIN Indexes

Designed for very large tables in which certain columns have some
natural correlation with their physical location within the table.

Only for [Postgres](https://www.postgresql.org/docs/current/brin-intro.html)

_Example_: power consumption measures over time, transfer amounts.

---

# Profiling

~~~
SET SESSION profiling = 1;

-- run queries here

SHOW PROFILES;
~~~

---

# Disable foreign and unique checks when bulk updates

~~~
SET FOREIGN_KEY_CHECKS = 0;
SET UNIQUE_CHECKS = 0;
SET AUTOCOMMIT = 0;

-- DO SOMETHING

SET UNIQUE_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
~~~

---

-> *Window Functions & CTEs* <-

---

# Exercise

Database contains _duplicated_ matrices, having the _same name_.
Leave the _first_ matrix found, delete the rest.

*ctes_and_window_fnc.sql*

---

-> *Denormalization* <-

---

# Exercise

Count the number of portals per matrix,
store it in column `portal_count` in matrix table.

*denorm_portal_count.sql*

---

# Exercise

_Normalize_ tags table, adding a table `matrix_to_tag` to store
the relation between tags and matrices.

*denorm_matrix_tags.sql*

---


# Random DOs and DON'Ts

Giving advice is cheap:

- DO let the database work. Push as much work as posible
- *DON'T* Entity-Attribute-Value (EAV) design
- DO stick to sql standards as much as possible
- *DON'T* make premature index optimizations
- DO _NULLS_, because they mean _unknown_ in the SQL world
- *DON'T* get crazy with JSON
- DO use specific data types without feat (decimal, date, text, etc.)
- *DON'T* get crazy with the ORM, SQL is good
- DO use the ORM, 80% of the cases are 1 to 1 translations

---

-> # Thanks! <-
