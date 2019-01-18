package com.myneko.admin.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.admin.qna.dao.QnaDAO;
import com.myneko.admin.qna.vo.QnaVO;

@Service
@Transactional
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaDAO qDao;
	
	@Override
	public List<QnaVO> getQnaList(QnaVO qvo) {
		// TODO Auto-generated method stub
		return qDao.getQnaList(qvo);
	}

	@Override
	public int qnaListCnt(QnaVO qvo) {
		// TODO Auto-generated method stub
		return (Integer)qDao.qnaListCnt(qvo);
	}

	@Override
	public QnaVO getQnaDetail(int i_number) {
		// TODO Auto-generated method stub
		return (QnaVO) qDao.getQnaDetail(i_number);
	}

	@Override
	public int whetherUpdate(QnaVO qvo) {
		// TODO Auto-generated method stub
		return (Integer) qDao.whetherUpdate(qvo);
	}

}
