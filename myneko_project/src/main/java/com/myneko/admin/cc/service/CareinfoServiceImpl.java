package com.myneko.admin.cc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myneko.admin.cc.dao.CareinfoDAO;
import com.myneko.admin.cc.vo.CareinfoBoardVO;

@Service
public class CareinfoServiceImpl implements CareinfoService {
	@Autowired
	private CareinfoDAO cdao;

	@Override
	public List<CareinfoBoardVO> CareInfoBoardList(CareinfoBoardVO cvo) {
		List<CareinfoBoardVO> list = cdao.CareInfoBoardList(cvo);
		return list;
	}

	@Override
	public int CareinfoCount(CareinfoBoardVO cvo) {
		int result = cdao.CareinfoCount(cvo);
		return result;
	}

	@Override
	public int CareinfoInsert(CareinfoBoardVO cvo) {
		int result = cdao.CareinfoInsert(cvo);
		return result;
	}

	@Override
	public int CareinfoDelete(CareinfoBoardVO cvo) {
		return cdao.CareinfoDelete(cvo);
	}

	@Override
	public CareinfoBoardVO CareinfoDetail(CareinfoBoardVO cvo) {
		CareinfoBoardVO result = cdao.CareinfoDetail(cvo);
		return result;
	}

	@Override
	public int CareinfoModify(CareinfoBoardVO cvo) {
		int result=cdao.CareinfoModify(cvo);
		return result;
	}

}
