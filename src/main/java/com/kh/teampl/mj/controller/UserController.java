package com.kh.teampl.mj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.teampl.mj.dto.LoginDto;
import com.kh.teampl.mj.service.MemberService;
import com.kh.teampl.mj.vo.MemberVo;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "/mj/user/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(LoginDto loginDto) {
//		System.out.println("UserController : " + loginDto);
		return "redirect:/";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register() {
		return "mj/user/register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(MemberVo memberVo, RedirectAttributes rttr) {
//		System.out.println("UserController : " + memberVo);
		memberService.register(memberVo);
		rttr.addFlashAttribute("register_result", "success");
		rttr.addFlashAttribute("register_name", memberVo.getMember_name());
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value = "/isDup", method = RequestMethod.POST)
	public String isDup(String member_id) {
//		System.out.println("UserController : " + member_id);
		int count = memberService.isDup(member_id);
		if (count == 1) {
			return "fail";
		}
		return "success";
	}
}
