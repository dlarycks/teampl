package com.kh.teampl.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVo {
	private int board_no;
	private String member_id;
	private String board_type;
	private String board_title;
	private String board_content;
	private Timestamp board_regdate;
	private int board_viewcount;
	// for file upload
	private String[] files;
}
