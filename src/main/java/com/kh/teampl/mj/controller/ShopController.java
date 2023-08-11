package com.kh.teampl.mj.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.teampl.mj.dto.LoginDto;
import com.kh.teampl.mj.dto.OrderDto;
import com.kh.teampl.mj.service.MemberService;
import com.kh.teampl.mj.service.ShopService;
import com.kh.teampl.mj.vo.MemberVo;
import com.kh.teampl.mj.vo.OrderVo;
import com.kh.teampl.mj.vo.OrderDetailVo;
import com.kh.teampl.mj.vo.ProductVo;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	private ShopService shopService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String shop() {
		return "/mj/shop/list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public List<ProductVo> productList(String category_key) {
		return shopService.productList(category_key);
	}
	
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public String order(HttpSession session, OrderDetailVo orderVo, OrderDto orderDto, Model model) {
		LoginDto loginDto = (LoginDto)session.getAttribute("loginInfo");
		MemberVo memberVo = memberService.getMemberInfo(loginDto.getMember_id());
		
		System.out.println("ShopController, memberVo : " + memberVo);
		System.out.println("ShopController, orderVo : " + orderVo);
		System.out.println("ShopController, orderDto : " + orderDto);
		
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("orderVo", orderVo);
		model.addAttribute("orderDto", orderDto);
		return "/mj/shop/order";
	}
	/* ���� */
	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String order(OrderVo orderVo, OrderDetailVo orderDVo, RedirectAttributes rttr) {
		System.out.println("ShopController, orderVo : " + orderVo);
		System.out.println("ShopController, orderDetailVo : " + orderDVo);
		
		shopService.order(orderVo, orderDVo);
		
		/* ���� �Ϸ�޼��� ��¿� rttr ���ε� */
		rttr.addFlashAttribute("payResult", "true");
		return "redirect:/";
	}
	
	/* TEST�� : ����ȭ�� �����̵�  ���߿� ����� */
	@RequestMapping(value = "/testOrder", method = RequestMethod.GET)
	public String testOrder(HttpSession session, Model model) {
		
		LoginDto loginDto = (LoginDto)session.getAttribute("loginInfo");
		MemberVo memberVo = memberService.getMemberInfo(loginDto.getMember_id());
		
		/* (number)CPU, MB, RAM, VGA, POWER, CASE, SSD �� */
		OrderDetailVo orderVo = new OrderDetailVo(1, 1001, 100001, 200001, 300001, 400001, 500001, 600001, 700001);
		/* (name)CPU, MB, RAM, VGA, POWER, CASE, SSD, �� ���� �� */
		OrderDto orderDto = new OrderDto("�ھ�i9-13���� 13900K", "Z790 AORUS ELITE",
										 "�Ｚ DDR5 32GB PC5-44800 2��", "GeForce RTX 3060 GAMING TWIN Edge OC D6 12GB LHR",
										 "MAXWELL BARON 800W 80PLUS BRONZE �÷�(ATX/800W)", "DLX21 RGB MESH ��ȭ���� ��",
										 "Gold P31 M.2 NVMe 2280",
										 2476400);
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("orderVo", orderVo);
		model.addAttribute("orderDto", orderDto);
		return "/mj/shop/order";
	}
	
	
}
