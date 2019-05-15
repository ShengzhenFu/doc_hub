+++
title = "02 Hadoop-introduction"
description = ""
weight = 2

+++

## **What is Hadoop?**

Apache Hadoop is an open source software framework used to develop data processing applications which are executed in a distributed computing environment.

 Applications built using HADOOP are run on large data sets distributed across clusters of commodity computers. Commodity computers are cheap and widely available. These are mainly useful for achieving greater computational power at low cost.

Similar to data residing in a local file system of a personal computer system, in Hadoop, data resides in a distributed file system which is called as a **Hadoop Distributed File system**. The processing model is based on **'Data Locality'** concept wherein computational logic is sent to cluster nodes(server) containing data. This computational logic is nothing, but a compiled version of a program written in a high-level language such as Java. Such a program, processes data stored in Hadoop HDFS.

***Do you know?*** Computer cluster consists of a set of multiple processing units (storage disk + processor) which are connected to each other and acts as a single system.

In this tutorial, you will learn,

- [Hadoop EcoSystem and Components](https://www.guru99.com/learn-hadoop-in-10-minutes.html#1)
- [Hadoop Architecture](https://www.guru99.com/learn-hadoop-in-10-minutes.html#4)
- [Features Of 'Hadoop'](https://www.guru99.com/learn-hadoop-in-10-minutes.html#2)
- [Network Topology In Hadoop](https://www.guru99.com/learn-hadoop-in-10-minutes.html#3)

## **Hadoop EcoSystem and Components**

Below diagram shows various components in the Hadoop ecosystem-

![img](https://www.guru99.com/images/Big_Data/061114_0803_LearnHadoop4.png)

Apache Hadoop consists of two sub-projects –

1. **Hadoop MapReduce:** MapReduce is a computational model and software framework for writing applications which are run on Hadoop. These MapReduce programs are capable of processing enormous data in parallel on large clusters of computation nodes.
2. **HDFS** (**Hadoop Distributed File System**): HDFS takes care of the storage part of Hadoop applications. MapReduce applications consume data from HDFS. HDFS creates multiple replicas of data blocks and distributes them on compute nodes in a cluster. This distribution enables reliable and extremely rapid computations.

Although Hadoop is best known for MapReduce and its distributed file system- HDFS, the term is also used for a family of related projects that fall under the umbrella of distributed computing and large-scale data processing. Other Hadoop-related projects at[ Apache ](https://www.guru99.com/apache.html)include are **Hive, HBase, Mahout, Sqoop, Flume, and ZooKeeper.**

**Hadoop Architecture**

![img](https://www.guru99.com/images/1/hadoop-architecture.png)

High Level Hadoop Architecture

Hadoop has a Master-Slave Architecture for data storage and distributed data processing using MapReduce and HDFS methods.

**NameNode:**

NameNode represented every files and directory which is used in the namespace

**DataNode:**

DataNode helps you to manage the state of an HDFS node and allows you to interacts with the blocks

**MasterNode:**

The master node allows you to conduct parallel processing of data using Hadoop MapReduce.

**Slave node:**

The slave nodes are the additional machines in the Hadoop cluster which allows you to store data to conduct complex calculations. Moreover, all the slave node comes with Task Tracker and a DataNode. This allows you to synchronize the processes with the NameNode and Job Tracker respectively.

In Hadoop, master or slave system can be set up in the cloud or on-premise

**Features Of 'Hadoop'**

**• Suitable for Big Data Analysis**

As Big Data tends to be distributed and unstructured in nature, HADOOP clusters are best suited for analysis of Big Data. Since it is processing logic (not the actual data) that flows to the computing nodes, less network bandwidth is consumed. This concept is called as **data locality concept** which helps increase the efficiency of Hadoop based applications.

**• Scalability**

HADOOP clusters can easily be scaled to any extent by adding additional cluster nodes and thus allows for the growth of Big Data. Also, scaling does not require modifications to application logic.

**• Fault Tolerance**

HADOOP ecosystem has a provision to replicate the input data on to other cluster nodes. That way, in the event of a cluster node failure, data processing can still proceed by using data stored on another cluster node.

## **Network Topology In Hadoop**

Topology (Arrangment) of the network, affects the performance of the Hadoop cluster when the size of the Hadoop cluster grows. In addition to the performance, one also needs to care about the high availability and handling of failures. In order to achieve this Hadoop, cluster formation makes use of network topology.

![img](https://www.guru99.com/images/Big_Data/061114_0803_LearnHadoop13.jpg)

Typically, network bandwidth is an important factor to consider while forming any network. However, as measuring bandwidth could be difficult, in Hadoop, a network is represented as a tree and distance between nodes of this tree (number of hops) is considered as an important factor in the formation of Hadoop cluster. Here, the distance between two nodes is equal to sum of their distance to their closest common ancestor.

Hadoop cluster consists of a data center, the rack and the node which actually executes jobs. Here, data center consists of racks and rack consists of nodes. Network bandwidth available to processes varies depending upon the location of the processes. That is, the bandwidth available becomes lesser as we go away from-

- Processes on the same node
- Different nodes on the same rack
- Nodes on different racks of the same data center
- Nodes in different data centers



## 03 Hadoop Installation

[03 Hadoop Installation]({{%relref "03-Hadoop-on-Ubuntu.md"%}})

