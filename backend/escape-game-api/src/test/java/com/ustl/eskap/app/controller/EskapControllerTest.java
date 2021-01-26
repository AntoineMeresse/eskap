package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.service.EskapService;
import org.junit.jupiter.api.Test;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class EskapControllerTest {

    @Test
    void getEscapeGame_shouldCallTheService(){
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
    void getAllEscapeGames_shouldCallTheService(){
        var service = mock(EskapService.class);
        var controller = new EskapController(service);

        controller.getAllEskaps();

        verify(service).getAllEskaps();
    }

    @Test
    void eskapController_shouldBeAnnotated(){
        var controllerAnnotation =
                EskapController.class.getAnnotation(RestController.class);
        assertNotNull(controllerAnnotation);

        var requestMappingAnnotation =
                EskapController.class.getAnnotation(RequestMapping.class);
        assertArrayEquals(new String[]{"/eskaps"}, requestMappingAnnotation.value());
    }

    @Test
    void getEskapFromId_shouldBeAnnotated() throws NoSuchMethodException {
        var getEskapFromId =
                EskapController.class.getDeclaredMethod("getEskapFromId", int.class);
        var getMapping = getEskapFromId.getAnnotation(GetMapping.class);

        assertNotNull(getMapping);
        assertArrayEquals(new String[]{"/{id}"}, getMapping.value());
    }

    @Test
    void getAllEskaps_shouldBeAnnotated() throws NoSuchMethodException {
        var getAllEskaps =
                EskapController.class.getDeclaredMethod("getAllEskaps");
        var getMapping = getAllEskaps.getAnnotation(GetMapping.class);

        assertNotNull(getMapping);
        assertArrayEquals(new String[]{"/"}, getMapping.value());
    }
}
