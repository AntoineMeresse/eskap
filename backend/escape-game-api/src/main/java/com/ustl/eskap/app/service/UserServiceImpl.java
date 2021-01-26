package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.user.User;
import com.ustl.eskap.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public User getUser(int id) {
        return this.userRepository.findUserById(id);
    }

    @Override
    public List<User> getAllUsers() {
        return this.userRepository.findAllUsers();
    }

    @Override
    public List<Integer> getFavEskapFromUser(int id) {
        return this.userRepository.findFavEskapFromUserById(id);
    }

    @Autowired
    public void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
}
