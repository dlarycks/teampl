package com.kh.teampl.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.teampl.dto.PagingDto;
import com.kh.teampl.service.BoardService;
import com.kh.teampl.vo.BoardVo;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(PagingDto pagingDto, Model model) {

		if (pagingDto.getBoard_type() == null) {
			pagingDto.setBoard_type("전체");
		}
		int boardCount = boardService.getBoardCount(pagingDto);
		pagingDto.setTotalBoardCount(boardCount);
		pagingDto.calc();
		
		model.addAttribute("pagingDto", pagingDto);
		System.out.println("BoardController, pagingDto: " + pagingDto);
		
		List<BoardVo> list = boardService.getList(pagingDto);
		model.addAttribute("list", list);
		return "/board/list";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register() {
		return "/board/register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(BoardVo boardVo, RedirectAttributes rttr) {
		boardService.register(boardVo);
		if (boardVo.getBoard_type().equals("공지")) {
			rttr.addFlashAttribute("redirect_board_type", "공지");
		}
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "/read/{board_no}", method = RequestMethod.GET)
	public String read(@PathVariable("board_no") int board_no, Model model) {
		BoardVo boardVo = boardService.read(board_no);
		model.addAttribute("boardVo", boardVo);
		return "/board/read";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(BoardVo boardVo, RedirectAttributes rttr) {
		boardService.update(boardVo);
		return "redirect:/board/read/" + boardVo.getBoard_no();
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(int board_no, String board_type, RedirectAttributes rttr) {
		boardService.delete(board_no);
		if (board_type.equals("공지")) {
			rttr.addFlashAttribute("redirect_board_type", "공지");
		}
		return "redirect:/board/list";
	}
}
