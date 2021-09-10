# SQL Workshop

Support materials for a training about SQL/MySQL we do at Flywire from time to time.

## Getting Started

We've prepared a container with MySQL that you can bring up with `make up` and then create the schema and load some test data on it:

```shell
make up   # wait few seconds for it to start

make schema seed
```

For the exercises, you can write your queries in `scratch.sql` and run them automatically with `make` - it's the default target. We recommend you to read the `Makefile` targets to understand how `mysql` executable is executed inside the container.

You can also run MySQL Shell by doing `make shell`. Alternativelly, MySQL will be available at port 3306 - user `root`, password `password`.

Other targets that you may find interesting:

```
make slides          # bring up slides used in the workshop
make drop            # drop all the tables
make clean           # clean all CSV seed files
make generate_data   # generate CSV seed files
```

## Links

- [High Performance MySQL](https://learning.oreilly.com/library/view/high-performance-mysql/9781492080503)
- [Use the index, Luke](https://use-the-index-luke.com/)
- [InnoDB Transaction Isolation Levels](https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-isolation-levels.html)
- [InnoDB Locking Reads](https://dev.mysql.com/doc/refman/8.0/en/innodb-locking-reads.html)
- [InnoDB Locking](https://dev.mysql.com/doc/refman/8.0/en/innodb-locking.html)
- [LOAD DATA](https://dev.mysql.com/doc/refman/8.0/en/load-data.html)
- [Explain Output](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html)
- [Confluence: Database Migrations](https://confluence.flywire.tech/display/PE/Database+Migrations)
- [Confluence: How to alter/removing existing indexes](https://confluence.flywire.tech/pages/viewpage.action?pageId=568594427)
- [Postgres Internals Booklet (old)](https://github.com/luisbelloch/postgres_internals_booklet)
