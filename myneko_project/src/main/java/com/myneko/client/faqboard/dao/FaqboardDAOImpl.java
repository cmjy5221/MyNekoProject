package com.myneko.client.faqboard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.faqboard.vo.FaqboardVO;
@Repository
public class FaqboardDAOImpl implements FaqboardDAO {
@Autowired
private SqlSession session;
	//글목록
	@Override
	public List<FaqboardVO> Faqboard(FaqboardVO bvo) {
		return session.selectList("Faqboard", bvo);
	}

	//글상세
	@Override
	public FaqboardVO boardDetail(FaqboardVO bvo) {
		return (FaqboardVO)session.selectOne("faqDetail", bvo);
	}
	//전체레코드 수 구현
	@Override
	public int faqBoardCnt(FaqboardVO bvo) {
		return (Integer) session.selectOne("faqBoardCnt", bvo);
	}
	
}
