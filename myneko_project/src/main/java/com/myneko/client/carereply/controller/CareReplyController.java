package com.myneko.client.carereply.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.myneko.client.carereply.service.CareReplyService;
import com.myneko.client.carereply.vo.CareReplyVO;

import lombok.extern.java.Log;

@RestController
@RequestMapping(value="/replies")
@Log
public class CareReplyController {
	
	@Autowired
	private CareReplyService careReplyService;
	
	// 댓글 목록 구현
	@RequestMapping(value = "/all/{ci_number}.do", method = RequestMethod.GET)
	@ResponseBody
	public List<CareReplyVO> list(@PathVariable("ci_number") int ci_number){
		List<CareReplyVO> replies = null;
		replies = careReplyService.replyList(ci_number);
		System.out.println(replies.toString());
		return replies;
	}
	
	// 댓글 쓰기 구현
	@RequestMapping(value="/replyInsert", method=RequestMethod.POST)
	public ResponseEntity<String> replyInsert(@RequestParam(name="rep_content", required=false) String rep_content, @RequestParam(name="rep_id", required=false) String rep_id, @RequestParam(name="ci_number", required=false) int ci_number, @RequestParam(name="m_number", required=false) String m_number) throws Exception{
		log.info("replyInsert 호출 성공!");
		ResponseEntity<String> entity = null;
		int result;
		CareReplyVO rvo = new CareReplyVO();
		rvo.setRep_content(rep_content);
		rvo.setRep_id(rep_id);
		rvo.setCi_number(ci_number);
		rvo.setM_number(Integer.parseInt(m_number));
			result = careReplyService.replyInsert(rvo);
			if(result==1) {
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
			}
		return entity;
	}
	
	// 댓글 수정
	@RequestMapping(value ="/{rep_number}.do", method = RequestMethod.POST)
	public ResponseEntity<String> replyUpdate(@RequestParam(name="rep_number", required=false) int rep_number, @RequestParam(name="rep_content", required=false) String rep_content) throws Exception {
		log.info("replyUpdate 호출 성공!");
		System.out.println(rep_number);
		ResponseEntity<String> entity = null;
		CareReplyVO rvo = new CareReplyVO();
			rvo.setRep_number(rep_number);
			rvo.setRep_content(rep_content);
			int result = careReplyService.replyUpdate(rvo);
			if (result == 1) {
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
			}
		return entity;
	}
	
	
	// 댓글 삭제
	@RequestMapping(value = "/{rep_number}.do", method = RequestMethod.DELETE)
	public ResponseEntity<String> replyDelete(@PathVariable("rep_number") Integer rep_number) {
		log.info("replyDelete 호출 성공!");
		ResponseEntity<String> entity = null;
		try {
			careReplyService.replyDelete(rep_number);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
}