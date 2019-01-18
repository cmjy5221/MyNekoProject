package com.myneko.client.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.member.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession session;

	@Override
	public int insertMember(MemberVO mvo) {
		return session.insert("insertMember", mvo);
	}

	@Override
	public MemberVO loginMember(MemberVO mvo) {
		
			return session.selectOne("loginMember", mvo);
		
	}

	@Override
	public int idOverlapChk(String id) {

		return session.selectOne("idOverlapChk", id);
	}

	@Override
	public int updatePassword(MemberVO mvo) {

		return session.update("updatePassword", mvo);
	}

	@Override
	public int addressModifi(MemberVO mvo) {
		return session.update("addressModifi", mvo);
	}

	@Override
	public int modifi(MemberVO mvo) {
		return session.update("modifi",mvo);
	}

	@Override
	public int withdrawal(MemberVO mvo) {
		return session.update("withdrawal",mvo);
	}

}
