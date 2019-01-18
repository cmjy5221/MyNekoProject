package com.myneko.client.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.cat.dao.CatDAO;
import com.myneko.client.member.dao.MemberDAO;
import com.myneko.client.member.vo.MemberVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO mdao;

	@Autowired
	private CatDAO cdao;

	@Override
	public int insertMember(MemberVO mvo) {

		return mdao.insertMember(mvo);
	}

	@Override
	public MemberVO loginMember(MemberVO mvo) {
		return mdao.loginMember(mvo);
	}

	@Override
	public int idOverlapChk(String id) {

		return mdao.idOverlapChk(id);
	}

	@Override
	public int updatePassword(MemberVO mvo) {
		return mdao.updatePassword(mvo);
	}

	@Override
	public int addressModifi(MemberVO mvo) {
		return mdao.addressModifi(mvo);
	}

	@Override
	public int modifi(MemberVO mvo) {
		return mdao.modifi(mvo);
	}

	@Override
	public int withdrawal(MemberVO mvo) {
		cdao.catAllDelete(mvo);
		
		return mdao.withdrawal(mvo);
		
	}

}
