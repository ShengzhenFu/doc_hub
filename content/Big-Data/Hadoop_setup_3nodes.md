+++
title = "3nodes-Hadoop-installation-setup"
description = ""
weight = 2
+++

# Setup 3 nodes Hadoop

## Hadoop Introduction



Hadoop is an open-source Apache project that allows creation of parallel processing applications on large data sets, distributed across networked nodes. It's composed of the Hadoop Distributed File System (HDFS™) that handles scalability and redundancy of data across nodes, and Hadoop YARN: a framework for job scheduling that executes data processing tasks on all nodes.

![img](https://github.com/linode/docs/raw/master/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/hadoop-1-logo.png)

## Before You Begin

1. Follow the [Getting Started](https://github.com/linode/docs/blob/master/docs/getting-started) guide to create three (3) nodes. They'll be referred to throughout this guide as node-master, node1 and node2. It's recommended that you set the hostname of each node to match this naming convention.

Run the steps in this guide from the node-master unless otherwise specified.

1. Follow the [Securing Your Server](https://github.com/linode/docs/blob/master/docs/security/securing-your-server) guide to harden the three servers. Create a normal user for the install, and a user called hadoop for any Hadoop daemons. Do not create SSH keys for hadoop users. SSH keys will be addressed in a later section.
2. Install the JDK using the appropriate guide for your distribution, [Debian](https://github.com/linode/docs/blob/master/docs/development/java/install-java-on-debian), [CentOS](https://github.com/linode/docs/blob/master/docs/development/java/install-java-on-centos) or [Ubuntu](https://github.com/linode/docs/blob/master/docs/development/java/install-java-on-ubuntu-16-04), or grab the latest JDK from Oracle.
3. The steps below use example IPs for each node. Adjust each example according to your configuration:

- - node-master: 192.0.2.1
  - node1: 192.0.2.2
  - node2: 192.0.2.3

{{< note >}} This guide is written for a non-root user. Commands that require elevated privileges are prefixed with sudo. If you’re not familiar with the sudo command, see the [Users and Groups](https://github.com/linode/docs/blob/master/docs/tools-reference/linux-users-and-groups) guide. All commands in this guide are run with the *hadoop* user if not specified otherwise. {{< /note >}}

## Architecture of a Hadoop Cluster

Before configuring the master and slave nodes, it's important to understand the different components of a Hadoop cluster.

A master node keeps knowledge about the distributed file system, like the inode table on an ext3 filesystem, and schedules resources allocation. node-master will handle this role in this guide, and host two daemons:

- The NameNode: manages the distributed file system and knows where stored data blocks inside the cluster are.
- The ResourceManager: manages the YARN jobs and takes care of scheduling and executing processes on slave nodes.

Slave nodes store the actual data and provide processing power to run the jobs. They'll be node1 and node2, and will host two daemons:

- The DataNode manages the actual data physically stored on the node; it's named, NameNode.
- The NodeManager manages execution of tasks on the node.

## Configure the System

#### Create Host File on Each Node

For each node to communicate with its names, edit the /etc/hosts file to add the IP address of the three servers. Don't forget to replace the sample IP with your IP:

file "/etc/hosts" > 192.0.2.1 node-master 192.0.2.2 node1 192.0.2.3 node2 file

Distribute Authentication Key-pairs for the Hadoop User

The master node will use an ssh-connection to connect to other nodes with key-pair authentication, to manage the cluster.

1. Login to node-master as the hadoop user, and generate an ssh-key:

ssh-keygen -b 4096 

1. Copy the key to the other nodes. It's good practice to also copy the key to the node-master itself, so that you can also use it as a DataNode if needed. Type the following commands, and enter the hadoop user's password when asked. If you are prompted whether or not to add the key to known hosts, enter yes:

ssh-copy-id -i $HOME/.ssh/id_rsa.pub hadoop@node-master ssh-copy-id -i $HOME/.ssh/id_rsa.pub hadoop@node1 ssh-copy-id -i $HOME/.ssh/id_rsa.pub hadoop@node2 

Download and Unpack Hadoop Binaries

Login to node-master as the hadoop user, download the Hadoop tarball from [Hadoop project page](https://hadoop.apache.org/), and unzip it:

cd wget http://apache.mindstudios.com/hadoop/common/hadoop-2.8.1/hadoop-2.8.1.tar.gz tar -xzf hadoop-2.8.1.tar.gz mv hadoop-2.8.1 hadoop 

Set Environment Variables

1. Add Hadoop binaries to your PATH. Edit /home/hadoop/.profile and add the following line:

file "/home/hadoop/.profile" shell > PATH=/home/hadoop/hadoop/bin:/home/hadoop/hadoop/sbin:$PATH

file

Configure the Master Node

Configuration will be done on node-master and replicated to other nodes.

Set JAVA_HOME

1. Get your Java installation path. If you installed open-jdk from your package manager, you can get the path with the command:

update-alternatives --display java 

Take the value of the current link and remove the trailing /bin/java. For example on Debian, the link is /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java, so JAVA_HOME should be /usr/lib/jvm/java-8-openjdk-amd64/jre.

If you installed java from Oracle, JAVA_HOME is the path where you unzipped the java archive.

1. Edit ~/hadoop/etc/hadoop/hadoop-env.sh and replace this line:

export JAVA_HOME=${JAVA_HOME} 

with your actual java installation path. For example on a Debian with open-jdk-8:

file "~/hadoop/etc/hadoop/hadoop-env.sh" shell >}} export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

file

Set NameNode Location

On each node update ~/hadoop/etc/hadoop/core-site.xml you want to set the NameNode location to node-master on port 9000:

file "~/hadoop/etc/hadoop/core-site.xml" xml >}}

<configuration>
    <property>
        <name>fs.default.name</name>
        <value>hdfs://node-master:9000</value>
    </property>
</configuration>

file

### Set path for HDFS

Edit hdfs-site.conf:

file "~/hadoop/etc/hadoop/hdfs-site.xml" xml >}} dfs.namenode.name.dir /home/hadoop/data/nameNode

<property>
        <name>dfs.datanode.data.dir</name>
        <value>/home/hadoop/data/dataNode</value>
</property>

<property>
        <name>dfs.replication</name>
        <value>1</value>
</property>

file

The last property, dfs.replication, indicates how many times data is replicated in the cluster. You can set 2 to have all the data duplicated on the two nodes. Don't enter a value higher than the actual number of slave nodes.

### Set YARN as Job Scheduler

1. In ~/hadoop/etc/hadoop/, rename mapred-site.xml.template to mapred-site.xml:

cd ~/hadoop/etc/hadoop mv mapred-site.xml.template mapred-site.xml 

1. Edit the file, setting yarn as the default framework for MapReduce operations:

file "~/hadoop/etc/hadoop/mapred-site.xml" xml >}}

mapreduce.framework.name yarn

file

Configure YARN

Edit yarn-site.xml:

file"~/hadoop/etc/hadoop/yarn-site.xml" xml >}} yarn.acl.enable 0

<property>
        <name>yarn.resourcemanager.hostname</name>
        <value>node-master</value>
</property>

<property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
</property>

file

Configure Slaves

The file slaves is used by startup scripts to start required daemons on all nodes. Edit ~/hadoop/etc/hadoop/slaves to be:

file"~/hadoop/etc/hadoop/slaves" resource >}} node1 node2

file

### Configure Memory Allocation

Memory allocation can be tricky on low RAM nodes because default values are not suitable for nodes with less than 8GB of RAM. This section will highlight how memory allocation works for MapReduce jobs, and provide a sample configuration for 2GB RAM nodes.

The Memory Allocation Properties

### A YARN job is executed with two kind of resources:

- An *Application Master* (AM) is responsible for monitoring the application and coordinating distributed executors in the cluster.
- Some executors that are created by the AM actually run the job. For a MapReduce jobs, they'll perform map or reduce operation, in parallel.

Both are run in *containers* on slave nodes. Each slave node runs a *NodeManager* daemon that's responsible for container creation on the node. The whole cluster is managed by a *ResourceManager* that schedules container allocation on all the slave-nodes, depending on capacity requirements and current charge.

Four types of resource allocations need to be configured properly for the cluster to work. These are:

1. How much memory can be allocated for YARN containers on a single node. This limit should be higher than all the others; otherwise, container allocation will be rejected and applications will fail. However, it should not be the entire amount of RAM on the node.

This value is configured in yarn-site.xml with yarn.nodemanager.resource.memory-mb.

1. How much memory a single container can consume and the minimum memory allocation allowed. A container will never be bigger than the maximum, or else allocation will fail and will always be allocated as a multiple of the minimum amount of RAM.

Those values are configured in yarn-site.xml with yarn.scheduler.maximum-allocation-mb and yarn.scheduler.minimum-allocation-mb.

1. How much memory will be allocated to the ApplicationMaster. This is a constant value that should fit in the container maximum size.

This is configured in mapred-site.xml with yarn.app.mapreduce.am.resource.mb.

1. How much memory will be allocated to each map or reduce operation. This should be less than the maximum size.

This is configured in mapred-site.xml with properties mapreduce.map.memory.mb and mapreduce.reduce.memory.mb.

The relationship between all those properties can be seen in the following figure:

![img](https://github.com/linode/docs/raw/master/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/hadoop-2-memory-allocation-new.png)

### Sample Configuration for 2GB Nodes

For 2GB nodes, a working configuration may be:

| Property                             | Value |
| ------------------------------------ | ----- |
| yarn.nodemanager.resource.memory-mb  | 1536  |
| yarn.scheduler.maximum-allocation-mb | 1536  |
| yarn.scheduler.minimum-allocation-mb | 128   |
| yarn.app.mapreduce.am.resource.mb    | 512   |
| mapreduce.map.memory.mb              | 256   |
| mapreduce.reduce.memory.mb           | 256   |

1. Edit /home/hadoop/hadoop/etc/hadoop/yarn-site.xml and add the following lines:

file"~/hadoop/etc/hadoop/yarn-site.xml" xml >}}

yarn.nodemanager.resource.memory-mb 1536 yarn.scheduler.maximum-allocation-mb 1536 yarn.scheduler.minimum-allocation-mb 128 yarn.nodemanager.vmem-check-enabled false

file

The last property disables virtual-memory checking and can prevent containers from being allocated properly on JDK8. 

1. Edit /home/hadoop/hadoop/etc/hadoop/mapred-site.xml and add the following lines:

file"~/hadoop/etc/hadoop/mapred-site.xml" xml >}}

yarn.app.mapreduce.am.resource.mb 512 mapreduce.map.memory.mb 256 mapreduce.reduce.memory.mb 256

file

### Duplicate Config Files on Each Node

1. Copy the hadoop binaries to slave nodes:

cd /home/hadoop/ scp hadoop-*.tar.gz node1:/home/hadoop scp hadoop-*.tar.gz node2:/home/hadoop 

1. Connect to node1 via ssh. A password isn't required, thanks to the ssh keys copied above:

ssh node1 

1. Unzip the binaries, rename the directory, and exit node1 to get back on the node-master:

tar -xzf hadoop-2.8.1.tar.gz mv hadoop-2.8.1 hadoop exit 

1. Repeat steps 2 and 3 for node2.
2. Copy the Hadoop configuration files to the slave nodes:

for node in node1 node2; do     scp ~/hadoop/etc/hadoop/* $node:/home/hadoop/hadoop/etc/hadoop/; done 

### Format HDFS

HDFS needs to be formatted like any classical file system. On node-master, run the following command:

hdfs namenode -format 

Your Hadoop installation is now configured and ready to run.

### Run and monitor HDFS

This section will walk through starting HDFS on NameNode and DataNodes, and monitoring that everything is properly working and interacting with HDFS data.

### Start and Stop HDFS

1. Start the HDFS by running the following script from node-master:

start-dfs.sh 

It'll start NameNode and SecondaryNameNode on node-master, and DataNode on node1 and node2, according to the configuration in the slaves config file.

1. Check that every process is running with the jps command on each node. You should get on node-master (PID will be different):

21922 Jps 21603 NameNode 21787 SecondaryNameNode 

and on node1 and node2:

19728 DataNode 19819 Jps 

1. To stop HDFS on master and slave nodes, run the following command from node-master:

stop-dfs.sh 

### Monitor your HDFS Cluster

1. You can get useful information about running your HDFS cluster with the hdfs dfsadmin command. Try for example:

hdfs dfsadmin -report 

This will print information (e.g., capacity and usage) for all running DataNodes. To get the description of all available commands, type:

hdfs dfsadmin -help 

1. You can also automatically use the friendlier web user interface. Point your browser to [http://node-master-IP:50070](http://node-master-ip:50070/)and you'll get a user-friendly monitoring console.

![img](https://github.com/linode/docs/raw/master/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/hadoop-3-hdfs-webui-wide.png)

### Put and Get Data to HDFS

Writing and reading to HDFS is done with command hdfs dfs. First, manually create your home directory. All other commands will use a path relative to this default home directory:

hdfs dfs -mkdir -p /user/hadoop 

Let's use some textbooks from the [Gutenberg project](https://www.gutenberg.org/) as an example.

1. Create a *books* directory in HDFS. The following command will create it in the home directory, /user/hadoop/books:

hdfs dfs -mkdir books 

1. Grab a few books from the Gutenberg project:

cd /home/hadoop wget -O alice.txt https://www.gutenberg.org/files/11/11-0.txt wget -O holmes.txt https://www.gutenberg.org/ebooks/1661.txt.utf-8 wget -O frankenstein.txt https://www.gutenberg.org/ebooks/84.txt.utf-8 

1. Put the three books through HDFS, in the booksdirectory:

hdfs dfs -put alice.txt holmes.txt frankenstein.txt books 

1. List the contents of the book directory:

hdfs dfs -ls books 

1. Move one of the books to the local filesystem:

hdfs dfs -get books/alice.txt 

1. You can also directly print the books from HDFS:

hdfs dfs -cat books/alice.txt 

There are many commands to manage your HDFS. For a complete list, you can look at the [Apache HDFS shell documentation](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/FileSystemShell.html), or print help with:

hdfs dfs -help 

### Run YARN

HDFS is a distributed storage system, it doesn't provide any services for running and scheduling tasks in the cluster. This is the role of the YARN framework. The following section is about starting, monitoring, and submitting jobs to YARN.

Start and Stop YARN

1. Start YARN with the script:

start-yarn.sh 

1. Check that everything is running with the jps command. In addition to the previous HDFS daemon, you should see a ResourceManager on node-master, and a NodeManager on node1 and node2.
2. To stop YARN, run the following command on node-master:

stop-yarn.sh 

Monitor YARN

1. The yarn command provides utilities to manage your YARN cluster. You can also print a report of running nodes with the command:

yarn node -list 

Similarly, you can get a list of running applications with command:

yarn application -list 

To get all available parameters of the yarn command, see [Apache YARN documentation](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YarnCommands.html).

1. As with HDFS, YARN provides a friendlier web UI, started by default on port 8088 of the Resource Manager. Point your browser to [http://node-master-IP:8088](http://node-master-ip:8088/) and browse the UI:

![img](https://github.com/linode/docs/raw/master/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/hadoop-4-yarn-webui-wide.png)

Submit MapReduce Jobs to YARN

Yarn jobs are packaged into jar files and submitted to YARN for execution with the command yarn jar. The Hadoop installation package provides sample applications that can be run to test your cluster. You'll use them to run a word count on the three books previously uploaded to HDFS.

1. Submit a job with the sample jar to YARN. On node-master, run:

yarn jar ~/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.1.jar wordcount "books/*" output 

The last argument is where the output of the job will be saved - in HDFS.

1. After the job is finished, you can get the result by querying HDFS with hdfs dfs -ls output. In case of a success, the output will resemble:

Found 2 items -rw-r--r--   1 hadoop supergroup          0 2017-10-11 14:09 output/_SUCCESS -rw-r--r--   1 hadoop supergroup     269158 2017-10-11 14:09 output/part-r-00000 

1. Print the result with:

hdfs dfs -cat output/part-r-00000 

Next Steps

Now that you have a YARN cluster up and running, you can:

- Learn how to code your own YARN jobs with [Apache documentation](https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/WritingYarnApplications.html).
- Install Spark on top on your YARN cluster with [Linode Spark guide](https://github.com/linode/docs/blob/master/docs/databases/hadoop/install-configure-run-spark-on-top-of-hadoop-yarn-cluster).