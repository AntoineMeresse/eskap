package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.user.User;
import com.ustl.eskap.app.repository.UserRepository;
import org.junit.jupiter.api.Test;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

public class UserServiceImplTest {

    @Test
    void userRepository_shouldCalled_whenFindAll(){
        var userRepository = mock(UserRepository.class);
        var userService = new UserServiceImpl(userRepository);

        userService.getAllUsers();
        verify(userRepository).findAll();
    }

    @Test
    void userRepository_shouldCalled_whenFindById(){
        var userRepository = mock(UserRepository.class);
        var userService = new UserServiceImpl(userRepository);

        userService.getUser("");
        verify(userRepository).findByUserid("");
    }

    @Test
    void userRepository_shouldCalled_whenSave(){
        var userRepository = mock(UserRepository.class);
        var userService = new UserServiceImpl(userRepository);

        User u = new User();
        userService.saveUser(u);
        verify(userRepository).save(u);
    }
}
