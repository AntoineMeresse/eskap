package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.EscapeGame;
import com.ustl.eskap.app.service.EskapService;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class EskapControllerTest {

    @Test
    void getPokemonType_shouldCallTheService(){
        var service = mock(EskapService.class);
        var controller = new EskapController(service);

        var eskap1 = new EscapeGame();
        eskap1.setId(1);
        eskap1.setName("Eskap 1");
        when(service.getEskap(1)).thenReturn(eskap1);

        var eskap = controller.getEskapFromId(1);
        assertEquals("Eskap 1", eskap.getName());

        verify(service).getEskap(1);
    }

    @Test
    void getAllPokemonTypes_shouldCallTheService(){
        var service = mock(EskapService.class);
        var controller = new EskapController(service);

        controller.getAllEskaps();

        verify(service).getAllEskaps();
    }

}
