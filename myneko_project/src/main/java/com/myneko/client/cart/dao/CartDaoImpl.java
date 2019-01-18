package com.myneko.client.cart.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.client.cart.vo.CartVO;
import com.myneko.client.cart.vo.CatorderVO;
import com.myneko.client.cart.vo.PartiorderVO;

@Repository
public class CartDaoImpl implements CartDao {

	@Autowired
	private SqlSession session;

	@Override
	public List<CartVO> cartList(CartVO ctvo) {
		return session.selectList("cartList", ctvo);
	}

	@Override
	public int cartDelete(int ct_number) {
		return session.delete("cartDelete", ct_number);
	}

	@Override
	public int cartUpdate(CartVO ctvo) {
		return session.update("cartUpdate", ctvo);
	}
	
	@Override
	public int cartInsert(CartVO ctvo) {
		return session.insert("cartInsert", ctvo);
	}

	@Override
	public int orderinsertOne(CatorderVO covo) {
		return session.insert("orderinsertOne", covo);
	}

	@Override
	public int onumber() {
		return session.selectOne("onumber");
	}

	@Override
	public int orderinsertOneP(PartiorderVO ptvo) {
		return session.insert("orderinsertOneP", ptvo);
	}

	@Override
	public int orderinsertAll(CatorderVO covo) {
		return session.insert("orderinsertAll", covo);
	}

	@Override
	public int usemilage(CatorderVO covo) {
		return session.update("usemilage", covo);
	}

	@Override
	public int orderinsertAllP(PartiorderVO ptvo) {
		return session.insert("orderinsertAllP", ptvo);
	}

	@Override
	public int deleteAll(int m_number) {
		return session.delete("deleteAll", m_number);
	}

	@Override
	public int checkcart(CartVO ctvo) {
		return session.selectOne("checkcart", ctvo);
	}

	@Override
	public int stockMinus(PartiorderVO ptvo) {
		return session.update("stockMinus", ptvo);
	}

}
