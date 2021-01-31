package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
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
        return this.eskapService.createEskap(eskap);
    }

    // --------------------------------  Delete MAPPING ---------------------------------------------- //

    @DeleteMapping("/{id}")
    public void deleteEskap(@PathVariable int id) {
        this.eskapService.deleteEskap(id);
    }

    // --------------------------------- PUT MAPPING ------------------------------------------------- //
}
