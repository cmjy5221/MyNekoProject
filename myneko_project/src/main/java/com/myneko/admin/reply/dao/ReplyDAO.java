package com.myneko.admin.reply.dao;


import com.myneko.admin.reply.vo.ReplyVO;

public interface ReplyDAO {

	public int insertReply(ReplyVO rvo);
	public ReplyVO getReply(ReplyVO rvo);
	
}
