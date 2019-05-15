+++
title = "03 Hadoop-installation(ubuntu)"
description = ""
weight = 2

+++

# Hadoop installation on Ubuntu 

- In this tutorial, we will take you through step by step process to install Apache Hadoop on a Linux box (Ubuntu). This is 2 part process

  - [Part 1) Download and Install Hadoop](https://www.guru99.com/how-to-install-hadoop.html#1)
  - [Part 2) Configure Hadoop](https://www.guru99.com/how-to-install-hadoop.html#2)

  There are 2 **Prerequisites**

  -  You must have [Ubuntu installed ](https://www.guru99.com/install-linux.html#6)and running
  - You must have [Java Installed.](https://www.guru99.com/how-to-install-java-on-ubuntu.html)

  **Part 1) Download and Install Hadoop**

  **Step 1)** Add a Hadoop system user using below command

  sudo addgroup hadoop_

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal1.png)

  sudo adduser --ingroup hadoop_ hduser_

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal2.png)

  Enter your password, name and other details.

  **NOTE:** There is a possibility of below-mentioned error in this setup and installation process.

  **"hduser is not in the sudoers file. This incident will be reported."**

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal3.jpg)

  This error can be resolved by Login as a root user

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal4.png)

  Execute the command

  sudo adduser hduser_ sudo

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal5.png)

  Re-login as hduser_

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal6.png)

  **Step 2)** Configure SSH

  In order to manage nodes in a cluster, Hadoop requires SSH access

  First, switch user, enter the following command

  su - hduser_

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal7.png)

  This command will create a new key.

  ssh-keygen -t rsa -P ""

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal8.png)

  Enable SSH access to local machine using this key.

  cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal9.png)

  Now test SSH setup by connecting to localhost as 'hduser' user.

  ssh localhost

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal10.png)

  **Note:** Please note, if you see below error in response to 'ssh localhost', then there is a possibility that SSH is not available on this system-

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal11.png)

  **To resolve this -**

  Purge SSH using,

  sudo apt-get purge openssh-server

  It is good practice to purge before the start of installation

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal12.png)

  Install SSH using the command-

  sudo apt-get install openssh-server

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal13.png)

  **Step 3)** Next step is to [Download Hadoop](https://www.guru99.com/ubuntu-installation-on-virtual-box.html)

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal14.png)

  Select Stable

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal15.png)

  **Select the tar.gz file ( not the file with src)**

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal16.png)

  Once a download is complete, navigate to the directory containing the tar file

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal17.png)

  Enter,

  sudo tar xzf hadoop-2.2.0.tar.gz

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal18.png)

  **Now, rename hadoop-2.2.0 as hadoop**

  sudo mv hadoop-2.2.0 hadoop

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal19.png)

  sudo chown -R hduser_:hadoop_ hadoop

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal20.png)

  **Part 2) Configure Hadoop**

  **Step 1)** Modify **~/.bashrc** file

  Add following lines to end of file **~/.bashrc**

  \#Set HADOOP_HOME export HADOOP_HOME=<Installation Directory of Hadoop> #Set JAVA_HOME export JAVA_HOME=<Installation Directory of Java> # Add bin/ directory of Hadoop to PATH export PATH=$PATH:$HADOOP_HOME/bin

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal21.png)

  Now, source this environment configuration using below command

  . ~/.bashrc

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal22.png)

  **Step 2)** Configurations related to HDFS

  Set **JAVA_HOME** inside file **$HADOOP_HOME/etc/hadoop/hadoop-env.sh**

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal23.png)

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal24.png)

  With

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal25.png)

  There are two parameters in **$HADOOP_HOME/etc/hadoop/core-site.xml** which need to be set-

  **1.** **'hadoop.tmp.dir' -** Used to specify a directory which will be used by Hadoop to store its data files.

  **2. 'fs.default.name' -** This specifies the default file system.

  To set these parameters, open core-site.xml

  sudo gedit $HADOOP_HOME/etc/hadoop/core-site.xml

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal26.png)

  Copy below line in between tags <configuration></configuration>

  <property>
  <name>hadoop.tmp.dir</name>
  <value>/app/hadoop/tmp</value>
  <description>Parent directory for other temporary directories.</description>
  </property>
  <property>
  <name>fs.defaultFS </name>
  <value>hdfs://localhost:54310</value>
  <description>The name of the default file system. </description>
  </property>

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal27.png)

  Navigate to the directory **$HADOOP_HOME/etc/Hadoop**

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal28.png)

  Now, create the directory mentioned in core-site.xml

  sudo mkdir -p <Path of Directory used in above setting>

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal29.png)

  Grant permissions to the directory

  sudo chown -R hduser_:Hadoop_ <Path of Directory created in above step>

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal30.png)

  sudo chmod 750 <Path of Directory created in above step>

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal31.png)

  **Step 3)** Map Reduce Configuration

  Before you begin with these configurations, lets set HADOOP_HOME path

  sudo gedit /etc/profile.d/hadoop.sh

  And Enter

  export HADOOP_HOME=/home/guru99/Downloads/Hadoop

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal32.png)

  Next enter

  sudo chmod +x /etc/profile.d/hadoop.sh

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal33.png)

  Exit the Terminal and restart again

  Type echo $HADOOP_HOME. To verify the path

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal34.png)

  Now copy files

  sudo cp $HADOOP_HOME/etc/hadoop/mapred-site.xml.template $HADOOP_HOME/etc/hadoop/mapred-site.xml

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal35.png)

  Open the **mapred-site.xml** file

  sudo gedit $HADOOP_HOME/etc/hadoop/mapred-site.xml

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal36.png)

  Add below lines of setting in between tags <configuration> and </configuration>

  <property> <name>mapreduce.jobtracker.address</name> <value>localhost:54311</value> <description>MapReduce job tracker runs at this host and port. </description> </property>

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal37.png)

  Open **$HADOOP_HOME/etc/hadoop/hdfs-site.xml** as below,

  sudo gedit $HADOOP_HOME/etc/hadoop/hdfs-site.xml

   

   

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal38.png)

  Add below lines of setting between tags <configuration> and </configuration>

  <property>
  <name>dfs.replication</name>
  <value>1</value>
  <description>Default block replication.</description>
  </property>
  <property>
  <name>dfs.datanode.data.dir</name>
  <value>/home/hduser_/hdfs</value>
  </property>

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal39.png)

  Create a directory specified in above setting-

  sudo mkdir -p <Path of Directory used in above setting>

  sudo mkdir -p /home/hduser_/hdfs

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal40.png)

  sudo chown -R hduser_:hadoop_ <Path of Directory created in above step>

  sudo chown -R hduser_:hadoop_ /home/hduser_/hdfs

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal41.png)

  sudo chmod 750 <Path of Directory created in above step>

  sudo chmod 750 /home/hduser_/hdfs

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal42.png)

  **Step 4)** Before we start Hadoop for the first time, format HDFS using below command

  $HADOOP_HOME/bin/hdfs namenode -format

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal43.png)

  **Step 5)** Start Hadoop single node cluster using below command

  $HADOOP_HOME/sbin/start-dfs.sh

  An output of above command

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal44.png)

  $HADOOP_HOME/sbin/start-yarn.sh

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal45.png)

  Using **'jps'** tool/command, verify whether all the Hadoop related processes are running or not.

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal46.png)

  If Hadoop has started successfully then an output of jps should show NameNode, NodeManager, ResourceManager, SecondaryNameNode, DataNode.

  **Step 6)** Stopping Hadoop

  $HADOOP_HOME/sbin/stop-dfs.sh

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal47.png)

  $HADOOP_HOME/sbin/stop-yarn.sh

  ![img](https://www.guru99.com/images/Big_Data/061114_0909_HowToInstal48.png)



## 04 HDFS Intro

[04 HDFS Introduction]({{%relref "04-HDFS.md"%}})

