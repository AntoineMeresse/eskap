package com.ustl.eskap.app.bo.eskap;

import org.junit.jupiter.api.Test;
import javax.persistence.*;
import static org.junit.jupiter.api.Assertions.*;

public class EscapeGameTest {

    @Test
    void escapeGame_shouldBeAnEntity() {
        assertNotNull(EscapeGame.class.getAnnotation(Entity.class));
    }

    @Test
    void escapeGameId_shouldBeAnId() throws NoSuchFieldException {
        assertNotNull(EscapeGame.class.getDeclaredField("id").getAnnotation(Id.class));
    }

    @Test
    void escapeGameReviews_shouldBeAElementCollection() throws NoSuchFieldException {
        assertNotNull(EscapeGame.class.getDeclaredField("reviews").getAnnotation(ElementCollection.class));
    }

    @Test
    void escapeGameThemes_shouldBeAElementCollection() throws NoSuchFieldException {
        assertNotNull(EscapeGame.class.getDeclaredField("themes").getAnnotation(ElementCollection.class));
    }
}
