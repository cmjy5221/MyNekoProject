package com.myneko.client.cart.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.myneko.admin.product.service.ProductService;
import com.myneko.admin.product.vo.ProductVO;
import com.myneko.client.cart.service.CartService;
import com.myneko.client.cart.vo.CartVO;
import com.myneko.client.cart.vo.CatorderVO;
import com.myneko.client.cart.vo.PartiorderVO;

import lombok.extern.java.Log;

@RestController
@RequestMapping(value = "/cart")
@Log
public class CartController {

	@Autowired
	private CartService cartService;

	@Autowired
	private ProductService pService;

	@RequestMapping(value = "/cartList", method = RequestMethod.GET)
	public ModelAndView cartList(@ModelAttribute CartVO ctvo, Model model) {

		ModelAndView mav = new ModelAndView();
		List<CartVO> cartList = cartService.cartList(ctvo);
		List<ProductVO> productList = new ArrayList<ProductVO>();
		ProductVO pvo = new ProductVO();
		for (int i = 0; i < cartList.size(); i++) {
			pvo.setP_number(cartList.get(i).getP_number());
			pvo = pService.productDetail(pvo);
			productList.add(pvo);
		}
		model.addAttribute("productList", productList);
		model.addAttribute("cartList", cartList);
		model.addAttribute("data", ctvo);
		mav.setViewName("cart/cartList");

		return mav;
	}

	@RequestMapping(value = "/{ct_number}.do", method = RequestMethod.DELETE)
	public ResponseEntity<String> cartDelete(@PathVariable("ct_number") Integer ct_number) {
		ResponseEntity<String> entity = null;
		try {
			cartService.cartDelete(ct_number);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{ct_number}.do", method = RequestMethod.POST)
	public ResponseEntity<String> cartUpdate(@RequestParam("ct_number") Integer ct_number, @RequestParam("ct_amount") int ct_amount) {
		ResponseEntity<String> entity = null;
		CartVO ctvo = new CartVO();
		try {
			ctvo.setCt_number(ct_number);
			ctvo.setCt_amount(ct_amount);
			cartService.cartUpdate(ctvo);

			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "/insert.do", method = RequestMethod.POST)
	public String cartInsert(@RequestBody CartVO ctvo, HttpServletRequest request, Model model) throws Exception {
		String result = "";
		int r;

		System.out.println("ctvo m_number : " + ctvo.getM_number());
		System.out.println("ctvo p_number : " + ctvo.getP_number());
		System.out.println("ctvp ct_amount : " + ctvo.getCt_amount());

		r = cartService.checkcart(ctvo);

		if (r == 0) {
			r = cartService.cartInsert(ctvo);
			if (r == 1) {
				result = "SUCCESS";
			} else {
				result = "FAIL";
			}
		} else {
			result = "FAIL";
		}

		return result;
	}

	@RequestMapping(value = "/payment", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView payment(Model model, @RequestParam("m_number") int m_number) {

		CartVO ctvo = new CartVO();
		ModelAndView mav = new ModelAndView();

		ctvo.setM_number(m_number);

		List<CartVO> cartList = cartService.cartList(ctvo);
		model.addAttribute("cartList", cartList);

		mav.setViewName("cart/payment");

		return mav;
	}

	@RequestMapping(value = "/onePayment", method = RequestMethod.GET)
	public ModelAndView onePayment(@ModelAttribute CartVO ctvo, ModelAndView mav, HttpServletRequest request) {

		HttpSession session = request.getSession(true);

		System.out.println(ctvo.getP_name());

		session.setAttribute("rnp_pnumber", ctvo.getP_number());
		session.setAttribute("rnp_pname", ctvo.getP_name());
		session.setAttribute("rnp_pprice", ctvo.getP_price());
		session.setAttribute("rnp_pcount", ctvo.getCt_amount());

		mav.setViewName("client/cart/paymentOne");

		return mav;
	}

	// mddetail -> payment -> insert
	@ResponseBody
	@RequestMapping(value = "/orderinsertOne", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderinsertone(@RequestBody CatorderVO covo, HttpSession session, Model model) {
		log.info("--- cat order insert ONE ---");
		String result = "";
		int success = 0;

		PartiorderVO ptvo = new PartiorderVO();

		int o_number = cartService.onumber();
		System.out.println("--- order_number : " + o_number + " ---");

		if (o_number == 0) {
			result = "FAIL";
			return result;
		} else {
			String o_waybill = System.currentTimeMillis() + "";
			o_waybill = o_waybill.substring(5, o_waybill.length() -1);
			covo.setO_number(o_number);
			covo.setO_waybill(o_waybill);
			success = cartService.orderinsertOne(covo);
			if (success == 1) {
				ptvo.setO_number(o_number);
				ptvo.setP_number(Integer.parseInt(session.getAttribute("rnp_pnumber").toString()));
				ptvo.setPo_amount(Integer.parseInt(session.getAttribute("rnp_pcount").toString()));
				ptvo.setPo_price(Integer.parseInt(session.getAttribute("rnp_pprice").toString()));

				success = cartService.orderinsertOneP(ptvo);
				cartService.stockMinus(ptvo);
				if (success == 1) {
					result = "SUCCESS";
					session.removeAttribute("rnp_pnumber");
					session.removeAttribute("rnp_pcount");
					session.removeAttribute("rnp_pprice");
				} else {
					result = "FAIL";
				}
			}
		}

		if (covo.getU_milage() != 0) {
			int rs = cartService.usemilage(covo);
		}

		return result;
	}

	// cart -> payment -> insert
	@ResponseBody
	@RequestMapping(value = "/orderinsertAll", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderinsertall(@RequestBody CatorderVO covo, HttpSession session, Model model) {
		log.info("--- cat order insert CART ALL ---");
		String result = "";
		int success = 0;

		PartiorderVO ptvo = null;

		int o_number = cartService.onumber();
		System.out.println("--- order_number : " + o_number + " ---");

		String o_waybill = System.currentTimeMillis() + "";
		o_waybill = o_waybill.substring(5, o_waybill.length() -1);

		covo.setO_waybill(o_waybill);

		if (o_number == 0) {
			result = "FAIL";
			return result;
		} else {
			covo.setO_number(o_number);
			success = cartService.orderinsertAll(covo);
			if (success == 1) {
				CartVO ctvo = new CartVO();
				ctvo.setM_number((Integer) session.getAttribute("m_number"));
				List<CartVO> list = cartService.cartList(ctvo);

				for (int i = 0; i < list.size(); i++) {
					ptvo = new PartiorderVO();
					ptvo.setO_number(o_number);
					ptvo.setP_number(list.get(i).getP_number());
					ptvo.setPo_amount(list.get(i).getCt_amount());
					ptvo.setPo_price(list.get(i).getP_price());

					success = cartService.orderinsertAllP(ptvo);
					cartService.stockMinus(ptvo);
				}
			}
		}

		if (success == 1) {
			result = "SUCCESS";

			cartService.deleteAll((Integer) session.getAttribute("m_number"));
		} else {
			result = "FAIL";
		}

		if (covo.getU_milage() != 0) {
			int rs = cartService.usemilage(covo);
		}

		return result;
	}

}