package com.myneko.client.inquiry.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.client.cireply.vo.CIReplyVO;
import com.myneko.client.inquiry.service.ClientInquiryService;
import com.myneko.client.inquiry.vo.ClientInquiryVO;
import com.myneko.common.file.FileUploadUtil;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value="/client/inquiry")
public class ClientInquiryController {

	@Autowired
	private ClientInquiryService ciservice;
	
	@RequestMapping(value="/getCIList", method=RequestMethod.GET)
	public ModelAndView getCIList(@ModelAttribute ClientInquiryVO civo) {
		
		
		
		System.out.println(civo.getM_id());
		
		Paging.setPage(civo);
		
		ModelAndView mav = new ModelAndView();
		
		List<ClientInquiryVO> inquiryList = ciservice.getCIList(civo);
		
		int total = ciservice.getCICount(civo);
		
		int count = total - (Util.nvl(civo.getPage())-1) * Util.nvl(civo.getPageSize());
		
		mav.addObject("inquiryList", inquiryList);
		mav.addObject("total", total);
		mav.addObject("count", count);
		mav.addObject("data", civo);
		mav.setViewName("client/inquiry/inquiryList");
		
		return mav;
		
	}
	
	@RequestMapping(value="/CIinsert", method=RequestMethod.GET)
	public String CIinsert() {
		
		return "client/inquiry/inquiryWrite";
		
	}
	
	@RequestMapping(value="/CIinsert", method=RequestMethod.POST)
	@ResponseBody
	public int CIinsert(@ModelAttribute ClientInquiryVO civo, HttpServletRequest request) throws Exception {
		
		int result = 0;
		
		if (civo.getFile() != null) {
			String i_image = FileUploadUtil.fileUpload(civo.getFile(), request, "inquiry");
			civo.setI_image(i_image);
		}
		
		result = ciservice.CIinsert(civo);
		
		return result;
		
	}
	
	@RequestMapping(value="/inquiryDetail", method=RequestMethod.GET)
	public ModelAndView getCIDetail(@ModelAttribute ClientInquiryVO civo) {
		
		ModelAndView mav = new ModelAndView();
		
		ClientInquiryVO civo2 = ciservice.getCIDetail(civo);
		
		mav.addObject("inquiryDetail", civo2);
		mav.setViewName("client/inquiry/inquiryDetail");
		
		return mav;
		
	}
	
	@RequestMapping(value="/getCIReply", method=RequestMethod.GET)
	@ResponseBody
	public CIReplyVO getCIReply(@RequestParam(name="i_number", required=false) int i_number) {
		
		ClientInquiryVO civo = new ClientInquiryVO();
		civo.setI_number(i_number);
		
		CIReplyVO cirvo = ciservice.getCIReply(civo);
		return cirvo;
		
	}
	
}
