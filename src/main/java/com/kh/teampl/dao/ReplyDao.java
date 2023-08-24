package com.kh.teampl.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.vo.ReplyVo;

@Repository
public class ReplyDao {

	@Autowired
	private SqlSession sqlSession;
	
	private final String NAMESPACE = "com.kh.teampl.ReplyMapper.";
	
	public List<ReplyVo> getReplyList(int board_no) {
		return sqlSession.selectList(NAMESPACE + "getReplyList", board_no);
	}
	
	private int seq_nextval() {
		return sqlSession.selectOne(NAMESPACE + "seq_nextval");
	}
	
	public void comment(ReplyVo replyVo) {
		replyVo.setReply_no(seq_nextval());
		sqlSession.insert(NAMESPACE + "comment", replyVo);
	}
	
	public void nestedComment(ReplyVo replyVo) {
		replyVo.setReply_no(seq_nextval());
		sqlSession.insert(NAMESPACE + "nestedComment", replyVo);
	}
	
	public void updateSeq(int reply_seq) {
		sqlSession.update(NAMESPACE + "updateSeq", reply_seq);
	}
	
	public void updateReply(int reply_no, String reply_content) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reply_no", reply_no);
		map.put("reply_content", reply_content);
		sqlSession.update(NAMESPACE + "updateReply", map);
	}
	
	public void deleteReply(int reply_no) {
		sqlSession.delete(NAMESPACE + "deleteReply", reply_no);
	}
	
}
