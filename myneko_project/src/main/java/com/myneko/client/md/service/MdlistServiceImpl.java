package com.myneko.client.md.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.cat.vo.CatVO;
import com.myneko.client.md.dao.MdlistDao;
import com.myneko.client.md.vo.MdVO;
import com.myneko.client.review.vo.ReviewVO;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class MdlistServiceImpl implements MdlistService {

	@Autowired
	private MdlistDao mdlistdao;
	
	// all md list call
	@Override
	public List<MdVO> allmdlist() {
		List<MdVO> list = null;
		list = mdlistdao.allmdlist();
		
		return list;
	}
	
	// call some md's detail
	@Override
	public MdVO mddetail(MdVO mdvo) {
		MdVO mdDetail = null;
		mdDetail = mdlistdao.mddetail(mdvo);
		return mdDetail;
	}

	// custom md list call
	@Override
	public MdVO customlist(String keyword) {
		MdVO customlist = null;
		customlist = mdlistdao.customlist(keyword);
		
		return customlist;
	}

	@Override
	public List<MdVO> mdlistcate(MdVO mdvo) {
		List<MdVO> cate01 = null;
		cate01 = mdlistdao.mdlistcate(mdvo);
		
		return cate01;
	}

	//call captain cat 's info
	@Override
	public CatVO capcatinfo(int m_number) {
		CatVO cvo = null;
		cvo = mdlistdao.capcatinfo(m_number);
		
		return cvo;
	}

	@Override
	public List<ReviewVO> getProductReview(int p_number) {
		// TODO Auto-generated method stub
		return mdlistdao.getProductReview(p_number);
	}

}
