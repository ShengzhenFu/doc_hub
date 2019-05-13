+++
title = "Day 04"
description = "**Equal** statement**, Day 04"
weight = 1

+++

# Day 04 Equal statement

### Before we begin

1. create a project in Eclipse

2. create package in Eclipse
3. create class (name it **equal**) in Eclipse
4. Open the class in Eclipse

### Copy code to your class

```java
public class equal {
	public static void main(String[] args) {
		System.out.println(1 == 2); //false
		System.out.println(2 == 2); //true
		
		int a = 1;
		int b = 1;
		boolean c = a == b; // boolean c = true;
		System.out.println(c); //true
		System.out.println(a == b);  //true
		
		System.out.println("**********************");
		System.out.println(1>2); //false
		System.out.println(1<2);  // true
		System.out.println(2>=1);  // true
		System.out.println(1!=2);  //true
		
		System.out.println("**********************");
		int i = 10;
		System.out.println(true || ++i == 11);
		System.out.println(i); //10
		System.out.println(false && i++  == 11);
		System.out.println(i);
		
		int j = 20;
		System.out.println(true & ++j == 21);
		System.out.println(false | ++j == 21);
		System.out.println(j);
		
		System.out.println("**********************");
		System.out.println(true ^ false); //true
		
		System.out.println("**********************");
		System.out.println(!true);
		System.out.println(!false);		
		
	}
	}
```


## Day 04

[Day 04]({{%relref "day03.md"%}})