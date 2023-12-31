package com.example.springboot.service.impl;

import com.example.springboot.entity.BookUnity;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.BookUnityMapper;
import com.example.springboot.service.IBookUnityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    @Override
    public List<BookUnity> getByISBN(String isbn){
        return mapper.getByISBN(isbn);
    }
    @Override
    public void updateByBookUnityID(BookUnity bu){
        try{
            mapper.UpdateByUnityID(bu);
        }
        catch(Exception e) {
            throw new ServiceException("BookUnity update failed");
        }
    }
    @Override
    public BookUnity getByBookUnityID(Integer bookUnityID){
        return mapper.getByBookUnityID(bookUnityID);
    }
    @Override
    public void deleteByBookUnityID(Integer bookUnityID){
        try{
            mapper.deleteByBookUnityID(bookUnityID);
        }
        catch(Exception e){
            throw new ServiceException("BookUnity delete failed");
        }
    }
}
