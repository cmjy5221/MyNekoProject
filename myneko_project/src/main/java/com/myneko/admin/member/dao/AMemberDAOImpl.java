package com.myneko.admin.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.admin.member.vo.AMemberVO;
import com.myneko.common.vo.StatsVO;

import lombok.extern.java.Log;

@Repository
@Log
public class AMemberDAOImpl implements AMemberDAO {
	@Autowired
	public SqlSession session;

	@Override
	public List<AMemberVO> MemberList(AMemberVO mvo) {
		log.info("MemberDAO MeberList 호출");
		return session.selectList("memberList", mvo);
	}

	@Override
	public int MemberCount(AMemberVO mvo) {
		log.info("MemberDAO MeberCount 호출");
		return session.selectOne("memberCount", mvo);

	}

	@Override
	public List<StatsVO> memberStatusList(AMemberVO mvo) {
		// TODO Auto-generated method stub
		return session.selectList("memberStatusList", mvo);
	}

	@Override
	public int getMemberCount(AMemberVO mvo) {
		// TODO Auto-generated method stub
		return session.selectOne("getMemberCount", mvo);
	}

	@Override
	public StatsVO memberStats(AMemberVO mvo) {
		// TODO Auto-generated method stub
		return session.selectOne("memberStats", mvo);
	}

}
