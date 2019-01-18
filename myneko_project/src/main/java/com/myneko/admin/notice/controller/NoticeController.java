package com.myneko.admin.notice.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.admin.notice.service.NoticeService;
import com.myneko.admin.notice.vo.NoticeVO;
import com.myneko.common.file.FileUploadUtil;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/admin/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@RequestMapping(value = "/getNoticeList.do", method = RequestMethod.GET)
	public ModelAndView getNoticeList(@ModelAttribute("NoticeVO") NoticeVO nvo) {

		Paging.setPage(nvo);

		ModelAndView mav = new ModelAndView();

		int total = noticeService.noticeListCnt(nvo);

		int count = total - (Util.nvl(nvo.getPage()) - 1) * Util.nvl(nvo.getPageSize());

		List<NoticeVO> noticeList = noticeService.getNoticeList(nvo);

		mav.addObject("total", total);
		mav.addObject("count", count);
		mav.addObject("data", nvo);
		mav.addObject("noticeList", noticeList);
		mav.setViewName("admin/cc/adminNoticeList");

		return mav;

	}

	@RequestMapping(value = "/noticeRegForm.do", method = RequestMethod.GET)
	public String noticeRegForm(@ModelAttribute("NoticeVO") NoticeVO nvo) {
		return "admin/cc/noticeRegForm";
	}

	@RequestMapping(value = "/insertNotice.do", method = RequestMethod.POST)
	@ResponseBody
	public int insertNotice(@ModelAttribute("NoticeVO") NoticeVO nvo, HttpServletRequest request) throws Exception {

		System.out.println(nvo);

		if (nvo.getFile() != null) {
			String n_image = FileUploadUtil.fileUpload(nvo.getFile(), request, "notice");
			nvo.setN_image(n_image);
		}

		int result = 0;

		result = noticeService.insertNotice(nvo);

		return result;
	}

	@RequestMapping(value = "/getNoticeDetail.do", method = RequestMethod.GET)
	public ModelAndView getNoticeDetail(@ModelAttribute("NoticeVO") NoticeVO nvo) {
		ModelAndView mav = new ModelAndView();

		NoticeVO nVo = noticeService.getNoticeDetail(nvo);
		if (nVo != null) {
			mav.addObject("noticeDetail", nVo);
			mav.addObject("code", 1);
		} else {
			mav.addObject("code", 2);
		}

		mav.setViewName("admin/cc/noticeDetail");

		return mav;
	}

	@RequestMapping(value = "/noticeModForm.do", method = RequestMethod.GET)
	public ModelAndView noticeModForm(@ModelAttribute("NoticeVO") NoticeVO nvo) {
		ModelAndView mav = new ModelAndView();

		NoticeVO nVo = noticeService.getNoticeDetail(nvo);

		mav.addObject("noticeDetail", nVo);
		mav.setViewName("admin/cc/noticeModForm");

		return mav;
	}

	@RequestMapping(value = "/noticeModify.do", method = RequestMethod.POST)
	@ResponseBody
	public int noticeModify(@ModelAttribute("NoticeVO") NoticeVO nvo, HttpServletRequest request) throws Exception {

		int result = 0;
		if (nvo.getN_image() != null && nvo.getN_image() != "default.jpg") {
			FileUploadUtil.fileDelete(nvo.getN_image(), request);
		}
		if (nvo.getFile() != null) {
			String n_image = FileUploadUtil.fileUpload(nvo.getFile(), request, "notice");
			nvo.setN_image(n_image);
		}
		
		result = noticeService.noticeModify(nvo);

		return result;

	}

	@RequestMapping(value = "/noticeDelete.do", method = RequestMethod.GET)
	@ResponseBody
	public int noticeDelete(@ModelAttribute("NoticeVO") NoticeVO nvo, HttpServletRequest request) throws Exception {

		FileUploadUtil.fileDelete(nvo.getN_image(), request);

		int result = 0;
		result = noticeService.noticeDelete(nvo);

		return result;
	}
}
