package com.myneko.admin.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myneko.admin.product.dao.ProductDAO;
import com.myneko.admin.product.vo.ProductVO;

import lombok.extern.java.Log;

@Service
@Log
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDAO pdao;

	@Override
	public int productReg(ProductVO pvo) {
		int result = 0;

		result = pdao.insertProduct(pvo);
		return result;
	}

	@Override
	public List<ProductVO> productList(ProductVO pvo) {
		List<ProductVO> result;

		result = pdao.productList(pvo);

		return result;
	}

	@Override
	public ProductVO productDetail(ProductVO pvo) {
		// TODO Auto-generated method stub
		ProductVO result;

		result = pdao.productDetail(pvo);
		return result;
	}

	@Override
	public int cntProduct(ProductVO pvo) {
		int result;
		result = pdao.cntProduct(pvo);

		return result;
	}

	@Override
	public int productMod(ProductVO pvo) {
		int result;
		result = pdao.productMod(pvo);
		return result;
	}

	@Override
	public List<ProductVO> getThree(ProductVO pvo) {
		// TODO Auto-generated method stub
		return pdao.getThree(pvo);
	}

	@Override
	public int p_amountMod(ProductVO pvo) {
		// TODO Auto-generated method stub
		log.info("update product set p_amount = p_amount + " + pvo.getP_amount() + " where p_number = " + pvo.getP_number());
		return pdao.p_amountMod(pvo);
	}

}
