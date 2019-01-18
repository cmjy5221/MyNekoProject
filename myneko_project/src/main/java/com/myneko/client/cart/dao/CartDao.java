package com.myneko.client.cart.dao;

import java.util.List;

import com.myneko.client.cart.vo.CartVO;
import com.myneko.client.cart.vo.CatorderVO;
import com.myneko.client.cart.vo.PartiorderVO;

public interface CartDao {
	public List<CartVO> cartList(CartVO ctvo);
	public int cartDelete(int ct_number);
	public int cartUpdate(CartVO ctvo);
	public int cartInsert(CartVO ctvo);
	
	public int checkcart(CartVO ctvo);
	
	public int onumber();
	public int orderinsertOne(CatorderVO covo);
	public int orderinsertOneP(PartiorderVO ptvo);
	public int orderinsertAll(CatorderVO covo);
	public int orderinsertAllP(PartiorderVO ptvo);
	public int usemilage(CatorderVO covo);
	
	public int deleteAll(int m_number);
	public int stockMinus(PartiorderVO ptvo);
}
