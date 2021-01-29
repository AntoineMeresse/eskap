package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.eskap.EscapeGame;
import com.ustl.eskap.app.service.EskapService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/eskaps")
public class EskapController {

    private EskapService eskapService;

    public EskapController(EskapService eskapService) {
        this.eskapService = eskapService;
    }

    @GetMapping("/{id}")
    public EscapeGame getEskapFromId(@PathVariable int id){
        return this.eskapService.getEskap(id);
    }

    @GetMapping("/")
    public Iterable<EscapeGame> getAllEskaps(){
        return this.eskapService.getAllEskaps();
    }
}
