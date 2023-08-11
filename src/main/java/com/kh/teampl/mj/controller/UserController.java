package com.kh.teampl.mj.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.teampl.mj.dto.LoginDto;
import com.kh.teampl.mj.dto.OrderDto;
import com.kh.teampl.mj.service.MemberService;
import com.kh.teampl.mj.service.ShopService;
import com.kh.teampl.mj.vo.MemberVo;
import com.kh.teampl.mj.vo.OrderDetailVo;
import com.kh.teampl.mj.vo.OrderVo;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ShopService shopService;
	
	@RequestMapping(value = "/orderHistrory", method = RequestMethod.GET)
	public String orderHistory(HttpSession session, Model model) {
		LoginDto loginDto = (LoginDto)session.getAttribute("loginInfo");
		MemberVo memberVo = memberService.getMemberInfo(loginDto.getMember_id());
		
		List<OrderDetailVo> OrderDetailList = shopService.showOrderList(memberVo.getMember_no());
		List<OrderVo> orderList = new ArrayList<>(); 
		
		for (OrderDetailVo orderDVo : OrderDetailList) {
			int order_no = orderDVo.getOrder_no();
			OrderVo orderVo = shopService.showOrder(order_no);
			orderList.add(orderVo);
		}
		model.addAttribute("orderList", orderList);
		model.addAttribute("member_name", memberVo.getMember_name());
		
		return "/mj/user/orderHistory";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(@CookieValue(value = "cookie_id", required = false) Cookie cookie, Model model) {
		if (cookie != null) {
			String cookie_id = cookie.getValue();
			model.addAttribute("cookie_id", cookie_id);
//			System.out.println("UserController, cookie_id : " + cookie_id);
		}
		return "/mj/user/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(LoginDto loginDto, boolean remember_id, 
			HttpServletResponse response, HttpSession session, RedirectAttributes rttr,
			OrderDetailVo orderVo, OrderDto orderDto) {
//		System.out.println("UserController, loginDto : " + loginDto);
		System.out.println("UserController, remember_id : " + remember_id);
		boolean loginResult = memberService.login(loginDto);
		
		System.out.println("Controller, loginResult : " + loginResult);
		if (loginResult == true) {
			System.out.println("UserController, loginResult : " + loginResult);
			session.setAttribute("loginInfo", loginDto);
			/* 아이디 기억하기 쿠키 생성*/
			if (remember_id == true) {
				Cookie cookie = new Cookie("cookie_id", loginDto.getMember_id());
//				cookie.setPath("/user/login");
				cookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookie);
			}
			/* 가려고 했던 위치로 보내기 */
			String targetLocation = (String)session.getAttribute("targetLocation");
			if (targetLocation != null) {
				return "redirect:" + targetLocation;
			}
		} else {
			rttr.addFlashAttribute("loginResult", "아이디와 비밀번호를 확인해 주세요.");
			return "redirect:/user/login";
		}
		return "redirect:/";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes rttr) {
		session.invalidate();
		rttr.addFlashAttribute("logoutResult", "true");
		return "redirect:/";
	}

	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register() {
		return "mj/user/register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(MemberVo memberVo, RedirectAttributes rttr) {
		System.out.println("UserController : " + memberVo);
		memberService.register(memberVo);
		rttr.addFlashAttribute("register_result", "success");
		rttr.addFlashAttribute("register_name", memberVo.getMember_name());
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value = "/isDup", method = RequestMethod.POST)
	public String isDup(String member_id) {
//		System.out.println("UserController : " + member_id);
		boolean isDup = memberService.isDup(member_id);
		if (isDup) {
			return "fail";
		}
		return "success";
	}
	
	@RequestMapping(value = "/userInfo", method = RequestMethod.GET)
	public String userInfo(HttpSession session, Model model) {
		LoginDto loginDto = (LoginDto)session.getAttribute("loginInfo");
		MemberVo memberVo = memberService.getMemberInfo(loginDto.getMember_id());
		model.addAttribute("memberVo", memberVo);
		return "mj/user/userInfo";
	}
	
	@RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
	public String userInfo() {
		return "mj/user/forgotPassword";
	}
	
	@ResponseBody
	@RequestMapping(value = "/chkForgotId", method = RequestMethod.POST)
	public String chkForgotId(String member_name, String member_email) {
		return memberService.chkForgotId(member_name, member_email);
	}
	
	@ResponseBody
	@RequestMapping(value = "/chkForgotPassword", method = RequestMethod.POST)
	public String chkForgotPassword(String member_id, String member_name, String member_email) {
		boolean result = memberService.chkForgotPassword(member_id, member_name, member_email);
		if (result == true) {
			return "success";
		} else {
			return "";
		}
	}
	
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public String changePassword(String member_id, String new_password) {
		System.out.println("UserController, member_id : " + member_id);
		System.out.println("UserController, new_password : " + new_password);
		memberService.changePassword(member_id, new_password);
		return "redirect:/";
	}
}
