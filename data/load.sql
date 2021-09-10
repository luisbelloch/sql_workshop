load data local infile '/opt/sql_workshop/data/tag.csv'
replace into table tag
fields optionally enclosed by '"' terminated by ','
lines terminated by '\n';

select count(*) as tag_count from tag;

load data local infile '/opt/sql_workshop/data/matrix.csv'
replace into table matrix
fields optionally enclosed by '"' terminated by ','
lines terminated by '\n';

select count(*) as matrix_count from matrix;

load data local infile '/opt/sql_workshop/data/portal.csv'
replace into table portal
fields optionally enclosed by '"' terminated by ','
lines terminated by '\n';

select count(*) as portal_count from portal;

load data local infile '/opt/sql_workshop/data/currency.tsv'
replace into table currency
fields optionally enclosed by '"' terminated by '\t'
lines terminated by '\n';

select count(*) as currency_count from currency;
