package com.myneko.admin.cc.dao;

import java.util.List;

import com.myneko.admin.cc.vo.CareinfoBoardVO;

public interface CareinfoDAO {
	public List<CareinfoBoardVO> CareInfoBoardList(CareinfoBoardVO cvo);

	public int CareinfoCount(CareinfoBoardVO cvo);
	
	public int CareinfoInsert(CareinfoBoardVO cvo);
	
	public int CareinfoDelete(CareinfoBoardVO cvo);
	
	public CareinfoBoardVO CareinfoDetail(CareinfoBoardVO cvo);
	
	public int CareinfoModify(CareinfoBoardVO cvo);
}
