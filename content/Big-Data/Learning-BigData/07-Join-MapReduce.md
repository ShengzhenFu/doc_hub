+++
title = "07 Join-MapReduce"
description = ""
weight = 2

+++

**What is a Join in MapReduce?**

A join operation is used to combine two large datasets in MapReduce. However, this process involves writing lots of code to perform the actual join operation.

Joining of two datasets begins by comparing the size of each dataset. If one dataset is smaller as compared to the other dataset then smaller dataset is distributed to every data node in the cluster. Once it is distributed, either Mapper or Reducer uses the smaller dataset to perform a lookup for matching records from the large dataset and then combine those records to form output records.

In this tutorial, you will learn-

- [What is a Join in MapReduce?](https://www.guru99.com/introduction-to-counters-joins-in-map-reduce.html#1)
- [Types of Join](https://www.guru99.com/introduction-to-counters-joins-in-map-reduce.html#2)
- [How to Join two DataSets: MapReduce Example](https://www.guru99.com/introduction-to-counters-joins-in-map-reduce.html#3)
- [What is Counter in MapReduce?](https://www.guru99.com/introduction-to-counters-joins-in-map-reduce.html#4)
- [Types of MapReduce Counters](https://www.guru99.com/introduction-to-counters-joins-in-map-reduce.html#5)
- [Counters Example](https://www.guru99.com/introduction-to-counters-joins-in-map-reduce.html#6)

**Types of Join**

Depending upon the place where the actual join is performed, this join is classified into-

**1. Map-side join -** When the join is performed by the mapper, it is called as map-side join. In this type, the join is performed before data is actually consumed by the map function. It is mandatory that the input to each map is in the form of a partition and is in sorted order. Also, there must be an equal number of partitions and it must be sorted by the join key.

**2. Reduce-side join -** When the join is performed by the reducer, it is called as reduce-side join. There is no necessity in this join to have a dataset in a structured form (or partitioned).

Here, map side processing emits join key and corresponding tuples of both the tables. As an effect of this processing, all the tuples with same join key fall into the same reducer which then joins the records with same join key.

An overall process flow is depicted in below diagram.

![img](https://www.guru99.com/images/Big_Data/061114_1003_Introductio1.png)

**How to Join two DataSets: MapReduce Example**

There are two Sets of Data in two Different Files (shown below). The Key Dept_ID is common in both files. The goal is to use MapReduce Join to combine these files

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa1.png)

File 1

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa2.png)

File 2

**Input:** The input data set is a txt file, **DeptName.txt & DepStrength.txt**

[**Download Input Files From Here**](https://drive.google.com/uc?export=download&id=0B_rQGHfXD8ltdUdCS3gzR1RKNFE)

Ensure you have Hadoop installed. Before you start with the actual process, change user to 'hduser' (id used while Hadoop configuration, you can switch to the userid used during your Hadoop config ).

su - hduser_

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa3.png)

**Step 1)** Copy the zip file to the location of your choice

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa4.png)

**Step 2)** Uncompress the Zip File

sudo tar -xvf MapReduceJoin.tar.gz

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa5.png)

**Step 3)** Go to directory MapReduceJoin/

cd MapReduceJoin/

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa6.png)

**Step 4)** Start Hadoop

$HADOOP_HOME/sbin/start-dfs.sh

$HADOOP_HOME/sbin/start-yarn.sh

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa7.png)

**Step 5)** DeptStrength.txt and DeptName.txt are the input files used for this program.

These file needs to be copied to HDFS using below command-

$HADOOP_HOME/bin/hdfs dfs -copyFromLocal DeptStrength.txt DeptName.txt /

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa8.png)

**Step 6)** Run the program using below command-

$HADOOP_HOME/bin/hadoop jar MapReduceJoin.jar MapReduceJoin/JoinDriver/DeptStrength.txt /DeptName.txt /output_mapreducejoin

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa9.png)

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa10.png)

**Step 7)** After execution, output file (named 'part-00000') will stored in the directory /output_mapreducejoin on HDFS

Results can be seen using the command line interface

$HADOOP_HOME/bin/hdfs dfs -cat /output_mapreducejoin/part-00000

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa11.png)

Results can also be seen via a web interface as-

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa12.png)

Now select **'Browse the filesystem'** and navigate upto **/output_mapreducejoin**

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa13.png)

Open **part-r-00000**

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa14.png)

Results are shown

![img](https://www.guru99.com/images/Big_Data/061114_1032_MapReduceHa15.png)

**NOTE:** Please note that before running this program for the next time, you will need to delete output directory /output_mapreducejoin

$HADOOP_HOME/bin/hdfs dfs -rm -r /output_mapreducejoin

Alternative is to use a different name for the output directory.

**What is Counter in MapReduce?**

A counter in MapReduce is a mechanism used for collecting statistical information about the MapReduce job. This information could be useful for diagnosis of a problem in MapReduce job processing. Counters are similar to putting a log message in the code for a map or reduce.

Typically, these counters are defined in a program (map or reduce) and are incremented during execution when a particular event or condition (specific to that counter) occurs. A very good application of counters is to track valid and invalid records from an input dataset.

**Types of MapReduce Counters**

There are basically 2 types of MapReduce Counters

- 1. **Hadoop Built-In counters:**There are some built-in counters which exist per job. Below are built-in counter groups-

- - - **MapReduce Task Counters** - Collects task specific information (e.g., number of input records) during its execution time.
    - **FileSystem Counters** - Collects information like number of bytes read or written by a task
    - **FileInputFormat Counters** - Collects information of a number of bytes read through FileInputFormat
    - **FileOutputFormat Counters** - Collects information of a number of bytes written through FileOutputFormat
    - **Job Counters -** These counters are used by JobTracker. Statistics collected by them include e.g., the number of task launched for a job.

- 1. **User Defined Counters**

In addition to built-in counters, a user can define his own counters using similar functionalities provided by programming languages. For example, in[ Java ](https://www.guru99.com/java-tutorial.html)'enum' are used to define user defined counters.

**Counters Example**

An example MapClass with Counters to count the number of missing and invalid values. Input data file used in this tutorial Our input data set is a CSV file, [SalesJan2009.csv](https://drive.google.com/uc?export=download&id=0B_vqvT0ovzHccGJ1VjVic1AwbGc)

public static class MapClass             extends MapReduceBase             implements Mapper<LongWritable, Text, Text, Text> {     static enum SalesCounters { MISSING, INVALID };     public void map ( LongWritable key, Text value,                  OutputCollector<Text, Text> output,                  Reporter reporter) throws IOException     {                  //Input string is split using ',' and stored in 'fields' array         String fields[] = value.toString().split(",", -20);         //Value at 4th index is country. It is stored in 'country' variable         String country = fields[4];                  //Value at 8th index is sales data. It is stored in 'sales' variable         String sales = fields[8];                if (country.length() == 0) {             reporter.incrCounter(SalesCounters.MISSING, 1);         } else if (sales.startsWith("\"")) {             reporter.incrCounter(SalesCounters.INVALID, 1);         } else {             output.collect(new Text(country), new Text(sales + ",1"));         }     } }

Above code snippet shows an example implementation of counters in Map Reduce.

Here, **SalesCounters** is a counter defined using **'enum'**. It is used to count **MISSING** and **INVALID** input records.

In the code snippet, if **'country'** field has zero length then its value is missing and hence corresponding counter **SalesCounters.MISSING** is incremented.

Next, if **'sales'** field starts with a **"** then the record is considered INVALID. This is indicated by incrementing counter **SalesCounters.INVALID.**



## 08 SQOOP

[08 Sqoop]({{%relref "08-Sqoop.md"%}})

