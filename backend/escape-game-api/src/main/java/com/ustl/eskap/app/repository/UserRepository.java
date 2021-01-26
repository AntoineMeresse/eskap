package com.ustl.eskap.app.repository;

import com.ustl.eskap.app.bo.user.User;

import java.util.List;

public interface UserRepository {
    User findUserById(int id);
    List<User> findAllUsers();
    List<Integer> findFavEskapFromUserById(int id);
}
