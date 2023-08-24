package com.kh.teampl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.teampl.dao.BoardDao;
import com.kh.teampl.dto.PagingDto;
import com.kh.teampl.vo.BoardVo;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	public int getBoardCount(PagingDto pagingDto) {
		return boardDao.getBoardCount(pagingDto);
	}
	
	public List<BoardVo> getList(PagingDto pagingDto) {
		List<BoardVo> list = boardDao.getList(pagingDto);
		return list;
	}
	
	public BoardVo read(int board_no) {
		boardDao.updateViewcount(board_no);
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
	
	public void update(BoardVo boardVo) {
		/* update */
		boardDao.update(boardVo);
		/* (new)file upload */
		int board_no = boardVo.getBoard_no();
		String[] files = boardVo.getFiles();
		if (files != null) {
			for(String board_imgsrc : files) {
				boardDao.insertAttach(board_no, board_imgsrc);
			}
		}
	}
	
	@Transactional
	public void delete(int board_no) {
		boardDao.deleteReply(board_no);
		boardDao.deleteAttach(board_no);
		boardDao.deleteLike(board_no);
		boardDao.delete(board_no);
	}
	
	public void deleteSingleAttach(String board_imgsrc) {
		boardDao.deleteSingleAttach(board_imgsrc);
	}
	
	public List<String> getImageList(int board_no) {
		return boardDao.getImageList(board_no);
	}
}
