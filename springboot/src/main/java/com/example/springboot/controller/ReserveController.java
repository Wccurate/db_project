package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.controller.request.BorrowPageRequest;
import com.example.springboot.controller.request.ReservePageRequest;
import com.example.springboot.entity.Borrow;
import com.example.springboot.entity.Reserve;
import com.example.springboot.mapper.BookMapper;
import com.example.springboot.mapper.ReserveMapper;
import com.example.springboot.service.IReserveService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping("/reserve")
public class ReserveController {
    @Autowired
    IReserveService reserveService;
    @Autowired
    ReserveMapper mapper;
    @Autowired
    BookMapper bookMapper;
    @PostMapping("/save")
    public Result save(@RequestBody Reserve reserve){
        reserveService.save(reserve);
        return Result.success();
    }
    @GetMapping("/page")
    public Result page(ReservePageRequest request) {
        return Result.success(reserveService.page(request));
    }
    @PostMapping("/getBook")
    public Result getBook(@RequestBody Reserve reserve){
        reserveService.getReservedBook(reserve);
        return Result.success();
    }
}
