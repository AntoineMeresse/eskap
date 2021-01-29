package com.ustl.eskap.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

    public static int PORT = 8080;
    public static void printLine(){
        System.out.println("=================================================");
    }

    public static void printRoutes() {
        printLine();
        System.out.println("Eskap Api :");
        System.out.println("            ---> 1) Eskaps   : http://localhost:"+PORT+"/eskaps/");
        System.out.println("            ---> 2) Users    : http://localhost:"+PORT+"/users/");
        System.out.println("            ---> 3) Outings  : http://localhost:"+PORT+"/outings/");
        printLine();
    }

    public static void main(String... args){
        SpringApplication.run(Application.class, args);
        printRoutes();
    }
}
