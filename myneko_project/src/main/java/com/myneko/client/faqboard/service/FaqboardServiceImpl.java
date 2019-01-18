package com.myneko.client.faqboard.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.faqboard.dao.FaqboardDAO;
import com.myneko.client.faqboard.vo.FaqboardVO;

@Service
@Transactional
public class FaqboardServiceImpl implements FaqboardService {
	@Autowired
	private FaqboardDAO FaqboardDAO;
	
	@Override
	//글목록
	public  List<FaqboardVO> Faqboard(FaqboardVO bvo) {
		List<FaqboardVO> myList = new ArrayList<FaqboardVO>();
		myList = FaqboardDAO.Faqboard(bvo);
		return myList ;
	}
	//글상세
	@Override
	public FaqboardVO faqboardviewdatail(FaqboardVO bvo) {
		FaqboardVO detail = null;
		detail = FaqboardDAO.boardDetail(bvo);
		return detail;
	}
	//전체 레코드 수 구현
	@Override
	public int faqBoardCnt(FaqboardVO fvo) {
		return FaqboardDAO.faqBoardCnt(fvo);
	}

}
