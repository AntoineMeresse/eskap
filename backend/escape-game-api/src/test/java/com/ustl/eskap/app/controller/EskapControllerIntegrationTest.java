package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class EskapControllerIntegrationTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate testRestTemplate;

    @Autowired
    private EskapController eskapController;

    @Test
    void eskapController_shouldBeInstanciated(){
        assertNotNull(eskapController);
    }

    @Test
    void getEskap_withId1_shouldReturnEG1(){
        var eg = this.testRestTemplate.getForObject("http://localhost:"+port+"/eskaps/1", EscapeGame.class);

        assertNotNull(eg);
        assertEquals("EG1", eg.getName());
    }

    @Test
    void getAllEskaps_shouldReturn2(){
        var eskaps = this.testRestTemplate.getForObject("http://localhost:"+port+"/eskaps/", EscapeGame[].class);

        assertNotNull(eskaps);
        assertEquals(2, eskaps.length);
    }
}
