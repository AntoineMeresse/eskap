package com.ustl.eskap.app.bo;

import java.math.BigDecimal;

public class Price {

    private BigDecimal price;

    public Price(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
