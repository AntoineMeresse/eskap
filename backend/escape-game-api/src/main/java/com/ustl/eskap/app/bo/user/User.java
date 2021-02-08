package com.ustl.eskap.app.bo.user;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="usereskap")
public class User {

    @Id
    private String userid;

    private String firstname;
    private String lastname;

    @ElementCollection
    private List<Integer> donelist;

    @ElementCollection
    private List<Integer> favlist;

    public User() {

    }

    public User(String id, String firstname, String lastname, List<Integer> donelist, List<Integer> favlist) {
        this.userid = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.donelist = donelist;
        this.favlist = favlist;
    }

    public String getId() {
        return userid;
    }

    public void setId(String id) {
        this.userid = id;
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
