package com.myneko.client.cat.service;

import java.util.List;

import com.myneko.client.cat.vo.CatVO;

public interface CatService {

	public List<CatVO> catList(CatVO cvo);

	public int catInsert(CatVO cvo);

	public int deleteCat(int c_number);

	public CatVO detailCat(int c_number);

	public int represent(CatVO cvo);

	public int representOne(CatVO cvo);
}
