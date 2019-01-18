package com.myneko.client.catcare.dao;

import java.util.List;

import com.myneko.client.catcare.vo.CatcareVO;

public interface CatcareDao {
	public List<CatcareVO> catcareList(CatcareVO cvo);
	public int catcareListCnt(CatcareVO cvo);
	public CatcareVO catcareDetail(CatcareVO cvo);

}
