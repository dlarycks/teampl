package com.kh.teampl.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teampl.dto.Product_noDto;
import com.kh.teampl.service.CheckService;

@Controller
@RequestMapping("/check")
public class CheckController {

	@Autowired
	private CheckService checkService;

	// cpu ram 셀렉 리스트(호환성 검사)
	@RequestMapping(value = "/compability", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> compability(Product_noDto product_noDto) {
		Map<String, Boolean> map = checkService.checkAll(product_noDto);
		return map;
	}
}
