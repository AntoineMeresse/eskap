package com.ustl.eskap.app.bo.eskap;

import javax.persistence.Embeddable;

@Embeddable
public class Review {

    private long reviewId;
    private String userId;
    private String text;
    private double rate;
    private String date;

    public Review () {

    }

    public Review(long reviewId, String userId, String text, double rate, String date) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.text = text;
        this.rate = rate;
        this.date = date;
    }

    public long getReviewId() {
        return reviewId;
    }

    public void setReviewId(long reviewId) {
        this.reviewId = reviewId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
