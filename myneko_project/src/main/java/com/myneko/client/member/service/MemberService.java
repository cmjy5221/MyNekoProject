package com.myneko.client.member.service;

import com.myneko.client.member.vo.MemberVO;

public interface MemberService {

	public int insertMember(MemberVO mvo);

	public int idOverlapChk(String id);

	public MemberVO loginMember(MemberVO mvo);
	
	public int updatePassword(MemberVO mvo);
	
	public int addressModifi(MemberVO mvo);
	
	public int modifi(MemberVO mvo);
	
	public int withdrawal(MemberVO mvo);
	
}
