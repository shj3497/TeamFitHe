package com.fithe.member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	// 관리자 페이지에서 회원 전체 조회
	@RequestMapping(value="memberList", method=RequestMethod.GET)
	public String memberList(Model model, MemberVO mvo, HttpServletRequest request) {
		logger.info("(AdminController) memberList() 진입");

		// 세션 번호로 정보 가져오기
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("mid");
		
		// 관리자 계정의 세션일 때만 페이지 이동이 가능하다
		if(mid.equals("admin")) {
		
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
		}else {
			// 관리자 계정이 아니면 에러페이지로 이동
			return "member/error";
		}
		
	}
	
	// 관리자페이지에서 삭제버튼 클릭시 회원을 탈퇴시킨다.
	@RequestMapping(value="adminDelete", method=RequestMethod.POST)
	@ResponseBody
	public String adminDelete(Model model, MemberVO mvo) {
		// 회원 탈퇴
		logger.info("(AdminController) adminDelete() 진입");
		
		// 데이터 잘 넘어오나 확인
		logger.info("삭제버튼을 선택한 해당 아이디 >>> : " + mvo.getMid());
		
		// 관리자가 사용하는 회원 삭제 메소드 실행
		// 관리자가 탈퇴시키는 경우 회원의 pw필요 x
		int nCnt = memberService.memberDelete(mvo);
		// 회원이 삭제하는 경우에는 pw 체크를 한다
		
		logger.info("성공여부 성공1, 실패0 nCnt >>> : " + nCnt);
		
		String result = "";
		
		if(nCnt == 1) {
			result = "1";
		}else {
			result = "0";
		}
		
		return result;
	}
}
