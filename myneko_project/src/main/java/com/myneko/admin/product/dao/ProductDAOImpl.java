package com.myneko.admin.product.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.admin.product.vo.ProductVO;

import lombok.extern.java.Log;

@Repository
@Log
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	private SqlSession session;

	@Override
	public int insertProduct(ProductVO pvo) {
		return session.insert("insertProduct", pvo);

	}

	@Override
	public List<ProductVO> productList(ProductVO pvo) {
		return session.selectList("productList", pvo);
	}

	@Override
	public ProductVO productDetail(ProductVO pvo) {
		return session.selectOne("productDetail", pvo);
	}

	@Override
	public int cntProduct(ProductVO pvo) {
		return session.selectOne("cntProduct", pvo);
	}

	@Override
	public int productMod(ProductVO pvo) {
		return session.update("productMod", pvo);
	}

	@Override
	public List<ProductVO> getThree(ProductVO pvo) {
		// TODO Auto-generated method stub
		return session.selectList("getThree", pvo);
	}

	@Override
	public int p_amountMod(ProductVO pvo) {
		// TODO Auto-generated method stub
		return session.update("p_amountMod", pvo);
	}

}
