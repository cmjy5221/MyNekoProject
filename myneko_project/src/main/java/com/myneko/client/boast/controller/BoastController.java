package com.myneko.client.boast.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myneko.client.boast.service.BoastService;
import com.myneko.client.boast.vo.BoastVO;
import com.myneko.client.boastreply.service.BoastReplyService;
import com.myneko.client.boastreply.vo.BoastReplyVO;
import com.myneko.common.file.FileUploadUtil;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/boast/**")
public class BoastController {
	
	@Autowired
	private BoastService boardService;

	@Autowired
	private BoastReplyService brService;
	
	// 글목록
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boastservice(@ModelAttribute BoastVO bvo, Model model) {
		// 페이징 세팅
		String url = "client/boast/boastList";
		Paging.setPage(bvo);
		// 전체 레코드수 구현
		int total = boardService.boastCnt(bvo);
		log.info(total + "" + bvo.getKeyword());
		// 글번호 재설정
		int count = total - (Util.nvl(bvo.getPage()) - 1) * Util.nvl(bvo.getPageSize());
		log.info("no" + bvo.getPage());
		List<BoastVO> boastList = boardService.boastList(bvo);
		model.addAttribute("boastList", boastList);
		model.addAttribute("total", total);
		model.addAttribute("count", count);
		model.addAttribute("data", bvo);
		// 페이징 추가
		return url;
	}

	// 상세구현
	@RequestMapping(value = "/boastDetail", method = RequestMethod.GET)
	public String boastDetail(@ModelAttribute BoastVO pvo, Model model) {
		log.info(pvo.getB_number() + "");
		BoastVO detail = new BoastVO();
		detail = boardService.boastDetail(pvo);
		System.out.println(detail.toString());
		if (detail != null) {
			detail.setB_content(detail.getB_content().toString().replaceAll("\n", "<br>"));
		}
		List<BoastReplyVO> replyList = null;
		BoastReplyVO brvo = new BoastReplyVO();
		brvo.setB_number(pvo.getB_number());
		replyList = brService.boastReplyList(brvo);
		model.addAttribute("detail", detail);
		model.addAttribute("replyList", replyList);
		return "boast/boastDetail";
	}

	// 글쓰기 폼 출력하기
	@RequestMapping(value = "/writeBoast")
	public String writeBoast() {
		log.info("writeBoast 호출성공");
		return "boast/writeBoast";
	}

	// 글쓰기 구현하기
	@RequestMapping(value = "/boastInsert", method = RequestMethod.POST)
	@ResponseBody
	public int boastInsert(@ModelAttribute BoastVO bvo, Model model, HttpServletRequest request) throws Exception {
		int result = 0;
		if(bvo.getFile() != null) {
			String b_image = FileUploadUtil.fileUpload(bvo.getFile(), request, "boast");
			bvo.setB_image(b_image);
		}
		result = boardService.boastInsert(bvo);
		return result;
	}
	
	@RequestMapping(value="/boastDelete", method=RequestMethod.GET)
	@ResponseBody
	public int boastDelete(@RequestParam(name="b_number", required=false) int b_number, HttpServletRequest request) throws Exception {
		
		int result = 0;
		
		BoastVO pvo = new BoastVO();
		pvo.setB_number(b_number);
		BoastVO bvo = boardService.boastDetail(pvo);
		
		if (bvo.getB_image() != null) {
			FileUploadUtil.fileDelete(bvo.getB_image(), request);
		}
		
		result = brService.boastReplyDeleteAll(b_number);
		result = boardService.boastDelete(b_number);
		return result;
		
	}
	
	@RequestMapping(value="/boastUpdate", method=RequestMethod.GET)
	public String boastUpdate(@ModelAttribute BoastVO bvo, Model model) {
		String url = "client/boast/boastModify";
		BoastVO bvo2 = boardService.boastDetail(bvo);
		model.addAttribute("data", bvo2);
		return url;
	}
	
	@RequestMapping(value="/boastUpdate", method=RequestMethod.POST)
	@ResponseBody
	public int boastUpdate(@ModelAttribute BoastVO bvo, HttpServletRequest request) throws Exception {
		int result = 0;
		
		if(bvo.getB_image() != null) {
			FileUploadUtil.fileDelete(bvo.getB_image(), request);
		}
		
		if(bvo.getFile() != null) {
			String b_image = FileUploadUtil.fileUpload(bvo.getFile(), request, "boast");
			bvo.setB_image(b_image);
		}
		
		result = boardService.boastUpdate(bvo);
		
		return result;
	}
}
