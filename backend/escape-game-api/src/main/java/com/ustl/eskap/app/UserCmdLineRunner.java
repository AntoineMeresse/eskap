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
        };
    }
}
