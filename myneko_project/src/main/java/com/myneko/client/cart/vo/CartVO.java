package com.myneko.client.cart.vo;

import lombok.Data;

@Data
public class CartVO {
	
	private int ct_number;
	private int m_number;
	private int p_number;
	private String m_id;
	private int ct_amount;
	private String p_name;
	private int p_price;
	private int money;
	private int total_money;

}