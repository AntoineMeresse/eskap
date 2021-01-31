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
    private double price;
    private String imgurl;
    private String description;

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

    public EscapeGame(int id, String name, String difficulty, double price, String imgurl, String description,
                      int number, String street, String city, String country, double latitude, double longitude,
                      List<String> themes, List<Review> reviews, Boolean isOfficial) {
        this.id = id;
        this.name = name;
        this.difficulty = difficulty;
        this.price = price;
        this.imgurl = imgurl;
        this.description = description;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
