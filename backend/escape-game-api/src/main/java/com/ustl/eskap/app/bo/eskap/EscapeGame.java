package com.ustl.eskap.app.bo.eskap;

import javax.persistence.*;
import java.util.List;

@Entity
public class EscapeGame {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private int id;

    //EscapeGameInfos
    private String name;
    private String difficulty;
    private double minprice;
    private double maxprice;
    private String imgurl;
    private String websiteurl;
    private String description;
    private int minplayer;
    private int maxplayer;
    private int roomnumber;

    // Address
    private int number;
    private String street;
    private String city;
    private String country;
    private double latitude;
    private double longitude;

    // Collections
    @ElementCollection
    private List<String> themes;

    @ElementCollection
    private List<Review> reviews;

    // Official
    private Boolean isOfficial;

    public EscapeGame() {

    }

    public EscapeGame(int id, String name, String difficulty, double minprice, double maxprice, String imgurl, String websiteurl, String description, int minplayer, int maxplayer, int roomnumber, int number, String street, String city, String country, double latitude, double longitude, List<String> themes, List<Review> reviews, Boolean isOfficial) {
        this.id = id;
        this.name = name;
        this.difficulty = difficulty;
        this.minprice = minprice;
        this.maxprice = maxprice;
        this.imgurl = imgurl;
        this.websiteurl = websiteurl;
        this.description = description;
        this.minplayer = minplayer;
        this.maxplayer = maxplayer;
        this.roomnumber = roomnumber;
        this.number = number;
        this.street = street;
        this.city = city;
        this.country = country;
        this.latitude = latitude;
        this.longitude = longitude;
        this.themes = themes;
        this.reviews = reviews;
        this.isOfficial = isOfficial;
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

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public double getMinprice() {
        return minprice;
    }

    public void setMinprice(double minprice) {
        this.minprice = minprice;
    }

    public double getMaxprice() {
        return maxprice;
    }

    public void setMaxprice(double maxprice) {
        this.maxprice = maxprice;
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }

    public String getWebsiteurl() {
        return websiteurl;
    }

    public void setWebsiteurl(String websiteurl) {
        this.websiteurl = websiteurl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getMinplayer() {
        return minplayer;
    }

    public void setMinplayer(int minplayer) {
        this.minplayer = minplayer;
    }

    public int getMaxplayer() {
        return maxplayer;
    }

    public void setMaxplayer(int maxplayer) {
        this.maxplayer = maxplayer;
    }

    public int getRoomnumber() {
        return roomnumber;
    }

    public void setRoomnumber(int roomnumber) {
        this.roomnumber = roomnumber;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public List<String> getThemes() {
        return themes;
    }

    public void setThemes(List<String> themes) {
        this.themes = themes;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    public Boolean getOfficial() {
        return isOfficial;
    }

    public void setOfficial(Boolean official) {
        isOfficial = official;
    }
}
