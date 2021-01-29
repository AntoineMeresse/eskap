package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.user.User;
import com.ustl.eskap.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    protected UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public UserServiceImpl() {

    }

    @Override
    public User getUser(String id) {
        return this.userRepository.findByUserId(id);
    }

    @Override
    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    @Override
    public List<Integer> getFavEskapFromUser(String id) {
        var users = this.userRepository.findAll();
        List<Integer> res = new ArrayList<>();
        for (User u : users) {
            if (id.equals(u.getId())){
                res = u.getFavlist();
            }
        }
        return res;
    }

    @Override
    public User createUser(User user) {
        return this.userRepository.save(user);
    }

    @Autowired
    public void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
}
