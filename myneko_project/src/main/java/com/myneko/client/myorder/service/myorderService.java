package com.myneko.client.myorder.service;

import java.util.List;

import com.myneko.client.cart.vo.PartiorderVO;
import com.myneko.client.member.vo.MemberVO;
import com.myneko.client.myorder.vo.myorderVO;

public interface myorderService {

	public List<myorderVO> myorderList(myorderVO mvo);

	 public myorderVO myorderDetail(myorderVO mvo); 

	public List<PartiorderVO> findProduct(int o_number);

	public MemberVO findMember(int o_number);

	public myorderVO findOrder(int o_number);

	public int myorderDelete(int o_number);
	
	public int myorderListCnt(myorderVO mvo);
	
	public int orderCancel(myorderVO mvo);
	
	public int myorderChange(myorderVO mvo);
	
	public int myorderAddressModify(myorderVO mvo);

	public int plusMilage(myorderVO mvo);
	
	public List<PartiorderVO> getpartiorderlist(int o_number);
	
	public int amountChange(PartiorderVO povo);
	
}
