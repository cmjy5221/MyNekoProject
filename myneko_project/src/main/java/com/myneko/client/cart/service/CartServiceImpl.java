package com.myneko.client.cart.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.client.cart.dao.CartDao;
import com.myneko.client.cart.vo.CartVO;
import com.myneko.client.cart.vo.CatorderVO;
import com.myneko.client.cart.vo.PartiorderVO;

@Service
@Transactional
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDao cartDao;
	
	@Override
	public List<CartVO> cartList(CartVO ctvo) {
		List<CartVO> myList = null;
		myList = cartDao.cartList(ctvo);
		return myList;
	}

	@Override
	public int cartDelete(int ct_number) {
		int result = 0;
		try {
			result = cartDao.cartDelete(ct_number);
		} catch(Exception e) {
			e.printStackTrace();
			result = 0;
		}
		return result;
	}

	@Override
	public int cartUpdate(CartVO ctvo) {
		int result = 0;
		try {
			result = cartDao.cartUpdate(ctvo);
		} catch (Exception e) {
			e.printStackTrace();
			result = 0;
		}
		return result;
	}

	// insert
	@Override
	public int cartInsert(CartVO ctvo) {
		int result = 0;
		result = cartDao.cartInsert(ctvo);

		return result;
	}

	// order insert one
	@Override
	public int orderinsertOne(CatorderVO covo) {
		int result = 0;
		result = cartDao.orderinsertOne(covo);
		
		return result;
	}

	@Override
	public int onumber() {
		int onumber = 0;
		onumber = cartDao.onumber();
		return onumber;
	}

	@Override
	public int orderinsertOneP(PartiorderVO ptvo) {
		int result = 0;
		result = cartDao.orderinsertOneP(ptvo);
		
		return result;
	}

	@Override
	public int orderinsertAll(CatorderVO covo) {
		int result = 0;
		result = cartDao.orderinsertAll(covo);
		
		return result;
	}

	@Override
	public int usemilage(CatorderVO covo) {
		int result = 0;
		result = cartDao.usemilage(covo);
		
		return result;
	}

	@Override
	public int orderinsertAllP(PartiorderVO ptvo) {
		int result = 0;
		result = cartDao.orderinsertAllP(ptvo);
		
		return result;
	}

	@Override
	public int deleteAll(int m_number) {
		int result = 0;
		result = cartDao.deleteAll(m_number);
		
		return result;
	}

	@Override
	public int checkcart(CartVO ctvo) {
		int ctnumber = 0;
		ctnumber = cartDao.checkcart(ctvo);
		
		return ctnumber;
	}

	@Override
	public int stockMinus(PartiorderVO ptvo) {
		int result = 0;
		result = cartDao.stockMinus(ptvo);
		
		return result;
	}

}
