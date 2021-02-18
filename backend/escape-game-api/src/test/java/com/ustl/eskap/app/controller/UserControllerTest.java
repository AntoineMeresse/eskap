package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.user.User;
import com.ustl.eskap.app.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.web.bind.annotation.*;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class UserControllerTest {

    @Mock
    private UserService userService;

    @InjectMocks
    private UserController userController;

    @BeforeEach
    void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void userController_shouldBeAnnotated(){
        var controllerAnnotation =
                UserController.class.getAnnotation(RestController.class);
        assertNotNull(controllerAnnotation);

        var requestMappingAnnotation =
                UserController.class.getAnnotation(RequestMapping.class);
        assertArrayEquals(new String[]{"/users"}, requestMappingAnnotation.value());
    }

    // --------------------------------- GET -----------------------------------------------//

    @Test
    void getUserFromId_shouldBeAnnotated() throws NoSuchMethodException {
        var getUserFromId = UserController.class.getDeclaredMethod("getUserFromId", String.class);
        var getMapping = getUserFromId.getAnnotation(GetMapping.class);

        assertNotNull(getMapping);
        assertArrayEquals(new String[]{"/{id}"}, getMapping.value());
    }

    @Test
    void getAllUsers_shouldBeAnnotated() throws NoSuchMethodException {
        var getUsers = UserController.class.getDeclaredMethod("getAllUsers");
        var getMapping = getUsers.getAnnotation(GetMapping.class);

        assertNotNull(getMapping);
        assertArrayEquals(new String[]{"/"}, getMapping.value());
    }

    // --------------------------------- POST -----------------------------------------------//

    @Test
    void postUser_shouldBeAnnotated() throws NoSuchMethodException {
        var postUser = UserController.class.getDeclaredMethod("postUser", User.class);
        var postMapping = postUser.getAnnotation(PostMapping.class);

        assertNotNull(postMapping);
        assertArrayEquals(new String[]{"/"}, postMapping.value());
    }

    // --------------------------------- DELETE -----------------------------------------------//

    // --------------------------------- PUT -----------------------------------------------//

    @Test
    void updateUser_shouldBeAnnotated() throws NoSuchMethodException {
        var putUser = UserController.class.getDeclaredMethod("updateUser", User.class);
        var putMapping = putUser.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/"}, putMapping.value());
    }

    @Test
    void addFavEskap_shouldBeAnnotated() throws NoSuchMethodException {
        var putUser = UserController.class.getDeclaredMethod("addFavEskap", String.class, int.class);
        var putMapping = putUser.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/{id}/favs/add/{eskapId}"}, putMapping.value());
    }

    @Test
    void deleteFavEskap_shouldBeAnnotated() throws NoSuchMethodException {
        var putUser = UserController.class.getDeclaredMethod("deleteFavEskap", String.class, int.class);
        var putMapping = putUser.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/{id}/favs/delete/{eskapId}"}, putMapping.value());
    }

    @Test
    void addDoneEskap_shouldBeAnnotated() throws NoSuchMethodException {
        var putUser = UserController.class.getDeclaredMethod("addDoneEskap", String.class, int.class);
        var putMapping = putUser.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/{id}/done/add/{eskapId}"}, putMapping.value());
    }

    @Test
    void deleteDoneEskap_shouldBeAnnotated() throws NoSuchMethodException {
        var putUser = UserController.class.getDeclaredMethod("deleteDoneEskap", String.class, int.class);
        var putMapping = putUser.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/{id}/done/delete/{eskapId}"}, putMapping.value());
    }
}
