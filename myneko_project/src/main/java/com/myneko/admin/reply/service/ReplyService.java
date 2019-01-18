package com.myneko.admin.reply.service;


import com.myneko.admin.reply.vo.ReplyVO;

public interface ReplyService {

	public int insertReply(ReplyVO rvo);
	public ReplyVO getReply(ReplyVO rvo);
	
}
