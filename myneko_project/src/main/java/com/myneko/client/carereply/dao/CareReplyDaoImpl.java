package com.myneko.client.carereply.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.carereply.vo.CareReplyVO;

@Repository
public class CareReplyDaoImpl implements CareReplyDao {

	@Autowired
	private SqlSession session;
	
	// 댓글 목록
	@Override
	public List<CareReplyVO> replyList(int ci_number) {
		return session.selectList("replyList", ci_number);
	}

	// 댓글 입력
	@Override
	public int replyInsert(CareReplyVO rvo) {
		return session.insert("replyInsert", rvo);
	}

	// 댓글 삭제
	@Override
	public int replyDelete(int rep_number) {
		return session.delete("replyDelete", rep_number);
	}

	// 댓글 수정
	@Override
	public int replyUpdate(CareReplyVO rvo) {
		return session.update("replyUpdate", rvo);
	}
	
	

}
