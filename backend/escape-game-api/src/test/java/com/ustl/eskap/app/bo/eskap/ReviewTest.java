package com.ustl.eskap.app.bo.eskap;

import org.junit.jupiter.api.Test;

import javax.persistence.Embeddable;

import static org.junit.Assert.assertNotNull;

public class ReviewTest {
    @Test
    void should_shouldBeAnEmbeddable(){
        assertNotNull(Review.class.getAnnotation(Embeddable.class));
    }
}
