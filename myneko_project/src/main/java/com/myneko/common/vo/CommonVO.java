package com.myneko.common.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CommonVO {
	private String page;// 페이지번호
	private String pageSize;// 페이지에서 보여주는 게시글 수
	private String start_row;// 시작 레코드 번호
	private String end_row;// 종료 레코드 번호

	private String firstDate;
	private String lastDate;

	private String order_by ;
	private String order_sc ;
	
	private String search;
	private String keyword;
	
	private String year;
}
