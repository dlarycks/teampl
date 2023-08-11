package com.kh.teampl.mj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teampl.mj.dao.BoardDao;
import com.kh.teampl.mj.dto.PagingDto;
import com.kh.teampl.mj.vo.BoardVo;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	public int getBoardCount(String board_type) {
		return boardDao.getBoardCount(board_type);
	}
	
	public List<BoardVo> getList(PagingDto pagingDto) {
		List<BoardVo> list = boardDao.getList(pagingDto);
		return list;
	}
	
	public List<BoardVo> getListByContent(String board_type) {
		List<BoardVo> list = boardDao.getListByContent(board_type);
		return list;
	}
	
	public BoardVo read(int board_no) {
		return boardDao.read(board_no);
	}
	
	@Transactional
	public void register(BoardVo boardVo) {
		
		int board_no = boardDao.getSequence();
		/* register */
		boardVo.setBoard_no(board_no);
		boardDao.register(boardVo);
		/* file upload */
		String[] files = boardVo.getFiles();
		if (files != null) {
			for(String board_imgsrc : files) {
				boardDao.insertAttach(board_no, board_imgsrc);
			}
		}
	}
	
	public List<String> getImageList(int board_no) {
		return boardDao.getImageList(board_no);
	}
}
