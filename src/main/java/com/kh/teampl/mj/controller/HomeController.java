package com.kh.teampl.mj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	@RequestMapping("/")
	public String home() {
		return "/mj/board/list";
	}
}
