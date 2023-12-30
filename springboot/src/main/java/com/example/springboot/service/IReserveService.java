package com.example.springboot.service;

import com.example.springboot.controller.request.ReservePageRequest;
import com.example.springboot.entity.Reserve;

public interface IReserveService {
    void save(Reserve reserve);
    Object page(ReservePageRequest request);
    void removeExpiredReservation();
    void getReservedBook(Reserve reserve);
}
