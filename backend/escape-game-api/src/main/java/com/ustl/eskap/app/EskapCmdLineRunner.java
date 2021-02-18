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

            var eg1 = new EscapeGame();
            eg1.setId(1);
            eg1.setName("EG1");

            var eg2 = new EscapeGame();
            eg2.setId(2);
            eg2.setName("EG2");

            repository.save(eg1);
            repository.save(eg2);
        };
    }
}
