package com.myneko.client.faqboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.myneko.client.faqboard.service.FaqboardService;
import com.myneko.client.faqboard.vo.FaqboardVO;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;
@Log
@Controller
@RequestMapping(value = "/faqboard/**")
public class FaqboardController {
	@Autowired
	private FaqboardService FaqboardService;
	//글목록
	@RequestMapping(value="/faqboardlist",method = RequestMethod.GET)
	public String faqbordservice( @ModelAttribute FaqboardVO bvo, Model model) {
				//페이징 세팅
				Paging.setPage(bvo);
				
				//전체 레코드수 구현
				int total = FaqboardService.faqBoardCnt(bvo);
				log.info(total + "" + bvo.getKeyword());
				
				//글번호 재설정
				int count = total - (Util.nvl(bvo.getPage()) - 1) * Util.nvl(bvo.getPageSize()); 
				log.info("no"+bvo.getPage());
				
				List<FaqboardVO> Faqboard = FaqboardService.Faqboard(bvo);
				
				model.addAttribute("Faqboard", Faqboard);
				//페이징 추가
				model.addAttribute("count",count);
				model.addAttribute("total",total);
				//페이징 추가end 
				model.addAttribute("data", bvo);
				
				return "Faqboard/faqboard";
		}
	
	//상세구현
		@RequestMapping(value = "/faqdetail.do", method = RequestMethod.GET)
		public String faqboardviewdetails(@ModelAttribute FaqboardVO pvo, Model model) {
			log.info(pvo.getF_number()+"");
			FaqboardVO detail = new FaqboardVO();
			detail =  FaqboardService.faqboardviewdatail(pvo); 
			if(detail!=null) {
				detail.setF_content(detail.getF_content().toString().replaceAll("\n","<br>"));
			}
			model.addAttribute("detail",detail);
			return "Faqboard/faqboardviewdetails";	
			
		}
}
