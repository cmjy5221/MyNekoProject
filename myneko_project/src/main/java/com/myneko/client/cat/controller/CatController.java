package com.myneko.client.cat.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myneko.client.cat.service.CatService;
import com.myneko.client.cat.vo.CatVO;
import com.myneko.common.file.FileUploadUtil;

@Controller
@RequestMapping("/cat")
public class CatController {

	@Autowired
	private CatService service;

	@RequestMapping(value = "/catList", method = RequestMethod.GET)
	public String catList(@ModelAttribute CatVO cvo, Model model, HttpSession session) {
		cvo.setM_number(session.getAttribute("m_number").toString());
		List<CatVO> list = service.catList(cvo);
		
		model.addAttribute("catList", list);
		model.addAttribute("cvo", cvo);

		return "/cat/catlist";
	}

	@RequestMapping(value = "/catInsert", method = RequestMethod.GET)
	public String Insert() {

		return "/cat/catinsert";
	}

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(@ModelAttribute CatVO cvo, HttpServletRequest request, HttpSession sessuon)
			throws IOException, IllegalStateException {
		int result = 0;
		String url = "";

		if (cvo.getFile() != null) {
			String c_file = FileUploadUtil.fileUpload(cvo.getFile(), request, "cat");

			cvo.setC_profile(c_file);
		}

		result = service.catInsert(cvo);
		List<CatVO> list = service.catList(cvo);
		
		if (list.size() <= 1) {
			System.out.println(list.get(0).getC_number());
			cvo.setC_number(list.get(0).getC_number());
			
			service.representOne(cvo);
		}

		if (result == 1) {
			url = "redirect:/mdlist/allmdlist";
		} else {
			url = "redirect:/cat/catInsert";
		}
		return url;
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public int deleteCat(@RequestParam("c_number") String c_number, HttpSession session) {
		int result = 0;
		System.out.println(c_number);
		String[] arrIdx = c_number.split(",");
		for (int i = 0; i < arrIdx.length; i++) {
			result = service.deleteCat(Integer.parseInt(arrIdx[i]));
			System.out.println(arrIdx[i]);
		}

		return result;
	}

	@RequestMapping(value = "/represent", method = RequestMethod.POST)
	@ResponseBody
	public int represent(@RequestParam("c_number") String c_number, HttpSession session) {
		int result = 0;
		CatVO cvo = new CatVO();
		cvo.setC_number(Integer.parseInt(c_number));

		System.out.println(session.getAttribute("m_number").toString());
		cvo.setM_number(session.getAttribute("m_number").toString());

		result = service.represent(cvo);

		return result;
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detailCat(@RequestParam("c_number") String c_number, @ModelAttribute CatVO cvo, Model model) {

		cvo = service.detailCat(Integer.parseInt(c_number));

		model.addAttribute("cvo", cvo);

		return "/cat/catdetail";
	}

}
