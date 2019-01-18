package com.myneko.client.boastreply.vo;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class BoastReplyVO extends CommonVO {

	private int br_number;
	private String br_content;
	private String br_date;
	private int b_number;
	private int m_number;
	private String m_id;
	
}
