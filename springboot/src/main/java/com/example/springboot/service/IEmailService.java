package com.example.springboot.service;

public interface IEmailService {
    void sendSimpleMessage(String to, String subject, String text);
}
