package com.kh.teampl.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teampl.dao.CheckDao;
import com.kh.teampl.dto.Product_noDto;

@Service
public class CheckService {

	@Autowired
	private CheckDao checkDao;
	
	@Transactional
	public Map<String, Boolean> checkAll(Product_noDto product_noDto) {
		
		Map<String, Boolean> map = new HashMap<>();
		map.put("CPU_RAM", crCheck(product_noDto));
		map.put("CPU_MB", cmCheck(product_noDto));
		map.put("MB_RAM", mrCheck(product_noDto));
		map.put("MB_VGA", mvCheck(product_noDto));
		map.put("MB_SSD", msCheck(product_noDto));
		map.put("CASE_MB", caseMbCheck(product_noDto));
		map.put("CASE_POWER", casePowerCheck(product_noDto));
		map.put("CASE_VGA", caseVgaCheck(product_noDto));
		return map;
	}

	// cpu ram select
	public boolean crCheck(Product_noDto product_noDto) {
		return checkDao.crCheck(product_noDto);
	}

	// cpu mb select
	public boolean cmCheck(Product_noDto product_noDto) {
		return checkDao.cmCheck(product_noDto);
	}

	// mb ram select
	public boolean mrCheck(Product_noDto product_noDto) {
		return checkDao.mrCheck(product_noDto);
	}

	// mb vga select
	public boolean mvCheck(Product_noDto product_noDto) {
		return checkDao.mvCheck(product_noDto);
	}

	// mb ssd select
	public boolean msCheck(Product_noDto product_noDto) {
		return checkDao.msCheck(product_noDto);
	}
	
	// case mb select
	public boolean caseMbCheck(Product_noDto product_noDto) {
		return checkDao.caseMbCheck(product_noDto);
	}

	// case power select
	public boolean casePowerCheck(Product_noDto product_noDto) {
		return checkDao.casePowerCheck(product_noDto);
	}
	
	// case vga select
	public boolean caseVgaCheck(Product_noDto product_noDto) {
		return checkDao.caseVgaCheck(product_noDto);
	}
}
