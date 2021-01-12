package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.EscapeGame;

import java.util.List;

public interface EskapService {
    EscapeGame getEskap(int id);

    List<EscapeGame> getAllEskaps();
}
