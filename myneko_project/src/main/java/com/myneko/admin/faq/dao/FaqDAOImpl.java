package com.myneko.admin.faq.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.admin.faq.vo.FaqVO;

@Repository
public class FaqDAOImpl implements FaqDAO {

	@Autowired
	private SqlSession session;

	@Override
	public List<FaqVO> faqList(FaqVO fvo) {
		// TODO Auto-generated method stub
		return session.selectList("faqList", fvo);
	}

	@Override
	public int insertFaq(FaqVO fvo) {
		// TODO Auto-generated method stub
		return (Integer) session.insert("insertFaq", fvo);
	}

	@Override
	public FaqVO getFaqDetail(FaqVO fvo) {
		// TODO Auto-generated method stub
		return (FaqVO) session.selectOne("getFaqDetail", fvo);
	}

	@Override
	public int faqDelete(FaqVO fvo) {
		// TODO Auto-generated method stub
		return (Integer) session.delete("faqDelete", fvo);
	}

	@Override
	public int faqModify(FaqVO fvo) {
		// TODO Auto-generated method stub
		return (Integer) session.update("faqModify", fvo);
	}

	@Override
	public int faqCnt(FaqVO fvo) {
		// TODO Auto-generated method stub
		return session.selectOne("faqCnt", fvo);
	}
	
}
