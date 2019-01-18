package com.myneko.admin.reply.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.admin.qna.service.QnaService;
import com.myneko.admin.qna.vo.QnaVO;
import com.myneko.admin.reply.service.ReplyService;
import com.myneko.admin.reply.vo.ReplyVO;

@Controller
@RequestMapping(value="/admin/reply")
public class ReplyController {

	@Autowired
	private ReplyService repService;
	
	@Autowired
	private QnaService qnaService;
	
	@RequestMapping(value="/insertReply.do", method=RequestMethod.POST)
	@ResponseBody
	public int InsertReply(@ModelAttribute("ReplyVO") ReplyVO rvo) {
		
		int result = repService.insertReply(rvo);
		
		if (result == 1) {
			
			QnaVO qvo = new QnaVO();
			qvo.setI_repwhether("Y");
			qvo.setI_number(rvo.getI_number());
			qnaService.whetherUpdate(qvo);
			
		}

		return result;
		
	}
	
}
