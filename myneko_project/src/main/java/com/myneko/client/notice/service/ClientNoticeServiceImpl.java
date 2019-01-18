package com.myneko.client.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.notice.dao.ClientNoticeDAO;
import com.myneko.client.notice.vo.ClientNoticeVO;

@Service
@Transactional
public class ClientNoticeServiceImpl implements ClientNoticeService {

	@Autowired
	private ClientNoticeDAO cdao;
	
	@Override
	public List<ClientNoticeVO> noticeList(ClientNoticeVO cnvo) {
		// TODO Auto-generated method stub
		return cdao.noticeList(cnvo);
	}

	@Override
	public int noticeCount(ClientNoticeVO cnvo) {
		// TODO Auto-generated method stub
		return cdao.noticeCount(cnvo);
	}

	@Override
	public ClientNoticeVO cnoticeDetail(ClientNoticeVO cnvo) {
		// TODO Auto-generated method stub
		return cdao.cnoticeDetail(cnvo);
	}

}
