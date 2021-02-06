package com.ustl.eskap.app.service;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.eskap.Review;
import com.ustl.eskap.app.repository.EskapRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
        return this.eskapRepository.findById(id);
    }

    @Override
    public Iterable<EscapeGame> getAllEskaps() {
        return this.eskapRepository.findAll();
    }

    @Override
    public EscapeGame saveEskap(EscapeGame escapeGame) {
        return this.eskapRepository.save(escapeGame);
    }

    @Override
    public void deleteEskap(int id) {
        this.eskapRepository.deleteById(id);
    }

    @Override
    public Iterable<EscapeGame> getNonOfficialEskaps() {
        return this.eskapRepository.findAllNonOfficial();
    }

    @Override
    public Iterable<EscapeGame> getOfficialEskaps() {
        return this.eskapRepository.findAllOfficial();
    }

    @Override
    public EscapeGame setEskapToOfficial(int id, boolean official) {
        EscapeGame escapeGame = getEskap(id);
        escapeGame.setOfficial(official);
        return saveEskap(escapeGame);
    }

    @Override
    public EscapeGame addReview(int id, Review review) {
        EscapeGame escapeGame = getEskap(id);
        escapeGame.getReviews().add(review);
        return saveEskap(escapeGame);
    }

    @Override
    public EscapeGame deleteReview(int id, long reviewId) {
        EscapeGame escapeGame = getEskap(id);
        List<Review> reviews = escapeGame.getReviews();
        if (reviews.size() >= 1) {
            for (int i = 0; i < reviews.size(); i ++) {
                if (reviews.get(i).getReviewId() == reviewId) {
                    reviews.remove(i);
                    return saveEskap(escapeGame);
                }
            }
        }
        return saveEskap(escapeGame);
    }

    @Autowired
    public void setEskapRepository(EskapRepository eskapRepository){
        this.eskapRepository = eskapRepository;
    }
}
