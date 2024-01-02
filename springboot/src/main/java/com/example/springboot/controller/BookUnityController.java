package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.controller.dto.AddBookDTO;
import com.example.springboot.entity.Book;
import com.example.springboot.entity.BookUnity;
import com.example.springboot.service.IBookService;
import com.example.springboot.service.IBookUnityService;
import org.apache.ibatis.jdbc.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

@CrossOrigin
@RestController
@RequestMapping("/bookUnity")
public class BookUnityController {
    @Autowired
    IBookUnityService bookUnityService;
    @Autowired
    IBookService bookService;
    @PostMapping("/save")
    public Result save(@RequestBody AddBookDTO addBookDTO){
        Book book=addBookDTO.GenerateBook();
        BookUnity bookUnity=addBookDTO.GenerateBookUnity();
        if(bookService.checkByISBN(book.getIsbn())){
            book=bookService.getByISBN(book.getIsbn());
            book.setNumber(book.getNumber()+1);
            bookService.sub_updateByISBN(book);
            bookUnityService.save(bookUnity);
        }
        else{
            book.setNumber(1);
            bookService.save(book);
            bookUnityService.save(bookUnity);
        }
        return Result.success();
    }
    @GetMapping("/getBooks")
    public Result getBookUnities(@RequestParam String isbn){
        return Result.success(bookUnityService.getByISBN(isbn));
    }
    @PutMapping("/update")
    public Result editBookUnity(@RequestBody BookUnity bookUnity){
        bookUnityService.updateByBookUnityID(bookUnity);
        return Result.success();
    }
    @DeleteMapping("/delete/{bookUnityID}")
    public Result deleteBookUnity(@PathVariable Integer bookUnityID){
        BookUnity bu = bookUnityService.getByBookUnityID(bookUnityID);
        if(Objects.equals(bu.getStatus(), "Available")){
            Book book = bookService.getByISBN(bu.getIsbn());
            book.setNumber(book.getNumber()-1);
            bookService.sub_updateByISBN(book);
        }
        bookUnityService.deleteByBookUnityID(bookUnityID);
        return Result.success();
    }
}
