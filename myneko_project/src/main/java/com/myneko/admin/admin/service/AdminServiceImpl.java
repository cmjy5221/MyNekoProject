package com.myneko.admin.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myneko.admin.admin.dao.AdminDAO;
import com.myneko.admin.admin.vo.AdminVO;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO aDao;
	
	@Override
	public AdminVO adminLogin(AdminVO avo) {
		// TODO Auto-generated method stub
		return aDao.adminLogin(avo);
	}

}
