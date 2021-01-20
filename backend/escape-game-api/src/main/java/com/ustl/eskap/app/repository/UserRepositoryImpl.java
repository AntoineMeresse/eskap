package com.ustl.eskap.app.repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ustl.eskap.app.bo.user.User;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class UserRepositoryImpl implements UserRepository {

    private List<User> users;

    public UserRepositoryImpl(){
        try {
            var usersStream = this.getClass().getResourceAsStream("/users.json");
            var objectMapper = new ObjectMapper();
            var usersArray = objectMapper.readValue(usersStream, User[].class);
            this.users = Arrays.asList(usersArray);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User findUserById(int id) {
        for (User user : users) {
            if (user.getId() == id) return user;
        }
        return null;
    }

    @Override
    public List<User> findAllUsers() {
        return users;
    }
}
