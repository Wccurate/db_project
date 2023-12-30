package com.example.springboot.mapper;

import com.example.springboot.controller.request.ReturnPageRequest;
import com.example.springboot.entity.Return;
import com.example.springboot.mapper.po.BorrowReturnCountPO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReturnMapper {
    List<Return> list();

    List<Return> listByCondition(ReturnPageRequest request);

    void deleteByEmailAndISBN(String email, String isbn);

    void save(Return aReturn);

    List<Return> selectByEmailAndISBN(String email, String isbn);

    List<BorrowReturnCountPO> countByADate(String range);
}
