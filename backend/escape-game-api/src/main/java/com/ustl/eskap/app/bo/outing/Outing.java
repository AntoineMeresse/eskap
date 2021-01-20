package com.ustl.eskap.app.bo.outing;

import java.util.List;

public class Outing {

    private int id;
    private String name;
    private String date;
    private List<OutingEskapList> eskapslist;

    public Outing() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public List<OutingEskapList> getEskapslist() {
        return eskapslist;
    }

    public void setEskapslist(List<OutingEskapList> eskapslist) {
        this.eskapslist = eskapslist;
    }
}
