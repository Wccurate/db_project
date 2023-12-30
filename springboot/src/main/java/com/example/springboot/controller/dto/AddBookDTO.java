package com.example.springboot.controller.dto;


import com.example.springboot.entity.Book;
import com.example.springboot.entity.BookUnity;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class AddBookDTO {
    private String isbn; // primary key
    private String name;
    private String description;
    private String category;
    private String publish_date;
    private String author;
    private String publisher;
    private String position;
    private String status;
    private String handler;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date cDate;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT-5")
    private Date uDate;
    private String cover;
    private Integer credit;
    private Integer number;
    private List<String> categories;
    public Book GenerateBook(){
        Book book = new Book();
        book.setIsbn(isbn);
        book.setName(name);
        book.setDescription(description);
        book.setCategory(category);
        book.setPublish_date(publish_date);
        book.setAuthor(author);
        book.setPublisher(publisher);
        book.setUDate(uDate);
        book.setCover(cover);
        book.setCredit(credit);
        book.setNumber(number);
        book.setCategories(categories);
        return book;
    }
    public BookUnity GenerateBookUnity(){
        BookUnity bookUnity = new BookUnity();
        bookUnity.setIsbn(isbn);
        bookUnity.setPosition(position);
        bookUnity.setStatus(status);
        bookUnity.setHandler(handler);
        return bookUnity;
    }
}
