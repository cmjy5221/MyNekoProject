package com.myneko.admin.product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myneko.admin.product.service.ProductService;
import com.myneko.admin.product.vo.ProductVO;
import com.myneko.common.file.FileUploadUtil;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;

import lombok.extern.java.Log;

@Controller
@Log
@RequestMapping(value = "/admin/product")
public class ProductContorller {
	@Autowired
	public ProductService ps;

	@RequestMapping(value = "/productList.do", method = RequestMethod.GET)
	public String ProductList(@ModelAttribute ProductVO pvo, Model model, HttpServletRequest request) {
		log.info("상품 리스트 이동");
		log.info(pvo.getP_division());
		// 페이지 세팅
		Paging.setPage(pvo);

		// 전체 레코드수 구현
		int total = ps.cntProduct(pvo);
		log.info("total = " + total);

		// 글번호 재설정
		int count = total - (Util.nvl(pvo.getPage()) - 1) * Util.nvl(pvo.getPageSize());
		log.info("count = " + count);
		List<ProductVO> productList = ps.productList(pvo);
		model.addAttribute("productList", productList);
		model.addAttribute("division", pvo.getP_division());
		model.addAttribute("searchword", pvo.getP_name());
		model.addAttribute("count", count);
		model.addAttribute("total", total);
		model.addAttribute("data", pvo);
		return "/admin/product/productList";
	}

	@RequestMapping(value = "/productRegForm.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String ProductRegForm() {
		log.info("상품 등록 폼 이동");
		return "/admin/product/productRegForm";
	}

	@RequestMapping(value = "/productDetail.do", method = RequestMethod.GET)
	public String ProductDetail(@ModelAttribute ProductVO pvo, Model model, HttpServletRequest request) {
		log.info("상품 상세페이지 이동");
		log.info("p_number" + pvo.getP_number());
		ProductVO product = new ProductVO();
		String origin = (String) request.getParameter("origin");
		log.info("origin은 " + origin);
		int cnt = ps.cntProduct(pvo);
		log.info(pvo.getP_number() + " 번호입니다.");
		log.info("cnt는 " + cnt);
		model.addAttribute("code", "0");
		model.addAttribute("origin", "");
		if (cnt == 0) {
			pvo.setP_number(Integer.parseInt(origin));
			model.addAttribute("msg", "상품 데이터가 없습니다. 이전 상품으로 돌아갑니다.");
			model.addAttribute("origin", origin);
		}
		product = ps.productDetail(pvo);
		List<ProductVO> productList = ps.productList(pvo);
		model.addAttribute("productList", productList);
		model.addAttribute("product", product);
		model.addAttribute("productListSize", productList.size());

		return "/admin/product/productDetail";
	}

	@RequestMapping(value = "/productReg", method = RequestMethod.POST)
	@ResponseBody
	public int ProductReg(@ModelAttribute ProductVO pvo, Model model, HttpServletRequest request)
			throws IllegalStateException, IOException {

		log.info("상품 정보 등록 시작");

		int result = 0;
		String url = "";
		log.info(pvo.getP_imageFile().toString());
		if (pvo.getP_imageFile() != null) {
			log.info("상품 이미지 존재함");
			String p_image = FileUploadUtil.fileUpload(pvo.getP_imageFile(), request, "product");
			pvo.setP_image(p_image);
			try {
				if (p_image != "default.jpg") {
					String p_thumbnail = FileUploadUtil.makeThumbnail(pvo.getP_image(), request);
					pvo.setP_thumbnail(p_thumbnail);
				} else {
					pvo.setP_thumbnail(p_image);
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		if (pvo.getP_detailimageFile() != null) {
			log.info("상품 상세 설명 이미지 존재함");
			String p_detailimage = FileUploadUtil.fileUpload(pvo.getP_detailimageFile(), request, "detail");
			pvo.setP_detailimage(p_detailimage);
		}
		String values[] = request.getParameterValues("disease");
		String disease = "";
		for (int i = 0; i < values.length; i++) {
			disease += (values[i]+",");
		}
		String p_searchkey = request.getParameter("foodChr")+"," + request.getParameter("furLength")+"," + disease
				+ request.getParameter("age");
		pvo.setP_searchkey(p_searchkey);
		System.out.println(pvo);
		result = ps.productReg(pvo);
		return result;
	}

	@RequestMapping(value = "/productModForm.do", method = RequestMethod.GET)
	public String productModForm(@ModelAttribute ProductVO pvo, Model model) {
		ProductVO product;
		product = ps.productDetail(pvo);

		model.addAttribute("product", product);
		return "/admin/product/productModForm";
	}

	@RequestMapping(value = "/productMod", method = RequestMethod.POST)
	@ResponseBody
	public int productMod(@ModelAttribute ProductVO pvo, Model model) {
		int result;
		result = ps.productMod(pvo);
		return result;
	}

}
