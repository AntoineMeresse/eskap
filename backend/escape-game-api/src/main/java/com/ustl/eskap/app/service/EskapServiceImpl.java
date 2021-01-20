package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.repository.EskapRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
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

    @Autowired
    public void setEskapRepository(EskapRepository eskapRepository){
        this.eskapRepository = eskapRepository;
    }
}
