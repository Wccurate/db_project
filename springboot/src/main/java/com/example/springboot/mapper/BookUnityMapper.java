package com.example.springboot.mapper;

import com.example.springboot.entity.BookUnity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookUnityMapper {
    void save(BookUnity bu);

    List<BookUnity> getBookUnityByISBN(String isbn);
    void UpdateByUnityID(BookUnity bu);
    BookUnity getByBookUnityID(Integer id);
    List<BookUnity> getByISBN(String isbn);
    void deleteByBookUnityID(Integer id);
}
