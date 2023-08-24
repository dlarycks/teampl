package com.kh.teampl.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyVo {
	private int reply_no;
	private int board_no;
	private String member_id;
	private String reply_content;
	private Timestamp reply_regdate;
	private int reply_group;
	private int reply_seq;
	private int reply_level;
}
