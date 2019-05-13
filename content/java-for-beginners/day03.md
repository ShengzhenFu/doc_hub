+++
title = "Day 03"
description = "**Switch** statement**, Day 03"
weight = 1

+++

# Day 03 Switch statement

### Before we begin

1. create a project in Eclipse

2. create package in Eclipse
3. create class (name it **switcher**) in Eclipse
4. Open the class in Eclipse

### Copy code to your class

```java
import java.util.Scanner;

public class switcher {
    public int x;
    public char y;
    public String z;
    
    void switch_numbers(){
    	int x = 0;
        System.out.println("please input a number <= 9: ");
        Scanner scan = new Scanner(System.in);
        while(scan.hasNext()){
            x = scan.nextInt();
        break;
        }
        System.out.println("your input number is "+x);
        switch (x){
            case 3: case 5: case 7:
                System.out.println(x + " is ODD number");
                break;
            case 2: case 4: case 6: case 8:
                System.out.println(x+" is even number");
                break;
            case 1:
            	System.out.println(x+" is minimum number");
            case 9:
            	System.out.println(x+" is maximum number");
            default:
                System.out.println("your input is not in range 1 ~ 9");
                break;
        }
    }
    void switch_string() {
    	String y = "";
    	System.out.println("Please input one string");
    	Scanner scan = new Scanner(System.in);
    	while(scan.hasNext()) {
    		y = scan.nextLine();
    	break;
    	}
    	System.out.println("your input string is "+y);
    	switch(y) {
	    	case "mj":
	    		System.out.println("mj matched Michael Jordan!");
	    		break;
	    	case "kb":
	    		System.out.println("kb matched Kobe Bryant!");
	    		break;
	    	case "kg":
	    		System.out.println("kg matched Kevin Garnet!");
	    		break;
	    	default:
	    		System.out.println("None matched !");
	    		break;
    	}
    }
    void switch_char() {
    	char z ='f';
    	System.out.println("please input one letter a ~ z or A ~ Z");
    	Scanner scan = new Scanner(System.in);
    	while(scan.hasNext()) {
    		z = scan.next().charAt(0);
    		break;
    	}
    	System.out.println("your input letter is "+z);
    	switch(z) {
	    	case 'm':
	    		System.out.println("m matched, Mondy !");
	    		break;
	    	case 't':
	    		System.out.println("t matched Tuesday!");
	    		break;
	    	case 'w':
	    		System.out.println("w matched Wednesday!");
	    		break;
	    	default:
	    		System.out.println("None matched !");
	    		break;
        	}
    	}
    public static void main(String[] args){
    	switcher swn = new switcher();
    	swn.switch_numbers(); // call switch_numbers function
    	swn.switch_string();  // call switch_string function
    	swn.switch_char();  // call switch_char function
    }
}
```


## Day 04

[Day 04]({{%relref "day04.md"%}})