package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.Borrow;
import com.example.springboot.service.IBookService;
import com.example.springboot.service.IBookUnityService;
import com.example.springboot.service.IEmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping("/email")
public class EmailController {
    @Autowired
    IEmailService emailService;
    @Autowired
    IBookService bookService;
    @PostMapping("/sendWarning")
    public Result sendWarning(@RequestBody Borrow borrow){
        Book book=bookService.getByISBN(borrow.getIsbn());
        emailService.sendSimpleMessage(borrow.getEmail(),"Book loan timeout reminder","The book: "+book.getName()+" you borrow is about/already expired, please return it as soon as possible.");
        return Result.success();
    }
}
