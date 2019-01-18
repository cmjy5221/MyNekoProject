package com.myneko.admin.cc.service;

import java.util.List;

import com.myneko.admin.cc.vo.CareinfoBoardVO;

public interface CareinfoService {
	public List<CareinfoBoardVO> CareInfoBoardList(CareinfoBoardVO cvo);

	public int CareinfoCount(CareinfoBoardVO cvo);

	public int CareinfoInsert(CareinfoBoardVO cvo);

	public int CareinfoDelete(CareinfoBoardVO cvo);

	public CareinfoBoardVO CareinfoDetail(CareinfoBoardVO cvo);

	public int CareinfoModify(CareinfoBoardVO cvo);
}
