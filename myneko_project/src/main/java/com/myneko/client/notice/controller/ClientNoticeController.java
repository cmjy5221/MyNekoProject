package com.myneko.client.notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.myneko.client.notice.service.ClientNoticeService;
import com.myneko.client.notice.vo.ClientNoticeVO;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

@Controller
@RequestMapping(value="/client/notice")
public class ClientNoticeController {

	@Autowired
	private ClientNoticeService cns;
	
	@RequestMapping(value="/noticeList", method=RequestMethod.GET)
	public String noticeList(@ModelAttribute("ClientNoticeVO") ClientNoticeVO cnvo, Model model) {
		
		Paging.setPage(cnvo);
		
		int total = cns.noticeCount(cnvo);
		int count = total - (Util.nvl(cnvo.getPage()) - 1) * Util.nvl(cnvo.getPageSize());

		System.out.println(total);
		System.out.println(count);
		
		List<ClientNoticeVO> noticeList = cns.noticeList(cnvo);
		
		model.addAttribute("notice", noticeList);
		model.addAttribute("total", total);
		model.addAttribute("count", count);
		model.addAttribute("data", cnvo);
		
		return "client/notice/noticeList";
		
	}
	
	@RequestMapping(value="/noticeDetail", method=RequestMethod.GET)
	public String noticeDetail(@ModelAttribute("ClientNoticeVO") ClientNoticeVO cnvo, Model model) {
		
		ClientNoticeVO cnvo2 = cns.cnoticeDetail(cnvo);
		
		model.addAttribute("noticeDetail", cnvo2);
		
		return "client/notice/noticeDetail";
		
	}
	
}
