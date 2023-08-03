package com.kh.teampl.mj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teampl.mj.dao.MemberDao;
import com.kh.teampl.mj.dto.LoginDto;
import com.kh.teampl.mj.vo.MemberVo;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;
	
	public boolean login(LoginDto loginDto) {
		boolean loginResult = memberDao.login(loginDto);
		return loginResult;
	}
	
	public void register(MemberVo memberVo) {
		memberDao.register(memberVo);
	}
	
	public boolean isDup(String member_id) {
		boolean isDup = memberDao.isDup(member_id);
		return isDup;
	}
	
	public MemberVo getMemberInfo(String member_id) {
		MemberVo memberVo = memberDao.getMemberInfo(member_id);
		return memberVo;
	}
	
	public String chkForgotId(String member_name, String member_email) {
		return memberDao.chkForgotId(member_name, member_email);
	}
	
	public boolean chkForgotPassword(String member_id, String member_name, String member_email) {
		return memberDao.chkForgotPassword(member_id, member_name, member_email);
	}
	
	public void changePassword(String member_id, String new_password) {
		memberDao.changePassword(member_id, new_password);
	}
}
