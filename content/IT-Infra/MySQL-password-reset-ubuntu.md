+++
title = "Reset - Mysql - password-ubuntu"
description = ""
weight = 1

+++

# Reset MySQL root password in ubuntu

1. edit config file by 

   ```shell
   sudo gedit /etc/mysql/mysql.conf.d/mysqld.cnf 
   ```

2. in [mysqld] section, below 'skip-external-locking' add line

   ```config
   skip-grant-tables
   ```

    

3. restart MySQL

```shell
sudo systemctl restart mysql
```

4. enter mysql 

   ```shell
   mysql -u root -p
   ```

   

5. switch to mysql database

   ```mysql
   use mysql;
   ```

   

6. change root password to 'passwd'：

```mysql
UPDATE mysql.user SET authentication_string=password('passwd') WHERE User='root' AND Host ='localhost';
```

7. update plugin field：

```mysql
UPDATE user SET plugin="mysql_native_password";
```

（plugin field is used to authenticate user, if it is empty, server will use built-in method)

8. ```mysql
   flush privileges;
   quit;
   ```

   

9. revert back the config file /etc/mysql/mysql.conf.d/mysqld.cnf  by remove or comment out the line has been added. 

10. start mysql again and login with new passwd

    ```shell
    sudo systemctl start mysql
    ```

    ## K8s installation on Centos
    
    [k8s installation Centos7]({{%relref "kubernetes-on-centos7.md"%}})

