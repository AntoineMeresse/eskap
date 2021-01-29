package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.user.User;
import com.ustl.eskap.app.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{id}")
    public User getUserFromId(@PathVariable String id) {
        return this.userService.getUser(id);
    }

    @GetMapping("/")
    public List<User> getAllUsers() {
        return this.userService.getAllUsers();
    }

    @GetMapping("/{id}/favs")
    public List<Integer> getFavEskapFromUser(@PathVariable String id) {
        return this.userService.getFavEskapFromUser(id);
    }

    // --------------------------------- POST MAPPING ------------------------------------------------ //

    @PostMapping("/")
    public User postUser(@RequestBody User user){
        return this.userService.createUser(user);
    }
}
