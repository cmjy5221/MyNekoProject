package com.myneko.admin.qna.vo;

import java.util.Date;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class QnaVO extends CommonVO {

	private int i_number;
	private String i_content;
	private String i_title;
	private String i_image;
	private String i_repwhether;
	private Date i_date;
	private String m_id;
	
}
