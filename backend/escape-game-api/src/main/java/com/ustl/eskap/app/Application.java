package com.ustl.eskap.app;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.eskap.Review;
import com.ustl.eskap.app.repository.EskapRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.List;

@SpringBootApplication
public class Application {

    public static int PORT = 8081;
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

    @Bean
    @Autowired
    public CommandLineRunner demo(EskapRepository repository) {
        return (args) -> {
            var review = new Review(1,"1","review 1",4.5,"01/29/2021");
            var review2 = new Review(2,"1","review 2",4.0,"01/29/2021");

            List<String> theme1 = List.of("Sea");
            List<String> theme2 = List.of("Jail");

            EscapeGame eg = new EscapeGame(
                    1, "Eskap Test", "Easy", 20.0, "urltest", "descriptiontest",
                    1, "rue", "Orchies","France",3.0,2.0, theme1, List.of(review));

            EscapeGame eg2 = new EscapeGame(
                    2, "Eskap Test", "Easy", 20.0, "urltest", "descriptiontest",
                    1, "rue", "Lille","France",4.0,1.0, theme2, List.of(review2));

            repository.save(eg);
            repository.save(eg2);
        };
    }
}
