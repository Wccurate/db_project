package com.example.springboot.service.impl;

import com.example.springboot.entity.Book;
import com.example.springboot.entity.BookUnity;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.BookMapper;
import com.example.springboot.mapper.BookUnityMapper;
import com.example.springboot.service.IBookUnityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class BookUnityService implements IBookUnityService {
    @Autowired
    BookUnityMapper mapper;
    @Override
    public void save(BookUnity bu){
        try{
            mapper.save(bu);
        }
        catch(Exception e){
            throw new ServiceException("Book save failed");
        }
    }
}
