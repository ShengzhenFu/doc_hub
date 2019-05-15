+++
title = "Set - Env - JDK - Maven - ubuntu"
description = ""
weight = 1

+++

# Set env for JDK and Maven ubuntu

1. Edit /etc/profile

   ```shell
   sudo vi /etc/profile
   ```

2. add below lines to the bottom 

   ```shell
   #set maven env
   export M2_HOME=/usr/local/apache-maven-3.6.1
   export CLASSPATH=$CLASSPATH:$M2_HOME/lib
   export PATH=$PATH:$M2_HOME/bin
   #set Java environment
   export JAVA_HOME=/usr/lib/jdk1.8.0_191
   export JRE_HOME=$JAVA_HOME/jre
   export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
   export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
   
   ```

3. activate the changes

   ```shell
   source /etc/profile
   ```

    /etc/profile

4. Edit bashrc

```shell
sudo vi ~/.bashrc
```

4. add below lines in the front

   ```shell
   #set maven env
   export M2_HOME=/usr/local/apache-maven-3.6.1
   export CLASSPATH=$CLASSPATH:$M2_HOME/lib
   export PATH=$PATH:$M2_HOME/bin
   #set Java environment
   export JAVA_HOME=/usr/lib/jdk1.8.0_191
   export JRE_HOME=$JAVA_HOME/jre
   export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
   export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
   ```

   

5. activate the changes

   ```shell
   source ~/.bashrc
   ```






