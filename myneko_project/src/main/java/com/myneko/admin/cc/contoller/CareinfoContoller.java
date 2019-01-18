package com.myneko.admin.cc.contoller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.admin.cc.service.CareinfoService;
import com.myneko.admin.cc.vo.CareinfoBoardVO;
import com.myneko.common.file.FileUploadUtil;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;

@Controller
@Log
@RequestMapping(value = "/admin/careinfo")
public class CareinfoContoller {

	@Autowired
	private CareinfoService cs;

	@RequestMapping(value = "/careinfoList.do", method = RequestMethod.GET)
	public ModelAndView CareinfoList(@ModelAttribute CareinfoBoardVO cvo) {

		log.info(cvo.getOrder_by());

		System.out.println(cvo.getLastDate());
		log.info("CareinfoList 호출");
		Paging.setPage(cvo);
		int total = cs.CareinfoCount(cvo);

		log.info("total = " + total);

		int count = total - (Util.nvl(cvo.getPage()) - 1) * Util.nvl(cvo.getPageSize());
		log.info("count = " + count);
		ModelAndView mav = new ModelAndView();
		List<CareinfoBoardVO> list = cs.CareInfoBoardList(cvo);
		mav.addObject("boardList", list);
		mav.addObject("data", cvo);
		mav.addObject("count", count);
		mav.addObject("total", total);
		mav.setViewName("/admin/careinfo/careinfoList");
		return mav;
	}

	@RequestMapping(value = "/careinfoWriteForm.do", method = RequestMethod.GET)
	public ModelAndView CareinfoWriteForm() {
		log.info("careinfoWirteForm 호출");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/admin/careinfo/careinfoWriteForm");
		return mav;
	}

	@RequestMapping(value = "/careinfoWrite.do", method = RequestMethod.POST)
	@ResponseBody
	public int CareinfoWrite(@ModelAttribute CareinfoBoardVO cvo, HttpServletRequest request) {
		log.info("careinfoWirte 호출");
		try {
			String ci_image = FileUploadUtil.fileUpload(cvo.getCi_file(), request, "catcareinfo");
			cvo.setCi_image(ci_image);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int result = cs.CareinfoInsert(cvo);
		return result;

	}

	@RequestMapping(value = "/careinfoDelete.do", method = RequestMethod.POST)
	public ModelAndView CareinfoDelete(@ModelAttribute CareinfoBoardVO cvo, HttpServletRequest request) {
		log.info("careinfoDelete 호출");
		String[] ci_number = request.getParameterValues("del_check");
		log.info("ci_number.length : " + ci_number.length);
		int result = 0;
		for (int i = 0; i < ci_number.length; i++) {
			cvo.setCi_number(Integer.parseInt(ci_number[i]));
			int count = cs.CareinfoDelete(cvo);
			result += count;
		}
		ModelAndView mav = new ModelAndView();

		mav.addObject("deleteCount", result);
		mav.setViewName("/admin/careinfo/careinfoList");
		return mav;
	}

	@RequestMapping(value = "/careinfoOneDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public int CareinfoDelete(@ModelAttribute CareinfoBoardVO cvo) {
		log.info("careinfoOneDelete 호출");
		int result = 0;
		result = cs.CareinfoDelete(cvo);
		return result;
	}

	@RequestMapping(value = "/careinfoDetail.do", method = RequestMethod.GET)
	public ModelAndView CareinfoDetail(@ModelAttribute CareinfoBoardVO cvo) {
		log.info("careinfoDetail 호출");
		ModelAndView mav = new ModelAndView();
		CareinfoBoardVO result = cs.CareinfoDetail(cvo);
		mav.setViewName("/admin/careinfo/careinfoDetail");
		mav.addObject("careinfo", result);
		mav.addObject("data", cvo);
		return mav;
	}

	@RequestMapping(value = "/careinfoModifyForm.do", method = RequestMethod.GET)
	public ModelAndView CareinfoModifyForm(@ModelAttribute CareinfoBoardVO cvo) {
		log.info("careinfoModifyForm 호출");
		ModelAndView mav = new ModelAndView();
		CareinfoBoardVO result = cs.CareinfoDetail(cvo);
		mav.setViewName("/admin/careinfo/careinfoModifyForm");
		mav.addObject("careinfo", result);
		mav.addObject("data", cvo);
		return mav;
	}

	@RequestMapping(value = "/careinfoModify.do", method = RequestMethod.POST)
	@ResponseBody
	public int CareinfoModify(@ModelAttribute CareinfoBoardVO cvo, HttpServletRequest request) {
		log.info("careinfoModify 호출");

		if (cvo.getCi_file() != null) {
			try {
				String ci_image = FileUploadUtil.fileUpload(cvo.getCi_file(), request, "catcareinfo");
				cvo.setCi_image(ci_image);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		int result = cs.CareinfoModify(cvo);
		return result;
	}
}
