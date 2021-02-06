package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.eskap.Review;

import java.util.List;

public interface EskapService {
    EscapeGame getEskap(int id);
    Iterable<EscapeGame> getAllEskaps();
    Iterable<EscapeGame> getOfficialEskaps();
    Iterable<EscapeGame> getNonOfficialEskaps();
    EscapeGame saveEskap(EscapeGame escapeGame);
    void deleteEskap(int id);

    EscapeGame setEskapToOfficial(int id, boolean official);
    EscapeGame addReview(int id, Review review);
    EscapeGame deleteReview(int id, long reviewId);
}
