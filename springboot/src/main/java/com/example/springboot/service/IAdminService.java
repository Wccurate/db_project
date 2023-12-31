package com.example.springboot.service;

import com.example.springboot.controller.dto.LoginDTO;
import com.example.springboot.controller.request.AdminPageRequest;
import com.example.springboot.controller.request.LoginRequest;
import com.example.springboot.controller.request.PasswordRequest;
import com.example.springboot.entity.Admin;

import java.util.List;

public interface IAdminService {
    List<Admin> list();

    Object page(AdminPageRequest adminPageRequest);

    void save(Admin admin);

    Admin getByEmail(String email);

    void updateByEmail(Admin admin);

    void deleteByEmail(String email);

    LoginDTO login(LoginRequest request);

    void changePass(PasswordRequest request);

    void resetPass(PasswordRequest request);
}
