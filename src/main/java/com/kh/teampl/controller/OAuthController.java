package com.kh.teampl.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.teampl.dto.LoginDto;
import com.kh.teampl.service.MemberService;
import com.kh.teampl.vo.MemberVo;

@Controller
@RequestMapping("/oauth")
public class OAuthController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/kakao", method = RequestMethod.POST)
    public String kakaoCallback(HttpSession session, String member_id) {
		
		member_id = member_id + "(kakao)";
		chkFirstLogin(member_id);
		
        LoginDto loginDto = new LoginDto();
        loginDto.setMember_id(member_id);
        session.setAttribute("loginInfo", loginDto);
        return "redirect:/";
    }
	
	@RequestMapping(value = "/naver", method = RequestMethod.POST)
	public String naverCallback(HttpSession session, String member_id) {
		
		member_id = member_id + "(naver)";
		chkFirstLogin(member_id);
		
		LoginDto loginDto = new LoginDto();
        loginDto.setMember_id(member_id);
        session.setAttribute("loginInfo", loginDto);
		return "redirect:/";
	}
	
	public void chkFirstLogin(String member_id) {
		// member_id로 가입된 계정이 있는지 검토.  id(naver), id(kakao) 로 저장되어 있음
		MemberVo memberVo = memberService.getMemberInfo(member_id);
		// 첫 로그인이라 계정이 없다면 id(naver/kakao) 생성 
		if (memberVo == null) {
			memberService.registerAuth(member_id);
		}
	}
}
