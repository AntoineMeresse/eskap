package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.eskap.EscapeGame;

import java.util.List;

public interface EskapService {
    EscapeGame getEskap(int id);

    List<EscapeGame> getAllEskaps();
}
