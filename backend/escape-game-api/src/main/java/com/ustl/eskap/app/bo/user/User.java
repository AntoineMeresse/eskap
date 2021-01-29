package com.ustl.eskap.app.bo.user;

import java.util.List;

public class User {

    private String id;
    private String firstname;
    private String lastname;
    private List<Integer> donelist;
    private List<Integer> favlist;

    public User() {

    }

    public User(String id, String firstname, String lastname, List<Integer> donelist, List<Integer> favlist) {
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.donelist = donelist;
        this.favlist = favlist;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public List<Integer> getDonelist() {
        return donelist;
    }

    public void setDonelist(List<Integer> donelist) {
        this.donelist = donelist;
    }

    public List<Integer> getFavlist() {
        return favlist;
    }

    public void setFavlist(List<Integer> favlist) {
        this.favlist = favlist;
    }
}
