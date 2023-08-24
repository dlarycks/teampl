package com.kh.teampl.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teampl.dao.ShopDao;
import com.kh.teampl.vo.OrderDetailVo;
import com.kh.teampl.vo.OrderVo;
import com.kh.teampl.vo.ProductVo;
import com.kh.teampl.vo.WizardVo;

@Service
public class ShopService {

	@Autowired
	private ShopDao shopDao;
	
	public List<ProductVo> productList(String category_key){
		return shopDao.productList(category_key); 
	}
	
	@Transactional
	public void order(OrderVo orderVo, OrderDetailVo orderDVo) {
		int order_no = shopDao.seq_nextval();
		orderVo.setOrder_no(order_no);
		orderDVo.setOrder_no(order_no);
		
		shopDao.insertOrder(orderVo);
		shopDao.insertOrderDetail(orderDVo);
	}
	
	public List<OrderVo> showOrderList(int member_no) {
		return shopDao.showOrderList(member_no);
	}
	
	public List<WizardVo> getWizardList(int wizard_value) {
		return shopDao.getWizardList(wizard_value);
	}
	
	public WizardVo getWizard(String wizard_no) {
		return shopDao.getWizard(wizard_no);
	}
	
	public List<ProductVo> getRecommendVoList(WizardVo wizardVo) {
		
		ProductVo vo_cpu = shopDao.getProductInfo(wizardVo.getWizard_cpu_no());
		ProductVo vo_mb = shopDao.getProductInfo(wizardVo.getWizard_mb_no());
		ProductVo vo_ram = shopDao.getProductInfo(wizardVo.getWizard_ram_no());
		ProductVo vo_vga = shopDao.getProductInfo(wizardVo.getWizard_vga_no());
		ProductVo vo_power = shopDao.getProductInfo(wizardVo.getWizard_power_no());
		ProductVo vo_case = shopDao.getProductInfo(wizardVo.getWizard_case_no());
		ProductVo vo_ssd = shopDao.getProductInfo(wizardVo.getWizard_ssd_no());
		
		List<ProductVo> list = new ArrayList<>();
		list.add(vo_cpu);
		list.add(vo_mb);
		list.add(vo_ram);
		list.add(vo_vga);
		list.add(vo_power);
		list.add(vo_case);
		list.add(vo_ssd);
		return list;
	}
}
