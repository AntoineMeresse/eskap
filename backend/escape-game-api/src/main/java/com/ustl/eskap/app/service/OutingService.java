package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.outing.Outing;

import java.util.List;

public interface OutingService {
    Outing getOuting(int id);
    List<Outing> getAllOutings();
}
