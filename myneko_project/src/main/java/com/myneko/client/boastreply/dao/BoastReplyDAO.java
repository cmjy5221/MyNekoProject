package com.myneko.client.boastreply.dao;

import java.util.List;

import com.myneko.client.boastreply.vo.BoastReplyVO;

public interface BoastReplyDAO {

	public List<BoastReplyVO> boastReplyList(BoastReplyVO brvo);
	public int boastReplyInsert(BoastReplyVO brvo);
	public int boastReplyUpdate(BoastReplyVO brvo);
	public int boastReplyDelete(int br_number);
	public int boastReplyDeleteAll(int b_number);
	
}
