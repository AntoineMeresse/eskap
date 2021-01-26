package com.ustl.eskap.app.bo.user;

import java.util.List;

public class User {

    private int id;
    private PersonnalInfos infos;
    private List<Integer> friendlist;
    private EskapInfos eskapinfos;

    public User() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public PersonnalInfos getInfos() {
        return infos;
    }

    public void setInfos(PersonnalInfos infos) {
        this.infos = infos;
    }

    public List<Integer> getFriendlist() {
        return friendlist;
    }

    public void setFriendlist(List<Integer> friendlist) {
        this.friendlist = friendlist;
    }

    public EskapInfos getEskapinfos() {
        return eskapinfos;
    }

    public void setEskapinfos(EskapInfos eskapinfos) {
        this.eskapinfos = eskapinfos;
    }
}
