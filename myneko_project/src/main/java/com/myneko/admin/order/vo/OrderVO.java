package com.myneko.admin.order.vo;

import java.util.Date;

import com.myneko.common.vo.CommonVO;

import lombok.Data;

@Data
public class OrderVO extends CommonVO {

	private int o_number;
	private String o_state;
	private String o_waybill;
	private Date o_date;
	private int o_milage;
	private int o_totalprice;
	private int o_count;
	private String o_zipcode;
	private String o_paywith;
	private String o_address;
	private String o_detailaddress;
	private String o_phone;
	private String o_name;
	private int m_number;

}
