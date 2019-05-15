+++
title = "08 SQOOP"
description = ""
weight = 2

+++

**What is SQOOP in Hadoop?**

Apache **Sqoop** (**SQL-to-Hadoop**) is designed to support bulk import of data into HDFS from structured data stores such as relational databases, enterprise data warehouses, and NoSQL systems. Sqoop is based upon a connector architecture which supports plugins to provide connectivity to new external systems.

An example use case of Sqoop is an enterprise that runs a nightly Sqoop import to load the day's data from a production transactional RDBMS into a[ Hive ](https://www.guru99.com/hive-tutorials.html)data warehouse for further analysis.

**Sqoop Architecture**

All the existing **Database Management Systems** are designed with[ SQL ](https://www.guru99.com/sql.html)standard in mind. However, each DBMS differs with respect to dialect to some extent. So, this difference poses challenges when it comes to data transfers across the systems. Sqoop Connectors are components which help overcome these challenges.

Data transfer between Sqoop and external storage system is made possible with the help of Sqoop's connectors.

Sqoop has connectors for working with a range of popular relational databases, including MySQL, PostgreSQL, Oracle, SQL Server, and DB2. Each of these connectors knows how to interact with its associated DBMS. There is also a generic JDBC connector for connecting to any database that supports Java's JDBC protocol. In addition, Sqoop provides optimized MySQL and PostgreSQL connectors that use database-specific APIs to perform bulk transfers efficiently.

![img](https://www.guru99.com/images/Big_Data/061114_1038_Introductio1.png)

Sqoop Architecture

In addition to this, Sqoop has various third-party connectors for data stores,

ranging from enterprise data warehouses (including Netezza, Teradata, and Oracle) to NoSQL stores (such as Couchbase). However, these connectors do not come with Sqoop bundle; those need to be downloaded separately and can be added easily to an existing Sqoop installation.

**Why do we need Sqoop?**

Analytical processing using Hadoop requires loading of huge amounts of data from diverse sources into Hadoop clusters. This process of bulk data load into Hadoop, from heterogeneous sources and then processing it, comes with a certain set of challenges. Maintaining and ensuring data consistency and ensuring efficient utilization of resources, are some factors to consider before selecting the right approach for data load.

**Major Issues:**

**1. Data load using Scripts**

The traditional approach of using scripts to load data is not suitable for bulk data load into Hadoop; this approach is inefficient and very time-consuming.

**2. Direct access to external data via Map-Reduce application**

Providing direct access to the data residing at external systems(without loading into Hadoop) for map-reduce applications complicates these applications. So, this approach is not feasible.

\3. In addition to having the ability to work with enormous data, Hadoop can work with data in several different forms. So, to load such heterogeneous data into Hadoop, different tools have been developed. **Sqoop** and **Flume** are two such data loading tools.

**Sqoop vs Flume vs HDFS in Hadoop**

| **Sqoop**                                                    | **Flume**                                                    | **HDFS**                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Sqoop is used for importing data from structured data sources such as RDBMS. | Flume is used for moving bulk streaming data into HDFS.      | HDFS is a distributed file system used by Hadoop ecosystem to store data. |
| Sqoop has a connector based architecture. Connectors know how to connect to the respective data source and fetch the data. | Flume has an agent-based architecture. Here, a code is written (which is called as 'agent') which takes care of fetching data. | HDFS has a distributed architecture where data is distributed across multiple data nodes. |
| HDFS is a destination for data import using Sqoop.           | Data flows to HDFS through zero or more channels.            | HDFS is an ultimate destination for data storage.            |
| Sqoop data load is not event-driven.                         | Flume data load can be driven by an event.                   | HDFS just stores data provided to it by whatsoever means.    |
| In order to import data from structured data sources, one has to use Sqoop only, because its connectors know how to interact with structured data sources and fetch data from them. | In order to load streaming data such as tweets generated on Twitter or log files of a web server, Flume should be used. Flume agents are built for fetching streaming data. | HDFS has its own built-in shell commands to store data into it. HDFS cannot import streaming data |

 

## 09 Flume

[09 Flume]({{%relref "09-Flume.md"%}})

