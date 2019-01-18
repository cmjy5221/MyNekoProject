package com.myneko.client.boast.dao;

import java.util.List;

import com.myneko.client.boast.vo.BoastVO;

public interface BoastDAO {
	//글목록
	public List<BoastVO> boastList(BoastVO bvo);
	//전체레코드 구 구현
	public int boastCnt(BoastVO fvo);
	//글상세
	public BoastVO boastDetail(BoastVO bvo);
	//글입력 구현
	public int boastInsert(BoastVO bvo);
	
	public int boastDelete(int b_number);
	
	public int boastUpdate(BoastVO bvo);

}
