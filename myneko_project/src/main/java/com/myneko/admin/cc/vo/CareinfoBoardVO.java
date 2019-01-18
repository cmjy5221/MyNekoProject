package com.myneko.admin.cc.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class CareinfoBoardVO extends CommonVO {

	private int ci_number;
	private String ci_title;
	private String ci_content;
	private String ci_image;
	private MultipartFile ci_file;
	private Date ci_date;
	private int a_number;
	private String a_id;
}