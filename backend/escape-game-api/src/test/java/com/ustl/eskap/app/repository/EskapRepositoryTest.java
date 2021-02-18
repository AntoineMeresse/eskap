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
        EscapeGame eg = new EscapeGame();
        eg.setId(1);
        eg.setName("Eskap Test");

        eskapRepository.save(eg);

        var saved = eskapRepository.findById(eg.getId());
        assertEquals("Eskap Test", saved.getName());

    }

    @Test
    void testDelete() {
        EscapeGame eg = new EscapeGame();
        eg.setId(1);
        eg.setName("Eskap Test");

        eskapRepository.save(eg);

        var eskaps = eskapRepository.findAll();
        assertEquals(1, eskaps.size());

        eskapRepository.deleteById(eskaps.get(0).getId());
        eskaps = eskapRepository.findAll();
        assertEquals(0, eskaps.size());
    }
}
