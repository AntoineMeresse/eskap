package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.EscapeGame;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class EskapControllerIntegrationTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @Autowired
    private EskapController controller;

    @Test
    void eskapController_shouldBeInstanciated(){
        assertNotNull(controller);
    }

    @Test
    void getEscapeGame_withId1() throws Exception{
        var url = "http://localhost:"+port+"/eskaps/1";
        var eskap = this.restTemplate.getForObject(url, EscapeGame.class);

        assertNotNull(eskap);
        assertEquals(1,eskap.getId());
        assertEquals("Eskap 1", eskap.getName());
    }
}
