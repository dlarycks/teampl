package com.kh.teampl.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.dto.LoginDto;
import com.kh.teampl.vo.MemberVo;

@Repository
public class MemberDao {

	@Autowired
	private SqlSession sqlSession;
	
	private final String NAMESPACE = "com.kh.teampl.MemberMapper.";
	
	public int login(LoginDto loginDto) {
		return sqlSession.selectOne(NAMESPACE + "login", loginDto);
	}
	
	public void register(MemberVo memberVo) {
		sqlSession.insert(NAMESPACE + "register", memberVo);
	}
	
	public void registerAuth(MemberVo memberVo) {
		sqlSession.insert(NAMESPACE + "registerAuth", memberVo);
	}
	
	public boolean isDup(String member_id) {
		int count = sqlSession.selectOne(NAMESPACE + "isDup", member_id);
		if (count == 1) {
			return true;
		}
		return false;
	}
	
	public MemberVo getMemberInfo(String member_id) {
		MemberVo memberVo = sqlSession.selectOne(NAMESPACE + "getMemberInfo", member_id);
		return memberVo;
	}
	
	public String chkForgotId(String member_name, String member_email) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_name", member_name);
		map.put("member_email", member_email);
		return sqlSession.selectOne(NAMESPACE + "chkForgotId", map);
	}
	
	public boolean chkForgotPassword(String member_id, String member_name, String member_email) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("member_name", member_name);
		map.put("member_email", member_email);
		int count = sqlSession.selectOne(NAMESPACE + "chkForgotPassword", map);
		if (count == 1) {
			return true;
		}
		return false;
	}
	
	public void changePassword(String member_id, String new_password) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("new_password", new_password);
		sqlSession.update(NAMESPACE + "changePassword", map);
	}
	
	
}
