+++
title = "12 Testing-BigData"
description = ""
weight = 2

+++

**What is Big Data Testing?**

BigData testing is defined as testing of Bigdata applications. Big data is a collection of large datasets that cannot be processed using traditional computing techniques.[ Testing ](https://www.guru99.com/software-testing.html)of these datasets involves various tools, techniques, and frameworks to process. Big data relates to data creation, storage, retrieval and analysis that is remarkable in terms of volume, variety, and velocity. You can learn more about Big Data, Hadoop and MapReduce [here](https://www.guru99.com/bigdata-tutorials.html)

In this tutorial, you will learn-

- [Big Data Testing Strategy](https://www.guru99.com/big-data-testing-functional-performance.html#1)
- [How to test Hadoop Applications](https://www.guru99.com/big-data-testing-functional-performance.html#2)
- [Architecture Testing](https://www.guru99.com/big-data-testing-functional-performance.html#6)
- [Performance Testing](https://www.guru99.com/big-data-testing-functional-performance.html#7)
- [Performance Testing Approach](https://www.guru99.com/big-data-testing-functional-performance.html#8)
- [Parameters for Performance Testing](https://www.guru99.com/big-data-testing-functional-performance.html#9)
- [Test Environment Needs](https://www.guru99.com/big-data-testing-functional-performance.html#10)
- [Big data Testing Vs. Traditional database Testing](https://www.guru99.com/big-data-testing-functional-performance.html#11)
- [Tools used in Big Data Scenarios](https://www.guru99.com/big-data-testing-functional-performance.html#12)
- [Challenges in Big Data Testing](https://www.guru99.com/big-data-testing-functional-performance.html#13)

**Big Data Testing Strategy**

Testing Big Data application is more verification of its data processing rather than testing the individual features of the software product. When it comes to Big data testing, **performance and functional testing** are the keys.

In Big data testing, QA engineers verify the successful processing of terabytes of data using commodity cluster and other supportive components. It demands a high level of testing skills as the processing is very fast. Processing may be of three types

![img](https://www.guru99.com/images/6-2015/060315_1205_BigDataTest1.png)

Along with this, data quality is also an important factor in Hadoop testing. Before testing the application, it is necessary to check the quality of data and should be considered as a part of database testing. **It involves checking various characteristics like conformity, accuracy, duplication, consistency, validity, data completeness,** etc.

**How to test Hadoop Applications**

The following figure gives a high-level overview of phases in Testing Big Data Applications

![img](https://www.guru99.com/images/6-2015/060315_1205_BigDataTest2.png)

Big Data Testing can be broadly divided into three steps

**Step 1: Data Staging Validation**

The first step of big data testing also referred as pre-Hadoop stage involves process validation.

- Data from various source like RDBMS, weblogs, social media, etc. should be validated to make sure that correct data is pulled into the system
- Comparing source data with the data pushed into the Hadoop system to make sure they match
- Verify the right data is extracted and loaded into the correct HDFS location

Tools like [**Talend**](https://www.talend.com/)**,** [**Datameer**](http://www.datameer.com/)**,** can be used for data staging validation

**Step 2: "MapReduce" Validation**

The second step is a validation of "MapReduce". In this stage, the tester verifies the business logic validation on every node and then validating them after running against multiple nodes, ensuring that the

- Map Reduce process works correctly
- Data aggregation or segregation rules are implemented on the data
- Key value pairs are generated
- Validating the data after the Map-Reduce process

**Step 3: Output Validation Phase**

The final or third stage of Big Data testing is the output validation process. The output data files are generated and ready to be moved to an EDW (Enterprise Data Warehouse) or any other system based on the requirement.

Activities in the third stage include

- To check the transformation rules are correctly applied
- To check the data integrity and successful data load into the target system
- To check that there is no data corruption by comparing the target data with the HDFS file system data

**Architecture Testing**

Hadoop processes very large volumes of data and is highly resource intensive. Hence, architectural testing is crucial to ensure the success of your Big Data project. A poorly or improper designed system may lead to performance degradation, and the system could fail to meet the requirement. At least, **Performance and Failover test** services should be done in a Hadoop environment.

Performance testing includes testing of job completion time, memory utilization, data throughput, and similar system metrics. While the motive of Failover test service is to verify that data processing occurs seamlessly in case of failure of data nodes

**Performance Testing**

Performance Testing for Big Data includes two main action

- **Data ingestion and Throughout**: In this stage, the tester verifies how the fast system can consume data from various data source. Testing involves identifying a different message that the queue can process in a given time frame. It also includes how quickly data can be inserted into the underlying data store for example insertion rate into a Mongo and Cassandra database.
- **Data Processing**: It involves verifying the speed with which the queries or map reduce jobs are executed. It also includes testing the data processing in isolation when the underlying data store is populated within the data sets. For example, running Map Reduce jobs on the underlying HDFS
- **Sub-Component Performance**: These systems are made up of multiple components, and it is essential to test each of these components in isolation. For example, how quickly the message is indexed and consumed, MapReduce jobs, query performance, search, etc.

**Performance Testing Approach**

Performance testing for big data application involves testing of huge volumes of structured and unstructured data, and it requires a specific testing approach to test such massive data.

![img](https://www.guru99.com/images/6-2015/060315_1205_BigDataTest3.png)

Performance Testing is executed in this order

1. The process begins with the setting of the Big data cluster which is to be tested for performance
2. Identify and design corresponding workloads
3. Prepare individual clients (Custom Scripts are created)
4. Execute the test and analyzes the result (If objectives are not met then tune the component and re-execute)
5. Optimum Configuration

**Parameters for Performance Testing**

Various parameters to be verified for performance testing are

- Data Storage: How data is stored in different nodes
- Commit logs: How large the commit log is allowed to grow
- Concurrency: How many threads can perform write and read operation
- Caching: Tune the cache setting "row cache" and "key cache."
- Timeouts: Values for connection timeout, query timeout, etc.
- JVM Parameters: Heap size, GC collection algorithms, etc.
- Map reduce performance: Sorts, merge, etc.
- Message queue: Message rate, size, etc.

**Test Environment Needs**

Test Environment needs to depend on the type of application you are testing. For Big data testing, the test environment should encompass

- It should have enough space for storage and process a large amount of data
- It should have a cluster with distributed nodes and data
- It should have minimum CPU and memory utilization to keep performance high

**Big data Testing Vs. Traditional database Testing**

| **Properties**       | **Traditional database testing**                             | **Big data testing**                                         |
| -------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Data**             | Tester work with structured data                             | Tester works with both structured as well as unstructured data |
|                      | Testing approach is well defined and time-tested             | The testing approach requires focused R&D efforts            |
|                      | Tester has the option of "Sampling" strategy doing manually or "Exhaustive Verification" strategy by the automation tool | "Sampling" strategy in Big data is a challenge               |
| **Infrastructure**   | It does not require a special test environment as the file size is limited | It requires a special test environment due to large data size and files (HDFS) |
| **Validation Tools** | Tester uses either the Excel-based [macros](https://www.guru99.com/introduction-to-macros-in-excel.html) or UI based automation tools | No defined tools, the range is vast from programming tools like MapReduce to HIVEQL |
|                      | Testing Tools can be used with basic operating knowledge and less training. | It requires a specific set of skills and training to operate a testing tool. Also, the tools are in their nascent stage and over time it may come up with new features. |

**Tools used in Big Data Scenarios**

| **Big Data Cluster** | **Big Data Tools**                                           |
| -------------------- | ------------------------------------------------------------ |
| **NoSQL:**           | CouchDB, DatabasesMongoDB, Cassandra, Redis, ZooKeeper, HBase |
| **MapReduce:**       | Hadoop, Hive, Pig, Cascading, Oozie, Kafka, S4, MapR, Flume  |
| **Storage:**         | S3, HDFS ( Hadoop Distributed File System)                   |
| **Servers:**         | Elastic, Heroku, Elastic, Google App Engine, EC2             |
| **Processing**       | R, Yahoo! Pipes, Mechanical Turk, BigSheets, Datameer        |

**Challenges in Big Data Testing**

- **Automation**

Automation testing for Big data requires someone with technical expertise. Also, automated tools are not equipped to handle unexpected problems that arise during testing

- **Virtualization**

It is one of the integral phases of testing. Virtual machine latency creates timing problems in real time big data testing. Also managing images in Big data is a hassle.

- **Large Dataset**

- - Need to verify more data and need to do it faster
  - Need to automate the testing effort
  - Need to be able to test across different platform

**Performance testing challenges**

- **Diverse set of technologies**: Each sub-component belongs to different technology and requires testing in isolation
- **Unavailability of specific tools**: No single tool can perform the end-to-end testing. For example, NoSQL might not fit for message queues
- **Test Scripting**: A high degree of scripting is needed to design test scenarios and test cases
- **Test environment**: It needs a special test environment due to the large data size
- **Monitoring Solution**: Limited solutions exists that can monitor the entire environment
- **Diagnostic Solution**: a Custom solution is required to develop to drill down the performance bottleneck areas

**Summary**

- As data engineering and data analytics advances to a next level, Big data testing is inevitable.
- Big data processing could be Batch, Real-Time, or Interactive
- 3 stages of Testing Big Data applications are

- - Data staging validation
  - "MapReduce" validation
  - Output validation phase

- Architecture Testing is the important phase of Big data testing, as poorly designed system may lead to unprecedented errors and degradation of performance
- Performance testing for Big data includes verifying

- - Data throughput
  - Data processing
  - Sub-component performance

- Big data testing is very different from Traditional data testing in terms of Data, Infrastructure & Validation Tools

- Big Data Testing challenges include virtualization, test automation and dealing with large dataset. Performance testing of Big Data applications is also an issue.

  

## 13 FAQ 

[13 FAQ]({{%relref "13-Faq.md"%}})

