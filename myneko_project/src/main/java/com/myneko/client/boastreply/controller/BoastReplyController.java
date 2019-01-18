package com.myneko.client.boastreply.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myneko.client.boastreply.service.BoastReplyService;
import com.myneko.client.boastreply.vo.BoastReplyVO;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value="/boast/replies")
public class BoastReplyController {

	@Autowired
	private BoastReplyService bService;

	@RequestMapping(value="/replyList/{b_number}", method=RequestMethod.GET)
	@ResponseBody
	public List<BoastReplyVO> replyList(@PathVariable int b_number) {
	
		BoastReplyVO brvo = new BoastReplyVO();
		brvo.setB_number(b_number);
		List<BoastReplyVO> replyList = bService.boastReplyList(brvo);
		System.out.println(replyList.toString());
		return replyList;
		
	}
	
	@RequestMapping(value="/replyInsert", method=RequestMethod.POST)
	@ResponseBody
	public int boastReplyInsert(@ModelAttribute BoastReplyVO brvo) {
		
		int result = 0;
		System.out.println(brvo.toString());
		result = bService.boastReplyInsert(brvo);
		
		if (result == 1) {
			result = brvo.getB_number();
		}
		
		return result;
		
	}
	
	@RequestMapping(value="/replyDelete", method=RequestMethod.GET)
	@ResponseBody
	public int boastReplyDelete(@RequestParam(name="br_number", required=false) int br_number) {
		
		int result = 0;
		
		result = bService.boastReplyDelete(br_number);
		
		return result;
		
	}
	
	@RequestMapping(value="/replyUpdate", method=RequestMethod.POST)
	@ResponseBody
	public int boastReplyUpdate(@ModelAttribute BoastReplyVO brvo) {
		
		int result = 0;
		
		result = bService.boastReplyUpdate(brvo);
		
		return result;
		
	}
	
}
