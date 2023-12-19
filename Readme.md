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
* Types: b tree and lsm
* pk has btree index
* if the data is in the index the query is fast
* we go  to the page and read from disk
* like is bad
* btree -->bit map heap scan
* 