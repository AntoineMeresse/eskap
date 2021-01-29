package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.eskap.EscapeGame;

import java.util.List;

public interface EskapService {
    EscapeGame getEskap(int id);
    Iterable<EscapeGame> getAllEskaps();
    EscapeGame createEskap(EscapeGame escapeGame);
    void deleteEskap(int id);
}
