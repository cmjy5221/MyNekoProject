package com.myneko.client.cat.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.cart.vo.CartVO;
import com.myneko.client.cat.vo.CatVO;
import com.myneko.client.member.vo.MemberVO;

@Repository
@Transactional
public class CatDAOImpl implements CatDAO {

	@Autowired
	private SqlSession session;

	@Override
	public List<CatVO> catList(CatVO cvo) {
		List<CatVO> list = session.selectList("catList", cvo);

		return list;
	}

	@Override
	public int catInsert(CatVO cvo) {
		
		return session.insert("catInsert", cvo);
	}

	@Override
	public int cartUpdate(CartVO ctvo) {
		return session.update("cartUpdate", ctvo);
	}

	@Override
	public int deleteCat(int c_number) {
		System.out.println(c_number);
		return session.delete("deleteCat", c_number);
	}

	@Override
	public CatVO detailCat(int c_number) {
		return session.selectOne("detailCat", c_number);
	}

	@Override
	public int represent(CatVO cvo) {

		return session.update("represent", cvo);
	}

	@Override
	public int afterRepresent(CatVO cvo) {
		return session.update("afterRepresent", cvo);
	}

	@Override
	public int catAllDelete(MemberVO mvo) {
		return session.delete("catAllDelete", mvo);
	}

}
