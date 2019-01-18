package com.myneko.client.catcare.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.catcare.vo.CatcareVO;

@Repository
public class CatcareDaoImpl implements CatcareDao{
	
	@Autowired
	private SqlSession session;
	
	// 글 목록 구현
	@Override
	public List<CatcareVO> catcareList(CatcareVO cvo){
		return session.selectList("catcareList", cvo);
	}

	// 글 상세 구현
	@Override
	public CatcareVO catcareDetail(CatcareVO cvo) {
		return (CatcareVO)session.selectOne("catcareDetail", cvo);
		
	}

	// 전체 레코드 수 구현
	@Override
	public int catcareListCnt(CatcareVO cvo) {
		return (Integer)session.selectOne("catcareListCnt");
	}
	
}
