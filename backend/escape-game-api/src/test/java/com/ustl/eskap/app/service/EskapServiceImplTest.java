package com.ustl.eskap.app.service;

import com.ustl.eskap.app.repository.EskapRepository;
import org.junit.jupiter.api.Test;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

public class EskapServiceImplTest {

    @Test
    void eskapRepository_shouldCalled_whenFindById(){
        var eskapRepository = mock(EskapRepository.class);
        var eskapService = new EskapServiceImpl(eskapRepository);

        eskapService.getEskap(1);

        verify(eskapRepository).findEskapById(1);
    }

    @Test
    void eskapRepository_shouldCalled_whenFindAll() {
        var eskapRepository = mock(EskapRepository.class);
        var eskapService = new EskapServiceImpl(eskapRepository);

        eskapService.getAllEskaps();

        verify(eskapRepository).findAllEskaps();
    }
}
