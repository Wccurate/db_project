package com.example.springboot.service;

import com.example.springboot.controller.request.ReturnPageRequest;
import com.example.springboot.entity.Borrow;
import com.example.springboot.entity.Return;

import java.util.List;

public interface IReturnService {
    List<Return> list();

    Object page(ReturnPageRequest request);

    void deleteByEmailAndISBN(String email, String isbn);

    void save(Borrow borrow);
}
