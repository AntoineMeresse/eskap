package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.outing.Outing;
import com.ustl.eskap.app.repository.OutingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OutingServiceImpl implements OutingService{
    protected OutingRepository outingRepository;

    public OutingServiceImpl(OutingRepository outingRepository) {
        this.outingRepository = outingRepository;
    }

    public OutingServiceImpl() {

    }

    @Override
    public Outing getOuting(int id) {
        return this.outingRepository.findOutingById(id);
    }

    @Override
    public List<Outing> getAllOutings() {
        return this.outingRepository.findAllOutings();
    }

    @Autowired
    public void setOutingRepository(OutingRepository outingRepository) {
        this.outingRepository = outingRepository;
    }
}
