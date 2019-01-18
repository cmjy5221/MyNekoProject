package com.myneko.admin.admin.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myneko.admin.admin.vo.AdminVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public AdminVO adminLogin(AdminVO avo) {
		// TODO Auto-generated method stub
		return (AdminVO) session.selectOne("adminLogin", avo);
	}

}
