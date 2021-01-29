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

    // --------------------------------- POST MAPPING ------------------------------------------------ //

    @PostMapping("/")
    public EscapeGame postEskap(@RequestBody EscapeGame eskap){
        return this.eskapService.createEskap(eskap);
    }

    // --------------------------------  Delete MAPPING ---------------------------------------------- //


    // --------------------------------- PUT MAPPING ------------------------------------------------- //
}
