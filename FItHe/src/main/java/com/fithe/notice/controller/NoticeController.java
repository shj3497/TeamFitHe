package com.fithe.notice.controller;

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
import com.fithe.notice.service.NoticeService;
import com.fithe.notice.vo.NoticeVO;

@Controller
public class NoticeController {
	
	Logger logger = Logger.getLogger(NoticeController.class);
	@Autowired(required = false)
	private ChaebunService chaebunService;
	@Autowired(required = false)
	private NoticeService noticeService;
	
	@RequestMapping(value="noticeList")
	public ModelAndView noticeList(@ModelAttribute BoardPagingVO pvo,
								   @RequestParam(value="nowPage", required=false)String nowPage,
								   @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		logger.info("NoticeController noticeList >>> ");
		
		// 페이징 설정
		int total = noticeService.countNotice(pvo);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
//		if (pvo.getOrder_by() == null) {pvo.setOrder_by("NHIT");}
//		if (pvo.getOrder_sc() == null) {pvo.setOrder_sc("DESC");}
		
		BoardPagingVO _pvo = new BoardPagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		_pvo.setKeyfilter(pvo.getKeyfilter());
		_pvo.setKeyword(pvo.getKeyword());
		_pvo.setOrder_by(pvo.getOrder_by());
		_pvo.setOrder_sc(pvo.getOrder_sc());
		
		// 페이징된 공지여부 비활성화 된 리스트
		List<NoticeVO> noticeList = noticeService.noticeList(_pvo); 
		// 공지여부 활성화 된 리스트
		List<NoticeVO> noticeExposureList = noticeService.noticeExposureList();
		ModelAndView mav = new ModelAndView();
		mav.addObject("noticeList", noticeList);
		mav.addObject("noticeExposureList", noticeExposureList);
		mav.addObject("paging", _pvo);
		mav.setViewName("notice/noticeList");
		
		return mav;
	}
	
	@RequestMapping(value="noticeForm")
	public ModelAndView noticeForm(@ModelAttribute NoticeVO nvo, HttpServletRequest req) {
		logger.info("NoticeController noticeForm >>> : ");
		
		// 관리자인지 확인
		HttpSession session = req.getSession();
		String mauth = String.valueOf(session.getAttribute("mauth")) ;
				
		ModelAndView mav = new ModelAndView();
		
		// 관리자가 아니면
		if (!mauth.equals("A")) {
			mav.addObject("unauthorized", "unauthorized");
			mav.setViewName("notice/noticeCheck");
			return mav;
		}
		mav.addObject("boardtype", nvo.getBoardtype());
		mav.setViewName("notice/noticeForm");
		
		return mav;
	}
	
	@RequestMapping(value="noticeInsert", method=RequestMethod.POST)
	public ModelAndView noticeInsert(@ModelAttribute NoticeVO nvo, HttpServletRequest req) {
		logger.info("NoticeController noticeInsert >>> ");
		
		// 공지사항 글 번호 채번 로직
		String nnum = ChaebunUtil.getNoticeChabun("Y", chaebunService.getNoticeChaebun().getNnum());
//		System.out.println("nnum >>> : " + nnum);
		
		// 파일 업로드 1
		FileUploadUtil fu = new FileUploadUtil();
		Boolean uploadChk = fu.imgfileUpload(req);
		System.out.println("파일 업로드 확인 >>> : " + uploadChk);
		String fileName = fu.getFileName("nfile");
		System.out.println("fileName >>> : "  + fileName);
		
//		System.out.println("fu.getParameter(\"nsubject\") >>> : " + fu.getParameter("nsubject"));
//		System.out.println("fu.getParameter(\"ncontent\") >>> : " + fu.getParameter("ncontent"));
//		System.out.println("fu.getParameter(\"nstatusyn\") >>> : " + fu.getParameter("nstatusyn"));
		
		HttpSession session = req.getSession();
		String mid = String.valueOf(session.getAttribute("mid"));
		
		nvo.setNnum(nnum); // 공지사항 글 번호 
		nvo.setMid(mid); 
		nvo.setNsubject(fu.getParameter("nsubject")); // 글 제목
		nvo.setNcontent(fu.getParameter("ncontent")); // 글 내용
		nvo.setNstatusyn(fu.getParameter("nstatusyn")); // 공지글 종류
		nvo.setNfile(fu.getFileName("nfile")); // 파일 이름
		nvo.setBoardtype(fu.getParameter("boardtype"));
		
		int result = noticeService.noticeInsert(nvo);
		
		ModelAndView mav = new ModelAndView();
		
		if (nvo.getBoardtype().equals("manage")) {
			System.out.println("옴?");
			mav.addObject("insertManageResult", result);
			mav.addObject("boardtype", nvo.getBoardtype());
			mav.setViewName("notice/noticeCheck");
		} else {
			mav.addObject("insertResult", result);
			mav.addObject("boardtype", nvo.getBoardtype());
			mav.setViewName("notice/noticeCheck");
		}
		
		return mav;
	}
	
	@RequestMapping(value="noticeDetail", method=RequestMethod.POST)
	public ModelAndView noticeDetail(@ModelAttribute NoticeVO nvo) {
		logger.info("NoticeController noticeDetail");
		
		noticeService.noticeHit(nvo); // 조회수  + 1
		NoticeVO noticeDetail = noticeService.noticeDetail(nvo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("noticeDetail", noticeDetail);
		mav.addObject("boardtype", nvo.getBoardtype());
		mav.setViewName("notice/noticeDetail");
		
		return mav;
	}
	
	// 수정을 위한 함수
	@RequestMapping(value="noticeCorrection", method=RequestMethod.POST) 
	public ModelAndView noticeCorrection(@ModelAttribute NoticeVO nvo) {
		logger.info("NoticeController noticeCorrection");
		
		NoticeVO noticeDetail = noticeService.noticeDetail(nvo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("boardtype", nvo.getBoardtype());
		mav.addObject("noticeDetail", noticeDetail);
		mav.setViewName("notice/noticeCorrection");
		
		return mav;
	}
	
	// 수정을 수행하는 함수
	@RequestMapping(value="noticeUpdate", method=RequestMethod.POST)
	public ModelAndView noticeUpdate(@ModelAttribute NoticeVO nvo, HttpServletRequest req) {
		logger.info("NoticeController noticeUpdate");
		
		HttpSession session = req.getSession();
		String mid = String.valueOf(session.getAttribute("mid"));
		nvo.setMid(mid);
		
		ModelAndView mav = new ModelAndView();
		// 관리자가 아닌 유저가 비정상적인 방법은 게시글을 수정하려고 하면
		// 세션을 종료시킨다.
		if(!userMauthCheck(session, nvo.getMid())) {
			mav.addObject("wrongAccess", "wrongAccess");
			mav.setViewName("notice/noticeCheck");
			return mav;
		}
		
		FileUploadUtil fu = new FileUploadUtil();
		fu.imgfileUpload(req);
		
		nvo.setNstatusyn(fu.getParameter("nstatusyn"));
		nvo.setNnum(fu.getParameter("nnum"));
		nvo.setNsubject(fu.getParameter("nsubject"));
		nvo.setNcontent(fu.getParameter("ncontent"));
		nvo.setBoardtype(fu.getParameter("boardtype"));
		
		// 파일이 변경되었으면 기존 파일 삭제
		String presentFileName = fu.getFileName("nfile");
		String previousFileName = noticeService.noticeFileCheck(nvo).getNfile();
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
		nvo.setNfile(fu.getFileName("nfile"));
		
		int result = noticeService.noticeUpdate(nvo); // 기존 파일 삭제 필요
		
		if (nvo.getBoardtype().equals("manage")) {
			mav.addObject("updateManageResult", result);
			mav.addObject("boardtype", nvo.getBoardtype());
			mav.setViewName("notice/noticeCheck");
		} else {
			mav.addObject("updateResult", result);
			mav.addObject("boardtype", nvo.getBoardtype());
			mav.setViewName("notice/noticeCheck");
		}
		return mav;
	}
	
	
	// 삭제 수행하는 함수
	@ResponseBody
	@RequestMapping(value="noticeDelete", method=RequestMethod.POST, produces="application/text; charset=utf8")
	public String noticeDelete(@ModelAttribute NoticeVO nvo, HttpServletRequest req, Model model) {
		logger.info("NoticeController noticeDelete");
		
		HttpSession session = req.getSession();
		
		System.out.println("nvo.getNnum() >>> : " + nvo.getNnum());
		
		// 관리자가 아닌 유저가 비정상적인 방법은 게시글을 수정하려고 하면
		// 세션을 종료시킨다.
		if(!userMauthCheck(session, nvo.getMid())) {
			model.addAttribute("wrongAccess", "wrongAccess");
			return "notice/noticeCheck";
		}
		
		String previousFileName = noticeService.noticeFileCheck(nvo).getNfile();
		// 게시글에 저장된 파일 있으면 삭제
		if (!previousFileName.equals("NA")) {
			FileUploadUtil fu = new FileUploadUtil();
			fu.imgfileDelete(req, previousFileName);
		}
		
		int result = noticeService.noticeDelete(nvo);
		
		return String.valueOf(result);
	}
	
	@ResponseBody 
	@RequestMapping(value="noticeFileDelete", method=RequestMethod.POST, produces="application/text; charset=utf8")
	public String noticeFileDelete(@ModelAttribute NoticeVO nvo, HttpServletRequest req) {
		logger.info("NoticeController noticeFileDelete");
		
		String fileName = noticeService.noticeFileCheck(nvo).getNfile();
		Boolean delete = false;
		String result = "파일을 삭제하지 못했습니다";
		
		if (fileName != null && fileName.length() > 0) {
			FileUploadUtil fu = new FileUploadUtil();
			delete = fu.imgfileDelete(req, fileName);
		}
		
		if (delete) {
			int deleteCheck = noticeService.noticeFileDelete(nvo);
				if (deleteCheck == 1) {
					result = "파일을 삭제했습니다";
				}
		}
		return result;
	}
	
	// 관리자만 들어올 수 있는 페이지
	@RequestMapping(value="noticeManagement", method=RequestMethod.GET)
	public ModelAndView noticeManagement(@ModelAttribute BoardPagingVO pvo, HttpServletRequest req,
			   @RequestParam(value="nowPage", required=false)String nowPage,
			   @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		
		ModelAndView mav = new ModelAndView();
		
		// 관리자인지 확인
		HttpSession session = req.getSession();
		String mauth = String.valueOf(session.getAttribute("mauth")) ;
		
		// 관리자가 아니면
		if (!mauth.equals("A")) {
			mav.addObject("unauthorized", "unauthorized");
			mav.setViewName("notice/noticeCheck");
			return mav;
		}
		
		// 페이징 설정
		int total = noticeService.countNotice(pvo);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
//		if (pvo.getOrder_by() == null) {pvo.setOrder_by("NHIT");}
//		if (pvo.getOrder_sc() == null) {pvo.setOrder_sc("DESC");}
		
		BoardPagingVO _pvo = new BoardPagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		_pvo.setKeyfilter(pvo.getKeyfilter());
		_pvo.setKeyword(pvo.getKeyword());
		_pvo.setOrder_by(pvo.getOrder_by());
		_pvo.setOrder_sc(pvo.getOrder_sc());
		
		// 페이징된 공지여부 비활성화 된 리스트
		List<NoticeVO> noticeList = noticeService.noticeList(_pvo); 
		// 공지여부 활성화 된 리스트
		List<NoticeVO> noticeExposureList = noticeService.noticeExposureList();
		mav.addObject("noticeList", noticeList);
		mav.addObject("noticeExposureList", noticeExposureList);
		mav.addObject("paging", _pvo);
		mav.setViewName("notice/noticeManagement");
		
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
