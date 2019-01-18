package com.myneko.admin.product.service;

import java.util.List;

import com.myneko.admin.product.vo.ProductVO;

public interface ProductService {

	public int productReg(ProductVO pvo);

	public List<ProductVO> productList(ProductVO pvo);

	public ProductVO productDetail(ProductVO pvo);

	public int cntProduct(ProductVO pvo);
	
	public int productMod(ProductVO pvo);
	
	public List<ProductVO> getThree(ProductVO pvo);
	
	public int p_amountMod(ProductVO pvo);
}
