package com.ustl.eskap.app.repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ustl.eskap.app.bo.outing.Outing;
import com.ustl.eskap.app.bo.user.User;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Repository
public class OutingRepositoryImpl implements OutingRepository{

    private List<Outing> outings;

    public OutingRepositoryImpl(){
        try {
            var outingStream = this.getClass().getResourceAsStream("/sortie.json");
            var objectMapper = new ObjectMapper();
            var outingArray = objectMapper.readValue(outingStream, Outing[].class);
            this.outings = Arrays.asList(outingArray);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Outing findOutingById(int id) {
        for (Outing outing : outings) {
            if (outing.getId() == id) return outing;
        }
        return null;
    }

    @Override
    public List<Outing> findAllOutings() {
        return outings;
    }
}
