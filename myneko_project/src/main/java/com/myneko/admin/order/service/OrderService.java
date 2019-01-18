package com.myneko.admin.order.service;

import java.util.List;

import com.myneko.admin.order.vo.OrderVO;
import com.myneko.client.cart.vo.PartiorderVO;
import com.myneko.common.vo.SstatsVO;

public interface OrderService {

	public List<OrderVO> getOrderList(OrderVO ovo);
	public int orderStateModify(OrderVO ovo);
	public int orderListCnt(OrderVO ovo);
	public String maxYear(OrderVO ovo);
	public String minYear(OrderVO ovo);
	public SstatsVO yearSales(OrderVO ovo);
	public SstatsVO monthly(OrderVO ovo);
	public List<PartiorderVO> getPartiOrderList();
	public List<SstatsVO> monthlyStats(OrderVO ovo);
	public List<PartiorderVO> getPartiorderList2(int o_number);
	public OrderVO orderDetail(int o_number);
	
}
