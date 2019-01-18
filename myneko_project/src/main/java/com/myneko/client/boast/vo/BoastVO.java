package com.myneko.client.boast.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class BoastVO extends CommonVO{
	private int b_number;// 글번호
	private String b_title;// 글제목
	private String b_image="";// 이미지
	private String b_content;// 내용
	private Date b_date;// 등록일
	private int m_number;// 회원번호
	private String b_division;
	private MultipartFile file;//첨부파일
	private String m_id;
}
