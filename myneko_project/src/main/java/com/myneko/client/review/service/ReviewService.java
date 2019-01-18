package com.myneko.client.review.service;

import java.util.List;

import com.myneko.client.cart.vo.PartiorderVO;
import com.myneko.client.md.vo.MdVO;
import com.myneko.client.myorder.vo.myorderVO;
import com.myneko.client.review.vo.ReviewVO;

public interface ReviewService {

	public List<ReviewVO> reviewList(ReviewVO rvo);
	
	public int reviewInsert(ReviewVO rvo);
	
	public ReviewVO reviewDetail(ReviewVO rvo);
	
	public int reviewUpdate(ReviewVO rvo);
	
	public int reviewDelete(int r_number);
	
	public List<ReviewVO> productReview(MdVO mdvo);
	
	public int reviewCnt(ReviewVO rvo);
	
	public List<PartiorderVO> getPartiorderList(int o_number);
	
	public int changeState(myorderVO mvo);
	
	public int plusM(myorderVO mvo);
	
}
