package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.eskap.Review;
import com.ustl.eskap.app.service.EskapService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.web.bind.annotation.*;

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
    void getAllEskaps_shouldCallTheService() {
        eskapController.getAllEskaps();

        verify(eskapService).getAllEskaps();
    }

    @Test
    void getEskap_shouldCallTheService() {
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

    // --------------------------------- GET -----------------------------------------------//

    @Test
    void getEskapFromId_shouldBeAnnotated() throws NoSuchMethodException {
        var getEskapFromId =
                EskapController.class.getDeclaredMethod("getEskapFromId", int.class);
        var getMapping = getEskapFromId.getAnnotation(GetMapping.class);

        assertNotNull(getMapping);
        assertArrayEquals(new String[]{"/{id}"}, getMapping.value());
    }

    @Test
    void getAllOfficialEskaps_shouldBeAnnotated() throws NoSuchMethodException {
        var getAllEskaps =
                EskapController.class.getDeclaredMethod("getAllOfficialEskaps");
        var getMapping = getAllEskaps.getAnnotation(GetMapping.class);

        assertNotNull(getMapping);
        assertArrayEquals(new String[]{"/officials/"}, getMapping.value());
    }

    @Test
    void getAllNonOfficialEskaps_shouldBeAnnotated() throws NoSuchMethodException {
        var getAllEskaps =
                EskapController.class.getDeclaredMethod("getAllNonOfficialEskaps");
        var getMapping = getAllEskaps.getAnnotation(GetMapping.class);

        assertNotNull(getMapping);
        assertArrayEquals(new String[]{"/nonofficials/"}, getMapping.value());
    }

    @Test
    void getAllEskaps_shouldBeAnnotated() throws NoSuchMethodException {
        var getAllEskaps =
                EskapController.class.getDeclaredMethod("getAllEskaps");
        var getMapping = getAllEskaps.getAnnotation(GetMapping.class);

        assertNotNull(getMapping);
        assertArrayEquals(new String[]{"/"}, getMapping.value());
    }

    // --------------------------------- POST -----------------------------------------------//

    @Test
    void postEskap_shouldBeAnnotated() throws NoSuchMethodException {
        // Error to fix
        var postEskap = EskapController.class.getDeclaredMethod("postEskap", EscapeGame.class);

        assertNotNull(postEskap);

        var postMapping = postEskap.getAnnotation(PostMapping.class);

        assertNotNull(postMapping);
        assertArrayEquals(new String[]{"/"}, postMapping.value());
    }

    // --------------------------------- DELETE -----------------------------------------------//

    @Test
    void deleteEskap_shouldBeAnnotated() throws NoSuchMethodException {
        var deleteEskap = EskapController.class.getDeclaredMethod("deleteEskap", int.class);
        assertNotNull(deleteEskap);

        var deleteMapping = deleteEskap.getAnnotation(DeleteMapping.class);

        assertNotNull(deleteMapping);
        assertArrayEquals(new String[]{"/{id}"}, deleteMapping.value());
    }

    // --------------------------------- PUT -----------------------------------------------//

    @Test
    void putEskap_shouldBeAnnotated() throws NoSuchMethodException {
        var putEskap = EskapController.class.getDeclaredMethod("putEskap", EscapeGame.class);
        assertNotNull(putEskap);

        var putMapping = putEskap.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/"}, putMapping.value());
    }

    @Test
    void addOfficialEskap_shouldBeAnnotated() throws NoSuchMethodException {
        var putEskap = EskapController.class.getDeclaredMethod("addOfficialEskap", int.class);
        assertNotNull(putEskap);

        var putMapping = putEskap.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/addofficial/{id}"}, putMapping.value());
    }

    @Test
    void removeOfficial_shouldBeAnnotated() throws NoSuchMethodException {
        var putEskap = EskapController.class.getDeclaredMethod("removeOfficial", int.class);
        assertNotNull(putEskap);

        var putMapping = putEskap.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/deleteofficial/{id}"}, putMapping.value());
    }

    @Test
    void addReview_shouldBeAnnotated() throws NoSuchMethodException {
        var putEskap = EskapController.class.getDeclaredMethod("addReview", int.class, Review.class);
        assertNotNull(putEskap);

        var putMapping = putEskap.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/{id}/reviews/"}, putMapping.value());
    }

    @Test
    void deleteReview_shouldBeAnnotated() throws NoSuchMethodException {
        var putEskap = EskapController.class.getDeclaredMethod("deleteReview", int.class, long.class);
        assertNotNull(putEskap);

        var putMapping = putEskap.getAnnotation(PutMapping.class);

        assertNotNull(putMapping);
        assertArrayEquals(new String[]{"/{id}/reviews/{reviewId}"}, putMapping.value());
    }
}
