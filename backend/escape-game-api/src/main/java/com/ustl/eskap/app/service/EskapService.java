package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.eskap.EscapeGame;

import java.util.List;

public interface EskapService {
    EscapeGame getEskap(int id);
    Iterable<EscapeGame> getAllEskaps();
    Iterable<EscapeGame> getOfficialEskaps();
    Iterable<EscapeGame> getNonOfficialEskaps();
    EscapeGame saveEskap(EscapeGame escapeGame);
    void deleteEskap(int id);

    EscapeGame setEskapToOfficial(int id, boolean official);
}
