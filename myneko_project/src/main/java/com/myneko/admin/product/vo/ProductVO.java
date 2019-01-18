package com.myneko.admin.product.vo;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.MultipartFilter;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class ProductVO extends CommonVO {
	private int p_number = 0;// 상품번호
	private String p_division = "";// 상품 카테고리
	private String p_name = "";// 상품 이름
	private String p_brand = "";// 제조사,브랜드명
	private String p_material = "";// 주재료
	private String p_usableage = "";// 주사용 연령
	private String p_function = "";// 기능
	private String p_size = "";// 크기
	private String p_usablehair = "";// 추천 털길이
	private String p_recchar = "";// 추천 성격
	private int p_price = 0;// 가격
	private int p_amount = 0;// 재고량
	private String p_type = "";// 상품 타입
	private String p_volume = "";// 상품 용량
	private String p_color = "";// 상품 색깔
	private String p_recgender = "";// 추천 성별
	private String p_rectaste = "";// 추천 식성
	private String p_searchkey = "";// 검색용 키워드 칼럼
	
	private String p_image;// 상품 이미지
	private MultipartFile p_imageFile;// 상품 이미지 파일

	private String p_thumbnail;// 상품 썸네일 이미지

	private String p_detailimage;// 상품 상세 내용 이미지
	private MultipartFile p_detailimageFile;// 상품 상세이미지 파일

	private int rnum;
	
}
