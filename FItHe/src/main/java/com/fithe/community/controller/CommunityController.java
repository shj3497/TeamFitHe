package com.fithe.community.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fithe.common.chaebun.ChaebunUtil;
import com.fithe.common.FileUploadUtil;
import com.fithe.common.BoardPagingVO;
import com.fithe.common.chaebun.service.ChaebunService;
import com.fithe.community.service.CommunityService;
import com.fithe.community.vo.CommunityVO;
import com.fithe.member.service.MemberService;
import com.fithe.member.vo.MemberVO;
import com.fithe.notice.service.NoticeService;
import com.fithe.notice.vo.NoticeVO;
	
@Controller
public class CommunityController {
	
	private Logger logger = Logger.getLogger(CommunityController.class);
	
	@Autowired(required = false)
	private CommunityService communityService;
	@Autowired(required = false)
	private ChaebunService chaebunSerivice;
	@Autowired(required = false)
	private NoticeService noticeService; 
	
	@RequestMapping(value="communityList")
	public ModelAndView communityList(@ModelAttribute BoardPagingVO pvo,
									  @RequestParam(value="nowPage", required=false)String nowPage,
									  @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		logger.info("CommunityController communityList");
		
		// 페이징 설정
		// 게시글 갯수 처리 함수
		int total = communityService.countCommunity(pvo);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1"; // 현재 페이지
			cntPerPage = "5"; // 5개씩 페이징
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
		System.out.println("keyfilter >>> : " + pvo.getKeyfilter());
		System.out.println("keyword >>> : " + pvo.getKeyword());
		System.out.println("pvo.getOrder_by() >>> : " + pvo.getOrder_by());
		
		BoardPagingVO _pvo = new BoardPagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		_pvo.setKeyfilter(pvo.getKeyfilter());
		_pvo.setKeyword(pvo.getKeyword());
		_pvo.setOrder_by(pvo.getOrder_by());
		_pvo.setOrder_sc(pvo.getOrder_sc());
		
		List<CommunityVO> communityList = communityService.communityList(_pvo);
		List<NoticeVO> noticeExposureList = noticeService.noticeExposureList(); // 공지사항 노출 활성화 한것만 표시
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("communityList", communityList);
		mav.addObject("noticeExposureList", noticeExposureList);
		mav.addObject("paging", _pvo);
		mav.setViewName("community/communityList");
		
		return mav;
	}
	
	@RequestMapping(value="communityForm")
	public ModelAndView communityForm(@ModelAttribute CommunityVO cvo, HttpServletRequest req) {
		logger.info("CommunityController communityForm >>> : ");
		
		HttpSession session = req.getSession();
		String mid = String.valueOf(session.getAttribute("mid"));
		
		ModelAndView mav = new ModelAndView();
		// 자유게시글을 눌렀는데 로그인이 되어있지 않으면 로그인 창으로
		if (mid == null || mid.length() <= 0 || mid.equals("null")) {
			System.out.println("mid >>> : " + mid);
			mav.addObject("notlogin", "notlogin");
			mav.setViewName("community/communityCheck");
			return mav;
		}
		
		mav.addObject("boardtype", cvo.getBoardtype());
		mav.setViewName("community/communityForm");
		
		return mav;
	}
	
	@RequestMapping(value="communityInsert")
	public ModelAndView communityInsert(@ModelAttribute CommunityVO cvo, HttpServletRequest req) {
		logger.info("CommunityController communityInsert");
		
		// 자유게시판 글 번호 채번 로직
		String cnum = ChaebunUtil.getCommunityChabun("Y", chaebunSerivice.getCommunityChaebun().getCnum());
		
		// 파일 업로드
		FileUploadUtil fu = new FileUploadUtil();
		Boolean uploadChk = fu.imgfileUpload(req);
		System.out.println("파일 업로드 확인 >>> : " + uploadChk);
		String fileName = fu.getFileName("cfile");
		System.out.println("fileName >>> : "  + fileName);
		
		HttpSession session = req.getSession();
		String mid = String.valueOf(session.getAttribute("mid"));
		
		cvo.setCnum(cnum); // 자유게시판 글 번호 
		cvo.setMid(mid); 
		cvo.setCsubject(fu.getParameter("csubject")); // 글 제목
		cvo.setCcontent(fu.getParameter("ccontent")); // 글 내용
		cvo.setCfile(fu.getFileName("cfile")); // 파일 이름
		cvo.setBoardtype(fu.getParameter("boardtype"));
		
		int result = communityService.communityInsert(cvo);
		
		ModelAndView mav = new ModelAndView();
		
		if (cvo.getBoardtype().equals("manage")) {
			System.out.println("옴?");
			mav.addObject("insertManageResult", result);
			mav.addObject("boardtype", cvo.getBoardtype());
			mav.setViewName("community/communityCheck");
		} else {
			mav.addObject("insertResult", result);
			mav.addObject("boardtype", cvo.getBoardtype());
			mav.setViewName("community/communityCheck");
		}
		
		return mav;
	}
	
	@RequestMapping(value="communityDetail", method=RequestMethod.POST)
	public ModelAndView communityDetail(@ModelAttribute CommunityVO cvo) {
		logger.info("CommunityController communityDetail");
		
		communityService.communityHit(cvo); // 조회수  + 1
		CommunityVO communityDetail = communityService.communityDetail(cvo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("communityDetail", communityDetail);
		mav.addObject("boardtype", cvo.getBoardtype());
		mav.setViewName("community/communityDetail");
		
		return mav;
	}
	
	// 수정을 위한 함수
	@RequestMapping(value="communityCorrection", method=RequestMethod.POST) 
	public ModelAndView communityBeforeUpdate(@ModelAttribute CommunityVO cvo) {
		logger.info("CommunityController communityCorrection");
		
		CommunityVO communityDetail = communityService.communityDetail(cvo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("boardtype", cvo.getBoardtype());
		mav.addObject("communityDetail", communityDetail);
		mav.setViewName("community/communityCorrection");
		
		return mav;
	}
	
	// 수정을 수행하는 함수
	@RequestMapping(value="communityUpdate", method=RequestMethod.POST)
	public ModelAndView communityUpdate(@ModelAttribute CommunityVO cvo, HttpServletRequest req) {
		logger.info("CommunityController communityUpdate");
		
		HttpSession session = req.getSession();
		String mid = String.valueOf(session.getAttribute("mid"));
		cvo.setMid(mid);
		
		ModelAndView mav = new ModelAndView();
		// 관리자가 아닌 유저가 비정상적인 방법은 게시글을 수정하려고 하면
		// 세션을 종료시킨다.
		if(!userMauthCheck(session, cvo.getMid())) {
			mav.addObject("wrongAccess", "wrongAccess");
			mav.setViewName("community/communityCheck");
			return mav;
		}
		
		FileUploadUtil fu = new FileUploadUtil();
		fu.imgfileUpload(req);
		
		cvo.setCnum(fu.getParameter("cnum"));
		cvo.setCsubject(fu.getParameter("csubject"));
		cvo.setCcontent(fu.getParameter("ccontent"));
		cvo.setBoardtype(fu.getParameter("boardtype"));
		
		// 파일이 변경되었으면 기존 파일 삭제
		String presentFileName = fu.getFileName("cfile");
		String previousFileName = communityService.communityFileCheck(cvo).getCfile();
//		System.out.println("현재 파일이름 >>> : " + presentFileName);
//		System.out.println("전 파일이름 >>> : " + previousFileName);
				
		// 다르면 예전 파일 지워주기
		if (presentFileName != null && presentFileName.length() > 0 &&
				previousFileName != null && previousFileName.length() > 0) {
			if (!presentFileName.equals(previousFileName)) {
				// NA는 파일이 없음, NA가 아니면 파일이 있음
				if (!previousFileName.equals("NA")) {
					fu.imgfileDelete(req, previousFileName);
				}
			}
		}
		cvo.setCfile(fu.getFileName("cfile"));
		
		int result = communityService.communityUpdate(cvo); // 기존 파일 삭제 필요
		
		if (cvo.getBoardtype().equals("manage")) {
			mav.addObject("updateManageResult", result);
			mav.addObject("boardtype", cvo.getBoardtype());
			mav.setViewName("community/communityCheck");
		} else {
			mav.addObject("updateResult", result);
			mav.addObject("boardtype", cvo.getBoardtype());
			mav.setViewName("community/communityCheck");
		}
		return mav;
	}
	
	// 삭제 수행하는 함수
	@ResponseBody
	@RequestMapping(value="communityDelete", method=RequestMethod.POST, produces="application/text; charset=utf8")
	public String communityDelete(@ModelAttribute CommunityVO cvo, HttpServletRequest req, Model model) {
		logger.info("CommunityController communityDelete");
		
		HttpSession session = req.getSession();
		
		// 관리자가 아닌 유저가 비정상적인 방법은 게시글을 수정하려고 하면
		// 세션을 종료시킨다.
		if(!userMauthCheck(session, cvo.getMid())) {
			model.addAttribute("wrongAccess", "wrongAccess");
			return "community/communityCheck";
		}
		
		String previousFileName = communityService.communityFileCheck(cvo).getCfile();
		// 게시글에 저장된 파일 있으면 삭제
		if (!previousFileName.equals("NA")) {
			FileUploadUtil fu = new FileUploadUtil();
			fu.imgfileDelete(req, previousFileName);
		}
		
		int result = communityService.communityDelete(cvo);
		
		return String.valueOf(result);
	}
	
	@ResponseBody 
	@RequestMapping(value="communityFileDelete", method=RequestMethod.POST, produces="application/text; charset=utf8" )
	public String communityFileDelete(@ModelAttribute CommunityVO cvo, HttpServletRequest req) {
		logger.info("CommunityController communityFileDelete");
		
		String fileName = communityService.communityFileCheck(cvo).getCfile();
		Boolean delete = false;
		String result = "파일을 삭제하지 못했습니다";
		
		if (fileName != null && fileName.length() > 0) {
			FileUploadUtil fu = new FileUploadUtil();
			delete = fu.imgfileDelete(req, fileName);
		}
		
		if (delete) {
			int deleteCheck = communityService.communityFileDelete(cvo);
				if (deleteCheck == 1) {
					result = "파일을 삭제했습니다";
				}
		}
		return result;
	}
	
	// 관리자만 들어올 수 있는 페이지
	@RequestMapping(value="communityManagement", method=RequestMethod.GET)
	public ModelAndView communityManagement(@ModelAttribute BoardPagingVO pvo, HttpServletRequest req,
			   @RequestParam(value="nowPage", required=false)String nowPage,
			   @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		
		ModelAndView mav = new ModelAndView();
		
		// 관리자인지 확인
		HttpSession session = req.getSession();
		String mauth = String.valueOf(session.getAttribute("mauth")) ;
		
		// 관리자가 아니면
		if (!mauth.equals("A")) {
			mav.addObject("unauthorized", "unauthorized");
			mav.setViewName("community/communityCheck");
			return mav;
		}
		
		// 페이징 설정
		int total = communityService.countCommunity(pvo);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
//		if (pvo.getOrder_by() == null) {pvo.setOrder_by("CHIT");}
//		if (pvo.getOrder_sc() == null) {pvo.setOrder_sc("DESC");}
		
		BoardPagingVO _pvo = new BoardPagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		_pvo.setKeyfilter(pvo.getKeyfilter());
		_pvo.setKeyword(pvo.getKeyword());
		_pvo.setOrder_by(pvo.getOrder_by());
		_pvo.setOrder_sc(pvo.getOrder_sc());
		
		// 페이징된 공지여부 비활성화 된 리스트
		List<CommunityVO> communityList = communityService.communityList(_pvo);
		
		mav.addObject("communityList", communityList);
		mav.addObject("paging", _pvo);
		mav.setViewName("community/communityManagement");
		
		return mav;
	}
	
	private boolean userMauthCheck(HttpSession session, String mid) {
		
		if("A".equals(session.getAttribute("mauth")) || 
				mid.equals(session.getAttribute("mid")) ) {
			return true;
		}
		return false;
	}

}
