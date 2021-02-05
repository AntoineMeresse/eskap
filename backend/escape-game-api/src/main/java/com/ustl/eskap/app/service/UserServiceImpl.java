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
    public User saveUser(User user) {
        return this.userRepository.save(user);
    }

    @Override
    public User favEskap(String id, int eskapId, boolean add){
        var user = this.userRepository.findByUserId(id);
        var userFav = user.getFavlist();
        if (add) {
            if(!userFav.contains(eskapId)) userFav.add(eskapId);
        }
        else {
            for (int i=0; i < userFav.size(); i++) {
                if(userFav.get(i) == eskapId) userFav.remove(i);
            }
        }
        return saveUser(user);
    }

    @Override
    public User doneEskap(String id, int eskapId, boolean add){
        var user = this.userRepository.findByUserId(id);
        var userDone = user.getDonelist();
        if (add) {
            if(!userDone.contains(eskapId)) userDone.add(eskapId);
        }
        else {
            for (int i=0; i < userDone.size(); i++) {
                if(userDone.get(i) == eskapId) userDone.remove(i);
            }
        }
        return saveUser(user);
    }

    @Autowired
    public void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
}
