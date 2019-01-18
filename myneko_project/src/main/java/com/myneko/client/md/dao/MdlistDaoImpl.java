package com.myneko.client.md.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.cat.vo.CatVO;
import com.myneko.client.md.vo.MdVO;
import com.myneko.client.review.vo.ReviewVO;

@Repository
public class MdlistDaoImpl implements MdlistDao {

	@Autowired
	private SqlSession session;

	//상품리스트
	@Override
	public List<MdVO> allmdlist() {
		return session.selectList("allmdlist");
	}

	//상세보기
	@Override
	public MdVO mddetail(MdVO mdvo) {
		return (MdVO) session.selectOne("mddetail", mdvo);
	}

	// call custom list
	@Override
	public MdVO customlist(String keyword) {
		return session.selectOne("customlist", keyword);
	}

	// call md = selected category
	@Override
	public List<MdVO> mdlistcate(MdVO mdvo) {
		return session.selectList("mdlistcate", mdvo);
	}

	//call captain cat 's info
	@Override
	public CatVO capcatinfo(int m_number) {
		return session.selectOne("capcatinfo", m_number);
	}

	@Override
	public List<ReviewVO> getProductReview(int p_number) {
		// TODO Auto-generated method stub
		return session.selectList("getProductReview", p_number);
	}

}
