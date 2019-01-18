package com.myneko.client.cart.vo;

import lombok.Data;

@Data
public class CatorderVO {
	
	private int o_number;
	private String o_state;
	
	private String o_waybill;
	private String o_date;
	private String o_paywith;
	private int o_milage;
	private int o_totalprice;
	private int o_count;
	
	private String o_zipcode;
	private String o_address;
	private String o_phone;
	private String o_name;
	
	private int m_number;
	
	private int u_milage;
}
