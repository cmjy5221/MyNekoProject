package com.myneko.client.boast.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.boast.dao.BoastDAO;
import com.myneko.client.boast.vo.BoastVO;

@Service
@Transactional
public class BoastServiceImpl implements BoastService {
	@Autowired
	private BoastDAO boastDAO;
	
	//글목록
	@Override
	public List<BoastVO> boastList(BoastVO bvo) {
		List<BoastVO> myList = new ArrayList<BoastVO>();
		myList = boastDAO.boastList(bvo);
		return myList;
	}

	//전체레코드 수 구현
	@Override
	public int boastCnt(BoastVO fvo) {
		
		return boastDAO.boastCnt(fvo);
	}

	//글입력
	@Override
	public int boastInsert(BoastVO bvo) {
		return boastDAO.boastInsert(bvo);
	}
	//글상세
	@Override
	public BoastVO boastDetail(BoastVO bvo) {
		BoastVO detail = null;
		detail = boastDAO.boastDetail(bvo);
		return detail;
	}

	@Override
	public int boastDelete(int b_number) {
		// TODO Auto-generated method stub
		return boastDAO.boastDelete(b_number);
	}

	@Override
	public int boastUpdate(BoastVO bvo) {
		// TODO Auto-generated method stub
		return boastDAO.boastUpdate(bvo);
	}

}
