package com.kh.teampl.mj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.teampl.mj.dto.LoginDto;
import com.kh.teampl.mj.vo.MemberVo;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "/mj/user/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(LoginDto loginDto) {
		System.out.println("UserController : " + loginDto);
		return "redirect:/";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register() {
		return "mj/user/register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(MemberVo memberVo) {
		System.out.println("UserController : " + memberVo);
		return "redirect:/mj/main/home";
	}
	
}
