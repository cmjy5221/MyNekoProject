package com.myneko.client.boast.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.boast.vo.BoastVO;

@Repository
public class BoastDAOImpl implements BoastDAO {
	@Autowired
	private SqlSession session;
	//글목록
	@Override
	public List<BoastVO> boastList(BoastVO bvo) {
		
		return session.selectList("boastList", bvo);
	}

	//전체 레코드 
	@Override
	public int boastCnt(BoastVO fvo) {
		return (Integer)session.selectOne("boastCnt", fvo);
	}
	//글상세
	@Override
	public BoastVO boastDetail(BoastVO bvo) {
		
		return (BoastVO)session.selectOne("boastDetail",bvo);
	}
	//글입력
	@Override
	public int boastInsert(BoastVO bvo) {
		return session.insert("boastInsert",bvo);
	}

	@Override
	public int boastDelete(int b_number) {
		// TODO Auto-generated method stub
		return session.delete("boastDelete", b_number);
	}

	@Override
	public int boastUpdate(BoastVO bvo) {
		// TODO Auto-generated method stub
		return session.update("boastUpdate", bvo);
	}

}
