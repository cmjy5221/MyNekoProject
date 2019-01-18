package com.myneko.client.inquiry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.cireply.vo.CIReplyVO;
import com.myneko.client.inquiry.dao.ClientInquiryDAO;
import com.myneko.client.inquiry.vo.ClientInquiryVO;

@Service
@Transactional
public class ClientInquiryServiceImpl implements ClientInquiryService {

	@Autowired
	private ClientInquiryDAO cidao;

	@Override
	public List<ClientInquiryVO> getCIList(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return cidao.getCIList(civo);
	}

	@Override
	public int getCICount(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return cidao.getCICount(civo);
	}

	@Override
	public int CIinsert(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return cidao.CIinsert(civo);
	}

	@Override
	public ClientInquiryVO getCIDetail(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return cidao.getCIDetail(civo);
	}

	@Override
	public CIReplyVO getCIReply(ClientInquiryVO civo) {
		// TODO Auto-generated method stub
		return cidao.getCIReply(civo);
	}
	
}
