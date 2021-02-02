package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.bo.eskap.Review;
import com.ustl.eskap.app.service.EskapService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/eskaps")
public class EskapController {

    private EskapService eskapService;

    public EskapController(EskapService eskapService) {
        this.eskapService = eskapService;
    }

    // --------------------------------- GET MAPPING ------------------------------------------------ //

    @GetMapping("/{id}")
    public EscapeGame getEskapFromId(@PathVariable int id){
        return this.eskapService.getEskap(id);
    }

    @GetMapping("/")
    public Iterable<EscapeGame> getAllEskaps(){
        return this.eskapService.getAllEskaps();
    }

    @GetMapping("/officials/")
    public Iterable<EscapeGame> getAllOfficialEskaps(){
        return this.eskapService.getOfficialEskaps();
    }

    @GetMapping("/nonofficials/")
    public Iterable<EscapeGame> getAllNonOfficialEskaps(){
        return this.eskapService.getNonOfficialEskaps();
    }

    // --------------------------------- POST MAPPING ------------------------------------------------ //

    @PostMapping("/")
    public EscapeGame postEskap(@RequestBody EscapeGame eskap){
        return this.eskapService.saveEskap(eskap);
    }

    // --------------------------------  Delete MAPPING ---------------------------------------------- //

    @DeleteMapping("/{id}")
    public void deleteEskap(@PathVariable int id) {
        this.eskapService.deleteEskap(id);
    }

    // --------------------------------- PUT MAPPING ------------------------------------------------- //

    @PutMapping("/")
    public EscapeGame putEskap(@RequestBody EscapeGame eskap){
        return this.eskapService.saveEskap(eskap);
    }

    @PutMapping("/addofficial/{id}")
    public EscapeGame addOfficialEskap(@PathVariable int id){
        return this.eskapService.setEskapToOfficial(id, true);
    }

    @PutMapping("/deleteofficial/{id}")
    public EscapeGame removeOfficial(@PathVariable int id){
        return this.eskapService.setEskapToOfficial(id, false);
    }

    @PutMapping("/{id}/reviews/")
    public EscapeGame addReview(@PathVariable int id, @RequestBody Review review) {
        return this.eskapService.addReview(id, review);
    }

    @PutMapping("/{id}/reviews/{reviewId}")
    public EscapeGame deleteReview(@PathVariable int id, @PathVariable int reviewId) {
        return this.eskapService.deleteReview(id, reviewId);
    }
}
