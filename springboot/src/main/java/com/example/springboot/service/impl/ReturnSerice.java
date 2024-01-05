package com.example.springboot.service.impl;

import com.example.springboot.controller.request.ReturnPageRequest;
import com.example.springboot.entity.*;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.*;
import com.example.springboot.service.IReturnService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Objects;

@Service
public class ReturnSerice implements IReturnService {
    private static final String RETURNED = "Returned";
    @Autowired
    ReturnMapper mapper;

    @Autowired
    BookMapper bookMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    BorrowMapper borrowMapper;

    @Autowired
    ReserveMapper reserveMapper;

    @Autowired
    JavaMailSender mailSender;
    @Autowired
    BookUnityMapper bookUnityMapper;

    @Override
    public List<Return> list() {
        return mapper.list();
    }

    @Override
    public Object page(ReturnPageRequest request) {
        PageHelper.startPage(request.getPageNum(), request.getPageSize());
        List<Return> aReturn = mapper.listByCondition(request);
        return new PageInfo<>(aReturn);
    }

    @Override
    public void deleteByEmailAndISBN(String email, String isbn) {
        try {
            mapper.deleteByEmailAndISBN(email, isbn);
        } catch (Exception e) {
            throw new ServiceException("Deletion failed, Please contact the administrator");
        }
    }

    @Override
    @Transactional
    public void save(Borrow borrow) {
        // get isbn and email
        String isbn = borrow.getIsbn();
        String email = borrow.getEmail();
        Integer id = borrow.getId();
        borrow = borrowMapper.getByEmailAndISBN(email, isbn, id);
        List<Reserve> reserves = reserveMapper.getByISBN(isbn);
        // verify the borrow record
        try {
            borrowMapper.getByEmailAndISBN(email, isbn, id);
        } catch (Exception e) {
            throw new ServiceException("Illegal Operation");
        }
        // record found, status changed in the borrow record
        borrow.setBStatus(RETURNED);
        borrowMapper.updateByEmailAndISBN(borrow);
        Book book = bookMapper.getByISBN(isbn);
        boolean flag = false;
        Reserve reserve=null;
        for(Reserve r:reserves){
            if(borrowMapper.getByEmail(r.getEmail()).size()<10 && ChronoUnit.DAYS.between(r.getReserveTime(), LocalDateTime.now())<=10){
                flag=true;
                reserve=r;
                break;
            }
        }
        if(!flag) {
            // book number increase
            BookUnity bu1 = bookUnityMapper.getByBookUnityID(borrow.getBook_unity_id());
            bu1.setStatus("Available");
            bookUnityMapper.UpdateByUnityID(bu1);
            book.setNumber(book.getNumber() + 1);
            bookMapper.updateByISBN(book);
        }
        else{
            reserve.setBookUnityID(borrow.getBook_unity_id());
            reserveMapper.updateByReserveID(reserve);
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("2469262728@qq.com");
            message.setTo(reserve.getEmail());
            message.setSubject("Reservation Service");
            message.setText("The book: "+bookMapper.getByISBN(borrow.getIsbn()).getName()+" is returned, please come to borrow it.");
            mailSender.send(message);
            BookUnity bu1 = bookUnityMapper.getByBookUnityID(borrow.getBook_unity_id());
            bu1.setStatus("Reserved");
            bookUnityMapper.UpdateByUnityID(bu1);
        }
        // return some credit if the book is returned before the due date
        User user = userMapper.getByEmail(email);
        LocalDateTime now = LocalDateTime.now();
        Integer returnCredit = 0;
        long realDuration = borrow.getCDate().until(now, ChronoUnit.DAYS);
        if(realDuration == 0) { // return on the same date of create date
            user.setACredit(user.getACredit() + book.getCredit());
        } else {
            if(now.isBefore(borrow.getRDate())) { // refund
                realDuration = now.until(borrow.getRDate(), ChronoUnit.DAYS);
                returnCredit = Math.toIntExact(book.getCredit() * realDuration);
                user.setACredit(user.getACredit() + returnCredit); // original + payback
            } else if(now.isAfter(borrow.getRDate())) {
                realDuration = borrow.getRDate().until(now, ChronoUnit.DAYS);
                Integer chargeCredit = 2 * Math.toIntExact(book.getCredit() * realDuration); // past due penalty
                user.setACredit(user.getACredit() - chargeCredit); // original - penalty
            }
            if(user.getACredit() < 0) { // lock account if the score is negative
                user.setStatus(false);
            }
        }
        userMapper.updateByEmail(user);
        // generate record id
        Integer max = 0;
        List<Return> records = mapper.selectByEmailAndISBN(email, isbn);
        if(!records.isEmpty()) {
            for(Return record: records) {
                Integer rId = record.getId();
                if(rId > max) {
                    max = rId;
                }
            }
        }
        // generate return record
        Return aReturn = new Return();
        aReturn.setIsbn(isbn);
        aReturn.setEmail(email);
        aReturn.setCDate(borrow.getCDate());
        aReturn.setDuration(borrow.getDuration());
        aReturn.setBStatus(RETURNED);
        aReturn.setRDate(borrow.getRDate());
        aReturn.setADate(now);
        aReturn.setId(max + 1);
        // upload to the database
        try {
            mapper.save(aReturn);
        } catch (Exception e) {
            throw new ServiceException("Return failed, please contact the administrator");
        }
    }
//    @Override
//    @Transactional
//    public void save(Borrow borrow) {
//        // get isbn and email
//        String isbn = borrow.getIsbn();
//        String email = borrow.getEmail();
//        Integer id = borrow.getId();
//        List<Reserve> reserves = reserveMapper.getByISBN(isbn);
//        // verify the borrow record
//        try {
//            borrowMapper.getByEmailAndISBN(email, isbn, id);
//        } catch (Exception e) {
//            throw new ServiceException("Illegal Operation");
//        }
//        // record found, status changed in the borrow record
//        borrow.setBStatus(RETURNED);
//        borrowMapper.updateByEmailAndISBN(borrow);
//        // book number increase
//        Book book = bookMapper.getByISBN(isbn);
//        book.setNumber(book.getNumber() + 1);
//        bookMapper.updateByISBN(book);
//        // return some credit if the book is returned before the due date
//        User user = userMapper.getByEmail(email);
//        LocalDateTime now = LocalDateTime.now();
//        Integer returnCredit = 0;
//        long realDuration = borrow.getCDate().until(now, ChronoUnit.DAYS);
//        if(realDuration == 0) { // return on the same date of create date
//            user.setACredit(user.getACredit() + book.getCredit());
//        } else {
//            if(now.isBefore(borrow.getRDate())) { // refund
//                realDuration = now.until(borrow.getRDate(), ChronoUnit.DAYS);
//                returnCredit = Math.toIntExact(book.getCredit() * realDuration);
//                user.setACredit(user.getACredit() + returnCredit); // original + payback
//            } else if(now.isAfter(borrow.getRDate())) {
//                realDuration = borrow.getRDate().until(now, ChronoUnit.DAYS);
//                Integer chargeCredit = 2 * Math.toIntExact(book.getCredit() * realDuration); // past due penalty
//                user.setACredit(user.getACredit() - chargeCredit); // original - penalty
//            }
//            if(user.getACredit() < 0) { // lock account if the score is negative
//                user.setStatus(false);
//            }
//        }
//        userMapper.updateByEmail(user);
//        // generate record id
//        Integer max = 0;
//        List<Return> records = mapper.selectByEmailAndISBN(email, isbn);
//        if(!records.isEmpty()) {
//            for(Return record: records) {
//                Integer rId = record.getId();
//                if(rId > max) {
//                    max = rId;
//                }
//            }
//        }
//        // generate return record
//        Return aReturn = new Return();
//        aReturn.setIsbn(isbn);
//        aReturn.setEmail(email);
//        aReturn.setCDate(borrow.getCDate());
//        aReturn.setDuration(borrow.getDuration());
//        aReturn.setBStatus(RETURNED);
//        aReturn.setRDate(borrow.getRDate());
//        aReturn.setADate(now);
//        aReturn.setId(max + 1);
//        // upload to the database
//        try {
//            mapper.save(aReturn);
//        } catch (Exception e) {
//            throw new ServiceException("Return failed, please contact the administrator");
//        }
//    }
}
