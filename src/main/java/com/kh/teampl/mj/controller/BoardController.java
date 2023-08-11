package com.kh.teampl.mj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.teampl.mj.dto.PagingDto;
import com.kh.teampl.mj.service.BoardService;
import com.kh.teampl.mj.vo.BoardVo;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(PagingDto pagingDto, Model model) {

		int boardCount = boardService.getBoardCount(pagingDto.getBoard_type());
		pagingDto.setTotalBoardCount(boardCount);
		pagingDto.calc();
		model.addAttribute("pagingDto", pagingDto);
		
		if (pagingDto.getBoard_type() == null) {
			pagingDto.setBoard_type("ÀüÃ¼");
		}
		System.out.println("BoardController, pagingDto: " + pagingDto);

		List<BoardVo> list = boardService.getList(pagingDto);
		
		model.addAttribute("list", list);
		
		return "/mj/board/list";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register() {
		return "/mj/board/register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(BoardVo boardVo) {
		System.out.println("Controller, boardVo : " + boardVo);
		boardService.register(boardVo);
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "/read/{board_no}", method = RequestMethod.GET)
	public String read(@PathVariable("board_no") int board_no, Model model) {
		
		BoardVo boardVo = boardService.read(board_no);
		
		model.addAttribute("boardVo", boardVo);
		return "/mj/board/read";
	}
	
}
