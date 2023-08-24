package com.kh.teampl.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LikeDao {

	@Autowired
	private SqlSession sqlSession;
	
	private final String NAMESPACE = "com.kh.teampl.LikeMapper.";
	
	public boolean isLiked(String member_id, int board_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("board_no", board_no);
		int count = sqlSession.selectOne(NAMESPACE + "isLiked", map);
		if (count == 1) {
			return true;
		}
		return false;
	}
	
	public int getLikeCount(int board_no) {
		return sqlSession.selectOne(NAMESPACE + "getLikeCount", board_no);
	}
	
	public void addLike(String member_id, int board_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("board_no", board_no);
		sqlSession.insert(NAMESPACE + "addLike", map);
	}
	
	public void deleteLike(String member_id, int board_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("board_no", board_no);
		sqlSession.delete(NAMESPACE + "deleteLike", map);
	}
}
