package com.myneko.client.review.vo;

import org.springframework.web.multipart.MultipartFile;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class ReviewVO extends CommonVO {

	private int r_number; // 글번호
	private String r_title; // 제목
	private String r_content; // 내용
	private String r_date; // 작성일
	private int r_starrate; // 평점
	private int m_number; // 회원번호
	private int p_number; // 상품번호
	private String m_id;
	private String p_name;

	//파일 업로드 위한 속성
	private MultipartFile file; //첨부파일
	private String r_image; //실제서버에 저장한 파일명
	
}