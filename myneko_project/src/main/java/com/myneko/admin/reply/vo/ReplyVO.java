package com.myneko.admin.reply.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private int rep_number;
	private String rep_content;
	private Date rep_regdate;
	private int i_number;
	private String a_id;
	
}
