package com.myneko.client.inquiry.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.cireply.vo.CIReplyVO;
import com.myneko.client.inquiry.vo.ClientInquiryVO;

@Repository
public class ClientInquiryDAOImpl implements ClientInquiryDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public List<ClientInquiryVO> getCIList(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return session.selectList("getCIList", civo);
	}

	@Override
	public int getCICount(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return session.selectOne("getCICount", civo);
	}

	@Override
	public int CIinsert(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return session.insert("CIinsert", civo);
	}

	@Override
	public ClientInquiryVO getCIDetail(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return session.selectOne("getCIDetail", civo);
	}

	@Override
	public CIReplyVO getCIReply(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return session.selectOne("getCIReply", civo);
	}

}
