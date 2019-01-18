package com.myneko.admin.order.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.admin.order.service.OrderService;
import com.myneko.admin.order.vo.OrderVO;
import com.myneko.admin.product.service.ProductService;
import com.myneko.admin.product.vo.ProductVO;
import com.myneko.client.cart.vo.PartiorderVO;
import com.myneko.common.excel.ListExcelView;
import com.myneko.common.page.Paging;
import com.myneko.common.util.Util;
import com.myneko.common.vo.SstatsVO;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value="/admin/order")
public class OrderController {

	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ProductService ps;
	
	@RequestMapping(value="getOrderList.do", method=RequestMethod.GET)
	public ModelAndView orderList(@ModelAttribute("OrderVO") OrderVO ovo, Model model) {
		
		ModelAndView mav = new ModelAndView();
		
		Paging.setPage(ovo);
		
		List<OrderVO> orderList = orderService.getOrderList(ovo);
		List<PartiorderVO> partiorderList = orderService.getPartiOrderList();
		List<ProductVO> productList = new ArrayList<ProductVO>();
		ProductVO pvo = new ProductVO();
		
		for (int i = 0; i < partiorderList.size(); i++) {
			
			pvo.setP_number(partiorderList.get(i).getP_number());
			pvo = ps.productDetail(pvo);
			
			productList.add(pvo);
			
		}
		
		int total = orderService.orderListCnt(ovo);
		log.info("total = " + total);
		int count = total - (Util.nvl(ovo.getPage()) - 1) * Util.nvl(ovo.getPageSize());
		log.info("count = " + count);
		
		mav.addObject("total", total);
		mav.addObject("count", count);
		mav.addObject("data", ovo);
		mav.addObject("orderList", orderList);
		mav.addObject("partiorderList", partiorderList);
		mav.addObject("productList", productList);
		
		mav.setViewName("admin/order/adminOrder");
		
		return mav;
		
	}
	
	@RequestMapping(value="orderStateMod.do", method=RequestMethod.POST)
	@ResponseBody
	public int orderStateMod(@ModelAttribute("OrderVO") OrderVO ovo) {
		int result = 0;
		result = orderService.orderStateModify(ovo);
		return result;
		
	}
	
	@RequestMapping(value="/salesStats.do", method=RequestMethod.GET)
	public String salesStats(@ModelAttribute OrderVO ovo, Model model) {
		String url = "admin/stats/salesStats";
		
		String year = LocalDate.now().toString().substring(0, 4);
		
		System.out.println(year.toString());
		
		ovo.setO_state("구매확정");
		ovo.setYear(year);
		
		String maxYear = orderService.maxYear(ovo);
		String minYear = orderService.minYear(ovo);
		SstatsVO yearSales = orderService.yearSales(ovo);
		SstatsVO monthly = orderService.monthly(ovo);
		List<SstatsVO> monthlyStats = orderService.monthlyStats(ovo);
		
		int yearSales1 = 0;
		
		if (yearSales == null) {
		} else {
			yearSales1 = yearSales.getSales();
		}
		
		if (yearSales1 + "" == null && yearSales1 + "" == "") {
		} else {
			model.addAttribute("monthlyStats", monthlyStats);
			model.addAttribute("year", ovo.getYear());
			model.addAttribute("maxYear", maxYear);
			model.addAttribute("minYear", minYear);
			model.addAttribute("yearSales", yearSales1);
			model.addAttribute("monthl", monthly);
			model.addAttribute("jan", monthly.getJan());
			model.addAttribute("feb", monthly.getFeb());
			model.addAttribute("mar", monthly.getMar());
			model.addAttribute("apr", monthly.getApr());
			model.addAttribute("may", monthly.getMay());
			model.addAttribute("jun", monthly.getJun());
			model.addAttribute("jul", monthly.getJul());
			model.addAttribute("aug", monthly.getAug());
			model.addAttribute("sep", monthly.getSep());
			model.addAttribute("oct", monthly.getOct());
			model.addAttribute("nov", monthly.getNov());
			model.addAttribute("dec", monthly.getDec());
		}
		
		return url;
	}
	
	@RequestMapping(value="/salesExcel", method=RequestMethod.GET)
	public ModelAndView memberExcel(@ModelAttribute OrderVO ovo) {
		log.info(ovo.toString());
		List<SstatsVO> statsList = orderService.monthlyStats(ovo);
		log.info(statsList.toString());
		ModelAndView mav = new ModelAndView(new ListExcelView());
		mav.addObject("statList", statsList);
		mav.addObject("template", "sStats.xlsx");
		mav.addObject("file_name", "sStats");
		return mav;
	}
	
	@RequestMapping(value="/orderDetail", method=RequestMethod.GET)
	public String orderDetail(@RequestParam("o_number") int o_number, Model model) {
		
		String url = "admin/order/orderDetail";
		
		List<PartiorderVO> orderDetail = new ArrayList<PartiorderVO>();
		orderDetail = orderService.getPartiorderList2(o_number);
		
		OrderVO oDetail = orderService.orderDetail(o_number);
		
		model.addAttribute("oDetail", oDetail);
		model.addAttribute("orderDetail", orderDetail);
		
		return url;
		
	}
	
}
