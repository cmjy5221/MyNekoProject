package com.myneko.client.member.controller;

import java.security.MessageDigest;

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
import org.springframework.web.bind.annotation.SessionAttributes;

import com.myneko.client.mail.dao.MailDAO;
import com.myneko.client.mail.service.MailService;
import com.myneko.client.member.service.MemberService;
import com.myneko.client.member.vo.MemberVO;

@Controller
@RequestMapping(value = "/member/")
@SessionAttributes({ "m_id", "m_state", "m_number", "m_name", "m_email", "m_phone", "m_postcode","m_mileage", "m_address" })
public class MemberController {

	@Autowired
	private MemberService service;
	
	
	@RequestMapping(value="/joinsuccess")
	public String joinSuccess() {
		return "/member/joinsuccess";
	}
	

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {

		return "/member/login";
	}

	@RequestMapping(value = "/terms", method = RequestMethod.GET)
	public String terms() {
		return "/member/terms";
	}

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {

		return "/member/join";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {

		return "/member/logout";
	}

	@RequestMapping(value = "/idSelect", method = RequestMethod.GET)
	public String idSelect() {
		return "/member/idselect";
	}

	@RequestMapping(value = "/passwordmodifi", method = RequestMethod.GET)
	public String passwordModifiForm(@ModelAttribute MemberVO mvo) {

		return "member/passwordmodifi";
	}

	@RequestMapping(value = "/modifi", method = RequestMethod.GET)
	public String modifiForm() {

		return "/member/modifi";
	}

	@RequestMapping(value = "/addressmodifi", method = RequestMethod.GET)
	public String addressModifiForm() {

		return "client/member/exception/addressmodifi";
	}

	@RequestMapping(value = "/addressmodifi", method = RequestMethod.POST)
	@ResponseBody
	public int addressModifi(@RequestParam("m_zipcode") String m_zipcode, @RequestParam("m_address") String m_address,
			Model model, HttpSession session) {
		int result = 0;
		MemberVO mvo = new MemberVO();
		mvo.setM_postcode(m_zipcode);
		mvo.setM_address(m_address);
		mvo.setM_number(Integer.parseInt(session.getAttribute("m_number").toString()));

		result = service.addressModifi(mvo);

		model.addAttribute("m_zipcode", m_zipcode);
		model.addAttribute("m_address", m_address);

		return result;
	}

	@RequestMapping(value = "/modifi", method = RequestMethod.POST)
	@ResponseBody
	public int modifi(@RequestParam("m_phone") String m_phone, @RequestParam("m_name") String m_name,
			@RequestParam("m_email") String m_email, Model model, HttpSession session) {
		int result = 0;
		MemberVO mvo = new MemberVO();
		mvo.setM_email(m_email);
		mvo.setM_name(m_name);
		mvo.setM_phone(m_phone);
		mvo.setM_number(Integer.parseInt(session.getAttribute("m_number").toString()));
		result = service.modifi(mvo);

		if (result == 1) {
			model.addAttribute("m_name", m_name);
			model.addAttribute("m_phone", m_phone);
			model.addAttribute("m_email", m_email);
		}

		return result;
	}

	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String memberjoin(@ModelAttribute MemberVO mvo) {
		int result = 0;
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");

			sh.update(mvo.getM_password().getBytes());

			byte byteData[] = sh.digest();

			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			mvo.setM_password(sb.toString());
			System.out.println(mvo.getM_password());
			result = service.insertMember(mvo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (result == 1)
			return "redirect:/member/joinsuccess";
		else {
			return "redirect:/member/join";
		}
	}

	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(@RequestParam("m_id") String m_id) {
		int result = 0;

		result = service.idOverlapChk(m_id);

		return result;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String loginMember(@RequestParam("id") String id, @RequestParam("pass") String pass, Model model,
			HttpSession session) {
		try {
			MemberVO mvo = new MemberVO();

			MessageDigest sh = MessageDigest.getInstance("SHA-256");

			sh.update(pass.getBytes());

			byte byteData[] = sh.digest();

			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			mvo.setM_id(id);
			mvo.setM_password(sb.toString());
			
			mvo = service.loginMember(mvo);
			
			System.out.println(mvo.toString());
			
			if (mvo.getM_state().equals("정상")) {
			
				model.addAttribute("m_id", mvo.getM_id());
				model.addAttribute("m_number", mvo.getM_number());
				model.addAttribute("m_name", mvo.getM_name());
				model.addAttribute("m_phone", mvo.getM_phone());
				model.addAttribute("m_email", mvo.getM_email());
				model.addAttribute("m_name", mvo.getM_name());
				model.addAttribute("m_postcode", mvo.getM_postcode());
				model.addAttribute("m_address", mvo.getM_address());
				model.addAttribute("m_state",mvo.getM_state());
				model.addAttribute("m_mileage",mvo.getM_mileage());
				session.setAttribute("m_mileage", mvo.getM_mileage());
				session.setMaxInactiveInterval(60 * 60);

				return mvo.getM_state();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "";
	}

	@RequestMapping(value = "/passwordmodifi", method = RequestMethod.POST)
	@ResponseBody
	public int passwordModifi(@RequestParam("m_id") String m_id,
			@RequestParam("m_password") String m_password) {
		MemberVO mvo = new MemberVO();
		int result = 0;
		

		try {
			
			
			MessageDigest sh = MessageDigest.getInstance("SHA-256");

			sh.update(m_password.getBytes());

			byte byteData[] = sh.digest();

			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			System.out.println();
			mvo.setM_id(m_id);
			mvo.setM_password(sb.toString());

			result = service.updatePassword(mvo);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;

	}

	@RequestMapping(value = "/withdrawal", method = RequestMethod.POST)
	@ResponseBody
	public int withdrawal(@RequestParam("m_number") String m_number) {
		int result = 0;
		MemberVO mvo = new MemberVO();

		mvo.setM_number(Integer.parseInt(m_number));
		mvo.setM_state("탈퇴");
		
		result = service.withdrawal(mvo);

		return result;
	}
}
