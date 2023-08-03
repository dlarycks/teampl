package com.kh.teampl.mj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teampl.mj.dao.MemberDao;
import com.kh.teampl.mj.vo.MemberVo;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;
	
	public void register(MemberVo memberVo) {
		memberDao.register(memberVo);
	}
	
	public int isDup(String member_id) {
		int count = memberDao.isDup(member_id);
		return count;
	}
	
	
}
