package com.myneko.admin.faq.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class FaqVO extends CommonVO {

	private int f_number;
	private String f_title;
	private String f_content;
	private String f_image;
	private MultipartFile file;
	private Date f_date;
	private String a_id;

}