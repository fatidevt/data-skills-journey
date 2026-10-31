-- Data structure provides quick access to  data, optimizing the speed og the queries
-- Index Types
/*
1. Structure : how db organizing data
	clustured index , non _clustured index
2. Storage : how db stored in db
	rowstore index , columnstore index
3. Function :
	unique index , filtred index
*/

/* General Infos
	data file has many data pages
	data page (8 KB) : disk storage that holds database table records
    data page = 
		header 1:150 ==> 1: file id , 150 page nb
        data rows 
        offsed : where eacj row begins (to find rows easily)
*/

/* why we need indexes?
heap structure : table without clustered index
slow read , fast write(isert data)
Full table scan : ex saerching cust id 14, will saerch data pages one by one.
thats why we need indexes.
*/
-- indexe is the primary key
show indexes from customers;


/* ==============================================================================
   1. CLUSTERED AND NON-CLUSTERED INDEXES
============================================================================== */

-- CLUSTERED INDEXES
-- 1. sql gonna phisically sort all data based on col id (first row in first page, 1,2,3 ........ last_id in last page)
-- 2. B-Tree : balance tree
	-- hierarchical structure storing data al leaves, to help quickly locate data
	-- leaf level is the data pages
	-- intermediate node : index page has the pointer of group of data pages 
	-- root node : index page has the pointer of index page of inermediate node
    
-- NON-CLUSTERED INDEXES 
-- 1. no phisically sorting of data
-- 2. B-Tree : balance tree
	-- leaf level has the index pages will have pointers of 1st id then 2nd .. untile last row in data page
    -- intermediate node : index page has the pointer of group of index pages of leaf level
	-- root node : index page has the pointer of index page of inermediate node


-- CLUSTERED created auto in mysql
-- syntax non-clustered
-- CREATE INDEX index_name ON table_name (column1, column2, ..);
CREATE INDEX idx_customers_last_name_ ON customers(lastname);
select * from customers;
show indexes from customers;
select *
from customers
where lastname = 'Adams';

-- coposite index

CREATE INDEX idx_customers_first_name_last_name_ ON customers(lastname, firstname);

show indexes from customers;

select *
from customers
where lastname = 'Adams' and firstname = 'Anna';

/*
Works: search by lastname alone or both lastname AND firstname.
Does NOT work: search only by firstname (because the leftmost prefix lastname is missing).
*/

-- drop an index
alter table customers
drop index idx_customers_first_name_last_name_;
show indexes from customers;



