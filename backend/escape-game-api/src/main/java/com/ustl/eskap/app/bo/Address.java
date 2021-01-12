package com.ustl.eskap.app.bo;

public class Address {

    private String number;
    private String street;
    private String city;
    private String stare;
    private int zipCode;

    public Address(String number, String street, String city, String stare, int zipCode) {
        this.number = number;
        this.street = street;
        this.city = city;
        this.stare = stare;
        this.zipCode = zipCode;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
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

    public String getStare() {
        return stare;
    }

    public void setStare(String stare) {
        this.stare = stare;
    }

    public int getZipCode() {
        return zipCode;
    }

    public void setZipCode(int zipCode) {
        this.zipCode = zipCode;
    }
}
