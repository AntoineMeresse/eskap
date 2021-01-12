package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.EscapeGame;
import com.ustl.eskap.app.repository.EskapRepository;

import java.util.List;

public class EskapServiceImpl implements EskapService{

    protected EskapRepository eskapRepository;

    public EskapServiceImpl(EskapRepository eskapRepository) {
        this.eskapRepository = eskapRepository;
    }

    public EskapServiceImpl(){

    }

    @Override
    public EscapeGame getEskap(int id) {
        return this.eskapRepository.findEskapById(id);
    }

    @Override
    public List<EscapeGame> getAllEskaps() {
        return this.eskapRepository.findAllEskaps();
    }
}
