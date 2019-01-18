package com.myneko.client.faqboard.dao;

import java.util.List;

import com.myneko.client.faqboard.vo.FaqboardVO;

public interface FaqboardDAO {
	//글목록
	public List<FaqboardVO> Faqboard(FaqboardVO bvo);
	//글상세
	public FaqboardVO boardDetail(FaqboardVO bvo);
	//페이징
	public int faqBoardCnt(FaqboardVO bvo);
}
