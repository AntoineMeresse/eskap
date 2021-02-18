package com.ustl.eskap.app.bo.user;

import org.junit.jupiter.api.Test;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.Id;

import static org.junit.jupiter.api.Assertions.assertNotNull;

public class UserTest {
    @Test
    void user_shouldBeAnEntity() {
        assertNotNull(User.class.getAnnotation(Entity.class));
    }

    @Test
    void userid_shouldBeAnId() throws NoSuchFieldException {
        assertNotNull(User.class.getDeclaredField("userid").getAnnotation(Id.class));
    }

    @Test
    void userDoneList_shouldBeAElementCollection() throws NoSuchFieldException {
        assertNotNull(User.class.getDeclaredField("donelist").getAnnotation(ElementCollection.class));
    }

    @Test
    void userFavList_shouldBeAElementCollection() throws NoSuchFieldException {
        assertNotNull(User.class.getDeclaredField("favlist").getAnnotation(ElementCollection.class));
    }
}
