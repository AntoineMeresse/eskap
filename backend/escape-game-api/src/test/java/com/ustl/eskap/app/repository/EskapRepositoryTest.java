package com.ustl.eskap.app.repository;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.eskap.Review;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.data.repository.CrudRepository;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

@DataJpaTest
class EskapRepositoryTest {

    @Autowired
    private EskapRepository eskapRepository;

    @Test
    void eskapRepository_shouldExtendsCrudRepository() {
        assertTrue(CrudRepository.class.isAssignableFrom(EskapRepository.class));
    }

    @Test
    void eskapRepositoryShouldBeInstanciedBySpring() {
        assertNotNull(eskapRepository);
    }

    @Test
    void testSave() {
        List<String> themes = new ArrayList<>();

        // Change this part
        List<Review> reviews = new ArrayList<>();

        EscapeGame eg = new EscapeGame(
                1, "Eskap Test", "Easy", 20.0, "urltest", "descriptiontest",
                1, "rue", "Orchies","France",3.0,2.0, themes, reviews);

        eskapRepository.save(eg);

        var saved = eskapRepository.findById(eg.getId());
        assertEquals("Eskap Test", saved.getName());
    }

    @Test
    void testDelete() {
        List<String> themes = new ArrayList<>();
        // Change this part
        List<Review> reviews = new ArrayList<>();

        EscapeGame eg = new EscapeGame(
                1, "Eskap Test", "Easy", 20.0, "urltest", "descriptiontest",
                1, "rue", "Orchies","France",3.0,2.0, themes, reviews);

        eskapRepository.save(eg);

        var eskaps = eskapRepository.findAll();
        assertEquals(1, eskaps.size());

        eskapRepository.deleteById(eskaps.get(0).getId());
        eskaps = eskapRepository.findAll();
        assertEquals(0, eskaps.size());
    }
}
