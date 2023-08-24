package com.kh.teampl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teampl.dao.ReplyDao;
import com.kh.teampl.vo.ReplyVo;

@Service
public class ReplyService {

	@Autowired
	private ReplyDao replyDao;
	
	public List<ReplyVo> getReplyList(int board_no) {
		return replyDao.getReplyList(board_no);
	}
	
	public void comment(ReplyVo replyVo) {
		replyDao.comment(replyVo);
	}
	
	@Transactional
	public void nestedComment(ReplyVo replyVo) {
		replyDao.updateSeq(replyVo.getReply_seq());
		replyDao.nestedComment(replyVo);
	}
	
	public void updateReply(int reply_no, String reply_content) {
		replyDao.updateReply(reply_no, reply_content);
	}
	
	public void deleteReply(int reply_no) {
		replyDao.deleteReply(reply_no);
	}
	
}
