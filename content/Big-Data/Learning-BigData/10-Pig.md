+++
title = "10 Pig"
description = ""
weight = 2

+++

# **What is PIG?**

Pig is a high-level programming language useful for analyzing large data sets. A pig was a result of development effort at Yahoo!

In a MapReduce framework, programs need to be translated into a series of Map and Reduce stages. However, this is not a programming model which data analysts are familiar with. So, in order to bridge this gap, an abstraction called Pig was built on top of Hadoop.

Apache Pig enables people to focus more on **analyzing bulk data sets and to spend less time writing Map-Reduce programs.** Similar to Pigs, who eat anything, the Pig programming language is designed to work upon any kind of data. That's why the name, Pig!

![img](https://www.guru99.com/images/Big_Data/061114_1128_INTRODUCTIO1.png)

In this beginner's Big Data tutorial, you will learn-

- [What is PIG?](https://www.guru99.com/introduction-to-pig-and-hive.html#1)
- [Pig Architecture](https://www.guru99.com/introduction-to-pig-and-hive.html#2)
- [Prerequisites](https://www.guru99.com/introduction-to-pig-and-hive.html#3)
- [How to Download and Install Pig](https://www.guru99.com/introduction-to-pig-and-hive.html#4)
- [Example Pig Script](https://www.guru99.com/introduction-to-pig-and-hive.html#5)

**Pig Architecture**

Pig consists of two components:

1. **Pig Latin,** which is a language
2. **A runtime environment,** for running PigLatin programs.

A Pig Latin program consists of a series of operations or transformations which are applied to the input data to produce output. These operations describe a data flow which is translated into an executable representation, by Pig execution environment. Underneath, results of these transformations are series of MapReduce jobs which a programmer is unaware of. So, in a way, Pig allows the programmer to focus on data rather than the nature of execution.

PigLatin is a relatively stiffened language which uses familiar keywords from data processing e.g., Join, Group and Filter.

![img](https://www.guru99.com/images/Big_Data/061114_1128_INTRODUCTIO2.jpg)

PIG Architecture

**Execution modes:**

Pig has two execution modes:

1. Local mode: In this mode, Pig runs in a single JVM and makes use of local file system. This mode is suitable only for analysis of small datasets using Pig
2. Map Reduce mode: In this mode, queries written in Pig Latin are translated into MapReduce jobs and are run on a Hadoop cluster (cluster may be pseudo or fully distributed). MapReduce mode with the fully distributed cluster is useful of running Pig on large datasets.

**How to Download and Install Pig**

Before we start with the actual process, ensure you have Hadoop installed. Change user to 'hduser' (id used while Hadoop configuration, you can switch to the userid used during your Hadoop config)

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG1.png)

**Step 1)** Download the stable latest release of Pig from any one of the mirrors sites available at

<http://pig.apache.org/releases.html>

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG2.png)

Select **tar.gz** (and not **src.tar.gz)** file to download.

**Step 2)** Once a download is complete, navigate to the directory containing the downloaded tar file and move the tar to the location where you want to setup Pig. In this case, we will move to /usr/local

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG3.png)

Move to a directory containing Pig Files

cd /usr/local

Extract contents of tar file as below

sudo tar -xvf pig-0.12.1.tar.gz

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG4.png)

**Step 3).** Modify **~/.bashrc** to add Pig related environment variables

Open **~/.bashrc** file in any text editor of your choice and do below modifications-

export PIG_HOME=<Installation directory of Pig> export PATH=$PIG_HOME/bin:$HADOOP_HOME/bin:$PATH 

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG5.png)

**Step 4)** Now, source this environment configuration using below command

. ~/.bashrc

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG6.png)

**Step 5)** We need to recompile **PIG** to support **Hadoop 2.2.0**

Here are the steps to do this-

Go to PIG home directory

cd $PIG_HOME

Install Ant

sudo apt-get install ant

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG7.png)

Note: Download will start and will consume time as per your internet speed.

Recompile PIG

sudo ant clean jar-all -Dhadoopversion=23

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG8.png)

Please note that in this recompilation process multiple components are downloaded. So, a system should be connected to the internet.

Also, in case this process stuck somewhere and you don't see any movement on command prompt for more than 20 minutes then press **Ctrl + c** and rerun the same command.

In our case, it takes 20 minutes

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG9.png)

**Step 6)** Test the **Pig** installation using the command

pig -help

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG10.png)

**Example Pig Script**

We will use PIG to find the Number of Products Sold in Each Country.

**Input:** Our input data set is a CSV file, [SalesJan2009.csv](https://drive.google.com/uc?export=download&id=1tP8AJGSgDXwI12r2Ap07GyamMj1o0iDD)

**Step 1)** Start Hadoop

$HADOOP_HOME/sbin/start-dfs.sh

$HADOOP_HOME/sbin/start-yarn.sh

**Step 2)** Pig takes a file from HDFS in MapReduce mode and stores the results back to HDFS.

Copy file **SalesJan2009.csv** (stored on local file system, **~/input/SalesJan2009.csv**) to HDFS (Hadoop Distributed File System) Home Directory

Here the file is in Folder input. If the file is stored in some other location give that name

$HADOOP_HOME/bin/hdfs dfs -copyFromLocal ~/input/SalesJan2009.csv /

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG11.png)

Verify whether a file is actually copied or not.

$HADOOP_HOME/bin/hdfs dfs -ls /

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG12.png)

**Step 3)** Pig Configuration

First, navigate to $PIG_HOME/conf

cd $PIG_HOME/conf

sudo cp pig.properties pig.properties.original

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG13.png)

Open **pig.properties** using a text editor of your choice, and specify log file path using **pig.logfile**

sudo gedit pig.properties

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG14.png)

Loger will make use of this file to log errors.

**Step 4)** Run command 'pig' which will start Pig command prompt which is an interactive shell Pig queries.

pig

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG15.png)

**Step 5)**In Grunt command prompt for Pig, execute below Pig commands in order.

-- A. Load the file containing data.

salesTable = LOAD '/SalesJan2009.csv' USING PigStorage(',') AS (Transaction_date:chararray,Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray,Account_Created:chararray,Last_Login:chararray,Latitude:chararray,Longitude:chararray);

Press Enter after this command.

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG16.png)

-- B. Group data by field Country

GroupByCountry = GROUP salesTable BY Country;

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG17.png)

-- C. For each tuple in **'GroupByCountry'**, generate the resulting string of the form-> Name of Country: No. of products sold

CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0,CONCAT(':',(chararray)COUNT($1)));

Press Enter after this command.

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG18.png)

-- D. Store the results of Data Flow in the directory **'pig_output_sales'** on HDFS

STORE CountByCountry INTO 'pig_output_sales' USING PigStorage('\t');

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG19.png)

This command will take some time to execute. Once done, you should see the following screen

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG20.png)

**Step 6)** Result can be seen through command interface as,

$HADOOP_HOME/bin/hdfs dfs -cat pig_output_sales/part-r-00000

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG21.png)

Results can also be seen via a web interface as-

**Results through a web interface-**

Open <http://localhost:50070/> in a web browser.

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG22.png)

Now select **'Browse the filesystem'** and navigate upto **/user/hduser/pig_output_sales**

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG23.png)

Open **part-r-00000**

![img](https://www.guru99.com/images/Big_Data/061114_1236_HANDSONPIG24.png)

 

## 11 OOZIE

[11 OOZIE]({{%relref "11-Oozie.md"%}})

