package com.myneko.client.md.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myneko.client.cat.vo.CatVO;
import com.myneko.client.md.service.MdlistService;
import com.myneko.client.md.vo.MdVO;
import com.myneko.client.review.vo.ReviewVO;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/mdlist")
public class MdlistController {

	//
	@Autowired
	MdlistService mdlistservice;

	// 메인페이지
	@RequestMapping(value = "/allmdlist", method = RequestMethod.GET)
	public String allmdList(@ModelAttribute MdVO mdvo, Model model, HttpSession session) {
		log.info("--- all md list ---");
		CatVO cvo = new CatVO();

		if (session.getAttribute("m_number") != null) {
			log.info("--- for customer list ---");

			String m_number = session.getAttribute("m_number") + "";
			cvo = mdlistservice.capcatinfo(Integer.parseInt(m_number));


			if (!cvo.getC_taste().equals("noData")) {
				String keyword = "";

				// c_birth 에서 고양이생일 가져와서 개월수 알기
				String cbirth = "";
				
				if (Double.parseDouble(cvo.getC_birth()) < 13) {
					cbirth = "자묘";
				} else if (Double.parseDouble(cvo.getC_birth()) > 75) {
					cbirth = "노묘";
				} else {
					cbirth = "성묘";
				}

				// taste
				String ctaste = "";
				System.out.println("대표고양이의 식성 : " + cvo.getC_taste()); //
				if (cvo.getC_taste() == "습식선호") {
					ctaste = "습식";
				} else if (cvo.getC_taste() == "검식선호") {
					ctaste = "건식";
				} else if (cvo.getC_taste() == "색식선호") {
					ctaste = "생식";
				}

				// disease
				String cdisease = cvo.getC_disease();
				System.out.println("대표고양이 질병 : " + cvo.getC_disease());

				// chair
				String chair = "공통";
				System.out.println("대표고양이의 종류 : " + cvo.getC_division());
				switch (cvo.getC_division()) {
				case "페르시안":
				case "터키쉬 앙고라":
				case "노르웨이지언포레스트":
				case "네벨룽":
				case "라가머핀":
				case "라판":
				case "버만":
				case "셀커크렉스":
				case "소말리":
				case "시베리안":
				case "아메리칸 밥테일":
				case "아메리칸와이어헤어":
				case "이그저틱":
				case "터키시반":
				case "히말라얀":
				case "먼치킨":
				case "메인쿤":
				case "렉돌":
					chair = "장모";
					break;
				case "기타":
					chair = "중모";
					break;
				default:
					chair = "단모";
					break;
				}

				// mdlistservice.customlist(m_number);
				List<MdVO> customlist = new ArrayList<MdVO>();

				// 1. 모종
				keyword = chair;
				System.out.println(keyword);
				MdVO part = new MdVO();
				part = mdlistservice.customlist(keyword);
				if (part != null) {
					customlist.add(part);
				}

				// 2. 질병

				// 3. 입맛
				keyword = ctaste;
				part = mdlistservice.customlist(keyword);
				if (part != null) {
					customlist.add(part);
				}

				// 4. 개월수
				keyword = cbirth;
				part = mdlistservice.customlist(keyword);
				if (part != null) {
					customlist.add(part);
				}
		
				model.addAttribute("customlist", customlist);
			}
		}
				List<MdVO> mdlist = mdlistservice.allmdlist();
				model.addAttribute("mdlist", mdlist);
				model.addAttribute("data", mdvo);
			
		return "/mdlist/allmdlist";
	}

	// 카테고리별 목록
	@RequestMapping(value = "/mdlistcate", method = RequestMethod.GET)
	public String mdlistcate01(@ModelAttribute MdVO mdvo, Model model) {
		System.out.println("--- selected's p_division : " + mdvo.getP_division() + " ---");

		List<MdVO> mdlist = mdlistservice.mdlistcate(mdvo);

		model.addAttribute("mdlist", mdlist);
		model.addAttribute("data", mdvo);

		return "/mdlist/allmdlist";
	}

	// 로그인 후 추천 페이지
	@ResponseBody
	@RequestMapping(value = "/forcustomerlist", method = RequestMethod.GET)
	public String forcustomerlist(@ModelAttribute MdVO mdvo, @RequestParam String m_number, Model model) {
		log.info("--- for customer list ---");

		CatVO cvo = mdlistservice.capcatinfo(Integer.parseInt(m_number));

		String keyword = "";

		// c_birth 에서 고양이생일 가져와서 개월수 알기
		String cbirth = "";
		System.out.println("대표고양이의 나이(개월수) : " + cvo.getC_birth()); //
		if (Double.parseDouble(cvo.getC_birth()) < 13) {
			cbirth = "자묘";
		} else if (Double.parseDouble(cvo.getC_birth()) > 75) {
			cbirth = "노묘";
		} else {
			cbirth = "성묘";
		}

		// taste
		String ctaste = "";
		System.out.println("대표고양이의 식성 : " + cvo.getC_taste()); //
		if (cvo.getC_taste() == "습식선호") {
			ctaste = "습식";
		} else if (cvo.getC_taste() == "검식선호") {
			ctaste = "건식";
		} else if (cvo.getC_taste() == "색식선호") {
			ctaste = "생식";
		}

		// disease
		String cdisease = cvo.getC_disease();
		System.out.println("대표고양이 질병 : " + cvo.getC_disease());

		// chair
		String chair = "공통";
		System.out.println("대표고양이의 종류 : " + cvo.getC_division());
		switch (cvo.getC_division()) {
		case "페르시안":
		case "터키쉬 앙고라":
		case "노르웨이지언포레스트":
		case "네벨룽":
		case "라가머핀":
		case "라판":
		case "버만":
		case "셀커크렉스":
		case "소말리":
		case "시베리안":
		case "아메리칸 밥테일":
		case "아메리칸와이어헤어":
		case "이그저틱":
		case "터키시반":
		case "히말라얀":
		case "먼치킨":
		case "메인쿤":
		case "렉돌":
			chair = "장모";
			break;
		case "기타":
			chair = "중모";
			break;
		default:
			chair = "단모";
			break;
		}

		// mdlistservice.customlist(m_number);
		List<MdVO> customlist = new ArrayList<MdVO>();

		// 1. 모종
		keyword = "중간";// chair;
		System.out.println(keyword);
		MdVO part = new MdVO();
		part = mdlistservice.customlist(keyword);
		System.out.println("11111" + part.getP_name());
		customlist.add(part);

		// 2. 질병

		// 3. 입맛
		keyword = "건식";// ctaste;
		part = mdlistservice.customlist(keyword);
		System.out.println("22222" + part.getP_name());
		customlist.add(part);

		// 4. 개월수
		keyword = "자묘";// cbirth;
		part = mdlistservice.customlist(keyword);
		System.out.println("33333" + part.getP_name());
		customlist.add(part);

		model.addAttribute("customlist", customlist);
		model.addAttribute("data", mdvo);

		return "/mdlist/forcustomerlist";
	}

	// 상품상세페이지
	@RequestMapping(value = "/mddetail", method = RequestMethod.GET)
	public String mddetail(@ModelAttribute MdVO mdvo, Model model) {

		System.out.println("--- selected's p_number : " + mdvo.getP_number() + " ---");
		MdVO mddetail = new MdVO();
		mddetail = mdlistservice.mddetail(mdvo);

		List<ReviewVO> review = mdlistservice.getProductReview(mdvo.getP_number());
		
		if (review != null) {
			int reviewTotal = 0;
			int reviewCount = 0;
			for (int i = 0; i < review.size(); i++) {
				reviewTotal = reviewTotal + review.get(i).getR_starrate();
				reviewCount = reviewCount + 1;
			}
			model.addAttribute("review", review);
			model.addAttribute("reviewTotal", reviewTotal);
			model.addAttribute("reviewCount", reviewCount);
		}
		
		System.out.println("--- mddetail's p_number : " + mddetail.getP_number() + " ---");

		model.addAttribute("mddetail", mddetail);

		return "/mdlist/mddetail";
	}
}
