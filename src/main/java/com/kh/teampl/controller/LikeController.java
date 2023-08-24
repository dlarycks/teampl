package com.kh.teampl.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teampl.service.LikeService;

@Controller
@RequestMapping("/like")
public class LikeController {

	@Autowired
	private LikeService likeService;
	
	@ResponseBody
	@RequestMapping(value = "/isLiked", method = RequestMethod.POST)
	public String isLiked(String member_id, int board_no) {
		boolean isLiked = likeService.isLiked(member_id, board_no);
		return String.valueOf(isLiked);
	}
	
	@ResponseBody
	@RequestMapping(value = "/getLikeCount", method = RequestMethod.GET)
	public String getLikeCount(int board_no) {
		return String.valueOf(likeService.getLikeCount(board_no));
	}
	
	@ResponseBody
	@RequestMapping(value = "/addLike", method = RequestMethod.POST)
	public String addLike(String member_id, int board_no) {
		/* 2차 검증 : 이미 추천을 누른 상황이면 return */
		if(isLiked(member_id, board_no) == "true") {
			return "";
		} else {
			likeService.addLike(member_id, board_no);
			return "success";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteLike", method = RequestMethod.POST)
	public String deleteLike(String member_id, int board_no) {
		/* 2차 검증 : 추천을 누르지 않은 상황이면 return */
		if(isLiked(member_id, board_no) == "false") {
			return "";
		} else {
			likeService.deleteLike(member_id, board_no);
			return "success";
		}
	}
}
