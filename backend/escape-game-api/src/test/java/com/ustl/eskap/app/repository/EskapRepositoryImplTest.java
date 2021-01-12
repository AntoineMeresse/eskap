package com.ustl.eskap.app.repository;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class EskapRepositoryImplTest {

    private EskapRepositoryImpl repository = new EskapRepositoryImpl();

    @Test
    void findEskapById_withId_1(){
        var eskap = repository.findEskapById(1);
        assertNotNull(eskap);
    }

    @Test
    void findAllEskaps_shouldReturn1(){
        var eskaps = repository.findAllEskaps();
        assertNotNull(eskaps);
        assertEquals(1, eskaps.size());
    }
}
