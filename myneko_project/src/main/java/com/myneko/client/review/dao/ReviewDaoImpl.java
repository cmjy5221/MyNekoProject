package com.myneko.client.review.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.cart.vo.PartiorderVO;
import com.myneko.client.md.vo.MdVO;
import com.myneko.client.myorder.vo.myorderVO;
import com.myneko.client.review.vo.ReviewVO;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	private SqlSession session;

	public List<ReviewVO> reviewList(ReviewVO rvo) {
		return session.selectList("reviewList", rvo);
	}

	@Override
	public int reviewInsert(ReviewVO rvo) {
		return session.insert("reviewInsert", rvo);
	}

	// review 상세 구현
	@Override
	public ReviewVO reviewDetail(ReviewVO rvo) {
		return (ReviewVO) session.selectOne("reviewDetail", rvo);
	}

	@Override
	public int reviewUpdate(ReviewVO rvo) {
		return session.update("reviewUpdate", rvo);
	}

	@Override
	public int reviewDelete(int r_number) {
		return session.delete("reviewDelete", r_number);
	}

	@Override
	public List<ReviewVO> productReview(MdVO mdvo) {
		// TODO Auto-generated method stub
		return session.selectList("productReview", mdvo);
	}

	@Override
	public int reviewCnt(ReviewVO rvo) {
		// TODO Auto-generated method stub
		return session.selectOne("reviewCnt", rvo);
	}

	@Override
	public List<PartiorderVO> getPartiorderList(int o_number) {
		// TODO Auto-generated method stub
		return session.selectList("getPartiorderList", o_number);
	}

	@Override
	public int changeState(myorderVO mvo) {
		// TODO Auto-generated method stub
		return session.update("changeState", mvo);
	}

	@Override
	public int plusM(myorderVO mvo) {
		// TODO Auto-generated method stub
		return session.update("plusM", mvo);
	}

}
