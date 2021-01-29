package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.user.User;

import java.util.List;

public interface UserService {
    User getUser(String id);
    List<User> getAllUsers();
    List<Integer> getFavEskapFromUser(String id);
    User saveUser(User user);

    User favEskap(String id, int eskapId, boolean add);
}
