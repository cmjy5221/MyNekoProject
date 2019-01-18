package com.myneko.admin.member.vo;

import java.util.Date;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class AMemberVO extends CommonVO {
	
	private int m_number;
	private String m_state;
	private String m_phone;
	private String m_password;
	private String m_id;
	private String m_name;
	private String m_postcode;
	private String m_address;
	private String m_detailaddress;
	private String m_email;
	private int m_mileage;
	private Date m_register;

}