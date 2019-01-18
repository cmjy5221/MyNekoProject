package com.myneko.client.notice.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class ClientNoticeVO extends CommonVO {

	private int n_number;
	private String n_title;
	private String n_content;
	private String n_image;
	private Date n_date;
	private String a_id;
	private MultipartFile file;

}