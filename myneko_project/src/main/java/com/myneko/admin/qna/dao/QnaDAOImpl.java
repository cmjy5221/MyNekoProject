package com.myneko.admin.qna.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.admin.qna.vo.QnaVO;

@Repository
public class QnaDAOImpl implements QnaDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public List<QnaVO> getQnaList(QnaVO qvo) {
		// TODO Auto-generated method stub
		return session.selectList("getQnaList", qvo);
	}

	@Override
	public int qnaListCnt(QnaVO qvo) {
		// TODO Auto-generated method stub
		return (Integer) session.selectOne("qnaListCnt", qvo);
	}

	@Override
	public QnaVO getQnaDetail(int i_number) {
		// TODO Auto-generated method stub
		return (QnaVO) session.selectOne("getQnaDetail", i_number);
	}

	@Override
	public int whetherUpdate(QnaVO qvo) {
		// TODO Auto-generated method stub
		return (Integer) session.update("whetherUpdate", qvo);
	}

}
