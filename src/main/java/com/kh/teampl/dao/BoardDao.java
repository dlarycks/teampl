package com.kh.teampl.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.teampl.dto.PagingDto;
import com.kh.teampl.vo.BoardVo;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	private final String NAMESPACE = "com.kh.teampl.BoardMapper.";
	
	public int getBoardCount(PagingDto pagingDto) {
		return sqlSession.selectOne(NAMESPACE + "getBoardCount", pagingDto);
	}
	
	public List<BoardVo> getList(PagingDto pagingDto) {
		List<BoardVo> list = sqlSession.selectList(NAMESPACE + "getList", pagingDto);
		return list;
	}
	
	public List<BoardVo> getListByContent(String board_type) {
		List<BoardVo> list = sqlSession.selectList(NAMESPACE + "getListByContent", board_type);
		return list;
	}
	
	public BoardVo read(int board_no) {
		return sqlSession.selectOne(NAMESPACE + "read", board_no);
	}
	
	public void updateViewcount(int board_no) {
		sqlSession.update(NAMESPACE + "updateViewcount", board_no);
	}
	
	public void register(BoardVo boardVo) {
		sqlSession.insert(NAMESPACE + "register", boardVo);
	}
	
	public void update(BoardVo boardVo) {
		sqlSession.update(NAMESPACE + "update", boardVo);
	}
	
	public void delete(int board_no) {
		sqlSession.delete(NAMESPACE + "delete", board_no);
	}
	
	public int getSequence() {
		return sqlSession.selectOne(NAMESPACE + "seq_nextval");
	}
	
	public void insertAttach(int board_no, String board_imgsrc) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_no", board_no);
		map.put("board_imgsrc", board_imgsrc);
		sqlSession.insert(NAMESPACE + "insertAttach", map);
	}
	
	public void deleteReply(int board_no) {
		sqlSession.delete(NAMESPACE + "deleteReply", board_no);
	}
	
	public void deleteAttach(int board_no) {
		sqlSession.delete(NAMESPACE + "deleteAttach", board_no);
	}
	
	public void deleteSingleAttach(String board_imgsrc) {
		sqlSession.delete(NAMESPACE + "deleteSingleAttach", board_imgsrc);
	}
	
	public void deleteLike(int board_no) {
		sqlSession.delete(NAMESPACE + "deleteLike", board_no);
	}
	
	public List<String> getImageList(int board_no) {
		return sqlSession.selectList(NAMESPACE + "getImageList", board_no);
	}
	
}
