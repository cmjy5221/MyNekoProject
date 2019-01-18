package com.myneko.admin.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.admin.reply.dao.ReplyDAO;
import com.myneko.admin.reply.vo.ReplyVO;

@Service
@Transactional
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyDAO rDao;

	@Override
	public int insertReply(ReplyVO rvo) {
		// TODO Auto-generated method stub
		int result = rDao.insertReply(rvo);
		return result;
	}

	@Override
	public ReplyVO getReply(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return rDao.getReply(rvo);
	}
	
}
