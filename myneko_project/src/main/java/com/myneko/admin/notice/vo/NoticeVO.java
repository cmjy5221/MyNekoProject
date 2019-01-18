package com.myneko.admin.notice.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class NoticeVO extends CommonVO {

	private int n_number;
	private String n_title;
	private String n_content;
	private MultipartFile file;
	private String n_image;
	private Date n_date;
	private String a_id;
	
}
