package com.example.springboot.controller.request;

import lombok.Data;

@Data
public class ReservePageRequest extends BaseRequest{
    private String email;
    private String isbn;
}
