package com.example.springboot.service;

import com.example.springboot.entity.BookUnity;

import java.util.List;

public interface IBookUnityService {
    void save(BookUnity bu);
    List<BookUnity> getByISBN(String isbn);
}
