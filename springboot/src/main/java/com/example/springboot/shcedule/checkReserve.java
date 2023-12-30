package com.example.springboot.shcedule;

import com.example.springboot.service.IReserveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class checkReserve {

    @Autowired
    private IReserveService reserveService;

    @Scheduled(fixedDelay = 30)
    public void runReserveServiceTask() {
        reserveService.removeExpiredReservation();
    }
}

