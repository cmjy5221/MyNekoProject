package com.myneko.client.boastreply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.boastreply.dao.BoastReplyDAO;
import com.myneko.client.boastreply.vo.BoastReplyVO;

@Service
@Transactional
public class BoastReplyServiceImpl implements BoastReplyService {

	@Autowired
	private BoastReplyDAO bDao;

	@Override
	public List<BoastReplyVO> boastReplyList(BoastReplyVO brvo) {
		// TODO Auto-generated method stub
		return bDao.boastReplyList(brvo);
	}

	@Override
	public int boastReplyInsert(BoastReplyVO brvo) {
		// TODO Auto-generated method stub
		return bDao.boastReplyInsert(brvo);
	}

	@Override
	public int boastReplyUpdate(BoastReplyVO brvo) {
		// TODO Auto-generated method stub
		return bDao.boastReplyUpdate(brvo);
	}

	@Override
	public int boastReplyDelete(int br_number) {
		// TODO Auto-generated method stub
		return bDao.boastReplyDelete(br_number);
	}

	@Override
	public int boastReplyDeleteAll(int b_number) {
		// TODO Auto-generated method stub
		return bDao.boastReplyDeleteAll(b_number);
	}
	
}
