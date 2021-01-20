package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.user.User;
import com.ustl.eskap.app.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{id}")
    public User getUserFromId(@PathVariable int id) {
        return this.userService.getUser(id);
    }

    @GetMapping("/")
    public List<User> getAllUsers() {
        return this.userService.getAllUsers();
    }

    @GetMapping("/{id}/favs")
    public List<Integer> getFavEskapFromUser(@PathVariable int id) {
        return this.userService.getFavEskapFromUser(id);
    }
}
