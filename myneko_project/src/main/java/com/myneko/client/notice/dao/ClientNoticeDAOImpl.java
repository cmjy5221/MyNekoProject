package com.myneko.client.notice.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.notice.vo.ClientNoticeVO;

import lombok.extern.java.Log;

@Log
@Repository
public class ClientNoticeDAOImpl implements ClientNoticeDAO {

	@Autowired
	private SqlSession session;

	@Override
	public List<ClientNoticeVO> noticeList(ClientNoticeVO cnvo) {
		// TODO Auto-generated method stub
		return session.selectList("noticeList", cnvo);
	}

	@Override
	public int noticeCount(ClientNoticeVO cnvo) {
		// TODO Auto-generated method stub
		return session.selectOne("noticeCount", cnvo);
	}

	@Override
	public ClientNoticeVO cnoticeDetail(ClientNoticeVO cnvo) {
		// TODO Auto-generated method stub
		return session.selectOne("cnoticeDetail", cnvo);
	}
	
}
