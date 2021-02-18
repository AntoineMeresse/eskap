package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.user.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class UserControllerIntegrationTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate testRestTemplate;

    @Autowired
    private UserController userController;

    @Test
    void userController_shouldBeInstanciated(){
        assertNotNull(userController);
    }

    @Test
    void getUser_withIdABCDE_shouldReturnAbcde(){
        var user = this.testRestTemplate.getForObject("http://localhost:"+port+"/users/abcde", User.class);

        assertNotNull(user);
        assertEquals("abcde", user.getId());
    }

    @Test
    void getAllUsers_shouldReturn2(){
        var users = this.testRestTemplate.getForObject("http://localhost:"+port+"/users/", User[].class);

        assertNotNull(users);
        assertEquals(2, users.length);
    }
}
