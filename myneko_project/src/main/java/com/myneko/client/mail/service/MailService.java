package com.myneko.client.mail.service;

import java.util.List;

import com.myneko.client.member.vo.MemberVO;

public interface MailService {
	
	public List<MemberVO> findAccount(MemberVO mvo);

	public MemberVO findPassword(MemberVO mvo);
	
	public MemberVO accountOne(MemberVO mvo);

}
