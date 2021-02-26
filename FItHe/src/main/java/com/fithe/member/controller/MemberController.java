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
import com.fithe.social.controller.KakaoController;
import com.fithe.social.controller.NaverController;

@Controller
public class MemberController {

// #################### ctrl+f 로 키워드 검색후 해당 함수 확인하세요!! ####################
	// 회원관련함수 검색 >>> !회원!
	// 로그인 관련 함수 검색 >>> !로그인!
	// ID찾기 관련 함수 검색 >>> !ID찾기!
	// PW찾기 관련 함수 검색 >>> !PW찾기!
	// Mypage 관련 함수 검색 >>> !MYPAGE!
	
	
	
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
	
	// 임시로 만든 메인페이지
	@RequestMapping(value="tempmain", method=RequestMethod.GET)
	public String tempmain() {
		logger.info("tempmain() 진입");
		
		return "member/tempmain";
	}
	
//	#################### !회원! ####################	
	@RequestMapping(value="memberInsertForm", method=RequestMethod.GET)
	public String memberForm() {
		// 회원가입 폼으로 이동
		logger.info("memberForm() 진입");
		
		return "member/insertForm";
	}

	public String memberSelect() {
		// 회원 정보 조회(당사자)
		
		return "";
	}
	
	@RequestMapping(value="memberInsert", method=RequestMethod.POST)
	public String memberInsert(Model model, MemberVO mvo, HttpServletRequest request) {
		// 회원 가입 처리
		logger.info("memberInsert() 진입");
		
		String result = "";
		
		
		// 데이터 받아오기
		String memail_a = request.getParameter("memail_a");
		logger.info("memail_a >>> : " + memail_a);
		String memail_b = request.getParameter("memail_b");
		logger.info("memail_b >>> : " + memail_b);
		
		// 조합
		String memail = memail_a.concat(memail_b);
		logger.info("memail >>> : " + memail);
		
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
		logger.info("chaebun >>> : " + chaebun);
		mvo.setMnum(chaebun);
				
		int nCnt = memberService.memberInsert(mvo);
		
		if(nCnt == 1) {
			logger.info("입력 성공");
			return "member/loginForm";
		}else {
			logger.info("입력 실패");
			result = "관리자에게 문의하세요";
			model.addAttribute("result", result);
			return "error/error";
		}
	}
	
	
	@RequestMapping(value="memberIdCheck", method=RequestMethod.POST)
	@ResponseBody // ajax 통신할 때는 ResponseBody 어노테이션 사용
	public String memberIdCheck(MemberVO mvo) {
		// ID 중복 체크
		logger.info("(Controller) memberIdCheck() 진입");
		int nCnt = memberService.memberIdCheck(mvo);
		logger.info("nCnt >>> : " + nCnt);
		
		String result = "";
		
		if(nCnt == 1) {
			result = "1";
		}else {
			result = "0";
		}
		return result;
	}
	
	@RequestMapping(value="memberEmailCheck", method=RequestMethod.POST)
	@ResponseBody // ajax 통신할 때는 ResponseBody 어노테이션 사용
	public String memberEmailCheck(MemberVO mvo) {
		// ID 중복 체크
		logger.info("(Controller) memberEmailCheck() 진입");
		
		int nCnt = memberService.memberEmailCheck(mvo);
		
		logger.info("nCnt >>> : " + nCnt);
		
		String result = "";
		
		if(nCnt == 1) {
			result = "1";
		}else {
			result = "0";
		}
		
		return result;
	}
	
//	#################### !로그인! ####################	
	// 로그인 화면 이동
	@RequestMapping(value="memberLoginForm", method=RequestMethod.GET)
	public String memberLoginForm(Model model, HttpSession session) {
		
		String naverAuthUrl = NaverController.getAuthorizationUrl(session); 
		logger.info("naverAuthUrl >>> : " + naverAuthUrl);
		model.addAttribute("naver_url", naverAuthUrl);
		
		String kakaoUrl = KakaoController.getAuthorizationUrl(session);
		logger.info("kakaoUrl >>> : " + kakaoUrl);
		model.addAttribute("kakao_url", kakaoUrl);
		
		return "member/loginForm";
	}
	
	// 로그인 처리 함수
	@RequestMapping(value="memberLogin", method=RequestMethod.POST)
	public String memberLogin(Model model, MemberVO mvo, HttpServletRequest request) {
		logger.info("memberLogin() 진입");
		
		String result;
		
		// view 페이지에서 받아온 pw
		String pw = mvo.getMpw();
		String mid = mvo.getMid();
		logger.info("로그인을 시도하는 id >>> : " + mid);
		
			
		// memberLogin, memberSelect는 동일한 쿼리이지만 직관성을 위해 나눠놓았다.
		MemberVO _mvo = null;
		_mvo = memberService.memberLogin(mvo);
		// _mvo에는 쿼리문에 대한 결과들이 저장되어있다.
				
		if(_mvo==null) {
			result = "존재하지 않는 아이디 입니다.";
			model.addAttribute("result", result);
			return "error/error";
		}
		
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
			session.setAttribute("mauth", _mvo.getMauth()); // 회원 관리자 구분문자에도 세션값을 부여
			session.setMaxInactiveInterval(-1); // 세션 무한대
			
			// 로그인에 성공한 getMnum()이 관리자의 아이디이라면
			if(_mvo.getMid().equals("admin")) {
				// 관리자 페이지로 리턴
				return "admin/admin";
			}
			
			model.addAttribute("memberVO", _mvo);
			
			// 사용자가 로그인에 성공하면 이동하는 페이지
			// 메인페이지로 이동해야함
			return "member/loginsuccess";
		}else {
			// 로그인에 실패하면 보여지는 페이지
			result = "PW가 일치하지 않습니다.";
			model.addAttribute("result", result);
			return "error/error";
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
	
	
	
//  #################### !ID찾기! ####################
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
		
		// 에러페이지 이동시 담길 문자열
		String result = "";
		
		
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
			result = "존재하는 ID가 없습니다.";
			model.addAttribute("result", result);
			return "error/error";
		}
	}
	
//  #################### !PW찾기! ####################
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

		String result = "";
		// ID가 존재하지 않으면 DB에러가 난다.. 그래서 catch로 에러가 나면 이동할 페이지를 넣어줌
		try {
			// 아이디 잘 넘어왔는지 확인 > check
			logger.info("mid >>> : " + mvo.getMid());
			
			// 넘겨 받은 아이디로 FIT_MEMBER 테이블에 해당 id가 등록되어있는지 조회한다.
			MemberVO _mvo = null;
			_mvo = memberService.memberSelect(mvo);
			
			logger.info("_mvo.getMid() >>> : " + _mvo.getMid());
			// 객체로 넘겨서 pwFindForm_2에서 히든태그로 mid를 가지고 이동할 것 
			model.addAttribute("memberVO", _mvo);
				
			return "member/pwFindFormsecond";
		}catch(NullPointerException e) {
			// 넘겨받은 아이디가 FIT_MEMBER에 등록되어있지 않을때 에러페이지로 반환후 뒤로가기
			result = "등록되지 않은 사용자입니다.";
			model.addAttribute("result", result);
			return "error/error";
		}

		/*
		String result = "";
		
		// 아이디 잘 넘어왔는지 확인 > check
		logger.info("mid >>> : " + mvo.getMid());
		
		// 넘겨 받은 아이디로 FIT_MEMBER 테이블에 해당 id가 등록되어있는지 조회한다.
		MemberVO _mvo = null;
		_mvo = memberService.memberSelect(mvo);
		
		logger.info("_mvo.getMid() >>> : " + _mvo.getMid());
		
		if(_mvo.getMid() != null) {
			// 객체로 넘겨서 pwFindForm_2에서 히든태그로 mid를 가지고 이동할 것 
			model.addAttribute("memberVO", _mvo);
			
			return "member/pwFindFormsecond";
		}else {
			// 넘겨받은 아이디가 FIT_MEMBER에 등록되어있지 않을때 에러페이지로 반환후 뒤로가기
			result = "등록되지 않은 사용자입니다.";
			model.addAttribute("result", result);
			return "error/error";
		}
		*/
	}
	
	@RequestMapping(value="pwFindsecond", method=RequestMethod.POST)
	public String memberPwFindsecond(Model model, MemberVO mvo) {
		// 입력받은 인증번호를 확인하고 새로운 pw 설정하는 페이지로 이동
		logger.info("memberPwFindsecond() 진입");
		
		String result = "";
		
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
			result = "존재하는 ID가 없습니다.";
			model.addAttribute("result", result);
			return "error/error";
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
	
}