package com.kh.teampl.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVo {
	private int member_no;
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_birth;
	private String member_pno;
	private String member_email;
	private String member_addr1;
	private String member_addr2;
	private Timestamp member_regdate;
	private int member_point;
}
