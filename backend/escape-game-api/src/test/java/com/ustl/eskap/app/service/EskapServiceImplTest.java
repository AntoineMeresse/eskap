package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.repository.EskapRepository;
import org.junit.jupiter.api.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

public class EskapServiceImplTest {

    @Test
    void eskapRepository_shouldCalled_whenFindAll() {
        var eskapRepository = mock(EskapRepository.class);
        var eskapService = new EskapServiceImpl(eskapRepository);

        eskapService.getAllEskaps();

        verify(eskapRepository).findAll();
    }

    @Test
    void applicationContext_shouldLoadEskapService(){
        var context = new AnnotationConfigApplicationContext("com.ustl.eskap.app");
        var serviceByName = context.getBean("eskapServiceImpl");
        var serviceByClass = context.getBean(EskapService.class);

        assertEquals(serviceByName, serviceByClass);
        assertNotNull(serviceByName);
        assertNotNull(serviceByClass);
    }

    @Test
    void EskapRepository_shouldBeAutowired_withSpring(){
        var context = new AnnotationConfigApplicationContext("com.ustl.eskap.app");
        var service = context.getBean(EskapServiceImpl.class);
        assertNotNull(service.eskapRepository);
    }

    @Test
    void createEscapeGame_shouldCallTheRepository() {
        var eskapRepo = mock(EskapRepository.class);
        var eskapServ = new EskapServiceImpl(eskapRepo);

        var eg = new EscapeGame();
        eskapServ.saveEskap(eg);
        verify(eskapRepo).save(eg);
    }

    @Test
    void deleteEscapeGame_shouldCallTheRepository() {
        var eskapRepo = mock(EskapRepository.class);
        var eskapServ = new EskapServiceImpl(eskapRepo);

        var eg = new EscapeGame();
        eg.setId(1);
        eskapServ.saveEskap(eg);
        eskapServ.deleteEskap(eg.getId());
        verify(eskapRepo).deleteById(eg.getId());
    }

    @Test
    void findAll_shouldCallTheRepository() {
        var eskapRepo = mock(EskapRepository.class);
        var eskapServ = new EskapServiceImpl(eskapRepo);

        eskapServ.getAllEskaps();
        verify(eskapRepo).findAll();
    }

    @Test
    void findById_shouldCallTheRepository() {
        var eskapRepo = mock(EskapRepository.class);
        var eskapServ = new EskapServiceImpl(eskapRepo);

        eskapServ.getEskap(1);
        verify(eskapRepo).findById(1);
    }

    @Test
    void findAllOfficial_shouldCallTheRepository() {
        var eskapRepo = mock(EskapRepository.class);
        var eskapServ = new EskapServiceImpl(eskapRepo);

        eskapServ.getOfficialEskaps();
        verify(eskapRepo).findAllOfficial();
    }

    @Test
    void findAllNonOfficial_shouldCallTheRepository() {
        var eskapRepo = mock(EskapRepository.class);
        var eskapServ = new EskapServiceImpl(eskapRepo);

        eskapServ.getNonOfficialEskaps();
        verify(eskapRepo).findAllNonOfficial();
    }
}
