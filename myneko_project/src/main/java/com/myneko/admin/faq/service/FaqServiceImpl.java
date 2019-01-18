package com.myneko.admin.faq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.admin.faq.dao.FaqDAO;
import com.myneko.admin.faq.vo.FaqVO;

@Service
@Transactional
public class FaqServiceImpl implements FaqService {

	@Autowired
	private FaqDAO fDao;

	@Override
	public List<FaqVO> faqList(FaqVO fvo) {
		// TODO Auto-generated method stub
		return fDao.faqList(fvo);
	}

	@Override
	public int insertFaq(FaqVO fvo) {
		// TODO Auto-generated method stub
		return fDao.insertFaq(fvo);
	}

	@Override
	public FaqVO getFaqDetail(FaqVO fvo) {
		// TODO Auto-generated method stub
		return fDao.getFaqDetail(fvo);
	}

	@Override
	public int faqDelete(FaqVO fvo) {
		// TODO Auto-generated method stub
		return fDao.faqDelete(fvo);
	}

	@Override
	public int faqModify(FaqVO fvo) {
		// TODO Auto-generated method stub
		return fDao.faqModify(fvo);
	}

	@Override
	public int faqCnt(FaqVO fvo) {
		// TODO Auto-generated method stub
		return fDao.faqCnt(fvo);
	}
	
}
