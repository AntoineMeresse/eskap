package com.ustl.eskap.app.controller;

import com.ustl.eskap.app.bo.outing.Outing;
import com.ustl.eskap.app.service.OutingService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/outings")
public class OutingController {

    private OutingService outingService;

    public OutingController(OutingService outingService) {
        this.outingService = outingService;
    }

    @GetMapping("/{id}")
    public Outing getOutingFromId(@PathVariable int id) {
        return this.outingService.getOuting(id);
    }

    @GetMapping("/")
    public List<Outing> getAllOutings() {
        return this.outingService.getAllOutings();
    }
}
