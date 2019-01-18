package com.myneko.client.carereply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.carereply.dao.CareReplyDao;
import com.myneko.client.carereply.vo.CareReplyVO;

@Service
@Transactional
public class CareReplyServiceImpl implements CareReplyService {

	@Autowired
	private CareReplyDao careReplyDao;
	
	// 댓글 목록
	@Override
	public List<CareReplyVO> replyList(int ci_number) {
		return careReplyDao.replyList(ci_number);
	}

	// 댓글 입력
	@Override
	public int replyInsert(CareReplyVO rvo) {
		int result = 0;
		try {
			result = careReplyDao.replyInsert(rvo);
		}catch(Exception e) {
			e.printStackTrace();
			result = 0;
		}
		return result;
	}

	// 글 삭제
	@Override
	public int replyDelete(int rep_number) {
		int result = 0;
		try {
			result = careReplyDao.replyDelete(rep_number);
		}catch(Exception e) {
			e.printStackTrace();
			result = 0;
		}
		return result;
	}

	// 글 수정
	@Override
	public int replyUpdate(CareReplyVO rvo) {
		int result = 0;
		try {
			result = careReplyDao.replyUpdate(rvo);
		}catch(Exception e) {
			e.printStackTrace();
			result = 0;
		}
		return result;
	}

}

