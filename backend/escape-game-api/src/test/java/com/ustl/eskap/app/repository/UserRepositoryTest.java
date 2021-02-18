package com.ustl.eskap.app.repository;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.user.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.data.repository.CrudRepository;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

@DataJpaTest
public class UserRepositoryTest {

    @Autowired
    private UserRepository repository;

    @Test
    void userRepository_shouldExtendsCrudRepository() {
        assertTrue(CrudRepository.class.isAssignableFrom(UserRepository.class));
    }

    @Test
    void userRepositoryShouldBeInstanciedBySpring() {
        assertNotNull(repository);
    }

    @Test
    void testSave() {
        User user = new User();
        user.setId("abcde");
        user.setFirstname("Firstname");
        user.setLastname("Lastname");

        repository.save(user);

        var saved = repository.findByUserid(user.getId());
        assertEquals("Firstname", saved.getFirstname());
        assertEquals("Lastname", saved.getLastname());
    }
}
