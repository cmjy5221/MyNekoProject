package com.myneko.client.catcare.vo;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class CatcareVO extends CommonVO {
	
	private int ci_number;
	private String ci_title;
	private String ci_content;
	private String ci_writer;
	private String ci_image;
	private String ci_date;
	private int a_number;
	private String a_id;

}
