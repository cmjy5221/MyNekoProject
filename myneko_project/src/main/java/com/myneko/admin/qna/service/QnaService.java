package com.myneko.admin.qna.service;

import java.util.List;

import com.myneko.admin.qna.vo.QnaVO;

public interface QnaService {

	public List<QnaVO> getQnaList(QnaVO qvo);
	public int qnaListCnt(QnaVO qvo);
	public QnaVO getQnaDetail(int i_number);
	public int whetherUpdate(QnaVO qvo);
	
}
