package com.myneko.client.carereply.service;

import java.util.List;

import com.myneko.client.carereply.vo.CareReplyVO;

public interface CareReplyService {
	public List<CareReplyVO> replyList(int ci_number);
	public int replyInsert(CareReplyVO rvo);
	public int replyDelete(int rep_number);
	public int replyUpdate(CareReplyVO rvo);

}
