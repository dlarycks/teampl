package com.kh.teampl.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.teampl.dao.LikeDao;

@Service
public class LikeService {

	@Autowired
	private LikeDao likeDao;
	
	public boolean isLiked(String member_id, int board_no) {
		return likeDao.isLiked(member_id, board_no);
	}
	
	public int getLikeCount(int board_no) {
		return likeDao.getLikeCount(board_no);
	}
	
	public void addLike(String member_id, int board_no) {
		likeDao.addLike(member_id, board_no);
	}
	
	public void deleteLike(String member_id, int board_no) {
		likeDao.deleteLike(member_id, board_no);
	}
	
}
