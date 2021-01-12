package com.ustl.eskap.app.bo;

public class EscapeGame {

    private int id;
    private String name;
    //private Address address;
    //private Theme theme;
    //private Difficulty difficulty;
    //private Price price;

    public EscapeGame() {

    }

    /*
    public EscapeGame(int id, String name, Address address, Theme theme, Difficulty difficulty, Price price) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.theme = theme;
        this.difficulty = difficulty;
        this.price = price;
    }
    */

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

    /*
    public Address getAddress() {
        return address;
    }

    public void setAddress(Address adress) {
        this.address = adress;
    }

    public Theme getTheme() {
        return theme;
    }

    public void setTheme(Theme theme) {
        this.theme = theme;
    }

    public Difficulty getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(Difficulty difficulty) {
        this.difficulty = difficulty;
    }

    public Price getPrice() {
        return price;
    }

    public void setPrice(Price price) {
        this.price = price;
    }
     */
}
