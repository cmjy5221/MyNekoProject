package com.myneko.client.member.dao;

import com.myneko.client.member.vo.MemberVO;



public interface MemberDAO {

	public int insertMember(MemberVO mvo);
	
	public int idOverlapChk(String id);

	public MemberVO loginMember(MemberVO mvo);
	
	public int updatePassword(MemberVO mvo);
	
	public int addressModifi(MemberVO mvo);
	
	public int modifi(MemberVO mvo);
	
	public int withdrawal(MemberVO mvo);
	
}


