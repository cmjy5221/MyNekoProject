package com.myneko.admin.faq.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.admin.faq.service.FaqService;
import com.myneko.admin.faq.vo.FaqVO;
import com.myneko.common.file.FileUploadUtil;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value="/admin/faq")
public class FaqController {

	@Autowired
	private FaqService faqService;
	
	@RequestMapping(value="/getFaqList.do", method=RequestMethod.GET)
	public ModelAndView getFaqList(@ModelAttribute("FaqVO") FaqVO fvo) {
		
		Paging.setPage(fvo);
		
		ModelAndView mav = new ModelAndView();
		List<FaqVO> faqList = faqService.faqList(fvo);

		int total = faqService.faqCnt(fvo);
		log.info("total = " + total);
		int count = total - (Util.nvl(fvo.getPage()) - 1) * Util.nvl(fvo.getPageSize());
		log.info("count =" + count);
		
		mav.addObject("total", total);
		mav.addObject("count", count);
		mav.addObject("data", fvo);
		mav.addObject("faqList", faqList);
		mav.addObject("firstDate", fvo.getFirstDate());
		mav.addObject("lastDate", fvo.getLastDate());
		mav.addObject("keyword", fvo.getKeyword());	
		mav.setViewName("admin/cc/adminFaqList");
		
		return mav;
		
	}
	
	@RequestMapping(value="/faqRegForm.do", method=RequestMethod.GET)
	public String faqRegForm() {
		return "admin/cc/faqRegForm";
	}
	
	@RequestMapping(value="/insertFaq.do", method=RequestMethod.POST)
	@ResponseBody
	public int insertFaq(@ModelAttribute("FaqVO") FaqVO fvo, HttpServletRequest request) throws Exception {
		
		if(fvo.getFile() != null) {
			String f_image = FileUploadUtil.fileUpload(fvo.getFile(), request, "faq");
			fvo.setF_image(f_image);
		}
		
		int result = faqService.insertFaq(fvo);
		
		return result;
		
	}
	
	@RequestMapping(value="/faqDetail.do", method=RequestMethod.GET)
	public ModelAndView faqDetail(@ModelAttribute("FaqVO") FaqVO fvo) {
		
		ModelAndView mav = new ModelAndView();
		
		FaqVO faqDetail = faqService.getFaqDetail(fvo);
		
		if (faqDetail != null) {
			mav.addObject("faqDetail", faqDetail);
			mav.setViewName("admin/cc/faqDetail");
		} else {
			mav.setViewName("admin/cc/faqRegForm");
		}
		
		return mav;
		
	}
	
	@RequestMapping(value="/faqDelete.do", method=RequestMethod.GET)
	@ResponseBody
	public int faqDelete(@ModelAttribute("FaqVO") FaqVO fvo, HttpServletRequest request) throws Exception {
		
		FileUploadUtil.fileDelete(fvo.getF_image(), request);
		
		int result = faqService.faqDelete(fvo);

		return result;
		
	}
	
	@RequestMapping(value="/faqModForm.do", method=RequestMethod.GET)
	public ModelAndView faqModForm(@ModelAttribute("FaqVO") FaqVO fvo) {
		
		ModelAndView mav = new ModelAndView();
		
		FaqVO faqDetail = faqService.getFaqDetail(fvo);
		
		mav.addObject("data", fvo);
		mav.addObject("faqDetail", faqDetail);
		mav.setViewName("admin/cc/faqModForm");
		
		return mav;
		
	}
	
	@RequestMapping(value="/faqModify.do", method=RequestMethod.POST)
	@ResponseBody
	public int faqModify(@ModelAttribute("FaqVO") FaqVO fvo, HttpServletRequest request) throws Exception {
		
		System.out.println(fvo);
		FileUploadUtil.fileDelete(fvo.getF_image(), request);
		String f_image = FileUploadUtil.fileUpload(fvo.getFile(), request, "faq");
		fvo.setF_image(f_image);
		
		int result = faqService.faqModify(fvo);
		
		System.out.println(fvo);
		
		return result;
		
	}
	
}
