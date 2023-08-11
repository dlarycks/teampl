package com.kh.teampl.mj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teampl.mj.dao.ShopDao;
import com.kh.teampl.mj.vo.OrderDetailVo;
import com.kh.teampl.mj.vo.OrderVo;
import com.kh.teampl.mj.vo.ProductVo;

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
	
	public List<OrderDetailVo> showOrderList(int member_no) {
		return shopDao.showOrderlist(member_no);
	}
	
	public OrderVo showOrder(int order_no) {
		return shopDao.showOrder(order_no);
	}
}
