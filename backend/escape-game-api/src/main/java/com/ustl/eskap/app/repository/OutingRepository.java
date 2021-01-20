package com.ustl.eskap.app.repository;

import com.ustl.eskap.app.bo.outing.Outing;

import java.util.List;

public interface OutingRepository {
    Outing findOutingById(int id);
    List<Outing> findAllOutings();
}
