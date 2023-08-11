package com.kh.teampl.mj.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.mj.vo.OrderDetailVo;
import com.kh.teampl.mj.vo.OrderVo;
import com.kh.teampl.mj.vo.ProductVo;

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
	
	public List<OrderDetailVo> showOrderlist(int member_no) {
		return sqlSession.selectList(NAMESPACE + "showOrderlist", member_no);
	}
	
	public OrderVo showOrder(int order_no) {
		return sqlSession.selectOne(NAMESPACE + "showOrder", order_no);
	}
}
