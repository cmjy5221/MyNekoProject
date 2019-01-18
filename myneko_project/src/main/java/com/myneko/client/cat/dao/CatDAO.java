	package com.myneko.client.cat.dao;

import java.util.List;

import com.myneko.client.cart.vo.CartVO;
import com.myneko.client.cat.vo.CatVO;
import com.myneko.client.member.vo.MemberVO;

public interface CatDAO {

	public List<CatVO> catList(CatVO cvo);

	public int catInsert(CatVO cvo);
	
	public int deleteCat(int c_number);
	
	public CatVO detailCat(int c_number);

	public int represent(CatVO cvo);
	
	public int afterRepresent(CatVO cvo);
	
	public int catAllDelete(MemberVO mvo);
	
	public int cartUpdate(CartVO cvo);
}
