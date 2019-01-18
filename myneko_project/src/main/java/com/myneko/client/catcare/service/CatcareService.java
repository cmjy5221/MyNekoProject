package com.myneko.client.catcare.service;

import java.util.List;

import com.myneko.client.catcare.vo.CatcareVO;

public interface CatcareService {
	public List<CatcareVO> catcareList(CatcareVO cvo);
	public int catcareListCnt(CatcareVO cvo);
	public CatcareVO catcareDetail(CatcareVO cvo);
}
