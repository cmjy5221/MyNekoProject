package com.myneko.client.inquiry.vo;

import org.springframework.web.multipart.MultipartFile;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class ClientInquiryVO extends CommonVO {

	private int i_number;
	private String i_title;
	private String i_content;
	private String i_image;
	private String i_repwhether;
	private String i_date;
	private String m_id;
	private MultipartFile file;
	
}
