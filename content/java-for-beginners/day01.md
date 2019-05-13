+++
title = "Day 01"
description = "**Read** input from console and **print** to console Day 01"
weight = 1

+++

{{% alert theme="warning" %}}Please Install **JAVA** **IDE** and setup **JDK** in your computer before you begin this tutorial.If you don’t know How to  at all, we strongly suggest you to train by following this [Eclipse Installation for beginners](<https://wiki.eclipse.org/Eclipse/Installation#Install_a_JVM>).
<!--more--> {{%/alert%}}

The following steps are here to help you to understand how to print data in console and use Scanner to read data from console. 

## Pre-requisites

We assume you already have JDK and Eclipse installed on your computer.

Before start real work:

1. Install Jave JDK
2. Download Eclipse https://www.eclipse.org/downloads/  or IEDA http://www.jetbrains.com/idea/download/#section=linux and Install.
3. Copy & paste below example to your Eclipse or IEDA

### Before we begin

1. create a project in Eclipse

2. create package in Eclipse
3. create class (name it *profile_print*) in Eclipse
4. Open the class in Eclipse

### Copy below code to your class

```java
import java.util.Scanner;

/*
 * this example is to let you know 
 * how to read input from console
 * how to print it in the console
 * */
public class profile_print {
    public String name;
    public String country;
    public String hobby;
    public String wechat;
    public int age;

    public profile_print(String name, String country, String hobby, String wechat, int age){
        this.name = name;
        this.country = country;
        this.hobby = hobby;
        this.wechat = wechat;
        this.age = age;
    }

    public void run(){
        System.out.println("your profile_print:\nname: "+name+"\ncountry: "+country+"\nhobby: "+hobby+"\nwechat: "+wechat+"\nage: "+age);
    }

    public static void main(String[] arg){
        Scanner reader = new Scanner(System.in);
        String name = null;
        String country = null;
        String hobby = null;
        String wechat = null;
        int age = 0;

        System.out.println("what is your name: ");
        while(reader.hasNext()) {
            name = reader.nextLine();
            System.out.println("which country you are: ");
            country = reader.nextLine();
            System.out.println("what is your hobby: ");
            hobby = reader.nextLine();
            System.out.println("your wechat id: ");
            wechat = reader.nextLine();
            System.out.println("how old are you");
            age = reader.nextInt();
            break;
        }
        profile_print show = new profile_print(name, country, hobby, wechat, age);
        if(age >0 & age < 150){
            show.run();
        }
        else {
            System.out.println("the age you input is not correct, please try again");
        }

    }
}
```


## Day 02

[Day 02]({{%relref "day02.md"%}})