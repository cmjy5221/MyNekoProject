package com.myneko.admin.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myneko.admin.member.dao.AMemberDAO;
import com.myneko.admin.member.vo.AMemberVO;
import com.myneko.common.vo.StatsVO;

import lombok.extern.java.Log;

@Service
@Log
public class AMemberServiceImpl implements AMemberService {

	@Autowired
	private AMemberDAO dao;

	@Override
	public List<AMemberVO> MemberList(AMemberVO mvo) {
		log.info("MemberService MeberList 호출");
		List<AMemberVO> list;
		list = dao.MemberList(mvo);
		return list;
	}

	@Override
	public int MemberCount(AMemberVO mvo) {
		log.info("MemberService MeberCount 호출");
		int result;
		result=dao.MemberCount(mvo);
		return result;
	}

	@Override
	public List<StatsVO> memberStatusList(AMemberVO mvo) {
		// TODO Auto-generated method stub
		return dao.memberStatusList(mvo);
	}

	@Override
	public int getMemberCount(AMemberVO mvo) {
		// TODO Auto-generated method stub
		return dao.getMemberCount(mvo);
	}

	@Override
	public StatsVO memberStats(AMemberVO mvo) {
		// TODO Auto-generated method stub
		return dao.memberStats(mvo);
	}

}
