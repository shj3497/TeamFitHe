package com.fithe.member.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fithe.common.page.Paging;
import com.fithe.common.page.Util;
import com.fithe.member.service.MemberService;
import com.fithe.member.vo.MemberVO;

@Controller
public class AdminController {
	
	@Autowired(required=false)
	private MemberService memberService;
	
	private Logger logger = Logger.getLogger(AdminController.class);
	
	@Autowired(required=false)
	public AdminController(MemberService memberService) {
		this.memberService=memberService;
	}
	
	@RequestMapping(value="memberList", method=RequestMethod.GET)
	public String memberList(Model model, MemberVO mvo) {
		logger.info("(AdminController) memberList() 진입");

		if(mvo.getOrder_by() == null) {
			mvo.setOrder_by("mnum");
		}
		if(mvo.getOrder_sc()==null) {
			mvo.setOrder_sc("DESC");
		}
		
		// 정렬 데이터 세팅 확인
		logger.info("order_by >>> : " + mvo.getOrder_by());
		logger.info("order_sc >>> : " + mvo.getOrder_sc());

		// 검색 데이터 세팅 확인
		logger.info("search >>> : " + mvo.getSearch());
		logger.info("keyword >>> : " + mvo.getKeyword());
		
		// 페이징 세팅
		Paging.setPage(mvo);
		
		// 전체 레코드 수
		int total = memberService.memberCount();
		logger.info("total >>> : " + total);
		
		// 글 번호 재설정
		int count = total - (Util.nvl(mvo.getPage()) -1)*Util.nvl(mvo.getPageSize());
		logger.info("count >>> : " + count);
		
		List<MemberVO> list = memberService.memberList(mvo);
		
		model.addAttribute("memberList", list);
		model.addAttribute("count", count);
		model.addAttribute("total", total);
		model.addAttribute("data", mvo);
		
		return "admin/memberList";
	}
}
