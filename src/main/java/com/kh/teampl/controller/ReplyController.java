package com.kh.teampl.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.teampl.service.ReplyService;
import com.kh.teampl.vo.ReplyVo;

@Controller
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	@ResponseBody
	@RequestMapping(value = "/getReplyList", method = RequestMethod.POST)
	public List<ReplyVo> getReplyList(int board_no) {
		return replyService.getReplyList(board_no);
	}
	
	@ResponseBody
	@RequestMapping(value = "/comment", method = RequestMethod.POST)
	public String comment(ReplyVo replyVo) {
		replyService.comment(replyVo);
		return "success";
	}
	
	@ResponseBody
	@RequestMapping(value = "/nestedComment", method = RequestMethod.POST)
	public String nestedComment(ReplyVo replyVo) {
		replyService.nestedComment(replyVo);
		return "success";
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateReply", method = RequestMethod.POST)
	public String updateReply(int reply_no, String reply_content) {
		replyService.updateReply(reply_no, reply_content);
		return "success";
	}
	@ResponseBody
	@RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
	public String deleteReply(int reply_no) {
		replyService.deleteReply(reply_no);
		return "success";
	}
	
}
