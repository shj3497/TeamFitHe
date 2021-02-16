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

import com.fithe.common.chaebun.ChaebunUtil;
import com.fithe.common.chaebun.service.ChaebunService;
import com.fithe.common.commons.AuthcodeUtil;
import com.fithe.common.commons.encryption.PasswordEncoding;
import com.fithe.common.commons.mail.MailSend;
import com.fithe.member.service.MemberService;
import com.fithe.member.vo.MemberVO;

@Controller
public class MemberController {

	@Autowired(required=false)
	private MemberService memberService;
	@Autowired(required=false)
	private ChaebunService chaebunService;
	
	private Logger logger = Logger.getLogger(MemberController.class);
	// 의존성 주입
	@Autowired(required=false)
	public MemberController(MemberService memberService,
							ChaebunService chaebunService) {
		this.memberService=memberService;
		this.chaebunService=chaebunService;
	}
	
	@RequestMapping(value="tempmain", method=RequestMethod.GET)
	public String tempmain() {
		logger.info("tempmain() 진입");
		
		return "member/tempmain";
	}
	
	@RequestMapping(value="memberInsertForm", method=RequestMethod.GET)
	public String memberForm() {
		// 회원가입 폼으로 이동
		logger.info("memberForm() 진입");
		
		return "member/insertForm";
	}
	
	public String memberSelectAll() {
		// 회원 전체 조회(관리자)
		
		return "";
	}
	
	public String memberSelect() {
		// 회원 정보 조회(당사자)
		
		return "";
	}
	
	@RequestMapping(value="memberInsert", method=RequestMethod.POST)
	public String memberInsert(Model model, MemberVO mvo, HttpServletRequest request) {
		// 회원 가입 처리
		logger.info("memberInsert() 진입");
		
		// 데이터 받아오기
		String memail_a = request.getParameter("memail_a");
		System.out.println("memail_a >>> : " + memail_a);
		String memail_b = request.getParameter("memail_b");
		System.out.println("memail_b >>> : " + memail_b);
		
		// 조합
		String memail = memail_a.concat(memail_b);
		System.out.println("memail >>> : " + memail);
		
		// vo에 세팅
		mvo.setMemail(memail);

		// 데이터 잘넘어오나 확인
		//System.out.println("mzonecode >>> : " + mvo.getMzonecode());
		//System.out.println("maddress >>> : " + mvo.getMaddress());
		//System.out.println("maddress_detail >>> : " + mvo.getMaddress_detail());
		
		// 비밀번호 암호화
		String pw = mvo.getMpw();
		// System.out.println("pw >>> : " + pw); // vo에 저장된 mpw가져옴
		String encrypt_pw = PasswordEncoding.encode(pw); // pw암호화
		// System.out.println("encrypt_pw >>> : " + encrypt_pw);
		mvo.setMpw(encrypt_pw);	// 암호화된 pw vo에 세팅
		
		// 채번 번호를 얻어온다.
		String chaebun = ChaebunUtil.getMemberChaebun("Y", chaebunService.getChaebun_m().getMnum());
		System.out.println("chaebun >>> : " + chaebun);
		mvo.setMnum(chaebun);
				
		int nCnt = memberService.memberInsert(mvo);
		
		if(nCnt == 1) {
			System.out.println("입력 성공");
			return "member/loginForm";
		}else {
			System.out.println("입력 실패");
			return "member/error";
		}
	}
	
	public String memberDelete() {
		// 회원 탈퇴
		
		return "";
	}
	
	@RequestMapping(value="memberIdCheck", method=RequestMethod.POST)
	@ResponseBody // ajax 통신할 때는 ResponseBody 어노테이션 사용
	public String memberIdCheck(MemberVO mvo) {
		// ID 중복 체크
		
		int nCnt = memberService.memberIdCheck(mvo);
		System.out.print("nCnt >>> : " + nCnt);
		
		String result = "";
		
		if(nCnt == 1) {
			result = "1";
		}else {
			result = "0";
		}
		return result;
	}
	
//	#################### 로그인 ####################	
	// 로그인 화면 이동
	@RequestMapping(value="memberLoginForm", method=RequestMethod.GET)
	public String memberLoginForm() {
		
		return "member/loginForm";
	}
	
	// 로그인 처리 함수
	@RequestMapping(value="memberLogin", method=RequestMethod.POST)
	public String memberLogin(Model model, MemberVO mvo, HttpServletRequest request) {
		logger.info("memberLogin() 진입");
		
		// view 페이지에서 받아온 pw
		String pw = mvo.getMpw();
		
		MemberVO _mvo = null;
		_mvo = memberService.memberLogin(mvo);
		// _mvo에는 쿼리문에 대한 결과들이 저장되어있다.
		
		// 패스워드 비교
		boolean bool = PasswordEncoding.matches(pw, _mvo.getMpw());
		System.out.println("bool >>> : " + bool);
		
		// 패스워드 비교 값이 true 라면 세션을 부여해주겠다.
		if(bool) {
			
			/*
			 * 세션을 생성하고 세션에 값을 부여한다.
			 * 세션 설정을 톰캣 server에 web.xml에 <session_config> 에서 한다...?
			 * 기본 설정값은 30분으로 되어있다.
			 * session.setAttribute 로 값을 세팅하고
			 * session.getAttribute 로 값을 빼서 사용한다.
			 * 
			 * */
			HttpSession session = request.getSession();
			session.setAttribute("mid", _mvo.getMid()); // id에 세션값을 부여
			session.setMaxInactiveInterval(-1); // 세션 무한대
			
			// 로그인에 성공한 getMnum()이 관리자의 아이디이라면
			if(_mvo.getMid().equals("admin")) {
				// 관리자 페이지로 리턴
				return "member/admin";
			}
			
			model.addAttribute("memberVO", _mvo);
			
			// 사용자가 로그인에 성공하면 이동하는 페이지
			// 메인페이지로 이동해야함
			return "member/loginsuccess";
		}else {
			// 로그인에 실패하면 보여지는 페이지
			return "member/error";
		}
	}// end of memberLogin()
	
	@RequestMapping(value="memberLogout", method=RequestMethod.GET)
	public String memberLogout(HttpServletRequest request) {
		// 로그아웃 버튼 선택시 처리하는 메소드
		logger.info("memberLogout() 진입");
		HttpSession session = request.getSession();
		
		// session.invalidate()는 세션을 모두 삭제한다.
		session.invalidate();
		
		return "member/loginForm";
	}
	
	
	
//  #################### ID찾기 ####################
	@RequestMapping(value="memberIdFindForm", method=RequestMethod.GET)
	public String memberIdFindForm() {
		// id찾기 폼으로 이동
		logger.info("memberIdFindForm() 진입");
		
		return "member/idFindForm";
	}
	
	@RequestMapping(value="sendAuthnum", method=RequestMethod.POST)
	@ResponseBody
	public String sendAuthnum(MemberVO mvo) {
		// 인증번호를 전송하는 것을 처리하는 메소드
		logger.info("sendAuthnum() 진입");
		
		String authnum = AuthcodeUtil.authcode(6);
		logger.info("mauthnum >>> : " + authnum);
		
		// 인증번호 VO에 세팅
		mvo.setAuthnum(authnum);
		logger.info("인증번호 찍어보기 >>> : " + mvo.getAuthnum());
		
		// AUTH 테이블의 채번 VO에 세팅
		String chaebun = ChaebunUtil.getMemberChaebun("Y", chaebunService.getChaebun_a().getAnum());
		mvo.setAnum(chaebun);
		logger.info("AUTH 테이블 채번 찍어보기 >>> : " + mvo.getAnum());
		
		logger.info("이름 >>> : " + mvo.getAname());
		logger.info("이메일 >>> : " + mvo.getAemail());
		
		
		// insert 결과물
		int nCnt = memberService.authInsert(mvo);
		
		String result = "";
		
		if(nCnt == 1) {
			result = "1";
			MailSend ms = new MailSend();
			ms.mailSend(mvo);
			
		}else {
			result = "0";
		}
		
		return result;
	}
	
	@RequestMapping(value="memberIdFind", method=RequestMethod.POST)
	public String memberIdFind(Model model, MemberVO mvo) {
		// id찾기
		logger.info("memberIdFind() 진입");
		
		// 데이터가 잘 넘어오나 확인
		//logger.info("aname >>> : " + mvo.getAname());
		//logger.info("aemail >>> : " + mvo.getAemail());
		//logger.info("authnum >>> : " + mvo.getAuthnum());
		
		MemberVO _mvo = null;
		_mvo = memberService.authCheck(mvo);
		
		
		if(_mvo!=null) {
			
			model.addAttribute("memberVO", _mvo);
			
			return "member/idFind";
		}else {
			
			return "member/error";
		}
	}
	
//  #################### PW찾기 ####################
	@RequestMapping(value="memberPwFindForm", method=RequestMethod.GET)
	public String memberPwFindForm() {
		// pw찾기 form으로 이동
		logger.info("memberPwFindForm() 진입");
		
		
		return "member/pwFindFormfirst";
	}
	
	@RequestMapping(value="pwFindfirst", method=RequestMethod.POST)
	public String memberPwFindfirst(Model model, MemberVO mvo) {
		// 입력받은 아이디에 해당하는 정보가 있는지 DB 검색
		logger.info("memberPwFindFormfirst() 진입");
		
		// 아이디 잘 넘어왔는지 확인 > check
		logger.info("mid >>> : " + mvo.getMid());
		
		// 넘겨 받은 아이디로 FIT_MEMBER 테이블에 해당 id가 등록되어있는지 조회한다.
		MemberVO _mvo = null;
		_mvo = memberService.memberSelect(mvo);
		
		// 객체로 넘겨서 pwFindForm_2에서 히든태그로 mid를 가지고 이동할 것 
		model.addAttribute("memberVO", _mvo);
		
		return "member/pwFindFormsecond";
	}
	
	@RequestMapping(value="pwFindsecond", method=RequestMethod.POST)
	public String memberPwFindsecond(Model model, MemberVO mvo) {
		// 입력받은 인증번호를 확인하고 새로운 pw 설정하는 페이지로 이동
		logger.info("memberPwFindsecond() 진입");
		
		// 데이터가 잘 넘어오나 확인
		logger.info("mid >>> : " + mvo.getMid());
		logger.info("aname >>> : " + mvo.getAname());
		logger.info("aemail >>> : " + mvo.getAemail());
		logger.info("authnum >>> : " + mvo.getAuthnum());
		
		// 인증번호를  부여받기 위해 입력한 name, email을 가지고 회원 DB에 있는 정보 조회에 성공한다면
		MemberVO _mvo = null;
		_mvo = memberService.authCheck(mvo);
		
		if(_mvo!=null) {
			// mid를 가지고 패스워드 변경 페이지로 이동
			model.addAttribute("memberVO", _mvo);
			
			return "member/pwUpdateForm";
		}else {
			
			// 실패하면 에러페이지로 이동
			return "member/error";
		}
	}
	
	@RequestMapping(value="pwUpdate", method=RequestMethod.POST)
	@ResponseBody
	public String pwUpdate(MemberVO mvo) {
		// 새로운 패스워드로 DB 업데이트
		logger.info("pwUdpate() 진입");
		
		// 데이터 잘 넘어오나 확인
		logger.info("mid >>> : " + mvo.getMid());
		String pw = mvo.getMpw();
		logger.info("pw >>> : " + pw); // vo에 저장된 mpw가져옴

		// 비밀번호 암호화
		String encrypt_pw = PasswordEncoding.encode(pw); // pw암호화
		// System.out.println("encrypt_pw >>> : " + encrypt_pw);
		mvo.setMpw(encrypt_pw);	// 암호화된 pw vo에 세팅
		
		// 암호화된 pw 업데이트
		int nCnt = memberService.pwUpdate(mvo);
		
		String result = "";
		// 업데이트에 성공했다면
		if(nCnt == 1) {
			// 로그인 페이지로 이동
			result = "1";
		}else {
			result = "0";
		}
		return result;
	}
	
	
	
//	#################### MyPage ####################
	
	@RequestMapping(value="mypage", method=RequestMethod.GET)
	public String mypage(Model model, MemberVO mvo, HttpServletRequest request) {
		// 로그인 후 마이페이지 이동 버튼 클릭시 동작
		logger.info("mypage() 진입");
		
		// 로그인 이후에 클릭할 페이지 이므로 세션으로 정보를 가져온다.
		HttpSession session = request.getSession();
		// 세션을 아이디로 설정했으니까 getAttribute("mid")이다.
		String mid = (String)session.getAttribute("mid");
		logger.info("현재 로그인되어있는 id >>> : " + mid);
		
		// 로그인 되어있는 id를 vo에 세팅
		mvo.setMid(mid);
		
		// 로그인 되어있는 id를 VO에 세팅해줬으므로 select문으로 회원 정보를 조회한다.
		MemberVO _mvo = memberService.memberSelect(mvo);
		
		// 모델객체로 view에 조회한 회원 정보를 전달한다.
		model.addAttribute("memberVO", _mvo);
		
		return "mypage/mypage";
	}
	
	
	@RequestMapping(value="memberupdateForm", method=RequestMethod.GET)
	public String memberUpdateForm(Model model, HttpServletRequest request, MemberVO mvo) {
		// 회원 정보 수정 페이지로 이동
		
		logger.info("memberUpdateForm() 진입");
		
		// 세션 번호로 정보 가져오기
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("mid");
		logger.info("세션 mid >>> : " + mid);

		// 세션으로 정보 가져오기
		mvo.setMid(mid);
		
		// 세션으로 불러온 mid에 따른 멤버 정보조회
		MemberVO _mvo = memberService.memberSelect(mvo); // >>?? 이거만 해줘도 자동으로 세션이 불러오는데?
		// 잘 불러오나 확인
		// logger.info("_mvo.mname >>> : " + _mvo.getMname());
		
		model.addAttribute("memberVO", _mvo);
		
		return "mypage/changeinfo";
	}
	
	@RequestMapping(value="memberUpdate", method=RequestMethod.POST)
	public String memberUpdate(Model model, MemberVO mvo) {
		// 회원 정보 수정
		
		return "";
	}
	
	
}
