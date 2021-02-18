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
            var user = new User();
            user.setId("abcde");
            user.setFirstname("abc");
            user.setLastname("de");

            var user2 = new User();
            user2.setId("fghij");
            user2.setFirstname("fgh");
            user2.setLastname("ij");

            repository.save(user);
            repository.save(user2);
        };
    }
}
