package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.service.EskapService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class EskapControllerTest {

    @Mock
    private EskapService eskapService;

    @InjectMocks
    private EskapController eskapController;

    @BeforeEach
    void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void getAllTrainers_shouldCallTheService() {
        eskapController.getAllEskaps();

        verify(eskapService).getAllEskaps();
    }

    @Test
    void getTrainer_shouldCallTheService() {
        eskapController.getEskapFromId(1);

        verify(eskapService).getEskap(1);
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
