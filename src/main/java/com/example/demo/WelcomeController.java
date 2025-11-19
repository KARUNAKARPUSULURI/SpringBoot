package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {
    
    @GetMapping({"/", "/welcome"})
    public String welcome(){
        return "Hello this is my first api";
    }

}
