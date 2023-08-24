package com.kh.teampl.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teampl.dao.MemberDao;
import com.kh.teampl.dto.LoginDto;
import com.kh.teampl.vo.MemberVo;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;
	
	public boolean login(LoginDto loginDto) {
		int count = memberDao.login(loginDto);
		if (count == 1) {
			return true;
		}
		return false;
	}
	
	public void register(MemberVo memberVo) {
		memberDao.register(memberVo);
	}
	
	public void registerAuth(String member_id) {
		MemberVo memberVo = new MemberVo();
		memberVo.setMember_id(member_id);
		memberVo.setMember_pw("0000");
		memberVo.setMember_name(member_id);
		memberVo.setMember_pno("-");
		memberVo.setMember_email("@");
		memberDao.registerAuth(memberVo);
	}
	
	public boolean isDup(String member_id) {
		return memberDao.isDup(member_id);
	}
	
	public MemberVo getMemberInfo(String member_id) {
		return memberDao.getMemberInfo(member_id);
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
