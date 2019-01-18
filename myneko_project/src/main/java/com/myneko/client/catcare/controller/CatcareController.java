package com.myneko.client.catcare.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.myneko.client.catcare.service.CatcareService;
import com.myneko.client.catcare.vo.CatcareVO;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;


@Controller
@RequestMapping(value="/catcare")
@Log
public class CatcareController {
	
	@Autowired
	private CatcareService catcareService;
	
	
	// 글 목록 구현하기
	@RequestMapping(value="/catcareList", method = RequestMethod.GET)
	public String catcareList(@ModelAttribute CatcareVO cvo, Model model) {
		log.info("catcareList 호출 성공!");
		
		// 페이지 세팅
		Paging.setPage(cvo);
		
		// 전체 레코드 수 구현
		int total = catcareService.catcareListCnt(cvo);
		log.info("total = " + total);
		
		// 글번호 재설정
		int count = total - (Util.nvl(cvo.getPage())-1) * Util.nvl(cvo.getPageSize());
		log.info("count = " + count);

		List<CatcareVO> catcareList = catcareService.catcareList(cvo);
		model.addAttribute("catcareList", catcareList);
		model.addAttribute("count", count);
		model.addAttribute("total", total);
		model.addAttribute("data", cvo);
		
		return "catcare/catcareList";
	}
	
	// 글 상세보기 구현하기
	@RequestMapping(value="/catcareDetail.do", method=RequestMethod.GET)
	public String boardDetail(@ModelAttribute CatcareVO ovo, Model model) {
		log.info("catcareDetail 호출 성공!");
		log.info("ci_number = " + ovo.getCi_number());
		
		CatcareVO detail = new CatcareVO();
		detail = catcareService.catcareDetail(ovo);
		
		if(detail != null) {
			detail.setCi_content(detail.getCi_content().toString().replaceAll("\n", "<br>"));
		}

		model.addAttribute("detail", detail);
		return "catcare/catcareDetail";
	}

}