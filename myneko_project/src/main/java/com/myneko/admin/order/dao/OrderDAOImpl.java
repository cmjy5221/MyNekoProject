package com.myneko.admin.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.admin.order.vo.OrderVO;
import com.myneko.client.cart.vo.PartiorderVO;
import com.myneko.common.vo.SstatsVO;

@Repository
public class OrderDAOImpl implements OrderDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public List<OrderVO> getOrderList(OrderVO ovo) {
		// TODO Auto-generated method stub
		
		List<OrderVO> orderList = session.selectList("getOrderList", ovo);
		
		return orderList;
		
	}

	@Override
	public int orderStateModify(OrderVO ovo) {
		// TODO Auto-generated method stub
		
		int result = 0;
		
		result = session.update("orderStateModify", ovo);
		
		return result;
	}

	@Override
	public int orderListCnt(OrderVO ovo) {
		// TODO Auto-generated method stub
		return (Integer)session.selectOne("orderListCnt", ovo);
	}

	@Override
	public String maxYear(OrderVO ovo) {
		// TODO Auto-generated method stub
		return session.selectOne("maxYear", ovo);
	}

	@Override
	public String minYear(OrderVO ovo) {
		// TODO Auto-generated method stub
		return session.selectOne("minYear", ovo);
	}

	@Override
	public SstatsVO yearSales(OrderVO ovo) {
		// TODO Auto-generated method stub
		return (SstatsVO)session.selectOne("yearSales", ovo);
	}

	@Override
	public SstatsVO monthly(OrderVO ovo) {
		// TODO Auto-generated method stub
		return session.selectOne("monthly", ovo);
	}

	@Override
	public List<PartiorderVO> getPartiOrderList() {
		// TODO Auto-generated method stub
		return session.selectList("getPartiOrderList");
	}

	@Override
	public List<SstatsVO> monthlyStats(OrderVO ovo) {
		// TODO Auto-generated method stub
		return session.selectList("monthlyStats", ovo);
	}

	@Override
	public List<PartiorderVO> getPartiorderList2(int o_number) {
		// TODO Auto-generated method stub
		return session.selectList("getPartiorderList2", o_number);
	}

	@Override
	public OrderVO orderDetail(int o_number) {
		// TODO Auto-generated method stub
		return session.selectOne("orderDetail", o_number);
	}

}
