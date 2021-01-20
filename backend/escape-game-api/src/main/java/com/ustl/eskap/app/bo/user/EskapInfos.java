package com.ustl.eskap.app.bo.user;

import java.util.List;

public class EskapInfos {

    private List<Integer> donelist;
    private List<Integer> favlist;

    public EskapInfos() {

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
