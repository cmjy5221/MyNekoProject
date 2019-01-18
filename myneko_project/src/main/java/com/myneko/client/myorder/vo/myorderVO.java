package com.myneko.client.myorder.vo;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data	
public class myorderVO extends CommonVO {

	private int o_number; // 주문번호
	private String o_state; // 주문상태
	private int o_amount; // 주문수량
	private String o_waybill; // 운송장 번호
	private String o_date; // 주문일자
	private String o_paywith; // 결제수단
	private int o_milage; // 사용한 마일리지
	private int o_totalprice; // 주문총액
	private String o_address; // 배송지 주소
	private String o_phone; // 수취인 연락저
	private String o_name; // 수취인성명
	private String o_zipcode; // 배송지우편번호
	private int m_number; // 회원번호
	private int u_milage;

}
