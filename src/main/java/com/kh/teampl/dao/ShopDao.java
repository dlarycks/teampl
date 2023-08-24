package com.kh.teampl.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.vo.OrderDetailVo;
import com.kh.teampl.vo.OrderVo;
import com.kh.teampl.vo.ProductVo;
import com.kh.teampl.vo.WizardVo;

@Repository
public class ShopDao {

	@Autowired
	private SqlSession sqlSession;
	
	private final String NAMESPACE = "com.kh.teampl.ShopMapper.";
	
	public List<ProductVo> productList(String category_key){
		return sqlSession.selectList(NAMESPACE + "productList", category_key);
	}
	
	public int seq_nextval() {
		return sqlSession.selectOne(NAMESPACE + "seq_nextval");
	}
	
	public void insertOrder(OrderVo orderVo) {
		sqlSession.insert(NAMESPACE + "insertOrder", orderVo);
	}
	
	public void insertOrderDetail(OrderDetailVo orderDVo) {
		sqlSession.insert(NAMESPACE + "insertOrderDetail", orderDVo);
	}
	
	public List<OrderVo> showOrderList(int member_no) {
		return sqlSession.selectList(NAMESPACE + "showOrderList", member_no);
	}
	
	public List<WizardVo> getWizardList(int wizard_value) {
		return sqlSession.selectList(NAMESPACE + "getWizardList", wizard_value);
	}
	
	public WizardVo getWizard(String wizard_no) {
		return sqlSession.selectOne(NAMESPACE + "getWizard", wizard_no);
	}
	
	public ProductVo getProductInfo(int product_no) {
		return sqlSession.selectOne(NAMESPACE + "getProductInfo", product_no);
	}
}
