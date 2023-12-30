package com.example.springboot.mapper;

import com.example.springboot.controller.request.ReservePageRequest;
import com.example.springboot.entity.Reserve;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReserveMapper {
    void save(Reserve reserve);
    Reserve getByEmailAndISBN(String email,String isbn);
    List<Reserve> getByISBN(String isbn);
    void deleteByReserveID(Integer reserveID);
    List<Reserve> listByCondition(ReservePageRequest request);
    List<Reserve> listAll();
    void updateByReserveID(Reserve reserve);
}
