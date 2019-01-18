package com.myneko.client.cat.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CatVO {
	private int c_number; //고양이 번호
	private String c_name;//고양이 이름
	private String c_gender;//고양이 성별
	private String c_birth; // 
	private String c_division;
	private String c_taste;
	private String c_disease;
	private String c_neutralization;
	private String c_represent;
	
	private String m_number;//회원번호
//파일 업로드를 위한 필드선언
	private MultipartFile file;
	private String c_profile;//프로필 사진
	
	
	
	
	
}