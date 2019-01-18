package com.myneko.client.boast.service;

import java.util.List;

import com.myneko.client.boast.vo.BoastVO;

public interface BoastService {
	//글목록
	public List<BoastVO> boastList(BoastVO bvo);
	//페이징
	public int boastCnt(BoastVO bvo);
	//글쓰기
	public int boastInsert(BoastVO bvo);
	//글상세
	public BoastVO boastDetail(BoastVO pvo);
	
	public int boastDelete(int b_number);
	
	public int boastUpdate(BoastVO bvo);
	
}
