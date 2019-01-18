package com.myneko.client.inquiry.service;

import java.util.List;

import com.myneko.client.cireply.vo.CIReplyVO;
import com.myneko.client.inquiry.vo.ClientInquiryVO;

public interface ClientInquiryService {

	public List<ClientInquiryVO> getCIList(ClientInquiryVO civo);
	public int getCICount(ClientInquiryVO civo);
	public int CIinsert(ClientInquiryVO civo);
	public ClientInquiryVO getCIDetail(ClientInquiryVO civo);
	public CIReplyVO getCIReply(ClientInquiryVO civo);
	
}
