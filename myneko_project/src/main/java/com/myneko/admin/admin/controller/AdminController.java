package com.myneko.admin.admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.admin.admin.service.AdminService;
import com.myneko.admin.admin.vo.AdminVO;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@RequestMapping(value="/adminLogin.do", method=RequestMethod.GET)
	public String loginForm() {
		return "admin/login";
	}
	
	@RequestMapping(value="/adminLogin.do", method=RequestMethod.POST)
	@ResponseBody
	public int adminLogin(@ModelAttribute("AdminVO") AdminVO avo, HttpSession session) {

		int result = 0;
		
		AdminVO aVo = adminService.adminLogin(avo);
		
		if (aVo != null) {
			session.setAttribute("adminId", aVo.getA_id());
			session.setAttribute("a_number", aVo.getA_number());
			session.setMaxInactiveInterval(60*60);
			result = 1;
		} else {
			result = 0;
		}
		
		return result;
		
	}
	
	@RequestMapping(value="/adminLogout.do")
	public String adminLogout(HttpSession session) {
		
		session.removeAttribute("adminId");
		session.invalidate();
		
		return "admin/login";
	}
	
}
