package com.myneko.admin.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.admin.order.dao.OrderDAO;
import com.myneko.admin.order.vo.OrderVO;
import com.myneko.client.cart.vo.PartiorderVO;
import com.myneko.common.vo.SstatsVO;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDAO orderDao;

	@Override
	public List<OrderVO> getOrderList(OrderVO ovo) {
		// TODO Auto-generated method stub
		return orderDao.getOrderList(ovo);
	}

	@Override
	public int orderStateModify(OrderVO ovo) {
		// TODO Auto-generated method stub
		
		int result = 0;
		
		result = orderDao.orderStateModify(ovo);
		
		return result;
	}

	@Override
	public int orderListCnt(OrderVO ovo) {
		// TODO Auto-generated method stub
		return orderDao.orderListCnt(ovo);
	}

	@Override
	public String maxYear(OrderVO ovo) {
		// TODO Auto-generated method stub
		return orderDao.maxYear(ovo);
	}

	@Override
	public String minYear(OrderVO ovo) {
		// TODO Auto-generated method stub
		return orderDao.minYear(ovo);
	}

	@Override
	public SstatsVO yearSales(OrderVO ovo) {
		// TODO Auto-generated method stub
		return orderDao.yearSales(ovo);
	}

	@Override
	public SstatsVO monthly(OrderVO ovo) {
		// TODO Auto-generated method stub
		return orderDao.monthly(ovo);
	}

	@Override
	public List<PartiorderVO> getPartiOrderList() {
		// TODO Auto-generated method stub
		return orderDao.getPartiOrderList();
	}

	@Override
	public List<SstatsVO> monthlyStats(OrderVO ovo) {
		// TODO Auto-generated method stub
		return orderDao.monthlyStats(ovo);
	}

	@Override
	public List<PartiorderVO> getPartiorderList2(int o_number) {
		// TODO Auto-generated method stub
		return orderDao.getPartiorderList2(o_number);
	}

	@Override
	public OrderVO orderDetail(int o_number) {
		// TODO Auto-generated method stub
		return orderDao.orderDetail(o_number);
	}

}
