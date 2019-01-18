package com.myneko.admin.cc.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.admin.cc.vo.CareinfoBoardVO;

@Repository
public class CareinfoDAOimpl implements CareinfoDAO {
	@Autowired
	private SqlSession sqlsession;

	@Override
	public List<CareinfoBoardVO> CareInfoBoardList(CareinfoBoardVO cvo) {
		return sqlsession.selectList("careinfoList", cvo);
	}

	@Override
	public int CareinfoCount(CareinfoBoardVO cvo) {
		return sqlsession.selectOne("careinfoCount", cvo);
	}

	@Override
	public int CareinfoInsert(CareinfoBoardVO cvo) {
		return sqlsession.insert("careinfoInsert", cvo);
	}

	@Override
	public int CareinfoDelete(CareinfoBoardVO cvo) {
		return sqlsession.delete("careinfoDelete", cvo);
	}

	@Override
	public CareinfoBoardVO CareinfoDetail(CareinfoBoardVO cvo) {
		return sqlsession.selectOne("careinfoDetail", cvo);
	}

	@Override
	public int CareinfoModify(CareinfoBoardVO cvo) {
		return sqlsession.update("careinfoUpdate", cvo);
	}

}
