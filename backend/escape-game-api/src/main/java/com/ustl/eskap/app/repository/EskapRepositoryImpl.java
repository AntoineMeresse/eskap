package com.ustl.eskap.app.repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ustl.eskap.app.bo.EscapeGame;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class EskapRepositoryImpl implements EskapRepository{

    private List<EscapeGame> eskaps;

    public EskapRepositoryImpl() {
         try {
             var eskapsStream = this.getClass().getResourceAsStream("/eskaps.json");
             var objectMapper = new ObjectMapper();
             var eskapsArray = objectMapper.readValue(eskapsStream, EscapeGame[].class);
             this.eskaps = Arrays.asList(eskapsArray);
         }
         catch (IOException e) {
             e.printStackTrace();
         }
    }

    @Override
    public EscapeGame findEskapById(int id) {
        for (EscapeGame eg : eskaps) {
            if (eg.getId() == id) return eg;
        }
        return null;
    }

    @Override
    public List<EscapeGame> findAllEskaps() {
        return eskaps;
    }
}
