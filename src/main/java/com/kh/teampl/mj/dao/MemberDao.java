package com.kh.teampl.mj.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.mj.vo.MemberVo;

@Repository
public class MemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	private final String NAMESPACE = "com.kh.teampl.MemberMapper.";
	
	public void register(MemberVo memberVo) {
		sqlSession.insert(NAMESPACE + "register", memberVo);
	}
	
	public int isDup(String member_id) {
		int count = sqlSession.selectOne(NAMESPACE + "isDup", member_id);
		return count;
	}
	
	
}
