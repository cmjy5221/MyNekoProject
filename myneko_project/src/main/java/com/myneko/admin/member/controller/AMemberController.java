package com.myneko.admin.member.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.admin.member.service.AMemberService;
import com.myneko.admin.member.vo.AMemberVO;
import com.myneko.common.excel.ListExcelView;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;
import com.myneko.common.vo.StatsVO;

import lombok.extern.java.Log;

@Controller
@Log
@RequestMapping(value = "/admin")
public class AMemberController {
	@Autowired
	private AMemberService ms;

	@RequestMapping(value = "/memberList.do")
	public ModelAndView MemberList(@ModelAttribute AMemberVO mvo) {
		Paging.setPage(mvo);

		int total = ms.MemberCount(mvo);
		log.info("total = " + total);

		int count = total - (Util.nvl(mvo.getPage()) - 1) * Util.nvl(mvo.getPageSize());
		log.info("count = " + count);

		ModelAndView mav = new ModelAndView();
		List<AMemberVO> list = ms.MemberList(mvo);

		mav.addObject("memberList", list);
		mav.setViewName("/admin/member/memberList");
		mav.addObject("count", count);
		mav.addObject("total", total);
		mav.addObject("data", mvo);
		return mav;
	}

	@RequestMapping(value = "/memberCount")
	public int MemberCount(@ModelAttribute AMemberVO mvo) {
		int result;
		result = ms.MemberCount(mvo);
		return result;
	}

	@RequestMapping(value="/memberStatus", method=RequestMethod.GET)
	public String memberStatus(@RequestParam(name="firstDate", required=false) String firstDate, @RequestParam(name="lastDate", required=false) String lastDate, Model model, HttpServletRequest request) {
		
		AMemberVO mvo = new AMemberVO();
		
		mvo.setFirstDate(firstDate);
		mvo.setLastDate(lastDate);
		
		List<StatsVO> statsList = ms.memberStatusList(mvo);
		StatsVO svo = ms.memberStats(mvo);
		
		model.addAttribute("date", LocalDate.now());
		model.addAttribute("firstDate", mvo.getFirstDate());
		model.addAttribute("lastDate", mvo.getLastDate());
		model.addAttribute("joinCount", svo.getJoinCount());
		model.addAttribute("leaveCount", svo.getLeaveCount());
		model.addAttribute("stats", statsList);
		
		return "admin/stats/mStats";
		
	}

	@RequestMapping(value="/memberExcel", method=RequestMethod.GET)
	public ModelAndView memberExcel(@RequestParam(name="firstDate", required=false) String firstDate, @RequestParam(name="lastDate", required=false) String lastDate) {
		AMemberVO mvo = new AMemberVO();
		mvo.setFirstDate(firstDate);
		mvo.setLastDate(lastDate);
		List<StatsVO> statsList = ms.memberStatusList(mvo);
		ModelAndView mav = new ModelAndView(new ListExcelView());
		mav.addObject("list", statsList);
		mav.addObject("template", "mStats.xlsx");
		mav.addObject("file_name", "mStats");
		return mav;
	}
	
}
