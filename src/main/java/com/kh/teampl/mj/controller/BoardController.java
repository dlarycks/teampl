package com.kh.teampl.mj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {

	@RequestMapping("/list")
	public String list() {
		System.out.println("list page");
		
		return "/mj/board/list";
	}
}
