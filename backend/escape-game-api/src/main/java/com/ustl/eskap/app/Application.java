package com.ustl.eskap.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

    public static void printLine(){
        System.out.println("=================================================");
    }

    public static void main(String... args){
        SpringApplication.run(Application.class, args);
        printLine();
        System.out.println("Eskap Api :");
        System.out.println("            ---> 1) Eskaps : http://localhost:8080/eskaps/");
        System.out.println("            ---> 2) Users  : http://localhost:8080/users/");
        printLine();
    }
}
