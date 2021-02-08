package com.ustl.eskap.app.repository;

import com.ustl.eskap.app.bo.user.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends CrudRepository<User, String> {
    User findByUserid(String id);
    List<User> findAll();
    User save(User user);
}
