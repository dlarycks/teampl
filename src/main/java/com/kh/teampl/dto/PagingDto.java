package com.kh.teampl.dto;

import lombok.Data;

@Data
public class PagingDto {
	
	private final int BOARD_PER_PAGE = 10;
	private final int PAGE_PER_ROW = 10;
	private int currentPage = 1;
	
	private int totalBoardCount;
	private int totalPageCount;
	
	private int startPage;
	private int endPage;
	
	private int startRnum;
	private int endRnum;
	
	private String board_type;
	private String searchType;
	private String keyword;
	
	public void calc() {
		
		totalPageCount = (int)Math.ceil(totalBoardCount / (double)BOARD_PER_PAGE);
		
		startRnum = (currentPage - 1) * 10 + 1;
		endRnum = startRnum + BOARD_PER_PAGE - 1;
		
		startPage = ((currentPage - 1) / 10) * 10 + 1 ;
		endPage = startPage + PAGE_PER_ROW - 1;
		if (endPage > totalPageCount) {
			endPage = totalPageCount;
		}
	}
}
