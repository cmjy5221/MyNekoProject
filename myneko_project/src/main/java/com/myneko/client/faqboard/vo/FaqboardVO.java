package com.myneko.client.faqboard.vo;

import java.util.Date;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class FaqboardVO extends CommonVO {
	
	private int f_number;// 글번호
	private String f_title;// 글제목
	private String f_content;// 내용
	private String f_image;// 이미지
	private Date f_date;// 등록일
	private String a_id;// 관리자 아이디

}