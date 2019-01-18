package com.myneko.client.mail.controller;

import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myneko.client.mail.service.MailService;
import com.myneko.client.member.vo.MemberVO;

@Controller
@RequestMapping(value = "/sendMail")
public class MailController {

	@Autowired
	private MailService service;

	@RequestMapping(value = "/id", method = RequestMethod.GET)
	public String selectId() {

		return "mail/id";
	}

	@RequestMapping(value="/password", method=RequestMethod.GET)
	public String password(@RequestParam(name="m_id", required=false) String m_id, Model model) {
		
		model.addAttribute("m_id", m_id);
		return "mail/password";
	}
	
	@RequestMapping(value = "/passwordemp", method = RequestMethod.GET)
	public String selectPassword() {
		return "mail/password";
	}

	@ResponseBody
	@RequestMapping(value = "/id", method = RequestMethod.POST)
	public List<MemberVO> Id(@RequestParam("email") String email) {
	
		MemberVO mvo = new MemberVO();
		mvo.setM_email(email);
		mvo.setM_state("정상");
		List<MemberVO> idList = service.findAccount(mvo);
		System.out.println(idList.toString());
		return idList;

	}

	@RequestMapping(value = "/password", method = RequestMethod.POST)
	@ResponseBody
	public String Id(@RequestParam("m_email") String email, @RequestParam("m_id") String id) {
		String user = "gmlrkd18207766@gmail.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
		String password = "wkdrk7264"; // 패스워드

		// SMTP 서버 정보를 설정한다.
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		try {
			MemberVO mvo = new MemberVO();
			mvo.setM_email(email);
			mvo.setM_id(id);

			mvo = service.accountOne(mvo);
			
			StringBuffer sb = new StringBuffer();
			System.out.println(email);
			sb.append("<!DOCTYPE html>");
			sb.append("<html>");
			sb.append("<head>");
			sb.append("<meta charset=\"UTF-8\">");
			sb.append("<title></title>");
			sb.append("<body>");
			sb.append("<div>비밀번호 찾기</div>");
			sb.append("<div><a href=localhost:8080/member/passwordmodifi?m_id=" + mvo.getM_id() + ">비밀번호 변경</a></div>");
			sb.append("</body>");
			sb.append("</html>");
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.setContent(sb.toString(), "text/html; charset=utf-8");
			// 수신자메일주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mvo.getM_email()));

			// Subject
			message.setSubject("우리집고양이 사이트 회원 비밀번호 찾기"); // 메일 제목을 입력

			// Text
			/* message.setText(); */ // 메일 내용을 입력
//			message.setContent(sb.toString(),"");
			// send the message
			Transport.send(message); //// 전송
			System.out.println("message sent successfully...");

			System.out.println("성공");
			return "true";
			// 메일을 발신한다
		} catch (AddressException e) {
			e.printStackTrace();
			System.out.println("실패");
			return "false";
		} catch (MessagingException e) {
			e.printStackTrace();
			System.out.println("실패");
			return "false";
		}

	}
}
