package com.ustl.eskap.app;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.eskap.Review;
import com.ustl.eskap.app.repository.EskapRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class EskapCmdLineRunner {

    @Bean
    @Autowired
    public CommandLineRunner demo(EskapRepository repository) {
        return (args) -> {
            var review = new Review(1,"1","review 1",4.5,"01/29/2021");
            var review2 = new Review(2,"1","review 2",4.0,"01/29/2021");

            List<String> theme1 = List.of("Sea");
            List<String> theme2 = List.of("Jail");

            EscapeGame eg1 = new EscapeGame(
                    1, "Eskap Lille", "easy", 20.0, "", "Eskap Game From Lille",
                    1, "rue", "Lille","France",50.630206,3.04584,
                    theme1, List.of(review), true);

            EscapeGame eg2 = new EscapeGame(
                    2, "Eskap Paris", "medium", 30.0, "", "Eskap Game From Paris",
                    1, "rue", "Paris","France",48.866667,2.333333,
                    theme2, List.of(review2), false);

            EscapeGame eg3 = new EscapeGame(
                    3, "Eskap Brest", "easy", 26.0, "", "Eskap Game From Brest",
                    1, "rue", "Brest","France",48.3905283,-4.4860088,
                    theme2, List.of(), true);

            EscapeGame eg4 = new EscapeGame(
                    4, "Eskap Lyon", "hard", 19.99, "", "Eskap Game From Lyon",
                    1, "rue", "Lyon","France",45.75,4.85,
                    theme2, List.of(), true);

            EscapeGame eg5 = new EscapeGame(
                    5, "Eskap Marseille", "medium", 32.0, "", "Eskap Game From Marseille",
                    1, "rue", "Marseille","France",43.3,5.4,
                    theme1, List.of(), false);

            repository.save(eg1);
            repository.save(eg2);
            repository.save(eg3);
            repository.save(eg4);
            repository.save(eg5);
        };
    }
}
