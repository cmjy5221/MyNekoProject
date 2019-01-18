package com.myneko.admin.qna.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.admin.qna.service.QnaService;
import com.myneko.admin.qna.vo.QnaVO;
import com.myneko.admin.reply.service.ReplyService;
import com.myneko.admin.reply.vo.ReplyVO;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value="/admin/qna")
public class QnaController {

	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping(value="/getQnaList.do", method=RequestMethod.GET)
	public ModelAndView getQnaList(@ModelAttribute("QnaVO") QnaVO qvo) {
		
		Paging.setPage(qvo);
		
		ModelAndView mav = new ModelAndView();
		List<QnaVO> qnaList = qnaService.getQnaList(qvo);
		
		int total = qnaService.qnaListCnt(qvo);
		log.info("total = " + total);
		int count = total - (Util.nvl(qvo.getPage()) - 1) * Util.nvl(qvo.getPageSize());
		log.info("count = " + count);
		
		mav.addObject("qnaList", qnaList);
		mav.addObject("total", total);
		mav.addObject("count", count);
		mav.addObject("data", qvo);
		mav.addObject("firstDate", qvo.getFirstDate());
		mav.addObject("lastDate", qvo.getLastDate());
		mav.setViewName("admin/cc/adminQnaList");
		
		return mav;
		
	}
	
	@RequestMapping(value="/getQnaDetail.do", method=RequestMethod.GET)
	public ModelAndView qnaDetailView(@ModelAttribute("QnaVO") QnaVO qVo) {
		
		ModelAndView mav = new ModelAndView();
		
		QnaVO qvo = qnaService.getQnaDetail(qVo.getI_number());

		ReplyVO rvo = new ReplyVO();
		/*rvo.setI_number(qvo.getI_number());*/
		
		ReplyVO reply = replyService.getReply(rvo);
		
		int total = qnaService.qnaListCnt(qvo);
		
		if (qvo == null) {
			mav.addObject("code", 0);
			mav.setViewName("admin/cc/adminQnaList");
		} else {
			
			if (reply == null) {
				mav.addObject("total", total);
				mav.addObject("qnaDetail", qvo);
				mav.setViewName("admin/cc/adminQnaDetail");
			} else {
				mav.addObject("reply", reply);
				mav.addObject("total", total);
				mav.addObject("qnaDetail", qvo);
				mav.setViewName("admin/cc/adminQnaDetail");
			}
			
		}
		
		return mav;
		
	}
	
	@RequestMapping(value="/qnaReplyRegForm.do", method=RequestMethod.GET)
	public ModelAndView qnaReplyRegForm(@RequestParam("i_number") int i_number) {
		
		ModelAndView mav = new ModelAndView();
		QnaVO qvo = qnaService.getQnaDetail(i_number);
		
		mav.addObject("qnaDetail", qvo);
		mav.setViewName("admin/cc/qnaReplyReg");
		
		return mav;
		
	}
	
}
