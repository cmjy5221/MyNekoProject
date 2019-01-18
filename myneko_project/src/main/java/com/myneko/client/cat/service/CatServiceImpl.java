package com.myneko.client.cat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myneko.client.cat.dao.CatDAO;
import com.myneko.client.cat.vo.CatVO;

@Service
public class CatServiceImpl implements CatService {

	@Autowired
	private CatDAO dao;

	@Override
	public List<CatVO> catList(CatVO cvo) {
		return dao.catList(cvo);
	}

	@Override
	public int catInsert(CatVO cvo) {
		return dao.catInsert(cvo);
	}

	@Override
	public int deleteCat(int c_number) {
		return dao.deleteCat(c_number);
	}

	@Override
	public CatVO detailCat(int c_number) {

		return dao.detailCat(c_number);
	}

	@Override
	public int represent(CatVO cvo) {
		int result = 0;

		result = dao.afterRepresent(cvo);
		System.out.println(result);
		if (result == 2) {
			return dao.represent(cvo);
		} else {
			return 0;
		}

	}

	@Override
	public int representOne(CatVO cvo) {
		
		return dao.represent(cvo);
	}

}
