package com.ustl.eskap.app.bo.outing;

import java.util.List;

public class OutingEskapList {

    private int id;
    private List<Integer> usersvote;

    public OutingEskapList() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Integer> getUsersvote() {
        return usersvote;
    }

    public void setUsersvote(List<Integer> usersvote) {
        this.usersvote = usersvote;
    }
}
