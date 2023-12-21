# Udemy -- Fundamentals of Database Engineering Course:

## Section 2 ACID:
* Atomicity, Isolation, consistency and Durability
* when we commit a transaction it means that in non volitile way that it can be access even if the power loss or it crashes.

### Transaction:
* a collection of sql queries that are treated as single unit of work  normally to change and modify data
* Transaction starts with Begin ---> quereis ---> Commit
* Transaction rollback and unexpected ending rollback
* some dbs optimize for crashes and some optimized for commits 
* postgresql is optimized for commit because they want to persist every change done by the query
* if your commits are slow means that it can crash if transactions is big
* Transaction can be read only and it optimizes itself to be read only and if you want a snap short at the time of transaction and if a concurrent user changes anything you read it isolates itslef at the time stamp and read no changes occur to the data.
* we are always in a transaction in db but it implicity commits it every time.
---
* lack of atomaticity leads to inconsistency
* Isolation levels:
  * Dirty reads
  * non repeatable reads
  * phantom reads: you cannot grab it its phantom
  * lost updates: locking solves
---
* Isolation levels in flight transaction:
* Read uncommited --> dirty reads
* Read commited --> default isolation level
* Repeatable read --> row remain unhinged has phantom reads
* snapshot --> changes up to the start
* Serializable --> one by one
---
*  in postgresql RR implement as a snapshot so we dont get repeatable reads
---
* Durability:
  * data is persisted on the disk
  * Durability techniques:
    * wal, write ahead log --> some times os write to cache--> fsync
    * Asynchronous snapshot
    * apend only files
---
* Consistency:
  * Consistency in data --> referential integrity, A,C,D
  * Consistency in reads --> eventual consistency
* Eventual Consistency:
  * expected results when viewing the data during reads
  * master node and slave node and eventual consistent
  * cache makes db in consistent
  * The transaction will always see the changes it makes regardless of the isolation level. Isolation level only applies to other concurrent transactions

## Indexing:
* a DS that you build on top of an existing table and it analyzes it and create shortcuts
* Types: b tree bitmap index and lsm
* pk has btree index
* if the data is in the index the query is fast
* we go  to the page and read from disk
* like is bad
* btree -->bit map heap scan
* inling --> multiple column index
* explain analyaze command
* seq table scan --> full table scan
* bitmap index scan --> makes a bitmap and go back to the index and fetch those pages
* key and non key index for efficient fetching 
  * a non key one is that a index include some columns  in making a index but not include any keys from that columns
  * vaccum verbose command for deleting dead rows and tables
* Index scan --> go to the table
* index only scan     
* Composite index a and b it can uses when you search for a and when a and b
* for b parallel seq scan
* Some times dbs think it is great to use scan rather than indexes
* Concurrent index creating
* Bloom Filters:
  * we create a 64 bit array and this contains 0s and 1s after that when a post request comes the payload is hashed and taken a mod of 64 and the result is between o and 63 and we make that bit 1 when a query ask is that particular letter exists we first hit the bit map sort of like strucutre first and check its hashed mod bit is 0 or 1 and it saves us the db queries and makes it fast and if all the bits became one then it ones use because your filter essentially everytime hits the db and its useless
* One billion row table:
  *  google map reduce
  *  indexing, Horizontal partitioning, sharding
  *  DB design like has a column that has json as a data type
*  Composite  index when it uses and
*  index is sorted

### Partitioning:
* Break the table rows into multiple columns
* Working with small set of data
* Horizontal: spliting rows
* vertical: splitting columns
* Partitioning Types:
  * By Data, List, Hash
* Partitioning means split the tables but manage by same database--> schema changes
* sharding means split the tables into multiple tables on different machines--> Schema remains same
* if we want to create partitions on a particular table we create tables and attach those to the main table and create a index on the master table
* we should enable partitioning pruning
* sequencial scna and scattered index scan
* Archieve old data on cheap hardware
##### Disadvantages:
* Update that move rows from a partition to another
* inefficient queries make the result slow
* Schema changes are difficult

### Sharding:
* shard key
* Consistent hashing shards
* Hash ring --> port
* Implement by hashring library
* Pros:
  * Scalibilty
  * security
  * Small index size
* Cons:
  * Complex client
  * Transacation across shards
  * Rollbacks
  * Schema changes
  * Joins
* In Real life last thing to do is sharding
* Redis creates inconsistency
* Replication --> master slave Reverse proxy
* Logic in Client

### Replication
* write on master and read from slaves
* Asynchronous and Synchronous Replication
* Horizontal Scaling
* Eventual Consistency
