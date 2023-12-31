package com.jafa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class HomeController {

	@GetMapping("/")
	public String home() {
		log.info("홈페이지 접근");
		return "home";
	}
}
