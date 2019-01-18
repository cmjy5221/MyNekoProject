package com.myneko.client.faqboard.service;

import java.util.List;

import com.myneko.client.faqboard.vo.FaqboardVO;

public interface FaqboardService {

	public List<FaqboardVO> Faqboard(FaqboardVO bvo);
	public FaqboardVO faqboardviewdatail(FaqboardVO pvo);
	public int faqBoardCnt(FaqboardVO fvo);

}
