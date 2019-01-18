package com.myneko.admin.reply.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.admin.reply.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public int insertReply(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return (Integer)session.insert("insertReply", rvo);
	}

	@Override
	public ReplyVO getReply(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return session.selectOne("getReply", rvo);
	}

}
