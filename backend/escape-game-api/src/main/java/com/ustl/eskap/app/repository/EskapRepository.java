package com.ustl.eskap.app.repository;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EskapRepository extends CrudRepository<EscapeGame, Integer> {
    // Get
    List<EscapeGame> findAll();
    EscapeGame findById(int id);

    // POST
    EscapeGame save(EscapeGame escapeGame);
}
