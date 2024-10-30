Schema: user_id INTEGER [ref: > users.id]
Polymorphic association, simple middle table,
CreatedAt DATETIME DEFAULT GETDATE()

---

Full → Latest Differential → Transaction Logs
Heap:
A table with out clustered index. Rows are stored where space is available. by this faster inserts can be done. slow reads
Default port: 1433
Stored procedures: modify db state and does not have to return a value but can have output parameters
Function: must return a value, can not modify db state, often use for cal calculations
Scalar Functions: returns a single value
Table-Valued Functions: return a table and can use in from clauses
SQL Server Profiler: To trace slow-running queries and events.
Execution Plans: To identify inefficient query plans. SQL server query optimiazer calculates bunch of ways. Tree based. Estimated EP, EP->runtime, Cache plans, statistics,
Dynamic Management Views (DMVs): For real-time performance metrics.
SQL Server Performance Monitor: For monitoring server resources (CPU, memory).
Temporary Table: A table that is created in the tempdb database and exists for the duration of a session or connection
Temp Varaible: A variable that holds a table in memory. It has limitations compared to temporary tables but is faster for small data insert
`VARCHAR` stores non-Unicode characters, while `NVARCHAR` stores Unicode characters
COALESCE: first non-null expression
FLOOR, CEIL, SIGN, functions
Locks: sp_lock
All Triggers: Select \* from sys.objects where type='tr'

---

Database:
Normalization: atomic, no mulyiple values in a columns,no multiple columns, uses foriegn key, seprate table, 3nf(does not contain columns that do not depend upon pk)
1nf to 3nf
Orm: maps database tables to objects, model in sequliaze
DDL: create, alter, drop
DML: select, update, insert, delete
order of execution: Fish will go home soon, Ollie laughs.
Case: for conditions(CASE->WHEN->THEN->ELSE->END).
Where-->Group by-->Having-->Order by
IN(), between
LIKE: wildcard matches, '\_a%'
Union(Unique), Union All, Intersect(Same)
DB Constraints: PK & FK, UNIQUE, NOT NULL, CHECK, DEFAULT
Where: filtering records before grouping
Having: filtering records after grouping, you can pass any column
Group by: group rows that have the same values, All columns in the SELECT clause that are not used in aggregate functions must be included in the GROUP BY clause.
Order by: sort the result of a query and can pass any column.

---

- Views: virtual table based on the result of a query, restrict access to sensitive data, simplify complex queries by encapsulating joins, filters, or aggregations
  Updating->if created from a single table not able to do even with DISTINCT.
  do not store data, When the view is queried, the query is executed on the underlying data,

- Stored Procedures: precompiled collection of one or more SQL statements that can be executed as a single unit, skipping the parsing and optimization
  Modularity, Performance, Maintainability, Security
  EXEC GetEmployeeByID @EmployeeID = 1;
  declare a variable to hold the output value
  CREATE PROCEDURE DeleteEmployee
  @EmployeeID INT
  AS
  BEGIN
  DELETE FROM Employees
  WHERE EmployeeID = @EmployeeID;
  END

- Indexes: database object that improves the speed of data retrieval operations on view or table.

  - Clustered: determines the physical order of data in a table,only one clustered index-> rows can be sorted in only one way., Single , PK.
  - Non-Clustered: separate structure from the data rows basically pointers to the location of the data, Multiple
  - Unique Index
  - Composite Index
  - Full-Text Index
    Speed Up Queries, Enhanced Sorting and Filtering, Storage Overhead, Slower DML Operations,
    Rebuilding Indexes, Monitoring Performance

- Trigger: A trigger is a special type of stored procedure that automatically executes when a specified event occurs on a table or view. For logging changes, or after CRUD operations. we can disable and drop them.
  DML triggers: has two tables, inserted, deleted
  AFTER Trigger, INSTEAD OF Trigger
  DDL Triggers:
  response to changes in the database schema
  Database-Level DDL Triggers, Server-Level DDL Triggers

- CTE:
  is a temporary result that you can reference within a DML or select statement
  WITH EmployeeCTE AS
  (
  SELECT EmployeeID, EmployeeName, ManagerID
  FROM Employees
  )
  SELECT e.EmployeeName AS Employee, m.EmployeeName AS Manager
  FROM EmployeeCTE e
  LEFT JOIN EmployeeCTE m ON e.ManagerID = m.EmployeeID;

- Auditlog:
  feature that allows you to track and record database activities
  Server-level audits, Database-level audits

- Correlated subquery
- subqueries:
  SELECT company, continent FROM forbes*global_2010_2014 WHERE sector 'Financials'
  AND profits = (SELECT MAX(profits) FROM forbes_global_2010_2014)
  select max(population)- (select min(population) from city) from city
  Select * from employees where salary = (select MAX(salary) from employess)
  Select * from employees where salary IN (select MAX(salary) from employess where name like "*%a")

self join: apply conditions to one table.
select e.name as E, m.name as M from employees E join employees M on e.manager_id = m.id
select e.name, m.name from emp e join emp m on e.depid = m.depid where e.id!= mm.id

---

Rollbacks:  
Transaction Rollback:
Rolling back a transaction ensures that changes made during the transaction are undone if an error occurs
Savepoints:
Implicit Transactions:
Explicit Transaction Control
TRY...CATCH
Using Distributed Transactions
Point-in-Time Recovery
Snapshot Isolation

---

# Database Engineering Fundamentals

## 1. ACID Properties

ACID stands for Atomicity, Consistency, Isolation, and Durability. These properties ensure reliable processing of database transactions.

### Transactions

- A collection of SQL queries treated as a single unit of work
- Structure: BEGIN -> queries -> COMMIT
- Can be rolled back if needed
- Some databases optimize for crashes, others for commits (e.g., PostgreSQL)
- Read-only transactions are optimized and provide a snapshot of data at a specific time

### Atomicity

- Ensures all parts of a transaction complete or none do
- Lack of atomicity can lead to inconsistency

### Consistency

- Ensures data integrity and follows predefined rules
- Types:
  1. Consistency in data (referential integrity)
  2. Consistency in reads (eventual consistency)

### Isolation

- Determines how transaction integrity is visible to other users
- Isolation levels:
  1. Read Uncommitted (allows dirty reads)
  2. Read Committed (default in many systems)
  3. Repeatable Read
  4. Snapshot
  5. Serializable
- Issues addressed:
  - Dirty reads
  - Non-repeatable reads
  - Phantom reads
  - Lost updates (solved by locking)

### Durability

- Ensures committed transactions are saved permanently
- Techniques:
  1. Write-Ahead Log (WAL)
  2. Asynchronous snapshots
  3. Append-only files

## 2. Indexing

Indexes are data structures built on top of existing tables to create shortcuts for faster data retrieval.

### Types of Indexes

- B-tree
- Bitmap
- LSM (Log-Structured Merge-tree)

### Key Concepts

- Primary keys typically use B-tree indexes
- Composite indexes can be used for multiple columns
- 'LIKE' queries can be problematic for index usage
- EXPLAIN ANALYZE command helps understand query execution

### Index Scans

- Index Scan: Uses index, then fetches from table
- Index Only Scan: All required data is in the index
- Bitmap Index Scan: Creates a bitmap for efficient page fetching

### Advanced Indexing Techniques

- Key and non-key indexes
- Concurrent index creation
- Bloom filters for quick existence checks

## 3. Partitioning

Partitioning involves breaking table rows into multiple smaller tables.

### Types of Partitioning

1. Horizontal: Splitting rows
2. Vertical: Splitting columns

### Partitioning Methods

- By Date
- By List
- By Hash

### Advantages

- Works with smaller sets of data
- Enables archiving of old data on cheaper hardware
- Improves query performance (when done correctly)

### Disadvantages

- Updates moving rows between partitions can be slow
- Schema changes become more difficult
- Inefficient queries can still result in slow performance

## 4. Sharding

Sharding splits tables across multiple machines, unlike partitioning which keeps data on the same database.

### Key Concepts

- Shard key
- Consistent hashing
- Hash ring

### Advantages

- Scalability
- Enhanced security
- Smaller index sizes

### Disadvantages

- Complex client implementation
- Difficult cross-shard transactions
- Challenging rollbacks and schema changes
- Complicated joins

### Best Practices

- Consider sharding as a last resort
- Be aware that caching (e.g., Redis) can introduce inconsistency
- Implement logic in the client when possible

## 5. Replication

Replication involves copying data across multiple nodes for redundancy and improved read performance.

### Types

- Master-Slave replication
- Synchronous vs Asynchronous replication

### Benefits

- Enables horizontal scaling
- Improves read performance

### Considerations

- Eventual consistency in asynchronous setups
- Proper load balancing required (e.g., using reverse proxies)

---

optimized database queries or fine-tune existing queries as needed-->
Indexes:
CREATE INDEX idx_employee_name ON Employees (EmployeeName);
slow down inserts and updates,helpful for columns in WHERE, JOIN, and ORDER BY clauses.
Avoid SELECT
Use Joins Instead of Subqueries:
optimize the join operation better
Joins can utilize indexes, Joins can use indexes on both tables, Joins usually process data in one pass subqueries may require multiple passes, DE better at optimizing join operations, Joins often use less memory as they stream data subqueries might create temporary tables, Joins can be parallelized more easily, Join performance is more consistent,
Filter Data Early:
columns used in WHERE conditions are indexed to avoid full table scans.
Use EXISTS Instead of IN:
EXISTS is faster than IN because it stops as soon as a match is found
Optimize ORDER BY and GROUP BY:
Indexing the columns involved in ORDER BY or GROUP BY
Avoid Functions on Indexed Columns:
like UPPER(), YEAR()
Use Query Execution Plan:
identify bottlenecks like table scans, index scans, or missing indexes
Batch Operations:
Update Statistics:
Statistics(SQL Server generates them for indexed columns, Helps in creating efficient execution plans, Column statistics, Index statistics) tell SQL Server about the distribution of data
Parameterize Queries:
reuse execution plans
Partition Large Tables:

=================================================================================
Here’s a simple and concise comparison between **SQL Server** and **MongoDB**:

### 1. **Data Model**

- **SQL Server**:

  - **Relational** database.
  - Data is stored in **tables** with fixed **schemas** (rows and columns).
  - Uses **Structured Query Language (SQL)** to manage and query data.

- **MongoDB**:
  - **Document-oriented** NoSQL database.
  - Data is stored in **documents** (similar to JSON) with **dynamic schemas**.
  - Uses a flexible **query language** for retrieving documents.

---

### 2. **Schema**

- **SQL Server**:

  - Requires a **predefined schema** (structured) where all rows in a table follow the same structure.
  - Schema changes can be **rigid** and often require migrations.

- **MongoDB**:
  - **Schema-less** (unstructured), so documents in a collection can have different structures.
  - Schema flexibility allows easy data evolution without migrations.

---

### 3. **Scalability**

- **SQL Server**:

  - Primarily supports **vertical scaling** (adding more resources like CPU or memory to a single server).
  - Limited horizontal scaling (requires complex configurations like partitioning).

- **MongoDB**:
  - Designed for **horizontal scaling** through **sharding** (splitting data across multiple servers).
  - Excellent for handling **large datasets** and **distributed workloads**.

---

### 4. **Transactions**

- **SQL Server**:

  - **ACID-compliant** by default, ensuring strict data consistency across multiple tables and operations.
  - Ideal for applications where **data integrity** is crucial (e.g., banking systems).

- **MongoDB**:
  - **ACID transactions** are supported but were introduced later and apply mainly to **multi-document** operations.
  - Best suited for applications where flexibility and performance are more important than strict consistency.

---

### 5. **Query Language**

- **SQL Server**:

  - Uses **SQL**, a standard query language for querying and managing data with structured commands (`SELECT`, `INSERT`, `UPDATE`).

- **MongoDB**:
  - Uses a **document-based query language**.
  - Queries are written in a **JavaScript-like syntax** (`db.collection.find()`), which is more flexible for working with JSON-like data.

---

### 6. **Use Cases**

- **SQL Server**:

  - Best for **structured data** with well-defined relationships, such as banking systems, financial records, and ERP systems.

- **MongoDB**:
  - Best for **unstructured or semi-structured data**, like real-time analytics, content management systems, IoT data, or social media.

---

### 7. **Performance**

- **SQL Server**:

  - Optimized for **complex joins**, **transactions**, and operations requiring strict **data integrity**.
  - Handles **heavy read and write** workloads in structured environments.

- **MongoDB**:
  - Optimized for **high-performance** reads and writes on **large, distributed datasets**.
  - Suitable for **high-throughput** workloads, but may require careful tuning for consistency.

---

### 8. **Indexing**

- **SQL Server**:

  - Supports **B-tree indexes**, **clustered**, and **non-clustered indexes** for optimizing query performance.

- **MongoDB**:
  - Supports **indexes** on document fields (single or compound) and allows **text** and **geo-spatial** indexing.
  - Indexes can significantly speed up document retrieval.

---

### 9. **Backup and Recovery**

- **SQL Server**:

  - Offers robust built-in tools for **backup, restore, and recovery**, with options like **full**, **differential**, and **log backups**.
  - Point-in-time recovery is available with transaction logs.

- **MongoDB**:
  - **Backup and restore** processes are simpler, but advanced features like point-in-time recovery require additional setup (e.g., using **MongoDB Atlas**).
  - **Replica sets** provide **high availability** and redundancy.

---

In SQL Server, the aspects you're referring to—upgrades, object management, user management, backup/recovery, patching, monitoring, and data import/export—are all essential tasks for database administration (DBA). Here’s a brief overview of each:

1. **Upgrades**:

   - SQL Server upgrades can involve moving to a new version of SQL Server or applying service packs and cumulative updates. Microsoft provides tools like the **SQL Server Installation Center** to assist with this. Before upgrading, always back up your databases and ensure that all systems using the database will remain compatible.

2. **Object Management**:

   - Involves creating, modifying, and deleting database objects like tables, views, indexes, stored procedures, and functions. This is typically done via **SQL Server Management Studio (SSMS)** or through T-SQL commands like `CREATE`, `ALTER`, and `DROP`.

3. **User Management**:

   - SQL Server uses **Windows authentication** and **SQL Server authentication** to manage users. You can create users and assign roles or permissions using SSMS or T-SQL (`CREATE LOGIN`, `CREATE USER`, `GRANT`, etc.). SQL Server supports **role-based access control (RBAC)** for managing privileges.

4. **Backup and Recovery**:

   - Backups are crucial for data protection. SQL Server supports **full, differential, and transaction log backups**. Recovery can be performed using the **RESTORE DATABASE** command. SSMS provides a visual interface for configuring backups and setting automated backup schedules using **SQL Server Agent**.

5. **Patching**:

   - Patching is handled by installing **SQL Server service packs** and **cumulative updates (CU)**. You can check for updates via the **SQL Server Installation Center** or Microsoft’s download site. Apply patches during maintenance windows and ensure backups are taken before applying them.

6. **Monitoring**:

   - SQL Server provides several monitoring tools:
     - **SQL Server Profiler** and **Extended Events** for tracking and debugging SQL Server activity.
     - **SQL Server Performance Monitor** for monitoring performance metrics.
     - **Dynamic Management Views (DMVs)** to access real-time performance data.
     - **Activity Monitor** within SSMS for real-time resource usage and query performance.

7. **Data Import/Export**:
   - SQL Server supports several ways to import and export data:
     - **SQL Server Import and Export Wizard** allows quick import/export of data from/to various formats (Excel, CSV, etc.).
     - **bcp (Bulk Copy Program)** for bulk data transfers.
     - **SSIS (SQL Server Integration Services)** for complex ETL (Extract, Transform, Load) operations.
     - T-SQL commands like `BULK INSERT` and `OPENROWSET`.

---

Configuring and maintaining SQL Server database servers involves several tasks to ensure optimal performance, security, and availability. Below is a high-level overview of the key steps you need to take for effective SQL Server management:

### 1. **Initial Configuration of SQL Server**

- **Install SQL Server**: Use the **SQL Server Installation Center** to install SQL Server. During installation, specify the instance name, choose a collation, configure server authentication mode, and select feature sets (Database Engine, SSIS, SSRS, etc.).
- **Set Up Authentication**: Choose between **Windows Authentication** (recommended) or **SQL Server Authentication**. You can configure this in **Security** settings via SQL Server Management Studio (SSMS).

- **Configure Memory and CPU Settings**:

  - SQL Server automatically manages memory allocation, but you can adjust the **max server memory** setting if needed.
  - For CPU, you can manage CPU affinity and configure **Max Degree of Parallelism (MAXDOP)** to optimize parallel query execution.

- **Set Up Network Configuration**:
  - Use **SQL Server Configuration Manager** to enable or disable protocols like **TCP/IP** or **Named Pipes** and configure port numbers for remote access.

### 2. **Security Management**

- **Create Logins and Users**:
  - Use SSMS or T-SQL commands like `CREATE LOGIN`, `CREATE USER`, and `GRANT` to define users and roles.
- **Role-Based Security**:

  - Assign database-level roles like **db_owner**, **db_datareader**, **db_datawriter**, and **public** to control user permissions.
  - Use **Server roles** to define broader permissions like **sysadmin**, **dbcreator**, or **securityadmin**.

- **Implement Transparent Data Encryption (TDE)**:

  - Protect your database at rest using **TDE** by enabling it through a database encryption key and certificate.

- **Audit and Monitor Security Events**:
  - Use **SQL Server Audit** to track security events such as login attempts, permission changes, and data access.

### 3. **Backup and Recovery Configuration**

- **Automated Backups**:
  - Set up regular **full**, **differential**, and **transaction log** backups using **SQL Server Agent Jobs** or Maintenance Plans.
- **Backup to Disk or Cloud**:

  - SQL Server allows you to back up databases to local storage or integrate with cloud solutions like **Azure Blob Storage**.

- **Restore Strategies**:
  - Configure your recovery model (Full, Bulk-logged, or Simple) and use **RESTORE DATABASE** to recover from backups when necessary.

### 4. **Monitoring and Performance Tuning**

- **Set Up Monitoring Tools**:

  - Use **SQL Server Profiler** or **Extended Events** to track performance bottlenecks.
  - **Activity Monitor** and **Dynamic Management Views (DMVs)** help to monitor real-time performance and system health.

- **Index and Query Optimization**:

  - Regularly monitor and maintain indexes. Use **Database Tuning Advisor** to recommend index and query improvements.
  - Analyze query execution plans using SSMS or `SET SHOWPLAN_XML` to identify inefficiencies.

- **SQL Server Agent Alerts**:
  - Set up **SQL Server Agent** to send email or pager notifications based on performance thresholds or errors.

### 5. **Patching and Updating**

- **Apply Service Packs and Cumulative Updates**:
  - Regularly check for and apply service packs and cumulative updates to SQL Server.
  - Always back up your databases before applying patches and schedule patching during maintenance windows.

### 6. **Database Maintenance Tasks**

- **Rebuild or Reorganize Indexes**:
  - Use **DBCC DBREINDEX** or **ALTER INDEX** to rebuild or reorganize fragmented indexes periodically.
- **Update Statistics**:

  - Regularly update query statistics with `UPDATE STATISTICS` or enable automatic statistics updates for optimal query performance.

- **Integrity Checks**:
  - Use **DBCC CHECKDB** to check database consistency and integrity, and resolve any issues it flags.

### 7. **High Availability and Disaster Recovery (HA/DR)**

- **Always On Availability Groups**:

  - Configure **Always On Availability Groups** for high availability, allowing multiple replicas of your database across different SQL Servers.

- **Log Shipping**:

  - Use **log shipping** to maintain a warm standby server with continuous backup and restore of transaction logs.

- **Failover Clustering**:

  - Implement **SQL Server Failover Cluster Instances (FCI)** to ensure high availability at the server level.

- **Replication**:
  - Set up **transactional** or **merge replication** for data distribution across multiple servers.

### 8. **Data Import/Export Configuration**

- **Data Import/Export**:
  - Use **SQL Server Import and Export Wizard** to transfer data between SQL Server and various formats (Excel, CSV, XML).
- **Bulk Data Import**:
  - Utilize **BULK INSERT** or **SSIS (SQL Server Integration Services)** for handling large volumes of data efficiently.

### 9. **System Health Monitoring**

- **Set Up Baselines**:

  - Define performance baselines using DMVs and Performance Monitor to track the server’s normal operation and quickly spot deviations.

- **SQL Server Logs**:
  - Regularly check the **SQL Server Error Logs**, **Windows Event Viewer**, and **SQL Server Agent Logs** for any abnormal activities or errors.

### 10. **Scheduling Jobs with SQL Server Agent**

- **Automate Jobs**:
  - Use **SQL Server Agent** to automate regular maintenance tasks like backups, index defragmentation, or batch jobs.
- **Monitoring Job History**:
  - Keep track of scheduled jobs and review job history to ensure successful execution and timely troubleshooting of failures.

---

When running SQL Server in a **Windows Server environment**, integrating it with **Active Directory (AD)** adds powerful features for user management, authentication, and security. Here’s how SQL Server interacts with a Windows Server environment and how Active Directory enhances SQL Server management:

### 1. **Active Directory Integration with SQL Server**

Active Directory allows you to manage user access and authentication for SQL Server databases across a network of computers. SQL Server can leverage **Windows Authentication** through AD for centralized control of users and groups, making user management more secure and scalable.

- **Windows Authentication**:

  - SQL Server supports **Windows Authentication**, which means that users can connect to SQL Server using their **Active Directory** credentials. This method is preferred over SQL Server Authentication because it uses the Windows security model and avoids storing credentials in the SQL Server database.
  - When a user logs in, SQL Server checks the user’s AD credentials, and if the user is part of the appropriate AD group or has been granted individual permissions, access is allowed.

- **Active Directory Groups**:
  - Instead of creating individual SQL Server logins for each user, you can manage access by adding AD **Security Groups**. These groups can be granted access to databases and server-level roles, simplifying user management.
  - Example: Create an AD group called `SQLAdmins` and grant it **sysadmin** privileges in SQL Server. Now, any member of `SQLAdmins` will have those permissions without needing individual SQL logins.

### 2. **Configuring SQL Server in an Active Directory Environment**

To set up SQL Server to work with Active Directory in a Windows Server environment, follow these steps:

#### A. **Enable Windows Authentication Mode**

During SQL Server installation or afterward through SSMS:

1. Open **SQL Server Management Studio (SSMS)**.
2. Right-click the server name in Object Explorer and select **Properties**.
3. Under **Security**, choose **Windows Authentication mode** (or **Mixed Mode** if you need both Windows and SQL authentication).
4. Restart the SQL Server service for the changes to take effect.

#### B. **Granting Access to AD Users and Groups**

1. In **SSMS**, expand **Security** → **Logins**.
2. Right-click **Logins** and select **New Login**.
3. Click **Search** and search for the Active Directory user or group.
4. After selecting the user or group, assign roles and permissions as needed.

#### C. **Using Kerberos Authentication**

Kerberos is a network authentication protocol that provides more secure and efficient authentication compared to NTLM. For SQL Server in an AD environment, Kerberos can be automatically enabled with Windows Authentication. Ensure that:

- The SQL Server Service account is registered in AD as a **Service Principal Name (SPN)**.
- SQL Server and client machines are correctly configured to use Kerberos authentication for SQL Server connections.

### 3. **SQL Server Service Accounts in Active Directory**

- **Domain Service Accounts**:

  - SQL Server services such as the **SQL Server Database Engine** and **SQL Server Agent** can run under a **domain user account**. By using a domain account, you can allow the SQL Server service to interact with network resources (e.g., shared drives, other servers) more securely.
  - You can configure SQL Server to run under a specific AD service account during installation or afterward via **SQL Server Configuration Manager**.

- **Managed Service Accounts (MSAs)**:
  - Windows Server supports **Managed Service Accounts** (MSAs) that automatically handle password changes and allow secure authentication. MSAs can be used for SQL Server services to reduce administrative overhead.
  - Example: Create an MSA in Active Directory, assign it to SQL Server services, and allow it to handle network permissions.

### 4. **SQL Server Security and Group Policies**

- **Group Policy Objects (GPOs)**:

  - In a Windows Server environment, Group Policies can enforce security settings across servers, including those running SQL Server. GPOs can ensure that SQL Server configurations comply with your organization’s security standards.
  - Example: A GPO can enforce password policies, firewall settings, and encryption standards for all SQL Server instances.

- **Encryption Policies**:
  - If your organization requires encrypted connections to SQL Server, you can configure **SSL/TLS encryption** and enforce it through Group Policies.
  - SQL Server can also work with **Windows BitLocker** or **Encrypting File System (EFS)**, both managed by Group Policy, to encrypt database files at the file system level.

### 5. **Backup and Recovery Using Active Directory**

- **Backing Up to Network Shares**:

  - When SQL Server is integrated with AD, you can back up databases to network shares or drives using domain accounts with the proper permissions.
  - Example: The SQL Server service account should have read/write access to the network location where backups are stored.

- **Disaster Recovery Planning**:
  - For disaster recovery, SQL Server instances can participate in **Active Directory Domain Services (AD DS)** replication to restore Active Directory-integrated services in case of failure.

### 6. **Monitoring and Auditing SQL Server in a Windows Server Environment**

- **Event Logs**:
  - SQL Server logs critical events (e.g., failed login attempts, backups, job failures) in the **Windows Event Log**. You can use Windows Server tools or third-party software to monitor these logs.
- **Auditing with AD and SQL Server**:
  - SQL Server’s **Audit** feature can track database actions and write audit logs to the Windows **Security Event Log** or file-based storage. These can be monitored and managed centrally through AD policies or third-party tools.
  - Use **SQL Server Extended Events** or **SQL Server Profiler** for deeper, real-time auditing of user activities.

### 7. **High Availability and Active Directory**

In an AD-integrated environment, high availability (HA) features such as **Always On Availability Groups** and **Failover Cluster Instances (FCI)** benefit from AD:

- **SQL Server Always On Availability Groups**:

  - Uses AD for managing cluster nodes and ensuring that all replicas of your databases are synchronized.
  - Active Directory Domain Services (AD DS) provides the failover mechanism for Always On Availability Groups.

- **Failover Cluster Instances (FCI)**:
  - SQL Server FCIs use **Windows Server Failover Clustering (WSFC)**, which integrates closely with AD for managing cluster nodes and service accounts.

### 8. **Using Active Directory for SQL Server Authentication and Authorization**

- **Cross-Forest Authentication**:

  - If your environment spans multiple AD forests, SQL Server can authenticate users from different forests through **Active Directory Trusts**. Ensure that the necessary trusts and permissions are configured in AD.

- **Authorization**:
  - SQL Server can use AD **Group Policies** to enforce password complexity, lockout policies, and other security settings for SQL Server users and administrators.

---

Here are the main **High Availability (HA)** and **Disaster Recovery (DR)** options for SQL Server, explained simply and concisely:

### 1. **Always On Availability Groups**

- **HA and DR** solution that allows you to group multiple databases and replicate them to secondary servers (replicas).
- Supports **automatic failover** (HA) and **manual failover** (DR) between servers.
- Can have **up to 8 secondary replicas**, some for **read-only** workloads, improving performance.
- Requires **Windows Server Failover Clustering (WSFC)**.

### 2. **SQL Server Failover Cluster Instances (FCI)**

- **HA solution** where multiple servers (nodes) share the same database storage.
- If one server fails, another server in the cluster takes over automatically (failover).
- Suitable for protecting against **hardware failures** but requires shared storage, so not ideal for DR.

### 3. **Log Shipping**

- **DR solution** that regularly sends transaction log backups from the primary server to one or more secondary servers.
- You can manually restore these backups in case of failure.
- **No automatic failover**, but it's simple to set up and provides **cheap disaster recovery**.
- Secondary servers can be located far away (good for DR), but **there's some data delay**.

### 4. **Database Mirroring** (Deprecated but still used)

- **HA and DR** solution that maintains two copies of a database—**primary** and **mirror**—on different servers.
- Offers **automatic failover** in **high-safety mode** with a witness server.
- Limited to **one mirror** and supports **synchronous** (zero data loss) and **asynchronous** mirroring.

### 5. **Replication**

- Primarily for **data distribution**, but can be used for **HA/DR**.
- Copies data from a **publisher** database to one or more **subscriber** databases.
- Suitable for scenarios where **some data delay** or **data filtering** is acceptable, but it doesn’t offer built-in failover.

---

Here are key **Performance Tuning and Optimization (PTO)** tools and techniques in SQL Server, explained simply and concisely:

### 1. **Execution Plans**

- **Execution plans** show how SQL Server processes queries, revealing inefficiencies like **table scans** (which are slow) and **missing indexes**.
- Use **SSMS** to view actual or estimated plans by running queries with `CTRL + L` (estimated) or `CTRL + M` (actual).
- Key for understanding query performance bottlenecks.

### 2. **Dynamic Management Views (DMVs)**

- DMVs provide real-time insights into system health, query performance, and resource usage.
- Examples:
  - **sys.dm_exec_query_stats**: Shows execution statistics for cached queries.
  - **sys.dm_os_wait_stats**: Displays resource wait times that can reveal bottlenecks.
- Use DMVs to track query performance over time.

### 3. **Index Tuning**

- Proper **indexing** improves query performance by speeding up data retrieval.
- Use **Database Engine Tuning Advisor (DTA)** to analyze workloads and suggest optimal indexes.
- Regularly **rebuild** or **reorganize** fragmented indexes using the **ALTER INDEX** command.

### 4. **Statistics**

- SQL Server uses **statistics** to estimate data distribution for query optimization.
- Keep statistics up to date using `UPDATE STATISTICS` or allow SQL Server to update them automatically.
- Outdated stats can lead to poor query performance.

### 5. **Query Store**

- **Query Store** tracks query performance over time, storing execution plans and query runtime statistics.
- Helps identify **regression** (queries that get slower over time) and optimize frequently used queries.
- Use Query Store for long-term performance monitoring.

### 6. **SQL Profiler / Extended Events**

- **SQL Server Profiler** (older tool) and **Extended Events** (newer tool) are used to trace and monitor real-time query activity.
- Useful for capturing slow-running queries or identifying deadlocks.
- Extended Events is lighter and better for **high-performance** environments.

### 7. **Performance Monitor (PerfMon)**

- Windows tool that tracks system resource usage (CPU, memory, disk I/O) for SQL Server processes.
- Use PerfMon to spot hardware bottlenecks that affect SQL Server performance, such as CPU overload or memory pressure.

### 8. **Wait Statistics**

- Wait statistics show what SQL Server is waiting on when executing queries (e.g., CPU, disk I/O).
- Key for diagnosing performance bottlenecks; use **sys.dm_os_wait_stats** to monitor.
- Common waits include **CXPACKET** (parallelism issues) and **PAGEIOLATCH** (disk I/O problems).

### 9. **TempDB Optimization**

- **TempDB** is a system database that SQL Server uses for temporary objects. Poorly configured TempDB can cause performance issues.
- Key optimizations include setting multiple **TempDB data files** and ensuring fast disk access.

### 10. **In-Memory OLTP (Hekaton)**

- **In-Memory OLTP** allows specific tables to be stored entirely in memory for faster data access.
- Useful for **high-throughput** and **low-latency** scenarios but requires proper application design to benefit from it.

### 11. **Resource Governor**

- **Resource Governor** allows you to allocate and control SQL Server resource usage (CPU, memory) across different workloads.
- Prevents a single query or workload from consuming all resources.

---

Here are the key concepts of **database security**, **backup**, **recovery**, and **performance monitoring** in SQL Server, explained simply:

### 1. **Database Security**

- **Authentication**:

  - SQL Server supports **Windows Authentication** (integrated with Active Directory) and **SQL Server Authentication** (login/password).
  - Windows Authentication is more secure because it relies on domain credentials.

- **Authorization**:

  - **Roles and permissions** control access to databases and objects.
  - Users are assigned to roles like **db_owner** (full control) or **db_datareader** (read-only access).

- **Encryption**:

  - SQL Server supports **Transparent Data Encryption (TDE)** to encrypt data at rest.
  - **Always Encrypted** protects sensitive data (e.g., credit card numbers) in transit and at rest, so even DBAs can’t see it.

- **Auditing**:
  - SQL Server **Audit** allows tracking of database actions (e.g., logins, data changes) to ensure security compliance.
  - Use SQL Audit to log critical actions for review.

---

### 2. **Backup**

- **Full Backup**:

  - A **complete copy** of the entire database. It’s the foundation for any recovery strategy.

- **Differential Backup**:

  - Backs up only the data that has changed since the **last full backup**. Faster than full backups but requires the last full backup to restore.

- **Transaction Log Backup**:

  - Captures changes in the **transaction log** since the last log backup. Essential for **point-in-time recovery**.
  - Often used in high-availability environments to keep secondary copies up-to-date.

- **Backup Strategies**:
  - Combine full, differential, and log backups based on how critical the database is and how frequently data changes.
  - Example: Perform a full backup weekly, differential daily, and log backups every 15 minutes.

---

### 3. **Recovery**

- **Restore**:

  - To recover a database, you restore a **full backup** first, then any **differential** and **log backups**.

- **Point-in-Time Recovery**:

  - Allows you to recover the database to a specific time, using **log backups**. Useful in case of accidental data deletion.

- **Recovery Models**:
  - **Full Recovery Model**: Logs every transaction, allowing point-in-time recovery, but requires transaction log backups.
  - **Simple Recovery Model**: Logs minimal changes, faster but no point-in-time recovery.
  - **Bulk-Logged Recovery Model**: Optimizes bulk operations (e.g., bulk inserts), but with limited recovery options.

---

### 4. **Performance Monitoring**

- **SQL Server Profiler / Extended Events**:

  - **SQL Profiler** (old) and **Extended Events** (newer) capture real-time query activity for performance analysis.

- **Performance Monitor (PerfMon)**:

  - Tracks system resources (CPU, memory, disk I/O) used by SQL Server processes.
  - Monitor counters like **Processor Time**, **Memory Usage**, and **Disk Queue Length**.

- **Dynamic Management Views (DMVs)**:

  - **DMVs** provide live data on server health, queries, and resource usage.
  - Example: **sys.dm_exec_query_stats** gives stats on query performance.

- **Wait Statistics**: - Tracks what SQL Server is waiting on (e.g., CPU, disk I/O) during query execution. - Use wait stats to diagnose bottlenecks like **PAGEIOLATCH** (disk I/O) or **CXPACKET** (parallelism).
  ----------------------------------------------------------------------------- - Small index size
- Cons:
  - Complex client
  - Transacation across shards
  - Rollbacks
  - Schema changes
  - Joins
- In Real life last thing to do is sharding
- Redis creates inconsistency
- Replication --> master slave Reverse proxy
- Logic in Client

### Replication

- write on master and read from slaves
- Asynchronous and Synchronous Replication
- Horizontal Scaling
- Eventual Consistency

# Postgresql Course:

- Design Process:
  - what kind of thing are we storing
  - what kind of properties this thing have
  - what type of data does each of those properties contain.
-


---

MongoDB:
relations: Embedded Documents (Denormalization), Referencing (Normalization), Manual Joins(Aggregation Framework)
Here are the **basics of MongoDB**, explained simply and concisely:

### 1. **Document-Oriented Database**

- **MongoDB** is a **NoSQL** database that stores data in **documents** (like JSON) instead of rows and columns.
- Each document is a set of **key-value pairs**, and documents with similar structures are grouped into **collections**.

---

### 2. **Schema Flexibility**

- MongoDB is **schema-less**, meaning documents in the same collection don’t have to follow a strict structure.
- You can have fields that vary between documents, which allows **flexibility** in how data is stored and updated.

---

### 3. **Basic Data Types**

- MongoDB supports common data types like **strings**, **numbers**, **arrays**, **dates**, and **objects**.
- It also allows embedding documents within documents, which is useful for **nested data**.

---

### 4. **CRUD Operations**

- **Create**: Add a document to a collection using the `insertOne()` or `insertMany()` commands.
- **Read**: Retrieve data with `find()`. Use queries to filter and project specific fields.
- **Update**: Modify documents with `updateOne()`, `updateMany()`, or `replaceOne()`.
- **Delete**: Remove documents using `deleteOne()` or `deleteMany()`.

---

### 5. **Indexing**

- **Indexes** in MongoDB improve query performance by speeding up searches on specific fields.
- Use the `createIndex()` command to create indexes, but be mindful that **too many indexes can slow down writes**.

---

### 6. **Replication**

- MongoDB uses **replica sets** to provide **high availability**.
- A replica set is a group of MongoDB instances with one **primary** node that handles writes, and **secondary** nodes that replicate data from the primary for **failover** in case the primary goes down.

---

### 7. **Sharding**

- **Sharding** is MongoDB’s method for scaling horizontally across multiple servers by splitting data into smaller chunks (shards).
- This enables MongoDB to handle **large datasets** and **high traffic**.

---

### 8. **Aggregation Framework**

- The **aggregation framework** allows complex data processing operations like filtering, grouping, and transforming data.
- Common stages include `$match` (filtering), `$group` (grouping data), and `$project` (reshaping data).

---

### 9. **ACID Transactions**

- **MongoDB** supports **multi-document ACID transactions**, ensuring that a group of operations either all succeed or all fail.
- This is critical for scenarios where **data consistency** across multiple documents is required.

---

### 10. **Security**

- MongoDB provides security features like **authentication**, **authorization** (role-based access control), and **encryption** (TLS for data in transit, encryption at rest).
- Use **MongoDB Atlas** for cloud-hosted MongoDB instances with built-in security and monitoring.