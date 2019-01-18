package com.myneko.client.cart.vo;

import lombok.Data;

@Data
public class PartiorderVO {
	private int po_number;
	private int o_number;
	private int p_number;
	private int po_amount;
	private int po_price;
	private String p_name;
}
