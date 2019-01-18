package com.myneko.client.mail.dao;

import java.util.List;

import com.myneko.client.member.vo.MemberVO;

public interface MailDAO {

	public List<MemberVO> findAccount(MemberVO mvo);

	public MemberVO findPassword(MemberVO mvo);
	
	public MemberVO accountOne(MemberVO mvo);


}
