package com.myneko.client.catcare.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.catcare.dao.CatcareDao;
import com.myneko.client.catcare.vo.CatcareVO;

@Service
@Transactional
public class CatcareServiceImpl implements CatcareService{

	@Autowired
	private CatcareDao catcareDao;
	
	// 글 목록 구현
	@Override
	public List<CatcareVO> catcareList(CatcareVO cvo) {
		List<CatcareVO> catcareList = null;
	
		catcareList = catcareDao.catcareList(cvo);
		return catcareList;
		
	}
	
	// 전체 레코드 수 구현
	@Override
	public int catcareListCnt(CatcareVO cvo) {
		return catcareDao.catcareListCnt(cvo);
	}

	// 글 상세 구현
	@Override
	public CatcareVO catcareDetail(CatcareVO cvo) {
		CatcareVO detail = null;
		detail = catcareDao.catcareDetail(cvo);
		return detail;
	}

	

}
