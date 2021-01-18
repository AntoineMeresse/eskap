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
        System.out.println("Eskap Api : ---> http://localhost:8080/eskaps/");
        printLine();
    }
}
