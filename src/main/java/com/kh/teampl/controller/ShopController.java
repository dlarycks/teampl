package com.kh.teampl.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.teampl.dto.LoginDto;
import com.kh.teampl.dto.OrderDto;
import com.kh.teampl.service.MemberService;
import com.kh.teampl.service.ShopService;
import com.kh.teampl.vo.MemberVo;
import com.kh.teampl.vo.OrderVo;
import com.kh.teampl.vo.OrderDetailVo;
import com.kh.teampl.vo.ProductVo;
import com.kh.teampl.vo.WizardVo;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	private ShopService shopService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String shop() {
		return "/shop/list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public List<ProductVo> productList(String category_key) {
		return shopService.productList(category_key);
	}
	
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public String order(HttpSession session, OrderDetailVo orderDetailVo, OrderDto orderDto, Model model) {
		
		LoginDto loginDto = (LoginDto)session.getAttribute("loginInfo");
		MemberVo memberVo = memberService.getMemberInfo(loginDto.getMember_id());
		
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("orderDetailVo", orderDetailVo);
		model.addAttribute("orderDto", orderDto);
		return "/shop/order";
	}
	/* 결제 */
	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String order(OrderVo orderVo, OrderDetailVo orderDVo, RedirectAttributes rttr) {
		shopService.order(orderVo, orderDVo);
		
		/* 결제 완료메세지 출력용 rttr 바인드 */
		rttr.addFlashAttribute("payResult", "true");
		return "redirect:/";
	}
	
	/* TEST용 : 결제화면 순간이동  */
	@RequestMapping(value = "/testOrder", method = RequestMethod.GET)
	public String testOrder(HttpSession session, Model model) {
		
		LoginDto loginDto = (LoginDto)session.getAttribute("loginInfo");
		MemberVo memberVo = memberService.getMemberInfo(loginDto.getMember_id());
		
		/* (number)CPU, MB, RAM, VGA, POWER, CASE, SSD 순 */
		OrderDetailVo orderDetailVo = new OrderDetailVo(1, 100001, 200001, 300001, 400001, 500001, 600001, 700001);
		
		/* (name)CPU, MB, RAM, VGA, POWER, CASE, SSD,
		 * (price)CPU, MB, RAM, VGA, POWER, CASE, SSD, 총 가격 순 */
		OrderDto orderDto = new OrderDto("코어i9-13세대 13900K", "Z790 AORUS ELITE", "삼성 DDR5 32GB PC5-44800 2개",
										 "GeForce RTX 3060 GAMING TWIN Edge OC D6 12GB LHR", "MAXWELL BARON 800W 80PLUS BRONZE 플랫(ATX/800W)",
										 "DLX21 RGB MESH 강화유리 블랙", "Gold P31 M.2 NVMe 2280",
										 785300, 365000, 197800,
										 428000, 87000,
										 98000, 785300,
										 2476400); 
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("orderDetailVo", orderDetailVo);
		model.addAttribute("orderDto", orderDto);
		return "/shop/order";
	}
	
	@RequestMapping(value = "/wizard", method = RequestMethod.GET)
	public String wizard() {
		return "/shop/wizard";
	}

	@ResponseBody
	@RequestMapping(value = "/threeResult", method = RequestMethod.GET)
	public List<WizardVo> threeResult(int wizard_value) {
		List<WizardVo> list = shopService.getWizardList(wizard_value);
		return list;
	}

	// wizard.jsp -> wizard_no 바인딩 -> list.jsp
	@RequestMapping(value = "/finalResult", method = RequestMethod.POST)
	public String finalResult(String wizard_no, Model model) {
		model.addAttribute("wizard_no", wizard_no);
		return "/shop/list";
	}
	
	// 위 메소드에서 가져온 wizard_no가 존재하면 여기를 호출함
	@RequestMapping(value = "/recommend", method = RequestMethod.GET)
	@ResponseBody
	public List<ProductVo> getRecommendVoList(String wizard_no, Model model) {
		WizardVo vo = shopService.getWizard(wizard_no);
		List<ProductVo> recommendVoList = shopService.getRecommendVoList(vo);
		return recommendVoList;
	}
	
	/* 결제 */
	@RequestMapping(value = "/digitalPay", method = RequestMethod.GET)
	public String digitalPay() {
		return "success";
	}
	
}
