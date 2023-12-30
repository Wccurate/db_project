package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.controller.request.ReturnPageRequest;
import com.example.springboot.entity.Borrow;
import com.example.springboot.entity.Return;
import com.example.springboot.service.IReturnService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/return")
public class ReturnController {
    @Autowired
    IReturnService service;

    @PostMapping("/save")
    public Result save(@RequestBody Borrow borrow) {
        service.save(borrow);
        return Result.success();
    }

    @DeleteMapping("/delete/{email}&{isbn}")
    public Result deleteByEmailAndISBN(@PathVariable String email, @PathVariable String isbn) {
        service.deleteByEmailAndISBN(email, isbn);
        return Result.success();
    }

    @GetMapping("/list")
    public Result list() {
        List<Return> aReturn = service.list();
        return Result.success(aReturn);
    }

    @GetMapping("/page")
    public Result page(ReturnPageRequest request) {
        return Result.success(service.page(request));
    }
}
