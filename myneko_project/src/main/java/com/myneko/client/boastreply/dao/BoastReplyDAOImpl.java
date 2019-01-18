package com.myneko.client.boastreply.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.boastreply.vo.BoastReplyVO;

import lombok.extern.java.Log;

@Log
@Repository
public class BoastReplyDAOImpl implements BoastReplyDAO {

	@Autowired
	private SqlSession session;

	@Override
	public List<BoastReplyVO> boastReplyList(BoastReplyVO brvo) {
		// TODO Auto-generated method stub
		return session.selectList("boastReplyList", brvo);
	}

	@Override
	public int boastReplyInsert(BoastReplyVO brvo) {
		// TODO Auto-generated method stub
		return session.insert("boastReplyInsert", brvo);
	}

	@Override
	public int boastReplyUpdate(BoastReplyVO brvo) {
		// TODO Auto-generated method stub
		return session.update("boastReplyUpdate", brvo);
	}

	@Override
	public int boastReplyDelete(int br_number) {
		// TODO Auto-generated method stub
		return session.delete("boastReplyDelete", br_number);
	}

	@Override
	public int boastReplyDeleteAll(int b_number) {
		// TODO Auto-generated method stub
		return session.delete("boastReplyDeleteAll", b_number);
	}
	
}
