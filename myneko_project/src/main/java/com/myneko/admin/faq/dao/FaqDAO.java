package com.myneko.admin.faq.dao;

import java.util.List;

import com.myneko.admin.faq.vo.FaqVO;

public interface FaqDAO {

	public List<FaqVO> faqList(FaqVO fvo);
	public int insertFaq(FaqVO fvo);
	public FaqVO getFaqDetail(FaqVO fvo);
	public int faqDelete(FaqVO fvo);
	public int faqModify(FaqVO fvo);
	public int faqCnt(FaqVO fvo);
	
}
