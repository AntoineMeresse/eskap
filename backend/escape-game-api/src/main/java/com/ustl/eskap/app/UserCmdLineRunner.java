package com.ustl.eskap.app;

import com.ustl.eskap.app.bo.user.User;
import com.ustl.eskap.app.repository.EskapRepository;
import com.ustl.eskap.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class UserCmdLineRunner {
    @Bean
    @Autowired
    public CommandLineRunner userBean(UserRepository repository) {
        return (args) -> {

            User u1 = new User("abcde","Antoine","Meresse",List.of(),List.of(1));
            User u2 = new User("edcba","Imad","Abdelmouine",List.of(),List.of(2));
            repository.save(u1);
            repository.save(u2);
        };
    }
}
