package com.ustl.eskap.app.repository;

import org.junit.jupiter.api.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import static org.junit.jupiter.api.Assertions.*;

public class EskapRepositoryImplTest {

    private EskapRepositoryImpl repository = new EskapRepositoryImpl();

    @Test
    void findEskapById_withId_1(){
        var eskap = repository.findEskapById(1);
        assertNotNull(eskap);
        assertEquals("Eskap 1", eskap.getName());
    }

    @Test
    void findAllEskaps_shouldReturn1(){
        var eskaps = repository.findAllEskaps();
        assertNotNull(eskaps);
        assertEquals(1, eskaps.size());
    }

    @Test
    void applicationContext_shouldLoadEskapRepository(){

        var context = new AnnotationConfigApplicationContext("com.ustl.eskap.app.repository");
        var repoByName = context.getBean("eskapRepositoryImpl");
        var repoByClass = context.getBean(EskapRepository.class);

        assertEquals(repoByName, repoByClass);
        assertNotNull(repoByName);
        assertNotNull(repoByClass);
    }
}
