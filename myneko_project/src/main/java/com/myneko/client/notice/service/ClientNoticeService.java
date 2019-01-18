package com.myneko.client.notice.service;

import java.util.List;

import com.myneko.client.notice.vo.ClientNoticeVO;

public interface ClientNoticeService {

	public List<ClientNoticeVO> noticeList(ClientNoticeVO cnvo);
	public int noticeCount(ClientNoticeVO cnvo);
	public ClientNoticeVO cnoticeDetail(ClientNoticeVO cnvo);
	
}
