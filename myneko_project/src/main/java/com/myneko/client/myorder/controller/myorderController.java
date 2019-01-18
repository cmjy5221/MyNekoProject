package com.myneko.client.myorder.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myneko.client.cart.vo.PartiorderVO;
import com.myneko.client.member.vo.MemberVO;
import com.myneko.client.myorder.service.myorderService;
import com.myneko.client.myorder.vo.myorderVO;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/myorder")
public class myorderController {

	@Autowired
	private myorderService myorderService;

	// 나의 주문내역 리스트 호출
	@RequestMapping(value = "/myorderList", method = RequestMethod.GET)
	public String myorderList(@ModelAttribute myorderVO mvo, Model model, HttpSession session) {
		log.info("myorderList 호출 성공");
		mvo.setPageSize("5");
		Paging.setPage(mvo);

		int m_number = (Integer) session.getAttribute("m_number");
		mvo.setM_number(m_number);

		// 전체 레코드 수 구현
		int total = myorderService.myorderListCnt(mvo);
		log.info("total = " + total);

		// 글번호 재설정
		int count = total - (Util.nvl(mvo.getPage()) - 1) * Util.nvl(mvo.getPageSize());
		log.info("count=" + count);

		List<myorderVO> myorderList = myorderService.myorderList(mvo);

		model.addAttribute("myorderList", myorderList);
		model.addAttribute("data", mvo);
		model.addAttribute("count", count);
		model.addAttribute("total", total);

		return "/myorder/myorderList";
	}

	@RequestMapping(value = "/myorderDetail", method = RequestMethod.GET)
	public String myorderDetail(@ModelAttribute myorderVO mvo, Model model) {
		log.info("myorderDetail 호출 성공");
		log.info("o_number=" + mvo.getO_number());

		myorderVO detail = new myorderVO();
		detail = myorderService.myorderDetail(mvo);

		List<PartiorderVO> findProduct = new ArrayList<>();
		MemberVO memvo = new MemberVO();
		myorderVO findOrder = new myorderVO();

		findProduct = myorderService.findProduct(mvo.getO_number());
		memvo = myorderService.findMember(mvo.getO_number());
		findOrder = myorderService.findOrder(mvo.getO_number());

		model.addAttribute("myorderDetail", detail);
		model.addAttribute("findProduct", findProduct);
		model.addAttribute("findOrder", findOrder);
		model.addAttribute("findMember", memvo);

		return "myorder/myorderDetail";
	}

	// myorder 삭제 구현하기
	@RequestMapping(value = "/myorderDelete")
	public String myorderDelete(@ModelAttribute myorderVO mvo, HttpSession m_number) {
		log.info("myorderDelete 호출 성공");

		int result = 0;

		result = myorderService.myorderDelete(mvo.getO_number());

		if (result == 1) {
			return "redirect:/myorder/myorderList?m_number=" + m_number.getAttribute("m_number");
		} else {
			return "redirect:/myorder/myorderDetail?o_number=" + mvo.getO_number();
		}
	}

	@RequestMapping(value = "/orderCancel", method = RequestMethod.POST)
	@ResponseBody
	public int orderCancel(@ModelAttribute myorderVO mvo, HttpSession session) {

		System.out.println(mvo.toString());

		int result = 0;

		result = myorderService.myorderChange(mvo);
		if (result == 1) {
			List<PartiorderVO> partiorderList = myorderService.getpartiorderlist(mvo.getO_number());

			for (int i = 0; i < partiorderList.size(); i++) {
				System.out.println(partiorderList.get(i).toString());
				result = myorderService.amountChange(partiorderList.get(i));
			}

		} else {
			result = 0;
		}

		return result;

	}

	@RequestMapping(value = "/oStateChange", method = RequestMethod.POST)
	@ResponseBody
	public int oStateChange(@ModelAttribute myorderVO mvo, HttpSession session) {

		int result = 0;

		int m_number = (Integer) session.getAttribute("m_number");

		mvo.setM_number(m_number);
		result = myorderService.myorderChange(mvo);

		if (result == 1) {
			result = 0;
			result = myorderService.plusMilage(mvo);
		} else {
			result = 0;
		}

		return result;

	}

}