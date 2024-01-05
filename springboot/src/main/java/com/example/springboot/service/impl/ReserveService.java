package com.example.springboot.service.impl;

import com.example.springboot.controller.request.BorrowPageRequest;
import com.example.springboot.controller.request.ReservePageRequest;
import com.example.springboot.entity.*;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.*;
import com.example.springboot.service.IReserveService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Objects;

@Slf4j
@Service
public class ReserveService implements IReserveService {
    @Autowired
    ReserveMapper mapper;
    @Autowired
    BookMapper bookMapper;
    @Autowired
    BorrowMapper borrowMapper;
    @Autowired
    BookUnityMapper bookUnityMapper;
    @Autowired
    UserMapper userMapper;
    @Override
    public Object page(ReservePageRequest request) {
        PageHelper.startPage(request.getPageNum(), request.getPageSize());
        List<Reserve> reserves = mapper.listByCondition(request);
        return new PageInfo<>(reserves);
    }

    @Override
    @Transactional
    public void save(Reserve reserve){
        String isbn=reserve.getIsbn();
        String email=reserve.getEmail();
        if(bookMapper.getByISBN(isbn)==null){
            throw new ServiceException("The book does not exist");
        }
        if(bookMapper.getByISBN(isbn).getNumber()!=0){
            throw new ServiceException("The book is available, please borrow it directly");
        }
        if(mapper.getByEmailAndISBN(email,isbn)!=null){
            throw new ServiceException("You have already reserved this book");
        }
        reserve.setReserveTime(LocalDateTime.now());
        mapper.save(reserve);
    }
    @Override
    public void getReservedBook(Reserve reserve){
        if(Objects.isNull(bookMapper.getByISBN(reserve.getIsbn()))){
            throw new ServiceException("Book not exists");
        }
        Reserve r=mapper.getByEmailAndISBN(reserve.getEmail(), reserve.getIsbn());
        if(Objects.isNull(r)){
            throw new ServiceException("Reservation expired or not exists");
        }
        if(r.getBookUnityID()==-1){
            throw new ServiceException("Book reserved isn't available");
        }
        Borrow newBorrow=new Borrow();
        newBorrow.setIsbn(r.getIsbn());
        newBorrow.setEmail(r.getEmail());
        Integer max = 0;
        List<Borrow> records = borrowMapper.selectByEmailAndISBN(r.getEmail(), r.getIsbn());
        if(!records.isEmpty()) {
            for(Borrow record: records) {
                Integer rId = record.getId();
                if(rId > max) {
                    max = rId;
                }
            }
        }
        newBorrow.setId(max + 1);
        newBorrow.setBStatus("Borrowed");
        newBorrow.setCDate(LocalDateTime.now());
        newBorrow.setDuration(r.getDuration());
        newBorrow.setRDate(LocalDateTime.now().plusDays(r.getDuration()));
        newBorrow.setBookUnityID(r.getBookUnityID());
        BookUnity bu = bookUnityMapper.getByBookUnityID(r.getBookUnityID());
        bu.setStatus("Borrowed");
        bookUnityMapper.UpdateByUnityID(bu);
        mapper.deleteByReserveID(r.getId());
        borrowMapper.save(newBorrow);
    }
    @Override
    public void removeExpiredReservation(){
        List<Reserve> reserves = mapper.listAll();
        for(Reserve r:reserves){
            if(ChronoUnit.DAYS.between(r.getReserveTime(), LocalDateTime.now())>10){
                if(r.getBookUnityID()!=-1){
                    BookUnity bu = bookUnityMapper.getByBookUnityID(r.getBookUnityID());
                    bu.setStatus("Available");
                    bookUnityMapper.UpdateByUnityID(bu);
                    Book book = bookMapper.getByISBN(bu.getIsbn());
                    book.setNumber(book.getNumber() + 1);
                    bookMapper.updateByISBN(book);
                }
                mapper.deleteByReserveID(r.getId());
            }
        }
    }
}
