package com.ustl.eskap.app.repository;

import com.ustl.eskap.app.bo.eskap.EscapeGame;

import java.util.List;

public interface EskapRepository {
    EscapeGame findEskapById(int id);
    List<EscapeGame> findAllEskaps();
}
