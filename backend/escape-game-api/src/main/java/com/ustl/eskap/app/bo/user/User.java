package com.ustl.eskap.app.bo.user;

import javax.persistence.*;
import java.util.List;

@Entity
public class User {

    @Id
    private String userId;
    private String firstname;
    private String lastname;

    @ElementCollection
    private List<Integer> donelist;

    @ElementCollection
    private List<Integer> favlist;

    public User() {

    }

    public User(String id, String firstname, String lastname, List<Integer> donelist, List<Integer> favlist) {
        this.userId = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.donelist = donelist;
        this.favlist = favlist;
    }

    public String getId() {
        return userId;
    }

    public void setId(String id) {
        this.userId = id;
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
